Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kees Cook <keescook@chromium.org>
Subject: [PATCH] um: Enable FORTIFY_SOURCE
Date: Wed,  9 Feb 2022 16:32:24 -0800
Message-Id: <20220210003224.773957-1-keescook@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To: Jeff Dike <jdike@addtoit.com>
Cc: Kees Cook <keescook@chromium.org>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, David Gow <davidgow@google.com>, linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com, linux-um@lists.infradead.org, linux-hardening@vger.kernel.org
List-ID: <linux-um.lists.infradead.org>

Enable FORTIFY_SOURCE so running Kunit tests can test fortified
functions.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 arch/um/Kconfig              | 1 +
 arch/um/os-Linux/user_syms.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4d398b80aea8..746e661395d7 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -9,6 +9,7 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
+	select ARCH_HAS_FORTIFY_SOURCE
 	select ARCH_NO_PREEMPT
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 715594fe5719..d9845b5219ce 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -1,4 +1,5 @@
 // SPDX-License-Identifier: GPL-2.0
+#define __NO_FORTIFY
 #include <linux/types.h>
 #include <linux/module.h>
 
-- 
2.30.2


