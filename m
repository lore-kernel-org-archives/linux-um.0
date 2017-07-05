Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <thomas@m3y3r.de>) id 1dSspS-0000KZ-PW
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 22:31:26 +0000
Received: from www17.your-server.de ([213.133.104.17])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1dSspR-0007YJ-U2
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 05 Jul 2017 22:31:26 +0000
From: Thomas Meyer <thomas@m3y3r.de>
Date: Thu,  6 Jul 2017 00:31:14 +0200
Message-Id: <20170705223114.10419-1-thomas@m3y3r.de>
Subject: [uml-devel] [PATCH] um: userspace - be more verbose in ptrace set
 regs error
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/user-mode-linux-devel>,
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
To: user-mode-linux-devel@lists.sourceforge.net

When ptrace fails to set GP/FP regs for the target process,
log the error before crashing the UML kernel.

Signed-off-by: Thomas Meyer <thomas@m3y3r.de>
---
 arch/um/os-Linux/skas/process.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 4530867..819d686 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -352,11 +352,17 @@ void userspace(struct uml_pt_regs *regs)
 		 * fail.  In this case, there is nothing to do but
 		 * just kill the process.
 		 */
-		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp))
+		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp)) {
+			printk(UM_KERN_ERR "userspace - ptrace set regs "
+			       "failed, errno = %d\n", errno);
 			fatal_sigsegv();
+		}
 
-		if (put_fp_registers(pid, regs->fp))
+		if (put_fp_registers(pid, regs->fp)) {
+			printk(UM_KERN_ERR "userspace - ptrace set fp regs "
+			       "failed, errno = %d\n", errno);
 			fatal_sigsegv();
+		}
 
 		/* Now we set local_using_sysemu to be used for one loop */
 		local_using_sysemu = get_using_sysemu();
-- 
2.9.4


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

