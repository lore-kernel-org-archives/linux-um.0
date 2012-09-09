Return-Path: <richard@nod.at>
Message-ID: <504C93F0.7030302@nod.at>
Date: Sun, 09 Sep 2012 15:04:48 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091415.02460.PeterHuewe@gmx.de> <504C8A2A.2060802@nod.at> <201209091452.19700.PeterHuewe@gmx.de>
In-Reply-To: <201209091452.19700.PeterHuewe@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig998A3F2B582A45B247D54E21"
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: =?ISO-8859-15?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: Jean Delvare <khali@linux-fr.org>, Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig998A3F2B582A45B247D54E21
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

BTW: What about io_remap_pfn_range()?

Thanks,
//richard


--------------enig998A3F2B582A45B247D54E21
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQTJPwAAoJEN9758yqZn9ek/wH/0fxh4yQ0NPC821ZkTJRpAkX
75szKiLE5rJz6/J/tjoeOYwJewviBAQYi1ntUJzBXp6ABl4j9MVPdW28KgPvzDOx
s6T6jhdGpXJ66Y4zbmNck9hshO4n3wWAEkY2w7HqkymHp7w4nfFUrDxK/d+rfIpb
FAN6wgwXI6/NQnE2qMQLiK3dsws7IKyytE0nFOv/s0G9q1Gxk9uDQY0GfPuh90Ju
+bL8kKWwplNMGalK9tEwdC0lSBTRHH3E+8aDVpJW6BD0IIoVGEPF0/vrxrUvezFm
JnQi3LZrZ2sYJAhA7ErHd989ZIQBRCNsxzbrEJeS9gzXubficn9E6ALWQZEqAzA=
=BRKj
-----END PGP SIGNATURE-----

--------------enig998A3F2B582A45B247D54E21--

