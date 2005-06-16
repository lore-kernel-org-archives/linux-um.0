Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Dj3J3-0002a6-8r	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 15:57:53 -0700
Received: from orange.ous.edu ([140.211.15.17])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1Dj3J2-0000Ou-Lw	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Jun 2005 15:57:53 -0700
Message-Id: <s2b1a1ed.011@ORANGE.OUS.EDU>
From: "Anthony Brock" <Anthony_Brock@ous.edu>
Subject: Re: [uml-devel] Recent patches of note
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Thu, 16 Jun 2005 15:59:24 -0700
Content-Transfer-Encoding: quoted-printable
To: jdike@addtoit.com, Anthony Brock <Anthony_Brock@ous.edu>
Cc: user-mode-linux-devel@lists.sourceforge.net

I don't know if this is of interest, but I encountered the following while =
trying to recreate the freeze. However, the UML will continue to load follo=
wing this error. For some reason, the freeze doesn't seem repeatable while =
under the debugger (sigh). Here is the interesting GDB bug:


INIT: Entering runlevel: 2
Starting system log daemon: syslogd.
Starting kernel log daemon: klogd.
Starting OpenLDAP: (db4.2_recover not found),  slapd
Program received signal SIGSEGV, Segmentation fault.
0x080b86d0 in __vmalloc_area (area=3D0xbd15be0, gfp_mask=3D210, prot=3D{pgp=
rot =3D 0}) at string.h:363
363     string.h: No such file or directory.
        in string.h
(gdb) c
Continuing.
BUG: soft lockup detected on CPU#0!

EIP: 0000:[<00000000>] CPU: 0 Not tainted EFLAGS: 00000000
    Not tainted
EAX: 00000000 EBX: 00000000 ECX: 00000000 EDX: 00000000
ESI: 00000000 EDI: 00000000 EBP: 00000000 DS: 0000 ES: 0000
082b76c0:  [<0807c29b>] show_regs+0xeb/0x110
082b76e0:  [<080a0c07>] softlockup_tick+0x57/0x60
082b7700:  [<0808bfa7>] do_timer+0x47/0xd0
082b7710:  [<08063e24>] um_timer+0x14/0xc0
082b7740:  [<080a0e63>] handle_IRQ_event+0x33/0x80
082b7770:  [<080a0f4a>] __do_IRQ+0x9a/0xe0
082b77a0:  [<08060570>] do_IRQ+0x30/0x40
082b77b0:  [<08063d83>] timer_irq+0x113/0x170
082b77e0:  [<080641a8>] timer_handler+0x48/0x50
082b7800:  [<08078d59>] sig_handler_common_skas+0xa9/0x100
082b7830:  [<080747eb>] real_alarm_handler+0x3b/0x60
082b7850:  [<08074857>] alarm_handler+0x47/0x60
082b7870:  [<ffffe420>] _etext+0xf7da0405/0x0
082b7b70:  [<08062356>] default_idle+0x56/0x60
082b7b90:  [<080660a8>] init_idle_skas+0x28/0x30
082b7ba0:  [<0806236b>] cpu_idle+0xb/0x10
082b7bb0:  [<0805f2db>] rest_init+0x2b/0x30
082b7bd0:  [<08049643>] start_kernel+0x173/0x1b0
082b7bf0:  [<080660dc>] start_kernel_proc+0x2c/0x40
082b7c00:  [<0807408c>] run_kernel_thread+0x5c/0x60
082b7ce0:  [<08065dea>] new_thread_handler+0xba/0x110
082b7d20:  [<ffffe420>] _etext+0xf7da0405/0x0


Program received signal SIGSEGV, Segmentation fault.
0x080668ad in copy_chunk_from_user (from=3D196263936, len=3D4096, arg=3D0xb=
b3bad4) at string.h:199
199     string.h: No such file or directory.
        in string.h
(gdb) bt
#0  0x080668ad in copy_chunk_from_user (from=3D196263936, len=3D4096, arg=
=3D0xbb3bad4) at string.h:199
#1  0x080666d4 in do_op (addr=3D196263936, len=3D4096, is_write=3D4096, op=
=3D0x8066890 <copy_chunk_from_user>, arg=3D0x1000)
    at arch/um/kernel/skas/uaccess.c:54
#2  0x080667f8 in do_buffer_op (jmpbuf=3D0x1000, arg_ptr=3D0x1000) at arch/=
um/kernel/skas/uaccess.c:95
#3  0x08076aef in setjmp_wrapper (proc=3D0x80666e0 <do_buffer_op>) at arch/=
um/os-Linux/util.c:111
#4  0x08066862 in buffer_op (addr=3D1075109888, len=3D6102308, is_write=3D4=
096, op=3D0x1000, arg=3D0x1000)
    at arch/um/kernel/skas/uaccess.c:123
#5  0x08066935 in copy_from_user_skas (to=3D0xc816000, from=3D0x4014e000, n=
=3D196328148) at arch/um/kernel/skas/uaccess.c:147
#6  0x0809e32f in load_module (umod=3D0x1000, len=3D6102308, uargs=3D0x8050=
a20 "\211\004$=E8=DC=E0") at um_uaccess.h:32
#7  0x0809ed85 in sys_init_module (umod=3D0x1000, len=3D4096, uargs=3D0x100=
0 <Address 0x1000 out of bounds>) at kernel/module.c:1868
#8  0x080662fa in execute_syscall_skas (r=3D0x5d1d24) at arch/um/kernel/ska=
s/syscall_kern.c:29
#9  0x08066322 in handle_syscall (regs=3D0xbd0e808) at arch/um/kernel/skas/=
syscall_kern.c:44
#10 0x08077e4a in handle_trap (pid=3D19465, regs=3D0xbd0e808, local_using_s=
ysemu=3D2) at arch/um/os-Linux/skas/process.c:134
#11 0x080784d2 in userspace (regs=3D0xbd0e808) at arch/um/os-Linux/skas/pro=
cess.c:276
#12 0x08065e0c in new_thread_handler (sig=3D10) at thread_info.h:47
#13 <signal handler called>
#14 0xb7ed9ab1 in kill () from /lib/tls/libc.so.6
#15 0x08073c6a in os_usr1_process (pid=3D0) at arch/um/os-Linux/process.c:1=
18
#16 0x08074bf1 in set_signals (enable=3D196310340) at arch/um/os-Linux/sign=
al.c:263
#17 0x08078930 in new_thread (stack=3D0xbb38000, switch_buf_ptr=3D0x0, fork=
_buf_ptr=3D0x0, handler=3D0x8065d30 <new_thread_handler>)
    at arch/um/os-Linux/skas/process.c:446
#18 0x08065fc0 in copy_thread_skas (nr=3D0, clone_flags=3D8388881, sp=3D196=
310340, stack_top=3D0, p=3D0xbd0e640, regs=3D0x0)
    at arch/um/kernel/skas/process_kern.c:125
#19 0x0806227b in copy_thread (nr=3D0, clone_flags=3D0, sp=3D0, stack_top=
=3D0, p=3D0xbb37544, regs=3D0x0) at arch/um/kernel/process_kern.c:149
#20 0x0bb34000 in ?? ()
#21 0x083da2c0 in ?? ()
#22 0x0bd0e0a0 in ?? ()
#23 0x0bb37a4c in ?? ()
#24 0x08062138 in _switch_to (prev=3D0x0, next=3D0x0, last=3D0xbd0e0a0) at =
arch/um/kernel/process_kern.c:114
#25 0x0825b191 in schedule () at kernel/sched.c:1642
#26 0x0808522c in do_wait (pid=3D899, options=3D4, infop=3D0x0, stat_addr=
=3D0xbdd3a2c, ru=3D0x0) at kernel/exit.c:1456
#27 0x0808579c in sys_wait4 (pid=3D0, stat_addr=3D0x0, options=3D196310340,=
 ru=3D0x0) at kernel/exit.c:1532
#28 0x080938b7 in wait_for_helper (data=3D0xbdd3a14) at kernel/kmod.c:189
#29 0x0807408c in run_kernel_thread (fn=3D0x8093830 <wait_for_helper>, arg=
=3D0xbdd3a14, jmp_ptr=3D0x0) at arch/um/os-Linux/process.c:215
#30 0x08065dea in new_thread_handler (sig=3D10) at thread_info.h:47
#31 <signal handler called>
#32 0xb7ed9ab1 in kill () from /lib/tls/libc.so.6
#33 0x08073c6a in os_usr1_process (pid=3D0) at arch/um/os-Linux/process.c:1=
18
#34 0x08074bf1 in set_signals (enable=3D144077940) at arch/um/os-Linux/sign=
al.c:263
#35 0x08078930 in new_thread (stack=3D0xbb34000, switch_buf_ptr=3D0x0, fork=
_buf_ptr=3D0x0, handler=3D0x8065d30 <new_thread_handler>)
    at arch/um/os-Linux/skas/process.c:446
#36 0x08065fc0 in copy_thread_skas (nr=3D0, clone_flags=3D8390417, sp=3D144=
077940, stack_top=3D0, p=3D0xbd0e0a0, regs=3D0x0)
    at arch/um/kernel/skas/process_kern.c:125
#37 0x0806227b in copy_thread (nr=3D0, clone_flags=3D0, sp=3D0, stack_top=
=3D0, p=3D0x8967474, regs=3D0x0) at arch/um/kernel/process_kern.c:149
#38 0xb7ed95fa in siglongjmp () from /lib/tls/libc.so.6
#39 0x08078a24 in switch_threads (me=3D0x0, next=3D0xbb37c24) at arch/um/os=
-Linux/skas/process.c:467
#40 0x08065cdf in switch_to_skas (prev=3D0x8940040, next=3D0xbd0e0a0) at ar=
ch/um/kernel/skas/process_kern.c:38
---Type <return> to continue, or q <return> to quit---
#41 0x08062138 in _switch_to (prev=3D0x0, next=3D0x0, last=3D0x8940040) at =
arch/um/kernel/process_kern.c:114
#42 0x0825b191 in schedule () at kernel/sched.c:1642
#43 0x08093e2c in worker_thread (__cwq=3D0x892c6e0) at kernel/workqueue.c:2=
08
#44 0x080981b9 in kthread (_create=3D0x8947b24) at kernel/kthread.c:95
#45 0x0807408c in run_kernel_thread (fn=3D0x8098100 <kthread>, arg=3D0x8947=
b24, jmp_ptr=3D0x0) at arch/um/os-Linux/process.c:215
#46 0x08065dea in new_thread_handler (sig=3D10) at thread_info.h:47
#47 <signal handler called>
#48 0xb7ed9ab1 in kill () from /lib/tls/libc.so.6
#49 0x00000000 in ?? ()
#50 0x00000000 in ?? ()
#51 0x00000000 in ?? ()
#52 0x00000000 in ?? ()
#53 0x00000000 in ?? ()
#54 0x00000000 in ?? ()
#55 0x00000000 in ?? ()
#56 0x00000000 in ?? ()
#57 0x00000000 in ?? ()
#58 0x08065e80 in release_thread_skas () at arch/um/kernel/skas/process_ker=
n.c:83
Previous frame inner to this frame (corrupt stack?)


Tony


>>> "Anthony Brock" <Anthony_Brock@ous.edu> 06/16/05 03:36PM >>>
Okay, two items of interest:

First, both instances are running the "rngd" daemon for random support. How=
ever, this daemon seems to be consuming between 8-15% of the CPU time on a =
consistent basis. Even after running for 20-30 minutes, the daemon is till =
busy.

Second, I'm once again enountering problems with launch the UML instance. I=
t likes to hang at:


Checking that ptrace can change system call numbers...OK
Checking syscall emulation patch for ptrace...OK
Checking advanced syscall emulation patch for ptrace...OK
Checking if syscall restart handling in host can be skipped...OK
Checking for the skas3 patch in the host:
  - /proc/mm...found
  - PTRACE_FAULTINFO...found
  - PTRACE_LDT...found
Checking PROT_EXEC mmap in /tmp...OK


I'll see if I can get a backtrace on this...

Tony


>>> Jeff Dike <jdike@addtoit.com> 06/16/05 03:13PM >>>
On Thu, Jun 16, 2005 at 02:26:13PM -0700, Anthony Brock wrote:
> Well, so far this seems to be running fine. However, I'm still
> seeing the load average >=3D 1 issue. This is a 2.6.12-rc6-mm1 host with
> your patches from this morning running on a 2.6.11.7-skas3-v8 custom
> built host kernel.=20

OK, thanks for letting me know.

				Jeff


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick =

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net=20
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel=20



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id492&op=3Dclick=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net=20
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_idt77&alloc_id=16492&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
