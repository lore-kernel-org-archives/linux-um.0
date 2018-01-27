Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-3.v28.ch3.sourceforge.com ([172.29.28.193]
 helo=mx.sourceforge.net)
 by sfs-ml-1.v29.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.89)
 (envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1efOsL-0008G6-OU
 for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 27 Jan 2018 11:42:25 +0000
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by sfi-mx-3.v28.ch3.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.89)
 id 1efOsK-0000xl-Oh for user-mode-linux-devel@lists.sourceforge.net;
 Sat, 27 Jan 2018 11:42:25 +0000
References: <20180127105510.2782-1-christophe.jaillet@wanadoo.fr>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <7f9f4ba3-5b3f-c5c5-7d63-d9032848a517@kot-begemot.co.uk>
Date: Sat, 27 Jan 2018 11:42:17 +0000
MIME-Version: 1.0
In-Reply-To: <20180127105510.2782-1-christophe.jaillet@wanadoo.fr>
Content-Language: en-US
Subject: Re: [uml-devel] [PATCH 2/2] um: vector: Fix an error handling path
 in 'vector_parse()'
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



On 27/01/18 10:55, Christophe JAILLET wrote:
> If 'find_device()' finds something, we set '*error_out' and we should
> return an error. However, 'err' is known to be 0 at this point.
>
> Explicitly return -EINVAL instead.
>
> While at it, remove the initialization of 'err' at the beginning of the
> function and also explicitly return an error code if the first check
> fails.
>
> Fixes: ad1f62ab2bd4 ("High Performance UML Vector Network Driver")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Not sure if correct, but it looks spurious to set 'error_out' and return
> 0 (i.e. success)
> ---
>  arch/um/drivers/vector_kern.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/um/drivers/vector_kern.c b/arch/um/drivers/vector_kern.c
> index 3c1e6ad91016..6fab02a126e6 100644
> --- a/arch/um/drivers/vector_kern.c
> +++ b/arch/um/drivers/vector_kern.c
> @@ -677,7 +677,7 @@ static struct vector_device *find_device(int n)
>  static int vector_parse(char *str, int *index_out, char **str_out,
>  			char **error_out)
>  {
> -	int n, len, err = -EINVAL;
> +	int n, len, err;
>  	char *start = str;
>  
>  	len = strlen(str);
> @@ -686,7 +686,7 @@ static int vector_parse(char *str, int *index_out, char **str_out,
>  		str++;
>  	if (*str != ':') {
>  		*error_out = "Expected ':' after device number";
> -		return err;
> +		return -EINVAL;
>  	}
>  	*str = '\0';
>  
> @@ -699,7 +699,7 @@ static int vector_parse(char *str, int *index_out, char **str_out,
>  	str++;
>  	if (find_device(n)) {
>  		*error_out = "Device already configured";
> -		return err;
> +		return -EINVAL;
>  	}
>  
>  	*index_out = n;



------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

