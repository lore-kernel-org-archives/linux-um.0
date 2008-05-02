Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Js0Pj-00064Y-OG for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 11:55:24 -0700
Received: from 41-052.adsl.zetnet.co.uk
	([194.247.41.52] helo=mail.esperi.org.uk ident=user76455)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Js0Pi-0000qj-14
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 02 May 2008 11:55:23 -0700
References: <877iel7ljp.fsf@hades.wkstn.nix> <87ve256146.fsf@hades.wkstn.nix>
	<871w4sqxgv.fsf@hades.wkstn.nix>
	<20080428164443.GB9628@c2.user-mode-linux.org>
	<871w4n9fo8.fsf@hades.wkstn.nix>
	<20080501151351.GA6303@c2.user-mode-linux.org>
	<87prs57g4h.fsf@hades.wkstn.nix>
	<20080502163020.GB7843@c2.user-mode-linux.org>
From: Nix <nix@esperi.org.uk>
Date: Fri, 02 May 2008 19:55:11 +0100
In-Reply-To: <20080502163020.GB7843@c2.user-mode-linux.org> (Jeff Dike's
	message of "Fri, 2 May 2008 12:30:20 -0400")
Message-ID: <87bq3o5yeo.fsf@hades.wkstn.nix>
MIME-Version: 1.0
Subject: Re: [uml-devel] actually useful backtrace from a CPU-chewing hang
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
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 2 May 2008, Jeff Dike verbalised:
> With your config, I'm seeing a hang until the system time catches up
> to what UML thought it should have been in the first place.  But it's
> only a few seconds, not forever.

This is true sometimes, but not always: I just tried twice and got
a rapid recovery the first time, but not the second. Trace the second
time:

0x08084b89 in update_wall_time () at kernel/time/timekeeping.c:475
475                     clock->error -= clock->xtime_interval << (TICK_LENGTH_SHIFT - clock->shift);
(gdb) bt
#0  0x08084b89 in update_wall_time () at kernel/time/timekeeping.c:475
#1  0x08077bd1 in do_timer (ticks=1) at kernel/timer.c:929
#2  0x08086314 in tick_periodic (cpu=0) at kernel/time/tick-common.c:66
#3  0x08086346 in tick_handle_periodic (dev=0x821d384) at kernel/time/tick-common.c:82
#4  0x080590ed in um_timer (irq=0, dev=0x0) at arch/um/kernel/time.c:70
#5  0x0808d3f3 in handle_IRQ_event (irq=0, action=0xdc49480) at kernel/irq/handle.c:140
#6  0x0808d471 in __do_IRQ (irq=0) at kernel/irq/handle.c:236
#7  0x080576f8 in do_IRQ (irq=0, regs=0x821bc80) at arch/um/kernel/irq.c:335
#8  0x080590a0 in timer_handler (sig=26, regs=0x821bc80) at arch/um/kernel/time.c:28
#9  0x08064c84 in real_alarm_handler (sc=0x821bd24) at arch/um/os-Linux/signal.c:93
#10 0x08064cac in alarm_handler (sig=26, sc=0x821bd24) at arch/um/os-Linux/signal.c:108
#11 0x08064d67 in handle_signal (sig=32, sc=0x821bd24) at arch/um/os-Linux/signal.c:157
#12 0x08066263 in hard_handler (sig=26) at arch/um/os-Linux/sys-i386/signal.c:12
#13 <signal handler called>
#14 getnstimeofday (ts=0xde3beec) at include/linux/time.h:182
#15 0x08084306 in do_gettimeofday (tv=0xde3bf04) at kernel/time/timekeeping.c:118
#16 0x0807396c in sys_gettimeofday (tv=0xbf8a4ad8, tz=0x0) at kernel/time.c:103
#17 0x0805a55c in handle_syscall (r=0xde66e28) at arch/um/kernel/skas/syscall.c:35
#18 0x08066cdf in handle_trap (pid=13310, regs=0xde66e28, local_using_sysemu=2) at arch/um/os-Linux/skas/process.c:202
#19 0x0806716b in userspace (regs=0xde66e28) at arch/um/os-Linux/skas/process.c:418
#20 0x08057f5a in fork_handler () at arch/um/kernel/process.c:179
#21 0x00000000 in ?? ()
(gdb) quit

> However, stracing it did reveal a bogus interval trying to be set,
> which the patch below fixes.  It doesn't cause any behavior change
> here, so YMMV.
>
> This includes the previous patch, which I think is a good idea anyway,
> so back that out and drop this in its place.

No behavioural change :(

I'm trying something else now, arranging for os_nsecs() itself to do the
never-backwards stuff on the assumption that something depends on
monotonic timers not skipping backwards which presently they might
(there are callers of os_nsecs() outside of os-Linux/time.c, notably in
kernel/time.c, and currently they see an unadjusted time, jumping
backwards and forwards and whatever).

-- 
`If you are having a "ua luea luea le ua le" kind of day, I can only
 assume that you are doing no work due [to] incapacitating nausea caused 
 by numerous lazy demons.' --- Frossie

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
