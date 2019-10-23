Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8ki-0001f3-7z
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 05:00:13 +0000
Received: by mail-pg1-x543.google.com with SMTP id e15so11355977pgu.13
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 22:00:08 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 38/47] Revert "export.h: remove code for prefixing symbols
 with underscore"
Date: Wed, 23 Oct 2019 13:38:12 +0900
Message-Id: <4ad3005234a6ee5444f3e47201b66ae1d0d4266b.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
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
Cc: Octavian Purdila <tavi.purdila@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>

for lkl, mingw32 requires underscore-ed symbols.

This reverts commit 94e58e0ac31284fa26597c0e00a9b1d87a691d02.

Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
---
 include/asm-generic/export.h | 34 ++++++++++++++++++++++------------
 include/linux/export.h       | 23 ++++++++++++++++++-----
 2 files changed, 40 insertions(+), 17 deletions(-)

diff --git a/include/asm-generic/export.h b/include/asm-generic/export.h
index 294d6ae785d4..69ce0914b025 100644
--- a/include/asm-generic/export.h
+++ b/include/asm-generic/export.h
@@ -27,32 +27,42 @@
 #endif
 .endm
 
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+#define KSYM(name) _##name
+#else
+#define KSYM(name) name
+#endif
+
 /*
  * note on .section use: @progbits vs %progbits nastiness doesn't matter,
  * since we immediately emit into those sections anyway.
  */
 .macro ___EXPORT_SYMBOL name,val,sec
 #ifdef CONFIG_MODULES
-	.globl __ksymtab_\name
+	.globl KSYM(__ksymtab_\name)
 	.section ___ksymtab\sec+\name,"a"
 	.balign KSYM_ALIGN
-__ksymtab_\name:
-	__put \val, __kstrtab_\name
+KSYM(__ksymtab_\name):
+	__put \val, KSYM(__kstrtab_\name)
 	.previous
 	.section __ksymtab_strings,"a"
-__kstrtab_\name:
+KSYM(__kstrtab_\name):
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+	.asciz "_\name"
+#else
 	.asciz "\name"
+#endif
 	.previous
 #ifdef CONFIG_MODVERSIONS
 	.section ___kcrctab\sec+\name,"a"
 	.balign KCRC_ALIGN
-__kcrctab_\name:
+KSYM(__kcrctab_\name):
 #if defined(CONFIG_MODULE_REL_CRCS)
-	.long __crc_\name - .
+	.long KSYM(__crc_\name) - .
 #else
-	.long __crc_\name
+	.long KSYM(__crc_\name)
 #endif
-	.weak __crc_\name
+	.weak KSYM(__crc_\name)
 	.previous
 #endif
 #endif
@@ -85,12 +95,12 @@ __ksym_marker_\sym:
 #endif
 
 #define EXPORT_SYMBOL(name)					\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(name),)
+	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)),)
 #define EXPORT_SYMBOL_GPL(name) 				\
-	__EXPORT_SYMBOL(name, KSYM_FUNC(name), _gpl)
+	__EXPORT_SYMBOL(name, KSYM_FUNC(KSYM(name)), _gpl)
 #define EXPORT_DATA_SYMBOL(name)				\
-	__EXPORT_SYMBOL(name, name,)
+	__EXPORT_SYMBOL(name, KSYM(name),)
 #define EXPORT_DATA_SYMBOL_GPL(name)				\
-	__EXPORT_SYMBOL(name, name,_gpl)
+	__EXPORT_SYMBOL(name, KSYM(name),_gpl)
 
 #endif
diff --git a/include/linux/export.h b/include/linux/export.h
index fd8711ed9ac4..34c34d09103c 100644
--- a/include/linux/export.h
+++ b/include/linux/export.h
@@ -10,6 +10,19 @@
  * hackers place grumpy comments in header files.
  */
 
+/* Some toolchains use a `_' prefix for all user symbols. */
+#ifdef CONFIG_HAVE_UNDERSCORE_SYMBOL_PREFIX
+#define __VMLINUX_SYMBOL(x) _##x
+#define __VMLINUX_SYMBOL_STR(x) "_" #x
+#else
+#define __VMLINUX_SYMBOL(x) x
+#define __VMLINUX_SYMBOL_STR(x) #x
+#endif
+
+/* Indirect, so macros are expanded before pasting. */
+#define VMLINUX_SYMBOL(x) __VMLINUX_SYMBOL(x)
+#define VMLINUX_SYMBOL_STR(x) __VMLINUX_SYMBOL_STR(x)
+
 #ifndef __ASSEMBLY__
 #ifdef MODULE
 extern struct module __this_module;
@@ -27,14 +40,14 @@ extern struct module __this_module;
 #if defined(CONFIG_MODULE_REL_CRCS)
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.weak	__crc_" #sym "				\n"	\
-	    "	.long	__crc_" #sym " - .			\n"	\
+	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) " - .	\n"	\
 	    "	.previous					\n");
 #else
 #define __CRC_SYMBOL(sym, sec)						\
 	asm("	.section \"___kcrctab" sec "+" #sym "\", \"a\"	\n"	\
-	    "	.weak	__crc_" #sym "				\n"	\
-	    "	.long	__crc_" #sym "				\n"	\
+	    "	.weak	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
+	    "	.long	" VMLINUX_SYMBOL_STR(__crc_##sym) "	\n"	\
 	    "	.previous					\n");
 #endif
 #else
@@ -80,7 +93,7 @@ struct kernel_symbol {
 	__CRC_SYMBOL(sym, sec)						\
 	static const char __kstrtab_##sym[]				\
 	__attribute__((section("__ksymtab_strings"), used, aligned(1)))	\
-	= #sym;								\
+	= VMLINUX_SYMBOL_STR(#sym);					\
 	__KSYMTAB_ENTRY(sym, sec)
 
 #if defined(__DISABLE_EXPORTS)
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

