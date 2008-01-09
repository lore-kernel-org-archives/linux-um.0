Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCj7X-000560-Gx for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:59 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCj7V-0007wi-R0
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 14:09:59 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m09M9rsT000407
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:53 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m09M9rSu009319
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 17:09:53 -0500
Date: Wed, 9 Jan 2008 17:09:53 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080109220953.GA9124@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 6/9] SKAS4 - Host get_mm and switch_mm
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
To: uml-devel <user-mode-linux-devel@lists.sourceforge.net>

This is the new_mm, switch_mm, and /proc/<pid>/mm implementation for
32- and 64-bit x86 and UML.

Index: linux-2.6-skas4/include/asm-x86/unistd_32.h
===================================================================
--- linux-2.6-skas4.orig/include/asm-x86/unistd_32.h	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/include/asm-x86/unistd_32.h	2008-01-09 16:43:30.000000000 -0500
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
Index: linux-2.6-skas4/include/asm-x86/unistd_64.h
===================================================================
--- linux-2.6-skas4.orig/include/asm-x86/unistd_64.h	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/include/asm-x86/unistd_64.h	2008-01-09 16:43:30.000000000 -0500
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
Index: linux-2.6-skas4/include/linux/ptrace.h
===================================================================
--- linux-2.6-skas4.orig/include/linux/ptrace.h	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/include/linux/ptrace.h	2008-01-09 16:43:30.000000000 -0500
@@ -21,6 +21,8 @@
 
 #define PTRACE_SYSCALL		  24
 
+#define PTRACE_SWITCH_MM	  33
+
 /* 0x4200-0x4300 are reserved for architecture-independent additions.  */
 #define PTRACE_SETOPTIONS	0x4200
 #define PTRACE_GETEVENTMSG	0x4201
Index: linux-2.6-skas4/include/linux/sched.h
===================================================================
--- linux-2.6-skas4.orig/include/linux/sched.h	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/include/linux/sched.h	2008-01-09 16:43:30.000000000 -0500
@@ -1665,6 +1665,7 @@ static inline int sas_ss_flags(unsigned 
  * Routines for handling mm_structs
  */
 extern struct mm_struct * mm_alloc(void);
+extern struct mm_struct *dup_mm(struct task_struct *tsk);
 
 /* mmdrop drops the mm and the page tables */
 extern void FASTCALL(__mmdrop(struct mm_struct *));
Index: linux-2.6-skas4/kernel/Makefile
===================================================================
--- linux-2.6-skas4.orig/kernel/Makefile	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/kernel/Makefile	2008-01-09 16:43:30.000000000 -0500
@@ -3,7 +3,7 @@
 #
 
 obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
-	    exit.o itimer.o time.o softirq.o resource.o \
+	    exit.o itimer.o time.o softirq.o resource.o mmfs.o \
 	    sysctl.o capability.o ptrace.o timer.o user.o user_namespace.o \
 	    signal.o sys.o kmod.o workqueue.o pid.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
Index: linux-2.6-skas4/kernel/fork.c
===================================================================
--- linux-2.6-skas4.orig/kernel/fork.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/kernel/fork.c	2008-01-09 16:43:30.000000000 -0500
@@ -491,7 +491,7 @@ void mm_release(struct task_struct *tsk,
  * Allocate a new mm structure and copy contents from the
  * mm structure of the passed in task structure.
  */
-static struct mm_struct *dup_mm(struct task_struct *tsk)
+struct mm_struct *dup_mm(struct task_struct *tsk)
 {
 	struct mm_struct *mm, *oldmm = current->mm;
 	int err;
Index: linux-2.6-skas4/kernel/mmfs.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6-skas4/kernel/mmfs.c	2008-01-09 16:43:30.000000000 -0500
@@ -0,0 +1,378 @@
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
+	memcpy(ptregs, regs, MAX_REG_NR * sizeof(long))
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
+static inline int ptrace_to_pt_regs(struct pt_regs *regs,
+				    unsigned long *ptrace)
+{
+	int i, err;
+
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
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, ptrace, FRAME_SIZE))
+		return -EFAULT;
+
+	for (i = 0; i < MAX_REG_NR; i++){
+		unsigned long n = getreg(current, i * 8), err;
+		err = put_user(n, &ptrace[i]);
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
+	if (regs_init == MM_SP_IP) {
+		pt_regs_ip(*regs) = ptrace_ip(new_regs);
+		pt_regs_sp(*regs) = ptrace_sp(new_regs);
+	}
+	else if (regs_init == MM_SAME)
+		ret = 1;
+	else
+		ptrace_to_pt_regs(regs, new_regs);
+
+	return ret;
+}
Index: linux-2.6-skas4/kernel/ptrace.c
===================================================================
--- linux-2.6-skas4.orig/kernel/ptrace.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/kernel/ptrace.c	2008-01-09 16:43:30.000000000 -0500
@@ -366,6 +366,29 @@ static int ptrace_setsiginfo(struct task
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
@@ -390,6 +413,9 @@ int ptrace_request(struct task_struct *c
 	case PTRACE_DETACH:	 /* detach a process that was attached. */
 		ret = ptrace_detach(child, data);
 		break;
+	case PTRACE_SWITCH_MM:
+		ret = ptrace_switch_mm(child, data);
+		break;
 	default:
 		break;
 	}
Index: linux-2.6-skas4/arch/x86/kernel/entry_64.S
===================================================================
--- linux-2.6-skas4.orig/arch/x86/kernel/entry_64.S	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/x86/kernel/entry_64.S	2008-01-09 16:43:30.000000000 -0500
@@ -412,6 +412,7 @@ END(\label)
 	PTREGSCALL stub_rt_sigsuspend, sys_rt_sigsuspend, %rdx
 	PTREGSCALL stub_sigaltstack, sys_sigaltstack, %rdx
 	PTREGSCALL stub_iopl, sys_iopl, %rsi
+	PTREGSCALL stub_switch_mm, sys_switch_mm, %r8
 
 ENTRY(ptregscall_common)
 	popq %r11
Index: linux-2.6-skas4/arch/x86/kernel/ptrace_32.c
===================================================================
--- linux-2.6-skas4.orig/arch/x86/kernel/ptrace_32.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/x86/kernel/ptrace_32.c	2008-01-09 16:43:30.000000000 -0500
@@ -83,8 +83,8 @@ static inline int put_stack_long(struct 
 	return 0;
 }
 
-static int putreg(struct task_struct *child,
-	unsigned long regno, unsigned long value)
+int putreg(struct task_struct *child,
+	   unsigned long regno, unsigned long value)
 {
 	switch (regno >> 2) {
 		case GS:
@@ -116,7 +116,7 @@ static int putreg(struct task_struct *ch
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *child,
+unsigned long getreg(struct task_struct *child,
 	unsigned long regno)
 {
 	unsigned long retval = ~0UL;
Index: linux-2.6-skas4/arch/x86/kernel/ptrace_64.c
===================================================================
--- linux-2.6-skas4.orig/arch/x86/kernel/ptrace_64.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/x86/kernel/ptrace_64.c	2008-01-09 16:43:30.000000000 -0500
@@ -226,7 +226,7 @@ void ptrace_disable(struct task_struct *
 	clear_singlestep(child);
 }
 
-static int putreg(struct task_struct *child,
+int putreg(struct task_struct *child,
 	unsigned long regno, unsigned long value)
 {
 	unsigned long tmp; 
@@ -283,7 +283,7 @@ static int putreg(struct task_struct *ch
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *child, unsigned long regno)
+unsigned long getreg(struct task_struct *child, unsigned long regno)
 {
 	unsigned long val;
 	switch (regno) {
Index: linux-2.6-skas4/arch/x86/kernel/sys_i386_32.c
===================================================================
--- linux-2.6-skas4.orig/arch/x86/kernel/sys_i386_32.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/x86/kernel/sys_i386_32.c	2008-01-09 16:43:30.000000000 -0500
@@ -261,3 +261,12 @@ int kernel_execve(const char *filename, 
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
Index: linux-2.6-skas4/arch/x86/kernel/sys_x86_64.c
===================================================================
--- linux-2.6-skas4.orig/arch/x86/kernel/sys_x86_64.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/x86/kernel/sys_x86_64.c	2008-01-09 16:43:30.000000000 -0500
@@ -153,3 +153,12 @@ asmlinkage long sys_uname(struct new_uts
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
Index: linux-2.6-skas4/arch/x86/kernel/syscall_table_32.S
===================================================================
--- linux-2.6-skas4.orig/arch/x86/kernel/syscall_table_32.S	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/x86/kernel/syscall_table_32.S	2008-01-09 16:43:30.000000000 -0500
@@ -324,3 +324,5 @@ ENTRY(sys_call_table)
 	.long sys_timerfd
 	.long sys_eventfd
 	.long sys_fallocate
+	.long sys_new_mm
+	.long sys_switch_mm
Index: linux-2.6-skas4/fs/proc/base.c
===================================================================
--- linux-2.6-skas4.orig/fs/proc/base.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/fs/proc/base.c	2008-01-09 16:43:30.000000000 -0500
@@ -2187,6 +2187,34 @@ static int proc_pid_io_accounting(struct
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
@@ -2250,6 +2278,7 @@ static const struct pid_entry tgid_base_
 #ifdef CONFIG_TASK_IO_ACCOUNTING
 	INF("io",	S_IRUGO, pid_io_accounting),
 #endif
+	REG("mm", S_IRUSR | S_IWUSR, pid_mm),
 };
 
 static int proc_tgid_base_readdir(struct file * filp,
Index: linux-2.6-skas4/arch/um/sys-x86_64/syscalls.c
===================================================================
--- linux-2.6-skas4.orig/arch/um/sys-x86_64/syscalls.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/um/sys-x86_64/syscalls.c	2008-01-09 16:43:30.000000000 -0500
@@ -112,3 +112,11 @@ void arch_switch_to(struct task_struct *
 
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
Index: linux-2.6-skas4/arch/um/sys-i386/syscalls.c
===================================================================
--- linux-2.6-skas4.orig/arch/um/sys-i386/syscalls.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/um/sys-i386/syscalls.c	2008-01-09 16:43:30.000000000 -0500
@@ -200,3 +200,11 @@ long sys_sigaction(int sig, const struct
 
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
Index: linux-2.6-skas4/arch/um/include/skas_ptrace.h
===================================================================
--- linux-2.6-skas4.orig/arch/um/include/skas_ptrace.h	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/um/include/skas_ptrace.h	2008-01-09 16:43:30.000000000 -0500
@@ -7,7 +7,9 @@
 #define __SKAS_PTRACE_H
 
 #define PTRACE_FAULTINFO 52
-#define PTRACE_SWITCH_MM 55
+#ifndef OLD_PTRACE_SWITCH_MM
+#define OLD_PTRACE_SWITCH_MM 55
+#endif
 
 #include "sysdep/skas_ptrace.h"
 
Index: linux-2.6-skas4/arch/um/kernel/ptrace.c
===================================================================
--- linux-2.6-skas4.orig/arch/um/kernel/ptrace.c	2008-01-09 16:29:06.000000000 -0500
+++ linux-2.6-skas4/arch/um/kernel/ptrace.c	2008-01-09 16:43:30.000000000 -0500
@@ -192,7 +192,7 @@ long arch_ptrace(struct task_struct *chi
 	}
 #endif
 #ifdef CONFIG_PROC_MM
-	case PTRACE_SWITCH_MM: {
+	case OLD_PTRACE_SWITCH_MM: {
 		struct mm_struct *old = child->mm;
 		struct mm_struct *new = proc_mm_get_mm(data);
 
Index: linux-2.6-skas4/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6-skas4.orig/arch/um/os-Linux/skas/process.c	2008-01-09 16:43:22.000000000 -0500
+++ linux-2.6-skas4/arch/um/os-Linux/skas/process.c	2008-01-09 16:44:21.000000000 -0500
@@ -731,7 +731,7 @@ void __switch_mm(struct mm_id *mm_idp)
 
 	/* FIXME: need cpu pid in __switch_mm */
 	if (proc_mm) {
-		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+		err = ptrace(OLD_PTRACE_SWITCH_MM, userspace_pid[0], 0,
 			     mm_idp->u.mm_fd);
 		if (err)
 			panic("__switch_mm - PTRACE_SWITCH_MM failed, "

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
