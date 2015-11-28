Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1448746350-19998-1-git-send-email-mic@digikod.net>
 <1448746350-19998-3-git-send-email-mic@digikod.net> <565A258D.4040206@nod.at>
 <565A3128.8010605@digikod.net> <565A31B6.5050802@nod.at>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <565A326F.4050005@digikod.net>
Date: Sun, 29 Nov 2015 00:02:07 +0100
MIME-Version: 1.0
In-Reply-To: <565A31B6.5050802@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="PTuVFHGVgpK2qbJwKwlpi3loGupHwU1wD"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 2/2] um: Use race-free temporary file creation
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, Al Viro <viro@zeniv.linux.org.uk>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--PTuVFHGVgpK2qbJwKwlpi3loGupHwU1wD
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: quoted-printable


>>>> +			errno !=3D EOPNOTSUPP))
>>>> +		return fd;
>>>> +	errno =3D 0;
>>>
>>> Why are you resetting errno?
>>
>> It's to ignore/reset the error code from open, but it may not be neede=
d because of the next call to malloc?
>=20
> But then you'd have to reset errno after every syscall. :-)

OK, I will remove it then :)

 Micka=EBl


--PTuVFHGVgpK2qbJwKwlpi3loGupHwU1wD
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWWjJvAAoJECLe/t9zvWqVeRMH/3puMkZ4tLBYQGGMLQWBzSwc
Zf0SQvvLCWJtpIBtybSuIYbRmRg0/Y6Pn6c4cVxNZhX/0h/PO2xRPE43iYIpje+4
++S9z0FNrlIn1nQx+ivfHBxtfe7BIG7g/I+eM/KtpiZv0UE/SOJR8sh/RJ9k18gV
Oj02G7Uv+sJcXIhMDS2mt2EpYSp6O1Bw7AYD1Xnh9bp7+8j7jDbi8ha1XowQGyiS
M5wOBCV2hWLkYObO0H2y0IkRFo+YiQnABw8n//HETha0dbWJeX/7kxp0XIu8SCKE
1l6ghYm3GwcsibbHocWP2gG85aXrWa6QTfHGgMa2vWPKS7Gg7m+m1LIO0kV6ED8=
=TBkZ
-----END PGP SIGNATURE-----

--PTuVFHGVgpK2qbJwKwlpi3loGupHwU1wD--
