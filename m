Return-Path: <richard@nod.at>
Message-ID: <504CF727.8090309@nod.at>
Date: Sun, 09 Sep 2012 22:08:07 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <201209022245.20413.PeterHuewe@gmx.de> <CAMuHMdVBEYk0wvG+Xd-pk3DUj852ab1CFwSjg_os3MJpRXcBpA@mail.gmail.com> <709c5ec5-fff8-46af-bd7e-31e1f660285b@email.android.com> <201209092112.16527.PeterHuewe@gmx.de>
In-Reply-To: <201209092112.16527.PeterHuewe@gmx.de>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9424E724E998628D361A2B75"
Subject: Re: [uml-devel] Emulate I2C subsystem/slaves
To: =?UTF-8?B?UGV0ZXIgSMO8d2U=?= <PeterHuewe@gmx.de>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, Jean Delvare <khali@linux-fr.org>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9424E724E998628D361A2B75
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 09.09.2012 21:12, schrieb Peter H=C3=BCwe:
>> That's why it may break. If you remove the depends on HAS_IOMEM, it wi=
ll be
>> built on s390 and fail if that codes uses io memory functions. Dependi=
ng
>> on GENERIC_IO fixes that.
>=20
> Everything I can select in I2C subsystem compiles fine on s390.
> (using defconfig + menuconfig).
> Just compiled it.

Very good. :-)

Thanks,
//richard


--------------enig9424E724E998628D361A2B75
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJQTPcnAAoJEN9758yqZn9eQbEH/jg1NlBZSYsPQwNVG2BC4Agh
+xRBXbgy97bZuM0hBmTRxzQWn+521kus2c6Qk+szoNf+tewUX3ftt5ablXTFvpzx
KsTPe3tYwaP/7B/3nr87DNkPnRI5zxUsr/nXypMn3LQJWYNWiMbmvTei8VlZEP0Q
7CIbkROdZLmideX3OsZ5KgT1fv9d+meKaXmNoguJXzd8/zO0ILr1r6tdU82mR552
j2ziLJZlwK+5kLEpwCoObF3FNT7+K/3M5CBHc8noMvAAZjBixYJUzZ5T9n5egDRc
jRfGQriqMOQVCEU3FSvQH+LgVSSPfB04dgZY1zxMXdMN6e8HRJ4jAtHujL3yDAE=
=rlRS
-----END PGP SIGNATURE-----

--------------enig9424E724E998628D361A2B75--

