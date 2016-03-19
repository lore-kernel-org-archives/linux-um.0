Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-4.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <elicooper@gmx.com>) id 1ahKDR-00042U-4e
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2016 16:59:05 +0000
Received: from mout.gmx.net ([212.227.17.21])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1ahKDP-0002fy-Qf
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 19 Mar 2016 16:59:05 +0000
From: Eli Cooper <elicooper@gmx.com>
Date: Sun, 20 Mar 2016 00:58:41 +0800
Message-Id: <1458406721-7478-4-git-send-email-elicooper@gmx.com>
In-Reply-To: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
References: <1458406721-7478-1-git-send-email-elicooper@gmx.com>
Subject: [uml-devel] [PATCH v3 3/3] um: add extended processor state
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
support for new processor state extensions between context switches.

When the new ptrace requests are unavailable, it falls back to the old
PTRACE_GETFPREGS and PTRACE_SETFPREGS methods, which have been renamed to
save_i387_registers() and restore_i387_registers().

Now these functions expect *fp_regs to have the space of an _xstate struct.
Thus, this also makes ptrace in UML responde to PTRACE_GETFPREGS/_SETFPREG
requests with a user_i387_struct (thus independent from HOST_FP_SIZE), and
by calling save_i387_registers() and restore_i387_registers() instead of
the extended save_fp_registers() and restore_fp_registers() functions.

Signed-off-by: Eli Cooper <elicooper@gmx.com>
---
 arch/um/include/shared/registers.h    |  2 ++
 arch/um/kernel/process.c              |  2 +-
 arch/x86/um/os-Linux/registers.c      | 49 +++++++++++++++++++++++++++++++++--
 arch/x86/um/ptrace_32.c               |  5 ++--
 arch/x86/um/ptrace_64.c               | 16 ++++++------
 arch/x86/um/shared/sysdep/ptrace_64.h |  4 +--
 6 files changed, 62 insertions(+), 16 deletions(-)

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
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 47c78d5..ebd4dd6 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -194,7 +194,8 @@ static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
 	struct user_i387_struct fpregs;
 
-	err = save_fp_registers(userspace_pid[cpu], (unsigned long *) &fpregs);
+	err = save_i387_registers(userspace_pid[cpu],
+				  (unsigned long *) &fpregs);
 	if (err)
 		return err;
 
@@ -214,7 +215,7 @@ static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_fp_registers(userspace_pid[cpu],
+	return restore_i387_registers(userspace_pid[cpu],
 				    (unsigned long *) &fpregs);
 }
 
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index a629694..faab418 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -222,14 +222,14 @@ int is_syscall(unsigned long addr)
 static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_FP_SIZE];
+	struct user_i387_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	err = save_fp_registers(userspace_pid[cpu], fpregs);
+	err = save_i387_registers(userspace_pid[cpu],
+				  (unsigned long *) &fpregs);
 	if (err)
 		return err;
 
-	n = copy_to_user(buf, fpregs, sizeof(fpregs));
+	n = copy_to_user(buf, &fpregs, sizeof(fpregs));
 	if (n > 0)
 		return -EFAULT;
 
@@ -239,14 +239,14 @@ static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *c
 static int set_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
 	int n, cpu = ((struct thread_info *) child->stack)->cpu;
-	long fpregs[HOST_FP_SIZE];
+	struct user_i387_struct fpregs;
 
-	BUG_ON(sizeof(*buf) != sizeof(fpregs));
-	n = copy_from_user(fpregs, buf, sizeof(fpregs));
+	n = copy_from_user(&fpregs, buf, sizeof(fpregs));
 	if (n > 0)
 		return -EFAULT;
 
-	return restore_fp_registers(userspace_pid[cpu], fpregs);
+	return restore_i387_registers(userspace_pid[cpu],
+				      (unsigned long *) &fpregs);
 }
 
 long subarch_ptrace(struct task_struct *child, long request,
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

