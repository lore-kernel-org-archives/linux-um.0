Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1fOS4D-0005qf-08
 for linux-um@lists.infradead.org; Thu, 31 May 2018 18:12:54 +0000
Subject: Re: fix create_queue() error handling
References: <20180531141804.ikypyiich2wzvxwd@kili.mountain>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f0f4d9fe-3c3b-7c21-eee6-fac662af6a2c@cambridgegreys.com>
Date: Thu, 31 May 2018 18:36:42 +0100
MIME-Version: 1.0
In-Reply-To: <20180531141804.ikypyiich2wzvxwd@kili.mountain>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Dan Carpenter <dan.carpenter@oracle.com>
Cc: linux-um@lists.infradead.org, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

Thanks, I will look at it ASAP.

I have cc-ed the new uml development list (we have moved to infradead).

A.


On 05/31/18 15:18, Dan Carpenter wrote:
> create_queue() error handling has serveral issues that are caused
> because we try to use it on partially initialized queues.  We
> dereference "qi" when it's NULL.  We free uninitialized pointers
> when we free the iovs.
>
> Those problems can be solved by only releasing memory which has been
> allocated using a series of labels which say what they are freeing.
> For example, we use "goto err_free_result;" to kfree(result).  We never
> free things which aren't allocated.  We just have to track the most
> recently allocated resource and verify that the goto is what we expect.
> Writing code which can be checked like this prevents leaks.
>
> It's a bit complicate to unwind the iov loop.  But the original code was
> *more* complicated and had bugs so this is not worse than before.
>
> Then after writing the error handling code, you can copy and paste it
> to destroy_queue() and that function is written for you automatically.
> The NULL checks are no longer needed so the code is simplified.
>
> Anyway, I can't compile this code.  I just wanted to show how easy it
> is to write error handling this way.
>
> regards,
> dan carpenter
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 02168fe25105..3c9909121c1a 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -458,33 +458,22 @@ static void destroy_queue(struct vector_queue *qi)
>   	struct vector_private *vp = netdev_priv(qi->dev);
>   	struct mmsghdr *mmsg_vector;
>   
> -	if (qi == NULL)
> -		return;
> -	/* deallocate any skbuffs - we rely on any unused to be
> -	 * set to NULL.
> -	 */
> -	if (qi->skbuff_vector != NULL) {
> -		for (i = 0; i < qi->max_depth; i++) {
> -			if (*(qi->skbuff_vector + i) != NULL)
> -				dev_kfree_skb_any(*(qi->skbuff_vector + i));
> -		}
> -		kfree(qi->skbuff_vector);
> +	mmsg_vector = qi->mmsg_vector;
> +	for (i = 0; i < qi->max_depth; i++) {
> +		iov = mmsg_vector->msg_hdr.msg_iov;
> +		if (vp->header_size > 0)
> +			kfree(iov->iov_base);
> +		kfree(iov);
> +		mmsg_vector++;
>   	}
> -	/* deallocate matching IOV structures including header buffs */
> -	if (qi->mmsg_vector != NULL) {
> -		mmsg_vector = qi->mmsg_vector;
> -		for (i = 0; i < qi->max_depth; i++) {
> -			iov = mmsg_vector->msg_hdr.msg_iov;
> -			if (iov != NULL) {
> -				if ((vp->header_size > 0) &&
> -					(iov->iov_base != NULL))
> -					kfree(iov->iov_base);
> -				kfree(iov);
> -			}
> -			mmsg_vector++;
> -		}
> -		kfree(qi->mmsg_vector);
> +
> +	for (i = 0; i < qi->max_depth; i++) {
> +		if (qi->skbuff_vector[i])
> +			dev_kfree_skb_any(qi->skbuff_vector[i]);
>   	}
> +
> +	kfree(qi->skbuff_vector);
> +	kfree(qi->mmsg_vector);
>   	kfree(qi);
>   }
>   
> @@ -498,21 +487,24 @@ static struct vector_queue *create_queue(
>   	int num_extra_frags)
>   {
>   	struct vector_queue *result;
> -	int i;
> +	int i, j;
>   	struct iovec *iov;
>   	struct mmsghdr *mmsg_vector;
>   
>   	result = kmalloc(sizeof(struct vector_queue), GFP_KERNEL);
> -	if (result == NULL)
> -		goto out_fail;
> +	if (!result)
> +		return NULL;
> +
>   	result->max_depth = max_size;
>   	result->dev = vp->dev;
> -	result->mmsg_vector = kmalloc(
> -		(sizeof(struct mmsghdr) * max_size), GFP_KERNEL);
> -	result->skbuff_vector = kmalloc(
> -		(sizeof(void *) * max_size), GFP_KERNEL);
> -	if (result->mmsg_vector == NULL || result->skbuff_vector == NULL)
> -		goto out_fail;
> +	result->mmsg_vector = kmalloc(sizeof(struct mmsghdr) * max_size,
> +				      GFP_KERNEL);
> +	if (!result->mmsg_vector)
> +		goto err_free_result;
> +
> +	result->skbuff_vector = kmalloc(sizeof(void *) * max_size, GFP_KERNEL);
> +	if (!result->skbuff_vector)
> +		goto err_free_mmsg;
>   
>   	mmsg_vector = result->mmsg_vector;
>   	for (i = 0; i < max_size; i++) {
> @@ -527,17 +519,16 @@ static struct vector_queue *create_queue(
>   	result->max_iov_frags = num_extra_frags;
>   	for (i = 0; i < max_size; i++) {
>   		if (vp->header_size > 0)
> -			iov = kmalloc(
> -				sizeof(struct iovec) * (3 + num_extra_frags),
> -				GFP_KERNEL
> -			);
> +			iov = kmalloc(sizeof(struct iovec) *
> +					(3 + num_extra_frags),
> +				      GFP_KERNEL);
>   		else
> -			iov = kmalloc(
> -				sizeof(struct iovec) * (2 + num_extra_frags),
> -				GFP_KERNEL
> -			);
> -		if (iov == NULL)
> -			goto out_fail;
> +			iov = kmalloc(sizeof(struct iovec) *
> +					(2 + num_extra_frags),
> +				GFP_KERNEL);
> +		if (!iov)
> +			goto err_unloop;
> +
>   		mmsg_vector->msg_hdr.msg_iov = iov;
>   		mmsg_vector->msg_hdr.msg_iovlen = 1;
>   		mmsg_vector->msg_hdr.msg_control = NULL;
> @@ -547,8 +538,10 @@ static struct vector_queue *create_queue(
>   		mmsg_vector->msg_hdr.msg_namelen = 0;
>   		if (vp->header_size > 0) {
>   			iov->iov_base = kmalloc(header_size, GFP_KERNEL);
> -			if (iov->iov_base == NULL)
> -				goto out_fail;
> +			if (!iov->iov_base) {
> +				kfree(iov);
> +				goto err_unloop;
> +			}
>   			iov->iov_len = header_size;
>   			mmsg_vector->msg_hdr.msg_iovlen = 2;
>   			iov++;
> @@ -563,8 +556,22 @@ static struct vector_queue *create_queue(
>   	result->head = 0;
>   	result->tail = 0;
>   	return result;
> -out_fail:
> -	destroy_queue(result);
> +
> +err_unloop:
> +	mmsg_vector = qi->mmsg_vector;
> +	for (j = 0; j < i; j++) {
> +		iov = mmsg_vector->msg_hdr.msg_iov;
> +		if (vp->header_size > 0)
> +			kfree(iov->iov_base);
> +		kfree(iov);
> +		mmsg_vector++;
> +	}
> +
> +	kfree(result->skbuff_vector);
> +err_free_mmsg:
> +	kfree(result->mmsg_vector);
> +err_free_result:
> +	kfree(result);
>   	return NULL;
>   }
>   
>

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

