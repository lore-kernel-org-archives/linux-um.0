Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1ZqeOH-0000dt-UV
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:33 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ZqeOG-000076-Ii for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 26 Oct 2015 09:48:33 +0000
From: Richard Weinberger <richard@nod.at>
Date: Mon, 26 Oct 2015 10:48:12 +0100
Message-Id: <1445852897-13102-2-git-send-email-richard@nod.at>
In-Reply-To: <1445852897-13102-1-git-send-email-richard@nod.at>
References: <1445852897-13102-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 2/7] um: Store syscall number after
	syscall_trace_enter()
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

To support changing syscall numbers we have to store
it after syscall_trace_enter().

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/shared/os.h     |  1 +
 arch/um/kernel/skas/syscall.c   | 13 +++----------
 arch/um/os-Linux/skas/process.c | 10 +++++++---
 3 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index ad3fa3a..f3cbaef 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -274,6 +274,7 @@ extern void initial_thread_cb_skas(void (*proc)(void *),
 				 void *arg);
 extern void halt_skas(void);
 extern void reboot_skas(void);
+extern int get_syscall(struct uml_pt_regs *regs);
 
 /* irq.c */
 extern int os_waiting_for_events(struct irq_fd *active_fds);
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index d9ec006..64a8fe5 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -8,6 +8,7 @@
 #include <kern_util.h>
 #include <sysdep/ptrace.h>
 #include <sysdep/syscalls.h>
+#include <os.h>
 
 extern int syscall_table_size;
 #define NR_SYSCALLS (syscall_table_size / sizeof(void *))
@@ -23,16 +24,8 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 	}
 
-	/*
-	 * This should go in the declaration of syscall, but when I do that,
-	 * strace -f -c bash -c 'ls ; ls' breaks, sometimes not tracing
-	 * children at all, sometimes hanging when bash doesn't see the first
-	 * ls exit.
-	 * The assembly looks functionally the same to me.  This is
-	 *     gcc version 4.0.1 20050727 (Red Hat 4.0.1-5)
-	 * in case it's a compiler bug.
-	 */
-	syscall = UPT_SYSCALL_NR(r);
+	syscall = get_syscall(r);
+
 	if ((syscall >= NR_SYSCALLS) || (syscall < 0))
 		result = -ENOSYS;
 	else result = EXECUTE_SYSCALL(syscall, regs);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 3dddedb..d38f495 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -137,9 +137,6 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
 	if ((UPT_IP(regs) >= STUB_START) && (UPT_IP(regs) < STUB_END))
 		fatal_sigsegv();
 
-	/* Mark this as a syscall */
-	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->gp);
-
 	if (!local_using_sysemu)
 	{
 		err = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
@@ -174,6 +171,13 @@ static void handle_trap(int pid, struct uml_pt_regs *regs,
 	handle_syscall(regs);
 }
 
+int get_syscall(struct uml_pt_regs *regs)
+{
+	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->gp);
+
+	return UPT_SYSCALL_NR(regs);
+}
+
 extern char __syscall_stub_start[];
 
 static int userspace_tramp(void *stack)
-- 
1.8.4.5


------------------------------------------------------------------------------
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

