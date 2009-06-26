Return-Path: <linux-kernel-owner+geert=40linux-m68k.org-S1755330AbZFZBHk@vger.kernel.org>
Date: Fri, 26 Jun 2009 11:07:22 +1000
From: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [uml-devel] [PATCH] UML: Fix some apparent bitrot
Message-Id: <20090626110722.7ca2e8c4.sfr@canb.auug.org.au>
In-Reply-To: <4A432DD4.3010905@panasas.com>
References: <20090620005524.25582.69677.stgit@menage.mtv.corp.google.com>
	<4A3F4448.30502@panasas.com>
	<20090625135901.a028512d.sfr@canb.auug.org.au>
	<4A432DD4.3010905@panasas.com>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA1";
 boundary="Signature=_Fri__26_Jun_2009_11_07_22_+1000_+N+U/eWqXUq/h3ys"
Sender: linux-kernel-owner@vger.kernel.org
To: Boaz Harrosh <bharrosh@panasas.com>
Cc: Paul Menage <menage@google.com>, Andrew Morton <akpm@linux-foundation.org>, jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Rusty Russell <rusty@rustcorp.com.au>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

--Signature=_Fri__26_Jun_2009_11_07_22_+1000_+N+U/eWqXUq/h3ys
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi Boaz,

On Thu, 25 Jun 2009 10:57:08 +0300 Boaz Harrosh <bharrosh@panasas.com> wrot=
e:
>
> On 06/25/2009 06:59 AM, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > I applied the following patch to yesterday's linux-next and the i386 uml
> > defconfig build succeeded.
>=20
> Stephan Hi,=20
       ^
Stephen :-)

> Does this means that there will be a UML build every linux-next now?

Yes,  I will also see if the x86_64 UML will build.  I know the PPC one
won't (does anyone care?).

--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/

--Signature=_Fri__26_Jun_2009_11_07_22_+1000_+N+U/eWqXUq/h3ys
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.9 (GNU/Linux)

iEYEARECAAYFAkpEH0oACgkQjjKRsyhoI8yFagCgvy78dnYVEHWwv1bBsSkYJ0gc
9/oAoKlewV4ngE2itq7NE2FPMPMRi8uI
=jXJo
-----END PGP SIGNATURE-----

--Signature=_Fri__26_Jun_2009_11_07_22_+1000_+N+U/eWqXUq/h3ys--
