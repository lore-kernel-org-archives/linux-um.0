Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: [PATCH] um: remove -fno-unit-at-a-time workaround for pre-4.0 GCC
Date: Mon, 27 Aug 2018 13:03:04 +0900
Message-Id: <1535342584-22174-1-git-send-email-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Commit cafa0010cd51 ("Raise the minimum required gcc version to 4.6")
bumped the minimum GCC version to 4.6 for all architectures.

'$(call cc-option,-fno-unit-at-a-time)' is now dead code since
'$(cc-version) -lt 0400' is always false.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
---

 arch/x86/Makefile.um | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/arch/x86/Makefile.um b/arch/x86/Makefile.um
index 91085a0..577976b 100644
--- a/arch/x86/Makefile.um
+++ b/arch/x86/Makefile.um
@@ -26,12 +26,8 @@ cflags-y += $(call cc-option,-mpreferred-stack-boundary=2)
 # an unresolved reference.
 cflags-y += -ffreestanding
 
-# Disable unit-at-a-time mode on pre-gcc-4.0 compilers, it makes gcc use
-# a lot more stack due to the lack of sharing of stacklots.  Also, gcc
-# 4.3.0 needs -funit-at-a-time for extern inline functions.
-KBUILD_CFLAGS += $(shell if [ $(cc-version) -lt 0400 ] ; then \
-			echo $(call cc-option,-fno-unit-at-a-time); \
-			else echo $(call cc-option,-funit-at-a-time); fi ;)
+# gcc 4.3.0 needs -funit-at-a-time for extern inline functions.
+KBUILD_CFLAGS += $(call cc-option,-funit-at-a-time)
 
 KBUILD_CFLAGS += $(cflags-y)
 
-- 
2.7.4


