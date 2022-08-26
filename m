Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.web.de ([212.227.17.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRbMQ-0072Vr-HW
	for linux-um@lists.infradead.org; Fri, 26 Aug 2022 15:35:07 +0000
Date: Fri, 26 Aug 2022 15:29:13 +0000
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 0/2] um: Fix compiler warnings on x86
Message-ID: <20220826152913.017387dc@gecko>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============3949780248017221710=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um <linux-um@lists.infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, x86@kernel.org, linux-kernel@vger.kernel.org

--===============3949780248017221710==
Content-Type: multipart/signed; boundary="Sig_/3rXaueXT.MEP0yFjLDtrM6n";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/3rXaueXT.MEP0yFjLDtrM6n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hello Everyone,
These patches fix some compiler errors on x86. I tested quickly without any
userspace and it booted fine.

Regards,
Lukas Straub

Lukas Straub (2):
  um: Cleanup syscall_handler_t cast in syscalls_32.h
  um: Cleanup compiler warning in arch/x86/um/tls_32.c

 arch/x86/um/shared/sysdep/syscalls_32.h | 5 ++---
 arch/x86/um/tls_32.c                    | 6 ------
 2 files changed, 2 insertions(+), 9 deletions(-)

--=20
2.37.2

--Sig_/3rXaueXT.MEP0yFjLDtrM6n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmMI5skACgkQNasLKJxd
slgT9BAArDpe55Yrw6Mn1PIH9dHA7KTH/Aisf7A5bAeQqyD7RtUWMFu31o+pcyja
iqnAOtX4nan1Y43/wbPnxdhODcMKVIQvLoC59y34Ey9IVeI0YgAvEhhwAWKAs9zq
WksBjh/MI8vpiwlouvb7RlDdxw4cc9mC0C7yI1SW57Glb7+1n/dQ8STR2V2lq9Yy
DXoCZmq/96+Lcr6mKRIfwg1HtfC1EptLWiMnkWfJDUc2xWumyOzhK7oat1ZZ7tq3
e8h19DjHPYAdJHpLxDtYTMngYNFJ9WWDWqfPIt0grZ07R8jGjzIaIamsTHyGx4lB
C1UQH9w7qf5qCcve3yTKqthNsngnQMcgvgJK5+KsQTtTXisHgjMjMe59LzdwBVwk
TItcTuh471hUMMlfCY/YJvYQ+b9I7qe6NmuFnv+P3/1QtVczNYKNHX/5kLJEJGja
FwV71YufTGdi1VPNlqFdo5hACNeN7FA5KmpZXaP+/fCaOODuDjHs1fdZoXdt830Q
1Wvp76emYObal8bgTj7i7TmC0/xAiakcIRZIh4+j8JRJWXe14E4J+QtjES/XhaQ3
Dauh5SGD2nbiBSUhVF1y8JhAwrkOOJrenPWIukIac0vOZwg5PNi36gRUYGUBVch6
Bw1qdyj2O1QiE1Y2rmcpUIwFfNk/KvKOmDeLrUINOu9N7In6KtM=
=tTlB
-----END PGP SIGNATURE-----

--Sig_/3rXaueXT.MEP0yFjLDtrM6n--


--===============3949780248017221710==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============3949780248017221710==--


