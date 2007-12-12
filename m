Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J2ZcO-00014X-CF for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 13:59:54 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J2ZcN-0005IN-Q5
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Dec 2007 13:59:52 -0800
Date: Wed, 12 Dec 2007 15:48:00 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071212204800.GA9144@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/6] UML - Clean up sig_handler_common_skas
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

sig_handler_common_skas needs significant modernization, starting with
its name and storage class.

There is no need to hide the true type of the sigcontext pointer, so
the void * dummy parameter can be replaced with a sigcontext *sc.

The array of uml_pt_regs structs used in the page fault case are gone,
replaced by a local variable.  This is also used in the non-segfault
case instead of the copy in the task_struct.  Since it's local, the
special handling of the is_user flag can go away.

There hasn't been any special treatment of SIGUSR1 in ages, so the
line that enables it can be deleted.

The special treatment of SIGSEGV similarly goes away, but to
compensate, SA_NODEFER is added to sa_mask when registering a signal
handler.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/signal.c |   63 +++++++++++++---------------------------------
 1 file changed, 18 insertions(+), 45 deletions(-)

Index: linux-2.6-git/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6-git.orig/arch/um/os-Linux/signal.c	2007-12-12 15:17:45.000000000 -0500
+++ linux-2.6-git/arch/um/os-Linux/signal.c	2007-12-12 15:32:38.000000000 -0500
@@ -10,14 +10,15 @@
 #include <signal.h>
 #include <strings.h>
 #include "as-layout.h"
-#include "kern_constants.h"
 #include "kern_util.h"
 #include "os.h"
 #include "sysdep/barrier.h"
 #include "sysdep/sigcontext.h"
-#include "task.h"
 #include "user.h"
 
+/* Copied from linux/compiler-gcc.h since we can't include it directly */
+#define barrier() __asm__ __volatile__("": : :"memory")
+
 void (*sig_info[NSIG])(int, struct uml_pt_regs *) = {
 	[SIGTRAP]	= relay_signal,
 	[SIGFPE]	= relay_signal,
@@ -28,58 +29,27 @@ void (*sig_info[NSIG])(int, struct uml_p
 	[SIGIO]		= sigio_handler,
 	[SIGVTALRM]	= timer_handler };
 
-static struct uml_pt_regs ksig_regs[UM_NR_CPUS];
-
-void sig_handler_common_skas(int sig, void *sc_ptr)
+static void sig_handler_common(int sig, struct sigcontext *sc)
 {
-	struct sigcontext *sc = sc_ptr;
-	struct uml_pt_regs *r;
-	void (*handler)(int, struct uml_pt_regs *);
-	int save_user, save_errno = errno;
+	struct uml_pt_regs r;
+	int save_errno = errno;
 
-	/*
-	 * This is done because to allow SIGSEGV to be delivered inside a SEGV
-	 * handler.  This can happen in copy_user, and if SEGV is disabled,
-	 * the process will die.
-	 * XXX Figure out why this is better than SA_NODEFER
-	 */
+	r.is_user = 0;
 	if (sig == SIGSEGV) {
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
-	} else
-		r = TASK_REGS(get_current());
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
+		/* For segfaults, we want the data from the sigcontext. */
+		copy_sc(&r, sc);
+		GET_FAULTINFO_FROM_SC(r.faultinfo, sc);
+	}
 
-	/* unblock SIGVTALRM, SIGIO if sig isn't IRQ signal */
+	/* enable signals if sig isn't IRQ signal */
 	if ((sig != SIGIO) && (sig != SIGWINCH) && (sig != SIGVTALRM))
 		unblock_signals();
 
-	handler(sig, r);
+	(*sig_info[sig])(sig, &r);
 
 	errno = save_errno;
-	r->is_user = save_user;
 }
 
-/* Copied from linux/compiler-gcc.h since we can't include it directly */
-#define barrier() __asm__ __volatile__("": : :"memory")
-
 /*
  * These are the asynchronous signals.  SIGPROF is excluded because we want to
  * be able to profile all of UML, not just the non-critical sections.  If
@@ -107,7 +77,7 @@ void sig_handler(int sig, struct sigcont
 
 	block_signals();
 
-	sig_handler_common_skas(sig, sc);
+	sig_handler_common(sig, sc);
 
 	set_signals(enabled);
 }
@@ -227,6 +197,9 @@ void set_handler(int sig, void (*handler
 		sigaddset(&action.sa_mask, mask);
 	va_end(ap);
 
+	if (sig == SIGSEGV)
+		flags |= SA_NODEFER;
+
 	action.sa_flags = flags;
 	action.sa_restorer = NULL;
 	if (sigaction(sig, &action, NULL) < 0)
@@ -306,7 +279,7 @@ void unblock_signals(void)
 		 * back here.
 		 */
 		if (save_pending & SIGIO_MASK)
-			sig_handler_common_skas(SIGIO, NULL);
+			sig_handler_common(SIGIO, NULL);
 
 		if (save_pending & SIGVTALRM_MASK)
 			real_alarm_handler(NULL);

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
