Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <f.fainelli@gmail.com>) id 1QVsaN-0001Zf-Ah
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 21:52:47 +0000
Received: from mail-wy0-f175.google.com ([74.125.82.175])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1QVsaM-0007h3-9y
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 12 Jun 2011 21:52:47 +0000
Received: by wye20 with SMTP id 20so4160189wye.34
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Sun, 12 Jun 2011 14:52:40 -0700 (PDT)
From: Florian Fainelli <florian@openwrt.org>
Date: Sun, 12 Jun 2011 23:52:35 +0200
References: <201106121314.41348.florian@openwrt.org>
	<201106121356.14546.richard@nod.at>
In-Reply-To: <201106121356.14546.richard@nod.at>
MIME-Version: 1.0
Message-Id: <201106122352.35662.florian@openwrt.org>
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
Subject: Re: [uml-devel] [PATCH 2/2] um: disable compile-time buffer checks
To: Richard Weinberger <richard@nod.at>
Cc: nico@openwrt.org, user-mode-linux-devel@lists.sourceforge.net

Le dimanche 12 juin 2011 13:56:14, Richard Weinberger a =E9crit :
> Am Sonntag 12 Juni 2011, 13:14:41 schrieb Florian Fainelli:
> > From: Nicolas Thill <nico@openwrt.org>
> > =

> > Ubuntu 8.10 and newer enable compile-time buffer checks by default,
> > =

> > which can sometime cause build failures like this:
> >   LD      vmlinux
> >   SYSMAP  System.map
> >   SYSMAP  .tmp_System.map
> >   LINK linux
> >   Building modules, stage 2.
> >   MODPOST 51 modules
> > =

> > ERROR: "__sprintf_chk" [arch/um/drivers/harddog.ko] undefined!
> =

> Hmm, now I'm wondering why no other Ubuntu users have noticed this.
> Are also current versions of Ubuntu affected?

Without this patch, I get the exact same modpost error on Ubuntu 11.04:

  SYSMAP  System.map
  LINK linux
  Building modules, stage 2.
  MODPOST 39 modules
ERROR: "__sprintf_chk" [arch/um/drivers/harddog.ko] undefined!
make[5]: *** [__modpost] Error 1
make[4]: *** [modules] Error 2
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

