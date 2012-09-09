Return-Path: <richard@nod.at>
Message-ID: <504C8A2A.2060802@nod.at>
Date: Sun, 09 Sep 2012 14:23:06 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091249.04279.PeterHuewe@gmx.de> <20120909132838.51b6c434@endymion.delvare> <201209091415.02460.PeterHuewe@gmx.de>
In-Reply-To: <201209091415.02460.PeterHuewe@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7040D84B91665B2204D24B27"
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: =?ISO-8859-1?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: Jean Delvare <khali@linux-fr.org>, Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7040D84B91665B2204D24B27
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 09.09.2012 14:15, schrieb Peter H=FCwe:
> Am Sonntag, 9. September 2012, 13:28:38 schrieb Jean Delvare:
>> Thanks for the info. I thought UML was no longer used with all the
>> virtualization solutions available, but apparently I was wrong.
> I guess it's mainly used for sandboxing, testing and development ;)

It's mostly used where KVM does not work.
For example low end i586 servers in schools.
Using UML you can still run 10+ instances on a P3 with 512MiB ram.

>=20
>> My bet is that all I2C bus drivers do use I/O or memory mapped
>> operations directly or indirectly, except i2c-stub. So it would
>> probably make more sense, and be a less intrusive change, to move the
>> HAS_IOMEM dependency to drivers/i2c/busses, and move (logically or for=

>> real) i2c-stub out of it.
>>
>> Or are there really other I2C bus drivers which make sense to enable
>> under UML?
> The only other available in UML which doesn't rely on HAS_IOMEM is the =

> PARPORT_LIGHT which relies on direct io access - so I guess this one do=
esn't=20
> make sense either.
>=20
> I created a patch for your proposed solution, I moved the stub driver t=
o the=20
> end in order to have only one big if HAS_IOMEM.

UML does not have IO_MEM but some sub-systems have "depend HAS_IOMEM" whi=
ch is
often too coarse grained.
To deal with that I've introduced GENERIC_IO some time ago to support MTD=
 (and nandsim)
on UML.
Maybe some parts of the I2C sub-system can also just depend on GENERIC_IO=
 instead of
HAS_IOMEM.
An arch has GENERIC_IO=3Dy if it supports everything defined in generic-a=
sm/io.h which is
more than enough for most stub drivers.

Please look at this patch series:
https://lkml.org/lkml/2012/2/6/489

I'm sure it will help you in bringing I2C to UML.

Thanks,
//richard


--------------enig7040D84B91665B2204D24B27
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQTIouAAoJEN9758yqZn9ekcgIALK1+pMcWkrW06iTYO68tiKw
38phzMAAcF24mkjEajh/y3OBmns7WX3cXada6y17JtyCHbxiRvfE5Raz7FxdTZts
sgzGD3TYZoPEoWml9JNZ9QsdGXxwsOHJ70xK+YJm9/yXmCQtrzmR3bQu63+/DAtZ
uhHfTAeNYFzHHKAueI8HsShO4dfFPHDxKWUpJMxtt7B1e0PWnSB7ePAKf8p/t5ia
m+01O+WJwLWLgbVanAk9/Z+31NTbk67x5EO75kU4OPEXO8mDUwTKU9qN5jdP39pP
nw8wx3nptcM2C/3yXi77nS17TR8fFTqEdWokIWIjQscANtcFKFCUDtdYTIp9ocY=
=DWVM
-----END PGP SIGNATURE-----

--------------enig7040D84B91665B2204D24B27--

