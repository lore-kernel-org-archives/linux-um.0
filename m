Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj239-00062V-Mu for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 12:00:35 -0800
Received: from mx2.elte.hu ([157.181.151.9])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.30)
	id 1Aj239-000307-41 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 20 Jan 2004 12:00:35 -0800
From: Ingo Molnar <mingo@elte.hu>
Message-ID: <20040120200105.GA2289@elte.hu>
References: <20040120191706.GA32711@elte.hu> <20040120194328.GA1518@elte.hu>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2oS5YaxWCcQjTEyO"
Content-Disposition: inline
In-Reply-To: <20040120194328.GA1518@elte.hu>
Subject: [uml-devel] [patch] uml-fixes2-2.6.1-mm5-A1
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
Date: Tue, 20 Jan 2004 21:01:05 +0100
To: Jeff Dike <jdike@addtoit.com>
Cc: user-mode-linux-devel@lists.sourceforge.net, Andrew Morton <akpm@osdl.org>



--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


> plus the attached patch is needed ontop of the previous one, to make
> x86 compile too. (and UML still compiles & works.)

i've attached uml-fixes2-2.6.1-A1 which is a replacement for the
uml-fixes2-2.6.1-A0 patch - the Makefile.lib and Makefile diffs were
superfluous.

	Ingo

--2oS5YaxWCcQjTEyO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="uml-fixes2-2.6.1-A1"

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

--2oS5YaxWCcQjTEyO--


-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
