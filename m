Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mout.web.de ([217.72.192.78])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oRbMX-0072bV-Mr
	for linux-um@lists.infradead.org; Fri, 26 Aug 2022 15:35:15 +0000
Date: Fri, 26 Aug 2022 15:29:27 +0000
From: Lukas Straub <lukasstraub2@web.de>
Subject: [PATCH 1/2] um: Cleanup syscall_handler_t cast in syscalls_32.h
Message-ID: <20220826152927.193d262c@gecko>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============4546627542126428434=="
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um <linux-um@lists.infradead.org>
Cc: Randy Dunlap <rdunlap@infradead.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, x86@kernel.org, linux-kernel@vger.kernel.org

--===============4546627542126428434==
Content-Type: multipart/signed; boundary="Sig_/2_zsh.QdJpcK7WunS7oTK32";
 protocol="application/pgp-signature"; micalg=pgp-sha256

--Sig_/2_zsh.QdJpcK7WunS7oTK32
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Like in f4f03f299a56ce4d73c5431e0327b3b6cb55ebb9
"um: Cleanup syscall_handler_t definition/cast, fix warning",
remove the cast to to fix the compiler warning.

Signed-off-by: Lukas Straub <lukasstraub2@web.de>
---
 arch/x86/um/shared/sysdep/syscalls_32.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/syscalls_32.h b/arch/x86/um/shared/s=
ysdep/syscalls_32.h
index 68fd2cf526fd..f6e9f84397e7 100644
--- a/arch/x86/um/shared/sysdep/syscalls_32.h
+++ b/arch/x86/um/shared/sysdep/syscalls_32.h
@@ -6,10 +6,9 @@
 #include <asm/unistd.h>
 #include <sysdep/ptrace.h>
=20
-typedef long syscall_handler_t(struct pt_regs);
+typedef long syscall_handler_t(struct syscall_args);
=20
 extern syscall_handler_t *sys_call_table[];
=20
 #define EXECUTE_SYSCALL(syscall, regs) \
-	((long (*)(struct syscall_args)) \
-	 (*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
+	((*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
--=20
2.37.2


--Sig_/2_zsh.QdJpcK7WunS7oTK32
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEg/qxWKDZuPtyYo+kNasLKJxdslgFAmMI5tcACgkQNasLKJxd
sli58g//YFp2irBcbLtEWRCL8FVxCc/fDmNk99rBRasiEUeEQ+l21SkJqqUUIhYe
SxNDovCVZC5pFDJZbSc+a3Gd+GQGNoQojL9V6U4B6JA2r98nzOYg7Demxin2fvm5
BA0ONTLJ4e7J156JSqX9z8lw//sk3vetdhRCFB7qh8fsUlm7dN5je4HxLfG+HRKH
tNWQb8Gp5P29mNDq4YRh95Xv+hMgKbOTPVb/vMLsXv9ZRVU+U2wVK/9vDtf96KgP
7NI8/g1LgcyQ9Efk+jiVjCIrqG20smACCp6mE6yPIuumZIJ7FkqujTd//BdptYns
c6HejzHgNbi2wpSuueV667SE4nKatPmXfqr26ZsVM1MoonImQ6ThN/3Tcb6c5Xtl
SPeafkPv/9UzREQzTdbLy5pW0pzFmyCeqJfTPMzemA553WxNQwfIWrZjbt1Kyuh0
Mx9aKuQ+XK5nquLwG4EdktA3gi6q+KK88UflateXMX4HCyhPuolGNvgY4He1EnVi
IPrabG4xn07xMZXKfBi9VdyDRU8C9VbdmqvY6mA8IBLlszWAZz2lMrveuCnxoMlw
TgWthGHqpm7ec73DL4xhPsUUif4q+lLf2N22ezViwiO+BKCvAVTt7sqnpHWrK6M+
PDWDvhuQYsNvcCJn1Zvw97YQyH/GM0jErNFZKPHDfnc7xOLvmt8=
=jB+v
-----END PGP SIGNATURE-----

--Sig_/2_zsh.QdJpcK7WunS7oTK32--


--===============4546627542126428434==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

--===============4546627542126428434==--


