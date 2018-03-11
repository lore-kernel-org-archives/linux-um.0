Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 1/9] um/drivers/vector_user: Delete unnecessary code in
 user_init_raw_fds()
References: <e21083ff-0ba7-42ad-e3f0-d84da9c93208@users.sourceforge.net>
 <a8ec6fce-df95-10a9-6dd7-3604fd403d0d@users.sourceforge.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <33ff08e8-39cd-8558-152f-dac474fb0b5b@cambridgegreys.com>
Date: Sun, 11 Mar 2018 18:08:22 +0000
MIME-Version: 1.0
In-Reply-To: <a8ec6fce-df95-10a9-6dd7-3604fd403d0d@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: SF Markus Elfring <elfring@users.sourceforge.net>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-user@lists.sourceforge.net, kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Thanks, well noted.

It still does not fix it completely though.

Re-reading the code it will leak a fd if the malloc for result fails. 
That return result; there should be inside the conditional falling back 
to cleanup if the alloc fails.

A.


On 03/11/18 15:16, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sun, 11 Mar 2018 11:36:18 +0100
>
> * One condition check could never be reached with a non-null pointer
>    at the end of this function. Thus remove the corresponding statement.
>
> * Delete an initialisation for the local variable "result"
>    which became unnecessary with this refactoring.
>
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>
> ---
>   arch/um/drivers/vector_user.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/arch/um/drivers/vector_user.c b/arch/um/drivers/vector_user.c
> index 4291f1a5d342..d6a6207d4061 100644
> --- a/arch/um/drivers/vector_user.c
> +++ b/arch/um/drivers/vector_user.c
> @@ -211,7 +211,7 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
>   	struct sockaddr_ll sock;
>   	int err = -ENOMEM;
>   	char *iface;
> -	struct vector_fds *result = NULL;
> +	struct vector_fds *result;
>   	int optval = 1;
>   
>   
> @@ -276,8 +276,6 @@ static struct vector_fds *user_init_raw_fds(struct arglist *ifspec)
>   		os_close_file(rxfd);
>   	if (txfd >= 0)
>   		os_close_file(txfd);
> -	if (result != NULL)
> -		kfree(result);
>   	return NULL;
>   }
>   

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


