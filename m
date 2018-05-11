Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] um: remove unused vdso-syms.lds
Date: Fri, 11 May 2018 12:47:24 +0900
Message-Id: <1526010444-4305-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Ingo Molnar <mingo@redhat.com>, Nicholas Piggin <npiggin@gmail.com>, x86@kernel.org, Masahiro Yamada <yamada.masahiro@socionext.com>, "H. Peter Anvin" <hpa@zytor.com>, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Philippe Ombredanne <pombredanne@nexb.com>, Kate Stewart <kstewart@linuxfoundation.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

This file contains symbol values, and was originally linked into
vmlinux, but I have no idea what it was actually used for.

Since commit 827880ec260b ("x86/um: thin archives build fix"), it is
not even linked.  Now it is completely orphan, and no problem has
been reported.  It is a proof that this file was not needed in the
first place.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
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
index 1000335..426681e 100644
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


