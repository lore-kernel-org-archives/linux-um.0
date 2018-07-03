Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from conuserg-09.nifty.com ([210.131.2.76])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1faATa-0003g0-D9
 for linux-um@lists.infradead.org; Tue, 03 Jul 2018 01:51:32 +0000
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH 1/2] x86/build/vdso: remove unused vdso-syms.lds
Date: Tue,  3 Jul 2018 10:50:13 +0900
Message-Id: <1530582614-5173-2-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
References: <1530582614-5173-1-git-send-email-yamada.masahiro@socionext.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Ingo Molnar <mingo@redhat.com>, Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, "H. Peter Anvin" <hpa@zytor.com>

This file contains symbol values, and was originally linked into
vmlinux, but I have no idea what it was actually used for.

Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
not even linked.  Now it is completely orphan, and no problem has
been reported.  It is a proof that this file was not needed in the
first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Acked-by: Richard Weinberger <richard@nod.at>
Acked-by: Ingo Molnar <mingo@kernel.org>
---

 arch/x86/um/vdso/.gitignore |  1 -
 arch/x86/um/vdso/Makefile   | 16 ----------------
 2 files changed, 17 deletions(-)

diff --git a/arch/x86/um/vdso/.gitignore b/arch/x86/um/vdso/.gitignore
index 9cac6d0..f8b69d8 100644
--- a/arch/x86/um/vdso/.gitignore
+++ b/arch/x86/um/vdso/.gitignore
@@ -1,2 +1 @@
-vdso-syms.lds
 vdso.lds
diff --git a/arch/x86/um/vdso/Makefile b/arch/x86/um/vdso/Makefile
index b2d6967..822ccdb 100644
--- a/arch/x86/um/vdso/Makefile
+++ b/arch/x86/um/vdso/Makefile
@@ -53,22 +53,6 @@ $(vobjs): KBUILD_CFLAGS += $(CFL)
 CFLAGS_REMOVE_vdso-note.o = -pg -fprofile-arcs -ftest-coverage
 CFLAGS_REMOVE_um_vdso.o = -pg -fprofile-arcs -ftest-coverage
 
-targets += vdso-syms.lds
-extra-$(VDSO64-y)			+= vdso-syms.lds
-
-#
-# Match symbols in the DSO that look like VDSO*; produce a file of constants.
-#
-sed-vdsosym := -e 's/^00*/0/' \
-	-e 's/^\([0-9a-fA-F]*\) . \(VDSO[a-zA-Z0-9_]*\)$$/\2 = 0x\1;/p'
-quiet_cmd_vdsosym = VDSOSYM $@
-define cmd_vdsosym
-	$(NM) $< | LC_ALL=C sed -n $(sed-vdsosym) | LC_ALL=C sort > $@
-endef
-
-$(obj)/%-syms.lds: $(obj)/%.so.dbg FORCE
-	$(call if_changed,vdsosym)
-
 #
 # The DSO images are built using a special linker script.
 #
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

