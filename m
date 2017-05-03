Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
MIME-Version: 1.0
In-Reply-To: <20161225221105.30112-1-richard@nod.at>
References: <20161225221105.30112-1-richard@nod.at>
From: Richard Weinberger <richard.weinberger@gmail.com>
Date: Wed, 3 May 2017 22:55:30 +0200
Message-ID: <CAFLxGvzZ8eGREEDOoYf1hKGwD9yPWqK-8aKAU64YztvLgPxNgA@mail.gmail.com>
Subject: Re: [uml-devel] [uml-user] [PATCH] um: Fix _print_addr()
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Richard Weinberger <richard@nod.at>
Cc: "user-mode-linux-user@lists.sourceforge.net" <user-mode-linux-user@lists.sourceforge.net>, LKML <linux-kernel@vger.kernel.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

On Sun, Dec 25, 2016 at 11:11 PM, Richard Weinberger <richard@nod.at> wrote:
> Recent changes to printk() broke UML's stack trace
> output. Kill the root of the problem by using a single
> printk() statement.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/um/kernel/sysrq.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/arch/um/kernel/sysrq.c b/arch/um/kernel/sysrq.c
> index aa1b56f5ac68..18eddf677ec6 100644
> --- a/arch/um/kernel/sysrq.c
> +++ b/arch/um/kernel/sysrq.c
> @@ -17,10 +17,8 @@
>
>  static void _print_addr(void *data, unsigned long address, int reliable)
>  {
> -       pr_info(" [<%08lx>]", address);
> -       pr_cont(" %s", reliable ? "" : "? ");
> -       print_symbol("%s", address);
> -       pr_cont("\n");
> +       pr_info(" [<%08lx>] %s%pF\n", address, reliable ? "" : "? ",
> +               (void *)address);
>  }
>
>  static const struct stacktrace_ops stackops = {

Applied.

-- 
Thanks,
//richard

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

