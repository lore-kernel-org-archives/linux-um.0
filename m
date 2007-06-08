Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HwYof-0008NT-4p for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jun 2007 00:23:25 -0700
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]
	helo=sous-sol.org)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1HwYoe-0003ND-O3
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 08 Jun 2007 00:23:25 -0700
Message-Id: <20070608072217.582992000@sous-sol.org>
References: <20070608072127.352723000@sous-sol.org>
Date: Fri, 08 Jun 2007 00:21:59 -0700
From: Chris Wright <chrisw@sous-sol.org>
Content-Disposition: inline;
	filename=uml-improve-host-ptrace_sysemu-check.patch
Subject: [uml-devel] [patch 32/54] UML - Improve host PTRACE_SYSEMU check
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: linux-kernel@vger.kernel.org, stable@kernel.org
Cc: Theodore Ts'o <tytso@mit.edu>, Zwane Mwaikambo <zwane@arm.linux.org.uk>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, Greg Kroah-Hartman <gregkh@suse.de>, Justin Forbes <jmforbes@linuxtx.org>, Domenico Andreoli <cavokz@gmail.com>, Chris Wedgwood <reviews@ml.cw.f00f.org>, Randy Dunlap <rdunlap@xenotime.net>, Michael Krufky <mkrufky@linuxtv.org>, Chuck Ebbert <cebbert@redhat.com>, Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>, akpm@linux-foundation.org, Jeff Dike <jdike@linux.intel.com>, torvalds@linux-foundation.org, alan@lxorguk.ukuu.org.uk

-stable review patch.  If anyone has any objections, please let us know.
---------------------

From: Jeff Dike <jdike@addtoit.com>

Make the PTRACE_SYSEMU checking more robust.  It will make sure that
system call numbers are reported correctly.  If there is a problem, it
will disable PTRACE_SYSEMU use and use PTRACE_SYSCALL instead.

This fixes a hang on boot on FC6 hosts with a broken PTRACE_SYSEMU.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
--
 arch/um/os-Linux/start_up.c |   24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

--- linux-2.6.21.4.orig/arch/um/os-Linux/start_up.c
+++ linux-2.6.21.4/arch/um/os-Linux/start_up.c
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

-- 

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
