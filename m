Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IVZZx-00025I-Ek for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:57 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IVZZw-0004Zr-Jj
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Sep 2007 14:16:57 -0700
Date: Wed, 12 Sep 2007 17:16:50 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070912211650.GA10257@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 10/11] UML - Eliminate SIGALRM usage
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
Cc: clk@c2.user-mode-linux.org, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Now that ITIMER_REAL is no longer used, there is no need for any use
of SIGALRM whatsoever.  This patch removes all mention of it.

In addition, real_alarm_handler took a signal argument which is now
always SIGVTALRM.  So, that is gone.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/irq.c          |    2 +-
 arch/um/os-Linux/main.c         |    2 +-
 arch/um/os-Linux/process.c      |   10 +++++-----
 arch/um/os-Linux/signal.c       |   28 +++++++---------------------
 arch/um/os-Linux/skas/process.c |    4 +---
 arch/um/os-Linux/skas/trap.c    |    5 ++---
 arch/um/os-Linux/trap.c         |    1 -
 7 files changed, 17 insertions(+), 35 deletions(-)

Index: linux-2.6.22/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/process.c	2007-09-12 15:39:37.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/skas/process.c	2007-09-12 15:47:42.000000000 -0400
@@ -222,7 +222,6 @@ static int userspace_tramp(void *stack)
 		sigemptyset(&sa.sa_mask);
 		sigaddset(&sa.sa_mask, SIGIO);
 		sigaddset(&sa.sa_mask, SIGWINCH);
-		sigaddset(&sa.sa_mask, SIGALRM);
 		sigaddset(&sa.sa_mask, SIGVTALRM);
 		sigaddset(&sa.sa_mask, SIGUSR1);
 		sa.sa_flags = SA_ONSTACK;
@@ -522,8 +521,7 @@ int start_idle_thread(void *stack, jmp_b
 	int n;
 
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
-		    SIGVTALRM, -1);
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGVTALRM, -1);
 
 	/*
 	 * Can't use UML_SETJMP or UML_LONGJMP here because they save
Index: linux-2.6.22/arch/um/os-Linux/irq.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/irq.c	2007-09-12 14:50:58.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/irq.c	2007-09-12 15:47:42.000000000 -0400
@@ -146,6 +146,6 @@ void init_irq_signals(int on_sigstack)
 	flags = on_sigstack ? SA_ONSTACK : 0;
 
 	set_handler(SIGIO, (__sighandler_t) sig_handler, flags | SA_RESTART,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	signal(SIGWINCH, SIG_IGN);
 }
Index: linux-2.6.22/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/main.c	2007-09-11 14:09:28.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/main.c	2007-09-12 15:47:42.000000000 -0400
@@ -161,7 +161,7 @@ int __init main(int argc, char **argv, c
 	 * some time) and cause a segfault.
 	 */
 
-	/* stop timers and set SIG*ALRM to be ignored */
+	/* stop timers and set SIGVTALRM to be ignored */
 	disable_timer();
 
 	/* disable SIGIO for the fds and set SIGIO to be ignored */
Index: linux-2.6.22/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/process.c	2007-09-12 14:50:58.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/process.c	2007-09-12 15:47:42.000000000 -0400
@@ -238,15 +238,15 @@ out:
 void init_new_thread_signals(void)
 {
 	set_handler(SIGSEGV, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_handler(SIGTRAP, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_handler(SIGFPE, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_handler(SIGILL, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	set_handler(SIGBUS, (__sighandler_t) sig_handler, SA_ONSTACK,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+		    SIGUSR1, SIGIO, SIGWINCH, SIGVTALRM, -1);
 	signal(SIGHUP, SIG_IGN);
 
 	init_irq_signals(1);
Index: linux-2.6.22/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/signal.c	2007-09-12 15:41:04.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/signal.c	2007-09-12 15:48:20.000000000 -0400
@@ -15,8 +15,7 @@
 #include "user.h"
 
 /*
- * These are the asynchronous signals.  SIGVTALRM and SIGARLM are handled
- * together under SIGVTALRM_BIT.  SIGPROF is excluded because we want to
+ * These are the asynchronous signals.  SIGPROF is excluded because we want to
  * be able to profile all of UML, not just the non-critical sections.  If
  * profiling is not thread-safe, then that is not my problem.  We can disable
  * profiling when SMP is enabled in that case.
@@ -27,9 +26,6 @@
 #define SIGVTALRM_BIT 1
 #define SIGVTALRM_MASK (1 << SIGVTALRM_BIT)
 
-#define SIGALRM_BIT 2
-#define SIGALRM_MASK (1 << SIGALRM_BIT)
-
 /*
  * These are used by both the signal handlers and
  * block/unblock_signals.  I don't want modifications cached in a
@@ -55,7 +51,7 @@ void sig_handler(int sig, struct sigcont
 	set_signals(enabled);
 }
 
-static void real_alarm_handler(int sig, struct sigcontext *sc)
+static void real_alarm_handler(struct sigcontext *sc)
 {
 	struct uml_pt_regs regs;
 
@@ -63,7 +59,7 @@ static void real_alarm_handler(int sig, 
 		copy_sc(&regs, sc);
 	regs.is_user = 0;
 	unblock_signals();
-	timer_handler(sig, &regs);
+	timer_handler(SIGVTALRM, &regs);
 }
 
 void alarm_handler(int sig, struct sigcontext *sc)
@@ -72,27 +68,20 @@ void alarm_handler(int sig, struct sigco
 
 	enabled = signals_enabled;
 	if (!signals_enabled) {
-		if (sig == SIGVTALRM)
-			pending |= SIGVTALRM_MASK;
-		else pending |= SIGALRM_MASK;
-
+		pending |= SIGVTALRM_MASK;
 		return;
 	}
 
 	block_signals();
 
-	real_alarm_handler(sig, sc);
+	real_alarm_handler(sc);
 	set_signals(enabled);
 }
 
 void timer_init(void)
 {
 	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
-		    SIGALRM, -1);
-	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
-		    SIGALRM, -1);
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, -1);
 }
 
 void set_sigstack(void *sig_stack, int size)
@@ -267,11 +256,8 @@ void unblock_signals(void)
 		if (save_pending & SIGIO_MASK)
 			sig_handler_common_skas(SIGIO, NULL);
 
-		if (save_pending & SIGALRM_MASK)
-			real_alarm_handler(SIGALRM, NULL);
-
 		if (save_pending & SIGVTALRM_MASK)
-			real_alarm_handler(SIGVTALRM, NULL);
+			real_alarm_handler(NULL);
 	}
 }
 
Index: linux-2.6.22/arch/um/os-Linux/skas/trap.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/skas/trap.c	2007-09-11 14:09:28.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/skas/trap.c	2007-09-12 15:47:42.000000000 -0400
@@ -58,9 +58,8 @@ void sig_handler_common_skas(int sig, vo
 
 	handler = sig_info[sig];
 
-	/* unblock SIGALRM, SIGVTALRM, SIGIO if sig isn't IRQ signal */
-	if (sig != SIGIO && sig != SIGWINCH &&
-	    sig != SIGVTALRM && sig != SIGALRM)
+	/* unblock SIGVTALRM, SIGIO if sig isn't IRQ signal */
+	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM))
 		unblock_signals();
 
 	handler(sig, r);
Index: linux-2.6.22/arch/um/os-Linux/trap.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/trap.c	2007-09-11 14:09:28.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/trap.c	2007-09-12 15:47:42.000000000 -0400
@@ -20,5 +20,4 @@ void os_fill_handlinfo(struct kern_handl
 	sig_info[SIGSEGV] = h.page_fault;
 	sig_info[SIGIO] = h.sigio_handler;
 	sig_info[SIGVTALRM] = h.timer_handler;
-	sig_info[SIGALRM] = h.timer_handler;
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
