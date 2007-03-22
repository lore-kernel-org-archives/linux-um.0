Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HUPqa-0003HD-2j for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:04 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HUPqW-0001i2-3H
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 22 Mar 2007 09:09:02 -0700
Date: Thu, 22 Mar 2007 12:06:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070322160642.GA7007@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 3/7 ] UML - Create arch.h
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

This patch moves the declarations of the architecture hooks from
user_util.h to a new header, arch.c, and adds the necessary includes
to files which need those declarations.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/arch.h      |   15 +++++++++++++++
 arch/um/include/user_util.h |    4 ----
 arch/um/kernel/trap.c       |    1 +
 arch/um/kernel/um_arch.c    |    1 +
 4 files changed, 17 insertions(+), 4 deletions(-)

Index: linux-2.6.21-mm/arch/um/include/arch.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.21-mm/arch/um/include/arch.h	2007-03-21 17:29:15.000000000 -0400
@@ -0,0 +1,15 @@
+/*
+ * Copyright (C) 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __ARCH_H__
+#define __ARCH_H__
+
+#include "sysdep/ptrace.h"
+
+extern void arch_check_bugs(void);
+extern int arch_fixup(unsigned long address, void *sc_ptr);
+extern int arch_handle_signal(int sig, union uml_pt_regs *regs);
+
+#endif
Index: linux-2.6.21-mm/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/trap.c	2007-03-21 16:16:43.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/trap.c	2007-03-21 17:29:15.000000000 -0400
@@ -20,6 +20,7 @@
 #include "sysdep/sigcontext.h"
 #include "user_util.h"
 #include "kern_util.h"
+#include "arch.h"
 #include "kern.h"
 #include "chan_kern.h"
 #include "mconsole_kern.h"
Index: linux-2.6.21-mm/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/kernel/um_arch.c	2007-03-21 16:16:43.000000000 -0400
+++ linux-2.6.21-mm/arch/um/kernel/um_arch.c	2007-03-21 17:29:15.000000000 -0400
@@ -28,6 +28,7 @@
 #include "asm/current.h"
 #include "user_util.h"
 #include "kern_util.h"
+#include "arch.h"
 #include "kern.h"
 #include "mem_user.h"
 #include "mem.h"
Index: linux-2.6.21-mm/arch/um/include/user_util.h
===================================================================
--- linux-2.6.21-mm.orig/arch/um/include/user_util.h	2007-03-21 16:17:50.000000000 -0400
+++ linux-2.6.21-mm/arch/um/include/user_util.h	2007-03-21 17:29:15.000000000 -0400
@@ -65,10 +65,6 @@ extern int attach(int pid);
 extern void kill_child_dead(int pid);
 extern int cont(int pid);
 extern void check_sigio(void);
-extern void arch_check_bugs(void);
-extern int arch_handle_signal(int sig, union uml_pt_regs *regs);
-extern int arch_fixup(unsigned long address, void *sc_ptr);
-extern void arch_init_thread(void);
 extern int raw(int fd);
 
 #endif

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
