Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1448805802-12156-1-git-send-email-mic@digikod.net>
 <1448805802-12156-2-git-send-email-mic@digikod.net>
 <CADNZ+wSJtq9Ymx-2YcYe5XwwXTmMdbtsuBz6JHotnnwH3G7GKg@mail.gmail.com>
 <56641CEA.5080202@digikod.net>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <566422C2.7050504@digikod.net>
Date: Sun, 6 Dec 2015 12:57:54 +0100
MIME-Version: 1.0
In-Reply-To: <56641CEA.5080202@digikod.net>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="eFVIo9dBNB5sTbgqcKJK1oo15E0HD5tH9"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] um: Set secure access mode for temporary file
To: Tristan Schmelcher <tschmelcher@google.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--eFVIo9dBNB5sTbgqcKJK1oo15E0HD5tH9
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 06/12/2015 12:32, Micka=C3=ABl Sala=C3=BCn wrote:
> On 04/12/2015 18:13, Tristan Schmelcher wrote:
>> File permissions are checked at time of open, so I think this fchmod
>> call has never had any effect.
>=20
> Indeed, mmap doesn't require the file to be executable, only readable a=
nd writable. The fchmod seems to be a guarantee for this permissions but =
I don't see why a file newly created could not be writable.

The fchmod may be useful if the umask is 0777 :)

 Micka=C3=ABl


--eFVIo9dBNB5sTbgqcKJK1oo15E0HD5tH9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWZCLCAAoJECLe/t9zvWqV5MkIAJzhyOiWPPqsYB+zgeAzbX86
XzQMzZUl+2EgrrT2DxGvOUW5FXKLmqUbFJFYCixlsJHHNQyROCKye99rSRhpUBag
hdZDCvDyn69wC+bXmuVR0YR2yRhV0af3p6ONUJ2spbZwCk5K27s6q0aT7pUCAgLz
AC217VIpqmXTpuFR/32bvijozio2h02ZAZS71Qx2ZiJ/tOxxJtL9OwGLS7q6SLjS
PGhEvEPzatj3FKxcBWZOPWrO/cO3l8JSMbiUKCsbg6zpTO7iawSA0yxBxfDtOhS4
TcQ+WaGfvKugFfCSDv8Ojff9olGRmtXLtaUaCwv8vIEjT008Cjc+uQDhamVLBBU=
=/7dc
-----END PGP SIGNATURE-----

--eFVIo9dBNB5sTbgqcKJK1oo15E0HD5tH9--
