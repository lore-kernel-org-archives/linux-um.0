Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4FD0D9AF.4000605@nod.at>
Date: Thu, 07 Jun 2012 18:41:19 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1338841657-30358-1-git-send-email-richard@nod.at> <4FCF6748.6020005@panasas.com> <4FD059AC.8050808@panasas.com> <4FD06A22.6040002@nod.at> <4FD07F14.50902@panasas.com> <4FD0802A.1020203@nod.at> <20120607115227.6643d1ad@pyramind.ukuu.org.uk> <4FD0C64D.2050302@nod.at> <20120607173711.22ae146f@bob.linux.org.uk> <4FD0D7AA.4010506@nod.at> <20120607175024.696be664@bob.linux.org.uk>
In-Reply-To: <20120607175024.696be664@bob.linux.org.uk>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigC05C773DAFD49FB4BF43B385"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [uml-devel] um: TTY fixes (?)
To: Alan Cox <alan@linux.intel.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Boaz Harrosh <bharrosh@panasas.com>, user-mode-linux-devel@lists.sourceforge.net, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, viro@zeniv.linux.org.uk, jslaby@suse.cz
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigC05C773DAFD49FB4BF43B385
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 07.06.2012 18:50, schrieb Alan Cox:
> On Thu, 07 Jun 2012 18:32:42 +0200
> Richard Weinberger <richard@nod.at> wrote:
>=20
>> Am 07.06.2012 18:37, schrieb Alan Cox:
>>> Yes I know exactly what is going on. However getting a more tolerant
>>> behaviour is going to take a couple more kernels.
>>>
>>
>> So, then please tell me what's the proper way to fix the UML console
>> driver?
>>
>> - tty_port plus ->hangup() works only with a patched util-linux
>> - tty_port without ->hangup() seems to work only if *getty does not
>> call vhangup()
>=20
> There isn't a nice one. It'll have to wait until 3.6/7 or so to get
> fixed nicely and it won't backport either.
>=20

Hmm, that's odd.
What about the not nice ways?
Having a ugly driver until 3.7 is better than having no driver...

I'm wondering why does drivers/tty/vt/vt.c work?
Can't I model the UML driver after it?

Thanks,
//richard




--------------enigC05C773DAFD49FB4BF43B385
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJP0NmwAAoJEN9758yqZn9e3fwIAMk/GU+h3cifpvGiW3QQ0P0s
WB6Whaq+G+hKqkHdic2RngsSJXSAI2j/cRsxcODM2d8Yk5vSU9NYDFQL/v7RMYEt
L+begzxomZfb1XNaBijxSh4LmLa4g40U/qm3nVsC3GJ2VYey1dV68kTr7iTOgkr4
Jjls4heJBBM/lUijdQ4I+5JdYMSmj2EOGXf5Rup9o/HkVOM9Tap9o0rxlplJJWWo
VUB4CWmFGXjP+4On81IDZ8JSaDnfvbagmh71WkMy/MGntufG9+ccfOyXknWVczzU
qmcIT4s23Q09ib5arAOUHtDDXJq4BGXmtNhelFHC5X1likZy/KRyr30s7HbpGGo=
=ZIze
-----END PGP SIGNATURE-----

--------------enigC05C773DAFD49FB4BF43B385--
