Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ip7cN-0006qo-C2 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:28:15 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ip7cK-0005Lb-M9
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 05 Nov 2007 11:28:15 -0800
Date: Mon, 5 Nov 2007 14:27:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071105192748.GA8808@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/6] UML - Borrow const.h techniques
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
To: Andrew Morton <akpm@osdl.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Suggested by Geert Uytterhoeven - use const.h to get constants that
are usable in both C and assembly.  I can't include it directly since
this code can't include kernel headers.  const.h is also for numeric
constants that can be typed by tacking a "UL" or similar on the end.
The constants here have to be typed by casting them.

So, the relevant parts of const.h are copied here and modified in
order to allow the constants to be uncasted in assembly and casted in
C.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/as-layout.h |   34 +++++++++++++++++++++-------------
 arch/um/sys-i386/stub.S     |    8 ++++----
 arch/um/sys-x86_64/stub.S   |    8 ++++----
 3 files changed, 29 insertions(+), 21 deletions(-)

Index: linux-2.6/arch/um/include/as-layout.h
===================================================================
--- linux-2.6.orig/arch/um/include/as-layout.h	2007-11-05 14:06:09.000000000 -0500
+++ linux-2.6/arch/um/include/as-layout.h	2007-11-05 14:16:29.000000000 -0500
@@ -10,23 +10,31 @@
 #include "kern_constants.h"
 
 /*
- * Assembly doesn't want any casting, but C does, so define these
- * without casts here, and define new symbols with casts inside the C
- * section.
+ * Stolen from linux/const.h, which can't be directly included since
+ * this is used in userspace code, which has no access to the kernel
+ * headers.  Changed to be suitable for adding casts to the start,
+ * rather than "UL" to the end.
  */
-#define ASM_STUB_CODE (UML_CONFIG_TOP_ADDR - 2 * UM_KERN_PAGE_SIZE)
-#define ASM_STUB_DATA (UML_CONFIG_TOP_ADDR - UM_KERN_PAGE_SIZE)
-#define ASM_STUB_START ASM_STUB_CODE
 
-/*
- * This file is included by the assembly stubs, which just want the
- * definitions above.
+/* Some constant macros are used in both assembler and
+ * C code.  Therefore we cannot annotate them always with
+ * 'UL' and other type specifiers unilaterally.  We
+ * use the following macros to deal with this.
  */
-#ifndef __ASSEMBLY__
 
-#define STUB_CODE ((unsigned long) ASM_STUB_CODE)
-#define STUB_DATA ((unsigned long) ASM_STUB_DATA)
-#define STUB_START ((unsigned long) ASM_STUB_START)
+#ifdef __ASSEMBLY__
+#define _AC(X, Y)	(Y)
+#else
+#define __AC(X, Y)	(X (Y))
+#define _AC(X, Y)	__AC(X, Y)
+#endif
+
+#define STUB_CODE _AC((unsigned long), \
+		      UML_CONFIG_TOP_ADDR - 2 * UM_KERN_PAGE_SIZE)
+#define STUB_DATA _AC((unsigned long), UML_CONFIG_TOP_ADDR - UM_KERN_PAGE_SIZE)
+#define STUB_START _AC(, STUB_CODE)
+
+#ifndef __ASSEMBLY__
 
 #include "sysdep/ptrace.h"
 
Index: linux-2.6/arch/um/sys-i386/stub.S
===================================================================
--- linux-2.6.orig/arch/um/sys-i386/stub.S	2007-11-05 14:06:09.000000000 -0500
+++ linux-2.6/arch/um/sys-i386/stub.S	2007-11-05 14:14:20.000000000 -0500
@@ -7,7 +7,7 @@
 	.globl batch_syscall_stub
 batch_syscall_stub:
 	/* load pointer to first operation */
-	mov	$(ASM_STUB_DATA+8), %esp
+	mov	$(STUB_DATA+8), %esp
 
 again:
 	/* load length of additional data */
@@ -15,12 +15,12 @@ again:
 
 	/* if(length == 0) : end of list */
 	/* write possible 0 to header */
-	mov	%eax, ASM_STUB_DATA+4
+	mov	%eax, STUB_DATA+4
 	cmpl	$0, %eax
 	jz	done
 
 	/* save current pointer */
-	mov	%esp, ASM_STUB_DATA+4
+	mov	%esp, STUB_DATA+4
 
 	/* skip additional data */
 	add	%eax, %esp
@@ -46,7 +46,7 @@ again:
 
 done:
 	/* save return value */
-	mov	%eax, ASM_STUB_DATA
+	mov	%eax, STUB_DATA
 
 	/* stop */
 	int3
Index: linux-2.6/arch/um/sys-x86_64/stub.S
===================================================================
--- linux-2.6.orig/arch/um/sys-x86_64/stub.S	2007-11-05 14:06:09.000000000 -0500
+++ linux-2.6/arch/um/sys-x86_64/stub.S	2007-11-05 14:14:20.000000000 -0500
@@ -8,18 +8,18 @@ syscall_stub:
 	/* We don't have 64-bit constants, so this constructs the address
 	 * we need.
 	 */
-	movq	$(ASM_STUB_DATA >> 32), %rbx
+	movq	$(STUB_DATA >> 32), %rbx
 	salq	$32, %rbx
-	movq	$(ASM_STUB_DATA & 0xffffffff), %rcx
+	movq	$(STUB_DATA & 0xffffffff), %rcx
 	or	%rcx, %rbx
 	movq	%rax, (%rbx)
 	int3
 
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	mov	$(ASM_STUB_DATA >> 32), %rbx
+	mov	$(STUB_DATA >> 32), %rbx
 	sal	$32, %rbx
-	mov	$(ASM_STUB_DATA & 0xffffffff), %rax
+	mov	$(STUB_DATA & 0xffffffff), %rax
 	or	%rax, %rbx
 	/* load pointer to first operation */
 	mov	%rbx, %rsp

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
