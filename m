Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 15 May 2008 16:11:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080515201117.GA12331@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 3/12] SKAS4 - Host get_mm and switch_mm
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: uml-user <user-mode-linux-user@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This is the new_mm, switch_mm, and /proc/<pid>/mm implementation for
32- and 64-bit x86 and UML, plus 32-bit support on 64-bit x86.

diff --git a/arch/um/include/skas_ptrace.h b/arch/um/include/skas_ptrace.h
index cd2327d..38ec9fd 100644
--- a/arch/um/include/skas_ptrace.h
+++ b/arch/um/include/skas_ptrace.h
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2000 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
@@ -7,19 +7,10 @@
 #define __SKAS_PTRACE_H
 
 #define PTRACE_FAULTINFO 52
-#define PTRACE_SWITCH_MM 55
+#ifndef OLD_PTRACE_SWITCH_MM
+#define OLD_PTRACE_SWITCH_MM 55
+#endif
 
 #include "sysdep/skas_ptrace.h"
 
 #endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
diff --git a/arch/um/include/sysdep-i386/ptrace_user.h b/arch/um/include/sysdep-i386/ptrace_user.h
index 7565072..9a4892d 100644
--- a/arch/um/include/sysdep-i386/ptrace_user.h
+++ b/arch/um/include/sysdep-i386/ptrace_user.h
@@ -43,6 +43,8 @@
 
 #define FP_SIZE ((HOST_XFP_SIZE > HOST_FP_SIZE) ? HOST_XFP_SIZE : HOST_FP_SIZE)
 
+#define FP_SIZE ((HOST_XFP_SIZE > HOST_FP_SIZE) ? HOST_XFP_SIZE : HOST_FP_SIZE)
+
 #ifndef FRAME_SIZE
 #define FRAME_SIZE (17)
 #endif
diff --git a/arch/um/include/sysdep-x86_64/ptrace_user.h b/arch/um/include/sysdep-x86_64/ptrace_user.h
index 45c0bd8..4e10c60 100644
--- a/arch/um/include/sysdep-x86_64/ptrace_user.h
+++ b/arch/um/include/sysdep-x86_64/ptrace_user.h
@@ -72,6 +72,8 @@
 
 #define FP_SIZE (HOST_FP_SIZE)
 
+#define FP_SIZE (HOST_FP_SIZE)
+
 #endif
 
 /*
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 47b57b4..6b6855a 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -192,7 +192,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 	}
 #endif
 #ifdef CONFIG_PROC_MM
-	case PTRACE_SWITCH_MM: {
+	case OLD_PTRACE_SWITCH_MM: {
 		struct mm_struct *old = child->mm;
 		struct mm_struct *new = proc_mm_get_mm(data);
 
@@ -292,3 +292,36 @@ void syscall_trace(struct uml_pt_regs *regs, int entryexit)
 		current->exit_code = 0;
 	}
 }
+
+int ptrace_to_pt_regs(struct pt_regs *to, struct user_regs __user *from)
+{
+	struct user_regs regs;
+	int rem;
+
+	rem = copy_from_user(&regs, from, sizeof(regs));
+	if (rem)
+		return -EFAULT;
+
+	memcpy(&to->regs.gp, &regs.regs, sizeof(to->regs.gp));
+
+	return put_fp_registers(userspace_pid[0],
+				(unsigned long *) &regs.fpregs);
+}
+
+int pt_regs_to_ptrace(struct user_regs __user *to, struct pt_regs *from)
+{
+	struct user_regs regs;
+	int err;
+
+	err = get_fp_registers(userspace_pid[0],
+			       (unsigned long *) &regs.fpregs);
+	if (err)
+		return err;
+
+	memcpy(&regs.regs, &from->regs.gp, sizeof(regs.regs));
+
+	if(copy_to_user(to, &regs, sizeof(regs)))
+		return -EFAULT;
+
+	return 0;
+}
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index 9cffc62..a9c2f6f 100644
--- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -148,3 +148,13 @@ int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 
 	return ret;
 }
+
+extern long do_switch_mm(int fd, long __user *save, long __user *new,
+			 unsigned long ip, unsigned long sp,
+			 struct pt_regs *regs);
+
+long sys_switch_mm(int fd, long __user *save, long __user *new,
+		   unsigned long ip, unsigned long sp)
+{
+	return do_switch_mm(fd, save, new, ip, sp, &current->thread.regs);
+}
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 1e8cba6..cbb7986 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -716,7 +716,7 @@ void __switch_mm(struct mm_id *mm_idp)
 
 	/* FIXME: need cpu pid in __switch_mm */
 	if (proc_mm) {
-		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+		err = ptrace(OLD_PTRACE_SWITCH_MM, userspace_pid[0], 0,
 			     mm_idp->u.mm_fd);
 		if (err) {
 			printk(UM_KERN_ERR "__switch_mm - PTRACE_SWITCH_MM "
diff --git a/arch/um/sys-x86_64/syscall_table.c b/arch/um/sys-x86_64/syscall_table.c
index c128eb8..8b5c216 100644
--- a/arch/um/sys-x86_64/syscall_table.c
+++ b/arch/um/sys-x86_64/syscall_table.c
@@ -39,6 +39,7 @@
 #define stub_rt_sigsuspend sys_rt_sigsuspend
 #define stub_sigaltstack sys_sigaltstack
 #define stub_rt_sigreturn sys_rt_sigreturn
+#define stub_switch_mm sys_switch_mm
 
 #define __SYSCALL(nr, sym) extern asmlinkage void sym(void) ;
 #undef _ASM_X86_64_UNISTD_H_
diff --git a/arch/x86/ia32/ia32entry.S b/arch/x86/ia32/ia32entry.S
index 8022d3c..8273782 100644
--- a/arch/x86/ia32/ia32entry.S
+++ b/arch/x86/ia32/ia32entry.S
@@ -373,6 +373,7 @@ quiet_ni_syscall:
 	PTREGSCALL stub32_vfork, sys_vfork, %rdi
 	PTREGSCALL stub32_iopl, sys_iopl, %rsi
 	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend, %rdx
+	PTREGSCALL stub32_switch_mm, sys_switch_mm, %r9
 
 ENTRY(ia32_ptregs_common)
 	popq %r11
@@ -727,4 +728,6 @@ ia32_sys_call_table:
 	.quad sys32_fallocate
 	.quad compat_sys_timerfd_settime	/* 325 */
 	.quad compat_sys_timerfd_gettime
+	.quad sys_new_mm
+	.quad stub32_switch_mm
 ia32_syscall_end:
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index c20c9e7..bb573ef 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -425,6 +425,7 @@ END(\label)
 	PTREGSCALL stub_rt_sigsuspend, sys_rt_sigsuspend, %rdx
 	PTREGSCALL stub_sigaltstack, sys_sigaltstack, %rdx
 	PTREGSCALL stub_iopl, sys_iopl, %rsi
+	PTREGSCALL stub_switch_mm, sys_switch_mm, %r9
 
 ENTRY(ptregscall_common)
 	popq %r11
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index eb92ccb..de84950 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -307,8 +307,7 @@ static int set_flags(struct task_struct *task, unsigned long value)
 	return 0;
 }
 
-static int putreg(struct task_struct *child,
-		  unsigned long offset, unsigned long value)
+int putreg(struct task_struct *child, unsigned long offset, unsigned long value)
 {
 	switch (offset) {
 	case offsetof(struct user_regs_struct, cs):
@@ -360,7 +359,7 @@ static int putreg(struct task_struct *child,
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *task, unsigned long offset)
+unsigned long getreg(struct task_struct *task, unsigned long offset)
 {
 	switch (offset) {
 	case offsetof(struct user_regs_struct, cs):
@@ -1036,7 +1035,7 @@ long arch_ptrace(struct task_struct *child, long request, long addr, long data)
 				       value);				\
 		break
 
-static int putreg32(struct task_struct *child, unsigned regno, u32 value)
+int putreg32(struct task_struct *child, unsigned regno, u32 value)
 {
 	struct pt_regs *regs = task_pt_regs(child);
 
@@ -1101,7 +1100,7 @@ static int putreg32(struct task_struct *child, unsigned regno, u32 value)
 				       offsetof(struct user_regs_struct, rs)); \
 		break
 
-static int getreg32(struct task_struct *child, unsigned regno, u32 *val)
+int getreg32(struct task_struct *child, unsigned regno, u32 *val)
 {
 	struct pt_regs *regs = task_pt_regs(child);
 
@@ -1254,6 +1253,7 @@ asmlinkage long sys32_ptrace(long request, u32 pid, u32 addr, u32 data)
 	case PTRACE_SETOPTIONS:
 	case PTRACE_SET_THREAD_AREA:
 	case PTRACE_GET_THREAD_AREA:
+	case PTRACE_SWITCH_MM:
 #ifdef X86_BTS
 	case PTRACE_BTS_CONFIG:
 	case PTRACE_BTS_STATUS:
@@ -1533,6 +1533,64 @@ out:
 	return 1;
 }
 
+int ptrace_to_pt_regs(struct pt_regs *regs, struct __user user_regs *ptrace)
+{
+	struct user_fxsr_struct *fp;
+	int i, err;
+
+	if (!access_ok(VERIFY_READ, ptrace, sizeof(*ptrace)))
+		return -EFAULT;
+
+	for (i = 0; i < FRAME_SIZE; i++) {
+		unsigned long n;
+
+		if (__get_user(n, &ptrace->regs[i]))
+			return -EFAULT;
+		err = putreg(current, i * 4, n);
+		if (err)
+			return err;
+	}
+
+	if (__get_user(fp, &ptrace->fp_state))
+		return -EFAULT;
+
+	if (fp == NULL) {
+		clear_used_math();
+		return 0;
+	}
+
+	set_used_math();
+
+	return xfpregs_set(current, NULL, 0, sizeof(*fp), NULL, fp);
+}
+
+int pt_regs_to_ptrace(struct __user user_regs *ptrace, struct pt_regs *regs)
+{
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, ptrace, sizeof(*ptrace)))
+		return -EFAULT;
+
+	for (i = 0; i < FRAME_SIZE; i++) {
+		unsigned long n = getreg(current, i * 4);
+		if (__put_user(n, &ptrace->regs[i]))
+			return -EFAULT;
+	}
+
+	if (!used_math()) {
+		if (__put_user(NULL, &ptrace->fp_state))
+			return -EFAULT;
+		return 0;
+	}
+
+	if (__put_user(&ptrace->fpregs, &ptrace->fp_state))
+		return -EFAULT;
+
+	clear_used_math();
+
+	return xfpregs_get(current, NULL, 0, sizeof(ptrace->fpregs), NULL,
+			  &ptrace->fpregs);
+}
 #else  /* CONFIG_X86_64 */
 
 static void syscall_trace(struct pt_regs *regs)
@@ -1593,4 +1651,115 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 		syscall_trace(regs);
 }
 
+int ptrace_to_pt_regs(struct pt_regs *regs, struct user_regs *ptrace)
+{
+	struct user_i387_struct *fp;
+	int i, err;
+
+#ifdef CONFIG_IA32_EMULATION
+	if (test_thread_flag(TIF_IA32)) {
+		for (i = 0; i < MAX_REG32_NR; i++) {
+			err = putreg32(current, i * 4, ptrace->u.regs32[i]);
+			if (err)
+				return err;
+		}
+
+		return 0;
+	}
+#endif
+	for (i = 0; i < MAX_REG_NR; i++){
+		if(i * 8 == offsetof(struct user_regs_struct, fs))
+			continue;
+
+		err = putreg(current, i * 8, ptrace->u.regs64.regs[i]);
+		if (err)
+			return err;
+	}
+
+	if (__get_user(fp, &ptrace->u.regs64.fp_state))
+		return -EFAULT;
+
+	if (fp == NULL) {
+		clear_used_math();
+		return 0;
+	}
+
+	set_used_math();
+
+	return xfpregs_set(current, NULL, 0, sizeof(*fp), NULL, fp);
+}
+
+extern int getreg32(struct task_struct *child, unsigned regno, u32 *val);
+
+int pt_regs_to_ptrace(struct __user user_regs *ptrace, struct pt_regs *regs)
+{
+	int i, err;
+
+#ifdef CONFIG_IA32_EMULATION
+	if (test_thread_flag(TIF_IA32)) {
+		if (!access_ok(VERIFY_WRITE, &ptrace->u.regs32,
+			       sizeof(&ptrace->u.regs32)))
+			return -EFAULT;
+
+		for (i = 0; i < ARRAY_SIZE(ptrace->u.regs32); i++) {
+			u32 n;
+
+			err = getreg32(current, i * 4, &n);
+			if (err)
+				return err;
+
+			err = __put_user(n, &ptrace->u.regs32[i]);
+			if (err)
+				return err;
+		}
+
+		return 0;
+	}
+#endif
+	if (!access_ok(VERIFY_WRITE, &ptrace->u.regs64,
+		       sizeof(ptrace->u.regs64)))
+		return -EFAULT;
+
+	for (i = 0; i < ARRAY_SIZE(ptrace->u.regs64.regs); i++) {
+		unsigned long n = getreg(current, i * 8);
+		err = __put_user(n, &ptrace->u.regs64.regs[i]);
+		if (err)
+			return err;
+	}
+
+	if (!used_math()) {
+		if (__put_user(NULL, &ptrace->u.regs64.fp_state))
+			return -EFAULT;
+		return 0;
+	}
+
+	if (__put_user(&ptrace->u.regs64.fpregs, &ptrace->u.regs64.fp_state))
+		return -EFAULT;
+
+	clear_used_math();
+
+	return xfpregs_get(current, NULL, 0, sizeof(ptrace->u.regs64.fpregs),
+			   NULL, &ptrace->u.regs64.fpregs);
+}
+
+#define RIP_INDEX (128 / sizeof(long))
+#define RSP_INDEX (152 / sizeof(long))
+
+unsigned long ptrace_ip(struct user_regs *regs)
+{
+#ifdef CONFIG_IA32_EMULATION
+	if (test_thread_flag(TIF_IA32))
+		return ptrace_ip32(regs->u.regs32);
+#endif
+	return regs->u.regs64.regs[RIP_INDEX];
+}
+
+unsigned long ptrace_sp(struct user_regs *regs)
+{
+#ifdef CONFIG_IA32_EMULATION
+	if (test_thread_flag(TIF_IA32))
+		return ptrace_sp32(regs->u.regs32);
+#endif
+	return regs->u.regs64.regs[RSP_INDEX];
+}
 #endif	/* CONFIG_X86_32 */
diff --git a/arch/x86/kernel/sys_i386_32.c b/arch/x86/kernel/sys_i386_32.c
index a86d26f..23f6aff 100644
--- a/arch/x86/kernel/sys_i386_32.c
+++ b/arch/x86/kernel/sys_i386_32.c
@@ -21,6 +21,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/user.h>
 
 /*
  * sys_pipe() is the normal C calling standard for creating
@@ -261,3 +262,14 @@ int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 	: "0" (__NR_execve),"ri" (filename),"c" (argv), "d" (envp) : "memory");
 	return __res;
 }
+
+extern long do_switch_mm(int fd, struct __user user_regs *save,
+			 struct __user user_regs *new, unsigned long ip,
+			 unsigned long sp, struct pt_regs *regs);
+
+asmlinkage long sys_switch_mm(struct pt_regs regs)
+{
+	return do_switch_mm(regs.bx, (struct __user user_regs *) regs.cx,
+			    (struct __user user_regs *) regs.dx, regs.si,
+			    regs.di, &regs);
+}
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index bd802a5..b3c98f5 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -251,3 +251,14 @@ asmlinkage long sys_uname(struct new_utsname __user * name)
 		err |= copy_to_user(&name->machine, "i686", 5); 		
 	return err ? -EFAULT : 0;
 }
+
+extern long do_switch_mm(int fd, struct __user user_regs *save,
+			 struct __user user_regs *new, unsigned long ip,
+			 unsigned long sp, struct pt_regs *regs);
+
+asmlinkage long sys_switch_mm(int fd, struct __user user_regs *save,
+			      struct __user user_regs *new, unsigned long ip,
+			      unsigned long sp, struct pt_regs *regs)
+{
+	return do_switch_mm(fd, save, new, ip, sp, regs);
+}
diff --git a/arch/x86/kernel/syscall_table_32.S b/arch/x86/kernel/syscall_table_32.S
index adff556..27f20f0 100644
--- a/arch/x86/kernel/syscall_table_32.S
+++ b/arch/x86/kernel/syscall_table_32.S
@@ -326,3 +326,5 @@ ENTRY(sys_call_table)
 	.long sys_fallocate
 	.long sys_timerfd_settime	/* 325 */
 	.long sys_timerfd_gettime
+	.long sys_new_mm
+	.long sys_switch_mm
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 81d7d14..082f349 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2279,6 +2279,37 @@ static int proc_pid_io_accounting(struct task_struct *task, char *buffer)
 }
 #endif
 
+static int proc_pid_mm_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *task = pid_task(proc_pid(inode), PIDTYPE_PID);
+	struct mm_struct *mm;
+
+	if (task == NULL)
+		return -ENOENT;
+
+	mm = get_task_mm(task);
+	if (mm == NULL)
+		return -EINVAL;
+
+	file->private_data = mm;
+	return 0;
+}
+
+static int proc_pid_mm_release(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = file->private_data;
+
+	if(mm != NULL)
+		mmput(mm);
+
+	return 0;
+}
+
+const struct file_operations proc_pid_mm_operations = {
+	.open		= proc_pid_mm_open,
+	.release	= proc_pid_mm_release,
+};
+
 /*
  * Thread groups
  */
@@ -2350,6 +2381,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	INF("io",	S_IRUGO, pid_io_accounting),
 #endif
+	REG("mm", S_IRUSR | S_IWUSR, pid_mm),
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
diff --git a/include/asm-um/ptrace-generic.h b/include/asm-um/ptrace-generic.h
index 6aefcd3..46f8a3f 100644
--- a/include/asm-um/ptrace-generic.h
+++ b/include/asm-um/ptrace-generic.h
@@ -34,6 +34,15 @@ struct pt_regs {
 
 #define instruction_pointer(regs) PT_REGS_IP(regs)
 
+struct user_regs {
+	unsigned long regs[MAX_REG_NR];
+	void *ptr;
+	unsigned long fpregs[FP_SIZE];
+};
+
+extern int ptrace_to_pt_regs(struct pt_regs *to, struct user_regs __user *from);
+extern int pt_regs_to_ptrace(struct user_regs __user *to, struct pt_regs *from);
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request, long addr,
diff --git a/include/asm-um/ptrace-i386.h b/include/asm-um/ptrace-i386.h
index b2d24c5..8c9c160 100644
--- a/include/asm-um/ptrace-i386.h
+++ b/include/asm-um/ptrace-i386.h
@@ -8,8 +8,11 @@
 
 #define HOST_AUDIT_ARCH AUDIT_ARCH_I386
 
-#include "linux/compiler.h"
-#include "asm/ptrace-generic.h"
+#include "user_constants.h"
+#define FP_SIZE ((HOST_XFP_SIZE > HOST_FP_SIZE) ? HOST_XFP_SIZE : HOST_FP_SIZE)
+
+#include <linux/compiler.h>
+#include <asm/ptrace-generic.h>
 #include <asm/user.h>
 #include "sysdep/ptrace.h"
 
@@ -40,6 +43,12 @@
 
 #define user_mode(r) UPT_IS_USER(&(r)->regs)
 
+#define pt_regs_ip(r) (r).regs.gp[EIP]
+#define pt_regs_sp(r) (r).regs.gp[UESP]
+
+#define ptrace_ip(r) (r)->regs[EIP]
+#define ptrace_sp(r) (r)->regs[UESP]
+
 /*
  * Forward declaration to avoid including sysdep/tls.h, which causes a
  * circular include, and compilation failures.
diff --git a/include/asm-um/ptrace-x86_64.h b/include/asm-um/ptrace-x86_64.h
index 4c47535..21345b5 100644
--- a/include/asm-um/ptrace-x86_64.h
+++ b/include/asm-um/ptrace-x86_64.h
@@ -7,6 +7,9 @@
 #ifndef __UM_PTRACE_X86_64_H
 #define __UM_PTRACE_X86_64_H
 
+#include "user_constants.h"
+#define FP_SIZE (HOST_FP_SIZE)
+
 #include "linux/compiler.h"
 #include "asm/errno.h"
 #include "asm/host_ldt.h"
@@ -62,6 +65,12 @@
 
 #define PT_FIX_EXEC_STACK(sp) do ; while(0)
 
+#define pt_regs_ip(r) (r).regs.gp[RIP / sizeof(long)]
+#define pt_regs_sp(r) (r).regs.gp[RSP / sizeof(long)]
+
+#define ptrace_ip(r) (r)->regs[RIP / sizeof(long)]
+#define ptrace_sp(r) (r)->regs[RSP / sizeof(long)]
+
 #define profile_pc(regs) PT_REGS_IP(regs)
 
 static inline int ptrace_get_thread_area(struct task_struct *child, int idx,
diff --git a/include/asm-x86/Kbuild b/include/asm-x86/Kbuild
index 3b8160a..45f5d02 100644
--- a/include/asm-x86/Kbuild
+++ b/include/asm-x86/Kbuild
@@ -21,5 +21,6 @@ unifdef-y += posix_types_64.h
 unifdef-y += ptrace.h
 unifdef-y += unistd_32.h
 unifdef-y += unistd_64.h
+unifdef-y += user.h
 unifdef-y += vm86.h
 unifdef-y += vsyscall.h
diff --git a/include/asm-x86/ptrace.h b/include/asm-x86/ptrace.h
index d9e04b4..046fb58 100644
--- a/include/asm-x86/ptrace.h
+++ b/include/asm-x86/ptrace.h
@@ -3,7 +3,7 @@
 
 #include <linux/compiler.h>	/* For __user */
 #include <asm/ptrace-abi.h>
-
+#include <asm/user.h>
 
 #ifndef __ASSEMBLY__
 
@@ -55,6 +55,24 @@ struct pt_regs {
 	int  ss;
 };
 
+#define pt_regs_ip(r) (r).ip
+#define pt_regs_sp(r) (r).sp
+
+struct user_regs {
+	unsigned long regs[FRAME_SIZE];
+	struct user_fxsr_struct *fp_state;
+	struct user_fxsr_struct fpregs;
+};
+
+#define ptrace_ip(r) (r)->regs.ip
+#define ptrace_sp(r) (r)->regs.sp
+
+struct pt_regs;
+extern int ptrace_to_pt_regs(struct pt_regs *regs,
+			     struct user_regs __user *ptrace);
+extern int pt_regs_to_ptrace(struct __user user_regs *ptrace,
+			     struct pt_regs *regs);
+
 #include <asm/vm86.h>
 #include <asm/segment.h>
 
@@ -227,6 +245,46 @@ extern int do_get_thread_area(struct task_struct *p, int idx,
 extern int do_set_thread_area(struct task_struct *p, int idx,
 			      struct user_desc __user *info, int can_allocate);
 
+#ifdef CONFIG_X86_64
+#ifdef CONFIG_IA32_EMULATION
+#define MAX_REG32_NR 17
+
+#define EIP 12
+#define UESP 15
+
+#define ptrace_ip32(regs) (unsigned long) (regs)[EIP]
+#define ptrace_sp32(regs) (unsigned long) (regs)[UESP]
+
+#endif
+
+#define MAX_REG_NR (sizeof(struct user_regs_struct) / sizeof(long))
+
+struct user_regs {
+	union {
+		struct  {
+			unsigned long regs[MAX_REG_NR];
+			struct user_i387_struct *fp_state;
+			struct user_i387_struct fpregs;
+		} regs64;
+#ifdef CONFIG_IA32_EMULATION
+		u32 regs32[MAX_REG32_NR];
+#endif
+	} u;
+};
+
+#define pt_regs_ip(regs) (regs).ip
+#define pt_regs_sp(regs) (regs).sp
+
+extern unsigned long ptrace_ip(struct user_regs *regs);
+extern unsigned long ptrace_sp(struct user_regs *regs);
+
+extern int ptrace_to_pt_regs(struct pt_regs *regs,
+			     struct user_regs __user *ptrace);
+extern int pt_regs_to_ptrace(struct __user user_regs *ptrace,
+			     struct pt_regs *regs);
+#else
+#endif
+
 #endif /* __KERNEL__ */
 
 #endif /* !__ASSEMBLY__ */
diff --git a/include/asm-x86/unistd_32.h b/include/asm-x86/unistd_32.h
index 984123a..5f8f291 100644
--- a/include/asm-x86/unistd_32.h
+++ b/include/asm-x86/unistd_32.h
@@ -332,6 +332,8 @@
 #define __NR_fallocate		324
 #define __NR_timerfd_settime	325
 #define __NR_timerfd_gettime	326
+#define __NR_new_mm		327
+#define __NR_switch_mm		328
 
 #ifdef __KERNEL__
 
diff --git a/include/asm-x86/unistd_64.h b/include/asm-x86/unistd_64.h
index 3883ceb..a674098 100644
--- a/include/asm-x86/unistd_64.h
+++ b/include/asm-x86/unistd_64.h
@@ -639,6 +639,10 @@ __SYSCALL(__NR_fallocate, sys_fallocate)
 __SYSCALL(__NR_timerfd_settime, sys_timerfd_settime)
 #define __NR_timerfd_gettime			287
 __SYSCALL(__NR_timerfd_gettime, sys_timerfd_gettime)
+#define __NR_new_mm				288
+__SYSCALL(__NR_new_mm, sys_new_mm)
+#define __NR_switch_mm				289
+__SYSCALL(__NR_switch_mm, stub_switch_mm)
 
 
 #ifndef __NO_STUBS
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index ebe0c17..a8ef98a 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -21,6 +21,8 @@
 
 #define PTRACE_SYSCALL		  24
 
+#define PTRACE_SWITCH_MM	  34
+
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
 #define PTRACE_GETEVENTMSG	0x4201
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 6a1e7af..7360fde 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1750,6 +1750,7 @@ static inline int sas_ss_flags(unsigned long sp)
  * Routines for handling mm_structs
  */
 extern struct mm_struct * mm_alloc(void);
+extern struct mm_struct *dup_mm(struct task_struct *tsk);
 
 /* mmdrop drops the mm and the page tables */
 extern void __mmdrop(struct mm_struct *);
diff --git a/kernel/fork.c b/kernel/fork.c
index 9c042f9..4ca580a 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -498,7 +498,7 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
  * Allocate a new mm structure and copy contents from the
  * mm structure of the passed in task structure.
  */
-static struct mm_struct *dup_mm(struct task_struct *tsk)
+struct mm_struct *dup_mm(struct task_struct *tsk)
 {
 	struct mm_struct *mm, *oldmm = current->mm;
 	int err;
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index fdb34e8..2200f84 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -420,6 +420,8 @@ static int ptrace_resume(struct task_struct *child, long request, long data)
 	return 0;
 }
 
+extern int do_switch(struct task_struct *task, int fd);
+
 int ptrace_request(struct task_struct *child, long request,
 		   long addr, long data)
 {
@@ -471,6 +473,10 @@ int ptrace_request(struct task_struct *child, long request,
 			return 0;
 		return ptrace_resume(child, request, SIGKILL);
 
+	case PTRACE_SWITCH_MM:
+		ret = do_switch(child, data);
+		break;
+
 	default:
 		break;
 	}
diff --git a/mm/Makefile b/mm/Makefile
index a5b0dd9..123ca7d 100644
--- a/mm/Makefile
+++ b/mm/Makefile
@@ -4,8 +4,8 @@
 
 mmu-y			:= nommu.o
 mmu-$(CONFIG_MMU)	:= fremap.o highmem.o madvise.o memory.o mincore.o \
-			   mlock.o mmap.o mprotect.o mremap.o msync.o rmap.o \
-			   vmalloc.o
+			   mlock.o mmap.o mmfs.o mprotect.o mremap.o msync.o \
+			   rmap.o vmalloc.o
 
 obj-y			:= bootmem.o filemap.o mempool.o oom_kill.o fadvise.o \
 			   page_alloc.o page-writeback.o pdflush.o \
diff --git a/mm/mmfs.c b/mm/mmfs.c
new file mode 100644
index 0000000..247f7a3
--- /dev/null
+++ b/mm/mmfs.c
@@ -0,0 +1,215 @@
+#define __FRAME_OFFSETS
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/sched.h>
+#include <asm/mmu_context.h>
+#include <asm/ptrace.h>
+#include <asm/uaccess.h>
+#include <asm/user.h>
+
+static int release_mm(struct inode *inode, struct file *file)
+{
+	struct mm_struct *mm = file->private_data;
+
+	mmput(mm);
+	return 0;
+}
+
+#define MM_MAGIC 0xE0AAC500
+
+static int mm_get_sb(struct file_system_type *fs_type,
+		     int flags, const char *dev_name, void *data,
+		     struct vfsmount *mnt)
+{
+	return get_sb_pseudo(fs_type, "mm:", NULL, MM_MAGIC, mnt);
+}
+
+static struct vfsmount *mm_mnt;
+
+static struct file_system_type mm_fs_type = {
+	.name		= "mm",
+	.get_sb		= mm_get_sb,
+	.kill_sb	= kill_anon_super,
+};
+
+static int __init init_mm_fs(void)
+{
+	int err;
+
+	err = register_filesystem(&mm_fs_type);
+	if (err)
+		return err;
+
+	mm_mnt = kern_mount(&mm_fs_type);
+	if (IS_ERR(mm_mnt)) {
+		err = PTR_ERR(mm_mnt);
+		unregister_filesystem(&mm_fs_type);
+	}
+
+	return err;
+}
+
+static void __exit exit_mm_fs(void)
+{
+	unregister_filesystem(&mm_fs_type);
+	mntput(mm_mnt);
+}
+
+fs_initcall(init_mm_fs);
+module_exit(exit_mm_fs);
+
+static int mm_delete_dentry(struct dentry *dentry)
+{
+	/*
+	 * At creation time, we pretended this dentry was hashed
+	 * (by clearing DCACHE_UNHASHED bit in d_flags)
+	 * At delete time, we restore the truth : not hashed.
+	 * (so that dput() can proceed correctly)
+	 */
+	dentry->d_flags |= DCACHE_UNHASHED;
+	return 0;
+}
+
+/*
+ * pipefs_dname() is called from d_path().
+ */
+static char *mm_dname(struct dentry *dentry, char *buffer, int buflen)
+{
+	return dynamic_dname(dentry, buffer, buflen, "mm:[%lu]",
+			     dentry->d_inode->i_ino);
+}
+
+static struct dentry_operations mm_dentry_operations = {
+	.d_delete	= mm_delete_dentry,
+	.d_dname	= mm_dname,
+};
+
+static struct file_operations mm_fops = {
+	.release	= release_mm,
+};
+
+asmlinkage long sys_new_mm(void)
+{
+	struct file *file;
+	struct mm_struct *mm;
+	struct inode *inode;
+	struct dentry *dentry;
+	struct qstr name = { .name = "" };
+	int err, fd;
+
+	mm = dup_mm(current);
+	if (mm == NULL)
+		return -ENOMEM;
+
+	fd = get_unused_fd();
+	if (fd < 0) {
+		err = fd;
+		goto out_free;
+	}
+
+	err = -ENOMEM;
+	dentry = d_alloc(mm_mnt->mnt_sb->s_root, &name);
+	if (dentry == NULL)
+		goto out_put;
+
+	dentry->d_op = &mm_dentry_operations;
+	dentry->d_flags &= ~DCACHE_UNHASHED;
+
+	inode = new_inode(mm_mnt->mnt_sb);
+	if (inode == NULL)
+		goto out_dput;
+
+	inode->i_mode = S_IRUSR;
+	inode->i_uid = current->fsuid;
+	inode->i_gid = current->fsgid;
+	inode->i_atime = inode->i_mtime = inode->i_ctime = CURRENT_TIME;
+
+	d_instantiate(dentry, inode);
+
+	file = alloc_file(mm_mnt, dentry, FMODE_READ, &mm_fops);
+	if (file == NULL)
+		goto out_dput;
+
+	file->f_flags = O_RDONLY;
+	file->private_data = mm;
+
+	fd_install(fd, file);
+
+	return fd;
+
+ out_dput:
+	dput(dentry);
+ out_put:
+	put_unused_fd(fd);
+ out_free:
+	mmput(mm);
+	return err;
+}
+
+void do_switch_mm_struct(struct task_struct *task, struct mm_struct *new)
+{
+	struct mm_struct *old = task->mm;
+
+	task_lock(task);
+
+	atomic_inc(&new->mm_users);
+	task->mm = new;
+	task->active_mm = new;
+
+	if (task == current)
+		switch_mm(old, task->mm, task);
+
+	task_unlock(task);
+
+	mmput(old);
+}
+
+extern const struct file_operations proc_pid_mm_operations;
+
+int do_switch(struct task_struct *task, int fd)
+{
+	struct file *file = fget(fd);
+	int err;
+
+	if (!file)
+		return -EBADF;
+
+	err = -EINVAL;
+	if ((file->f_op != &mm_fops) && (file->f_op != &proc_pid_mm_operations))
+		goto out;
+
+	do_switch_mm_struct(task, file->private_data);
+
+	err = 0;
+
+ out:
+	fput(file);
+	return err;
+}
+
+long do_switch_mm(int fd, struct __user user_regs *save,
+		  struct __user user_regs *new, unsigned long ip,
+		  unsigned long sp, struct pt_regs *regs)
+{
+	int ret;
+
+	if (current->mm == NULL)
+		return -EINVAL;
+
+	if ((save != NULL) && pt_regs_to_ptrace(save, regs))
+		return -EFAULT;
+
+	ret = do_switch(current, fd);
+	if (ret)
+		return ret;
+
+	if (new != NULL)
+		ret = ptrace_to_pt_regs(regs, new);
+	else {
+		pt_regs_ip(*regs) = ip;
+		pt_regs_sp(*regs) = sp;
+	}
+
+	return ret;
+}

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
