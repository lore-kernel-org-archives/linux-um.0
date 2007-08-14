Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IL47u-0001ak-DY for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:40:34 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IL47q-0008Am-WA
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 14 Aug 2007 14:40:34 -0700
Date: Tue, 14 Aug 2007 17:40:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070814214027.GA17549@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 14/14] UML - Replace clone with fork
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

Convert the boot-time host ptrace testing from clone to fork.  They were
essentially doing fork anyway.  This cleans up the code a bit, and makes
valgrind a bit happier about grinding it.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/start_up.c |   55 ++++++++++++++++----------------------------
 1 file changed, 20 insertions(+), 35 deletions(-)

Index: linux-2.6.22/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/start_up.c	2007-08-10 15:59:56.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/start_up.c	2007-08-10 16:16:32.000000000 -0400
@@ -25,7 +25,7 @@
 #include "registers.h"
 #include "skas_ptrace.h"
 
-static int ptrace_child(void *arg)
+static int ptrace_child(void)
 {
 	int ret;
 	int pid = os_getpid(), ppid = getppid();
@@ -90,31 +90,23 @@ static void non_fatal(char *fmt, ...)
 	fflush(stdout);
 }
 
-static int start_ptraced_child(void **stack_out)
+static int start_ptraced_child(void)
 {
-	void *stack;
-	unsigned long sp;
 	int pid, n, status;
 
-	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
-		     PROT_READ | PROT_WRITE | PROT_EXEC,
-		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	if (stack == MAP_FAILED)
-		fatal_perror("check_ptrace : mmap failed");
-
-	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);
-	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
-	if (pid < 0)
-		fatal_perror("start_ptraced_child : clone failed");
+	pid = fork();
+	if (pid == 0)
+		ptrace_child();
+	else if (pid < 0)
+		fatal_perror("start_ptraced_child : fork failed");
 
 	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
 	if (n < 0)
-		fatal_perror("check_ptrace : clone failed");
+		fatal_perror("check_ptrace : waitpid failed");
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP))
 		fatal("check_ptrace : expected SIGSTOP, got status = %d",
 		      status);
 
-	*stack_out = stack;
 	return pid;
 }
 
@@ -124,8 +116,7 @@ static int start_ptraced_child(void **st
  * So only for SYSEMU features we test mustpanic, while normal host features
  * must work anyway!
  */
-static int stop_ptraced_child(int pid, void *stack, int exitcode,
-			      int mustexit)
+static int stop_ptraced_child(int pid, int exitcode, int mustexit)
 {
 	int status, n, ret = 0;
 
@@ -145,8 +136,6 @@ static int stop_ptraced_child(int pid, v
 		ret = -1;
 	}
 
-	if (munmap(stack, UM_KERN_PAGE_SIZE) < 0)
-		fatal_perror("check_ptrace : munmap failed");
 	return ret;
 }
 
@@ -198,13 +187,12 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 
 static void __init check_sysemu(void)
 {
-	void *stack;
 	unsigned long regs[MAX_REG_NR];
 	int pid, n, status, count=0;
 
 	non_fatal("Checking syscall emulation patch for ptrace...");
 	sysemu_supported = 0;
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 
 	if (ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
 		goto fail;
@@ -231,7 +219,7 @@ static void __init check_sysemu(void)
 		goto fail;
 	}
 
-	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+	if (stop_ptraced_child(pid, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 1;
@@ -239,7 +227,7 @@ static void __init check_sysemu(void)
 	set_using_sysemu(!force_sysemu_disabled);
 
 	non_fatal("Checking advanced syscall emulation patch for ptrace...");
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 
 	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0))
@@ -271,7 +259,7 @@ static void __init check_sysemu(void)
 			fatal("check_ptrace : expected SIGTRAP or "
 			      "(SIGTRAP | 0x80), got status = %d", status);
 	}
-	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+	if (stop_ptraced_child(pid, 0, 0) < 0)
 		goto fail_stopped;
 
 	sysemu_supported = 2;
@@ -282,18 +270,17 @@ static void __init check_sysemu(void)
 	return;
 
 fail:
-	stop_ptraced_child(pid, stack, 1, 0);
+	stop_ptraced_child(pid, 1, 0);
 fail_stopped:
 	non_fatal("missing\n");
 }
 
 static void __init check_ptrace(void)
 {
-	void *stack;
 	int pid, syscall, n, status;
 
 	non_fatal("Checking that ptrace can change system call numbers...");
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 
 	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0))
@@ -323,7 +310,7 @@ static void __init check_ptrace(void)
 			break;
 		}
 	}
-	stop_ptraced_child(pid, stack, 0, 1);
+	stop_ptraced_child(pid, 0, 1);
 	non_fatal("OK\n");
 	check_sysemu();
 }
@@ -403,11 +390,10 @@ __uml_setup("noptraceldt", noptraceldt_c
 static inline void check_skas3_ptrace_faultinfo(void)
 {
 	struct ptrace_faultinfo fi;
-	void *stack;
 	int pid, n;
 
 	non_fatal("  - PTRACE_FAULTINFO...");
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
 	if (n < 0) {
@@ -425,13 +411,12 @@ static inline void check_skas3_ptrace_fa
 	}
 
 	init_registers(pid);
-	stop_ptraced_child(pid, stack, 1, 1);
+	stop_ptraced_child(pid, 1, 1);
 }
 
 static inline void check_skas3_ptrace_ldt(void)
 {
 #ifdef PTRACE_LDT
-	void *stack;
 	int pid, n;
 	unsigned char ldtbuf[40];
 	struct ptrace_ldt ldt_op = (struct ptrace_ldt) {
@@ -440,7 +425,7 @@ static inline void check_skas3_ptrace_ld
 		.bytecount = sizeof(ldtbuf)};
 
 	non_fatal("  - PTRACE_LDT...");
-	pid = start_ptraced_child(&stack);
+	pid = start_ptraced_child();
 
 	n = ptrace(PTRACE_LDT, pid, 0, (unsigned long) &ldt_op);
 	if (n < 0) {
@@ -458,7 +443,7 @@ static inline void check_skas3_ptrace_ld
 			non_fatal("found, but use is disabled\n");
 	}
 
-	stop_ptraced_child(pid, stack, 1, 1);
+	stop_ptraced_child(pid, 1, 1);
 #else
 	/* PTRACE_LDT might be disabled via cmdline option.
 	 * We want to override this, else we might use the stub

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
