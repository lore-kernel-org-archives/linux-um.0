Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7OYd-0000wj-Kc for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 16:53:47 -0800
Received: from hoth.xs4all.nl ([213.84.241.98] helo=seven.hoth.xs4all.nl)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1B7OYb-0006Ht-J6 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 27 Mar 2004 16:53:45 -0800
Message-ID: <33123.192.168.1.9.1080435284.squirrel@hoth.xs4all.nl>
Subject: Re: [uml-devel] Kernel panic on UML linux
From: "Mark Hurenkamp" <Mark.Hurenkamp@xs4all.nl>
In-Reply-To: <Pine.LNX.4.44.0403271255200.19645-100000@filer.marasystems.com>
References: <200403271230.45025.mark.hurenkamp@xs4all.nl>
	<Pine.LNX.4.44.0403271255200.19645-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
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
Date: Sun, 28 Mar 2004 01:54:44 +0100 (CET)
Content-Transfer-Encoding: quoted-printable
To: hno@marasystems.com
Cc: jdike@addtoit.com, user-mode-linux-devel@lists.sourceforge.net

> I have found that GDB in some case works better if I attach to the kernel
> separately, not starting the kernel from within GDB. At least on Fedora
> Core 2 test 1.. the GDB version used there seems to have very many
> problems, not only with UML. Maybe this also applies to your system?
Could be, I don't use gdb often enough to notice...
I'm using version 6.0 on a Gentoo distro.

> To gain some time to attach the debugger you can boot the guest in
> "failsafe" mode by using init=3D/bin/sh. Then when you have attached the
> debugger, configured signals, set breakpoints etc allow the guest to
> continue the boot by running
>
>    exec /sbin/init
>
> from the guest console.

Thanks for the tip, this seems to work great :-)

So here's the stacktrace of the panic:

Breakpoint 1, panic (fmt=3D0x400e9df8 <Address 0x400e9df8 out of bounds>) at
panic.c:5858 =A0 =A0 =A0 =A0 =A0 =A0 =A0machine_paniced =3D 1;
(gdb) bt
#0 =A0panic (fmt=3D0x400e9df8 <Address 0x400e9df8 out of bounds>) at panic.=
c:58
#1 =A00xa00c8932 in segv (address=3D1218387968, ip=3D1074699768, is_write=
=3D0,
is_user=3D0, sc=3D0x400e9df8) at trap_kern.c:149#2 =A00xa00c8d65 in segv_ha=
ndler (sig=3D11, regs=3D0xa70d0274) at trap_user.c:67
#3 =A00xa00d0674 in sig_handler_common_skas (sig=3D11, sc_ptr=3D0x58) at
trap_user.c:35#4 =A00xa00c8e75 in sig_handler (sig=3D0, sc=3D
=A0 =A0 =A0 {gs =3D 0, __gsh =3D 0, fs =3D 0, __fsh =3D 0, es =3D 123, __es=
h =3D 0, ds =3D
123, __dsh =3D 0, edi =3D 2808081524, esi =3D 1218387968, ebp =3D 280266214=
0, esp
=3D 2802662132, ebx =3D 2808081524, edx =3D 2802662280, ecx =3D 24, eax =3D=
 96,
trapno =3D 14, err =3D 4, eip =3D 2685209117, cs =3D 115, __csh =3D 0, efla=
gs =3D
2163222, esp_at_signal =3D 2802662132, ss =3D 123, __ssh =3D 0, fpstate =3D=
 0x0,
oldmask =3D 0, cr2 =3D 1218387968}) at trap_user.c:103#5 =A0<signal handler=
 called>
#6 =A00xa00d0a1d in copy_chunk_to_user (to=3D2808081524, len=3D96,
arg=3D0xa70d3b88) at string.h:202#7 =A00xa00d080d in do_op (addr=3D28080815=
24, len=3D96, is_write=3D96,
op=3D0xa00d0a00 <copy_chunk_to_user>, arg=3D0x60) at uaccess.c:46#8 =A00xa0=
0d0867 in buffer_op (addr=3D134671476, len=3D-1492305016, is_write=3D1,
op=3D0xa00d0a00 <copy_chunk_to_user>, arg=3D0xa70d3b88) at uaccess.c:59#9 =
=A00xa00d0aa4 in copy_to_user_skas (to=3D0x806ec74, from=3D0x489f2000,
n=3D-1492305016) at uaccess.c:122#10 0xa00d4974 in read_kmem (file=3D0xa70c=
25a0, buf=3D0x806ec74 <Address
0x806ec74 out of bounds>, count=3D96, ppos=3D0xa70c25c0) at mem.c:264#11 0x=
a0038d75 in sys_read (fd=3D96, buf=3D0x60 <Address 0x60 out of bounds>,
count=3D96) at read_write.c:177#12 0xa00d00a2 in execute_syscall_skas (r=3D=
0x806ec74) at syscall_kern.c:28
#13 0xa00d0124 in handle_syscall (regs=3D0xa70d0274) at syscall_user.c:26
#14 0xa00cefca in handle_trap (pid=3D1407, regs=3D0xa70d0274) at process.c:=
85
#15 0xa00cf303 in userspace (regs=3D0xa70d0274) at process.c:160
#16 0xa00cfca4 in fork_handler (sig=3D10) at process_kern.c:102
#17 <signal handler called>
#18 0xa01532f1 in kill () at string.h:486
#19 0xa00d440a in os_usr1_process (pid=3D0) at process.c:95
#20 0xa00cf3b2 in new_thread (stack=3D0xa771f794, switch_buf_ptr=3D0x0,
fork_buf_ptr=3D0x0, handler=3D0xa771f794) at process.c:199#21 0xa00c6320 in=
 enable_mask (mask=3D0x0) at signal_user.c:92
#22 0xa00c6411 in set_signals (enable=3D0) at signal_user.c:127
(gdb)





-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dclick
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
