Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Davidlohr Bueso <dave@gnu.org>
Reply-To: dave@gnu.org
In-Reply-To: <20110812190626.GK29043@debian.debian>
References: <1313108903-7351-1-git-send-email-j.neuschaefer@gmx.net>
	 <20110812101928.f34da400.rdunlap@xenotime.net>
	 <20110812190626.GK29043@debian.debian>
Content-Type: text/plain; charset=UTF-8
Date: Wed, 24 Aug 2011 18:35:43 -0300
Message-ID: <1314221743.3109.1.camel@offbook>
Mime-Version: 1.0
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] UserModeLinux-HOWTO.txt: remove ^H characters
To: Jonathan =?ISO-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc: Randy Dunlap <rdunlap@xenotime.net>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, 2011-08-12 at 21:06 +0200, Jonathan Neusch=C3=A4fer wrote:
> On Fri, Aug 12, 2011 at 10:19:28AM -0700, Randy Dunlap wrote:
> > On Fri, 12 Aug 2011 02:28:23 +0200 Jonathan Neusch=C3=A4fer wrote:
> >=20
> > > If you can't read this patch, please run:
> > >=20
> > > 	sed -i -e "s/[^\o10]\o10//g" \
> > > 		Documentation/virtual/uml/UserModeLinux-HOWTO.txt
> > >=20
> > > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > > ---
> > >  Documentation/virtual/uml/UserModeLinux-HOWTO.txt |  530 +++++++=
+++----------
> > >  1 files changed, 265 insertions(+), 265 deletions(-)
> >=20
> > I like the patch, although the text file seems to be quite old and =
it
> > appears to be a generated file (from where?).
>=20
> Yes, looks old. There has been only one (real) change in content sinc=
e
> 2.6.12-rc2 (4ff4d8d3: um: add ucast ethernet transport).

Glad I noticed this patch in time, just today I was doing the same. FYI
I'm in the process of updating/splitting the document.

Thanks,
Davidlohr

>=20
> Greetings,
> 	Jonathan Neusch=C3=A4fer
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kerne=
l" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>=20


--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

