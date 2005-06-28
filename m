Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DnHDO-0006v0-3n	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jun 2005 07:37:30 -0700
Received: from imap.gmx.net ([213.165.64.20] helo=mail.gmx.net)
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.41)
	id 1DnHDN-0006Xu-CI	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 28 Jun 2005 07:37:30 -0700
From: "Dominik Vogt" <dominik.vogt@gmx.de>
MIME-Version: 1.0
Message-ID: <6028.1119969442@www81.gmx.net>
Content-Type: text/plain; charset="iso-8859-1"
Subject: [uml-devel] =?ISO-8859-1?Q?Kernel_panic_in_dump_fpu_with_2.6.11.11?=
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
Date: Tue, 28 Jun 2005 16:37:22 +0200 (MEST)
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: dominik.vogt@gmx.de

When I run a certain mulithreaded application in a virtual
machine, I get a UML kernel panic.  The host and the VM are both
running Debian-3.1r0a (sarge) on i386.  The application gets a
SIGSEGV after a couple of seconds and generates a core dump.  In
this process, the UML kernel panics un the dump_fpu() function at
position 0x61 with a NULL pointer reference:

  C: (ptrace.c, line 333, inline function copy_fpu_fxsave_tt)
  struct i387_fxsave_struct *fpu =3D SC_FXSR_ENV(PT_REGS_SC(regs));

  assembler: (eax being 0)
  0xa0031b4d <dump_fpu+61>:       mov    0x4(%eax),%eax

I can prevent the kernel panic by commenting out the line

  copy_fpu_fxsave(regs, (struct user_i387_struct *) fpu);

in dump_fpu(), so that copy_fpu_fxsave_tt() is never called.  The
application always coredumps in

  /lib/tls/libc.so.6(__clone+0x5a)[0x4026118a]

which I guess is part of the threading library in libc.  This
crash is 100% reproducable.

--

Kernel panic - not syncing: Kernel mode fault at addr 0x4, ip 0xa0031b4d

EIP: 0073:[<a0031b4d>] CPU: 0 Not tainted ESP: 007b:a7b47764 EFLAGS:
00010202
    Not tainted
EAX: 00000000 EBX: a61b4728 ECX: 00000001 EDX: 0000001c
ESI: a61b4728 EDI: 00000007 EBP: a7b4777c DS: 007b ES: 007b
Call Trace:
a7b472d8:  [<a0056a4d>] notifier_call_chain+0x2d/0x50
a7b472f8:  [<a003b742>] panic+0x72/0x120
a7b4730c:  [<a0031b4d>] dump_fpu+0x3d/0x80
a7b47318:  [<a0019831>] segv+0x241/0x280
a7b47324:  [<a0031b4d>] dump_fpu+0x3d/0x80
a7b47338:  [<a00189e3>] timer_irq+0x113/0x170
a7b47388:  [<a0017432>] change_signals+0x62/0x90
a7b47408:  [<a0019d75>] segv_handler+0x175/0x230
a7b47410:  [<a0031b4d>] dump_fpu+0x3d/0x80
a7b47438:  [<a001de11>] sig_handler_common_tt+0x91/0x110
a7b47478:  [<a002fbb2>] sig_handler+0x22/0x40
a7b47488:  [<a01b1fb8>] __restore+0x0/0x8
a7b474c8:  [<a0031b4d>] dump_fpu+0x3d/0x80
a7b474f0:  [<a00c1b58>] inode_init_once+0xc8/0x210
a7b47520:  [<a0114bfb>] hostfs_alloc_inode+0x9b/0xb0
a7b47530:  [<a00c1b58>] inode_init_once+0xc8/0x210
a7b4763c:  [<a01c8ec4>] ___lxstat64+0x24/0xf0
a7b47650:  [<a00175e1>] set_signals+0x81/0x130
a7b4766c:  [<a01b20e4>] sigemptyset+0x24/0x40
a7b47680:  [<a00175e1>] set_signals+0x81/0x130
a7b47690:  [<a00174f0>] enable_mask+0x50/0x70
a7b476ac:  [<a01b20e4>] sigemptyset+0x24/0x40
a7b476c0:  [<a00175e1>] set_signals+0x81/0x130
a7b476d0:  [<a0017432>] change_signals+0x62/0x90
a7b47720:  [<a0076edd>] check_poison_obj+0x2d/0x1e0
a7b47730:  [<a0076837>] dbg_redzone1+0x17/0x50
a7b47750:  [<a007905f>] cache_alloc_debugcheck_after+0x3f/0x170
a7b47780:  [<a00db1f3>] elf_dump_thread_status+0x83/0xe0
a7b477b0:  [<a00db424>] elf_core_dump+0x1d4/0xef0
a7b47830:  [<a0037de5>] __might_sleep+0xc5/0xe0
a7b47850:  [<a00c559e>] notify_change+0x15e/0x240
a7b478f0:  [<a00ad59e>] do_coredump+0x45e/0x610
a7b47900:  [<a00175e1>] set_signals+0x81/0x130
a7b47970:  [<a0017432>] change_signals+0x62/0x90
a7b47a20:  [<a0052a04>] get_signal_to_deliver+0x7c4/0xd10
a7b47a50:  [<a0017492>] unblock_signals+0x12/0x20
a7b47a60:  [<a0035c49>] finish_task_switch+0x79/0x100
a7b47a7c:  [<a01b20e4>] sigemptyset+0x24/0x40
a7b47a90:  [<a00175e1>] set_signals+0x81/0x130
a7b47aac:  [<a01b20e4>] sigemptyset+0x24/0x40
a7b47ac0:  [<a00175e1>] set_signals+0x81/0x130
a7b47ba0:  [<a0016806>] kern_do_signal+0x36/0x1f0
a7b47bbc:  [<a00365b0>] default_wake_function+0x0/0x20
a7b47bf8:  [<a0135430>] write_chan+0x0/0x250
a7b47c00:  [<a0016834>] kern_do_signal+0x64/0x1f0
a7b47c20:  [<a009b235>] vfs_writev+0x55/0x60
a7b47c40:  [<a009b397>] sys_writev+0xa7/0xb0
a7b47ca0:  [<a00169f7>] do_signal+0x37/0x40
a7b47cb0:  [<a001c932>] syscall_handler_tt+0x62/0x90
a7b47cc0:  [<a0014058>] interrupt_end+0x38/0x50
a7b47cd0:  [<a001de55>] sig_handler_common_tt+0xd5/0x110
a7b47d10:  [<a002fbb2>] sig_handler+0x22/0x40
a7b47d20:  [<a01b1fb8>] __restore+0x0/0x8

--

(gdb) bt
#0  panic (
    fmt=3D0xa0031b4d "\213@\004\213XL\2114$\203=C6\034\215Cp\211T$\b\201=C3=
\220")
    at kernel/panic.c:67
#1  0xa0019831 in segv (address=3D4, ip=3D2684558157, is_write=3D0, is_user=
=3D0,
    sc=3D0xa0031b4d) at arch/um/kernel/trap_kern.c:166
#2  0xa0019d75 in segv_handler (sig=3D11, regs=3D0xa7eb2294)
    at arch/um/kernel/trap_user.c:73
#3  0xa001de11 in sig_handler_common_tt (sig=3D11, sc_ptr=3D0xa71bb490)
    at arch/um/kernel/tt/trap_user.c:42
#4  0xa002fbb2 in sig_handler (sig=3D11) at arch/um/os-Linux/signal.c:16
#5  <signal handler called>
#6  dump_fpu (regs=3D0x0, fpu=3D0xa61a4728) at arch/um/sys-i386/ptrace.c:333
#7  0xa00db1f3 in elf_dump_thread_status (signr=3D0, t=3D0xa61a4690)
    at elfcore.h:115
#8  0xa00db424 in elf_core_dump (signr=3D11, regs=3D0xa7eb2294, file=3D0xa5=
dc8418)
    at fs/binfmt_elf.c:1453
#9  0xa00ad59e in do_coredump (signr=3D11, exit_code=3D0, regs=3D0x0)
    at fs/exec.c:1486
#10 0xa0052a04 in get_signal_to_deliver (info=3D0xa71bbbe4,
    return_ka=3D0xa71bbc64, regs=3D0xa7eb2294, cookie=3D0x0) at
kernel/signal.c:1935
#11 0xa0016806 in kern_do_signal (regs=3D0xa7eb2294, oldset=3D0xa7eb25d4)
    at arch/um/kernel/signal_kern.c:113
#12 0xa00169f7 in do_signal () at thread_info.h:46
#13 0xa0014058 in interrupt_end () at arch/um/kernel/process_kern.c:144
#14 0xa001de55 in sig_handler_common_tt (sig=3D12, sc_ptr=3D0xa71bbd28)
    at arch/um/kernel/tt/trap_user.c:45
#15 0xa002fbb2 in sig_handler (sig=3D12) at arch/um/os-Linux/signal.c:16
#16 <signal handler called>
#17 0x40261679 in ?? ()

... (14000 lines of trash)

(gdb) i line *2684558157
Line 333 of "arch/um/sys-i386/ptrace.c"
   starts at address 0xa0031b4d <dump_fpu+61>
   and ends at 0xa0031b53 <dump_fpu+67>.

--

Ciao

Dominik ^_^  ^_^

--=20
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse f=FCr Mail, Message, More +++


-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=3D7477&alloc_id=3D16492&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
