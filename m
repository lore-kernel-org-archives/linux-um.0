Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 12 Aug 2011 21:06:26 +0200
From: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>
Message-ID: <20110812190626.GK29043@debian.debian>
References: <1313108903-7351-1-git-send-email-j.neuschaefer@gmx.net>
 <20110812101928.f34da400.rdunlap@xenotime.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: QUOTED-PRINTABLE
In-Reply-To: <20110812101928.f34da400.rdunlap@xenotime.net>
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] UserModeLinux-HOWTO.txt: remove ^H characters
To: Randy Dunlap <rdunlap@xenotime.net>
Cc: Jonathan =?utf-8?Q?Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>, linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Fri, Aug 12, 2011 at 10:19:28AM -0700, Randy Dunlap wrote:
> On Fri, 12 Aug 2011 02:28:23 +0200 Jonathan Neusch=C3=A4fer wrote:
>=20
> > If you can't read this patch, please run:
> >=20
> > 	sed -i -e "s/[^\o10]\o10//g" \
> > 		Documentation/virtual/uml/UserModeLinux-HOWTO.txt
> >=20
> > Signed-off-by: Jonathan Neusch=C3=A4fer <j.neuschaefer@gmx.net>
> > ---
> >  Documentation/virtual/uml/UserModeLinux-HOWTO.txt |  530 +++++++++=
+----------
> >  1 files changed, 265 insertions(+), 265 deletions(-)
>=20
> I like the patch, although the text file seems to be quite old and it
> appears to be a generated file (from where?).

Yes, looks old. There has been only one (real) change in content since
2.6.12-rc2 (4ff4d8d3: um: add ucast ethernet transport).

Greetings,
	Jonathan Neusch=C3=A4fer
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

