Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1755977AbZFZCB0@vger.kernel.org>
Date: Fri, 26 Jun 2009 12:01:11 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [uml-devel] [PATCH] UML: Fix some apparent bitrot
Message-Id: <20090626120111.ef8622ba.sfr@canb.auug.org.au>
In-Reply-To: <20090625145155.GA6383@c2.user-mode-linux.org>
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com>
	<4A3F4448.30502@panasas.com>
	<20090622085735.GB6499@cr0.nay.redhat.com>
	<20090622205226.fee30ba8.sfr@canb.auug.org.au>
	<20090625104901.GG6374@cr0.nay.redhat.com>
	<20090625145155.GA6383@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__26_Jun_2009_12_01_11_+1000_YNeEzb3njtCdI8sg"
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>
Cc: Amerigo Wang <xiyou.wangcong@gmail.com>, Boaz Harrosh <bharrosh@panasas.com>, Paul Menage <menage@google.com>, akpm@linux-foundation.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

--Signature=_Fri__26_Jun_2009_12_01_11_+1000_YNeEzb3njtCdI8sg
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, 25 Jun 2009 10:51:55 -0400 Jeff Dike <jdike@addtoit.com> wrote:
>
> On Thu, Jun 25, 2009 at 06:49:01PM +0800, Amerigo Wang wrote:
> > make ARCH=3Dum SUBARCH=3Dppc? Or something similar...
>=20
> It would need to be
> 	make ARCH=3Dum=20
> with an x86 cross-compiler.

On out PowerPC host I am using

	make ARCH=3Dum SUBARCH=3Di386 CROSS_COMPILE=3D<path to i386 cross compiler>

I am just building defconfig, would another config also be useful?

Currently plain "make ARCH=3Dum" on PowerPC doesn't appear to work.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__26_Jun_2009_12_01_11_+1000_YNeEzb3njtCdI8sg
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpEK+cACgkQjjKRsyhoI8wSkwCgkjJ4mO9aS59K8scR2ibpLv9S
cRIAn0TGIPSRwn6YkvVzBvWb4a50HEId
=CcyU
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Jun_2009_12_01_11_+1000_YNeEzb3njtCdI8sg--
