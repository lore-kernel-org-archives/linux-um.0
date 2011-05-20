Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Date: Fri, 20 May 2011 09:43:09 +0200
References: <201105191526.31904.toralf.foerster@gmx.de> <201105191834.56577.toralf.foerster@gmx.de> <BANLkTi=8NW9Q+8Q=kuUJY1L=FcQGapqDLA@mail.gmail.com>
In-Reply-To: <BANLkTi=8NW9Q+8Q=kuUJY1L=FcQGapqDLA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Message-Id: <201105200943.10228.toralf.foerster@gmx.de>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: kernel 2.6.39 (user mode linux) crashes (2.6.38 works fine)
To: richard -rw- weinberger <richard.weinberger@gmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


richard -rw- weinberger wrote at 08:44:39
> > * Starting local
>=20
> What is this "Starting local",
> was UML crashing while starting your distro?
No, that the last init script of the Gentoo, I'm using within UML.

> I fear the backtrace is garbage.
yep, maybe this helps more :=20

Program received signal SIGSEGV, Segmentation fault.
0x080a9f6b in futex_wake (uaddr=3D<value optimized out>, flags=3D<value=
 optimized out>, nr_wake=3D<value optimized out>,=20
    bitset=3D4294967295) at kernel/futex.c:958
958             plist_for_each_entry_safe(this, next, head, list) {
(gdb) bt
#0  0x080a9f6b in futex_wake (uaddr=3D<value optimized out>, flags=3D<v=
alue optimized out>, nr_wake=3D<value optimized out>,=20
    bitset=3D4294967295) at kernel/futex.c:958
#1  0x080abb1d in do_futex (uaddr=3D0x81efe10, op=3D0, val=3D0, timeout=
=3D0x0, uaddr2=3D0x81efe0c, val2=3D0, val3=3D4294967295)
    at kernel/futex.c:2610
#2  0x080ac184 in sys_futex (uaddr=3D0x81efe10, op=3D129, val=3D1, utim=
e=3D0x83f89b8, uaddr2=3D0x81efe0c, val3=3D134908072)
    at kernel/futex.c:2678
#3  0x08060d16 in handle_syscall (r=3D0x19545290) at arch/um/kernel/ska=
s/syscall.c:35
#4  0x08074cf1 in handle_trap (regs=3D0x19545290) at arch/um/os-Linux/s=
kas/process.c:201
#5  userspace (regs=3D0x19545290) at arch/um/os-Linux/skas/process.c:41=
7
#6  0x0805e0cb in fork_handler () at arch/um/kernel/process.c:181
#7  0x00000000 in ?? ()

>=20
> Can you reproduce the issue using the default config?
yes

> Are you using hostfs?
Yes, but the issue is independend from that.


--=20
MfG/Sincerely
Toralf F=F6rster
pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

