Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11] helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.24)
	id 1AVDUd-0003G1-8w
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 09:23:51 -0800
Received: from smtp001.mail.ukl.yahoo.com ([217.12.11.32])
	by sc8-sf-mx1.sourceforge.net with smtp (Exim 4.24)
	id 1AVDUc-0003sj-LX
	for user-mode-linux-devel@lists.sourceforge.net; Sat, 13 Dec 2003 09:23:50 -0800
From: BlaisorBlade <blaisorblade_spam@yahoo.it>
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_jw02/gE1iesbKLb"
Message-Id: <200312131828.03645.blaisorblade_spam@yahoo.it>
Subject: [uml-devel] [PATCH]Modules support in 2.6: reaching the complete fix
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list <user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Sat, 13 Dec 2003 18:28:03 +0100
To: user-mode-linux-devel@lists.sourceforge.net
Cc: jdike@addtoit.com



--Boundary-00=_jw02/gE1iesbKLb
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

I've applied the various modules patches(i.e. apply_alternatives + some 
exports), have added some others, but still make modules complains: no 
unresolved symbols, but CRC are missing(at least with MODVERSIONS enabled; 
I'll try disabling it), and the kernel still panics(I guess that without 
MODVERSION this panic can't at all happen). I'm attaching the patch I built.

I've analized this, and got to the point that:

1) user_ksyms.c bundles a copy of the EXPORT_SYMBOL definition, but it's 
outdated; I've inserted the new one(with appropriate changes, i.e. 
s/CONFIG_/UML_CONFIG/) and it works. This is attached.

Still, the CRC are missing. The CRC symbol are defined, but we need also #2:

2) then, the UML build system is broken for USER_OBJS. The UML Makefiles 
define their own rule for such files. But the needed rule which would be 
needed is much more complex; this means that:
a) the terse output of 2.6 make doesn't appear(we have the complete command 
line)
b) a part of the post-processing needed for modules doesn't work.
Instead of specifying the rule each time, wouldn't it be good something 
such(in pseudo-code, I know there is only foreach in make-language)?

for i in USER_OBJS; do
  CFLAGS_$i+=USER_CFLAGS
done

If you accept, I volunteer to do it(i.e. find how to write this with make and 
do it).

3) When running the kernel, it panics this way:
Kernel panic: kernel BUG at kernel/module.c:1021!
The offending code is:

       if (!__find_symbol("struct_module", &owner, &crc, 1))
                BUG();
        return check_version(sechdrs, versindex, "struct_module", mod,
                             crc);

Though, this symbol is defined. Here the problem is probably that the link 
script is not up-to-date. I've given a look and verified this, but I didn't 
found THE actual error. And for this, I cannot help because I've not enough 
experience with link scripts(I've been able to learn the syntax, but I don't 
know the reason why some section missing in the i386 appear in the UML 
script; some are from libc, but I don't know which ones).

Bye
-- 
cat <<EOSIGN
Paolo Giarrusso, aka Blaisorblade
Linux Kernel 2.4.21/2.6.0-test on an i686; Linux registered user n. 292729
EOSIGN

--Boundary-00=_jw02/gE1iesbKLb
Content-Type: text/x-diff;
  charset="us-ascii";
  name="Module_support.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="Module_support.patch"

--- ./arch/um/kernel/mem.c.modfix	2003-12-02 17:20:43.000000000 +0100
+++ ./arch/um/kernel/mem.c	2003-12-12 18:56:29.000000000 +0100
@@ -119,6 +119,7 @@
 		kmem_top = CHOOSE_MODE(kmem_end_tt, kmem_end_skas);
 	return(kmem_top);
 }
+EXPORT_SYMBOL(get_kmem_end);
 
 #ifdef CONFIG_HIGHMEM
 /* Changed during early boot */
@@ -715,6 +716,7 @@
 
 	return(&mem_map[pfn - region->start_pfn]);
 }
+EXPORT_SYMBOL(pfn_to_page);
 
 unsigned long phys_to_pfn(unsigned long p)
 {
--- ./arch/um/kernel/user_syms.c.modfix	2003-12-02 17:20:43.000000000 +0100
+++ ./arch/um/kernel/user_syms.c	2003-12-13 12:05:17.000000000 +0100
@@ -16,6 +16,62 @@
  * since this includes various user-level headers.
  */
 
+/* Had to update this: this changed in late 2.5 to add CRC and other beasts
+ * and was never updated here- 13 Dec 2003-Blaisorblade*/
+
+/* v850 toolchain uses a `_' prefix for all user symbols */
+#ifndef MODULE_SYMBOL_PREFIX
+#define MODULE_SYMBOL_PREFIX ""
+#endif
+
+struct kernel_symbol
+{
+	unsigned long value;
+	const char *name;
+};
+
+#if !defined(UML_CONFIG_MODULES)
+#define EXPORT_SYMBOL(sym)
+#define EXPORT_SYMBOL_GPL(sym)
+#define EXPORT_SYMBOL_NOVERS(sym)
+
+#else /*UML_CONFIG_MODULES*/
+#ifndef __GENKSYMS__
+#ifdef UML_CONFIG_MODVERSIONS
+/* Mark the CRC weak since genksyms apparently decides not to
+ * generate a checksums for some symbols */
+#define __CRC_SYMBOL(sym, sec)					\
+	extern void *__crc_##sym __attribute__((weak));		\
+	static const unsigned long __kcrctab_##sym		\
+	__attribute__((section("__kcrctab" sec), unused))	\
+	= (unsigned long) &__crc_##sym;
+#else
+#define __CRC_SYMBOL(sym, sec)
+#endif
+
+/* For every exported symbol, place a struct in the __ksymtab section */
+#define __EXPORT_SYMBOL(sym, sec)				\
+	__CRC_SYMBOL(sym, sec)					\
+	static const char __kstrtab_##sym[]			\
+	__attribute__((section("__ksymtab_strings")))		\
+	= MODULE_SYMBOL_PREFIX #sym;                    	\
+	static const struct kernel_symbol __ksymtab_##sym	\
+	__attribute__((section("__ksymtab" sec), unused))	\
+	= { (unsigned long)&sym, __kstrtab_##sym }
+
+#define EXPORT_SYMBOL(sym)					\
+	__EXPORT_SYMBOL(sym, "")
+
+#define EXPORT_SYMBOL_GPL(sym)					\
+	__EXPORT_SYMBOL(sym, "_gpl")
+
+#endif
+
+/* We don't mangle the actual symbol anymore, so no need for
+ * special casing EXPORT_SYMBOL_NOVERS.  FIXME: Deprecated */
+#define EXPORT_SYMBOL_NOVERS(sym) EXPORT_SYMBOL(sym)
+#endif
+#if 0
 struct module_symbol
 {
 	unsigned long value;
@@ -57,6 +113,7 @@
 #define EXPORT_SYMBOL_NOVERS(var)  __EXPORT_SYMBOL(var, __MODULE_STRING(var))
 
 #endif
+#endif
 
 EXPORT_SYMBOL(__errno_location);
 
@@ -109,5 +166,7 @@
 
 EXPORT_SYMBOL(memset);
 EXPORT_SYMBOL(strstr);
+EXPORT_SYMBOL(printf);
+EXPORT_SYMBOL(strlen);
 
 EXPORT_SYMBOL(find_iomem);
--- ./include/asm-um/common.lds.S.modfix	2003-12-02 17:20:44.000000000 +0100
+++ ./include/asm-um/common.lds.S	2003-12-13 17:53:09.000000000 +0100
@@ -15,18 +15,6 @@
 
   RODATA
 
-  __start___ksymtab = .;	/* Kernel symbol table */
-  __ksymtab : { *(__ksymtab) }
-  __stop___ksymtab = .;
-
-  __start___gpl_ksymtab = .;	/* Kernel symbol table:	GPL-only symbols */
-  __gpl_ksymtab : { *(__gpl_ksymtab) }
-  __stop___gpl_ksymtab = .;
-
-  __start___kallsyms = .;       /* All kernel symbols */
-  __kallsyms : { *(__kallsyms) }
-  __stop___kallsyms = .;
-
   .unprotected : { *(.unprotected) }
   . = ALIGN(4096);
   PROVIDE (_unprotected_end = .);

--Boundary-00=_jw02/gE1iesbKLb--



-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
