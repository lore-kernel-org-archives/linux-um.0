Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kosNM-0006Nm-4R
 for linux-um@lists.infradead.org; Mon, 14 Dec 2020 18:15:12 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v5 4/4] um: allow the use of glibc functions instead of
 builtins
Date: Mon, 14 Dec 2020 18:14:59 +0000
Message-Id: <20201214181459.11096-5-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20201214181459.11096-1-anton.ivanov@cambridgegreys.com>
References: <20201214181459.11096-1-anton.ivanov@cambridgegreys.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: richard@nod.at, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

The UML kernel runs as a normal userspace process and can use most
of glibc string.h functionality instead of built-ins. At present,
when using built-ins, it is also limited to their unoptimized
versions, because it does not have the runtime code patching present
on x86 via apply_alternatives()

Allowing the use of glibc for memcpy, memmove, etc provides 1-5%
boost on common file io as measured by cat and dd. The size of
the linux executable is also reduced by ~10KBytes.

It is possible to turn this on/off via the kernel configuration.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/Kconfig              | 10 ++++++
 arch/um/include/asm/string.h | 70 ++++++++++++++++++++++++++++++++++++
 arch/um/os-Linux/user_syms.c | 29 ++++++++++++---
 arch/x86/um/Makefile         |  6 ++--
 4 files changed, 109 insertions(+), 6 deletions(-)
 create mode 100644 arch/um/include/asm/string.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 6d707122e8d8..9e4503066552 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -192,6 +192,16 @@ config UML_TIME_TRAVEL_SUPPORT
 
 	  It is safe to say Y, but you probably don't need this.
 
+config UML_USE_BUILT_IN_STRINGS
+	bool
+	default N
+	prompt "Use kernel memcpy, memmove, etc"
+	help
+	  UML can use the kernel built in memcpy, memmove, etc functions
+	  or use the glibc equivalents instead.
+	  The glibc equivalents are slightly faster and will result in a
+	  slightly smaller executable when linking UML dynamically.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
diff --git a/arch/um/include/asm/string.h b/arch/um/include/asm/string.h
new file mode 100644
index 000000000000..a65bbbe83083
--- /dev/null
+++ b/arch/um/include/asm/string.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Copyright (C) 2020 Cambridge Greys Ltd.
+ * Copyright (C) 2020 Red Hat Inc.
+ */
+
+#ifndef __ASM_UM_STRING_H
+#define __ASM_UM_STRING_H
+
+#ifndef CONFIG_UML_USE_BUILT_IN_STRINGS
+
+#include <stddef.h>
+
+#define __HAVE_ARCH_STRCPY
+extern char *strcpy(char *dest, const char *src);
+#define __HAVE_ARCH_STRNCPY
+extern char *strncpy(char *dest, const char *src, size_t n);
+#define __HAVE_ARCH_STRCAT
+extern char *strcat(char *dest, const char *src);
+#define __HAVE_ARCH_STRNCAT
+extern char *strncat(char *dest, const char *src, size_t n);
+#define __HAVE_ARCH_STRCMP
+extern int strcmp(const char *s1, const char *s2);
+#define __HAVE_ARCH_STRNCMP
+extern int strncmp(const char *s1, const char *s2, size_t n);
+#define __HAVE_ARCH_STRCHR
+extern char *strchr(const char *s, int c);
+#define __HAVE_ARCH_STRLEN
+extern size_t strlen(const char *s);
+#define __HAVE_ARCH_MEMCPY
+extern void *memcpy(void *dest, const void *src, size_t n);
+#define __HAVE_ARCH_MEMMOVE
+extern void *memmove(void *dest, const void *src, size_t n);
+#define __HAVE_ARCH_MEMCHR
+extern void *memchr(const void *s, int c, size_t n);
+#define __HAVE_ARCH_STRNLEN
+extern size_t strnlen(const char *s, size_t maxlen);
+#define __HAVE_ARCH_STRSTR
+extern char *strstr(const char *haystack, const char *needle);
+#define __HAVE_ARCH_MEMSET
+extern void *memset(void *s, int c, size_t n);
+#define __HAVE_ARCH_STRNCASECMP
+extern int strncasecmp(const char *s1, const char *s2, size_t n);
+#define __HAVE_ARCH_STRCASECMP
+extern int strcasecmp(const char *s1, const char *s2);
+#define __HAVE_ARCH_STRCHRNUL
+extern char *strchrnul(const char *s, int c);
+#define __HAVE_ARCH_STRRCH
+extern char *strchrnul(const char *s, int c);
+#define __HAVE_ARCH_STRSPN
+extern size_t strspn(const char *s, const char *accept);
+#define __HAVE_ARCH_STRCSPN
+extern size_t strcspn(const char *s, const char *reject);
+#define __HAVE_ARCH_STRPBRK
+extern char *strpbrk(const char *s, const char *accept);
+#define __HAVE_ARCH_STRSEP
+extern char *strsep(char **stringp, const char *delim);
+#define __HAVE_ARCH_MEMCMP
+extern int memcmp(const void *s1, const void *s2, size_t n);
+#define __HAVE_ARCH_BCMP
+extern int bcmp(const void *s1, const void *s2, size_t n);
+
+#else
+
+#include <../../x86/include/asm/string.h>
+
+#endif
+
+#endif /* __ASM_UM_STRING_H */
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index 715594fe5719..2e24c9000316 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -9,6 +9,7 @@
  * add an EXPORT for the glibc one.
  */
 
+#ifdef CONFIG_UML_USE_BUILT_IN_STRINGS
 #undef strlen
 #undef strstr
 #undef memcpy
@@ -17,6 +18,7 @@
 extern size_t strlen(const char *);
 extern void *memmove(void *, const void *, size_t);
 extern void *memset(void *, int, size_t);
+#endif
 extern int printf(const char *, ...);
 
 /* If it's not defined, the export is included in lib/string.c.*/
@@ -24,14 +26,33 @@ extern int printf(const char *, ...);
 EXPORT_SYMBOL(strstr);
 #endif
 
-#ifndef __x86_64__
-extern void *memcpy(void *, const void *, size_t);
-EXPORT_SYMBOL(memcpy);
+#ifndef CONFIG_UML_USE_BUILT_IN_STRINGS
+/* These all come from glibc */
+EXPORT_SYMBOL(printf);
+EXPORT_SYMBOL(strcpy);
+EXPORT_SYMBOL(strncpy);
+EXPORT_SYMBOL(strcat);
+EXPORT_SYMBOL(strncat);
+EXPORT_SYMBOL(strcmp);
+EXPORT_SYMBOL(strncmp);
+EXPORT_SYMBOL(strchr);
+EXPORT_SYMBOL(strlen);
+EXPORT_SYMBOL(memchr);
+EXPORT_SYMBOL(strnlen);
+EXPORT_SYMBOL(strncasecmp);
+EXPORT_SYMBOL(strcasecmp);
+EXPORT_SYMBOL(strchrnul);
+EXPORT_SYMBOL(strcspn);
+EXPORT_SYMBOL(strpbrk);
+EXPORT_SYMBOL(strsep);
+EXPORT_SYMBOL(memcmp);
+EXPORT_SYMBOL(bcmp);
+
 #endif
 
+EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memset);
-EXPORT_SYMBOL(printf);
 
 /* Here, instead, I can provide a fake prototype. Yes, someone cares: genksyms.
  * However, the modules will use the CRC defined *here*, no matter if it is
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index 77f70b969d14..453ea23a9770 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -20,14 +20,16 @@ ifeq ($(CONFIG_X86_32),y)
 obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
-subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
+subarch-y = ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
 subarch-y += ../kernel/sys_ia32.o
+subarch-$(CONFIG_UML_USE_BUILT_IN_STRINGS) += ../lib/string_32.o
 
 else
 
 obj-y += syscalls_64.o vdso/
 
-subarch-y = ../lib/csum-partial_64.o ../lib/memcpy_64.o ../entry/thunk_64.o
+subarch-y = ../lib/csum-partial_64.o ../entry/thunk_64.o
+subarch-$(CONFIG_UML_USE_BUILT_IN_STRINGS) += ../lib/memcpy_64.o
 
 endif
 
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

