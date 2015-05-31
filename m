Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1YzAwK-0000w5-RK
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:40 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1YzAwJ-0005qA-DA for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 31 May 2015 21:38:40 +0000
From: Richard Weinberger <richard@nod.at>
Date: Sun, 31 May 2015 23:38:24 +0200
Message-Id: <1433108305-9255-4-git-send-email-richard@nod.at>
In-Reply-To: <1433108305-9255-1-git-send-email-richard@nod.at>
References: <1433108305-9255-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 4/5] um: Handle tracehook_report_syscall_entry()
	result
To: richard@nod.at
Cc: user-mode-linux-devel@lists.sourceforge.net

tracehook_report_syscall_entry() is allowed to fail,
in case of failure we have to abort the current syscall.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/asm/ptrace-generic.h | 2 +-
 arch/um/kernel/ptrace.c              | 6 +++---
 arch/um/kernel/skas/syscall.c        | 6 +++++-
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/um/include/asm/ptrace-generic.h b/arch/um/include/asm/ptrace-generic.h
index cb9b3c4..283480a 100644
--- a/arch/um/include/asm/ptrace-generic.h
+++ b/arch/um/include/asm/ptrace-generic.h
@@ -37,7 +37,7 @@ extern int putreg(struct task_struct *child, int regno, unsigned long value);
 
 extern int arch_copy_tls(struct task_struct *new);
 extern void clear_flushed_tls(struct task_struct *task);
-extern void syscall_trace_enter(struct pt_regs *regs);
+extern int syscall_trace_enter(struct pt_regs *regs);
 extern void syscall_trace_leave(struct pt_regs *regs);
 
 #endif
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 174ee50..cac2ea0 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -131,7 +131,7 @@ static void send_sigtrap(struct task_struct *tsk, struct uml_pt_regs *regs,
  * XXX Check PT_DTRACE vs TIF_SINGLESTEP for singlestepping check and
  * PT_PTRACED vs TIF_SYSCALL_TRACE for syscall tracing check
  */
-void syscall_trace_enter(struct pt_regs *regs)
+int syscall_trace_enter(struct pt_regs *regs)
 {
 	audit_syscall_entry(UPT_SYSCALL_NR(&regs->regs),
 			    UPT_SYSCALL_ARG1(&regs->regs),
@@ -140,9 +140,9 @@ void syscall_trace_enter(struct pt_regs *regs)
 			    UPT_SYSCALL_ARG4(&regs->regs));
 
 	if (!test_thread_flag(TIF_SYSCALL_TRACE))
-		return;
+		return 0;
 
-	tracehook_report_syscall_entry(regs);
+	return tracehook_report_syscall_entry(regs);
 }
 
 void syscall_trace_leave(struct pt_regs *regs)
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index c0681e0..d9ec006 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -18,7 +18,10 @@ void handle_syscall(struct uml_pt_regs *r)
 	long result;
 	int syscall;
 
-	syscall_trace_enter(regs);
+	if (syscall_trace_enter(regs)) {
+		result = -ENOSYS;
+		goto out;
+	}
 
 	/*
 	 * This should go in the declaration of syscall, but when I do that,
@@ -34,6 +37,7 @@ void handle_syscall(struct uml_pt_regs *r)
 		result = -ENOSYS;
 	else result = EXECUTE_SYSCALL(syscall, regs);
 
+out:
 	PT_REGS_SET_SYSCALL_RETURN(regs, result);
 
 	syscall_trace_leave(regs);
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

