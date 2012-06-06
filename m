Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FCFE504.2020100@nod.at>
Date: Thu, 07 Jun 2012 01:17:24 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at> <20120604221731.5e378fc2@pyramind.ukuu.org.uk>
In-Reply-To: <20120604221731.5e378fc2@pyramind.ukuu.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig46D237879C2261C99606B318"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: TTY fixes (?)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: jslaby@suse.cz, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, alan@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig46D237879C2261C99606B318
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 04.06.2012 23:17, schrieb Alan Cox:
> We can half ignore it on console for the simple reason that you don't
> "dial in" to the console. I suspect it may be abusable but I've not fou=
nd
> a way to do so.
>=20

BTW: Can't we add such a mode to tty_port?
E.g. tty_port->non_dialin_console. 8)

Nobody dials-in on a UML console...

Thanks,
//richard


--------------enig46D237879C2261C99606B318
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPz+UFAAoJEN9758yqZn9ehHAIAKZchZPEFb5/8JBuGQaazgCU
t4xH+C34UCPb4aaVvfrCZ/aOtJ20eRBvxmyqq52qUUgan5RsVMuqmyiPmLG6D1NL
d+3ExQusYBtUHXpxen5ijudDjigN5bDBByNmfWrj8JoqiwfTC06eIyUe/Z9IkiwF
G1qZc+QbQWXNwRhP7YIKAUSLL7WWN3DCc7LdUMlhokgMYwtxP1Qf0j4XyPz2yqIb
YSQjxK1tJWvnpYmpdEyTdTUzv8o9chM7j+e7pr9qzghtSH6+EQtVLznbYdDI7ZgQ
/EeQN5bY7yRgq7CKjXKoUzYzaZL1Prw0Ax8eAZ1upvUbiRopOm+fsAfcyvFOlaQ=
=2qVf
-----END PGP SIGNATURE-----

--------------enig46D237879C2261C99606B318--
