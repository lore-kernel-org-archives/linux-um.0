Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IV76K-0006j8-4P for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:52:28 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IV76I-0003GF-Cy
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:52:28 -0700
Date: Tue, 11 Sep 2007 10:52:21 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070911145221.GA6318@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 2/3 ] UML - Remove unused file
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

arch/um/os-Linux/tt.c is no longer used.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/tt.c |  195 --------------------------------------------------
 1 file changed, 195 deletions(-)

Index: linux-2.6.22/arch/um/os-Linux/tt.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/tt.c	2007-09-02 14:05:53.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,195 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <signal.h>
-#include <sched.h>
-#include <errno.h>
-#include <stdarg.h>
-#include <stdlib.h>
-#include <sys/time.h>
-#include <sys/ptrace.h>
-#include <linux/ptrace.h>
-#include <sys/wait.h>
-#include <sys/mman.h>
-#include <asm/ptrace.h>
-#include <asm/unistd.h>
-#include "kern_util.h"
-#include "user.h"
-#include "signal_kern.h"
-#include "sysdep/ptrace.h"
-#include "sysdep/sigcontext.h"
-#include "irq_user.h"
-#include "ptrace_user.h"
-#include "init.h"
-#include "os.h"
-#include "uml-config.h"
-#include "choose-mode.h"
-#include "mode.h"
-#include "tempfile.h"
-#include "kern_constants.h"
-
-int protect_memory(unsigned long addr, unsigned long len, int r, int w, int x,
-		   int must_succeed)
-{
-	int err;
-
-	err = os_protect_memory((void *) addr, len, r, w, x);
-	if(err < 0){
-                if(must_succeed)
-			panic("protect failed, err = %d", -err);
-		else return(err);
-	}
-	return(0);
-}
-
-void kill_child_dead(int pid)
-{
-	kill(pid, SIGKILL);
-	kill(pid, SIGCONT);
-	do {
-		int n;
-		CATCH_EINTR(n = waitpid(pid, NULL, 0));
-		if (n > 0)
-			kill(pid, SIGCONT);
-		else
-			break;
-	} while(1);
-}
-
-void stop(void)
-{
-	while(1) sleep(1000000);
-}
-
-int wait_for_stop(int pid, int sig, int cont_type, void *relay)
-{
-	sigset_t *relay_signals = relay;
-	int status, ret;
-
-	while(1){
-		CATCH_EINTR(ret = waitpid(pid, &status, WUNTRACED));
-		if((ret < 0) ||
-		   !WIFSTOPPED(status) || (WSTOPSIG(status) != sig)){
-			if(ret < 0){
-				printk("wait failed, errno = %d\n",
-				       errno);
-			}
-			else if(WIFEXITED(status))
-				printk("process %d exited with status %d\n",
-				       pid, WEXITSTATUS(status));
-			else if(WIFSIGNALED(status))
-				printk("process %d exited with signal %d\n",
-				       pid, WTERMSIG(status));
-			else if((WSTOPSIG(status) == SIGVTALRM) ||
-				(WSTOPSIG(status) == SIGALRM) ||
-				(WSTOPSIG(status) == SIGIO) ||
-				(WSTOPSIG(status) == SIGPROF) ||
-				(WSTOPSIG(status) == SIGCHLD) ||
-				(WSTOPSIG(status) == SIGWINCH) ||
-				(WSTOPSIG(status) == SIGINT)){
-				ptrace(cont_type, pid, 0, WSTOPSIG(status));
-				continue;
-			}
-			else if((relay_signals != NULL) &&
-				sigismember(relay_signals, WSTOPSIG(status))){
-				ptrace(cont_type, pid, 0, WSTOPSIG(status));
-				continue;
-			}
-			else printk("process %d stopped with signal %d\n",
-				    pid, WSTOPSIG(status));
-			panic("wait_for_stop failed to wait for %d to stop "
-			      "with %d\n", pid, sig);
-		}
-		return(status);
-	}
-}
-
-void forward_ipi(int fd, int pid)
-{
-	int err;
-
-	err = os_set_owner(fd, pid);
-	if(err < 0)
-		printk("forward_ipi: set_owner failed, fd = %d, me = %d, "
-		       "target = %d, err = %d\n", fd, os_getpid(), pid, -err);
-}
-
-/*
- *-------------------------
- * only for tt mode (will be deleted in future...)
- *-------------------------
- */
-
-struct tramp {
-	int (*tramp)(void *);
-	void *tramp_data;
-	unsigned long temp_stack;
-	int flags;
-	int pid;
-};
-
-/* See above for why sigkill is here */
-
-int sigkill = SIGKILL;
-
-int outer_tramp(void *arg)
-{
-	struct tramp *t;
-	int sig = sigkill;
-
-	t = arg;
-	t->pid = clone(t->tramp, (void *) t->temp_stack + UM_KERN_PAGE_SIZE/2,
-		       t->flags, t->tramp_data);
-	if(t->pid > 0) wait_for_stop(t->pid, SIGSTOP, PTRACE_CONT, NULL);
-	kill(os_getpid(), sig);
-	_exit(0);
-}
-
-int start_fork_tramp(void *thread_arg, unsigned long temp_stack,
-		     int clone_flags, int (*tramp)(void *))
-{
-	struct tramp arg;
-	unsigned long sp;
-	int new_pid, status, err;
-
-	/* The trampoline will run on the temporary stack */
-	sp = stack_sp(temp_stack);
-
-	clone_flags |= CLONE_FILES | SIGCHLD;
-
-	arg.tramp = tramp;
-	arg.tramp_data = thread_arg;
-	arg.temp_stack = temp_stack;
-	arg.flags = clone_flags;
-
-	/* Start the process and wait for it to kill itself */
-	new_pid = clone(outer_tramp, (void *) sp, clone_flags, &arg);
-	if(new_pid < 0)
-		return(new_pid);
-
-	CATCH_EINTR(err = waitpid(new_pid, &status, 0));
-	if(err < 0)
-		panic("Waiting for outer trampoline failed - errno = %d",
-		      errno);
-
-	if(!WIFSIGNALED(status) || (WTERMSIG(status) != SIGKILL))
-		panic("outer trampoline didn't exit with SIGKILL, "
-		      "status = %d", status);
-
-	return(arg.pid);
-}
-
-void forward_pending_sigio(int target)
-{
-	sigset_t sigs;
-
-	if(sigpending(&sigs))
-		panic("forward_pending_sigio : sigpending failed");
-	if(sigismember(&sigs, SIGIO))
-		kill(target, SIGIO);
-}
-

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
