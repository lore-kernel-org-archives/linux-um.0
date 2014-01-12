Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1W2UL9-0001Dx-0f
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jan 2014 23:21:11 +0000
Received: from mail-we0-f181.google.com ([74.125.82.181])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1W2UL7-0001em-Ic
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jan 2014 23:21:10 +0000
Received: by mail-we0-f181.google.com with SMTP id u56so3611176wes.40
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 Jan 2014 15:21:03 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <52D12125.9060001@gmx.de>
References: <52D12125.9060001@gmx.de>
Date: Mon, 13 Jan 2014 00:21:03 +0100
Message-ID: <CAFLxGvwrbAm5mRkje+TFgpr1Q+UoBEZQxmTaxvwv+6-GwGpMbA@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] negative pid -516 possible ?
To: =?ISO-8859-1?Q?Toralf_F=F6rster?= <toralf.foerster@gmx.de>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>

On Sat, Jan 11, 2014 at 11:47 AM, Toralf F=F6rster <toralf.foerster@gmx.de>=
 wrote:
> -----BEGIN PGP SIGNED MESSAGE-----
> Hash: SHA256
>
> I do fuzz testing with trinity (latest git version) a stable 32 bit Gento=
o Linux user mode linux image.
> The host is a stable 32 bit vanilla 3.12.7 kernel, the guest runs latest =
git tree + 2 patches (attached).
>
> The trinity call in the UML guest is :
> $> trinity -q -l off -N 10000 -C 2 -x move_pages -x mremap -v /mnt/ramdisk
>
> After a while there's no progress on the command line seen at the host sy=
stem - the trinity process seems to just hangs/idling. When this does occur=
 I cannot longer ssh into the system. The system however runs furthermore. =
In another terminal I still see the output of this command:

Does it consume 100% CPU?

> $> ssh root@trinity "tail -f /var/log/messages"
>
> That's why I do know that the system does not hang completely. The output=
 of top at the host system gives me the pid of the linux exe. A gdb call gi=
ves for that pid :
>
> $ date; sudo gdb /home/tfoerste/devel/linux/linux 25224 -n -batch -ex 'bt=
 full'
> Sat Jan 11 11:36:47 CET 2014
>
> warning: Could not load shared library symbols for linux-gate.so.1.
> Do you need "set solib-search-path" or "set sysroot"?
> 0xb7800424 in __kernel_vsyscall ()
> #0  0xb7800424 in __kernel_vsyscall ()
> No symbol table info available.
> #1  0x083d63ff in __nanosleep_nocancel ()
> No symbol table info available.
> #2  0x0807266c in idle_sleep (nsecs=3D602496380195307520) at arch/um/os-L=
inux/time.c:183
>         ts =3D {tv_sec =3D 0, tv_nsec =3D 8436602}
> #3  0x0805fc0f in arch_cpu_idle () at arch/um/kernel/process.c:208
> No locals.
> #4  0x080a8971 in cpu_idle_loop () at kernel/cpu/idle.c:98
> No locals.
> #5  cpu_startup_entry (state=3DCPUHP_ONLINE) at kernel/cpu/idle.c:140
> No locals.
> #6  0x084215e9 in rest_init () at init/main.c:402
>         pid =3D -516
>         __func__ =3D "rest_init"
> #7  0x080487e1 in start_kernel () at init/main.c:656
>         command_line =3D 0x85b8400 <command_line> "earlyprintk ubda=3D/ho=
me/tfoerste/virtual/uml/trinity ubdb=3D/mnt/ramdisk/trinity_swap eth0=3Dtun=
tap,tap0,72:ef:3d:9f:c3:5a mem=3D1025M con0=3Dfd:0,fd:1 con=3Dpts rootfstyp=
e=3Dext4  root=3D98:0"
> #8  0x08049e42 in start_kernel_proc (unused=3D0x0) at arch/um/kernel/skas=
/process.c:48
>         pid =3D -516
>         __func__ =3D "start_kernel_proc"
> #9  0x0805f7cb in new_thread_handler () at arch/um/kernel/process.c:129
>         fn =3D 0x0
> #10 0x00000000 in ?? ()
> No symbol table info available.
>
>
>
> Please note that BUG_ON was not triggered. For completeness here are the =
gdb traces from all linux processes currently running at the host:

So let's forget the 516 issue for now.
What we no for now is that you manage to trigger a lockup within UML.


>
> $ pgrep linux | xargs -n1 -I {} sudo gdb /home/tfoerste/devel/linux/linux=
 {} -n -batch -ex 'bt'
> warning: process 1613 is already traced by process 25224
> ptrace: Operation not permitted.
> /home/tfoerste/1613: No such file or directory.
> No stack.
> warning: process 21849 is already traced by process 25224
> ptrace: Operation not permitted.
> /home/tfoerste/21849: No such file or directory.
> No stack.
>
> warning: Could not load shared library symbols for linux-gate.so.1.
> Do you need "set solib-search-path" or "set sysroot"?
> 0xb7800424 in __kernel_vsyscall ()
> #0  0xb7800424 in __kernel_vsyscall ()
> #1  0x083d63ff in __nanosleep_nocancel ()
> #2  0x0807266c in idle_sleep (nsecs=3D602496380205307520) at arch/um/os-L=
inux/time.c:183
> #3  0x0805fc0f in arch_cpu_idle () at arch/um/kernel/process.c:208
> #4  0x080a8971 in cpu_idle_loop () at kernel/cpu/idle.c:98
> #5  cpu_startup_entry (state=3DCPUHP_ONLINE) at kernel/cpu/idle.c:140
> #6  0x084215e9 in rest_init () at init/main.c:402
> #7  0x080487e1 in start_kernel () at init/main.c:656
> #8  0x08049e42 in start_kernel_proc (unused=3D0x0) at arch/um/kernel/skas=
/process.c:48
> #9  0x0805f7cb in new_thread_handler () at arch/um/kernel/process.c:129
> #10 0x00000000 in ?? ()
>
> warning: process 25231 is a cloned process
>
> warning: Could not load shared library symbols for linux-gate.so.1.
> Do you need "set solib-search-path" or "set sysroot"?
> 0xb7800424 in __kernel_vsyscall ()
> #0  0xb7800424 in __kernel_vsyscall ()
> #1  0x083da446 in syscall ()
> #2  0x0806e861 in io_getevents (events=3D<optimized out>, ctx_id=3D<optim=
ized out>, min_nr=3D<optimized out>, nr=3D<optimized out>, timeout=3D<optim=
ized out>) at arch/um/os-Linux/aio.c:49
> #3  aio_thread (arg=3D0x0) at arch/um/os-Linux/aio.c:109
> #4  0x083db56e in clone ()
>
> warning: process 25232 is a cloned process
>
> warning: Could not load shared library symbols for linux-gate.so.1.
> Do you need "set solib-search-path" or "set sysroot"?
> 0xb7800424 in __kernel_vsyscall ()
> #0  0xb7800424 in __kernel_vsyscall ()
> #1  0x083d82c2 in __read_nocancel ()
> #2  0x0806f3ff in read (__nbytes=3D<optimized out>, __buf=3D<optimized ou=
t>, __fd=3D<optimized out>) at /usr/include/bits/unistd.h:44
> #3  os_read_file (fd=3D-512, buf=3D0xfffffe00, len=3D-512) at arch/um/os-=
Linux/file.c:253
> #4  0x0806bafc in io_thread (arg=3D0x0) at arch/um/drivers/ubd_kern.c:1482
> #5  0x083db56e in clone ()
>
> warning: process 25233 is a cloned process
>
> warning: Could not load shared library symbols for linux-gate.so.1.
> Do you need "set solib-search-path" or "set sysroot"?
> 0xb7800424 in __kernel_vsyscall ()
> #0  0xb7800424 in __kernel_vsyscall ()
> #1  0x083d9132 in __poll_nocancel ()
> #2  0x08071114 in poll (__timeout=3D<optimized out>, __nfds=3D<optimized =
out>, __fds=3D<optimized out>) at /usr/include/bits/poll2.h:46
> #3  write_sigio_thread (unused=3D0x0) at arch/um/os-Linux/sigio.c:61
> #4  0x083db56e in clone ()
> warning: process 25234 is a zombie - the process has already terminated
> ptrace: Operation not permitted.
> /home/tfoerste/25234: No such file or directory.
> No stack.
> ...
>
>
> Please Cc: me I'm not subscribed.

Wouldn't it make sense to subscribe?
You post very often on this list. :)

>
>
> - --
> MfG/Sincerely
> Toralf F=F6rster
> pgp finger print:1A37 6F99 4A9D 026F 13E2 4DCF C4EA CDDE 0076 E94E
> -----BEGIN PGP SIGNATURE-----
> Version: GnuPG v2.0.22 (GNU/Linux)
> Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/
>
> iF4EAREIAAYFAlLRISQACgkQxOrN3gB26U54pwD9Eq49Oog5KpSC4+e19t4HG6LA
> 5d3Oz4/qq98wCb+rF9UA/0j+fT4xjdHbYmLtc8Z0wctVO3DjdQG49/+n81s/gLx3
> =3DeP08
> -----END PGP SIGNATURE-----
>
> -------------------------------------------------------------------------=
-----
> CenturyLink Cloud: The Leader in Enterprise Cloud Services.
> Learn Why More Businesses Are Choosing CenturyLink Cloud For
> Critical Workloads, Development Environments & Everything In Between.
> Get a Quote or Start a Free Trial Today.
> http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431&iu=3D/4140/ostg=
.clktrk
> _______________________________________________
> User-mode-linux-devel mailing list
> User-mode-linux-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
>



-- =

Thanks,
//richard

---------------------------------------------------------------------------=
---
CenturyLink Cloud: The Leader in Enterprise Cloud Services.
Learn Why More Businesses Are Choosing CenturyLink Cloud For
Critical Workloads, Development Environments & Everything In Between.
Get a Quote or Start a Free Trial Today.
http://pubads.g.doubleclick.net/gampad/clk?id=3D119420431&iu=3D/4140/ostg.c=
lktrk
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

