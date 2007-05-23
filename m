Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HqtsA-0003uQ-MP for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 09:39:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Hqts9-0007sE-6p
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 23 May 2007 09:39:38 -0700
Date: Wed, 23 May 2007 12:33:01 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070523163301.GA5558@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/2] UML - Improve PTRACE_SYSEMU checking
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
Cc: balajig81@gmail.com, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Make the PTRACE_SYSEMU checking more robust.  It will make sure that
system call numbers are reported correctly.  If there is a problem, it
will disable PTRACE_SYSEMU use and use PTRACE_SYSCALL instead.

Thanks to Balaji G for helping reproduce this problem.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/start_up.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

Index: linux-2.6.21-mm/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/start_up.c	2007-05-16 18:23:49.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/start_up.c	2007-05-22 17:47:57.000000000 -0400
@@ -144,9 +144,7 @@ static int stop_ptraced_child(int pid, v
 		int exit_with = WEXITSTATUS(status);
 		if (exit_with == 2)
 			non_fatal("check_ptrace : child exited with status 2. "
-				  "Serious trouble happening! Try updating "
-				  "your host skas patch!\nDisabling SYSEMU "
-				  "support.");
+				  "\nDisabling SYSEMU support.\n");
 		non_fatal("check_ptrace : child exited with exitcode %d, while "
 			  "expecting %d; status 0x%x\n", exit_with,
 			  exitcode, status);
@@ -209,6 +207,7 @@ __uml_setup("nosysemu", nosysemu_cmd_par
 static void __init check_sysemu(void)
 {
 	void *stack;
+	unsigned long regs[MAX_REG_NR];
 	int pid, n, status, count=0;
 
 	non_fatal("Checking syscall emulation patch for ptrace...");
@@ -225,11 +224,20 @@ static void __init check_sysemu(void)
 		fatal("check_sysemu : expected SIGTRAP, got status = %d",
 		      status);
 
-	n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
-		   os_getpid());
-	if(n < 0)
-		fatal_perror("check_sysemu : failed to modify system call "
-			     "return");
+	if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
+		fatal_perror("check_sysemu : PTRACE_GETREGS failed");
+	if(PT_SYSCALL_NR(regs) != __NR_getpid){
+		non_fatal("check_sysemu got system call number %d, "
+			  "expected %d...", PT_SYSCALL_NR(regs), __NR_getpid);
+		goto fail;
+	}
+
+	n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET, os_getpid());
+	if(n < 0){
+		non_fatal("check_sysemu : failed to modify system call "
+			  "return");
+		goto fail;
+	}
 
 	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
 		goto fail_stopped;

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
