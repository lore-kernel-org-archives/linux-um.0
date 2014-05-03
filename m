Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1WgfN0-0005D1-5z
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 May 2014 19:13:10 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1WgfMy-0001Hs-13 for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 03 May 2014 19:13:10 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sat,  3 May 2014 21:12:43 +0200
Message-Id: <1399144364-30696-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 1/2] Revert "um: Fix wait_stub_done() error
	handling"
To: user-mode-linux-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>

This reverts commit 0974a9cadc7886f7baaa458bb0c89f5c5f9d458e.
It was a bad idea and was only papering over the real issue.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/os-Linux/skas/process.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index d531879..908579f 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -54,7 +54,7 @@ static int ptrace_dump_regs(int pid)
 
 void wait_stub_done(int pid)
 {
-	int n, status, err, bad_stop = 0;
+	int n, status, err;
 
 	while (1) {
 		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED | __WALL));
@@ -74,8 +74,6 @@ void wait_stub_done(int pid)
 
 	if (((1 << WSTOPSIG(status)) & STUB_DONE_MASK) != 0)
 		return;
-	else
-		bad_stop = 1;
 
 bad_wait:
 	err = ptrace_dump_regs(pid);
@@ -85,10 +83,7 @@ bad_wait:
 	printk(UM_KERN_ERR "wait_stub_done : failed to wait for SIGTRAP, "
 	       "pid = %d, n = %d, errno = %d, status = 0x%x\n", pid, n, errno,
 	       status);
-	if (bad_stop)
-		kill(pid, SIGKILL);
-	else
-		fatal_sigsegv();
+	fatal_sigsegv();
 }
 
 extern unsigned long current_stub_stack(void);
-- 
1.8.1.4


------------------------------------------------------------------------------
"Accelerate Dev Cycles with Automated Cross-Browser Testing - For FREE
Instantly run your Selenium tests across 300+ browser/OS combos.  Get 
unparalleled scalability from the best Selenium testing platform available.
Simple to use. Nothing to install. Get started now for free."
http://p.sf.net/sfu/SauceLabs
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

