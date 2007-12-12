Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2YV9-0001bf-3e for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 12:48:19 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J2YV6-0006sv-97
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 12:48:19 -0800
Date: Wed, 12 Dec 2007 15:47:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071212204759.GA9139@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/6] UML - Move sig_handler_common_skas
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

This patch moves sig_handler_common_skas from
arch/um/os-Linux/skas/trap.c to its only caller in
arch/um/os-Linux/signal.c.  trap.c is now empty, so it can be removed.

This is code movement only - the significant cleanup needed here is
done in the next patch.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/os.h           |    3 -
 arch/um/os-Linux/signal.c      |   62 ++++++++++++++++++++++++++++++++++
 arch/um/os-Linux/skas/Makefile |    6 +--
 arch/um/os-Linux/skas/trap.c   |   73 -----------------------------------------
 4 files changed, 65 insertions(+), 79 deletions(-)

Index: linux-2.6-git/arch/um/include/os.h
===================================================================
--- linux-2.6-git.orig/arch/um/include/os.h	2007-12-12 15:06:13.000000000 -0500
+++ linux-2.6-git/arch/um/include/os.h	2007-12-12 15:16:44.000000000 -0500
@@ -292,9 +292,6 @@ extern int add_sigio_fd(int fd);
 extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd, int read);
 
-/* skas/trap */
-extern void sig_handler_common_skas(int sig, void *sc_ptr);
-
 /* sys-x86_64/prctl.c */
 extern int os_arch_prctl(int pid, int code, unsigned long *addr);
 
Index: linux-2.6-git/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/signal.c	2007-12-12 15:06:13.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/signal.c	2007-12-12 15:17:45.000000000 -0500
@@ -9,12 +9,74 @@
 #include <errno.h>
 #include <signal.h>
 #include <strings.h>
+#include "as-layout.h"
+#include "kern_constants.h"
 #include "kern_util.h"
 #include "os.h"
 #include "sysdep/barrier.h"
 #include "sysdep/sigcontext.h"
+#include "task.h"
 #include "user.h"
 
+void (*sig_info[NSIG])(int, struct uml_pt_regs *) = {
+	[SIGTRAP]	= relay_signal,
+	[SIGFPE]	= relay_signal,
+	[SIGILL]	= relay_signal,
+	[SIGWINCH]	= winch,
+	[SIGBUS]	= bus_handler,
+	[SIGSEGV]	= segv_handler,
+	[SIGIO]		= sigio_handler,
+	[SIGVTALRM]	= timer_handler };
+
+static struct uml_pt_regs ksig_regs[UM_NR_CPUS];
+
+void sig_handler_common_skas(int sig, void *sc_ptr)
+{
+	struct sigcontext *sc = sc_ptr;
+	struct uml_pt_regs *r;
+	void (*handler)(int, struct uml_pt_regs *);
+	int save_user, save_errno = errno;
+
+	/*
+	 * This is done because to allow SIGSEGV to be delivered inside a SEGV
+	 * handler.  This can happen in copy_user, and if SEGV is disabled,
+	 * the process will die.
+	 * XXX Figure out why this is better than SA_NODEFER
+	 */
+	if (sig == SIGSEGV) {
+		change_sig(SIGSEGV, 1);
+		/*
+		 * For segfaults, we want the data from the
+		 * sigcontext.  In this case, we don't want to mangle
+		 * the process registers, so use a static set of
+		 * registers.  For other signals, the process
+		 * registers are OK.
+		 */
+		r = &ksig_regs[cpu()];
+		copy_sc(r, sc_ptr);
+	} else
+		r = TASK_REGS(get_current());
+
+	save_user = r->is_user;
+	r->is_user = 0;
+	if ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
+	    (sig == SIGILL) || (sig == SIGTRAP))
+		GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
+
+	change_sig(SIGUSR1, 1);
+
+	handler = sig_info[sig];
+
+	/* unblock SIGVTALRM, SIGIO if sig isn't IRQ signal */
+	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM))
+		unblock_signals();
+
+	handler(sig, r);
+
+	errno = save_errno;
+	r->is_user = save_user;
+}
+
 /* Copied from linux/compiler-gcc.h since we can't include it directly */
 #define barrier() __asm__ __volatile__("": : :"memory")
 
Index: linux-2.6-git/arch/um/os-Linux/skas/Makefile
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/skas/Makefile	2007-12-12 15:06:13.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/skas/Makefile	2007-12-12 15:16:44.000000000 -0500
@@ -1,10 +1,10 @@
 #
-# Copyright (C) 2002 - 2004 Jeff Dike (jdike@addtoit.com)
+# Copyright (C) 2002 - 2007 Jeff Dike (jdike@{linux.intel,addtoit}.com)
 # Licensed under the GPL
 #
 
-obj-y := mem.o process.o trap.o
+obj-y := mem.o process.o
 
-USER_OBJS := mem.o process.o trap.o
+USER_OBJS := $(obj-y)
 
 include arch/um/scripts/Makefile.rules
Index: linux-2.6-git/arch/um/os-Linux/skas/trap.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/skas/trap.c	2007-12-12 15:06:13.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,73 +0,0 @@
-/*
- * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#include <errno.h>
-#include <signal.h>
-#include "sysdep/ptrace.h"
-#include "kern_constants.h"
-#include "as-layout.h"
-#include "kern_util.h"
-#include "os.h"
-#include "sigcontext.h"
-#include "task.h"
-
-void (*sig_info[NSIG])(int, struct uml_pt_regs *) = {
-	[SIGTRAP]	= relay_signal,
-	[SIGFPE]	= relay_signal,
-	[SIGILL]	= relay_signal,
-	[SIGWINCH]	= winch,
-	[SIGBUS]	= bus_handler,
-	[SIGSEGV]	= segv_handler,
-	[SIGIO]		= sigio_handler,
-	[SIGVTALRM]	= timer_handler };
-
-static struct uml_pt_regs ksig_regs[UM_NR_CPUS];
-
-void sig_handler_common_skas(int sig, void *sc_ptr)
-{
-	struct sigcontext *sc = sc_ptr;
-	struct uml_pt_regs *r;
-	void (*handler)(int, struct uml_pt_regs *);
-	int save_user, save_errno = errno;
-
-	/*
-	 * This is done because to allow SIGSEGV to be delivered inside a SEGV
-	 * handler.  This can happen in copy_user, and if SEGV is disabled,
-	 * the process will die.
-	 * XXX Figure out why this is better than SA_NODEFER
-	 */
-	if (sig == SIGSEGV) {
-		change_sig(SIGSEGV, 1);
-		/*
-		 * For segfaults, we want the data from the
-		 * sigcontext.  In this case, we don't want to mangle
-		 * the process registers, so use a static set of
-		 * registers.  For other signals, the process
-		 * registers are OK.
-		 */
-		r = &ksig_regs[cpu()];
-		copy_sc(r, sc_ptr);
-	}
-	else r = TASK_REGS(get_current());
-
-	save_user = r->is_user;
-	r->is_user = 0;
-	if ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
-	    (sig == SIGILL) || (sig == SIGTRAP))
-		GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
-
-	change_sig(SIGUSR1, 1);
-
-	handler = sig_info[sig];
-
-	/* unblock SIGVTALRM, SIGIO if sig isn't IRQ signal */
-	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM))
-		unblock_signals();
-
-	handler(sig, r);
-
-	errno = save_errno;
-	r->is_user = save_user;
-}

-------------------------------------------------------------------------
SF.Net email is sponsored by:
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services
for just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
