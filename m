Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [uml-devel] UML hangs with hrtimer test module
Date: Thu, 29 Mar 2018 00:35:11 +0200
Message-ID: <6520656.Ns80NH9HyO@blindfold>
In-Reply-To: <CAD=GYpaBOgoWGW3F5kjk_0V8mUw1VeWLm7PnveNGejfehoE1Og@mail.gmail.com>
References: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com> <1847021.mDh9H4lbpW@blindfold> <CAD=GYpaBOgoWGW3F5kjk_0V8mUw1VeWLm7PnveNGejfehoE1Og@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
To: Joel Fernandes <agnel.joel@gmail.com>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Donnerstag, 29. M=E4rz 2018, 00:19:39 CEST schrieb Joel Fernandes:
> Thanks for the quick reply.
>=20
> On Wed, Mar 28, 2018 at 6:19 AM, Richard Weinberger <richard@nod.at> wrot=
e:
> > Am Mittwoch, 28. M=E4rz 2018, 15:11:29 CEST schrieb Geert Uytterhoeven:
> >> On Wed, Mar 28, 2018 at 12:28 PM, Joel Fernandes <agnel.joel@gmail.com>
> > wrote:
> >> >         while(release_now =3D=3D 0);
> >>
> >> while (release_now =3D=3D 0)
> >>         cpu_relax();
> >
> > Not sure whether a cpu_relax() fixes the problem.
> > I guess the root of the problem is that UML is UP and non-preemptive.
> > Therefore the loop is never interrupted.
> > To verify I asked for the full source.
> >
>=20
> cpu_relax actually worked!

Interesting.
=20
> Any thoughts on why it helps? Even if its non-preemptive, I did
> receive the timer interrupt, so I expected the variable to be set.

Timers trigger also with preempt off, I forgot...
I think the cpu_relax() issues internally a barrier such that the
release_now variable is read again.
Can you try barrier() instead of cpu_relax()? I bet it works too.
Same if you mark release_now as volatile.

Thanks,
//richard

