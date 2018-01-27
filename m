Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-4.v28.ch3.sourceforge.com ([172.29.28.194]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1efOrn-0008Dd-SJ
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 27 Jan 2018 11:41:51 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sfi-mx-4.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1efOrm-0005Uu-CL for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 27 Jan 2018 11:41:51 +0000
References: <20180127105357.2728-1-christophe.jaillet@wanadoo.fr>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <2ef83bee-fd4d-93c0-d5d6-59025c4406bf@kot-begemot.co.uk>
Date: Sat, 27 Jan 2018 11:41:42 +0000
MIME-Version: 1.0
In-Reply-To: <20180127105357.2728-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Subject: Re: [uml-devel] [PATCH 1/2] um: vector: Fix a memory allocation
 check
List-Id: The user-mode Linux development list
 <user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>, 
 <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>

Thanks, looks correct, +1

Richard, can you add it to the next pull.

Thanks in advance,

A.

On 27/01/18 10:53, Christophe JAILLET wrote:
> Checking the result of the previous 'kstrdup()' call is expected here, so
> we should test 'params' and not 'str' (which is known to be non-NULL at
> this point)
>
> Fixes: ad1f62ab2bd4 ("High Performance UML Vector Network Driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/um/drivers/vector_kern.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index d1d53015d572..3c1e6ad91016 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -723,7 +723,7 @@ static int vector_config(char *str, char **error_out)
>  	 */
>  
>  	params = kstrdup(params, GFP_KERNEL);
> -	if (str == NULL) {
> +	if (params == NULL) {
>  		*error_out = "vector_config failed to strdup string";
>  		return -ENOMEM;
>  	}



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

