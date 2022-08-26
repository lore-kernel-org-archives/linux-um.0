Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.web.de ([212.227.17.12])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRbMe-0072eq-OA
	for linux-um@lists.infradead.org; Fri, 26 Aug 2022 15:35:22 +0000
Date: Fri, 26 Aug 2022 15:29:31 +0000
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 2/2] um: Cleanup compiler warning in arch/x86/um/tls_32.c
Message-ID: <20220826152931.5835fdf8@gecko>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============2692410671515588002=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um <linux-um@lists.infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, x86@kernel.org, linux-kernel@vger.kernel.org

--===============2692410671515588002==
Content-Type: multipart/signed; boundary="Sig_/LZycpH1Xjhw3hn5+7RWproQ";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/LZycpH1Xjhw3hn5+7RWproQ
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

arch.tls_array is statically allocated so checking for NULL doesn't
make sense. This causes the compiler warning below.

Remove the checks to silence these warnings.

../arch/x86/um/tls_32.c: In function 'get_free_idx':
../arch/x86/um/tls_32.c:68:13: warning: the comparison will always evaluate=
 as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
   68 |         if (!t->arch.tls_array)
      |             ^
In file included from ../arch/x86/um/asm/processor.h:10,
                 from ../include/linux/rcupdate.h:30,
                 from ../include/linux/rculist.h:11,
                 from ../include/linux/pid.h:5,
                 from ../include/linux/sched.h:14,
                 from ../arch/x86/um/tls_32.c:7:
../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
   22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
      |                               ^~~~~~~~~
../arch/x86/um/tls_32.c: In function 'get_tls_entry':
../arch/x86/um/tls_32.c:243:13: warning: the comparison will always evaluat=
e as 'true' for the address of 'tls_array' will never be NULL [-Waddress]
  243 |         if (!t->arch.tls_array)
      |             ^
../arch/x86/um/asm/processor_32.h:22:31: note: 'tls_array' declared here
   22 |         struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
      |                               ^~~~~~~~~

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 arch/x86/um/tls_32.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/x86/um/tls_32.c b/arch/x86/um/tls_32.c
index ac8eee093f9c..66162eafd8e8 100644
--- a/arch/x86/um/tls_32.c
+++ b/arch/x86/um/tls_32.c
@@ -65,9 +65,6 @@ static int get_free_idx(struct task_struct* task)
 	struct thread_struct *t =3D &task->thread;
 	int idx;
=20
-	if (!t->arch.tls_array)
-		return GDT_ENTRY_TLS_MIN;
-
 	for (idx =3D 0; idx < GDT_ENTRY_TLS_ENTRIES; idx++)
 		if (!t->arch.tls_array[idx].present)
 			return idx + GDT_ENTRY_TLS_MIN;
@@ -240,9 +237,6 @@ static int get_tls_entry(struct task_struct *task, stru=
ct user_desc *info,
 {
 	struct thread_struct *t =3D &task->thread;
=20
-	if (!t->arch.tls_array)
-		goto clear;
-
 	if (idx < GDT_ENTRY_TLS_MIN || idx > GDT_ENTRY_TLS_MAX)
 		return -EINVAL;
=20
--=20
2.37.2

--Sig_/LZycpH1Xjhw3hn5+7RWproQ
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmMI5tsACgkQNasLKJxd
sli3qRAAkgRBGEM2oxLpbfJhsLdW21G4iDuBKV5sUnRsRzt2Wgxx8osNg28GNg+k
xsM+8Fr2Qnjgqci8p5sIB4sqGxr5sAl3Lof7KTo2JfSs/i6pkAf4i2aXQo/8lmHd
8lQPxzmSn6oWkGyfLYNxSMZG3ax7B1sx4tjMomaAoqF6jp0pzU9m3Kx3+c5Pw2U0
waPRbj0R4pELzFzAinqW+tU815/UxtScYVGIJtGX5mNa0q1Nywm9iHdx7Ay2x2Bw
QmuhfjCOQIt3hvAebILiYFLV7GBLrr93pEvnQOaozW+oHjXsM1uEXM3qCuAD/7ti
BNpVoTTiCaNKO1PvnGpiYzky67WbsUchbSJrDcpBIPBL1NL9JDKr72B1Dg+WAUHH
ae55V9qaye07Bg8+MiEgzGoMvE6tb4lcA6m7zhO/4uaQVv2CpNpUHNX9jyY1i3/R
9PnR62D+kWkiqsRW5CL/bAA5mtDbkQ8gu+bov3M2IvceC9aAQe1sam5sxqcQqcFK
CQRqAcv6hcVUx30JqLv1clx7JZwdpVrXA3DE+N2O3IKnE8xO247uAoOQ0r2Db8v3
0964pe4JOjYprIDVyFrKAFFkntSvga5t+zJf0ZCVECn7t4IgN8xad7ar/+Yzcy2b
FX0PVBW9FG0Vces/8byR1B/+mBwjEbb96RFK5jvQ294gXRg9LsA=
=y+Wt
-----END PGP SIGNATURE-----

--Sig_/LZycpH1Xjhw3hn5+7RWproQ--


--===============2692410671515588002==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============2692410671515588002==--


