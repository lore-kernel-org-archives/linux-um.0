Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [uml-devel] UML hangs with hrtimer test module
Date: Thu, 29 Mar 2018 22:34:46 +0200
Message-ID: <5210954.RitFgLWNVY@blindfold>
In-Reply-To: <CAD=GYpbAfqdEquXWdvHwrxaPQwi8Dyh=j9+6=SpwZ3zqnKSq0Q@mail.gmail.com>
References: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com> <CAMuHMdUVJtweuB1GVhyaiK2ak3AG+oE5JR-D78xJ75ARpcV=jA@mail.gmail.com> <CAD=GYpbAfqdEquXWdvHwrxaPQwi8Dyh=j9+6=SpwZ3zqnKSq0Q@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
To: Joel Fernandes <agnel.joel@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Donnerstag, 29. M=E4rz 2018, 22:20:47 CEST schrieb Joel Fernandes:
> Thanks a lot! I am wondering why the same compiler works when running
> the test for a regular image. Maybe different compiler flags. Anyway
> good to learn this.
>=20
> Also one more slightly OT question, why is UML only doing UP ? Is it
> extremely hard to do SMP for UML?

Long story short, nobody implemented SMP so far. :-)
Because SKAS3/0 we had a SMP implementation of TT mode.

In terms of UML implementing SMP means having multiple threads
that handle the userspace loop in arch/um/os-Linux/skas/process.c.

We could also do a poor man's SMP implementation first, where only user=20
processes run in parallel.
IOW userspace() in arch/um/os-Linux/skas/process.c is still a single thread=
=20
but it let's run up to N user space thread and only if the call into the=20
kernel we degrade to UP.

Adding SMP is not extremely hard but it requires a lot of re-work of the UM=
L=20
core and introduces tons of new issues.

That said, volunteers are welcome!

Thanks,
//richard

