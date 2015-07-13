Return-Path: <dcb314@hotmail.com>
Message-ID: <DUB128-W34F7EAB9B83253645F225B9C9C0@phx.gbl>
From: David Binderman <dcb314@hotmail.com>
Date: Mon, 13 Jul 2015 16:33:25 +0000
In-Reply-To: 
 <CAMuHMdWNE86shNgXqs8ZWJXeUf1L8eqK41GDfYvCHdFHefz9Kw@mail.gmail.com>
References: 
 <DUB128-W4287C49CC298A43BB8A3409C9C0@phx.gbl>,<55A3A5E0.8030802@nod.at>,<DUB128-W657ACA17D13F07E1D42A339C9C0@phx.gbl>,<CAMuHMdUjwQF3Lhcyo0L_TNGECtKMbOdDp+fixiyj=Svw7XeuXg@mail.gmail.com>,<DUB128-W57E673D474548BF61C14F09C9C0@phx.gbl>,<CAMuHMdWNE86shNgXqs8ZWJXeUf1L8eqK41GDfYvCHdFHefz9Kw@mail.gmail.com>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Subject: RE: [uml-devel] linux-4.2-rc2/arch/um/drivers/net_user.c:258:
 possible missing call to va_end ?
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hello there Geert=2C=0A=
=0A=
----------------------------------------=0A=
> Thanks for your patch!=0A=
=0A=
You are welcome.=0A=
=0A=
> As Jeff already commented=2C you should include a proper patch descriptio=
n.=0A=
=0A=
How about=0A=
=0A=
[PATCH]: Add missing va_end to split_if_spec=0A=
=0A=
> Unfortunately the patch is whitespace-damaged.=0A=
> Did you paste it in a web-based email client?=0A=
=0A=
Yes.=0A=
=0A=
> Do you use git?=0A=
=0A=
No.=0A=
=0A=
BTW=2C the same problem we are discussing also occurs in the arch/xtensa su=
bsystem.=0A=
=0A=
A chap called Max Filippov <jcmvbkbc@gmail.com> managed to brew up=0A=
a suitable patch as soon as I informed him of his bug. Perhaps it would=0A=
be cheaper and easier for you to get in touch with him about his patch=0A=
and adapt it to your purposes ?=0A=
=0A=
Just an idea.=0A=
=0A=
Regards=0A=
=0A=
David Binderman=0A=
=0A=
 		 	   		  =

