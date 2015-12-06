Return-Path: <linux-kernel-owner@vger.kernel.org>
References: <1448805802-12156-1-git-send-email-mic@digikod.net>
 <1448805802-12156-2-git-send-email-mic@digikod.net>
 <CADNZ+wSJtq9Ymx-2YcYe5XwwXTmMdbtsuBz6JHotnnwH3G7GKg@mail.gmail.com>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
Message-ID: <56641CEA.5080202@digikod.net>
Date: Sun, 6 Dec 2015 12:32:58 +0100
MIME-Version: 1.0
In-Reply-To: <CADNZ+wSJtq9Ymx-2YcYe5XwwXTmMdbtsuBz6JHotnnwH3G7GKg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="IJilABAj6qTSantFpe9fwNbmjbctHgTc3"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2 1/2] um: Set secure access mode for temporary file
To: Tristan Schmelcher <tschmelcher@google.com>
Cc: linux-kernel@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel <user-mode-linux-devel@lists.sourceforge.net>, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IJilABAj6qTSantFpe9fwNbmjbctHgTc3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On 04/12/2015 18:13, Tristan Schmelcher wrote:
> File permissions are checked at time of open, so I think this fchmod
> call has never had any effect.

Indeed, mmap doesn't require the file to be executable, only readable and=
 writable. The fchmod seems to be a guarantee for this permissions but I =
don't see why a file newly created could not be writable.

>=20
> If there is a concern that the mkstemp implementation may be insecure,
> why not set and restore the umask?
>=20

I will add this safeguard.

 Micka=C3=ABl


--IJilABAj6qTSantFpe9fwNbmjbctHgTc3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWZBzyAAoJECLe/t9zvWqVI34H/AhdHSEgiee4MrSr190ws4cf
2M6r7GPezK2D7eqSCSVE/aPvQA6gtpr9c9yW4atir3drGrgd+Z33yv3foeNA/7HL
/hOrZ5blv1OB9/zZup0ua6AZm90T0i9f7OrAaEdIcqDa7QGkZYy3AlH49RHii0fL
9icoFDPShoZhfTm0qTHrY2EzZlkdEahLCgXTILifzBLn1XWa7tH1P6PkMUj0S6jM
wE5eqO+JS+OlBulywiW2Yma1Bf/aSypb9xTx6QLybT9wYlaqonuzgXZ4ZZPcTN+p
FMqxQj34KoeOOxV7YUgZrPlowiEqiFaaPdvODQFboHAOiqqhZ+L+ATj6/+bvZ0E=
=m5MX
-----END PGP SIGNATURE-----

--IJilABAj6qTSantFpe9fwNbmjbctHgTc3--
