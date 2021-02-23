Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lEbSQ-0008HB-JK
 for linux-um@lists.infradead.org; Tue, 23 Feb 2021 17:26:48 +0000
Received: by mail-pj1-x102b.google.com with SMTP id ds5so2419870pjb.2
 for <linux-um@lists.infradead.org>; Tue, 23 Feb 2021 09:26:45 -0800 (PST)
Message-ID: <529cd4e2f39efffb18125dffab3058aeec3351ce.camel@debian.org>
Subject: Re: linux uml segfault
From: Ritesh Raj Sarraf <rrs@debian.org>
Date: Tue, 23 Feb 2021 22:56:37 +0530
In-Reply-To: <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
References: <3448a70e7a39b9c3202aeefa7858ace265b8a978.camel@debian.org>
 <6d37b5aa-36f2-1fce-b70b-8faa0ff882e0@kot-begemot.co.uk>
 <c8bb257c-1542-12f5-89f1-5c1f14b8a70a@collabora.com>
 <db40449e-6916-56bf-377c-01b042b9c890@kot-begemot.co.uk>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: rrs@debian.org
Content-Type: multipart/mixed; boundary="===============0101054678824162383=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>, Christopher Obbard <chris.obbard@collabora.com>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
Cc: 983379@bugs.debian.org


--===============0101054678824162383==
Content-Type: multipart/signed; micalg="pgp-sha512";
	protocol="application/pgp-signature"; boundary="=-esNxet9fZJgNPMVK+cY7"


--=-esNxet9fZJgNPMVK+cY7
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Added the debian bug report in CC.

On Tue, 2021-02-23 at 17:19 +0000, Anton Ivanov wrote:
> > The current Debian user-mode-linux package in unstable is based on
> > the 5.10.5 stable source which includes the mentioned patch, but is
> > still causing an error for some users.
>=20
> After updating the tree to 5.10.5 and applying all Debian patches
> from the package, I cannot reproduce the bug.
>=20
> I am running it on 5.10, 5.2 and 4.19 hosts with the same parameters
> without issues. Hosts are all up to date Debian 10.8 and so is the
> UML userspace.
>=20

Did you mean 5.10, 5.2 and 4.19 (UML) guests ?

We've seen this happen on Debian Testing and Unstable Host (of which
the former would soon be the next stable i.e. Debian Bullseye).

In our tests, when running the same linux uml binary (5.10) on a Debian
Stable Host, it is working fine.


--=20
Ritesh Raj Sarraf | http://people.debian.org/~rrs
Debian - The Universal Operating System

--=-esNxet9fZJgNPMVK+cY7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEQCVDstmIVAB/Yn02pjpYo/LhdWkFAmA1Os0ACgkQpjpYo/Lh
dWnK8A//XKhhhWumcyVfJO5+7UTgEf7oY8mITclgojvBVWCuujwA3CyhL9hLHe1x
bQi9b5Q3htokXf7UUrjUrJJ0FSz4MYU5DMCLqHVmcuscMxD7RfssDHaakOqiANEm
3POd4jLtS1Q6hXlL+efRAhI0Esf5RvZQKBmGH5q24jnF6jRorFxxWEut3NlvFEaT
rALM+M4EYm+kjoJO4gQZYbfLoZ3kAI6f5wciAO0kfJ9djZcR1FTmTkNvnLfgo8J5
pKaAnvXz7N6CaaMl66UUT0CK3rks6w18xpMUW+XXipu0hvCb++p5XYbo/y5EnUFB
3eiscMp91DV7Br6fce17yHHGyuTRCvJCHIADMNEiCdrpkrFGYVJZ8HkyOY6bvo+G
f3f0fqQsoegFMLwtNKdT67hwiftWkV2Dl8e/EIG3c9QicvGd1CnKAGaCrFia01SF
9FQ11Dk8B6GD4CFb3y4tBj5qQ5hef79+EF+ZLkBUugt9ZgPz2XcK8ZdhddR89bDl
ASxxkK4UwV70l8y83c6WN9VZQZhq2wVTfP2PCv00Csu0eNLN3vUe2O/N6mMVAGkx
+uSPuUHg9Ju8Kv49dVNjAJka6s1duxRY58hvTdMHrpmVFrGr0Lv3UEIQEPq1x/dk
eCp5keXiaORHM5KB+KsOR6kUOK4YxFH0FjVGLFbHs4Fgxnektns=
=Fl7T
-----END PGP SIGNATURE-----

--=-esNxet9fZJgNPMVK+cY7--



--===============0101054678824162383==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============0101054678824162383==--



