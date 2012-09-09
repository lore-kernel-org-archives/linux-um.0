Return-Path: <richard@nod.at>
Message-ID: <504C992D.606@nod.at>
Date: Sun, 09 Sep 2012 15:27:09 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201209022245.20413.PeterHuewe@gmx.de> <201209091452.19700.PeterHuewe@gmx.de> <504C9227.1020700@nod.at> <201209091511.32970.PeterHuewe@gmx.de>
In-Reply-To: <201209091511.32970.PeterHuewe@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC654781FF81B8EA82C078E12"
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: =?ISO-8859-15?Q?Peter_H=FCwe?= <PeterHuewe@gmx.de>
Cc: Jean Delvare <khali@linux-fr.org>, Geert Uytterhoeven <geert@linux-m68k.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC654781FF81B8EA82C078E12
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Am 09.09.2012 15:11, schrieb Peter H=FCwe:
>>>> Maybe some parts of the I2C sub-system can also just depend on
>>>> GENERIC_IO instead of HAS_IOMEM.
>>>> An arch has GENERIC_IO=3Dy if it supports everything defined in
>>>> generic-asm/io.h which is more than enough for most stub drivers.
>>>
>>> The only thing which seems to be missing on UML is the ioremap functi=
on
>>> family ;/
>>
>> Why do you need ioremap() in a stub driver?
>> This sounds strange.
>=20
>=20
> This was a misunderstanding - the main part of the I2C subsystem doesn'=
t=20
> depend at all on HAS_IOMEM, only the main part of the i2c/busses sectio=
n.
> And almost all of those drivers use ioremap.

Sure. They need real hardware. :-)

> For my stub driver I don't need any of that, I'd be fine with the move =
of=20
> HAS_IOMEM as proposed by Jean.

IMHO you should replace the HAS_IOMEM with GENERIC_IO.
Otherwise you may break the build on s390.

Thanks,
//richard


--------------enigC654781FF81B8EA82C078E12
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQTJktAAoJEN9758yqZn9eTEoH/25xnLzPwqCihXujcCBAiEGw
MYD40giaVtRmRrKqjly6efLKdOyTgo62k4dtmJhgWxVsb+M98wmn7B3fMhZSADpK
qSexGR88BhrL55Zk1Wy+eWFmlIz24FQmhJTBGwXrhie/5ELAIGOx+vDTGl99suwJ
pI0uTnAqiCX3qkaWN3+1Pea4d+RIMvaYCtrHI0g3l2fvhq76FHcUGsGrQq9nvNmq
cKUFpYXvk7RhmWRsvnWiyddRfvGZchbHYdQk2dshrHyTVWpLl9Zyig3b0uFwrksi
hIOJXrJCeCnUVYAphpJDpnNSXqidsE1VTI9uKNKK6PJMfKHuHQVeHK7wNjHBw1U=
=20jU
-----END PGP SIGNATURE-----

--------------enigC654781FF81B8EA82C078E12--

