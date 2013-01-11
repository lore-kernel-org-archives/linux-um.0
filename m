Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Fri, 11 Jan 2013 22:59:11 +0100
From: Richard Weinberger <richard@nod.at>
Message-ID: <20130111225911.6c3b99e4@spider.haslach.nod.at>
In-Reply-To: <20130112005517.281f2b53@sf>
References: <1356820651-8495-1-git-send-email-slyfox@gentoo.org>
	<1356820651-8495-2-git-send-email-slyfox@gentoo.org>
	<20121230104043.2090940b@spider.haslach.nod.at>
	<20130112005517.281f2b53@sf>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] um: fix build failure due to mess-up of sig_info
 protorype
To: Sergei Trofimovich <slyfox@gentoo.org>
Cc: Jeff Dike <jdike@addtoit.com>, Martin =?UTF-8?B?UMOkcnRlbA==?= <martin.partel@gmail.com>, Al Viro <viro@zeniv.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am Sat, 12 Jan 2013 00:55:17 +0300
schrieb Sergei Trofimovich <slyfox@gentoo.org>:

> On Sun, 30 Dec 2012 10:40:43 +0100
> Richard Weinberger <richard@nod.at> wrote:
>=20
> > Am Sun, 30 Dec 2012 01:37:31 +0300
> > schrieb Sergei Trofimovich <slyfox@gentoo.org>:
> >=20
> > > arch/um/os-Linux/signal.c:18:8: error: conflicting types for
> > > 'sig_info' In file included
> > > from /home/slyfox/linux-2.6/arch/um/os-Linux/signal.c:12:0:
> > > arch/um/include/shared/as-layout.h:64:15: note: previous
> > > declaration of 'sig_info' was here
> > >=20
> > > Signed-off-by: Sergei Trofimovich <slyfox@gentoo.org>
> > > CC: Jeff Dike <jdike@addtoit.com>
> > > CC: Richard Weinberger <richard@nod.at>
> > > CC: "Martin P=C3=A4rtel" <martin.partel@gmail.com>
> > > CC: Al Viro <viro@zeniv.linux.org.uk>
> > > CC: user-mode-linux-devel@lists.sourceforge.net
> > > CC: user-mode-linux-user@lists.sourceforge.net
> > > CC: linux-kernel@vger.kernel.org
> > > ---
> >=20
> > I think both patches need to be backported to -stable.
> > I'll add the tag and push the patches ASAP to Linus.
>=20
> Seems to have got lost.

Yeah. Sorry for that. I'm currently very busy.
This weekend I'll have some time to prepare all my patches.

Thanks,
//richard
--
To unsubscribe from this list: send the line "unsubscribe linux-kernel"=
 in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/

