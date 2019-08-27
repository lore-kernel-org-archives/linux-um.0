Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2U21-0005XK-L3
 for linux-um@lists.infradead.org; Tue, 27 Aug 2019 05:28:39 +0000
Subject: Re: [PATCH 2/4] arch: um: avoid using uninitialized regs
References: <20190823104429.11047-1-johannes@sipsolutions.net>
 <20190823104429.11047-2-johannes@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <d1ee048f-8ea6-d618-05a8-f254d1107cb8@kot-begemot.co.uk>
Date: Tue, 27 Aug 2019 06:28:32 +0100
MIME-Version: 1.0
In-Reply-To: <20190823104429.11047-2-johannes@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>



On 23/08/2019 11:44, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> In timer_real_alarm_handler(), regs is only initialized if
> the context argument is non-NULL, also initialize in the
> other case.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/os-Linux/signal.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
> index 35d1b2bc00cb..4cd88b5b9006 100644
> --- a/arch/um/os-Linux/signal.c
> +++ b/arch/um/os-Linux/signal.c
> @@ -10,6 +10,7 @@
>   #include <stdarg.h>
>   #include <errno.h>
>   #include <signal.h>
> +#include <string.h>
>   #include <strings.h>
>   #include <as-layout.h>
>   #include <kern_util.h>
> @@ -88,6 +89,8 @@ static void timer_real_alarm_handler(mcontext_t *mc)
>   
>   	if (mc != NULL)
>   		get_regs_from_mc(&regs, mc);
> +	else
> +		memset(&regs, 0, sizeof(regs));
>   	timer_handler(SIGALRM, NULL, &regs);
>   }
>   
> 

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>

-- 
Anton R Ivanov

http://www.kot-begemot.co.uk

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

