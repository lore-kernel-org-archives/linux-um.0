Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ag78R-0000jq-Am
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 08:48:55 +0000
Received: from mout.gmx.net ([212.227.15.19])
	by sog-mx-1.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1ag78Q-000327-6K for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 16 Mar 2016 08:48:55 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Wed, 16 Mar 2016 16:48:28 +0800
Message-Id: <1458118109-3178-3-git-send-email-elicooper@gmx.com>
In-Reply-To: <1458118109-3178-1-git-send-email-elicooper@gmx.com>
References: <1458118109-3178-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH v2 2/3] um: add extended processor state
	save/restore support
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

This patch extends save_fp_registers() and restore_fp_registers() to use
PTRACE_GETREGSET and PTRACE_SETREGSET with the XSTATE note type, adding
support for new processor state extensions.

Now these functions expect *fp_regs to have the space of an _xstate struct.

When the new ptrace requests are unavailable, it falls back to the old
PTRACE_GETFPREGS and PTRACE_SETFPREGS methods, which have been renamed to
save_i387_registers() and restore_i387_registers().

Signed-off-by: Eli Cooper <elicooper@gmx.com>
---
 arch/um/include/shared/registers.h    |  2 ++
 arch/um/kernel/process.c              |  2 +-
 arch/x86/um/os-Linux/registers.c      | 49 +++++++++++++++++++++++++++++++++--
 arch/x86/um/shared/sysdep/ptrace_64.h |  4 +--
 4 files changed, 51 insertions(+), 6 deletions(-)

diff --git a/arch/um/include/shared/registers.h b/arch/um/include/shared/registers.h
index f5b7635..a74449b 100644
--- a/arch/um/include/shared/registers.h
+++ b/arch/um/include/shared/registers.h
@@ -9,6 +9,8 @@
 #include <sysdep/ptrace.h>
 #include <sysdep/archsetjmp.h>
 
+extern int save_i387_registers(int pid, unsigned long *fp_regs);
+extern int restore_i387_registers(int pid, unsigned long *fp_regs);
 extern int save_fp_registers(int pid, unsigned long *fp_regs);
 extern int restore_fp_registers(int pid, unsigned long *fp_regs);
 extern int save_fpx_registers(int pid, unsigned long *fp_regs);
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 48af59a..d55a473 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -402,6 +402,6 @@ int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu)
 {
 	int cpu = current_thread_info()->cpu;
 
-	return save_fp_registers(userspace_pid[cpu], (unsigned long *) fpu);
+	return save_i387_registers(userspace_pid[cpu], (unsigned long *) fpu);
 }
 
diff --git a/arch/x86/um/os-Linux/registers.c b/arch/x86/um/os-Linux/registers.c
index 41bfe84..00f54a9 100644
--- a/arch/x86/um/os-Linux/registers.c
+++ b/arch/x86/um/os-Linux/registers.c
@@ -11,21 +11,56 @@
 #endif
 #include <longjmp.h>
 #include <sysdep/ptrace_user.h>
+#include <sys/uio.h>
+#include <asm/sigcontext.h>
+#include <linux/elf.h>
 
-int save_fp_registers(int pid, unsigned long *fp_regs)
+int have_xstate_support;
+
+int save_i387_registers(int pid, unsigned long *fp_regs)
 {
 	if (ptrace(PTRACE_GETFPREGS, pid, 0, fp_regs) < 0)
 		return -errno;
 	return 0;
 }
 
-int restore_fp_registers(int pid, unsigned long *fp_regs)
+int save_fp_registers(int pid, unsigned long *fp_regs)
+{
+	struct iovec iov;
+
+	if (have_xstate_support) {
+		iov.iov_base = fp_regs;
+		iov.iov_len = sizeof(struct _xstate);
+		if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
+			return -errno;
+		return 0;
+	} else {
+		return save_i387_registers(pid, fp_regs);
+	}
+}
+
+int restore_i387_registers(int pid, unsigned long *fp_regs)
 {
 	if (ptrace(PTRACE_SETFPREGS, pid, 0, fp_regs) < 0)
 		return -errno;
 	return 0;
 }
 
+int restore_fp_registers(int pid, unsigned long *fp_regs)
+{
+	struct iovec iov;
+
+	if (have_xstate_support) {
+		iov.iov_base = fp_regs;
+		iov.iov_len = sizeof(struct _xstate);
+		if (ptrace(PTRACE_SETREGSET, pid, NT_X86_XSTATE, &iov) < 0)
+			return -errno;
+		return 0;
+	} else {
+		return restore_i387_registers(pid, fp_regs);
+	}
+}
+
 #ifdef __i386__
 int have_fpx_regs = 1;
 int save_fpx_registers(int pid, unsigned long *fp_regs)
@@ -85,6 +120,16 @@ int put_fp_registers(int pid, unsigned long *regs)
 	return restore_fp_registers(pid, regs);
 }
 
+void arch_init_registers(int pid)
+{
+	struct _xstate fp_regs;
+	struct iovec iov;
+
+	iov.iov_base = &fp_regs;
+	iov.iov_len = sizeof(struct _xstate);
+	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_XSTATE, &iov) == 0)
+		have_xstate_support = 1;
+}
 #endif
 
 unsigned long get_thread_reg(int reg, jmp_buf *buf)
diff --git a/arch/x86/um/shared/sysdep/ptrace_64.h b/arch/x86/um/shared/sysdep/ptrace_64.h
index 919789f..0dc223a 100644
--- a/arch/x86/um/shared/sysdep/ptrace_64.h
+++ b/arch/x86/um/shared/sysdep/ptrace_64.h
@@ -57,8 +57,6 @@
 #define UPT_SYSCALL_ARG5(r) UPT_R8(r)
 #define UPT_SYSCALL_ARG6(r) UPT_R9(r)
 
-static inline void arch_init_registers(int pid)
-{
-}
+extern void arch_init_registers(int pid);
 
 #endif
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

