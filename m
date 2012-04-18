Return-Path: <richard@nod.at>
Message-ID: <4F8E79D7.3030906@nod.at>
Date: Wed, 18 Apr 2012 10:22:47 +0200
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <1334695036-19977-1-git-send-email-richard@nod.at> <1334695036-19977-4-git-send-email-richard@nod.at> <CAMuHMdXXGSyQN0U_KntTn3ydeZ7tAqJh2445ptvo+GYwV_SNMg@mail.gmail.com>
In-Reply-To: <CAMuHMdXXGSyQN0U_KntTn3ydeZ7tAqJh2445ptvo+GYwV_SNMg@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig38499842B01E484DA3C520F2"
Subject: Re: [uml-devel] [PATCH 4/4] irq: Remove irq_chip->release()
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, tglx@linutronix.de, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig38499842B01E484DA3C520F2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 18.04.2012 09:46, schrieb Geert Uytterhoeven:
> On Tue, Apr 17, 2012 at 22:37, Richard Weinberger <richard@nod.at> wrot=
e:
>> As it's only user (UML) does no longer need it we can get
>> rid of it.
>=20
> But now all drivers have to call um_free_irq() instead of free_irq()?

No. They can still use free_irq().
Only drivers on top of SIGIO and SIGVTALRAM irq chips have to use um_free=
_irq().
But ATAIK all drivers on UML use SIGIO, SIGVTALRAM.

> Are there any generic drivers not specific to UML we do want to use on =
UML?

I don't think so.

Thanks,
//richard


--------------enig38499842B01E484DA3C520F2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJPjnnaAAoJEN9758yqZn9eMhQH/0EqlHXeVHAn3gFWyqt9A7J0
tDJkQ+p2BFLAt8YPENCmJt0xgHPJxzNqjp9Ws6piZZzsQnQTbQ0ze8J0Z4grEazq
lk/ECPLbHAm5vqqO0idRtyuScpkWSU5NIgC1dxQKMbr/hIc3yRQrZ8//fLftyR76
jOcp81irrH4zqHY3Edkqll2RwO3vlrpQ4Jj+es+cxqaI8iH+JGubjl7mc9Ao+e3R
YZCcV9C1i5CpnZ9KOif07ezDIfoCvSKe7bovrN4L+VKJVqW4S2Kz4oSrTxhen42K
TqByAMh9cq85iMBIbFxZkekWNJ2DHsKMDF/zhFMeYAPUvqERVGrbG0sM5WtEiho=
=VOFY
-----END PGP SIGNATURE-----

--------------enig38499842B01E484DA3C520F2--

