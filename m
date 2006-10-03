Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GUtF2-0002QV-KG for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Oct 2006 16:00:00 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GUtF1-0003bF-3B
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 03 Oct 2006 16:00:00 -0700
Message-Id: <200610032256.k93MulSV006888@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 03 Oct 2006 18:56:46 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH] UML - add generic BUG support
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The BUG changes in -mm3 need some arch support.  This patch adds the UML 
support needed.  For the most part, it was stolen from the underlying 
architecture.  The exception is the kernel eip < PAGE_OFFSET test, which is 
wrong for skas mode UMLs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
---
 arch/um/Kconfig             |    5 +++++
 arch/um/sys-i386/Makefile   |    2 +-
 arch/um/sys-i386/bug.c      |   20 ++++++++++++++++++++
 arch/um/sys-x86_64/Makefile |    2 +-
 arch/um/sys-x86_64/bug.c    |   20 ++++++++++++++++++++
 include/asm-um/bug.h        |    4 +++-
 6 files changed, 50 insertions(+), 3 deletions(-)

Index: linux-2.6.18-mm/arch/um/Kconfig
===================================================================
--- linux-2.6.18-mm.orig/arch/um/Kconfig	2006-10-03 12:46:44.000000000 -0400
+++ linux-2.6.18-mm/arch/um/Kconfig	2006-10-03 17:44:32.000000000 -0400
@@ -29,6 +29,11 @@ config GENERIC_CALIBRATE_DELAY
 	bool
 	default y
 
+config GENERIC_BUG
+	bool
+	default y
+	depends on BUG
+
 # Used in kernel/irq/manage.c and include/linux/irq.h
 config IRQ_RELEASE_METHOD
 	bool
Index: linux-2.6.18-mm/include/asm-um/bug.h
===================================================================
--- linux-2.6.18-mm.orig/include/asm-um/bug.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.18-mm/include/asm-um/bug.h	2006-10-03 13:29:28.000000000 -0400
@@ -1,4 +1,6 @@
 #ifndef __UM_BUG_H
 #define __UM_BUG_H
-#include <asm-generic/bug.h>
+
+#include <asm/arch/bug.h>
+
 #endif
Index: linux-2.6.18-mm/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-i386/Makefile	2006-10-03 12:53:13.000000000 -0400
+++ linux-2.6.18-mm/arch/um/sys-i386/Makefile	2006-10-03 17:44:32.000000000 -0400
@@ -1,4 +1,4 @@
-obj-y = bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
+obj-y = bug.o bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
 	ptrace_user.o setjmp.o signal.o sigcontext.o syscalls.o sysrq.o \
 	sys_call_table.o tls.o
 
Index: linux-2.6.18-mm/arch/um/sys-i386/bug.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/sys-i386/bug.c	2006-10-03 13:45:39.000000000 -0400
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2006 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL V2
+ */
+
+#include <linux/uaccess.h>
+
+/* Mostly copied from i386/x86_86 - eliminated the eip < PAGE_OFFSET because
+ * that's not relevent in skas mode.
+ */
+
+int is_valid_bugaddr(unsigned long eip)
+{
+	unsigned short ud2;
+
+	if (probe_kernel_address((unsigned short __user *)eip, ud2))
+		return 0;
+
+	return ud2 == 0x0b0f;
+}
Index: linux-2.6.18-mm/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/sys-x86_64/Makefile	2006-10-03 12:53:13.000000000 -0400
+++ linux-2.6.18-mm/arch/um/sys-x86_64/Makefile	2006-10-03 17:44:32.000000000 -0400
@@ -4,7 +4,7 @@
 # Licensed under the GPL
 #
 
-obj-y = bugs.o delay.o fault.o ldt.o mem.o ptrace.o ptrace_user.o \
+obj-y = bug.o bugs.o delay.o fault.o ldt.o mem.o ptrace.o ptrace_user.o \
 	setjmp.o sigcontext.o signal.o syscalls.o syscall_table.o sysrq.o \
 	ksyms.o tls.o
 
Index: linux-2.6.18-mm/arch/um/sys-x86_64/bug.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-mm/arch/um/sys-x86_64/bug.c	2006-10-03 13:45:53.000000000 -0400
@@ -0,0 +1,20 @@
+/*
+ * Copyright (C) 2006 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL V2
+ */
+
+#include <linux/uaccess.h>
+
+/* Mostly copied from i386/x86_86 - eliminated the eip < PAGE_OFFSET because
+ * that's not relevent in skas mode.
+ */
+
+int is_valid_bugaddr(unsigned long eip)
+{
+	unsigned short ud2;
+
+	if (probe_kernel_address((unsigned short __user *)eip, ud2))
+		return 0;
+
+	return ud2 == 0x0b0f;
+}


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
