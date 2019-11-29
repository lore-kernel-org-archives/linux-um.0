Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from www62.your-server.de ([213.133.104.62])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iacNH-0007P6-9h
 for linux-um@lists.infradead.org; Fri, 29 Nov 2019 09:15:41 +0000
Subject: Re: [PATCH] um: vector: fix BPF loading in vector drivers
References: <20191128174405.4244-1-anton.ivanov@cambridgegreys.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <1416753c-e966-e259-a84d-2a5f0a166660@iogearbox.net>
Date: Fri, 29 Nov 2019 10:15:29 +0100
MIME-Version: 1.0
In-Reply-To: <20191128174405.4244-1-anton.ivanov@cambridgegreys.com>
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
To: anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: songliubraving@fb.com, richard@nod.at, kernel-janitors@vger.kernel.org, ast@kernel.org, weiyongjun1@huawei.com, netdev@vger.kernel.org, bpf@vger.kernel.org, kafai@fb.com, dan.carpenter@oracle.com

On 11/28/19 6:44 PM, anton.ivanov@cambridgegreys.com wrote:
> From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> 
> This fixes a possible hang in bpf firmware loading in the
> UML vector io drivers due to use of GFP_KERNEL while holding
> a spinlock.
> 
> Based on a prposed fix by weiyongjun1@huawei.com and suggestions for
> improving it by dan.carpenter@oracle.com
> 
> Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Any reason why this BPF firmware loading mechanism in UML vector driver that was
recently added [0] is plain old classic BPF? Quoting your commit log [0]:

   All vector drivers now allow a BPF program to be loaded and
   associated with the RX socket in the host kernel.

   1. The program can be loaded as an extra kernel command line
   option to any of the vector drivers.

   2. The program can also be loaded as "firmware", using the
   ethtool flash option. It is possible to turn this facility
   on or off using a command line option.

   A simplistic wrapper for generating the BPF firmware for the raw
   socket driver out of a tcpdump/libpcap filter expression can be
   found at: https://github.com/kot-begemot-uk/uml_vector_utilities/

... it tells what it does but /nothing/ about the original rationale / use case
why it is needed. So what is the use case? And why is this only classic BPF? Is
there any discussion to read up that lead you to this decision of only implementing
handling for classic BPF?

I'm asking because classic BPF is /legacy/ stuff that is on feature freeze and
only very limited in terms of functionality compared to native (e)BPF which is
why you need this weird 'firmware' loader [1] which wraps around tcpdump to
parse the -ddd output into BPF insns ...

Thanks,
Daniel

   [0] https://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git/commit/?h=linux-next&id=9807019a62dc670c73ce8e59e09b41ae458c34b3
   [1] https://github.com/kot-begemot-uk/uml_vector_utilities/blob/master/build_bpf_firmware.py

>   arch/um/drivers/vector_kern.c | 38 ++++++++++++++++++-----------------
>   1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 92617e16829e..dbbc6e850fdd 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -1387,6 +1387,7 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   	struct vector_private *vp = netdev_priv(dev);
>   	struct vector_device *vdevice;
>   	const struct firmware *fw;
> +	void *new_filter;
>   	int result = 0;
>   
>   	if (!(vp->options & VECTOR_BPF_FLASH)) {
> @@ -1394,6 +1395,15 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   		return -1;
>   	}
>   
> +	vdevice = find_device(vp->unit);
> +
> +	if (request_firmware(&fw, efl->data, &vdevice->pdev.dev))
> +		return -1;
> +
> +	new_filter = kmemdup(fw->data, fw->size, GFP_KERNEL);
> +	if (!new_filter)
> +		goto free_buffer;
> +
>   	spin_lock(&vp->lock);
>   
>   	if (vp->bpf != NULL) {
> @@ -1402,41 +1412,33 @@ static int vector_net_load_bpf_flash(struct net_device *dev,
>   		kfree(vp->bpf->filter);
>   		vp->bpf->filter = NULL;
>   	} else {
> -		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_KERNEL);
> +		vp->bpf = kmalloc(sizeof(struct sock_fprog), GFP_ATOMIC);
>   		if (vp->bpf == NULL) {
>   			netdev_err(dev, "failed to allocate memory for firmware\n");
> -			goto flash_fail;
> +			goto apply_flash_fail;
>   		}
>   	}
>   
> -	vdevice = find_device(vp->unit);
> -
> -	if (request_firmware(&fw, efl->data, &vdevice->pdev.dev))
> -		goto flash_fail;
> -
> -	vp->bpf->filter = kmemdup(fw->data, fw->size, GFP_KERNEL);
> -	if (!vp->bpf->filter)
> -		goto free_buffer;
> -
> +	vp->bpf->filter = new_filter;
>   	vp->bpf->len = fw->size / sizeof(struct sock_filter);
> -	release_firmware(fw);
>   
>   	if (vp->opened)
>   		result = uml_vector_attach_bpf(vp->fds->rx_fd, vp->bpf);
>   
>   	spin_unlock(&vp->lock);
>   
> -	return result;
> -
> -free_buffer:
>   	release_firmware(fw);
>   
> -flash_fail:
> +	return result;
> +
> +apply_flash_fail:
>   	spin_unlock(&vp->lock);
> -	if (vp->bpf != NULL)
> +	if (vp->bpf)
>   		kfree(vp->bpf->filter);
>   	kfree(vp->bpf);
> -	vp->bpf = NULL;
> +
> +free_buffer:
> +	release_firmware(fw);
>   	return -1;
>   }
>   
> 


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

