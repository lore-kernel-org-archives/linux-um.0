Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JA9tY-0005WJ-Qc for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:08:57 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JA9tY-00049R-5i
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 02 Jan 2008 12:08:56 -0800
Date: Wed, 2 Jan 2008 15:08:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080102200853.GA7954@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/7] UML - Signal handling tidying
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

This patch tidies the signal handling code slightly.

pending is renamed to signals_pending for symmetry with signals_enabled.

remove_sigstack was unused, so can be deleted.

The value of change_sig was never used, so it is now void and the
return value is not calculated any more.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/signal.c |   31 +++++++++++--------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

Index: linux-2.6-git/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/signal.c	2007-12-14 10:29:21.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/signal.c	2007-12-14 10:41:00.000000000 -0500
@@ -63,7 +63,7 @@ static void sig_handler_common(int sig, 
 #define SIGVTALRM_MASK (1 << SIGVTALRM_BIT)
 
 static int signals_enabled;
-static unsigned int pending;
+static unsigned int signals_pending;
 
 void sig_handler(int sig, struct sigcontext *sc)
 {
@@ -71,7 +71,7 @@ void sig_handler(int sig, struct sigcont
 
 	enabled = signals_enabled;
 	if (!enabled && (sig == SIGIO)) {
-		pending |= SIGIO_MASK;
+		signals_pending |= SIGIO_MASK;
 		return;
 	}
 
@@ -99,7 +99,7 @@ void alarm_handler(int sig, struct sigco
 
 	enabled = signals_enabled;
 	if (!signals_enabled) {
-		pending |= SIGVTALRM_MASK;
+		signals_pending |= SIGVTALRM_MASK;
 		return;
 	}
 
@@ -125,16 +125,6 @@ void set_sigstack(void *sig_stack, int s
 		panic("enabling signal stack failed, errno = %d\n", errno);
 }
 
-void remove_sigstack(void)
-{
-	stack_t stack = ((stack_t) { .ss_flags	= SS_DISABLE,
-				     .ss_sp	= NULL,
-				     .ss_size	= 0 });
-
-	if (sigaltstack(&stack, NULL) != 0)
-		panic("disabling signal stack failed, errno = %d\n", errno);
-}
-
 void (*handlers[_NSIG])(int sig, struct sigcontext *sc);
 
 void handle_signal(int sig, struct sigcontext *sc)
@@ -213,13 +203,14 @@ void set_handler(int sig, void (*handler
 
 int change_sig(int signal, int on)
 {
-	sigset_t sigset, old;
+	sigset_t sigset;
 
 	sigemptyset(&sigset);
 	sigaddset(&sigset, signal);
-	if (sigprocmask(on ? SIG_UNBLOCK : SIG_BLOCK, &sigset, &old) < 0)
+	if (sigprocmask(on ? SIG_UNBLOCK : SIG_BLOCK, &sigset, NULL) < 0)
 		return -errno;
-	return !sigismember(&old, signal);
+
+	return 0;
 }
 
 void block_signals(void)
@@ -244,26 +235,26 @@ void unblock_signals(void)
 	/*
 	 * We loop because the IRQ handler returns with interrupts off.  So,
 	 * interrupts may have arrived and we need to re-enable them and
-	 * recheck pending.
+	 * recheck signals_pending.
 	 */
 	while(1) {
 		/*
 		 * Save and reset save_pending after enabling signals.  This
-		 * way, pending won't be changed while we're reading it.
+		 * way, signals_pending won't be changed while we're reading it.
 		 */
 		signals_enabled = 1;
 
 		/*
-		 * Setting signals_enabled and reading pending must
+		 * Setting signals_enabled and reading signals_pending must
 		 * happen in this order.
 		 */
 		barrier();
 
-		save_pending = pending;
+		save_pending = signals_pending;
 		if (save_pending == 0)
 			return;
 
-		pending = 0;
+		signals_pending = 0;
 
 		/*
 		 * We have pending interrupts, so disable signals, as the

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
