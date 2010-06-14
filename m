Return-Path: <toralf.foerster@gmx.de>
From: Toralf =?iso-8859-1?q?F=F6rster?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH] x86, hweight: Fix UML boot crash
Date: Mon, 14 Jun 2010 15:44:58 +0200
References: <201005271944.09541.toralf.foerster@gmx.de> <201006141149.24647.toralf.foerster@gmx.de> <20100614130039.GA4618@kryptos.osrc.amd.com>
In-Reply-To: <20100614130039.GA4618@kryptos.osrc.amd.com>
MIME-Version: 1.0
Content-Type: Text/Plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Message-Id: <201006141544.59500.toralf.foerster@gmx.de>
To: Borislav Petkov <bp@amd64.org>
Cc: Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>, Geert Uytterhoeven <geert@linux-m68k.org>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>


Borislav Petkov wrote at 15:00:39

> Linus' tree doesn't contain the fix yet - rather it is in -tip:
> http://git.kernel.org/tip/055c47272b8f5679d08ccc57efea3cb4aaeb5fc6
>=20
> You can easily cherry-pick it from there and retest.
Issue solved works with that patch.

FWIW : This command sequence produced a linux executable which crashed too:

$> ~/devel/linux-2.6 $ patch -p1 < ../linux-2.6-
tip.git-055c47272b8f5679d08ccc57efea3cb4aaeb5fc6.patch patching file=20
arch/um/include/asm/arch_hweight.h

$> ~/devel/linux-2.6 $ make ARCH=3Dum CC=3D"ccache gcc"
make[1]: `arch/um/sys-i386/user-offsets.s' is up to date.
  CHK     include/linux/version.h
  CHK     include/generated/utsrelease.h
  CALL    scripts/checksyscalls.sh
  CHK     include/generated/compile.h
  LINK linux
$> start_uml.sh
...

But after I compiled it w/o ccache

$> ~/devel/linux-2.6 $ make ARCH=3Dum

linux executable works (!?!)

Anyway thx for the fix
:-)

--=20
MfG/Kind regards
Toralf F=EF=BF=BDrster

pgp finger print: 7B1A 07F4 EC82 0F90 D4C2 8936 872A E508 7DB6 9DA3


