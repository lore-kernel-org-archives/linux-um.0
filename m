Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1BqS8F-000559-3u for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 00:48:47 -0700
Received: from boxa.alphawave.net ([207.218.5.130] helo=box.alphawave.net)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.34)
	id 1BqS8E-0000nc-Fm for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 30 Jul 2004 00:48:47 -0700
From: Nick Craig-Wood <nick@memset.com>
Subject: Re: [uml-devel] uml-patch-2.4.26-2
Message-ID: <20040730074833.GA22488@craig-wood.com>
References: <200407162019.i6GKJKqa003236@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200407162019.i6GKJKqa003236@ccure.user-mode-linux.org>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Fri, 30 Jul 2004 08:48:33 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

I'm having trouble getting this to run stably.  On a Fedora core 2
image it locks up with 100% CPU after about 12 hours
normally.

uml-patch-2.4.26-1 did the same thing (but required quite a bit of
patching to even get throught the boot process!).

I'm using 2.4.26 + uml-patch-2.4.26-2 plus the patches from /work/2.4
on a SKAS host running 2.4.25.

Here is a gdb backtrace of the locked UML.  It still responds to ping
and uml_mconsole but it doesn't respond to ssh...

#0  0xa01e68f5 in sigprocmask ()
#1  0xa00e5a10 in change_signals (type=0) at signal_user.c:69
#2  0xa00e5a48 in block_signals () at signal_user.c:75
#3  0xa00165c0 in do_softirq () at softirq.c:95
#4  0xa00e0c42 in do_IRQ (irq=0, regs=0xa0294278) at irq.c:336
#5  0xa00e710e in timer_irq (regs=0xa0294278) at time_kern.c:76
#6  0xa00e7418 in timer_handler (sig=14, regs=0xa0294278) at time_kern.c:163
#7  0xa00ed1d4 in sig_handler_common_skas (sig=14, sc_ptr=0xa0297868)
    at trap_user.c:35
#8  0xa00e7eed in alarm_handler (sig=14, sc=
      {gs = 0, __gsh = 0, fs = 0, __fsh = 0, es = 43, __esh = 0, ds = 43, __dsh = 0, edi = 2687057920, esi = 2687057920, ebp = 2687073132, esp = 2687073088, ebx = 2687073124, edx = 2687057920, ecx = 0, eax = 4294967292, trapno = 14, err = 6, eip = 2686421985, cs = 35, __csh = 0, eflags = 643, esp_at_signal = 2687073088, ss = 43, __ssh = 0, fpstate = 0x0, oldmask = 0, cr2 = 2827055104})
    at trap_user.c:115
#9  <signal handler called>
#10 0xa01f8be1 in nanosleep ()
#11 0xa00e6fe9 in idle_sleep (secs=10) at time.c:132
#12 0xa00e36ea in cpu_idle () at process_kern.c:212
#13 0xa000e5b1 in rest_init () at init/main.c:346
#14 0xa000255c in start_kernel () at init/main.c:440
#15 0xa00ecb5f in start_kernel_proc (unused=0x0) at process_kern.c:156
#16 0xa00e3236 in run_kernel_thread (fn=0xa00ecb38 <start_kernel_proc>, 
    arg=0x0, jmp_ptr=0xa0294558) at process.c:227
#17 0xa00ec92d in new_thread_handler (sig=10) at process_kern.c:70
#18 <signal handler called>
#19 0xa01e6971 in kill ()
#20 0x0000001c in ?? ()

Let me know if I can produce anything more interesting from gdb - I've
left the UML locked up.

-- 
Nick Craig-Wood   Tel: 0800 195 4968   Net: nick@memset.com
Memset Ltd                             Web: http://www.memset.com


-------------------------------------------------------
This SF.Net email is sponsored by OSTG. Have you noticed the changes on
Linux.com, ITManagersJournal and NewsForge in the past few weeks? Now,
one more big change to announce. We are now OSTG- Open Source Technology
Group. Come see the changes on the new OSTG site. www.ostg.com
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
