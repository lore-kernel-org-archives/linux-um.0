Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4EAFDC5D.8030307@nod.at>
Date: Tue, 01 Nov 2011 12:47:41 +0100
From: Richard Weinberger <richard@nod.at>
MIME-Version: 1.0
References: <alpine.LNX.2.00.1111011207190.348@pobox.suse.cz>
In-Reply-To: <alpine.LNX.2.00.1111011207190.348@pobox.suse.cz>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig4F69D52EC1DE46203943CD0C"
Sender: linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH] um: vDSO: fix vdsop allocation
To: Jiri Kosina <jkosina@suse.cz>
Cc: Jeff Dike <jdike@addtoit.com>, Andrew Morton <akpm@linux-foundation.org>, user-mode-linux-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig4F69D52EC1DE46203943CD0C
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 01.11.2011 12:09, schrieb Jiri Kosina:
> The kmalloc() call in init_vdso() has reverse order of arguments.
>=20
> Signed-off-by: Jiri Kosina <jkosina@suse.cz>

Dave sent me already a patch:
https://lkml.org/lkml/2011/10/24/388

Thanks,
//richard


--------------enig4F69D52EC1DE46203943CD0C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iQEcBAEBAgAGBQJOr9xjAAoJEN9758yqZn9eAHYH/0u5X9Lwc687Dzl4q0rwsllH
Aay9D0P3ngEMyvzbzuFLZzjV/ehjY2j6HAG+vmZ8GbQ1Qew6TlzgLu9og+DKKqCV
51kA08VoLRTSzuTximtkUqEppiLD7zUpR6bfTfXlSpZr6RuBucPL6aIfbBUAPhZx
re9qKZ2AH0XvSQ378FkE3k+AiVf7F8mjOdWAezCe2QmPwHqV9t81o/BlXOslrG9J
HRMFEidDyO9vEvhE+TnxGVH3cW4voq/q1aBfJ84naBzo7/ZB168KXAJNjbyJn9Oh
UMTwxAARhZZ+70frOrA+zlnf45d/svFsdNmzcPjwJ9QfgCHqI1nBZgeD29pEs8g=
=V7VW
-----END PGP SIGNATURE-----

--------------enig4F69D52EC1DE46203943CD0C--
