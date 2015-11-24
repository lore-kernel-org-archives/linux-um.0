Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>) id 1a1GxX-00013T-M4
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Nov 2015 17:00:51 +0000
Received: from ivanoab4.miniserver.com ([78.31.104.92])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1a1GxW-0000hJ-An
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 24 Nov 2015 17:00:51 +0000
Message-ID: <565497BA.20400@kot-begemot.co.uk>
Date: Tue, 24 Nov 2015 17:00:42 +0000
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
MIME-Version: 1.0
References: <564F0C6D.8000806@kot-begemot.co.uk>
In-Reply-To: <564F0C6D.8000806@kot-begemot.co.uk>
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
Subject: Re: [uml-devel] IRQ handler reentrancy
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>

I got to the bottom of this now:

1. This has been around for a long time.

2. It was not showing up because:

     2.1. The deactivate_fd/reactivate_fd in the poll based IRQ 
controller double up as per-fd reentrancy guard for SIGIO. So while 
SIGIO handler was reentrant (potentially bad), the actual device reading 
and writing were not. This is why this was not blowing up regularly so 
far. Even if there are potential races in modifying the poll structures, 
etc, they are very difficult to trigger.

     2.2. The VTALRM based timer system produced timer interrupts only 
when UML was running or out of idle. This ensured that there is only one 
timer interrupt in flight at any given time.

The new timer subsystem + me trying to move to EPOLL brought the 
gremlins out of the woodwork (which is good, we know that they are there 
now).

I am going to reissue the timer errata + IRQ guard setting a guard only 
around the timer. The per-fd disable/reenable behaviour provides a 
sufficient guard for SIGIO so while you can crudely guard for both (as I 
have in the first version of the reentrancy patch), you do not need to 
do that. A guard for the timer is sufficient.

I now have a fixed version for the EPOLL patch which replicates the 
per-fd old reentrancy guard behavior and has a timer guard. That has 
killed all WARN() and BUG() in my testing so far.

I am going to give all of these some testing for 1-2 days and if I am 
happy with the results resubmit the errata patchset and the revised 
EPOLL IRQ controller patch (as an incremental on top of the errata).

The Epoll controller with the fixes still manages ~ 10%+ better 
performance than the old POLL based one and it will also allow further 
optimizations later on.

A.


On 20/11/15 12:05, Anton Ivanov wrote:
> I have gotten to the bottom of this.
>
> 1. The IRQ handler re-entrancy issue predates the timer patch. Adding a
> simple guard with a WARN_ON_ONCE around the device loop in the
> sig_io_handler catches it in plain 4.3
>
> diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
> index 23cb935..ac0bbce 100644
> --- a/arch/um/kernel/irq.c
> +++ b/arch/um/kernel/irq.c
> @@ -30,12 +30,17 @@ static struct irq_fd **last_irq_ptr = &active_fds;
>
>    extern void free_irqs(void);
>
> +static int in_poll_handler = 0;
> +
>    void sigio_handler(int sig, struct siginfo *unused_si, struct
> uml_pt_regs *regs)
>    {
>           struct irq_fd *irq_fd;
>           int n;
>
> +    WARN_ON_ONCE(in_poll_handler == 1);
> +
>           while (1) {
> +        in_poll_handler = 1;
>                   n = os_waiting_for_events(active_fds);
>                   if (n <= 0) {
>                           if (n == -EINTR)
> @@ -51,6 +56,7 @@ void sigio_handler(int sig, struct siginfo *unused_si,
> struct uml_pt_regs *regs)
>                           }
>                   }
>           }
> +    in_poll_handler = 0;
>
>           free_irqs();
>    }
>
> This is dangerously broken - you can under heavy IO exhaust the stack,
> you can get packets out of order, etc. Most IO is reasonably atomic so
> corruption is not likely, but not impossible (especially if one or more
> drivers are optimized to use multi-read/multi-write).
>
> 2. I cannot catch what is wrong with the current code in signal.c. When
> I read it, it should not produce re-entrancy. But it does.
>
> 3. I found 2-3 minor issues with signal handling and the timer patch
> which I will submit a hot-fix for, including a proper fix for the
> hang-in-sleep issue.
>
> 4. While I can propose a brutal patch for signal.c which sets guards
> against reentrancy which works fine, I suggest we actually get to the
> bottom of this. Why the code in unblock_signals() does not guard
> correctly against that?
>
> A.
>
> ------------------------------------------------------------------------------
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>


------------------------------------------------------------------------------
Go from Idea to Many App Stores Faster with Intel(R) XDK
Give your users amazing mobile app experiences with Intel(R) XDK.
Use one codebase in this all-in-one HTML5 development environment.
Design, debug & build mobile apps & 2D/3D high-impact games for multiple OSs.
http://pubads.g.doubleclick.net/gampad/clk?id=254741551&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

