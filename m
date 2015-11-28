Return-Path: <linux-kernel-owner@vger.kernel.org>
From: =?UTF-8?Q?Micka=c3=abl_Sala=c3=bcn?= <mic@digikod.net>
References: <1448746350-19998-1-git-send-email-mic@digikod.net>
 <1448746350-19998-2-git-send-email-mic@digikod.net> <565A1F49.3040408@nod.at>
Message-ID: <565A3035.6030104@digikod.net>
Date: Sat, 28 Nov 2015 23:52:37 +0100
MIME-Version: 1.0
In-Reply-To: <565A1F49.3040408@nod.at>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="4Ncr94mjmtV9sVBo2E8FS3gNfo7d8r4f6"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH 1/2] um: Set secure access mode for temporary file
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Tristan Schmelcher <tschmelcher@google.com>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--4Ncr94mjmtV9sVBo2E8FS3gNfo7d8r4f6
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


On 28/11/2015 22:40, Richard Weinberger wrote:
> Am 28.11.2015 um 22:32 schrieb Micka=C3=ABl Sala=C3=BCn:
>> Replace the default insecure mode 0777 with 0700 for temporary file.
>>
>> Prohibit other users to change the executable mapped code.
>=20
> Hmm, isn't the tmp file already unlinked at this stage?
>=20

Yes, but if someone could open it before the unlink e.g. because of the u=
mask (which does not seems to be the case thanks to mkstemp, but remains =
unspecified [1]), this user should then be able to have write access to t=
he file descriptor/description.

 Micka=C3=ABl

1. http://man7.org/linux/man-pages/man3/mkstemp.3.html#NOTES



--4Ncr94mjmtV9sVBo2E8FS3gNfo7d8r4f6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAEBCgAGBQJWWjA7AAoJECLe/t9zvWqVAbwH/2HvqSraUWb3OPYGiXLsJ5dY
NXpqenFpj+k3KTxazJz39A3UIeL+hVverTp/ozEtYXyzF8E5TGW4LPTKO6YblUOW
P10rP07RfPktwSaHFMfd3c26ERBmKmKM6KmaGJCLjhEzNh//RtJ+o6pOtWExbIbD
vmdmSCbOtOrgvXpxSVivGNe4WA2JYjkPFnMBW489Uq1aib7YT4Gt0x2XYPN34zSk
7Mg+zfNpnaE/wVtMm+AIyBjTl+FNGk4LPHxXNlb1ZDC+IEeep2tf0EIwQ2NgI6Yr
RBUvLk8Q2RC1nOT5pyq/meN46Y7kfXh16nWMNIQG3PZFisgDqV499b9/pdAnxNg=
=OfH6
-----END PGP SIGNATURE-----

--4Ncr94mjmtV9sVBo2E8FS3gNfo7d8r4f6--
