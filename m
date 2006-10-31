Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 31 Oct 2006 08:52:38 +0100
From: Stefano Melchior <stefano.melchior@openlabs.it>
Message-ID: <20061031075238.GB17198@SteX>
References: <8764elbcrj.fsf@glaurung.internal.golden-gryphon.com>
	<20061025122339.GA23127@SteX>
MIME-Version: 1.0
In-Reply-To: <20061025122339.GA23127@SteX>
Subject: Re: [uml-devel] [Pkg-uml-devel] Re: [Pkg-uml-pkgs] Bug#393263:
	uml-utilities: New version uml_utilities_20060622 has humsify,
	please update
Reply-To: stefano.melchior@openlabs.it
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============0125023032=="
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: 393263@bugs.debian.org
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Pkg-UML developers <pkg-uml-devel@lists.alioth.debian.org>


--===============0125023032==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="nVMJ2NtxeReIH9PS"
Content-Disposition: inline


--nVMJ2NtxeReIH9PS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 25, 2006 at 02:23:40PM +0200, Stefano Melchior wrote:
Dear all,
> > Package: uml-utilities
> > Version: 20060323-3
> > Severity: wishlist
> >=20
> > Hi,
> >=20
> >         The functionality of humsify is very interesting, and would
> >  allow adding a large file system to running UML instance, and yet
> >  allow the file system to be backed up by normal host backup schemas.=
=20
> >=20
> >         Please consider upgrading to 20060622.
> >=20
> >         manoj
> >=20
> > -- System Information:
> > Debian Release: testing/unstable
> >   APT prefers unstable
> >   APT policy: (990, 'unstable'), (500, 'stable'), (1, 'experimental')
> > Architecture: i386 (i686)
> > Shell:  /bin/sh linked to /bin/bash
> > Kernel: Linux 2.6.18-mh1-skas3-v9-pre9-fremap
> > Locale: LANG=3Den_US.UTF-8, LC_CTYPE=3Den_US.UTF-8 (charmap=3DUTF-8) (i=
gnored: LC_ALL set to en_US.UTF-8)
>=20
> I just started to work on porting the 2006-06-22 to svn and then I
> think, accordingly with Mattia's agreement, it will be ready for Etch+1.
>=20
I am also trying to write a quick man page for the humfsify tool and I am
planning to release it as soon as the package seems to be ready.
I tried to find if someone else already wrote it, but I could not find
anyone, so I decided to proceed.

When ready please check if it will be exhaustive enough

--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://www.openlabs.it/~stex    --     <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org  --  <ste@etinarcadiaego.dyndns.org>
Skype ID "stefanomelchior"

--nVMJ2NtxeReIH9PS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iQCVAwUBRUcAxolnkxrVLfgpAQL/WgP+J9QzpZyx7zTEpw1FfZ3sSVdgCnYwSum0
sdtAeFhPdVyiGELXW4y3sUEUlVC6HZt4l+SqX97jRjAIYB71a56RG+47NxI6FsFg
8rv32+li8sQCd2zzu7ZLVmpeQo0mgEkhspk1kbw5tk8ep7bYkkGhH+aukVv9o90M
hr/wdOmWz3E=
=yfto
-----END PGP SIGNATURE-----

--nVMJ2NtxeReIH9PS--


--===============0125023032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============0125023032==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

--===============0125023032==--
