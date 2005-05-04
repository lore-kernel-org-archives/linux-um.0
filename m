Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DTLQy-0000sH-4O	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 08:05:08 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DTLQx-0005Zm-Ar	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 May 2005 08:05:08 -0700
Message-Id: <s2788296.000@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: Re: [uml-devel] Kernel panic with 2.6.11.6
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
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
Date: Wed, 04 May 2005 08:06:22 -0700
Content-Transfer-Encoding: 8bit
To: jdike@addtoit.com
Cc: user-mode-linux-devel@lists.sourceforge.net

Okay, I've now recompiled the host kernel to include debugging information. I now get the following:

myserver:~# 
Program received signal SIGSEGV, Segmentation fault.
chan_interrupt (chans=0x4013a3cc, task=0x4013a3fc, tty=0xbc1c000, irq=2) at arch/um/drivers/chan_kern.c:535
535     arch/um/drivers/chan_kern.c: No such file or directory.
        in arch/um/drivers/chan_kern.c
(gdb) bt   
#0  chan_interrupt (chans=0x4013a3cc, task=0x4013a3fc, tty=0xbc1c000, irq=2) at arch/um/drivers/chan_kern.c:535
#1  0x0806b2d0 in line_interrupt (irq=1075028940, data=0xbc1c000, unused=0x8290ee8) at arch/um/drivers/line.c:30
#2  0x080984b3 in handle_IRQ_event (irq=2, regs=0x8290ee8, action=0xbc8c780) at kernel/irq/handle.c:87
#3  0x080985ab in __do_IRQ (irq=2, regs=0x8290ee8) at kernel/irq/handle..c:172
#4  0x0805fe70 in do_IRQ (irq=1075028940, regs=0x4013a3c4) at arch/um/kernel/irq.c:89
#5  0x0806000a in sigio_handler (sig=29, regs=0x8290ee8) at arch/um/kernel/irq_user.c:73
#6  0x0806939f in sig_handler_common_skas (sig=29, sc_ptr=0xe8) at arch/um/kernel/skas/trap_user.c:42
#7  0x08075648 in sig_handler (sig=29) at arch/um/os-Linux/signal.c:16
#8  <signal handler called>
#9  0xb7f5a5bb in nanosleep () from /lib/tls/libc.so.6
#10 0x08065c44 in idle_sleep (secs=-4) at arch/um/kernel/time.c:155
#11 0x08062e76 in default_idle () at arch/um/kernel/process_kern.c:215
#12 0x08068ca8 in init_idle_skas () at arch/um/kernel/skas/process_kern.c:157
#13 0x08049603 in start_kernel () at init/main.c:514
#14 0x08068cdc in start_kernel_proc (unused=0x0) at arch/um/kernel/skas/process_kern.c:174
#15 0x080628d9 in run_kernel_thread (fn=0x8068cb0 <start_kernel_proc>, arg=0x0, jmp_ptr=0xfffffffc) at arch/um/kernel/process.c:364
#16 0x08068983 in new_thread_handler (sig=10) at thread_info.h:46
#17 <signal handler called>
#18 0xb7ed9ab1 in kill () from /lib/tls/libc.so.6
#19 0x04000000 in ?? ()
#20 0x08000000 in ?? ()
#21 0x00000001 in ?? ()
#22 0xbffff488 in ?? ()
#23 0x080685f9 in start_idle_thread (stack=0x828fad4, switch_buf_ptr=0x1, fork_buf_ptr=0x0) at arch/um/kernel/skas/process.c:282
#24 0x080685f9 in start_idle_thread (stack=0x828c000, switch_buf_ptr=0x82911f4, fork_buf_ptr=0x0)
    at arch/um/kernel/skas/process.c:282
#25 0x08068d43 in start_uml_skas () at arch/um/kernel/skas/process_kern.c:187
#26 0x08066fee in linux_main (argc=137186816, argv=0x8000000) at arch/um/kernel/um_arch.c:426
#27 0x08060b1b in main (argc=0, argv=0xbffff614, envp=0x0) at arch/um/kernel/main.c:155
(gdb) 

>>> "Anthony Brock" <Anthony_Brock@ous.edu> 05/03/05 09:39AM >>>
One final test. The following allowed the crash to finish. Also, the crash occurred as soon as I hit the "down" arrow on my keyboard. I'm beginning to wonder if this is somehow related to the readline libraries or bash:

myserver:~# 
Program received signal SIGSEGV, Segmentation fault.
0x0806b21f in chan_interrupt ()
(gdb) bt
#0  0x0806b21f in chan_interrupt ()
#1  0x00000000 in ?? ()
(gdb) c
Continuing.

Breakpoint 1, 0x0807d0c0 in panic ()
(gdb) bt
#0  0x0807d0c0 in panic ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0807d0c4 in panic ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0807d0cb in panic ()
(gdb) handle SIGTRAP pass nostop noprint
SIGTRAP is used by the debugger.
Are you sure you want to change it? (y or n) y
Signal        Stop      Print   Pass to program Description
SIGTRAP       No        No      Yes             Trace/breakpoint trap
(gdb) c
Continuing.

Breakpoint 1, 0x0807d0c0 in panic ()
(gdb) bt
#0  0x0807d0c0 in panic ()
#1  0x08066ac4 in relay_signal ()
#2  0x08256923 in __func__.5 ()
#3  0x00000005 in ?? ()
#4  0x08298ee8 in init_task ()
#5  0x08064f0f in unblock_signals ()
#6  0x00000001 in ?? ()
#7  0x08298ee8 in init_task ()
#8  0x00000028 in ?? ()
#9  0x080697f0 in sig_handler_common_skas ()
#10 0x00000000 in ?? ()
#11 0x00000000 in ?? ()
#12 0x00000016 in ?? ()
#13 0x40139b54 in ?? ()
#14 0xfffffff2 in ?? ()
#15 0x00000000 in ?? ()
#16 0x00000000 in ?? ()
#17 0x08075e87 in sig_handler ()
#18 0x00000005 in ?? ()
#19 0x08297088 in init_thread_union ()
#20 0x40139b54 in ?? ()
#21 <signal handler called>
#22 0x0807d0cb in panic ()
(gdb) c
Continuing.

Program terminated with signal SIGTRAP, Trace/breakpoint trap.
The program no longer exists.
(gdb) quit


>>> "Anthony Brock" <Anthony_Brock@ous.edu> 05/03/05 09:32AM >>>
Well, debug information didn't seem to have any positive effect. Here are the additional configure parameters I turned on:

CONFIG_DEBUG_KERNEL=y
CONFIG_DEBUG_INFO=y
CONFIG_FRAME_POINTER=y

Let me know if I'm missing something or need to turn on additional parameters. Also, please note that this crash never seemed to end! It kept hitting breakpoints! Here are the start of the messages:

myserver:~# 
Program received signal SIGSEGV, Segmentation fault.
0x0806b21f in chan_interrupt ()
(gdb) bt
#0  0x0806b21f in chan_interrupt ()
#1  0x00000000 in ?? ()
(gdb) c
Continuing.

Breakpoint 1, 0x0807d0c0 in panic ()
(gdb) bt
#0  0x0807d0c0 in panic ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0807d0c4 in panic ()
(gdb) bt
#0  0x0807d0c4 in panic ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0807d0cb in panic ()
(gdb) bt
#0  0x0807d0cb in panic ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fdd0 in bust_spinlocks ()
(gdb) bt
#0  0x0818fdd0 in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fdd3 in bust_spinlocks ()
(gdb) bt
#0  0x0818fdd3 in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fdd7 in bust_spinlocks ()
(gdb) bt
#0  0x0818fdd7 in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fddb in bust_spinlocks ()
(gdb) bt
#0  0x0818fddb in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fddd in bust_spinlocks ()
(gdb) bt
#0  0x0818fddd in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fddf in bust_spinlocks ()
(gdb) bt
#0  0x0818fddf in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fde4 in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fdea in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fdee in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0818fdf1 in bust_spinlocks ()
(gdb) c
Continuing.

Program received signal SIGTRAP, Trace/breakpoint trap.
0x0807d0d0 in panic ()
(gdb) 


I eventually killed the process. It never actually reached the previous error message. Also, this crash occurred a few seconds after I had finished typing my last command (ls -l /etc/network/).

Tony

>>> "Anthony Brock" <Anthony_Brock@ous.edu> 05/03/05 08:16AM >>>
Hmmm, I think I need to recompile the kernel with debug information. In any case, here are the results:

myserver:~# 
Program received signal SIGSEGV, Segmentation fault.
0x0806b21f in chan_interrupt ()
(gdb) bt   
#0  0x0806b21f in chan_interrupt ()
#1  0x00000000 in ?? ()
(gdb) c
Continuing.
Kernel panic - not syncing: Kernel mode fault at addr 0xd, ip 0x0
 
EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
Call Trace: 
08297338:  [<0808c30d>] notifier_call_chain+0x2d/0x50
08297348:  [<0818fe16>] bust_spinlocks+0x46/0x50
08297358:  [<0807d131>] panic+0x71/0x120
08297378:  [<08066997>] segv+0x217/0x250
082973d8:  [<08064eb5>] change_signals+0x65/0x90
08297468:  [<08066cb7>] segv_handler+0xd7/0xe0
08297488:  [<080697f0>] sig_handler_common_skas+0x90/0xe0
082974b8:  [<08075e87>] sig_handler+0x17/0x20
08297508:  [<0806b21f>] chan_interrupt+0xf/0x130
08297530:  [<08064f70>] enable_mask+0x50/0x70
08297550:  [<08064fc3>] get_signals+0x33/0x50
082975b0:  [<0806505d>] set_signals+0x7d/0x130
08297620:  [<0806505d>] set_signals+0x7d/0x130
082976b0:  [<0806505d>] set_signals+0x7d/0x130
08297710:  [<0806505d>] set_signals+0x7d/0x130
08297740:  [<08064eb5>] change_signals+0x65/0x90
082977d0:  [<0806b85f>] line_interrupt+0x2f/0x40
082977f0:  [<08099900>] handle_IRQ_event+0x30/0x80
08297820:  [<080999f8>] __do_IRQ+0xa8/0xf0
08297840:  [<0805fea3>] do_IRQ+0x33/0x50
08297850:  [<0806004a>] sigio_handler+0xda/0x140
08297870:  [<080697f0>] sig_handler_common_skas+0x90/0xe0
08297894:  [<080690e0>] start_kernel_proc+0x0/0x40
0829789c:  [<08068cc0>] new_thread_handler+0x0/0x120
082978a0:  [<08075e87>] sig_handler+0x17/0x20
082978cc:  [<080690e0>] start_kernel_proc+0x0/0x40
082978d0:  [<08068cc0>] new_thread_handler+0x0/0x120
08297a40:  [<08068937>] switch_threads+0x87/0x90
08297a70:  [<08064eb5>] change_signals+0x65/0x90
08297b10:  [<08064f0f>] unblock_signals+0xf/0x20
08297b20:  [<080799e7>] finish_task_switch+0x27/0x70
08297b40:  [<08244353>] schedule+0x2e3/0x4e0
08297b90:  [<08065e93>] idle_sleep+0x23/0x30
08297bac:  [<08068cc0>] new_thread_handler+0x0/0x120
08297bb0:  [<08062f37>] default_idle+0x67/0x70
08297bd0:  [<080690d8>] init_idle_skas+0x28/0x30
08297bd4:  [<0805f210>] init+0x0/0x110
08297be0:  [<080495b3>] start_kernel+0x163/0x1a0
08297bf4:  [<08049130>] unknown_bootoption+0x0/0x200
08297c00:  [<0806910b>] start_kernel_proc+0x2b/0x40
08297c04:  [<080690e0>] start_kernel_proc+0x0/0x40
08297c10:  [<08062978>] run_kernel_thread+0x78/0x80
08297c28:  [<080690e0>] start_kernel_proc+0x0/0x40
08297c30:  [<08068cc0>] new_thread_handler+0x0/0x120
08297c38:  [<08062940>] run_kernel_thread+0x40/0x80
08297cd4:  [<080690e0>] start_kernel_proc+0x0/0x40
08297cdc:  [<08068cc0>] new_thread_handler+0x0/0x120
08297ce0:  [<08068d8e>] new_thread_handler+0xce/0x120
08297ce4:  [<080690e0>] start_kernel_proc+0x0/0x40
08297d40:  [<08068cc0>] new_thread_handler+0x0/0x120

 

Program exited with code 01.
(gdb) 


>>> Jeff Dike <jdike@addtoit.com> 05/02/05 08:13PM >>>
brocka@sterlingcgi.com said:
> Is this your "stack trace"? 

Close.  What I'd really like is to get it to crash when it's running under
gdb, with a breakpoint on panic.  Then, 'bt' to gdb at that point.

That gives the true call trace, plus line number information.

> 08297488:  [<080697f0>] sig_handler_common_skas+0x90/0xe0
> 082974b8:  [<08075e87>] sig_handler+0x17/0x20
> 08297508:  [<0806b21f>] chan_interrupt+0xf/0x130
> 08297530:  [<08064f70>] enable_mask+0x50/0x70

This tells me that chan_interrupt segfaulted, but not necessarily exactly
where, and a lot of the other stuff on the stack isn't in the true call
chain.

				Jeff



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net 
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net 
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net 
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel 


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net 
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r 
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
