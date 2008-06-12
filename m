Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1K6pfb-0003FZ-Gr for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 09:29:03 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1K6pfa-00025h-PZ
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 12 Jun 2008 09:29:03 -0700
Date: Thu, 12 Jun 2008 12:28:42 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080612162842.GA8406@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/2] UML - Work around broken host PTRACE_SYSEMU
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

Fedora broke PTRACE_SYSEMU again, and UML crashes as a result when it
doesn't need to.  This patch makes the PTRACE_SYSEMU check fail
gracefully and makes UML fall back to PTRACE_SYSCALL.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/os-Linux/start_up.c |   25 ++++++++++++++++---------
 1 file changed, 16 insertions(+), 9 deletions(-)

Index: linux-2.6.22/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.22.orig/arch/um/os-Linux/start_up.c	2008-06-10 11:42:06.000000000 -0400
+++ linux-2.6.22/arch/um/os-Linux/start_up.c	2008-06-10 12:16:57.000000000 -0400
@@ -121,8 +121,10 @@ static int stop_ptraced_child(int pid, i
 {
 	int status, n, ret = 0;
 
-	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0)
-		fatal_perror("stop_ptraced_child : ptrace failed");
+	if (ptrace(PTRACE_CONT, pid, 0, 0) < 0) {
+		perror("stop_ptraced_child : ptrace failed");
+		return -1;
+	}
 	CATCH_EINTR(n = waitpid(pid, &status, 0));
 	if (!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
 		int exit_with = WEXITSTATUS(status);
@@ -212,7 +214,7 @@ static void __init check_sysemu(void)
 	if (n < 0)
 		fatal_perror("check_sysemu : wait failed");
 	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-		fatal("check_sysemu : expected SIGTRAP, got status = %d",
+		fatal("check_sysemu : expected SIGTRAP, got status = %d\n",
 		      status);
 
 	if (ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
@@ -254,9 +256,11 @@ static void __init check_sysemu(void)
 
 		if (WIFSTOPPED(status) &&
 		    (WSTOPSIG(status) == (SIGTRAP|0x80))) {
-			if (!count)
-				fatal("check_ptrace : SYSEMU_SINGLESTEP "
-				      "doesn't singlestep");
+			if (!count) {
+				non_fatal("check_ptrace : SYSEMU_SINGLESTEP "
+					  "doesn't singlestep");
+				goto fail;
+			}
 			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
 				   os_getpid());
 			if (n < 0)
@@ -266,9 +270,12 @@ static void __init check_sysemu(void)
 		}
 		else if (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGTRAP))
 			count++;
-		else
-			fatal("check_ptrace : expected SIGTRAP or "
-			      "(SIGTRAP | 0x80), got status = %d", status);
+		else {
+			non_fatal("check_ptrace : expected SIGTRAP or "
+				  "(SIGTRAP | 0x80), got status = %d\n",
+				  status);
+			goto fail;
+		}
 	}
 	if (stop_ptraced_child(pid, 0, 0) < 0)
 		goto fail_stopped;

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://sourceforge.net/services/buy/index.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
