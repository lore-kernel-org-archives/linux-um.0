Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JEWz1-0000ec-73 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 13:36:39 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JEWyy-00087n-PC
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 14 Jan 2008 13:36:38 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m0ELaY3c021938
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jan 2008 16:36:34 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m0ELaY1Q002618
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 14 Jan 2008 16:36:34 -0500
Date: Mon, 14 Jan 2008 16:36:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080114213634.GA2506@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 7/10] SKAS4 - Host get_mm and switch_mm
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
To: UML-user <user-mode-linux-devel@lists.sourceforge.net>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

    This is the new_mm, switch_mm, and /proc/<pid>/mm implementation for
    32- and 64-bit x86 and UML, plus 32-bit support on 64-bit x86.

diff --git a/arch/um/include/skas_ptrace.h b/arch/um/include/skas_ptrace.h
index cd2327d..6b55c52 100644
--- a/arch/um/include/skas_ptrace.h
+++ b/arch/um/include/skas_ptrace.h
@@ -7,7 +7,9 @@
 #define __SKAS_PTRACE_H
 
 #define PTRACE_FAULTINFO 52
-#define PTRACE_SWITCH_MM 55
+#ifndef OLD_PTRACE_SWITCH_MM
+#define OLD_PTRACE_SWITCH_MM 55
+#endif
 
 #include "sysdep/skas_ptrace.h"
 
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 47b57b4..36f8ae5 100644
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
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 82a0780..522d0f1 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -627,7 +627,7 @@ void __switch_mm(struct mm_id *mm_idp)
 
 	/* FIXME: need cpu pid in __switch_mm */
 	if (proc_mm) {
-		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+		err = ptrace(OLD_PTRACE_SWITCH_MM, userspace_pid[0], 0,
 			     mm_idp->u.mm_fd);
 		if (err)
 			panic("__switch_mm - PTRACE_SWITCH_MM failed, "
diff --git a/arch/um/sys-i386/syscalls.c b/arch/um/sys-i386/syscalls.c
index e2d1426..85621a2 100644
--- a/arch/um/sys-i386/syscalls.c
+++ b/arch/um/sys-i386/syscalls.c
@@ -200,3 +200,11 @@ long sys_sigaction(int sig, const struct old_sigaction __user *act,
 
 	return ret;
 }
+
+extern long do_switch_mm(int fd, int flags, long __user *new,
+			 long __user *save, struct pt_regs *regs);
+
+long sys_switch_mm(int fd, int flags, long __user *new, long __user *save)
+{
+	return do_switch_mm(fd, flags, new, save, &current->thread.regs);
+}
diff --git a/arch/um/sys-x86_64/syscalls.c b/arch/um/sys-x86_64/syscalls.c
index 86f6b18..ff012ba 100644
--- a/arch/um/sys-x86_64/syscalls.c
+++ b/arch/um/sys-x86_64/syscalls.c
@@ -112,3 +112,11 @@ void arch_switch_to(struct task_struct *from, struct task_struct *to)
 
 	arch_prctl(to, ARCH_SET_FS, (void __user *) to->thread.arch.fs);
 }
+
+extern long do_switch_mm(int fd, int flags, long __user *new,
+			 long __user *save, struct pt_regs *regs);
+
+long stub_switch_mm(int fd, int flags, long __user *new, long __user *save)
+{
+	return do_switch_mm(fd, flags, new, save, &current->thread.regs);
+}
diff --git a/arch/x86/ia32/ia32entry.S b/arch/x86/ia32/ia32entry.S
index df588f0..1992458 100644
--- a/arch/x86/ia32/ia32entry.S
+++ b/arch/x86/ia32/ia32entry.S
@@ -374,6 +374,7 @@ quiet_ni_syscall:
 	PTREGSCALL stub32_vfork, sys_vfork, %rdi
 	PTREGSCALL stub32_iopl, sys_iopl, %rsi
 	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend, %rdx
+	PTREGSCALL stub32_switch_mm, sys_switch_mm, %r8
 
 ENTRY(ia32_ptregs_common)
 	popq %r11
@@ -726,4 +727,6 @@ ia32_sys_call_table:
 	.quad compat_sys_timerfd
 	.quad sys_eventfd
 	.quad sys32_fallocate
+ 	.quad sys_new_mm		/* 325 */
+	.quad stub32_switch_mm
 ia32_syscall_end:
diff --git a/arch/x86/ia32/ptrace32.c b/arch/x86/ia32/ptrace32.c
index 4a233ad..5c0caa4 100644
--- a/arch/x86/ia32/ptrace32.c
+++ b/arch/x86/ia32/ptrace32.c
@@ -38,7 +38,7 @@
 #define R32(l,q) \
 	case offsetof(struct user32, regs.l): stack[offsetof(struct pt_regs, q)/8] = val; break
 
-static int putreg32(struct task_struct *child, unsigned regno, u32 val)
+int putreg32(struct task_struct *child, unsigned regno, u32 val)
 {
 	int i;
 	__u64 *stack = (__u64 *)task_pt_regs(child);
@@ -139,7 +139,7 @@ static int putreg32(struct task_struct *child, unsigned regno, u32 val)
 #define R32(l,q) \
 	case offsetof(struct user32, regs.l): *val = stack[offsetof(struct pt_regs, q)/8]; break
 
-static int getreg32(struct task_struct *child, unsigned regno, u32 *val)
+int getreg32(struct task_struct *child, unsigned regno, u32 *val)
 {
 	__u64 *stack = (__u64 *)task_pt_regs(child);
 
@@ -248,6 +248,7 @@ asmlinkage long sys32_ptrace(long request, u32 pid, u32 addr, u32 data)
 	case PTRACE_SETOPTIONS:
 	case PTRACE_SET_THREAD_AREA:
 	case PTRACE_GET_THREAD_AREA:
+	case PTRACE_SWITCH_MM:
 		return sys_ptrace(request, pid, addr, data); 
 
 	default:
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index 3a058bb..b130f88 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -412,6 +412,7 @@ END(\label)
 	PTREGSCALL stub_rt_sigsuspend, sys_rt_sigsuspend, %rdx
 	PTREGSCALL stub_sigaltstack, sys_sigaltstack, %rdx
 	PTREGSCALL stub_iopl, sys_iopl, %rsi
+	PTREGSCALL stub_switch_mm, sys_switch_mm, %r8
 
 ENTRY(ptregscall_common)
 	popq %r11
diff --git a/arch/x86/kernel/ptrace_32.c b/arch/x86/kernel/ptrace_32.c
index ff5431c..c3bd8cd 100644
--- a/arch/x86/kernel/ptrace_32.c
+++ b/arch/x86/kernel/ptrace_32.c
@@ -83,8 +83,8 @@ static inline int put_stack_long(struct task_struct *task, int offset,
 	return 0;
 }
 
-static int putreg(struct task_struct *child,
-	unsigned long regno, unsigned long value)
+int putreg(struct task_struct *child,
+	   unsigned long regno, unsigned long value)
 {
 	switch (regno >> 2) {
 		case GS:
@@ -116,7 +116,7 @@ static int putreg(struct task_struct *child,
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *child,
+unsigned long getreg(struct task_struct *child,
 	unsigned long regno)
 {
 	unsigned long retval = ~0UL;
diff --git a/arch/x86/kernel/ptrace_64.c b/arch/x86/kernel/ptrace_64.c
index 607085f..a568429 100644
--- a/arch/x86/kernel/ptrace_64.c
+++ b/arch/x86/kernel/ptrace_64.c
@@ -226,7 +226,7 @@ void ptrace_disable(struct task_struct *child)
 	clear_singlestep(child);
 }
 
-static int putreg(struct task_struct *child,
+int putreg(struct task_struct *child,
 	unsigned long regno, unsigned long value)
 {
 	unsigned long tmp; 
@@ -283,7 +283,7 @@ static int putreg(struct task_struct *child,
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *child, unsigned long regno)
+unsigned long getreg(struct task_struct *child, unsigned long regno)
 {
 	unsigned long val;
 	switch (regno) {
diff --git a/arch/x86/kernel/sys_i386_32.c b/arch/x86/kernel/sys_i386_32.c
index a86d26f..7b9d43b 100644
--- a/arch/x86/kernel/sys_i386_32.c
+++ b/arch/x86/kernel/sys_i386_32.c
@@ -261,3 +261,12 @@ int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 	: "0" (__NR_execve),"ri" (filename),"c" (argv), "d" (envp) : "memory");
 	return __res;
 }
+
+extern long do_switch_mm(int fd, int flags, long __user *new, long __user *save,
+			 struct pt_regs *regs);
+
+asmlinkage long sys_switch_mm(struct pt_regs regs)
+{
+	return do_switch_mm(regs.ebx, regs.ecx, (long __user *) regs.edx,
+			    (long __user *) regs.esi, &regs);
+}
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 907942e..ddc1c98 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -153,3 +153,12 @@ asmlinkage long sys_uname(struct new_utsname __user * name)
 		err |= copy_to_user(&name->machine, "i686", 5); 		
 	return err ? -EFAULT : 0;
 }
+
+extern long do_switch_mm(int fd, int flags, long __user *new,
+			 long __user *save, struct pt_regs *regs);
+
+asmlinkage long sys_switch_mm(int fd, int flags, long __user *new,
+			      long __user *save, struct pt_regs *regs)
+{
+	return do_switch_mm(fd, flags, new, save, regs);
+}
diff --git a/arch/x86/kernel/syscall_table_32.S b/arch/x86/kernel/syscall_table_32.S
index 8344c70..3346997 100644
--- a/arch/x86/kernel/syscall_table_32.S
+++ b/arch/x86/kernel/syscall_table_32.S
@@ -324,3 +324,5 @@ ENTRY(sys_call_table)
 	.long sys_timerfd
 	.long sys_eventfd
 	.long sys_fallocate
+	.long sys_new_mm
+	.long sys_switch_mm
diff --git a/fs/proc/base.c b/fs/proc/base.c
index 7411bfb..6dd8e34 100644
--- a/fs/proc/base.c
+++ b/fs/proc/base.c
@@ -2187,6 +2187,34 @@ static int proc_pid_io_accounting(struct task_struct *task, char *buffer)
 }
 #endif
 
+static int proc_pid_mm_open(struct inode *inode, struct file *file)
+{
+	struct task_struct *task = pid_task(proc_pid(inode), PIDTYPE_PID);
+
+	if (task == NULL)
+		return -ENOENT;
+
+	if(task->mm != NULL)
+		atomic_inc(&task->mm->mm_users);
+	file->private_data = task->mm;
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
@@ -2250,6 +2278,7 @@ static const struct pid_entry tgid_base_stuff[] = {
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	INF("io",	S_IRUGO, pid_io_accounting),
 #endif
+	REG("mm", S_IRUSR | S_IWUSR, pid_mm),
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
diff --git a/include/asm-x86/unistd_32.h b/include/asm-x86/unistd_32.h
index 9b15545..3477555 100644
--- a/include/asm-x86/unistd_32.h
+++ b/include/asm-x86/unistd_32.h
@@ -330,10 +330,12 @@
 #define __NR_timerfd		322
 #define __NR_eventfd		323
 #define __NR_fallocate		324
+#define __NR_new_mm		325
+#define __NR_switch_mm		326
 
 #ifdef __KERNEL__
 
-#define NR_syscalls 325
+#define NR_syscalls 327
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
diff --git a/include/asm-x86/unistd_64.h b/include/asm-x86/unistd_64.h
index 5ff4d3e..baf4c0c 100644
--- a/include/asm-x86/unistd_64.h
+++ b/include/asm-x86/unistd_64.h
@@ -635,6 +635,10 @@ __SYSCALL(__NR_timerfd, sys_timerfd)
 __SYSCALL(__NR_eventfd, sys_eventfd)
 #define __NR_fallocate				285
 __SYSCALL(__NR_fallocate, sys_fallocate)
+#define __NR_new_mm				286
+__SYSCALL(__NR_new_mm, sys_new_mm)
+#define __NR_switch_mm				287
+__SYSCALL(__NR_switch_mm, stub_switch_mm)
 
 #ifndef __NO_STUBS
 #define __ARCH_WANT_OLD_READDIR
diff --git a/include/linux/ptrace.h b/include/linux/ptrace.h
index 3ea5750..6758e86 100644
--- a/include/linux/ptrace.h
+++ b/include/linux/ptrace.h
@@ -21,6 +21,8 @@
 
 #define PTRACE_SYSCALL		  24
 
+#define PTRACE_SWITCH_MM	  33
+
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
 #define PTRACE_GETEVENTMSG	0x4201
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ac3d496..7707a43 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1665,6 +1665,7 @@ static inline int sas_ss_flags(unsigned long sp)
  * Routines for handling mm_structs
  */
 extern struct mm_struct * mm_alloc(void);
+extern struct mm_struct *dup_mm(struct task_struct *tsk);
 
 /* mmdrop drops the mm and the page tables */
 extern void FASTCALL(__mmdrop(struct mm_struct *));
diff --git a/kernel/Makefile b/kernel/Makefile
index dfa9695..ecaf05e 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -3,7 +3,7 @@
 #
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
-	    exit.o itimer.o time.o softirq.o resource.o \
+	    exit.o itimer.o time.o softirq.o resource.o mmfs.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o user_namespace.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
diff --git a/kernel/fork.c b/kernel/fork.c
index 8dd8ff2..bd9afde 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -491,7 +491,7 @@ void mm_release(struct task_struct *tsk, struct mm_struct *mm)
  * Allocate a new mm structure and copy contents from the
  * mm structure of the passed in task structure.
  */
-static struct mm_struct *dup_mm(struct task_struct *tsk)
+struct mm_struct *dup_mm(struct task_struct *tsk)
 {
 	struct mm_struct *mm, *oldmm = current->mm;
 	int err;
diff --git a/kernel/mmfs.c b/kernel/mmfs.c
new file mode 100644
index 0000000..6111c73
--- /dev/null
+++ b/kernel/mmfs.c
@@ -0,0 +1,446 @@
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
+#define MM_FLAGS_MASK 1
+#define MM_INIT_MASK 1
+
+#define MM_COPY 0
+#define MM_EMPTY 1
+
+asmlinkage long sys_new_mm(int flags)
+{
+	struct file *file;
+	struct mm_struct *mm;
+	struct inode *inode;
+	struct dentry *dentry;
+	struct qstr name = { .name = "" };
+	int err, fd;
+
+	if ((flags & ~MM_FLAGS_MASK) != 0)
+		return -EINVAL;
+
+	if ((flags & MM_INIT_MASK) == MM_COPY) {
+		mm = dup_mm(current);
+		if (mm == NULL)
+			return -ENOMEM;
+	}
+	else
+		return -EINVAL;
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
+extern const struct file_operations proc_pid_mm_operations;
+
+struct mm_struct *fd_to_mm(int fd)
+{
+	struct mm_struct *mm;
+	struct file *file = fget(fd);
+
+	if (!file)
+		return ERR_PTR(-EBADF);
+
+	if ((file->f_op != &mm_fops) &&
+	    (file->f_op != &proc_pid_mm_operations))
+		mm = ERR_PTR(-EINVAL);
+	else mm = file->private_data;
+
+	fput(file);
+
+	return mm;
+}
+
+static void do_switch(struct mm_struct *mm)
+{
+	struct mm_struct *old = current->mm;
+
+	task_lock(current);
+
+	atomic_inc(&mm->mm_users);
+	current->mm = mm;
+	current->active_mm = mm;
+
+	switch_mm(old, current->mm, current);
+
+	task_unlock(current);
+
+	mmput(old);
+}
+
+#define MM_SWITCH_MASK 3
+#define MM_REGS_MASK 3
+
+#define MM_ALL_REGS 0
+#define MM_SP_IP 1
+#define MM_SAME 2
+
+#ifdef CONFIG_UML
+
+#define ptrace_to_pt_regs(ptregs, regs) \
+	(memcpy(ptregs, regs, MAX_REG_NR * sizeof(long)), 0)
+#define pt_regs_to_ptrace(regs, ptregs) \
+	copy_to_user(regs, ptregs, MAX_REG_NR * sizeof(long))
+
+#ifdef CONFIG_X86_32
+#define pt_regs_ip(r) (r).regs.gp[EIP]
+#define pt_regs_sp(r) (r).regs.gp[UESP]
+
+#define ptrace_ip(r) (r)[EIP]
+#define ptrace_sp(r) (r)[UESP]
+
+#else
+#define pt_regs_ip(r) (r).regs.gp[RIP / sizeof(long)]
+#define pt_regs_sp(r) (r).regs.gp[RSP / sizeof(long)]
+
+#define ptrace_ip(r) (r)[RIP / sizeof(long)]
+#define ptrace_sp(r) (r)[RSP / sizeof(long)]
+#endif
+
+#else
+#ifdef CONFIG_X86_32
+#define pt_regs_ip(r) (r).eip
+#define pt_regs_sp(r) (r).esp
+
+#define ptrace_ip(r) (r)[EIP]
+#define ptrace_sp(r) (r)[UESP]
+
+#define MAX_REG_NR FRAME_SIZE
+
+extern int putreg(struct task_struct *child, unsigned long regno,
+		  unsigned long value);
+
+static inline int ptrace_to_pt_regs(struct pt_regs *regs,
+				    unsigned long *ptrace)
+{
+	int i, err;
+
+	for (i = 0; i < MAX_REG_NR; i++){
+		err = putreg(current, i * 4, ptrace[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+extern unsigned long getreg(struct task_struct *child,
+			    unsigned long regno);
+
+static inline int pt_regs_to_ptrace(unsigned long __user *ptrace,
+				    struct pt_regs *regs)
+{
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, ptrace, MAX_REG_NR * sizeof(long)))
+		return -EFAULT;
+
+	for (i = 0; i < MAX_REG_NR; i++){
+		unsigned long n = getreg(current, i * 4), err;
+		err = put_user(n, &ptrace[i]);
+	}
+
+	return 0;
+}
+
+#else
+#ifdef CONFIG_X86_64
+#define pt_regs_ip(r) (r).rip
+#define pt_regs_sp(r) (r).rsp
+
+#define ptrace_ip(regs) (regs)[RIP / sizeof(long)]
+#define ptrace_sp(regs) (regs)[RSP / sizeof(long)]
+
+#define MAX_REG_NR (sizeof(struct user_regs_struct) / sizeof(long))
+
+extern int putreg(struct task_struct *child, unsigned long regno,
+		  unsigned long value);
+
+#ifdef CONFIG_IA32_EMULATION
+#define MAX_REG32_NR 17
+
+#define EIP 12
+#define UESP 15
+
+#define ptrace_ip32(regs) (unsigned long) (regs)[EIP]
+#define ptrace_sp32(regs) (unsigned long) (regs)[UESP]
+
+extern int putreg32(struct task_struct *child, unsigned long regno,
+		    unsigned long value);
+extern int getreg32(struct task_struct *child, unsigned regno, u32 *val);
+#endif
+
+static inline int ptrace_to_pt_regs(struct pt_regs *regs,
+				    unsigned long *ptrace)
+{
+	int i, err;
+
+#ifdef CONFIG_IA32_EMULATION
+	if (test_thread_flag(TIF_IA32)) {
+		u32 *ptrace32 = (u32 *) ptrace;
+
+		for (i = 0; i < MAX_REG32_NR; i++){
+			err = putreg32(current, i * 4, ptrace32[i]);
+			if (err)
+				return err;
+		}
+
+		return 0;
+	}
+#endif
+	for (i = 0; i < MAX_REG_NR; i++){
+		err = putreg(current, i * 8, ptrace[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+extern unsigned long getreg(struct task_struct *child,
+			    unsigned long regno);
+
+static inline int pt_regs_to_ptrace(unsigned long __user *ptrace,
+				    struct pt_regs *regs)
+{
+	int i, err;
+
+#ifdef CONFIG_IA32_EMULATION
+	if (test_thread_flag(TIF_IA32)) {
+		u32 __user *ptrace32 = (u32 __user *) ptrace;
+		u32 tmp[MAX_REG32_NR];
+
+		for (i = 0; i < MAX_REG32_NR; i++){
+			err = getreg32(current, i * 4, &tmp[i]);
+			if (err)
+				return err;
+		}
+		if (copy_to_user(ptrace32, tmp, sizeof(tmp)))
+			return -EFAULT;
+
+		return 0;
+	}
+#endif
+	if (!access_ok(VERIFY_WRITE, ptrace, MAX_REG_NR * 8))
+		return -EFAULT;
+
+	for (i = 0; i < MAX_REG_NR; i++){
+		unsigned long n = getreg(current, i * 8);
+		err = put_user(n, &ptrace[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+#endif
+#endif
+#endif
+
+long do_switch_mm(int fd, unsigned long flags, long __user *new,
+		  long __user *save, struct pt_regs *regs)
+{
+	unsigned long new_regs[MAX_REG_NR];
+#ifdef CONFIG_IA32_EMULATION
+	u32 new_regs32[MAX_REG32_NR];
+#endif
+	struct mm_struct *old_mm, *new_mm;
+	int regs_init, ret = 0;
+
+	if ((flags & ~MM_SWITCH_MASK) != 0)
+		return -EINVAL;
+
+	regs_init = flags & MM_SWITCH_MASK;
+	if (regs_init > MM_SAME)
+		return -EINVAL;
+
+	old_mm = current->mm;
+	if (old_mm == NULL)
+		return -EINVAL;
+
+	if ((new == NULL) && (regs_init != MM_SAME))
+		return -EINVAL;
+#ifdef CONFIG_IA32_EMULATION
+	else if (test_thread_flag(TIF_IA32)) {
+		if (copy_from_user(new_regs32, new, sizeof(new_regs32)))
+			return -EFAULT;
+	}
+#endif
+	else if (copy_from_user(new_regs, new, sizeof(new_regs)))
+		return -EFAULT;
+
+	/*
+	 * XXX nothing is guaranteeing that new won't disappear out from
+	 * under us - i.e. fd gets closed, file freed, and mm destroyed
+	 */
+	new_mm = fd_to_mm(fd);
+	if (IS_ERR(new_mm))
+		return PTR_ERR(new_mm);
+
+	/*
+	 * XXX need to hold a reference on old_mm in case we need to switch
+	 * back when pt_regs_to_ptrace fails or we race with another
+	 * switch_mm
+	 */
+	do_switch(new_mm);
+
+	if ((save != NULL) && pt_regs_to_ptrace(save, regs)) {
+		do_switch(old_mm);
+		return -EFAULT;
+	}
+
+#ifdef CONFIG_IA32_EMULATION
+	if ((regs_init == MM_SP_IP) && (test_thread_flag(TIF_IA32))) {
+		pt_regs_ip(*regs) = ptrace_ip32(new_regs32);
+		pt_regs_sp(*regs) = ptrace_sp32(new_regs32);
+	}
+	else
+#endif
+	if (regs_init == MM_SP_IP) {
+		pt_regs_ip(*regs) = ptrace_ip(new_regs);
+		pt_regs_sp(*regs) = ptrace_sp(new_regs);
+	}
+	else if (regs_init == MM_SAME)
+		ret = 1;
+	else {
+#ifdef CONFIG_IA32_EMULATION
+		if (test_thread_flag(TIF_IA32))
+			ret = ptrace_to_pt_regs(regs,
+						(unsigned long *) new_regs32);
+		else
+#endif
+		ret = ptrace_to_pt_regs(regs, new_regs);
+	}
+
+	return ret;
+}
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index c25db86..317e888 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -366,6 +366,29 @@ static int ptrace_setsiginfo(struct task_struct *child, siginfo_t __user * data)
 	return error;
 }
 
+extern struct mm_struct *fd_to_mm(int fd);
+
+static int ptrace_switch_mm(struct task_struct *child, int mm_fd)
+{
+	struct mm_struct *old = child->mm;
+	struct mm_struct *new = fd_to_mm(mm_fd);
+
+	if (IS_ERR(new))
+		return PTR_ERR(new);
+
+	task_lock(child);
+
+	atomic_inc(&new->mm_users);
+
+	child->mm = new;
+	child->active_mm = new;
+
+	task_unlock(child);
+	mmput(old);
+
+	return 0;
+}
+
 int ptrace_request(struct task_struct *child, long request,
 		   long addr, long data)
 {
@@ -390,6 +413,9 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_DETACH:	 /* detach a process that was attached. */
 		ret = ptrace_detach(child, data);
 		break;
+	case PTRACE_SWITCH_MM:
+		ret = ptrace_switch_mm(child, data);
+		break;
 	default:
 		break;
 	}

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
