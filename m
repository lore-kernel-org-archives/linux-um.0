Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1B42v4-0002eW-Cr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 11:11:06 -0800
Received: from smtp004.mail.ukl.yahoo.com ([217.12.11.35])
	by sc8-sf-mx2.sourceforge.net with smtp (Exim 4.30)
	id 1B42v2-0008DZ-7w for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 18 Mar 2004 11:11:04 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
Subject: Re: [uml-devel] /dev/kmem panic in SKAS mode
References: <Pine.LNX.4.44.0403161053200.23697-100000@filer.marasystems.com>
In-Reply-To: <Pine.LNX.4.44.0403161053200.23697-100000@filer.marasystems.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Message-Id: <200403182017.52188.blaisorblade_spam@yahoo.it>
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
Date: Thu, 18 Mar 2004 20:17:52 +0100
Content-Transfer-Encoding: quoted-printable
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Henrik Nordstrom <hno@marasystems.com>

Alle 11:38, marted=EC 16 marzo 2004, Henrik Nordstrom ha scritto:
> There seems to be some kind of vm addressing related issue in SKAS mode.
> This time related to reading of /dev/kmem.

If you are not using 2.6.4, do it and it should disappear. If not, probably=
 he=20
applied the patch we discussed after the release (but I'm almost sure this =
is=20
not the case).

At least, search the archives since I and Jeff discussed it (search for=20
"[PATCH] fix writing into /dev/kmem" and my answers; the patch in the 1st=20
message is wrong).

We understood that copy_from_user should check also for invalid addresses i=
n=20
kernel space (the i386/anything one does this check implicitly, the TT mode=
=20
too). In skas mode he cannot rely on SIGSEGV so it checks pagetables by han=
d,=20
but not for the kernel. In the case below it's copy_to_user that does not=20
check the from address, but it's the same anyway.

Now, to do this, he set fault_catcher for this case so the SIGSEGV for the =

case below will be handled in the same way as for TT.

The problem actually is because to workaround the panic on cat /dev/kmem Je=
ff=20
made that device like /dev/mem; however this was removed when the fix above=
=20
came in.

> The following kernel panic is seen when klogd starts up:
>
> #0  panic (fmt=3D0xa014ce00 "Kernel mode fault at addr 0x%lx, ip 0x%lx") =
at
> panic.c:60
> #1  0xa006fab6 in segv (address=3D1116127232, ip=3D1074706056, is_write=
=3D0,
> is_user=3D0, sc=3D0xa13c8274) at trap_kern.c:149
> #2  0xa006feaa in segv_handler (sig=3D11, regs=3D0xa13c8274) at trap_user=
.c:67
> #3  0xa007615d in sig_handler_common_skas (sig=3D11, sc_ptr=3D0x58) at
> trap_user.c:35
> #4  0xa006ff99 in sig_handler (sig=3D0, sc=3D {gs =3D 0, __gsh =3D 0, fs =
=3D 0, __fsh
> =3D 0, es =3D 123, __esh =3D 0, ds =3D 123, __dsh =3D 0, edi =3D 27054740=
36, esi =3D
> 1116127232, ebp =3D 2705111756, esp =3D 2705111748, ebx =3D 2685835552, e=
dx =3D
> 2705111928, ecx =3D 15, eax =3D 60, trapno =3D 14, err =3D 4, eip =3D 268=
4838993, cs
> =3D 115, __csh =3D 0, eflags =3D 66054, esp_at_signal =3D 2705111748, ss =
=3D 123,
> __ssh =3D 0, fpstate =3D 0x0, oldmask =3D 0, cr2 =3D 1116127232}) at
> trap_user.c:103 #5  <signal handler called>
> #6  0xa0076451 in copy_chunk_to_user (to=3D2705474036, len=3D60,
> arg=3D0xa13cbb78) at string.h:202 #7  0xa00762ca in do_op (addr=3D2705474=
036,
> len=3D60, is_write=3D1, op=3D0xa007643c <copy_chunk_to_user>, arg=3D0xa13=
cbb78) at
> uaccess.c:46 #8  0xa007630d in buffer_op (addr=3D134541812, len=3D-158985=
5368,
> is_write=3D1, op=3D0xa007643c <copy_chunk_to_user>, arg=3D0xa13cbb78) at
> uaccess.c:59 #9  0xa00764b8 in copy_to_user_skas (to=3D0x804f1f4,
> from=3D0x4286c000, n=3D-1589855368) at uaccess.c:122 #10 0xa0079851 in
> read_kmem (file=3D0xa13ae1e4, buf=3D0x804f1f4 <Address 0x804f1f4 out of
> bounds>, count=3D60, ppos=3D0xa13ae204) at mem.c:264 #11 0xa0032d41 in sy=
s_read
> (fd=3D60, buf=3D0x804f1f4 <Address 0x804f1f4 out of bounds>, count=3D60) =
at
> read_write.c:177 #12 0xa0075c63 in execute_syscall_skas (r=3D0xa13cbc3c) =
at
> syscall_kern.c:28 #13 0xa0075cd8 in handle_syscall (regs=3D0xa13c8274) at
> syscall_user.c:26 #14 0xa0074e84 in handle_trap (pid=3D8470, regs=3D0xa13=
c8274)
> at process.c:85 #15 0xa0075140 in userspace (regs=3D0xa13c8274) at
> process.c:160
> #16 0xa00758fa in fork_handler (sig=3D10) at process_kern.c:102
> #17 <signal handler called>
> #18 0xa00ff3ed in syscall () at string.h:486
> Previous frame inner to this frame (corrupt stack?)
>
> (gdb) frame 1
> (gdb) p/x address
> $2 =3D 0x4286c000
>
> (gdb) frame 10
> (gdb) p/x *ppos
> $3 =3D 0xa286c000
>
>
> In TT mode on the same host this problem is not seen.
>
> Host OS: Fedora Core 2 test 1
> Host kernel: Fedora kernel-2.6.3-1.118 + host-skas3-2.6.3-v1.patch
>
>
> Regards
> Henrik
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=3D1470&alloc_id=3D3638&op=3Dcli=
ck
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--=20
Paolo Giarrusso, aka Blaisorblade
Linux registered user n. 292729



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id638&op=CCk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
