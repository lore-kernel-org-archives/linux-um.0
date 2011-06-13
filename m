Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <f.fainelli@gmail.com>) id 1QW6R3-00028k-C1
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jun 2011 12:40:05 +0000
Received: from mail-ww0-f53.google.com ([74.125.82.53])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QW6Qy-0004C2-Lr
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jun 2011 12:40:05 +0000
Received: by wwj40 with SMTP id 40so4256499wwj.10
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 13 Jun 2011 05:39:54 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
Date: Mon, 13 Jun 2011 14:39:44 +0200
References: <201106121314.41348.florian@openwrt.org>
	<201106122352.35662.florian@openwrt.org>
	<201106130056.12956.richard@nod.at>
In-Reply-To: <201106130056.12956.richard@nod.at>
MIME-Version: 1.0
Message-Id: <201106131439.44908.florian@openwrt.org>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-15"
Content-Transfer-Encoding: quoted-printable
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] [PATCH 2/2] um: disable compile-time buffer checks
To: Richard Weinberger <richard@nod.at>
Cc: nico@openwrt.org, user-mode-linux-devel@lists.sourceforge.net

Le lundi 13 juin 2011 00:56:12, Richard Weinberger a =E9crit :
> Am Sonntag 12 Juni 2011, 23:52:35 schrieb Florian Fainelli:
> > Le dimanche 12 juin 2011 13:56:14, Richard Weinberger a =E9crit :
> > > Am Sonntag 12 Juni 2011, 13:14:41 schrieb Florian Fainelli:
> > > > From: Nicolas Thill <nico@openwrt.org>
> > > > =

> > > > Ubuntu 8.10 and newer enable compile-time buffer checks by default,
> > > > =

> > > > which can sometime cause build failures like this:
> > > >   LD      vmlinux
> > > >   SYSMAP  System.map
> > > >   SYSMAP  .tmp_System.map
> > > >   LINK linux
> > > >   Building modules, stage 2.
> > > >   MODPOST 51 modules
> > > > =

> > > > ERROR: "__sprintf_chk" [arch/um/drivers/harddog.ko] undefined!
> > > =

> > > Hmm, now I'm wondering why no other Ubuntu users have noticed this.
> > > Are also current versions of Ubuntu affected?
> > =

> > Without this patch, I get the exact same modpost error on Ubuntu 11.04:
> Okay, found the real problem.
> We have to export the *_chk functions.
> Nobody noticed it because most UML kernels are CONFIG_MODULES=3Dn
> and harddog.ko is not part of the defaultconfig.
> =

> Can you please test the attached patch?

Your patch works, thank you!

Feel free to add my Testbed-by: Florian Fainelli <florian@openwrt.org to th=
e =

final patch.
--
Florian

---------------------------------------------------------------------------=
---
EditLive Enterprise is the world's most technically advanced content
authoring tool. Experience the power of Track Changes, Inline Image
Editing and ensure content is compliant with Accessibility Checking.
http://p.sf.net/sfu/ephox-dev2dev
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

