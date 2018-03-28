Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Subject: Re: [uml-devel] UML hangs with hrtimer test module
Date: Wed, 28 Mar 2018 15:19:07 +0200
Message-ID: <1847021.mDh9H4lbpW@blindfold>
In-Reply-To: <CAMuHMdU0jYx+NdZWdZpSwWZkBNvBDJ14trvM8B49h4st_7RkgA@mail.gmail.com>
References: <CAD=GYpatpGo=6mwhkw+RCQX=TNxX9jyfsq67srFc6+FhYtxaWg@mail.gmail.com> <CAMuHMdU0jYx+NdZWdZpSwWZkBNvBDJ14trvM8B49h4st_7RkgA@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Joel Fernandes <agnel.joel@gmail.com>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Mittwoch, 28. M=E4rz 2018, 15:11:29 CEST schrieb Geert Uytterhoeven:
> On Wed, Mar 28, 2018 at 12:28 PM, Joel Fernandes <agnel.joel@gmail.com>=20
wrote:
> >         while(release_now =3D=3D 0);
>=20
> while (release_now =3D=3D 0)
>         cpu_relax();

Not sure whether a cpu_relax() fixes the problem.
I guess the root of the problem is that UML is UP and non-preemptive.=20
Therefore the loop is never interrupted.
To verify I asked for the full source.

Thanks,
//richard

