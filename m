Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JpSA3-0003kT-VK for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:40 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JpS9v-0005OO-KS
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 25 Apr 2008 10:56:34 -0700
Date: Fri, 25 Apr 2008 13:56:08 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080425175606.GA11176@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/19] UML - Style fixes
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

A few random style fixes.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/skas_ptrace.h            |   13 +------------
 arch/um/include/sysdep-i386/sigcontext.h |    2 +-
 arch/um/kernel/um_arch.c                 |    2 +-
 arch/um/os-Linux/skas/process.c          |    2 +-
 4 files changed, 4 insertions(+), 15 deletions(-)

Index: linux-2.6-git/arch/um/include/skas_ptrace.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/skas_ptrace.h	2008-02-21 18:47:34.000000000 -0500
+++ linux-2.6-git/arch/um/include/skas_ptrace.h	2008-03-06 09:46:19.000000000 -0500
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
@@ -12,14 +12,3 @@
 #include "sysdep/skas_ptrace.h"
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6-git/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/skas/process.c	2008-02-26 10:26:40.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/skas/process.c	2008-03-06 09:46:19.000000000 -0500
@@ -442,7 +442,7 @@ void userspace(struct uml_pt_regs *regs)
 				unblock_signals();
 				break;
 			default:
-			        printk(UM_KERN_ERR "userspace - child stopped "
+				printk(UM_KERN_ERR "userspace - child stopped "
 				       "with signal %d\n", sig);
 				fatal_sigsegv();
 			}
Index: linux-2.6-git/arch/um/include/sysdep-i386/sigcontext.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/sysdep-i386/sigcontext.h	2008-02-21 18:47:34.000000000 -0500
+++ linux-2.6-git/arch/um/include/sysdep-i386/sigcontext.h	2008-03-06 09:46:19.000000000 -0500
@@ -10,7 +10,7 @@
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 
-#define GET_FAULTINFO_FROM_SC(fi,sc) \
+#define GET_FAULTINFO_FROM_SC(fi, sc) \
 	{ \
 		(fi).cr2 = SC_CR2(sc); \
 		(fi).error_code = SC_ERR(sc); \
Index: linux-2.6-git/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/um_arch.c	2008-02-21 18:47:34.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/um_arch.c	2008-03-06 09:46:19.000000000 -0500
@@ -150,7 +150,7 @@ __uml_setup("root=", uml_root_setup,
 static int __init no_skas_debug_setup(char *line, int *add)
 {
 	printf("'debug' is not necessary to gdb UML in skas mode - run \n");
-	printf("'gdb linux'");
+	printf("'gdb linux'\n");
 
 	return 0;
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
