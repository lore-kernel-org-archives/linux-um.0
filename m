Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpW3s-00049S-0f for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 15:06:32 -0700
Received: from 41-052.adsl.zetnet.co.uk ([194.247.41.52]
	helo=mail.esperi.org.uk)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JpW3o-00023m-5P
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 15:06:31 -0700
References: <877iel7ljp.fsf@hades.wkstn.nix>
From: Nix <nix@esperi.org.uk>
Date: Fri, 25 Apr 2008 23:06:17 +0100
In-Reply-To: <877iel7ljp.fsf@hades.wkstn.nix> (nix@esperi.org.uk's message of
	"Fri, 25 Apr 2008 20:59:38 +0100")
Message-ID: <87ve256146.fsf@hades.wkstn.nix>
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
To: Jeff Dike <jdike@linux.intel.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

On 25 Apr 2008, nix@esperi.org.uk told this:

> I suspect this can go wrong anywhere, but it happens to have been a
> CBQ-triggered gettimeofday() while sending an arp that did it. (My ADSL
> router pretty much bombs the poor damn machine with ARP packets all the
> time.)

Woo, it's happening a lot tonight.

The CBQ/ARP problem recurred, and also this:

(gdb) bt
#0  0xb7f87410 in __kernel_vsyscall ()
#1  0x45f27b36 in gettimeofday () from /lib/libc.so.6
#2  0x08065417 in os_nsecs () at arch/um/os-Linux/time.c:79
#3  0x080590fc in itimer_read () at arch/um/kernel/time.c:77
#4  0x08084a5f in update_wall_time () at include/linux/clocksource.h:167
#5  0x08077ba1 in do_timer (ticks=1) at kernel/timer.c:929
#6  0x08086350 in tick_periodic (cpu=0) at kernel/time/tick-common.c:66
#7  0x08086382 in tick_handle_periodic (dev=0x821d384) at kernel/time/tick-common.c:82
#8  0x080590ed in um_timer (irq=0, dev=0x0) at arch/um/kernel/time.c:70
#9  0x0808d42f in handle_IRQ_event (irq=0, action=0xdc49480) at kernel/irq/handle.c:140
#10 0x0808d4ad in __do_IRQ (irq=0) at kernel/irq/handle.c:236
#11 0x080576f8 in do_IRQ (irq=0, regs=0x8217ec4) at arch/um/kernel/irq.c:335
#12 0x080590a0 in timer_handler (sig=26, regs=0x8217ec4) at arch/um/kernel/time.c:28
#13 0x08064c84 in real_alarm_handler (sc=0x0) at arch/um/os-Linux/signal.c:93
#14 0x08064cac in alarm_handler (sig=26, sc=0x0) at arch/um/os-Linux/signal.c:108
#15 0x080654a0 in deliver_alarm () at arch/um/os-Linux/time.c:117
#16 0x08065640 in idle_sleep (nsecs=<value optimized out>) at arch/um/os-Linux/time.c:181
#17 0x080580d4 in default_idle () at arch/um/kernel/process.c:248
#18 0x080580fe in cpu_idle () at arch/um/kernel/process.c:256
#19 0x081afdee in rest_init () at init/main.c:453
#20 0x0804953b in start_kernel () at init/main.c:650
#21 0x0804a7e1 in start_kernel_proc (unused=0x0) at arch/um/kernel/skas/process.c:46
#22 0x08064261 in run_kernel_thread (fn=0x804a7b5 <start_kernel_proc>, arg=0x0, jmp_ptr=0x821d184) at arch/um/os-Linux/process.c:267
#23 0x08057ee0 in new_thread_handler () at arch/um/kernel/process.c:151
#24 0x00000000 in ?? ()

It looks to me like os_nsecs()/gettimeofday()/et al are the only really
important parts of this backtrace.

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
