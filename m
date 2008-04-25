Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSA1-0003ko-GN for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:37 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpS9x-0000ra-Kf
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:37 -0700
Date: Fri, 25 Apr 2008 13:56:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175617.GA11206@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 18/19] UML - use PAGE_SIZE in linker scripts
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>
Cc: Cyrill Gorcunov <gorcunov@gmail.com>

From: Cyrill Gorcunov <gorcunov@gmail.com>

This patch includes page.h header into liker scripts that
allow us to use PAGE_SIZE macro instead of numeric constant.

To be able to include page.h into linker scripts page.h is
needed for some modification - i.e. we need to use __ASSEMBLY__
and _AC macro

[ jdike@linux.intel.com - fixed conflict with as-layout.h ]

Signed-off-by: Cyrill Gorcunov <gorcunov@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/as-layout.h |   14 +++++++-------
 arch/um/kernel/dyn.lds.S    |    7 ++++---
 arch/um/kernel/uml.lds.S    |    7 ++++---
 include/asm-um/page.h       |   17 +++++++++++------
 4 files changed, 26 insertions(+), 19 deletions(-)

Index: linux-2.6-git/arch/um/kernel/dyn.lds.S
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/dyn.lds.S	2008-04-24 16:51:07.000000000 -0400
+++ linux-2.6-git/arch/um/kernel/dyn.lds.S	2008-04-24 17:07:28.000000000 -0400
@@ -1,4 +1,5 @@
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
 
 OUTPUT_FORMAT(ELF_FORMAT)
 OUTPUT_ARCH(ELF_ARCH)
@@ -21,7 +22,7 @@ SECTIONS
 	_einittext = .;
   }
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
 
   /* Read-only sections, merged into text segment: */
   .hash           : { *(.hash) }
@@ -68,9 +69,9 @@ SECTIONS
     /* .gnu.warning sections are handled specially by elf32.em.  */
     *(.gnu.warning)
 
-    . = ALIGN(4096);
+    . = ALIGN(PAGE_SIZE);
   } =0x90909090
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   .syscall_stub : {
 	__syscall_stub_start = .;
 	*(.__syscall_stub*)
Index: linux-2.6-git/arch/um/kernel/uml.lds.S
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/uml.lds.S	2008-04-24 16:51:07.000000000 -0400
+++ linux-2.6-git/arch/um/kernel/uml.lds.S	2008-04-24 17:07:28.000000000 -0400
@@ -1,4 +1,5 @@
 #include <asm-generic/vmlinux.lds.h>
+#include <asm/page.h>
 
 OUTPUT_FORMAT(ELF_FORMAT)
 OUTPUT_ARCH(ELF_ARCH)
@@ -26,7 +27,7 @@ SECTIONS
 	INIT_TEXT
 	_einittext = .;
   }
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
 
   .text      :
   {
@@ -39,7 +40,7 @@ SECTIONS
     *(.gnu.linkonce.t*)
   }
 
-  . = ALIGN(4096);
+  . = ALIGN(PAGE_SIZE);
   .syscall_stub : {
 	__syscall_stub_start = .;
 	*(.__syscall_stub*)
@@ -79,7 +80,7 @@ SECTIONS
   .sdata     : { *(.sdata) }
   _edata  =  .;
   PROVIDE (edata = .);
-  . = ALIGN(0x1000);
+  . = ALIGN(PAGE_SIZE);
   .sbss      :
   {
    __bss_start = .;
Index: linux-2.6-git/include/asm-um/page.h
===================================================================
--- linux-2.6-git.orig/include/asm-um/page.h	2008-04-24 16:51:07.000000000 -0400
+++ linux-2.6-git/include/asm-um/page.h	2008-04-24 17:07:28.000000000 -0400
@@ -7,16 +7,20 @@
 #ifndef __UM_PAGE_H
 #define __UM_PAGE_H
 
-struct page;
-
-#include <linux/types.h>
-#include <asm/vm-flags.h>
+#include <linux/const.h>
 
 /* PAGE_SHIFT determines the page size */
 #define PAGE_SHIFT	12
-#define PAGE_SIZE	(1UL << PAGE_SHIFT)
+#define PAGE_SIZE	(_AC(1, UL) << PAGE_SHIFT)
 #define PAGE_MASK	(~(PAGE_SIZE-1))
 
+#ifndef __ASSEMBLY__
+
+struct page;
+
+#include <linux/types.h>
+#include <asm/vm-flags.h>
+
 /*
  * These are used to make use of C type-checking..
  */
@@ -120,4 +124,5 @@ extern struct page *arch_validate(struct
 #include <asm-generic/memory_model.h>
 #include <asm-generic/page.h>
 
-#endif
+#endif	/* __ASSEMBLY__ */
+#endif	/* __UM_PAGE_H */
Index: linux-2.6-git/arch/um/include/as-layout.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/as-layout.h	2008-04-24 16:51:07.000000000 -0400
+++ linux-2.6-git/arch/um/include/as-layout.h	2008-04-24 17:08:16.000000000 -0400
@@ -23,16 +23,16 @@
  */
 
 #ifdef __ASSEMBLY__
-#define _AC(X, Y)	(Y)
+#define _UML_AC(X, Y)	(Y)
 #else
-#define __AC(X, Y)	(X (Y))
-#define _AC(X, Y)	__AC(X, Y)
+#define __UML_AC(X, Y)	(X(Y))
+#define _UML_AC(X, Y)	__UML_AC(X, Y)
 #endif
 
-#define STUB_START _AC(, 0x100000)
-#define STUB_CODE _AC((unsigned long), STUB_START)
-#define STUB_DATA _AC((unsigned long), STUB_CODE + UM_KERN_PAGE_SIZE)
-#define STUB_END _AC((unsigned long), STUB_DATA + UM_KERN_PAGE_SIZE)
+#define STUB_START _UML_AC(, 0x100000)
+#define STUB_CODE _UML_AC((unsigned long), STUB_START)
+#define STUB_DATA _UML_AC((unsigned long), STUB_CODE + UM_KERN_PAGE_SIZE)
+#define STUB_END _UML_AC((unsigned long), STUB_DATA + UM_KERN_PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
 

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
