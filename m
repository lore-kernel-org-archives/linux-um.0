Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj1o4-0000zM-D4 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:45:00 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj1o3-0003IG-NQ for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:44:59 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040120194328.GA1518@elte.hu>
References: <20040120191706.GA32711@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="DocE+STaALJfprDB"
Content-Disposition: inline
In-Reply-To: <20040120191706.GA32711@elte.hu>
Subject: [uml-devel] [patch] uml-fixes2-2.6.1-mm5-A0
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Tue, 20 Jan 2004 20:43:28 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>



--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


plus the attached patch is needed ontop of the previous one, to make x86
compile too. (and UML still compiles & works.)

	Ingo

--DocE+STaALJfprDB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uml-fixes2-2.6.1-A0"

--- linux/arch/i386/kernel/head.S.orig	
+++ linux/arch/i386/kernel/head.S	
@@ -13,6 +13,7 @@
 #include <linux/linkage.h>
 #include <asm/segment.h>
 #include <asm/page.h>
+#include <asm/processor.h>
 #include <asm/pgtable.h>
 #include <asm/desc.h>
 #include <asm/cache.h>
--- linux/arch/i386/kernel/vmlinux.lds.S.orig	
+++ linux/arch/i386/kernel/vmlinux.lds.S	
@@ -5,6 +5,7 @@
 #include <asm-generic/vmlinux.lds.h>
 #include <linux/config.h>
 #include <asm/page.h>
+#include <asm/processor.h>
 #include <asm/asm_offsets.h>
 	
 OUTPUT_FORMAT("elf32-i386", "elf32-i386", "elf32-i386")
--- linux/arch/i386/boot/setup.S.orig	
+++ linux/arch/i386/boot/setup.S	
@@ -59,6 +59,7 @@
 #include <asm/e820.h>
 #include <asm/edd.h>    
 #include <asm/page.h>
+#include <asm/processor.h>
 	
 /* Signature words to ensure LILO loaded us right */
 #define SIG1	0xAA55
--- linux/include/asm-i386/processor.h.orig	
+++ linux/include/asm-i386/processor.h	
@@ -7,6 +7,8 @@
 #ifndef __ASM_I386_PROCESSOR_H
 #define __ASM_I386_PROCESSOR_H
 
+#ifndef __ASSEMBLY__
+
 #include <asm/vm86.h>
 #include <asm/math_emu.h>
 #include <asm/segment.h>
@@ -649,4 +651,30 @@ extern void select_idle_routine(const st
 #define ARCH_HAS_SCHED_WAKE_BALANCE
 #endif
 
+#endif /* ! __ASSEMBLY__ */
+
+/*
+ * This handles the memory map.. We could make this a config
+ * option, but too many people screw it up, and too few need
+ * it.
+ *
+ * A __PAGE_OFFSET of 0xC0000000 means that the kernel has
+ * a virtual address space of one gigabyte, which limits the
+ * amount of physical memory you can use to about 950MB. 
+ *
+ * If you want more physical memory than this then see the CONFIG_HIGHMEM4G
+ * and CONFIG_HIGHMEM64G options in the kernel configuration.
+ *
+ * Note: on PAE the kernel must never go below 32 MB, we use the
+ * first 8 entries of the 2-level boot pgd for PAE magic.
+ */
+
+#ifdef CONFIG_X86_4G_VM_LAYOUT
+#define __PAGE_OFFSET		(0x02000000)
+#define TASK_SIZE		(0xff000000)
+#else
+#define __PAGE_OFFSET		(0xc0000000)
+#define TASK_SIZE		(0xc0000000)
+#endif
+
 #endif /* __ASM_I386_PROCESSOR_H */
--- linux/scripts/Makefile.lib.orig	
+++ linux/scripts/Makefile.lib	
@@ -144,7 +144,8 @@ _hostcxx_flags = $(HOSTCXXFLAGS) $(HOST_
 
 
 # If building the kernel in a separate objtree expand all occurrences
-# of -Idir to -I$(srctree)/dir except for absolute paths (starting with '/').
+# of -Idir to -Idir -I$(srctree)/dir.
+# hereby allowing gcc to locate files in both trees. Local tree first.
 
 ifeq ($(KBUILD_SRC),)
 __c_flags	= $(_c_flags)
@@ -153,16 +154,15 @@ __hostc_flags	= $(_hostc_flags)
 __hostcxx_flags	= $(_hostcxx_flags)
 else
 flags = $(foreach o,$($(1)),\
-		$(if $(filter -I%,$(filter-out -I/%,$(o))), \
-		$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
+	$(if $(filter -I%,$(o)),$(patsubst -I%,-I$(srctree)/%,$(o)),$(o)))
 
-# -I$(obj) locates generated .h files
-# -I$(srctree)/$(src) locates .h files in srctree, from generated .c files
-# FIXME: Replace both with specific EXTRA_CFLAGS statements in the makefiles
+# -I$(obj) locate generated .h files
+# -I$(srctree)/$(src) locate .h files in srctree, from generated .c files
+# FIXME: Replace both with specific EXTRA_CFLAGS statements
 __c_flags	= -I$(obj) -I$(srctree)/$(src) $(call flags,_c_flags)
 __a_flags	=                              $(call flags,_a_flags)
 __hostc_flags	= -I$(obj)                     $(call flags,_hostc_flags)
-__hostcxx_flags	= -I$(obj)                     $(call flags,_hostcxx_flags)
+__hostcxx_flags	=                              $(call flags,_hostcxx_flags)
 endif
 
 c_flags        = -Wp,-MD,$(depfile) $(NOSTDINC_FLAGS) $(CPPFLAGS) \
--- linux/Makefile.orig	
+++ linux/Makefile	
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 1
-EXTRAVERSION = -mm5
+EXTRAVERSION =
 
 # *DOCUMENTATION*
 # To see a list of typical targets execute "make help"
@@ -445,10 +445,6 @@ ifdef CONFIG_DEBUG_INFO
 CFLAGS		+= -g
 endif
 
-# Enable unit-at-a-time mode when possible. It shrinks the
-# kernel considerably.
-CFLAGS += $(call check_gcc,-funit-at-a-time,)
-
 # warn about C99 declaration after statement
 CFLAGS += $(call check_gcc,-Wdeclaration-after-statement,)
 

--DocE+STaALJfprDB--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
