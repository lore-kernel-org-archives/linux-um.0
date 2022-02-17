Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] um: Allow builds with Clang
Date: Wed, 16 Feb 2022 16:28:43 -0800
Message-Id: <20220217002843.2312603-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Masahiro Yamada <masahiroy@kernel.org>, Nick Desaulniers <ndesaulniers@google.com>, Nathan Chancellor <nathan@kernel.org>, David Gow <davidgow@google.com>, linux-um@lists.infradead.org, linux-kbuild@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, llvm@lists.linux.dev, linux-kernel@vger.kernel.org, x86@kernel.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Add x86-64 target for Clang+um and update user-offsets.c to use
Clang-friendly assembler, similar to the fix from commit cf0c3e68aa81
("kbuild: fix asm-offset generation to work with clang").

This lets me run KUnit tests with Clang:

$ ./tools/testing/kunit/kunit.py config --make_options LLVM=1
...
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
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/x86/um/user-offsets.c | 4 ++--
 scripts/Makefile.clang     | 1 +
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/x86/um/user-offsets.c b/arch/x86/um/user-offsets.c
index bae61554abcc..d9071827b515 100644
--- a/arch/x86/um/user-offsets.c
+++ b/arch/x86/um/user-offsets.c
@@ -10,10 +10,10 @@
 #include <asm/types.h>
 
 #define DEFINE(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val))
 
 #define DEFINE_LONGS(sym, val) \
-	asm volatile("\n->" #sym " %0 " #val : : "i" (val/sizeof(unsigned long)))
+	asm volatile("\n.ascii \"->" #sym " %0 " #val "\"": : "i" (val/sizeof(unsigned long)))
 
 void foo(void)
 {
diff --git a/scripts/Makefile.clang b/scripts/Makefile.clang
index 51fc23e2e9e5..857b23de51c6 100644
--- a/scripts/Makefile.clang
+++ b/scripts/Makefile.clang
@@ -10,6 +10,7 @@ CLANG_TARGET_FLAGS_powerpc	:= powerpc64le-linux-gnu
 CLANG_TARGET_FLAGS_riscv	:= riscv64-linux-gnu
 CLANG_TARGET_FLAGS_s390		:= s390x-linux-gnu
 CLANG_TARGET_FLAGS_x86		:= x86_64-linux-gnu
+CLANG_TARGET_FLAGS_um		:= x86_64-linux-gnu
 CLANG_TARGET_FLAGS		:= $(CLANG_TARGET_FLAGS_$(SRCARCH))
 
 ifeq ($(CROSS_COMPILE),)
-- 
2.30.2


