Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Jukel-000315-Of for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 May 2008 01:42:17 -0700
Received: from smtp-1.orange.nl ([193.252.22.241])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1Jukej-0003NV-W2
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 10 May 2008 01:42:15 -0700
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf6009.orange.nl (SMTP Server) with ESMTP id 5CE6F700008C
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 10 May 2008 10:42:06 +0200 (CEST)
Received: from [127.0.0.1] (c529de59c.cable.wanadoo.nl [82.157.229.156])
	by mwinf6009.orange.nl (SMTP Server) with ESMTP id 3BE8D7000089
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sat, 10 May 2008 10:42:06 +0200 (CEST)
Message-ID: <48255FC4.4040805@vulnscan.org>
Date: Sat, 10 May 2008 10:41:40 +0200
From: "Bram Matthys (Syzop)" <syzop@vulnscan.org>
MIME-Version: 1.0
References: <4821B5FC.40307@vulnscan.org>
	<20080509154552.GH10169@c2.user-mode-linux.org>
In-Reply-To: <20080509154552.GH10169@c2.user-mode-linux.org>
Subject: [SPAM] Re: [uml-devel] umls unresponsive & consuming 100% cpu time
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
To: user-mode-linux-devel@lists.sourceforge.net

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Sorry, this was supposed to go to the list...

UPDATE: after 12+ hours still hung.

Jeff Dike wrote:
| On Wed, May 07, 2008 at 04:00:28PM +0200, Bram Matthys (Syzop) wrote:
|> I'm experiencing the following problem:
|> I upgraded from 2.6.20.1 to 2.6.25 on both the host and the uml's.
|> Now, after some time (unsure how soon), the uml's appear to hang.
|> It seems though, that they are not completely freezed, but just very very
|> very slow (or rather.. 99% unresponsive).
|>
|> top:
|> ~  PID USER      PR  NI  VIRT  RES  SHR S %CPU %MEM    TIME+  COMMAND
|> ~ 5434 virt      20   0  128m  89m  89m R   99  4.5 269:40.81 linux
|> ..so consuming nearly 100% cpu.
|
| Are you using CONFIG_NOHZ?
|
| There have been some recent time-related fixes.  Can you try the two
| patches below and see if they help?

Thanks for your reply.

$ grep HZ .config
CONFIG_HZ=100
# CONFIG_NO_HZ is not set

I've applied your patch against my 2.6.25 (vanilla)...
patching file arch/um/os-Linux/time.c
patching file arch/um/kernel/time.c
Hunk #1 succeeded at 74 (offset -1 lines).
Hunk #2 succeeded at 82 (offset -1 lines).
and recompiled etc..

I saw vincent's issue, and when I set the time like 5 seconds back.. the UML
freezes and uses 100% cpu and doesn't respond at all. This is however not
entirely the same as what I had, because i still had it somewhat responsive...

Anyway, applied your patches and recompiled, booted etc.. hangs again when I
set the time 5s back.
I also tested with 1s backwards... same...
This was a quick test, I don't know if it becomes responsive after like
several hours...

Attaching to program: /home/virt/linux, process 25109
0x080978bf in update_wall_time () at kernel/time/timekeeping.c:475
475                     clock->error -= clock->xtime_interval <<
(TICK_LENGTH_SHIFT - clock->shift);
(gdb) bt
#0  0x080978bf in update_wall_time () at kernel/time/timekeeping.c:475
#1  0x08086bb5 in do_timer (ticks=1) at kernel/timer.c:929
#2  0x08099793 in tick_periodic (cpu=0) at kernel/time/tick-common.c:66
#3  0x080997b8 in tick_handle_periodic (dev=0x8355420) at
kernel/time/tick-common.c:82
#4  0x0805c143 in um_timer (irq=0, dev=0x0) at arch/um/kernel/time.c:70
#5  0x0809fac0 in handle_IRQ_event (irq=0, action=0x11449460) at
kernel/irq/handle.c:140
#6  0x0809fb6a in __do_IRQ (irq=0) at kernel/irq/handle.c:236
#7  0x08059d65 in do_IRQ (irq=0, regs=0x834fe98) at arch/um/kernel/irq.c:335
#8  0x0805c0c6 in timer_handler (sig=26, regs=0x834fe98) at
arch/um/kernel/time.c:28
#9  0x0806c3d9 in real_alarm_handler (sc=0x0) at arch/um/os-Linux/signal.c:93
#10 0x0806c410 in alarm_handler (sig=26, sc=0x0) at
arch/um/os-Linux/signal.c:108
#11 0x0806cee4 in deliver_alarm () at arch/um/os-Linux/time.c:116
#12 0x0806d0f1 in idle_sleep (nsecs=<value optimized out>) at
arch/um/os-Linux/time.c:180
#13 0x0805ab13 in default_idle () at arch/um/kernel/process.c:248
#14 0x0805ab56 in cpu_idle () at arch/um/kernel/process.c:256
#15 0x082b379a in rest_init () at init/main.c:453
#16 0x0804879a in start_kernel () at init/main.c:650
#17 0x0804a12c in start_kernel_proc (unused=0x0) at
arch/um/kernel/skas/process.c:46
#18 0x0806b671 in run_kernel_thread (fn=0x804a100 <start_kernel_proc>,
arg=0x0, jmp_ptr=0x83551e0)
~    at arch/um/os-Linux/process.c:267
#19 0x0805a892 in new_thread_handler () at arch/um/kernel/process.c:151
#20 0x00000000 in ?? ()
(gdb) c
Continuing.
^C
Program received signal SIGINT, Interrupt.
0x0809785c in update_wall_time () at kernel/time/timekeeping.c:464
464                     clock->cycle_last += clock->cycle_interval;
(gdb) bt
#0  0x0809785c in update_wall_time () at kernel/time/timekeeping.c:464
#1  0x08086bb5 in do_timer (ticks=1) at kernel/timer.c:929
#2  0x08099793 in tick_periodic (cpu=0) at kernel/time/tick-common.c:66
#3  0x080997b8 in tick_handle_periodic (dev=0x8355420) at
kernel/time/tick-common.c:82
#4  0x0805c143 in um_timer (irq=0, dev=0x0) at arch/um/kernel/time.c:70
#5  0x0809fac0 in handle_IRQ_event (irq=0, action=0x11449460) at
kernel/irq/handle.c:140
#6  0x0809fb6a in __do_IRQ (irq=0) at kernel/irq/handle.c:236
#7  0x08059d65 in do_IRQ (irq=0, regs=0x834fe98) at arch/um/kernel/irq.c:335
#8  0x0805c0c6 in timer_handler (sig=26, regs=0x834fe98) at
arch/um/kernel/time.c:28
#9  0x0806c3d9 in real_alarm_handler (sc=0x0) at arch/um/os-Linux/signal.c:93
#10 0x0806c410 in alarm_handler (sig=26, sc=0x0) at
arch/um/os-Linux/signal.c:108
#11 0x0806cee4 in deliver_alarm () at arch/um/os-Linux/time.c:116
#12 0x0806d0f1 in idle_sleep (nsecs=<value optimized out>) at
arch/um/os-Linux/time.c:180
#13 0x0805ab13 in default_idle () at arch/um/kernel/process.c:248
#14 0x0805ab56 in cpu_idle () at arch/um/kernel/process.c:256
#15 0x082b379a in rest_init () at init/main.c:453
#16 0x0804879a in start_kernel () at init/main.c:650
#17 0x0804a12c in start_kernel_proc (unused=0x0) at
arch/um/kernel/skas/process.c:46
#18 0x0806b671 in run_kernel_thread (fn=0x804a100 <start_kernel_proc>,
arg=0x0, jmp_ptr=0x83551e0)
~    at arch/um/os-Linux/process.c:267
#19 0x0805a892 in new_thread_handler () at arch/um/kernel/process.c:151
#20 0x00000000 in ?? ()
(gdb)

I also saw this on my console (which does not react either btw), not sure
when it appeared.. at or very short after/before the time setting:
Stub registers -
~        0 - 621a
~        1 - 13
~        2 - 621a
~        3 - 6215
~        4 - 8
~        5 - bfae182c
~        6 - 0
~        7 - 7b
~        8 - 7b
~        9 - 0
~        10 - 0
~        11 - ffffffff
~        12 - 1000be
~        13 - 73
~        14 - 200246
~        15 - bfae1810
~        16 - 7b
wait_stub_done : failed to wait for SIGTRAP, pid = 26141, n = 26141, errno =
0, status = 0x1c7f

The old 2.6.20.1 uml's react fine when setting time backwards, btw (well..
within reasonable limits)

	Bram.

- --
Bram Matthys
Software developer/IT consultant        syzop@vulnscan.org
PGP key:                       www.vulnscan.org/pubkey.asc
PGP fp: 8DD4 437E 9BA8 09AA 0A8D  1811 E1C3 D65F E6ED 2AA2
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (MingW32)

iD8DBQFIJV/E46ioc5305a8RAsiwAJ4wjzYWngQWdfQ+EdGuJgXFyu5PYQCeIPbe
tqYB/w+brTtcjK0dLpoe/yY=
=P50g
-----END PGP SIGNATURE-----


-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
