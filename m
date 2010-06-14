Return-Path: <bp@amd64.org>
Date: Mon, 14 Jun 2010 15:00:39 +0200
From: Borislav Petkov <bp@amd64.org>
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
Message-ID: <20100614130039.GA4618@kryptos.osrc.amd.com>
References: <201005271944.09541.toralf.foerster@gmx.de>
 <201005311555.56791.toralf.foerster@gmx.de>
 <20100531141058.GB4915@aftab>
 <201006141149.24647.toralf.foerster@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <201006141149.24647.toralf.foerster@gmx.de>
To: Toralf =?iso-8859-1?Q?F=F6rster?= <toralf.foerster@gmx.de>
Cc: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Toralf F=EF=BF=BDrster <toralf.foerster@gmx.de>
Date: Mon, Jun 14, 2010 at 11:49:24AM +0200

> Borislav Petkov wrote at 16:10:58
> > Did you do 'make mrproper' before rebuilding UML with it?
>=20
> Today I started with a clean git tree (cloned Linus tree) and got this :

Right, I kinda missed that line, now it makes sense.

Linus' tree doesn't contain the fix yet - rather it is in -tip:
http://git.kernel.org/tip/055c47272b8f5679d08ccc57efea3cb4aaeb5fc6

You can easily cherry-pick it from there and retest.

Thanks.

--=20
Regards/Gruss,
Boris.

Operating Systems Research Center
Advanced Micro Devices, Inc.

