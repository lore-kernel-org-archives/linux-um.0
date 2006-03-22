Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
From: Stefano Melchior <stefano.melchior@openlabs.it>
Subject: Re: [uml-devel] Cannot debug UML
Message-ID: <20060322152707.GH8115@SteX>
Reply-To: stefano.melchior@openlabs.it
References: <44215200.8020708@gmail.com> <20060322135015.GC8115@SteX>
	<44215B8F.6060400@gmail.com> <20060322142820.GF8115@SteX>
	<44216384.4070709@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="ZYOWEO2dMm2Af3e3"
Content-Disposition: inline
In-Reply-To: <44216384.4070709@gmail.com>
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Wed, 22 Mar 2006 16:27:08 +0100
To: Mikado <mikado4vn@gmail.com>
Cc: user-mode-linux-user@lists.sourceforge.net, user-mode-linux-devel@lists.sourceforge.net


--ZYOWEO2dMm2Af3e3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 22, 2006 at 09:47:32PM +0700, Mikado wrote:
Hi Mikado,
>=20
> ./linux mode=3Dtt debug ubd0=3Droot_fs ubd1=3Dswap eth0=3Dtuntap,,,192.16=
8.0.254
> ./linux mode=3Dtt debug ubd0=3Droot_fs ubd1=3Dswap mem=3D128m
> eth0=3Dtuntap,,,192.168.0.254
> ./linux mode=3Dtt debug ubd0=3Droot_fs ubd1=3Dswap mem=3D128M
> eth0=3Dtuntap,,,192.168.0.254
Maybe it is a stupid question:=20
does the following command work?

=2E/linux ubd0=3Droot_fs

Start from this, then add step by step all the needed option

Cheers

SteX
--=20
Stefano Melchior, GPG key =3D D52DF829 - <stefano.melchior@openlabs.it>
http://etinarcadiaego.dyndns.org    --     http://www.stex.name
Skype ID "stefanomelchior"

--ZYOWEO2dMm2Af3e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.2.2 (GNU/Linux)

iQCVAwUBRCFsy4lnkxrVLfgpAQKE4QQAlLGz+nY81kI8ORwG3nuppnDPUVCYpOpm
VV8odldrJxu0wqOJ2uTxXVLqlNIjoNnQsVWAySNHYyA/4dZBG6mlh3IgnDqVxQ8w
LQohWFiXn6ILp87yaA96XvuKxohCTL8yiEHRLLLdG5Qsp6J1/II7YZuXOicsWV44
6IPrCYxHAOM=
=lmEk
-----END PGP SIGNATURE-----

--ZYOWEO2dMm2Af3e3--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
