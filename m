Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12] helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1AnzlD-0001WV-NA
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 03 Feb 2004 04:34:35 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1AnzlC-0005Cm-Tw
	for user-mode-linux-devel@lists.sourceforge.net; Tue, 03 Feb 2004 04:34:35 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040203120505.GA10527@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="r5Pyd7+fXNt84Ff3"
Content-Disposition: inline
Subject: [uml-devel] [patch] uml-fixes-2.6.2-rc3-mm1-A2
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
Date: Tue, 3 Feb 2004 13:05:05 +0100
To: Andrew Morton <akpm@osdl.org>
Cc: Jeff Dike <jdike@addtoit.com>, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net



--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


the attached patch fixes UML on 2.6.2-rc3-mm1:

 - generic: dmapool.o depends on CONFIG_PCI

 - x86: reshuffle the way TASK_SIZE is defined on x86. [UML relied 
        on a specific order of definitions within the x86 header files, 
        the  4/4 patch broke this assumption.]

 - UML: sys_call_table.c: syscall layout changed

 - UML: um_arch.c: handle_sysrq() changed

UML compiles & works fine with this patch applied.

	Ingo

--r5Pyd7+fXNt84Ff3
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uml-fixes-2.6.2-rc3-mm1-A2"

--- linux/drivers/base/Makefile.orig	
+++ linux/drivers/base/Makefile	
@@ -2,7 +2,8 @@
 
 obj-y			:= core.o sys.o interface.o bus.o \
 			   driver.o class.o class_simple.o platform.o \
-			   cpu.o firmware.o init.o map.o dmapool.o
+			   cpu.o firmware.o init.o map.o
+obj-$(CONFIG_PCI)	+= dmapool.o
 obj-y			+= power/
 obj-$(CONFIG_FW_LOADER)	+= firmware_class.o
 obj-$(CONFIG_NUMA)	+= node.o
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
@@ -61,6 +61,7 @@
 #include <asm/e820.h>
 #include <asm/edd.h>    
 #include <asm/page.h>
+#include <asm/processor.h>
 	
 /* Signature words to ensure LILO loaded us right */
 #define SIG1	0xAA55
--- linux/arch/um/kernel/sys_call_table.c.orig	
+++ linux/arch/um/kernel/sys_call_table.c	
@@ -151,7 +151,6 @@ extern syscall_handler_t sys_mlockall;
 extern syscall_handler_t sys_munlockall;
 extern syscall_handler_t sys_sched_setparam;
 extern syscall_handler_t sys_sched_getparam;
-extern syscall_handler_t sys_sched_setscheduler;
 extern syscall_handler_t sys_sched_getscheduler;
 extern syscall_handler_t sys_sched_get_priority_max;
 extern syscall_handler_t sys_sched_get_priority_min;
@@ -275,7 +274,7 @@ extern syscall_handler_t um_mount;
 extern syscall_handler_t um_time;
 extern syscall_handler_t um_stime;
 
-#define LAST_GENERIC_SYSCALL __NR_remap_file_pages
+#define LAST_GENERIC_SYSCALL __NR_sys_fadvise64_64
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
 #define LAST_SYSCALL LAST_GENERIC_SYSCALL
@@ -442,7 +441,7 @@ syscall_handler_t *sys_call_table[] = {
 	[ __NR_munlockall ] = sys_munlockall,
 	[ __NR_sched_setparam ] = sys_sched_setparam,
 	[ __NR_sched_getparam ] = sys_sched_getparam,
-	[ __NR_sched_setscheduler ] = sys_sched_setscheduler,
+	[ __NR_sched_setscheduler ] = (syscall_handler_t *) sys_sched_setscheduler,
 	[ __NR_sched_getscheduler ] = sys_sched_getscheduler,
 	[ __NR_sched_yield ] = (syscall_handler_t *) yield,
 	[ __NR_sched_get_priority_max ] = sys_sched_get_priority_max,
--- linux/arch/um/kernel/um_arch.c.orig	
+++ linux/arch/um/kernel/um_arch.c	
@@ -393,7 +393,7 @@ static int panic_exit(struct notifier_bl
 		      void *unused2)
 {
 #ifdef CONFIG_MAGIC_SYSRQ
-	handle_sysrq('p', &current->thread.regs, NULL, NULL);
+	handle_sysrq('p', &current->thread.regs, NULL);
 #endif
 	machine_halt();
 	return(0);
--- linux/include/asm-i386/page.h.orig	
+++ linux/include/asm-i386/page.h	
@@ -79,30 +79,6 @@ typedef struct { unsigned long pgprot; }
 #define PAGE_ALIGN(addr)	(((addr)+PAGE_SIZE-1)&PAGE_MASK)
 
 /*
- * This handles the memory map.. We could make this a config
- * option, but too many people screw it up, and too few need
- * it.
- *
- * A __PAGE_OFFSET of 0xC0000000 means that the kernel has
- * a virtual address space of one gigabyte, which limits the
- * amount of physical memory you can use to about 950MB. 
- *
- * If you want more physical memory than this then see the CONFIG_HIGHMEM4G
- * and CONFIG_HIGHMEM64G options in the kernel configuration.
- *
- * Note: on PAE the kernel must never go below 32 MB, we use the
- * first 8 entries of the 2-level boot pgd for PAE magic.
- */
-
-#ifdef CONFIG_X86_4G_VM_LAYOUT
-#define __PAGE_OFFSET		(0x02000000)
-#define TASK_SIZE		(0xff000000)
-#else
-#define __PAGE_OFFSET		(0xc0000000)
-#define TASK_SIZE		(0xc0000000)
-#endif
-
-/*
  * This much address space is reserved for vmalloc() and iomap()
  * as well as fixmap mappings.
  */
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

--r5Pyd7+fXNt84Ff3--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
