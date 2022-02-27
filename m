Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH v3 5/7] um: Allow builds with Clang
Date: Sun, 27 Feb 2022 10:45:15 -0800
Message-Id: <20220227184517.504931-6-keescook@chromium.org>
In-Reply-To: <20220227184517.504931-1-keescook@chromium.org>
References: <20220227184517.504931-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Kees Cook <keescook@chromium.org>
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, David Gow <davidgow@google.com>, linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, llvm@lists.linux.dev, "Gustavo A. R. Silva" <gustavoars@kernel.org>, Rasmus Villemoes <linux@rasmusvillemoes.dk>, Vitor Massaru Iha <vitor@massaru.org>, Daniel Latypov <dlatypov@google.com>, Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org, x86@kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Add SUBARCH target for Clang+um (which must go last, not alphabetically,
so the other SUBARCHes are assigned). Remove open-coded "DEFINE"
macro, instead using linux/kbuild.h's version which was updated to use
Clang-friendly assembly in commit cf0c3e68aa81 ("kbuild: fix asm-offset
generation to work with clang"). Redefine "DEFINE_LONGS" in terms of
"COMMENT" and "DEFINE" so that the intended coment actually has useful
content. Add a missed "break" to avoid implicit fall-through warnings.

This lets me run KUnit tests with Clang:

$ ./tools/testing/kunit/kunit.py run --make_options LLVM=1
...

Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>
Cc: Nick Desaulniers <ndesaulniers@google.com>
Cc: Nathan Chancellor <nathan@kernel.org>
Cc: David Gow <davidgow@google.com>
Cc: linux-um@lists.infradead.org
Cc: linux-kbuild@vger.kernel.org
Cc: linux-kselftest@vger.kernel.org
Cc: kunit-dev@googlegroups.com
Cc: llvm@lists.linux.dev
Reviewed-by: Nathan Chancellor <nathan@kernel.org>
Link: https://lore.kernel.org/lkml/Yg2YubZxvYvx7%2Fnm@dev-arch.archlinux-ax161/
Tested-by: David Gow <davidgow@google.com>
Link: https://lore.kernel.org/lkml/CABVgOSk=oFxsbSbQE-v65VwR2+mXeGXDDjzq8t7FShwjJ3+kUg@mail.gmail.com/
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220217002843.2312603-1-keescook@chromium.org
v2: https://lore.kernel.org/lkml/20220224055831.1854786-1-keescook@chromium.org
v3:
 - use kbuild.h to avoid duplication (Masahiro)
 - fix intended comments (Masahiro)
 - use SUBARCH (Nathan)
---
 arch/um/os-Linux/execvp.c  | 1 +
 arch/x86/um/user-offsets.c | 9 ++++-----
 scripts/Makefile.clang     | 1 +
 3 files changed, 6 insertions(+), 5 deletions(-)

diff --git a/arch/um/os-Linux/execvp.c b/arch/um/os-Linux/execvp.c
index 84a0777c2a45..c09a5fd5e225 100644
--- a/arch/um/os-Linux/execvp.c
+++ b/arch/um/os-Linux/execvp.c
@@ -93,6 +93,7 @@ int execvp_noalloc(char *buf, const char *file, char *const argv[])
 					   up finding no executable we can use, we want to diagnose
 					   that we did find one but were denied access.  */
 					got_eacces = 1;
+					break;
 				case ENOENT:
 				case ESTALE:
 				case ENOTDIR:
diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index bae61554abcc..e54a9814ccf1 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -8,12 +8,11 @@
 #define __FRAME_OFFSETS
 #include <linux/ptrace.h>
 #include <asm/types.h>
+#include <linux/kbuild.h>
 
-#define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
-
-#define DEFINE_LONGS(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
+#define DEFINE_LONGS(sym, val)	\
+	COMMENT(#val " / sizeof(unsigned long)");	\
+	DEFINE(sym, val / sizeof(unsigned long))
 
 void foo(void)
 {
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 51fc23e2e9e5..87285b76adb2 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
+CLANG_TARGET_FLAGS_um		:= $(CLANG_TARGET_FLAGS_$(SUBARCH))
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
 
 ifeq ($(CROSS_COMPILE),)
-- 
2.32.0


