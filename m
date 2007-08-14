Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IL47p-0001a2-96 for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:40:31 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IL47l-0001AF-BN
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:40:28 -0700
Date: Tue, 14 Aug 2007 17:40:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070814214017.GA17285@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/14] UML - Remove sysdep/thread.h
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This patch removes thread.h, which turns out not to be needed any more.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/include/sysdep-i386/kernel-offsets.h |    1 -
 arch/um/include/sysdep-i386/sigcontext.h     |    3 ++-
 arch/um/include/sysdep-i386/thread.h         |    8 --------
 arch/um/include/sysdep-x86_64/thread.h       |    6 ------
 arch/um/sys-i386/ptrace_user.c               |    1 -
 5 files changed, 2 insertions(+), 17 deletions(-)

Index: linux-2.6.22/arch/um/include/sysdep-i386/sigcontext.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/sysdep-i386/sigcontext.h	2007-08-09 13:25:53.000000000 -0400
+++ linux-2.6.22/arch/um/include/sysdep-i386/sigcontext.h	2007-08-09 14:27:51.000000000 -0400
@@ -7,7 +7,8 @@
 #define __SYS_SIGCONTEXT_I386_H
 
 #include "uml-config.h"
-#include <sysdep/sc.h>
+#include "skas.h"
+#include "sysdep/sc.h"
 
 #define IP_RESTART_SYSCALL(ip) ((ip) -= 2)
 
Index: linux-2.6.22/arch/um/include/sysdep-i386/kernel-offsets.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/sysdep-i386/kernel-offsets.h	2007-07-08 19:32:17.000000000 -0400
+++ linux-2.6.22/arch/um/include/sysdep-i386/kernel-offsets.h	2007-08-09 14:43:15.000000000 -0400
@@ -17,6 +17,5 @@
 
 void foo(void)
 {
-	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
 #include <common-offsets.h>
 }
Index: linux-2.6.22/arch/um/include/sysdep-i386/thread.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/sysdep-i386/thread.h	2007-08-09 13:25:53.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,8 +0,0 @@
-#ifndef __UM_THREAD_H
-#define __UM_THREAD_H
-
-#include <kern_constants.h>
-
-#define TASK_DEBUGREGS(task) ((unsigned long *) &(((char *) (task))[HOST_TASK_DEBUGREGS]))
-
-#endif
Index: linux-2.6.22/arch/um/sys-i386/ptrace_user.c
===================================================================
--- linux-2.6.22.orig/arch/um/sys-i386/ptrace_user.c	2007-08-09 13:25:53.000000000 -0400
+++ linux-2.6.22/arch/um/sys-i386/ptrace_user.c	2007-08-09 14:44:17.000000000 -0400
@@ -11,7 +11,6 @@
 /* Grr, asm/user.h includes asm/ptrace.h, so has to follow ptrace_user.h */
 #include <asm/user.h>
 #include "kern_util.h"
-#include "sysdep/thread.h"
 #include "user.h"
 #include "os.h"
 #include "uml-config.h"
Index: linux-2.6.22/arch/um/include/sysdep-x86_64/thread.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/sysdep-x86_64/thread.h	2007-08-09 13:25:53.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,6 +0,0 @@
-#ifndef __UM_THREAD_H
-#define __UM_THREAD_H
-
-#include <kern_constants.h>
-
-#endif

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
