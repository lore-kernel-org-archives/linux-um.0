Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FCDF996.9010205@nod.at>
Date: Tue, 05 Jun 2012 14:20:38 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at> <20120604221731.5e378fc2@pyramind.ukuu.org.uk> <4FCD4161.7060409@nod.at> <20120605104125.GA14536@x2.net.home> <20120605121532.366a6526@pyramind.ukuu.org.uk>
In-Reply-To: <20120605121532.366a6526@pyramind.ukuu.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDA7382F1B5860F4602F148B2"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: um: TTY fixes (?)
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: Karel Zak <kzak@redhat.com>, jslaby@suse.cz, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, alan@linux.intel.com
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDA7382F1B5860F4602F148B2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 05.06.2012 13:15, schrieb Alan Cox:
> Actually I'd prefer a clever solution which can spot all the fds are th=
e
> same process so we can keep compatibility but I've not found a sensible=

> way to do that.

Me too.

For UML users the current situation is odd.
They have to select between:
- Having a UML that crashes randomly on some distros.
- Applying the TTY fix and break login on every distro that uses util-lin=
ux's login.
- Applying the TTY fix and patch util-linux too.

Thanks,
//richard




--------------enigDA7382F1B5860F4602F148B2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPzfmdAAoJEN9758yqZn9eOloIAJfvdVD2e8RjLEFFTFiD2DjX
9I0mnUTCWCJ4ke/THRAHi868iJrgbmG1UdKWzJNAB1CDwW8SLzDg8GUKTvEYv8G3
9TPoXKjhkdfSZQxahmlMtOEJnjiguvY3kDdR5R123jXleJh3GpgFEvI63mhilZpP
gwFBgNpFV0XPdyliDjaZurwZ6+4KzC/szyYKvUBlo+5ojVD99nJCq5rS8zY4uqkU
78hWPs/ZHXlvD9WKrOg1iiJUI27aAuW6HYCmAJ+P9bV1vUUsUObXZrlQubtyo3gt
wMR/M1TQNpKW9JslLe3x3NLh5Sp3pZ9eD4H9cF2FbVW56kDFdE1pBKVek657BAA=
=okVX
-----END PGP SIGNATURE-----

--------------enigDA7382F1B5860F4602F148B2--
