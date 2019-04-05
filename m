Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hCRX4-0002TE-VU
 for linux-um@lists.infradead.org; Fri, 05 Apr 2019 16:17:36 +0000
Subject: Re: [PATCH] um: Do not unlock mutex that is not hold.
References: <20190402084332.88965-1-dwalter@google.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <cb5e35f0-9f95-fec1-9325-be8fa580bf00@kot-begemot.co.uk>
Date: Fri, 5 Apr 2019 17:17:27 +0100
MIME-Version: 1.0
In-Reply-To: <20190402084332.88965-1-dwalter@google.com>
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
To: Daniel Walter <dwalter@google.com>, richard@nod.at, linux-um@lists.infradead.org
Cc: linux-kernel@vger.kernel.org



On 02/04/2019 09:43, Daniel Walter wrote:
>   Return error instead of trying to unlock a mutex that is not hold.
> 
> Signed-off-by: Daniel Walter <dwalter@google.com>
> ---
>   arch/um/drivers/ubd_kern.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
> index aca09be2373e..33c1cd6a12ac 100644
> --- a/arch/um/drivers/ubd_kern.c
> +++ b/arch/um/drivers/ubd_kern.c
> @@ -276,14 +276,14 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
>   		str++;
>   		if(!strcmp(str, "sync")){
>   			global_openflags = of_sync(global_openflags);
> -			goto out1;
> +			return err;
>   		}
>   
>   		err = -EINVAL;
>   		major = simple_strtoul(str, &end, 0);
>   		if((*end != '\0') || (end == str)){
>   			*error_out = "Didn't parse major number";
> -			goto out1;
> +			return err;
>   		}
>   
>   		mutex_lock(&ubd_lock);
> 

Reviewed-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

