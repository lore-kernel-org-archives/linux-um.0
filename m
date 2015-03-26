Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1Yb6sy-0005EG-KR
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:44 +0000
Received: from mail.sigma-star.at ([95.130.255.111])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtp (Exim 4.76)
	id 1Yb6sv-0005xr-1y for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 26 Mar 2015 12:27:44 +0000
From: Richard Weinberger <richard@nod.at>
Date: Thu, 26 Mar 2015 13:27:15 +0100
Message-Id: <1427372838-16605-4-git-send-email-richard@nod.at>
In-Reply-To: <1427372838-16605-1-git-send-email-richard@nod.at>
References: <1427372838-16605-1-git-send-email-richard@nod.at>
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
Subject: [uml-devel] [PATCH 4/7] um: Remove SKAS3/4 support
To: user-mode-linux-devel@lists.sourceforge.net
Cc: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org

Before we had SKAS0 UML had two modes of operation
TT (tracing thread) and SKAS3/4 (separated kernel address space).
TT was known to be insecure and got removed a long time ago.
SKAS3/4 required a few (3 or 4) patches on the host side which never went
mainline. The last host patch is 10 years old.

With SKAS0 mode (separated kernel address space using 0 host patches),
default since 2005, SKAS3/4 is obsolete and can be removed.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/include/shared/os.h              |   2 -
 arch/um/include/shared/skas/proc_mm.h    |  44 ------
 arch/um/include/shared/skas/skas.h       |   3 -
 arch/um/include/shared/skas_ptrace.h     |  14 --
 arch/um/kernel/ptrace.c                  |  32 -----
 arch/um/kernel/reboot.c                  |  35 ++---
 arch/um/kernel/skas/mmu.c                |  68 ++++-----
 arch/um/kernel/skas/process.c            |  27 ----
 arch/um/kernel/trap.c                    |   2 +-
 arch/um/kernel/um_arch.c                 |  10 --
 arch/um/os-Linux/process.c               |  16 ---
 arch/um/os-Linux/skas/mem.c              | 100 ++------------
 arch/um/os-Linux/skas/process.c          | 200 +++++++--------------------
 arch/um/os-Linux/start_up.c              | 154 ---------------------
 arch/x86/um/ldt.c                        | 227 +++++++------------------------
 arch/x86/um/shared/sysdep/faultinfo_32.h |   3 -
 arch/x86/um/shared/sysdep/faultinfo_64.h |   3 -
 arch/x86/um/shared/sysdep/skas_ptrace.h  |  22 ---
 18 files changed, 148 insertions(+), 814 deletions(-)
 delete mode 100644 arch/um/include/shared/skas/proc_mm.h
 delete mode 100644 arch/um/include/shared/skas_ptrace.h
 delete mode 100644 arch/x86/um/shared/sysdep/skas_ptrace.h

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 08eec0b..d824528 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -174,7 +174,6 @@ extern unsigned long long os_makedev(unsigned major, unsigned minor);
 
 /* start_up.c */
 extern void os_early_checks(void);
-extern void can_do_skas(void);
 extern void os_check_bugs(void);
 extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 
@@ -187,7 +186,6 @@ extern int os_process_parent(int pid);
 extern void os_stop_process(int pid);
 extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
-extern long os_ptrace_ldt(long pid, long addr, long data);
 
 extern int os_getpid(void);
 extern int os_getpgrp(void);
diff --git a/arch/um/include/shared/skas/proc_mm.h b/arch/um/include/shared/skas/proc_mm.h
deleted file mode 100644
index 9028092..0000000
--- a/arch/um/include/shared/skas/proc_mm.h
+++ /dev/null
@@ -1,44 +0,0 @@
-/*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_PROC_MM_H
-#define __SKAS_PROC_MM_H
-
-#define MM_MMAP 54
-#define MM_MUNMAP 55
-#define MM_MPROTECT 56
-#define MM_COPY_SEGMENTS 57
-
-struct mm_mmap {
-	unsigned long addr;
-	unsigned long len;
-	unsigned long prot;
-	unsigned long flags;
-	unsigned long fd;
-	unsigned long offset;
-};
-
-struct mm_munmap {
-	unsigned long addr;
-	unsigned long len;
-};
-
-struct mm_mprotect {
-	unsigned long addr;
-	unsigned long len;
-	unsigned int prot;
-};
-
-struct proc_mm_op {
-	int op;
-	union {
-		struct mm_mmap mmap;
-		struct mm_munmap munmap;
-	        struct mm_mprotect mprotect;
-		int copy_segments;
-	} u;
-};
-
-#endif
diff --git a/arch/um/include/shared/skas/skas.h b/arch/um/include/shared/skas/skas.h
index c45df96..911f3c4 100644
--- a/arch/um/include/shared/skas/skas.h
+++ b/arch/um/include/shared/skas/skas.h
@@ -9,13 +9,10 @@
 #include <sysdep/ptrace.h>
 
 extern int userspace_pid[];
-extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
-extern int skas_needs_stub;
 
 extern int user_thread(unsigned long stack, int flags);
 extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
-extern int new_mm(unsigned long stack);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
 
diff --git a/arch/um/include/shared/skas_ptrace.h b/arch/um/include/shared/skas_ptrace.h
deleted file mode 100644
index 630a9c9..0000000
--- a/arch/um/include/shared/skas_ptrace.h
+++ /dev/null
@@ -1,14 +0,0 @@
-/* 
- * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
- * Licensed under the GPL
- */
-
-#ifndef __SKAS_PTRACE_H
-#define __SKAS_PTRACE_H
-
-#define PTRACE_FAULTINFO 52
-#define PTRACE_SWITCH_MM 55
-
-#include <sysdep/skas_ptrace.h>
-
-#endif
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index 62435ef..174ee50 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -8,9 +8,6 @@
 #include <linux/sched.h>
 #include <linux/tracehook.h>
 #include <asm/uaccess.h>
-#include <skas_ptrace.h>
-
-
 
 void user_enable_single_step(struct task_struct *child)
 {
@@ -104,35 +101,6 @@ long arch_ptrace(struct task_struct *child, long request,
 		ret = ptrace_set_thread_area(child, addr, vp);
 		break;
 
-	case PTRACE_FAULTINFO: {
-		/*
-		 * Take the info from thread->arch->faultinfo,
-		 * but transfer max. sizeof(struct ptrace_faultinfo).
-		 * On i386, ptrace_faultinfo is smaller!
-		 */
-		ret = copy_to_user(p, &child->thread.arch.faultinfo,
-				   sizeof(struct ptrace_faultinfo)) ?
-			-EIO : 0;
-		break;
-	}
-
-#ifdef PTRACE_LDT
-	case PTRACE_LDT: {
-		struct ptrace_ldt ldt;
-
-		if (copy_from_user(&ldt, p, sizeof(ldt))) {
-			ret = -EIO;
-			break;
-		}
-
-		/*
-		 * This one is confusing, so just punt and return -EIO for
-		 * now
-		 */
-		ret = -EIO;
-		break;
-	}
-#endif
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		if (ret == -EIO)
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index ced8903..9bdf67a 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -15,28 +15,21 @@ void (*pm_power_off)(void);
 
 static void kill_off_processes(void)
 {
-	if (proc_mm)
-		/*
-		 * FIXME: need to loop over userspace_pids
-		 */
-		os_kill_ptraced_process(userspace_pid[0], 1);
-	else {
-		struct task_struct *p;
-		int pid;
-
-		read_lock(&tasklist_lock);
-		for_each_process(p) {
-			struct task_struct *t;
-
-			t = find_lock_task_mm(p);
-			if (!t)
-				continue;
-			pid = t->mm->context.id.u.pid;
-			task_unlock(t);
-			os_kill_ptraced_process(pid, 1);
-		}
-		read_unlock(&tasklist_lock);
+	struct task_struct *p;
+	int pid;
+
+	read_lock(&tasklist_lock);
+	for_each_process(p) {
+		struct task_struct *t;
+
+		t = find_lock_task_mm(p);
+		if (!t)
+			continue;
+		pid = t->mm->context.id.u.pid;
+		task_unlock(t);
+		os_kill_ptraced_process(pid, 1);
 	}
+	read_unlock(&tasklist_lock);
 }
 
 void uml_cleanup(void)
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 007d550..94abdcc 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -54,35 +54,22 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
 
-	if (skas_needs_stub) {
-		stack = get_zeroed_page(GFP_KERNEL);
-		if (stack == 0)
-			goto out;
-	}
+	stack = get_zeroed_page(GFP_KERNEL);
+	if (stack == 0)
+		goto out;
 
 	to_mm->id.stack = stack;
 	if (current->mm != NULL && current->mm != &init_mm)
 		from_mm = &current->mm->context;
 
-	if (proc_mm) {
-		ret = new_mm(stack);
-		if (ret < 0) {
-			printk(KERN_ERR "init_new_context_skas - "
-			       "new_mm failed, errno = %d\n", ret);
-			goto out_free;
-		}
-		to_mm->id.u.mm_fd = ret;
-	}
-	else {
-		if (from_mm)
-			to_mm->id.u.pid = copy_context_skas0(stack,
-							     from_mm->id.u.pid);
-		else to_mm->id.u.pid = start_userspace(stack);
-
-		if (to_mm->id.u.pid < 0) {
-			ret = to_mm->id.u.pid;
-			goto out_free;
-		}
+	if (from_mm)
+		to_mm->id.u.pid = copy_context_skas0(stack,
+						     from_mm->id.u.pid);
+	else to_mm->id.u.pid = start_userspace(stack);
+
+	if (to_mm->id.u.pid < 0) {
+		ret = to_mm->id.u.pid;
+		goto out_free;
 	}
 
 	ret = init_new_ldt(to_mm, from_mm);
@@ -105,9 +92,6 @@ void uml_setup_stubs(struct mm_struct *mm)
 {
 	int err, ret;
 
-	if (!skas_needs_stub)
-		return;
-
 	ret = init_stub_pte(mm, STUB_CODE,
 			    (unsigned long) &__syscall_stub_start);
 	if (ret)
@@ -154,25 +138,19 @@ void destroy_context(struct mm_struct *mm)
 {
 	struct mm_context *mmu = &mm->context;
 
-	if (proc_mm)
-		os_close_file(mmu->id.u.mm_fd);
-	else {
-		/*
-		 * If init_new_context wasn't called, this will be
-		 * zero, resulting in a kill(0), which will result in the
-		 * whole UML suddenly dying.  Also, cover negative and
-		 * 1 cases, since they shouldn't happen either.
-		 */
-		if (mmu->id.u.pid < 2) {
-			printk(KERN_ERR "corrupt mm_context - pid = %d\n",
-			       mmu->id.u.pid);
-			return;
-		}
-		os_kill_ptraced_process(mmu->id.u.pid, 1);
+	/*
+	 * If init_new_context wasn't called, this will be
+	 * zero, resulting in a kill(0), which will result in the
+	 * whole UML suddenly dying.  Also, cover negative and
+	 * 1 cases, since they shouldn't happen either.
+	 */
+	if (mmu->id.u.pid < 2) {
+		printk(KERN_ERR "corrupt mm_context - pid = %d\n",
+		       mmu->id.u.pid);
+		return;
 	}
+	os_kill_ptraced_process(mmu->id.u.pid, 1);
 
-	if (skas_needs_stub)
-		free_page(mmu->id.stack);
-
+	free_page(mmu->id.stack);
 	free_ldt(mmu);
 }
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 4da11b3..082955d 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -10,25 +10,6 @@
 #include <os.h>
 #include <skas.h>
 
-int new_mm(unsigned long stack)
-{
-	int fd, err;
-
-	fd = os_open_file("/proc/mm", of_cloexec(of_write(OPENFLAGS())), 0);
-	if (fd < 0)
-		return fd;
-
-	if (skas_needs_stub) {
-		err = map_stub_pages(fd, STUB_CODE, STUB_DATA, stack);
-		if (err) {
-			os_close_file(fd);
-			return err;
-		}
-	}
-
-	return fd;
-}
-
 extern void start_kernel(void);
 
 static int __init start_kernel_proc(void *unused)
@@ -55,14 +36,6 @@ int __init start_uml(void)
 {
 	stack_protections((unsigned long) &cpu0_irqstack);
 	set_sigstack(cpu0_irqstack, THREAD_SIZE);
-	if (proc_mm) {
-		userspace_pid[0] = start_userspace(0);
-		if (userspace_pid[0] < 0) {
-			printf("start_uml - start_userspace returned %d\n",
-			       userspace_pid[0]);
-			exit(1);
-		}
-	}
 
 	init_new_thread_signals();
 
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 2096173..8e4daf4 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -220,7 +220,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 		panic("Segfault with no mm");
 	}
 
-	if (SEGV_IS_FIXABLE(&fi) || SEGV_MAYBE_FIXABLE(&fi))
+	if (SEGV_IS_FIXABLE(&fi))
 		err = handle_page_fault(address, ip, is_write, is_user,
 					&si.si_code);
 	else {
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 9274eae..dbd5bda 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -268,7 +268,6 @@ int __init linux_main(int argc, char **argv)
 	unsigned long stack;
 	unsigned int i;
 	int add;
-	char * mode;
 
 	for (i = 1; i < argc; i++) {
 		if ((i == 1) && (argv[i][0] == ' '))
@@ -291,15 +290,6 @@ int __init linux_main(int argc, char **argv)
 	/* OS sanity checks that need to happen before the kernel runs */
 	os_early_checks();
 
-	can_do_skas();
-
-	if (proc_mm && ptrace_faultinfo)
-		mode = "SKAS3";
-	else
-		mode = "SKAS0";
-
-	printf("UML running in %s mode\n", mode);
-
 	brk_start = (unsigned long) sbrk(0);
 
 	/*
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 33496fe..8408aba 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -16,7 +16,6 @@
 #include <init.h>
 #include <longjmp.h>
 #include <os.h>
-#include <skas_ptrace.h>
 
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
@@ -102,21 +101,6 @@ void os_kill_process(int pid, int reap_child)
 		CATCH_EINTR(waitpid(pid, NULL, __WALL));
 }
 
-/* This is here uniquely to have access to the userspace errno, i.e. the one
- * used by ptrace in case of error.
- */
-
-long os_ptrace_ldt(long pid, long addr, long data)
-{
-	int ret;
-
-	ret = ptrace(PTRACE_LDT, pid, addr, data);
-
-	if (ret < 0)
-		return -errno;
-	return ret;
-}
-
 /* Kill off a ptraced child by all means available.  kill it normally first,
  * then PTRACE_KILL it, then PTRACE_CONT it in case it's in a run state from
  * which it can't exit directly.
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 689b18d..e7f8c94 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -12,7 +12,6 @@
 #include <as-layout.h>
 #include <mm_id.h>
 #include <os.h>
-#include <proc_mm.h>
 #include <ptrace_user.h>
 #include <registers.h>
 #include <skas.h>
@@ -46,8 +45,6 @@ static int __init init_syscall_regs(void)
 
 __initcall(init_syscall_regs);
 
-extern int proc_mm;
-
 static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 {
 	int n, i;
@@ -56,10 +53,6 @@ static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 	unsigned long * syscall;
 	int err, pid = mm_idp->u.pid;
 
-	if (proc_mm)
-		/* FIXME: Need to look up userspace_pid by cpu */
-		pid = userspace_pid[0];
-
 	n = ptrace_setregs(pid, syscall_regs);
 	if (n < 0) {
 		printk(UM_KERN_ERR "Registers - \n");
@@ -178,38 +171,12 @@ int map(struct mm_id * mm_idp, unsigned long virt, unsigned long len, int prot,
 	int phys_fd, unsigned long long offset, int done, void **data)
 {
 	int ret;
+	unsigned long args[] = { virt, len, prot,
+				 MAP_SHARED | MAP_FIXED, phys_fd,
+				 MMAP_OFFSET(offset) };
 
-	if (proc_mm) {
-		struct proc_mm_op map;
-		int fd = mm_idp->u.mm_fd;
-
-		map = ((struct proc_mm_op) { .op	= MM_MMAP,
-				       .u		=
-				       { .mmap	=
-					 { .addr	= virt,
-					   .len	= len,
-					   .prot	= prot,
-					   .flags	= MAP_SHARED |
-					   MAP_FIXED,
-					   .fd	= phys_fd,
-					   .offset= offset
-					 } } } );
-		CATCH_EINTR(ret = write(fd, &map, sizeof(map)));
-		if (ret != sizeof(map)) {
-			ret = -errno;
-			printk(UM_KERN_ERR "map : /proc/mm map failed, "
-			       "err = %d\n", -ret);
-		}
-		else ret = 0;
-	}
-	else {
-		unsigned long args[] = { virt, len, prot,
-					 MAP_SHARED | MAP_FIXED, phys_fd,
-					 MMAP_OFFSET(offset) };
-
-		ret = run_syscall_stub(mm_idp, STUB_MMAP_NR, args, virt,
-				       data, done);
-	}
+	ret = run_syscall_stub(mm_idp, STUB_MMAP_NR, args, virt,
+			       data, done);
 
 	return ret;
 }
@@ -218,32 +185,11 @@ int unmap(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
 	  int done, void **data)
 {
 	int ret;
+	unsigned long args[] = { (unsigned long) addr, len, 0, 0, 0,
+				 0 };
 
-	if (proc_mm) {
-		struct proc_mm_op unmap;
-		int fd = mm_idp->u.mm_fd;
-
-		unmap = ((struct proc_mm_op) { .op	= MM_MUNMAP,
-					 .u	=
-					 { .munmap	=
-					   { .addr	=
-					     (unsigned long) addr,
-					     .len		= len } } } );
-		CATCH_EINTR(ret = write(fd, &unmap, sizeof(unmap)));
-		if (ret != sizeof(unmap)) {
-			ret = -errno;
-			printk(UM_KERN_ERR "unmap - proc_mm write returned "
-			       "%d\n", ret);
-		}
-		else ret = 0;
-	}
-	else {
-		unsigned long args[] = { (unsigned long) addr, len, 0, 0, 0,
-					 0 };
-
-		ret = run_syscall_stub(mm_idp, __NR_munmap, args, 0,
-				       data, done);
-	}
+	ret = run_syscall_stub(mm_idp, __NR_munmap, args, 0,
+			       data, done);
 
 	return ret;
 }
@@ -251,33 +197,11 @@ int unmap(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
 int protect(struct mm_id * mm_idp, unsigned long addr, unsigned long len,
 	    unsigned int prot, int done, void **data)
 {
-	struct proc_mm_op protect;
 	int ret;
+	unsigned long args[] = { addr, len, prot, 0, 0, 0 };
 
-	if (proc_mm) {
-		int fd = mm_idp->u.mm_fd;
-
-		protect = ((struct proc_mm_op) { .op	= MM_MPROTECT,
-					   .u	=
-					   { .mprotect	=
-					     { .addr	=
-					       (unsigned long) addr,
-					       .len	= len,
-					       .prot	= prot } } } );
-
-		CATCH_EINTR(ret = write(fd, &protect, sizeof(protect)));
-		if (ret != sizeof(protect)) {
-			ret = -errno;
-			printk(UM_KERN_ERR "protect failed, err = %d", -ret);
-		}
-		else ret = 0;
-	}
-	else {
-		unsigned long args[] = { addr, len, prot, 0, 0, 0 };
-
-		ret = run_syscall_stub(mm_idp, __NR_mprotect, args, 0,
-				       data, done);
-	}
+	ret = run_syscall_stub(mm_idp, __NR_mprotect, args, 0,
+			       data, done);
 
 	return ret;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 908579f..50ebeae 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -16,11 +16,9 @@
 #include <kern_util.h>
 #include <mem.h>
 #include <os.h>
-#include <proc_mm.h>
 #include <ptrace_user.h>
 #include <registers.h>
 #include <skas.h>
-#include <skas_ptrace.h>
 #include <sysdep/stub.h>
 
 int is_skas_winch(int pid, int fd, void *data)
@@ -91,50 +89,33 @@ extern unsigned long current_stub_stack(void);
 static void get_skas_faultinfo(int pid, struct faultinfo *fi)
 {
 	int err;
+	unsigned long fpregs[FP_SIZE];
 
-	if (ptrace_faultinfo) {
-		err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
-		if (err) {
-			printk(UM_KERN_ERR "get_skas_faultinfo - "
-			       "PTRACE_FAULTINFO failed, errno = %d\n", errno);
-			fatal_sigsegv();
-		}
-
-		/* Special handling for i386, which has different structs */
-		if (sizeof(struct ptrace_faultinfo) < sizeof(struct faultinfo))
-			memset((char *)fi + sizeof(struct ptrace_faultinfo), 0,
-			       sizeof(struct faultinfo) -
-			       sizeof(struct ptrace_faultinfo));
+	err = get_fp_registers(pid, fpregs);
+	if (err < 0) {
+		printk(UM_KERN_ERR "save_fp_registers returned %d\n",
+		       err);
+		fatal_sigsegv();
 	}
-	else {
-		unsigned long fpregs[FP_SIZE];
-
-		err = get_fp_registers(pid, fpregs);
-		if (err < 0) {
-			printk(UM_KERN_ERR "save_fp_registers returned %d\n",
-			       err);
-			fatal_sigsegv();
-		}
-		err = ptrace(PTRACE_CONT, pid, 0, SIGSEGV);
-		if (err) {
-			printk(UM_KERN_ERR "Failed to continue stub, pid = %d, "
-			       "errno = %d\n", pid, errno);
-			fatal_sigsegv();
-		}
-		wait_stub_done(pid);
+	err = ptrace(PTRACE_CONT, pid, 0, SIGSEGV);
+	if (err) {
+		printk(UM_KERN_ERR "Failed to continue stub, pid = %d, "
+		       "errno = %d\n", pid, errno);
+		fatal_sigsegv();
+	}
+	wait_stub_done(pid);
 
-		/*
-		 * faultinfo is prepared by the stub-segv-handler at start of
-		 * the stub stack page. We just have to copy it.
-		 */
-		memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
+	/*
+	 * faultinfo is prepared by the stub-segv-handler at start of
+	 * the stub stack page. We just have to copy it.
+	 */
+	memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
 
-		err = put_fp_registers(pid, fpregs);
-		if (err < 0) {
-			printk(UM_KERN_ERR "put_fp_registers returned %d\n",
-			       err);
-			fatal_sigsegv();
-		}
+	err = put_fp_registers(pid, fpregs);
+	if (err < 0) {
+		printk(UM_KERN_ERR "put_fp_registers returned %d\n",
+		       err);
+		fatal_sigsegv();
 	}
 }
 
@@ -198,7 +179,8 @@ extern int __syscall_stub_start;
 static int userspace_tramp(void *stack)
 {
 	void *addr;
-	int err;
+	int err, fd;
+	unsigned long long offset;
 
 	ptrace(PTRACE_TRACEME, 0, 0, 0);
 
@@ -211,36 +193,32 @@ static int userspace_tramp(void *stack)
 		exit(1);
 	}
 
-	if (!proc_mm) {
-		/*
-		 * This has a pte, but it can't be mapped in with the usual
-		 * tlb_flush mechanism because this is part of that mechanism
-		 */
-		int fd;
-		unsigned long long offset;
-		fd = phys_mapping(to_phys(&__syscall_stub_start), &offset);
-		addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
-			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
+	/*
+	 * This has a pte, but it can't be mapped in with the usual
+	 * tlb_flush mechanism because this is part of that mechanism
+	 */
+	fd = phys_mapping(to_phys(&__syscall_stub_start), &offset);
+	addr = mmap64((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
+		      PROT_EXEC, MAP_FIXED | MAP_PRIVATE, fd, offset);
+	if (addr == MAP_FAILED) {
+		printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, "
+		       "errno = %d\n", STUB_CODE, errno);
+		exit(1);
+	}
+
+	if (stack != NULL) {
+		fd = phys_mapping(to_phys(stack), &offset);
+		addr = mmap((void *) STUB_DATA,
+			    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+			    MAP_FIXED | MAP_SHARED, fd, offset);
 		if (addr == MAP_FAILED) {
-			printk(UM_KERN_ERR "mapping mmap stub at 0x%lx failed, "
-			       "errno = %d\n", STUB_CODE, errno);
+			printk(UM_KERN_ERR "mapping segfault stack "
+			       "at 0x%lx failed, errno = %d\n",
+			       STUB_DATA, errno);
 			exit(1);
 		}
-
-		if (stack != NULL) {
-			fd = phys_mapping(to_phys(stack), &offset);
-			addr = mmap((void *) STUB_DATA,
-				    UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
-				    MAP_FIXED | MAP_SHARED, fd, offset);
-			if (addr == MAP_FAILED) {
-				printk(UM_KERN_ERR "mapping segfault stack "
-				       "at 0x%lx failed, errno = %d\n",
-				       STUB_DATA, errno);
-				exit(1);
-			}
-		}
 	}
-	if (!ptrace_faultinfo && (stack != NULL)) {
+	if (stack != NULL) {
 		struct sigaction sa;
 
 		unsigned long v = STUB_CODE +
@@ -286,11 +264,7 @@ int start_userspace(unsigned long stub_stack)
 
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);
 
-	flags = CLONE_FILES;
-	if (proc_mm)
-		flags |= CLONE_VM;
-	else
-		flags |= SIGCHLD;
+	flags = CLONE_FILES | SIGCHLD;
 
 	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
 	if (pid < 0) {
@@ -413,8 +387,7 @@ void userspace(struct uml_pt_regs *regs)
 
 			switch (sig) {
 			case SIGSEGV:
-				if (PTRACE_FULL_FAULTINFO ||
-				    !ptrace_faultinfo) {
+				if (PTRACE_FULL_FAULTINFO) {
 					get_skas_faultinfo(pid,
 							   &regs->faultinfo);
 					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
@@ -571,67 +544,6 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	return err;
 }
 
-/*
- * This is used only, if stub pages are needed, while proc_mm is
- * available. Opening /proc/mm creates a new mm_context, which lacks
- * the stub-pages. Thus, we map them using /proc/mm-fd
- */
-int map_stub_pages(int fd, unsigned long code, unsigned long data,
-		   unsigned long stack)
-{
-	struct proc_mm_op mmop;
-	int n;
-	unsigned long long code_offset;
-	int code_fd = phys_mapping(to_phys((void *) &__syscall_stub_start),
-				   &code_offset);
-
-	mmop = ((struct proc_mm_op) { .op        = MM_MMAP,
-				      .u         =
-				      { .mmap    =
-					{ .addr    = code,
-					  .len     = UM_KERN_PAGE_SIZE,
-					  .prot    = PROT_EXEC,
-					  .flags   = MAP_FIXED | MAP_PRIVATE,
-					  .fd      = code_fd,
-					  .offset  = code_offset
-	} } });
-	CATCH_EINTR(n = write(fd, &mmop, sizeof(mmop)));
-	if (n != sizeof(mmop)) {
-		n = errno;
-		printk(UM_KERN_ERR "mmap args - addr = 0x%lx, fd = %d, "
-		       "offset = %llx\n", code, code_fd,
-		       (unsigned long long) code_offset);
-		printk(UM_KERN_ERR "map_stub_pages : /proc/mm map for code "
-		       "failed, err = %d\n", n);
-		return -n;
-	}
-
-	if (stack) {
-		unsigned long long map_offset;
-		int map_fd = phys_mapping(to_phys((void *)stack), &map_offset);
-		mmop = ((struct proc_mm_op)
-				{ .op        = MM_MMAP,
-				  .u         =
-				  { .mmap    =
-				    { .addr    = data,
-				      .len     = UM_KERN_PAGE_SIZE,
-				      .prot    = PROT_READ | PROT_WRITE,
-				      .flags   = MAP_FIXED | MAP_SHARED,
-				      .fd      = map_fd,
-				      .offset  = map_offset
-		} } });
-		CATCH_EINTR(n = write(fd, &mmop, sizeof(mmop)));
-		if (n != sizeof(mmop)) {
-			n = errno;
-			printk(UM_KERN_ERR "map_stub_pages : /proc/mm map for "
-			       "data failed, err = %d\n", n);
-			return -n;
-		}
-	}
-
-	return 0;
-}
-
 void new_thread(void *stack, jmp_buf *buf, void (*handler)(void))
 {
 	(*buf)[0].JB_IP = (unsigned long) handler;
@@ -728,17 +640,5 @@ void reboot_skas(void)
 
 void __switch_mm(struct mm_id *mm_idp)
 {
-	int err;
-
-	/* FIXME: need cpu pid in __switch_mm */
-	if (proc_mm) {
-		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
-			     mm_idp->u.mm_fd);
-		if (err) {
-			printk(UM_KERN_ERR "__switch_mm - PTRACE_SWITCH_MM "
-			       "failed, errno = %d\n", errno);
-			fatal_sigsegv();
-		}
-	}
-	else userspace_pid[0] = mm_idp->u.pid;
+	userspace_pid[0] = mm_idp->u.pid;
 }
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 337518c..47f1ff0 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -24,7 +24,6 @@
 #include <ptrace_user.h>
 #include <registers.h>
 #include <skas.h>
-#include <skas_ptrace.h>
 
 static void ptrace_child(void)
 {
@@ -143,44 +142,6 @@ static int stop_ptraced_child(int pid, int exitcode, int mustexit)
 }
 
 /* Changed only during early boot */
-int ptrace_faultinfo;
-static int disable_ptrace_faultinfo;
-
-int ptrace_ldt;
-static int disable_ptrace_ldt;
-
-int proc_mm;
-static int disable_proc_mm;
-
-int have_switch_mm;
-static int disable_switch_mm;
-
-int skas_needs_stub;
-
-static int __init skas0_cmd_param(char *str, int* add)
-{
-	disable_ptrace_faultinfo = 1;
-	disable_ptrace_ldt = 1;
-	disable_proc_mm = 1;
-	disable_switch_mm = 1;
-
-	return 0;
-}
-
-/* The two __uml_setup would conflict, without this stupid alias. */
-
-static int __init mode_skas0_cmd_param(char *str, int* add)
-	__attribute__((alias("skas0_cmd_param")));
-
-__uml_setup("skas0", skas0_cmd_param,
-"skas0\n"
-"    Disables SKAS3 and SKAS4 usage, so that SKAS0 is used\n\n");
-
-__uml_setup("mode=skas0", mode_skas0_cmd_param,
-"mode=skas0\n"
-"    Disables SKAS3 and SKAS4 usage, so that SKAS0 is used.\n\n");
-
-/* Changed only during early boot */
 static int force_sysemu_disabled = 0;
 
 static int __init nosysemu_cmd_param(char *str, int* add)
@@ -376,121 +337,6 @@ void __init os_early_checks(void)
 	stop_ptraced_child(pid, 1, 1);
 }
 
-static int __init noprocmm_cmd_param(char *str, int* add)
-{
-	disable_proc_mm = 1;
-	return 0;
-}
-
-__uml_setup("noprocmm", noprocmm_cmd_param,
-"noprocmm\n"
-"    Turns off usage of /proc/mm, even if host supports it.\n"
-"    To support /proc/mm, the host needs to be patched using\n"
-"    the current skas3 patch.\n\n");
-
-static int __init noptracefaultinfo_cmd_param(char *str, int* add)
-{
-	disable_ptrace_faultinfo = 1;
-	return 0;
-}
-
-__uml_setup("noptracefaultinfo", noptracefaultinfo_cmd_param,
-"noptracefaultinfo\n"
-"    Turns off usage of PTRACE_FAULTINFO, even if host supports\n"
-"    it. To support PTRACE_FAULTINFO, the host needs to be patched\n"
-"    using the current skas3 patch.\n\n");
-
-static int __init noptraceldt_cmd_param(char *str, int* add)
-{
-	disable_ptrace_ldt = 1;
-	return 0;
-}
-
-__uml_setup("noptraceldt", noptraceldt_cmd_param,
-"noptraceldt\n"
-"    Turns off usage of PTRACE_LDT, even if host supports it.\n"
-"    To support PTRACE_LDT, the host needs to be patched using\n"
-"    the current skas3 patch.\n\n");
-
-static inline void check_skas3_ptrace_faultinfo(void)
-{
-	struct ptrace_faultinfo fi;
-	int pid, n;
-
-	non_fatal("  - PTRACE_FAULTINFO...");
-	pid = start_ptraced_child();
-
-	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
-	if (n < 0) {
-		if (errno == EIO)
-			non_fatal("not found\n");
-		else
-			perror("not found");
-	} else if (disable_ptrace_faultinfo)
-		non_fatal("found but disabled on command line\n");
-	else {
-		ptrace_faultinfo = 1;
-		non_fatal("found\n");
-	}
-
-	stop_ptraced_child(pid, 1, 1);
-}
-
-static inline void check_skas3_ptrace_ldt(void)
-{
-#ifdef PTRACE_LDT
-	int pid, n;
-	unsigned char ldtbuf[40];
-	struct ptrace_ldt ldt_op = (struct ptrace_ldt) {
-		.func = 2, /* read default ldt */
-		.ptr = ldtbuf,
-		.bytecount = sizeof(ldtbuf)};
-
-	non_fatal("  - PTRACE_LDT...");
-	pid = start_ptraced_child();
-
-	n = ptrace(PTRACE_LDT, pid, 0, (unsigned long) &ldt_op);
-	if (n < 0) {
-		if (errno == EIO)
-			non_fatal("not found\n");
-		else
-			perror("not found");
-	} else if (disable_ptrace_ldt)
-		non_fatal("found, but use is disabled\n");
-	else {
-		ptrace_ldt = 1;
-		non_fatal("found\n");
-	}
-
-	stop_ptraced_child(pid, 1, 1);
-#endif
-}
-
-static inline void check_skas3_proc_mm(void)
-{
-	non_fatal("  - /proc/mm...");
-	if (access("/proc/mm", W_OK) < 0)
-		perror("not found");
-	else if (disable_proc_mm)
-		non_fatal("found but disabled on command line\n");
-	else {
-		proc_mm = 1;
-		non_fatal("found\n");
-	}
-}
-
-void can_do_skas(void)
-{
-	non_fatal("Checking for the skas3 patch in the host:\n");
-
-	check_skas3_proc_mm();
-	check_skas3_ptrace_faultinfo();
-	check_skas3_ptrace_ldt();
-
-	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
-		skas_needs_stub = 1;
-}
-
 int __init parse_iomem(char *str, int *add)
 {
 	struct iomem_region *new;
diff --git a/arch/x86/um/ldt.c b/arch/x86/um/ldt.c
index 8e08176..5c0b711 100644
--- a/arch/x86/um/ldt.c
+++ b/arch/x86/um/ldt.c
@@ -8,9 +8,7 @@
 #include <linux/slab.h>
 #include <asm/unistd.h>
 #include <os.h>
-#include <proc_mm.h>
 #include <skas.h>
-#include <skas_ptrace.h>
 #include <sysdep/tls.h>
 
 extern int modify_ldt(int func, void *ptr, unsigned long bytecount);
@@ -19,105 +17,20 @@ static long write_ldt_entry(struct mm_id *mm_idp, int func,
 		     struct user_desc *desc, void **addr, int done)
 {
 	long res;
-
-	if (proc_mm) {
-		/*
-		 * This is a special handling for the case, that the mm to
-		 * modify isn't current->active_mm.
-		 * If this is called directly by modify_ldt,
-		 *     (current->active_mm->context.skas.u == mm_idp)
-		 * will be true. So no call to __switch_mm(mm_idp) is done.
-		 * If this is called in case of init_new_ldt or PTRACE_LDT,
-		 * mm_idp won't belong to current->active_mm, but child->mm.
-		 * So we need to switch child's mm into our userspace, then
-		 * later switch back.
-		 *
-		 * Note: I'm unsure: should interrupts be disabled here?
-		 */
-		if (!current->active_mm || current->active_mm == &init_mm ||
-		    mm_idp != &current->active_mm->context.id)
-			__switch_mm(mm_idp);
-	}
-
-	if (ptrace_ldt) {
-		struct ptrace_ldt ldt_op = (struct ptrace_ldt) {
-			.func = func,
-			.ptr = desc,
-			.bytecount = sizeof(*desc)};
-		u32 cpu;
-		int pid;
-
-		if (!proc_mm)
-			pid = mm_idp->u.pid;
-		else {
-			cpu = get_cpu();
-			pid = userspace_pid[cpu];
-		}
-
-		res = os_ptrace_ldt(pid, 0, (unsigned long) &ldt_op);
-
-		if (proc_mm)
-			put_cpu();
-	}
-	else {
-		void *stub_addr;
-		res = syscall_stub_data(mm_idp, (unsigned long *)desc,
-					(sizeof(*desc) + sizeof(long) - 1) &
-					    ~(sizeof(long) - 1),
-					addr, &stub_addr);
-		if (!res) {
-			unsigned long args[] = { func,
-						 (unsigned long)stub_addr,
-						 sizeof(*desc),
-						 0, 0, 0 };
-			res = run_syscall_stub(mm_idp, __NR_modify_ldt, args,
-					       0, addr, done);
-		}
+	void *stub_addr;
+	res = syscall_stub_data(mm_idp, (unsigned long *)desc,
+				(sizeof(*desc) + sizeof(long) - 1) &
+				    ~(sizeof(long) - 1),
+				addr, &stub_addr);
+	if (!res) {
+		unsigned long args[] = { func,
+					 (unsigned long)stub_addr,
+					 sizeof(*desc),
+					 0, 0, 0 };
+		res = run_syscall_stub(mm_idp, __NR_modify_ldt, args,
+				       0, addr, done);
 	}
 
-	if (proc_mm) {
-		/*
-		 * This is the second part of special handling, that makes
-		 * PTRACE_LDT possible to implement.
-		 */
-		if (current->active_mm && current->active_mm != &init_mm &&
-		    mm_idp != &current->active_mm->context.id)
-			__switch_mm(&current->active_mm->context.id);
-	}
-
-	return res;
-}
-
-static long read_ldt_from_host(void __user * ptr, unsigned long bytecount)
-{
-	int res, n;
-	struct ptrace_ldt ptrace_ldt = (struct ptrace_ldt) {
-			.func = 0,
-			.bytecount = bytecount,
-			.ptr = kmalloc(bytecount, GFP_KERNEL)};
-	u32 cpu;
-
-	if (ptrace_ldt.ptr == NULL)
-		return -ENOMEM;
-
-	/*
-	 * This is called from sys_modify_ldt only, so userspace_pid gives
-	 * us the right number
-	 */
-
-	cpu = get_cpu();
-	res = os_ptrace_ldt(userspace_pid[cpu], 0, (unsigned long) &ptrace_ldt);
-	put_cpu();
-	if (res < 0)
-		goto out;
-
-	n = copy_to_user(ptr, ptrace_ldt.ptr, res);
-	if (n != 0)
-		res = -EFAULT;
-
-  out:
-	kfree(ptrace_ldt.ptr);
-
 	return res;
 }
 
@@ -145,9 +58,6 @@ static int read_ldt(void __user * ptr, unsigned long bytecount)
 		bytecount = LDT_ENTRY_SIZE*LDT_ENTRIES;
 	err = bytecount;
 
-	if (ptrace_ldt)
-		return read_ldt_from_host(ptr, bytecount);
-
 	mutex_lock(&ldt->lock);
 	if (ldt->entry_count <= LDT_DIRECT_ENTRIES) {
 		size = LDT_ENTRY_SIZE*LDT_DIRECT_ENTRIES;
@@ -229,17 +139,11 @@ static int write_ldt(void __user * ptr, unsigned long bytecount, int func)
 			goto out;
 	}
 
-	if (!ptrace_ldt)
-		mutex_lock(&ldt->lock);
+	mutex_lock(&ldt->lock);
 
 	err = write_ldt_entry(mm_idp, func, &ldt_info, &addr, 1);
 	if (err)
 		goto out_unlock;
-	else if (ptrace_ldt) {
-		/* With PTRACE_LDT available, this is used as a flag only */
-		ldt->entry_count = 1;
-		goto out;
-	}
 
 	if (ldt_info.entry_number >= ldt->entry_count &&
 	    ldt_info.entry_number >= LDT_DIRECT_ENTRIES) {
@@ -393,91 +297,56 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 	int i;
 	long page, err=0;
 	void *addr = NULL;
-	struct proc_mm_op copy;
 
 
-	if (!ptrace_ldt)
-		mutex_init(&new_mm->arch.ldt.lock);
+	mutex_init(&new_mm->arch.ldt.lock);
 
 	if (!from_mm) {
 		memset(&desc, 0, sizeof(desc));
 		/*
-		 * We have to initialize a clean ldt.
+		 * Now we try to retrieve info about the ldt, we
+		 * inherited from the host. All ldt-entries found
+		 * will be reset in the following loop
 		 */
-		if (proc_mm) {
-			/*
-			 * If the new mm was created using proc_mm, host's
-			 * default-ldt currently is assigned, which normally
-			 * contains the call-gates for lcall7 and lcall27.
-			 * To remove these gates, we simply write an empty
-			 * entry as number 0 to the host.
-			 */
-			err = write_ldt_entry(&new_mm->id, 1, &desc, &addr, 1);
-		}
-		else{
-			/*
-			 * Now we try to retrieve info about the ldt, we
-			 * inherited from the host. All ldt-entries found
-			 * will be reset in the following loop
-			 */
-			ldt_get_host_info();
-			for (num_p=host_ldt_entries; *num_p != -1; num_p++) {
-				desc.entry_number = *num_p;
-				err = write_ldt_entry(&new_mm->id, 1, &desc,
-						      &addr, *(num_p + 1) == -1);
-				if (err)
-					break;
-			}
+		ldt_get_host_info();
+		for (num_p=host_ldt_entries; *num_p != -1; num_p++) {
+			desc.entry_number = *num_p;
+			err = write_ldt_entry(&new_mm->id, 1, &desc,
+					      &addr, *(num_p + 1) == -1);
+			if (err)
+				break;
 		}
 		new_mm->arch.ldt.entry_count = 0;
 
 		goto out;
 	}
 
-	if (proc_mm) {
-		/*
-		 * We have a valid from_mm, so we now have to copy the LDT of
-		 * from_mm to new_mm, because using proc_mm an new mm with
-		 * an empty/default LDT was created in new_mm()
-		 */
-		copy = ((struct proc_mm_op) { .op 	= MM_COPY_SEGMENTS,
-					      .u 	=
-					      { .copy_segments =
-							from_mm->id.u.mm_fd } } );
-		i = os_write_file(new_mm->id.u.mm_fd, &copy, sizeof(copy));
-		if (i != sizeof(copy))
-			printk(KERN_ERR "new_mm : /proc/mm copy_segments "
-			       "failed, err = %d\n", -i);
-	}
-
-	if (!ptrace_ldt) {
-		/*
-		 * Our local LDT is used to supply the data for
-		 * modify_ldt(READLDT), if PTRACE_LDT isn't available,
-		 * i.e., we have to use the stub for modify_ldt, which
-		 * can't handle the big read buffer of up to 64kB.
-		 */
-		mutex_lock(&from_mm->arch.ldt.lock);
-		if (from_mm->arch.ldt.entry_count <= LDT_DIRECT_ENTRIES)
-			memcpy(new_mm->arch.ldt.u.entries, from_mm->arch.ldt.u.entries,
-			       sizeof(new_mm->arch.ldt.u.entries));
-		else {
-			i = from_mm->arch.ldt.entry_count / LDT_ENTRIES_PER_PAGE;
-			while (i-->0) {
-				page = __get_free_page(GFP_KERNEL|__GFP_ZERO);
-				if (!page) {
-					err = -ENOMEM;
-					break;
-				}
-				new_mm->arch.ldt.u.pages[i] =
-					(struct ldt_entry *) page;
-				memcpy(new_mm->arch.ldt.u.pages[i],
-				       from_mm->arch.ldt.u.pages[i], PAGE_SIZE);
+	/*
+	 * Our local LDT is used to supply the data for
+	 * modify_ldt(READLDT), if PTRACE_LDT isn't available,
+	 * i.e., we have to use the stub for modify_ldt, which
+	 * can't handle the big read buffer of up to 64kB.
+	 */
+	mutex_lock(&from_mm->arch.ldt.lock);
+	if (from_mm->arch.ldt.entry_count <= LDT_DIRECT_ENTRIES)
+		memcpy(new_mm->arch.ldt.u.entries, from_mm->arch.ldt.u.entries,
+		       sizeof(new_mm->arch.ldt.u.entries));
+	else {
+		i = from_mm->arch.ldt.entry_count / LDT_ENTRIES_PER_PAGE;
+		while (i-->0) {
+			page = __get_free_page(GFP_KERNEL|__GFP_ZERO);
+			if (!page) {
+				err = -ENOMEM;
+				break;
 			}
+			new_mm->arch.ldt.u.pages[i] =
+				(struct ldt_entry *) page;
+			memcpy(new_mm->arch.ldt.u.pages[i],
+			       from_mm->arch.ldt.u.pages[i], PAGE_SIZE);
 		}
-		new_mm->arch.ldt.entry_count = from_mm->arch.ldt.entry_count;
-		mutex_unlock(&from_mm->arch.ldt.lock);
 	}
+	new_mm->arch.ldt.entry_count = from_mm->arch.ldt.entry_count;
+	mutex_unlock(&from_mm->arch.ldt.lock);
 
     out:
 	return err;
@@ -488,7 +357,7 @@ void free_ldt(struct mm_context *mm)
 {
 	int i;
 
-	if (!ptrace_ldt && mm->arch.ldt.entry_count > LDT_DIRECT_ENTRIES) {
+	if (mm->arch.ldt.entry_count > LDT_DIRECT_ENTRIES) {
 		i = mm->arch.ldt.entry_count / LDT_ENTRIES_PER_PAGE;
 		while (i-- > 0)
 			free_page((long) mm->arch.ldt.u.pages[i]);
diff --git a/arch/x86/um/shared/sysdep/faultinfo_32.h b/arch/x86/um/shared/sysdep/faultinfo_32.h
index a26086b..b6f2437 100644
--- a/arch/x86/um/shared/sysdep/faultinfo_32.h
+++ b/arch/x86/um/shared/sysdep/faultinfo_32.h
@@ -27,9 +27,6 @@ struct faultinfo {
 /* This is Page Fault */
 #define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
 
-/* SKAS3 has no trap_no on i386, but get_skas_faultinfo() sets it to 0. */
-#define SEGV_MAYBE_FIXABLE(fi)	((fi)->trap_no == 0 && ptrace_faultinfo)
-
 #define PTRACE_FULL_FAULTINFO 0
 
 #endif
diff --git a/arch/x86/um/shared/sysdep/faultinfo_64.h b/arch/x86/um/shared/sysdep/faultinfo_64.h
index f811cbe..ee88f88 100644
--- a/arch/x86/um/shared/sysdep/faultinfo_64.h
+++ b/arch/x86/um/shared/sysdep/faultinfo_64.h
@@ -27,9 +27,6 @@ struct faultinfo {
 /* This is Page Fault */
 #define SEGV_IS_FIXABLE(fi)	((fi)->trap_no == 14)
 
-/* No broken SKAS API, which doesn't pass trap_no, here. */
-#define SEGV_MAYBE_FIXABLE(fi)	0
-
 #define PTRACE_FULL_FAULTINFO 1
 
 #endif
diff --git a/arch/x86/um/shared/sysdep/skas_ptrace.h b/arch/x86/um/shared/sysdep/skas_ptrace.h
deleted file mode 100644
index 453febe..0000000
--- a/arch/x86/um/shared/sysdep/skas_ptrace.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SYSDEP_X86_SKAS_PTRACE_H
-#define __SYSDEP_X86_SKAS_PTRACE_H
-
-struct ptrace_faultinfo {
-        int is_write;
-        unsigned long addr;
-};
-
-struct ptrace_ldt {
-        int func;
-        void *ptr;
-        unsigned long bytecount;
-};
-
-#define PTRACE_LDT 54
-
-#endif
-- 
1.8.4.5


------------------------------------------------------------------------------
Dive into the World of Parallel Programming The Go Parallel Website, sponsored
by Intel and developed in partnership with Slashdot Media, is your hub for all
things parallel software development, from weekly thought leadership blogs to
news, videos, case studies, tutorials and more. Take a look and join the 
conversation now. http://goparallel.sourceforge.net/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

