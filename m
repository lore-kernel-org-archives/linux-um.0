Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gPleC-0007sS-OX
 for linux-um@lists.infradead.org; Thu, 22 Nov 2018 09:51:46 +0000
Subject: Re: [PATCH] um/timer: fix tv_sec value setup in os_timer_one_shot
References: <20181122015535.3943-1-liwei@anbutu.com>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <50d3eb2e-afc9-3bbe-1117-81a26d79c48b@cambridgegreys.com>
Date: Thu, 22 Nov 2018 09:51:26 +0000
MIME-Version: 1.0
In-Reply-To: <20181122015535.3943-1-liwei@anbutu.com>
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
To: Wei Li <liwei@anbutu.com>, linux-um@lists.infradead.org
Cc: richard@nod.at, jdike@addtoit.com

On 11/22/18 1:55 AM, Wei Li wrote:

> Signed-off-by: Wei Li <liwei@anbutu.com>
> ---
>   arch/um/os-Linux/time.c | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
> index 0e39b9978729..c0c6bcb51241 100644
> --- a/arch/um/os-Linux/time.c
> +++ b/arch/um/os-Linux/time.c
> @@ -119,11 +119,11 @@ int os_timer_one_shot(int ticks)
>   	unsigned long long nsec;
>   	unsigned long sec;
>   
> -    nsec = (ticks + 1);
> -    sec = nsec / UM_NSEC_PER_SEC;
> +	nsec = (ticks + 1);
> +	sec = nsec / UM_NSEC_PER_SEC;
>   	nsec = nsec % UM_NSEC_PER_SEC;
>   
> -	its.it_value.tv_sec = nsec / UM_NSEC_PER_SEC;
> +	its.it_value.tv_sec = sec;
>   	its.it_value.tv_nsec = nsec;
>   
>   	its.it_interval.tv_sec = 0;

Thanks,

A.

-- 
Anton R. Ivanov

Cambridge Greys Limited, England and Wales company No 10273661
http://www.cambridgegreys.com/


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

