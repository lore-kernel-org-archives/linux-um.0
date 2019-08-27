Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.92 #3 (Red Hat Linux))
 id 1i2U1B-0005V1-Q9
 for linux-um@lists.infradead.org; Tue, 27 Aug 2019 05:27:47 +0000
Subject: Re: [PATCH 1/4] arch: um: remove sig_info[SIGALRM]
References: <20190823104429.11047-1-johannes@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <4c9cd570-5036-73b5-f23d-3ce67e6f04c6@kot-begemot.co.uk>
Date: Tue, 27 Aug 2019 06:27:38 +0100
MIME-Version: 1.0
In-Reply-To: <20190823104429.11047-1-johannes@sipsolutions.net>
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
> This entry is misleading, the actual signal handler is
> another one that never uses sig_info.
> 
> Also remove the SIGALRM if inside sig_handler() for the
> same reason.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   arch/um/os-Linux/signal.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
> index 75b10235d369..35d1b2bc00cb 100644
> --- a/arch/um/os-Linux/signal.c
> +++ b/arch/um/os-Linux/signal.c
> @@ -26,7 +26,6 @@ void (*sig_info[NSIG])(int, struct siginfo *, struct uml_pt_regs *) = {
>   	[SIGBUS]	= bus_handler,
>   	[SIGSEGV]	= segv_handler,
>   	[SIGIO]		= sigio_handler,
> -	[SIGALRM]	= timer_handler
>   };
>   
>   static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
> @@ -42,7 +41,7 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
>   	}
>   
>   	/* enable signals if sig isn't IRQ signal */
> -	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGALRM))
> +	if ((sig != SIGIO) && (sig != SIGWINCH))
>   		unblock_signals();
>   
>   	(*sig_info[sig])(sig, si, &r);
>

Acked-by: Anton Ivanov <anton.ivanov@cambridgegreys.co.uk>


-- 
Anton R Ivanov

http://www.kot-begemot.co.uk

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

