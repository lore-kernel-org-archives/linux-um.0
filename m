Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Sasha Levin <Alexander.Levin@microsoft.com>
Subject: [PATCH AUTOSEL for 4.9 187/293] x86/um: thin archives build fix
Date: Mon, 9 Apr 2018 00:25:20 +0000
Message-ID: <20180409002239.163177-187-alexander.levin@microsoft.com>
References: <20180409002239.163177-1-alexander.levin@microsoft.com>
In-Reply-To: <20180409002239.163177-1-alexander.levin@microsoft.com>
Content-Language: en-US
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
To: "stable@vger.kernel.org" <stable@vger.kernel.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Nicholas Piggin <npiggin@gmail.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>, Masahiro Yamada <yamada.masahiro@socionext.com>, Sasha Levin <Alexander.Levin@microsoft.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Nicholas Piggin <npiggin@gmail.com>

[ Upstream commit 827880ec260ba048f95fe646b96a205c394fa0f0 ]

The linker does not like vdso-syms.lds in input archive files.
Make it an extra-y instead.

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: user-mode-linux-devel@lists.sourceforge.net
Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Sasha Levin <alexander.levin@microsoft.com>
---
 arch/x86/um/vdso/Makefile | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index d72dec406ccb..329406224330 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -53,7 +53,7 @@ CFLAGS_REMOVE_vdso-note.o =3D -pg -fprofile-arcs -ftest-c=
overage
 CFLAGS_REMOVE_um_vdso.o =3D -pg -fprofile-arcs -ftest-coverage
=20
 targets +=3D vdso-syms.lds
-obj-$(VDSO64-y)			+=3D vdso-syms.lds
+extra-$(VDSO64-y)			+=3D vdso-syms.lds
=20
 #
 # Match symbols in the DSO that look like VDSO*; produce a file of constan=
ts.
--=20
2.15.1

