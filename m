Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcWXd-00077W-1f
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 16:30:46 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] um: allow using glibc string functions instead of generics
Date: Tue, 10 Nov 2020 16:30:34 +0000
Message-Id: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
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

UML kernel runs as a normal userspace process and can use the
optimized glibc strings functions like strcpy, memcpy, etc.

The support is optional and is turned on/of using a config
option.

Using glibc functions results in a slightly smaller executable
when linked dynamically as well as anything between 1% and 5%
performance improvements.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/Kconfig                    | 11 +++++
 arch/um/include/asm/string.h       | 72 +++++++++++++++++++++++++++
 arch/um/include/shared/os_string.h | 30 ++++++++++++
 arch/um/os-Linux/Makefile          |  4 +-
 arch/um/os-Linux/string.c          | 78 ++++++++++++++++++++++++++++++
 5 files changed, 193 insertions(+), 2 deletions(-)
 create mode 100644 arch/um/include/asm/string.h
 create mode 100644 arch/um/include/shared/os_string.h
 create mode 100644 arch/um/os-Linux/string.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4b799fad8b48..961cf3af3ff0 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -189,6 +189,17 @@ config UML_TIME_TRAVEL_SUPPORT
 
 	  It is safe to say Y, but you probably don't need this.
 
+config UML_USE_HOST_STRINGS
+	bool
+	default y
+	prompt "Use glibc strings and memory functions"
+	help
+	  UML runs as a normal userspace process. As a result it can use
+	  the optimized strcpy, memcpy, etc from glibc instead of the
+          kernel generic equivalents. This provides some minimal speedup
+	  in the 1% or so range for most applications. It also results in
+	  a smaller executable.
+
 endmenu
 
 source "arch/um/drivers/Kconfig"
diff --git a/arch/um/include/asm/string.h b/arch/um/include/asm/string.h
new file mode 100644
index 000000000000..1fba8d59afe5
--- /dev/null
+++ b/arch/um/include/asm/string.h
@@ -0,0 +1,72 @@
+#ifndef __ASM_UM_STRING_H
+#define __ASM_UM_STRING_H
+
+#ifdef CONFIG_UML_USE_HOST_STRINGS
+
+/* UML saves and restores registers when going to/from
+ * userspace. This allows the use of normal userspace
+ * functions for strings with all relevant glibc processor
+ * optimizations
+ */
+
+#include <os_string.h>
+
+#define __HAVE_ARCH_STRCPY
+
+#define strcpy(dest, src) os_strcpy(dest, src);
+
+#define __HAVE_ARCH_STRNCPY
+
+#define strncpy(dest, src, count) os_strncpy(dest, src, count)
+
+#define __HAVE_ARCH_STRCAT
+
+#define strcat(dest, src) os_strcat(dest, src)
+
+#define __HAVE_ARCH_STRNCAT
+
+#define strncat(dest, src, count) os_strncat(dest, src, count)
+
+#define __HAVE_ARCH_STRCMP
+
+#define strcmp(cs, ct) os_strcmp(cs, ct)
+
+#define __HAVE_ARCH_STRNCMP
+
+#define strncmp(cs, ct, count) os_strncmp(cs, ct, count) 
+
+#define __HAVE_ARCH_STRCHR
+
+#define strchr(s, c) os_strchr(s, c)
+
+#define __HAVE_ARCH_STRLEN
+
+#define strlen(s) os_strlen(s)
+
+#define __HAVE_ARCH_MEMCPY
+
+#define memcpy(dst, src, n) os_memcpy(dst, src, n)
+
+#define __HAVE_ARCH_MEMMOVE
+
+#define memmove(dest, src, n) os_memmove(dest, src, n)
+
+#define __HAVE_ARCH_MEMCHR
+
+#define memchr(cs, c, count) os_memchr(cs, c, count)
+
+#define __HAVE_ARCH_STRNLEN
+
+#define strnlen(s, count) os_strnlen(s, count)
+
+#define __HAVE_ARCH_STRSTR
+
+#define strstr(cs, ct) os_strstr(cs, ct)
+
+#define __HAVE_ARCH_MEMSET
+
+#define memset(dst, c, n) os_memset(dst, c, n)
+
+#endif
+
+#endif /* __ASM_GENERIC_STRING_H */
diff --git a/arch/um/include/shared/os_string.h b/arch/um/include/shared/os_string.h
new file mode 100644
index 000000000000..b9662f622e77
--- /dev/null
+++ b/arch/um/include/shared/os_string.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2015 Anton Ivanov (aivanov@{brocade.com,kot-begemot.co.uk})
+ * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
+ * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+
+#ifndef __OS_STRING_H__
+#define __OS_STRING_H__
+
+#include <stddef.h>
+
+/* string.c */
+
+extern char *os_strcpy(char *dest, const char *src);
+extern char *os_strncpy(char *dest, const char *src, size_t count);
+extern char *os_strcat(char *dest, const char *src);
+extern char *os_strncat(char *dest, const char *src, size_t count);
+extern int os_strcmp(const char *cs, const char *ct);
+extern int os_strncmp(const char *cs, const char *ct, size_t count);
+extern char *os_strchr(const char *s, int c);
+extern size_t os_strlen(const char *s);
+extern void *os_memcpy(void *dest, const void *src, size_t n);
+extern void *os_memmove(void *dest, const void *src, size_t n);
+extern void *os_memchr(const void *cs, int c, size_t count);
+extern size_t os_strnlen(const char *s, size_t count);
+extern char *os_strstr(const char *cs, const char *ct);
+extern void *os_memset(void *s, int c, size_t n);
+
+#endif
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index 839915b8c31c..f117f2514191 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -8,12 +8,12 @@ KCOV_INSTRUMENT                := n
 
 obj-y = execvp.o file.o helper.o irq.o main.o mem.o process.o \
 	registers.o sigio.o signal.o start_up.o time.o tty.o \
-	umid.o user_syms.o util.o drivers/ skas/
+	umid.o user_syms.o util.o string.o drivers/ skas/
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
-	tty.o umid.o util.o
+	tty.o umid.o util.o string.o
 
 include arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/string.c b/arch/um/os-Linux/string.c
new file mode 100644
index 000000000000..abc76e2aecb3
--- /dev/null
+++ b/arch/um/os-Linux/string.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ */
+
+#include <stddef.h>
+#include <unistd.h>
+#include <string.h>
+#include <os_string.h>
+
+inline char *os_strcpy(char *dest, const char *src)
+{
+	return strcpy(dest, src);
+}
+
+inline char *os_strncpy(char *dest, const char *src, size_t count)
+{
+	return strncpy(dest, src, count);
+}
+
+inline char *os_strcat(char *dest, const char *src)
+{
+	return strcat(dest, src);
+}
+inline char *os_strncat(char *dest, const char *src, size_t count)
+{
+	return strncat(dest, src, count);
+}
+
+inline int os_strcmp(const char *cs, const char *ct)
+{
+	return strcmp(cs, ct);
+}
+
+inline int os_strncmp(const char *cs, const char *ct, size_t count)
+{
+	return strncmp(cs, ct, count);
+}
+
+inline char *os_strchr(const char *s, int c)
+{
+	return strchr(s, c);
+}
+inline size_t os_strlen(const char *s)
+{
+	return strlen(s);
+}
+
+inline void *os_memcpy(void *dest, const void *src, size_t n)
+{
+	return memcpy(dest, src, n);
+}
+
+inline void *os_memmove(void *dest, const void *src, size_t n)
+{
+	return memmove(dest, src, n);
+}
+	
+inline void *os_memchr(const void *cs, int c, size_t count)
+{
+	return memchr(cs, c, count);
+}
+
+inline size_t os_strnlen(const char *s, size_t count)
+{
+	return strnlen(s, count);
+}
+
+inline char *os_strstr(const char *cs, const char *ct)
+{
+	return strstr(cs, ct);
+}
+
+inline void *os_memset(void *s, int c, size_t n)
+{
+	return memset(s, c, n);
+}
+
-- 
2.20.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

