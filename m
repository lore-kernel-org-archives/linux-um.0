Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj1Mh-0005Hd-KT for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:16:43 -0800
Received: from mx1.elte.hu ([157.181.1.137])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj1Mg-00075p-V4 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 11:16:43 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040120191706.GA32711@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
Subject: [uml-devel] [patch] uml-fixes-2.6.1-mm5-A1
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
Date: Tue, 20 Jan 2004 20:17:06 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>



--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


Jeff, Andrew,

the attached patch is needed to make UML work on 2.6.1-mm5. It does the 
following things:

 - update UML to the extable changes

 - remove __i386__ kgdb dependency from config.h. The config.h kgdb.h 
   thing is a kludge by itself i think - but this change doesnt make it
   any better. It might break amd64 which has CONFIG_X86 too iirc - but 
   this unbreaks UML compilation.

 - move i386 TASK_SIZE definition from page.h back to processor.h. This 
   was moved to page.h by the 4G/4G patch and there's no reason why we 
   couldnt leave it in processor.h. This unbreaks UML compilation.

 - a top Makefile change broke UML compilation. I'm not sure why, but it 
   makes the difference.

with this patch applied, UML compiles & works fine.

	Ingo

--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uml-fixes-2.6.1-mm5-A1"

--- linux/arch/um/sys-i386/extable.c.orig	
+++ linux/arch/um/sys-i386/extable.c	
@@ -1,30 +0,0 @@
-/*
- * linux/arch/i386/mm/extable.c
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/spinlock.h>
-#include <asm/uaccess.h>
-
-/* Simple binary search */
-const struct exception_table_entry *
-search_extable(const struct exception_table_entry *first,
-	       const struct exception_table_entry *last,
-	       unsigned long value)
-{
-        while (first <= last) {
-		const struct exception_table_entry *mid;
-		long diff;
-
-		mid = (last - first) / 2 + first;
-		diff = mid->insn - value;
-                if (diff == 0)
-                        return mid;
-                else if (diff < 0)
-                        first = mid+1;
-                else
-                        last = mid-1;
-        }
-        return NULL;
-}
--- linux/arch/um/sys-i386/Makefile.orig	
+++ linux/arch/um/sys-i386/Makefile	
@@ -1,4 +1,4 @@
-obj-y = bugs.o checksum.o extable.o fault.o ksyms.o ldt.o ptrace.o \
+obj-y = bugs.o checksum.o fault.o ksyms.o ldt.o ptrace.o \
 	ptrace_user.o semaphore.o sigcontext.o syscalls.o sysrq.o time.o
 
 obj-$(CONFIG_HIGHMEM) += highmem.o
--- linux/include/linux/config.h.orig	
+++ linux/include/linux/config.h	
@@ -2,7 +2,7 @@
 #define _LINUX_CONFIG_H
 
 #include <linux/autoconf.h>
-#if defined(__i386__) && !defined(IN_BOOTLOADER)
+#if defined(CONFIG_X86) && !defined(IN_BOOTLOADER)
 #include <asm/kgdb.h>
 #endif
 
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
@@ -291,6 +291,30 @@ extern unsigned int machine_submodel_id;
 extern unsigned int BIOS_revision;
 extern unsigned int mca_pentium_flag;
 
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
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
  */
--- linux/Makefile.orig	
+++ linux/Makefile	
@@ -404,6 +404,10 @@ endif
 
 include $(srctree)/arch/$(ARCH)/Makefile
 
+# Let architecture Makefiles change CPPFLAGS if needed
+CFLAGS := $(CPPFLAGS) $(CFLAGS)
+AFLAGS := $(CPPFLAGS) $(AFLAGS)
+
 core-y		+= kernel/ mm/ fs/ ipc/ security/ crypto/
 
 SUBDIRS		+= $(patsubst %/,%,$(filter %/, $(init-y) $(init-m) \

--wRRV7LY7NUeQGEoC--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
