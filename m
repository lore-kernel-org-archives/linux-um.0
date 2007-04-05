Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HZYZx-00031g-It for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2007 13:29:09 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HZYZx-0004p2-2w
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2007 13:29:09 -0700
Date: Thu, 5 Apr 2007 16:24:53 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070405202453.GA8934@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/4] UML - Dump registers on ptrace or wait failure
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Provide a register dump if handle_trap fails.
Abstract out ptrace_dump_regs since it now has two callers.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/os-Linux/skas/process.c |   37 +++++++++++++++++++++++++------------
 1 file changed, 25 insertions(+), 12 deletions(-)

Index: linux-2.6.21-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/os-Linux/skas/process.c	2007-04-05 12:38:43.000000000 -0400
+++ linux-2.6.21-mm/arch/um/os-Linux/skas/process.c	2007-04-05 12:39:12.000000000 -0400
@@ -44,6 +44,22 @@ int is_skas_winch(int pid, int fd, void 
 	return(1);
 }
 
+static int ptrace_dump_regs(int pid)
+{
+        unsigned long regs[MAX_REG_NR];
+        int i;
+
+        if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
+                return -errno;
+        else {
+                printk("Stub registers -\n");
+                for(i = 0; i < ARRAY_SIZE(regs); i++)
+                        printk("\t%d - %lx\n", i, regs[i]);
+        }
+
+        return 0;
+}
+
 void wait_stub_done(int pid, int sig, char * fname)
 {
 	int n, status, err;
@@ -67,18 +83,10 @@ void wait_stub_done(int pid, int sig, ch
 
 	if((n < 0) || !WIFSTOPPED(status) ||
 	   (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
-		unsigned long regs[MAX_REG_NR];
-
-		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
+		err = ptrace_dump_regs(pid);
+		if(err)
 			printk("Failed to get registers from stub, "
-			       "errno = %d\n", errno);
-		else {
-			int i;
-
-			printk("Stub registers -\n");
-			for(i = 0; i < ARRAY_SIZE(regs); i++)
-				printk("\t%d - %lx\n", i, regs[i]);
-		}
+			       "errno = %d\n", -err);
 		panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
 		      "pid = %d, n = %d, errno = %d, status = 0x%x\n",
 		      fname, pid, n, errno, status);
@@ -142,9 +150,14 @@ static void handle_trap(int pid, union u
 
 		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
 		if((err < 0) || !WIFSTOPPED(status) ||
-		   (WSTOPSIG(status) != SIGTRAP + 0x80))
+		   (WSTOPSIG(status) != SIGTRAP + 0x80)){
+                        err = ptrace_dump_regs(pid);
+                        if(err)
+                                printk("Failed to get registers from process, "
+                                       "errno = %d\n", -err);
 			panic("handle_trap - failed to wait at end of syscall, "
 			      "errno = %d, status = %d\n", errno, status);
+                }
 	}
 
 	handle_syscall(regs);

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
