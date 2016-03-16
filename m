Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-2.v43.ch3.sourceforge.com ([172.29.43.192]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ag0DE-0006BV-Sf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 01:25:24 +0000
Received: from mout.gmx.net ([212.227.15.18])
	by sog-mx-2.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ag0DD-0005wX-Gs
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 01:25:24 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Wed, 16 Mar 2016 09:25:05 +0800
Message-Id: <1458091505-967-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH] um: fix FPU register double-restore after
	sigreturn
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
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>

This patch prevents userspace() from incorrectly restoring FPU registers
after a sigreturn or rt_sigreturn system call, which has already restored
FPU registers to the state prior to the signal handler was invoked.

Fixes FPU state corruption after invoking the signal handler.

Signed-off-by: Eli Cooper <elicooper@gmx.com>
---
 arch/um/os-Linux/skas/process.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 23025d6..664f184 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -310,6 +310,8 @@ void userspace(struct uml_pt_regs *regs)
 	int err, status, op, pid = userspace_pid[0];
 	/* To prevent races if using_sysemu changes under us.*/
 	int local_using_sysemu;
+	/* To prevent FPU register restore after sigreturn syscalls. */
+	int skip_fp_restore = 0;
 	siginfo_t si;
 
 	/* Handle any immediate reschedules or signals */
@@ -328,8 +330,9 @@ void userspace(struct uml_pt_regs *regs)
 		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp))
 			fatal_sigsegv();
 
-		if (put_fp_registers(pid, regs->fp))
-			fatal_sigsegv();
+		if (!skip_fp_restore)
+			if (put_fp_registers(pid, regs->fp))
+				fatal_sigsegv();
 
 		/* Now we set local_using_sysemu to be used for one loop */
 		local_using_sysemu = get_using_sysemu();
@@ -351,6 +354,7 @@ void userspace(struct uml_pt_regs *regs)
 		}
 
 		regs->is_user = 1;
+		skip_fp_restore = 0;
 		if (ptrace(PTRACE_GETREGS, pid, 0, regs->gp)) {
 			printk(UM_KERN_ERR "userspace - PTRACE_GETREGS failed, "
 			       "errno = %d\n", errno);
@@ -381,6 +385,12 @@ void userspace(struct uml_pt_regs *regs)
 				else handle_segv(pid, regs);
 				break;
 			case SIGTRAP + 0x80:
+#ifdef __i386__
+				if (PT_SYSCALL_NR(regs->gp) == __NR_sigreturn)
+					skip_fp_restore = 1;
+#endif
+				if (PT_SYSCALL_NR(regs->gp) == __NR_rt_sigreturn)
+					skip_fp_restore = 1;
 			        handle_trap(pid, regs, local_using_sysemu);
 				break;
 			case SIGTRAP:
-- 
2.7.2


------------------------------------------------------------------------------
Transform Data into Opportunity.
Accelerate data analysis in your applications with
Intel Data Analytics Acceleration Library.
Click to learn more.
http://pubads.g.doubleclick.net/gampad/clk?id=278785231&iu=/4140
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

