Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HUPqa-0003HG-2l for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:04 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HUPqX-0005JG-5L
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:03 -0700
Date: Thu, 22 Mar 2007 12:06:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070322160643.GA7012@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 4/7 ] UML - create as-layout.h
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch moves all the the symbols defined in um_arch.c, which are
mostly boundaries between different parts of the UML kernel address
space, to a new header, as-layout.h.  There are also a few things here
which aren't really related to address space layout, but which don't
really have a better place to go.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/as-layout.h   |   35 +++++++++++++++++++++++++++++++++++
 arch/um/include/user_util.h   |   23 -----------------------
 arch/um/kernel/exec.c         |    1 +
 arch/um/kernel/ksyms.c        |    1 +
 arch/um/kernel/mem.c          |    1 +
 arch/um/kernel/physmem.c      |    1 +
 arch/um/kernel/process.c      |    1 +
 arch/um/kernel/skas/process.c |    1 +
 arch/um/kernel/tlb.c          |    1 +
 arch/um/kernel/trap.c         |    1 +
 arch/um/kernel/um_arch.c      |    1 +
 arch/um/os-Linux/main.c       |    1 +
 arch/um/os-Linux/skas/trap.c  |    1 +
 13 files changed, 46 insertions(+), 23 deletions(-)

Index: linux-2.6.21-mm/arch/um/kernel/exec.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/exec.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/exec.c	2007-03-22 11:18:21.000000000 -0400
@@ -12,6 +12,7 @@
 #include "asm/uaccess.h"
 #include "user_util.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "mem_user.h"
 #include "kern.h"
 #include "irq_user.h"
Index: linux-2.6.21-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/mem.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/mem.c	2007-03-22 11:18:21.000000000 -0400
@@ -15,6 +15,7 @@
 #include "asm/pgalloc.h"
 #include "user_util.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "kern.h"
 #include "mem_user.h"
 #include "uml_uaccess.h"
Index: linux-2.6.21-mm/arch/um/kernel/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/process.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/process.c	2007-03-22 11:18:21.000000000 -0400
@@ -34,6 +34,7 @@
 #include "asm/user.h"
 #include "user_util.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "kern.h"
 #include "signal_kern.h"
 #include "init.h"
Index: linux-2.6.21-mm/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/skas/process.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/skas/process.c	2007-03-22 11:18:21.000000000 -0400
@@ -13,6 +13,7 @@
 #include "asm/uaccess.h"
 #include "asm/atomic.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "skas.h"
 #include "os.h"
 #include "user_util.h"
Index: linux-2.6.21-mm/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/main.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/main.c	2007-03-22 11:18:21.000000000 -0400
@@ -15,6 +15,7 @@
 #include <asm/page.h>
 #include "user_util.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "mem_user.h"
 #include "irq_user.h"
 #include "user.h"
Index: linux-2.6.21-mm/arch/um/os-Linux/skas/trap.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/trap.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/trap.c	2007-03-22 11:18:21.000000000 -0400
@@ -7,6 +7,7 @@
 #include <errno.h>
 #include "user_util.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "task.h"
 #include "sigcontext.h"
 #include "skas.h"
Index: linux-2.6.21-mm/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/physmem.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/physmem.c	2007-03-22 11:18:21.000000000 -0400
@@ -13,6 +13,7 @@
 #include "asm/types.h"
 #include "asm/pgtable.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "user_util.h"
 #include "mode_kern.h"
 #include "mem.h"
Index: linux-2.6.21-mm/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/tlb.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/tlb.c	2007-03-22 11:18:21.000000000 -0400
@@ -9,6 +9,7 @@
 #include "asm/tlbflush.h"
 #include "choose-mode.h"
 #include "mode_kern.h"
+#include "as-layout.h"
 #include "user_util.h"
 #include "tlb.h"
 #include "mem.h"
Index: linux-2.6.21-mm/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/trap.c	2007-03-21 17:38:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/trap.c	2007-03-22 11:18:21.000000000 -0400
@@ -20,6 +20,7 @@
 #include "sysdep/sigcontext.h"
 #include "user_util.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "arch.h"
 #include "kern.h"
 #include "chan_kern.h"
Index: linux-2.6.21-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/um_arch.c	2007-03-21 17:38:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/um_arch.c	2007-03-22 11:18:21.000000000 -0400
@@ -28,6 +28,7 @@
 #include "asm/current.h"
 #include "user_util.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "arch.h"
 #include "kern.h"
 #include "mem_user.h"
Index: linux-2.6.21-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/user_util.h	2007-03-21 17:38:21.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/user_util.h	2007-03-22 11:18:21.000000000 -0400
@@ -30,30 +30,7 @@ extern int grantpt(int __fd);
 extern int unlockpt(int __fd);
 extern char *ptsname(int __fd);
 
-struct cpu_task {
-	int pid;
-	void *task;
-};
-
-extern struct cpu_task cpu_tasks[];
-
-extern void (*sig_info[])(int, union uml_pt_regs *);
-
-extern unsigned long low_physmem;
-extern unsigned long high_physmem;
-extern unsigned long uml_physmem;
-extern unsigned long uml_reserved;
-extern unsigned long end_vm;
-extern unsigned long start_vm;
-extern unsigned long long highmem;
-
-extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
-extern unsigned long _unprotected_end;
-extern unsigned long brk_start;
-
 extern void *add_signal_handler(int sig, void (*handler)(int));
-extern int linux_main(int argc, char **argv);
-extern void set_cmdline(char *cmd);
 extern void input_cb(void (*proc)(void *), void *arg, int arg_len);
 extern int get_pty(void);
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
Index: linux-2.6.21-mm/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/ksyms.c	2007-03-21 17:33:45.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/ksyms.c	2007-03-22 11:18:21.000000000 -0400
@@ -16,6 +16,7 @@
 #include "asm/page.h"
 #include "asm/tlbflush.h"
 #include "kern_util.h"
+#include "as-layout.h"
 #include "user_util.h"
 #include "mem_user.h"
 #include "os.h"
Index: linux-2.6.21-mm/arch/um/include/as-layout.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.21-mm/arch/um/include/as-layout.h	2007-03-22 11:18:04.000000000 -0400
@@ -0,0 +1,35 @@
+/*
+ * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __START_H__
+#define __START_H__
+
+#include "sysdep/ptrace.h"
+
+struct cpu_task {
+	int pid;
+	void *task;
+};
+
+extern struct cpu_task cpu_tasks[];
+
+extern unsigned long low_physmem;
+extern unsigned long high_physmem;
+extern unsigned long uml_physmem;
+extern unsigned long uml_reserved;
+extern unsigned long end_vm;
+extern unsigned long start_vm;
+extern unsigned long long highmem;
+
+extern unsigned long _stext, _etext, _sdata, _edata, __bss_start, _end;
+extern unsigned long _unprotected_end;
+extern unsigned long brk_start;
+
+extern int linux_main(int argc, char **argv);
+extern void set_cmdline(char *cmd);
+
+extern void (*sig_info[])(int, union uml_pt_regs *);
+
+#endif

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
