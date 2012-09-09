Return-Path: <richard@nod.at>
Message-ID: <504C9227.1020700@nod.at>
Date: Sun, 09 Sep 2012 14:57:11 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091415.02460.PeterHuewe@gmx.de> <504C8A2A.2060802@nod.at> <201209091452.19700.PeterHuewe@gmx.de>
In-Reply-To: <201209091452.19700.PeterHuewe@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6B4DD4F66E91CEEA1A591D90"
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: =?ISO-8859-15?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: Jean Delvare <khali@linux-fr.org>, Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6B4DD4F66E91CEEA1A591D90
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 09.09.2012 14:52, schrieb Peter H=FCwe:
> Am Sonntag, 9. September 2012, 14:23:06 schrieb Richard Weinberger:=20
>> UML does not have IO_MEM but some sub-systems have "depend HAS_IOMEM" =
which
>> is often too coarse grained.
>> To deal with that I've introduced GENERIC_IO some time ago to support =
MTD
>> (and nandsim) on UML.
>> Maybe some parts of the I2C sub-system can also just depend on GENERIC=
_IO
>> instead of HAS_IOMEM.
>> An arch has GENERIC_IO=3Dy if it supports everything defined in
>> generic-asm/io.h which is more than enough for most stub drivers.
>=20
> The only thing which seems to be missing on UML is the ioremap function=
 family=20
> ;/

Why do you need ioremap() in a stub driver?
This sounds strange.

Thanks,
//richard



--------------enig6B4DD4F66E91CEEA1A591D90
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQTJInAAoJEN9758yqZn9eC3wH/1TrCU01RrR54PxTVYdP++P4
I6cDHIPzD/+oQC/kk8C4UQPTB49Ydl6evxBvzqWeqYHRNzHil0+xjEsZtaTWKF1X
Vw6PISJP+AfkZYOD3W/e3SX2tSJPE190SbojbwTvzL0kTSSWnc3KIYdRi6JqxT0a
C1hluqtez+D6DU/tLClOZPfTFGWbs7D2CUuqlbctnOFTeUJO0CSPwh9lk4PMJ4te
wTHUQROe8DMSfQKZmxKkrlYEJ4EoAFdf5ePqY80q4/vE8uh1sf0f5VABS0Un6ItN
1ypQOc6Lpt4RdqFQ9Mo+QC/bK7NAASyOicZiQAj1mWPGGGHwpRBF6hpB0R51Sj4=
=XxBJ
-----END PGP SIGNATURE-----

--------------enig6B4DD4F66E91CEEA1A591D90--

