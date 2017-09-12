Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Tue, 12 Sep 2017 14:10:16 +0200
From: Petr Mladek <pmladek@suse.com>
Subject: Re: [PATCH 02/14] um: Use %pS printk format for symbols from direct
 addresses
Message-ID: <20170912121016.GF2908@pathway.suse.cz>
References: <1504729681-3504-1-git-send-email-deller@gmx.de>
 <1504729681-3504-3-git-send-email-deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1504729681-3504-3-git-send-email-deller@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, Sergey Senozhatsky <sergey.senozhatsky@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Wed 2017-09-06 22:27:49, Helge Deller wrote:
> Use the %pS printk format for printing symbols from direct addresses.
> In usermode-linux there is actually no difference between %pS and %pF, but for
> consistency throughout the kernel fix the wrong usage here too.
> 
> Signed-off-by: Helge Deller <deller@gmx.de>
> Cc: Jeff Dike <jdike@addtoit.com>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: user-mode-linux-devel@lists.sourceforge.net
> ---
>  arch/um/kernel/sysrq.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
> index 6b995e8..05585ee 100644
> --- a/arch/um/kernel/sysrq.c
> +++ b/arch/um/kernel/sysrq.c
> @@ -20,7 +20,7 @@
>  
>  static void _print_addr(void *data, unsigned long address, int reliable)
>  {
> -	pr_info(" [<%08lx>] %s%pF\n", address, reliable ? "" : "? ",
> +	pr_info(" [<%08lx>] %s%pS\n", address, reliable ? "" : "? ",
>  		(void *)address);

This seems to be used to print addresses from the stack.
IMHO, we should use %pB here.

Best Regards,
Petr

