Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] um: Include kbuild.h instead of duplicating its macros
Date: Mon,  3 Apr 2017 12:54:58 -0700
Message-Id: <20170403195458.112185-1-mka@chromium.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>, "H . Peter Anvin" <hpa@zytor.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-kernel@vger.kernel.org, Matthias Kaehlcke <mka@chromium.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 arch/x86/um/shared/sysdep/kernel-offsets.h | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/arch/x86/um/shared/sysdep/kernel-offsets.h b/arch/x86/um/shared/sysdep/kernel-offsets.h
index 46a9df99f3c5..7e1d35b6ad5c 100644
--- a/arch/x86/um/shared/sysdep/kernel-offsets.h
+++ b/arch/x86/um/shared/sysdep/kernel-offsets.h
@@ -2,16 +2,9 @@
 #include <linux/sched.h>
 #include <linux/elf.h>
 #include <linux/crypto.h>
+#include <linux/kbuild.h>
 #include <asm/mman.h>
 
-#define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define BLANK() asm volatile("\n->" : : )
-
-#define OFFSET(sym, str, mem) \
-	DEFINE(sym, offsetof(struct str, mem));
-
 void foo(void)
 {
 #include <common-offsets.h>
-- 
2.12.2.564.g063fe858b8-goog


