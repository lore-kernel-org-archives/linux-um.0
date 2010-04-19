Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <4BCC07C0.5050601@web.de>
Date: Mon, 19 Apr 2010 09:35:28 +0200
From: Jan Kiszka <jan.kiszka@web.de>
MIME-Version: 1.0
Subject: Re: [PATCH] uml: Fix build breakage after slab.h changes
References: <4BCB353A.3040806@web.de> <4BCB788E.2040501@kernel.org>
In-Reply-To: <4BCB788E.2040501@kernel.org>
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigECEAA47507809F97268BA43A"
Sender: linux-kernel-owner@vger.kernel.org
To: Tejun Heo <tj@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, user-mode-linux-devel@lists.sourceforge.net, Tiger Yang <tiger.yang@oracle.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigECEAA47507809F97268BA43A
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Tejun Heo wrote:
> Hello,
>=20
> On 04/19/2010 01:37 AM, Jan Kiszka wrote:
>> We now have to to include linux/slab.h explicitly for kmalloc & friend=
s.
>> Files that build against host headers already get their prototypes via=

>> um_malloc.h, linux/slab.h may even be unavailable.
>=20
> Hmmm... my test um build was okay but I don't know much about details
> of um builds.=20

We may use different configs. Also, your userland includes have to lack
slab.h.

> I suppose this patch will go through um tree?

Good question. Does such a tree exist? I'm sitting on a few more um
cleanups & fixes, and so far I'm working against Linus' tree as I failed
to find anything more recent.

Jan


--------------enigECEAA47507809F97268BA43A
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.9 (GNU/Linux)
Comment: Using GnuPG with SUSE - http://enigmail.mozdev.org

iEYEARECAAYFAkvMB8AACgkQitSsb3rl5xSVZgCfVGI6pJXVFibUZ6Gbuy1Ue1BY
VK0An00HqFcHT7Bv2Oi7vp8v1ceZtr1s
=LFFY
-----END PGP SIGNATURE-----

--------------enigECEAA47507809F97268BA43A--
