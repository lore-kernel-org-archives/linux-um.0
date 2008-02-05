Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Tue, 5 Feb 2008 11:46:24 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080205164624.GA7845@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 0/11] SKAS4
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

Major changes since version 4 -
	Fiddled the switch_mm interface, simplifying the
implementation, its users, and the architecture hooks
	userspace registers are now encapsulated in struct user_regs,
which will include FP registers as well
	Fixed a skas4 detection bug

Major changes since version 3 -
	Rebased on 2.6.24
	Removed some unused options to new_mm and switch_mm

Major changes since version 2 -
	Rebased on rc8
	Code cleanup
		mmfs.c moved to mm
		arch-specific code is moved to arch
		mm refcounting fixed

Major changes since version 1 -
	32-bit compatibility - 32-bit skas4 guests run on skas4 hosts
	testing of host PTRACE_GETSIGINFO support

A full rolled-up patch is appended to this message.

These patches implement host and guest SKAS4 support for both 32- and
64-bit x86, plus 32-bit compatibility.

I think the new interfaces here are much more acceptable than those in
SKAS3, so I'm going to push this to mainline.

What's new:
    two new system calls -
	new_mm - creates a new address space and returns a file
descriptor referencing it
	switch_mm - moves the calling process to the address space
referenced by the file descriptor passed to it

    /proc/<pid>/mm - opening this gives you a file descriptor
referencing the address space occupied by the given pid - this
descriptor can be given to switch_mm just as a new_mm descriptor can

    PTRACE_SWITCH_MM - same as with SKAS3, causes the child process to
switch from its current address space to a different one

    siginfo_t extensions - siginfo_t always contained the faulting
address in the SIGSEGV case.  However, for it to be useful to UML, it
needs the CPU trap number and error code.  There already was
conditional support for the trap number, which x86 didn't implement.
This is enabled, and support for passing out the error code is added.

How this compares to skas3:

Creating a new address space:
    skas3 - open /proc/mm
    skas4 - new_mm()

Remapping pages within another address space
    skas3 - write a structure desribing the change to a /proc/mm
descriptor
    skas4 - switch_mm to the address space, run the necessary system
calls directly, switch_mm back to the UML kernel address space

Getting page fault information from a process
    skas3 - PTRACE_FAULTINFO
    skas4 - PTRACE_GETSIGINFO

This patchset contains 11 patches.  Four of them contain the siginfo
extension, guest siginfo support, host new_mm/switch_mm support, and
guest new_mm/switch_mm support.  The rest are preparation patches
which shouldn't change anything functionally, but which make the four
functional patches smaller and easier to read.

These are against 2.6.24.  Build both host and guest from the same
tree.  I will be tweaking the interfaces in incompatible ways, so if
you play with future versions of this patchset, throw this one out.
Definitely don't try to boot a guest built from one version on a host
built from another.  It will work, but likely you'll get skas0, as
there will likely be some interface change which causes the host skas4
checks to fail.

This is very experimental at this point.  Don't let it near anything
resembling a production system.

				Jeff

-- 
Work email - jdike at linux dot intel dot com


diff --git a/arch/um/include/as-layout.h b/arch/um/include/as-layout.h
index a5cdf95..90ee798 100644
--- a/arch/um/include/as-layout.h
+++ b/arch/um/include/as-layout.h
@@ -17,6 +17,7 @@
 #define ASM_STUB_CODE (UML_CONFIG_TOP_ADDR - 2 * UM_KERN_PAGE_SIZE)
 #define ASM_STUB_DATA (UML_CONFIG_TOP_ADDR - UM_KERN_PAGE_SIZE)
 #define ASM_STUB_START ASM_STUB_CODE
+#define ASM_STUB_END UML_CONFIG_TOP_ADDR
 
 /*
  * This file is included by the assembly stubs, which just want the
@@ -27,6 +28,7 @@
 #define STUB_CODE ((unsigned long) ASM_STUB_CODE)
 #define STUB_DATA ((unsigned long) ASM_STUB_DATA)
 #define STUB_START ((unsigned long) ASM_STUB_START)
+#define STUB_END ((unsigned long) ASM_STUB_END)
 
 #include "sysdep/ptrace.h"
 
diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 6f0d1c7..f1c26f5 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -168,7 +168,7 @@ extern int os_fchange_dir(int fd);
 
 /* start_up.c */
 extern void os_early_checks(void);
-extern int can_do_skas(void);
+extern void can_do_skas(void);
 extern void os_check_bugs(void);
 extern void check_host_supports_tls(int *supports_tls, int *tls_min);
 
diff --git a/arch/um/include/siginfo_segv.h b/arch/um/include/siginfo_segv.h
new file mode 100644
index 0000000..c000267
--- /dev/null
+++ b/arch/um/include/siginfo_segv.h
@@ -0,0 +1,133 @@
+/*
+ * Copyright (C) 2002- 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __SIGINFO_SIGSEGV_H_
+#define __SIGINFO_SIGSEGV_H_
+
+/*
+ * Provide signal.h, except for replacing siginfo_t with one that has
+ * the CPU trap number and error code in the SIGSEGV case.
+ */
+
+#include <time.h>
+
+/* Rename the signal.h siginfo and siginfo_t out of the way */
+#define siginfo old_siginfo
+#define siginfo_t old_siginfo_t
+
+#include <signal.h>
+
+#undef siginfo
+#undef siginfo_t
+
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
+
+/* The new siginfo_t, plus associated definitions */
+
+/*
+ * This is the size (including padding) of the part of the
+ * struct siginfo that is before the union.
+ */
+#ifndef __ARCH_SI_PREAMBLE_SIZE
+#define __ARCH_SI_PREAMBLE_SIZE	(3 * sizeof(int))
+#endif
+
+#define SI_MAX_SIZE	128
+#ifndef SI_PAD_SIZE
+#define SI_PAD_SIZE	((SI_MAX_SIZE - __ARCH_SI_PREAMBLE_SIZE) / sizeof(int))
+#endif
+
+#ifndef __ARCH_SI_UID_T
+#define __ARCH_SI_UID_T	uid_t
+#endif
+
+/*
+ * The default "si_band" type is "long", as specified by POSIX.
+ * However, some architectures want to override this to "int"
+ * for historical compatibility reasons, so we allow that.
+ */
+#ifndef __ARCH_SI_BAND_T
+#define __ARCH_SI_BAND_T long
+#endif
+
+#define __user
+
+typedef struct siginfo {
+	int si_signo;
+	int si_errno;
+	int si_code;
+
+	union {
+		int _pad[SI_PAD_SIZE];
+
+		/* kill() */
+		struct {
+			pid_t _pid;		/* sender's pid */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
+		} _kill;
+
+		/* POSIX.1b timers */
+		struct {
+			timer_t _tid;		/* timer id */
+			int _overrun;		/* overrun count */
+			char _pad[sizeof( __ARCH_SI_UID_T) - sizeof(int)];
+			sigval_t _sigval;	/* same as below */
+			int _sys_private;       /* not to be passed to user */
+		} _timer;
+
+		/* POSIX.1b signals */
+		struct {
+			pid_t _pid;		/* sender's pid */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
+			sigval_t _sigval;
+		} _rt;
+
+		/* SIGCHLD */
+		struct {
+			pid_t _pid;		/* which child */
+			__ARCH_SI_UID_T _uid;	/* sender's uid */
+			int _status;		/* exit code */
+			clock_t _utime;
+			clock_t _stime;
+		} _sigchld;
+
+		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
+		struct {
+			void __user *_addr; /* faulting insn/memory ref. */
+#ifdef __ARCH_SI_TRAPNO
+			int _trapno;	/* TRAP # which caused the signal */
+#endif
+#ifdef __ARCH_SI_ERROR
+			int _error;	/* CPU error code */
+#endif
+		} _sigfault;
+
+		/* SIGPOLL */
+		struct {
+			__ARCH_SI_BAND_T _band;	/* POLL_IN, POLL_OUT, POLL_MSG */
+			int _fd;
+		} _sigpoll;
+	} _sifields;
+} siginfo_t;
+
+#ifdef __ARCH_SI_TRAPNO
+#define si_trapno	_sifields._sigfault._trapno
+#endif
+#ifdef __ARCH_SI_ERROR
+#define si_error	_sifields._sigfault._error
+#endif
+
+#undef si_addr
+#define si_addr	_sifields._sigfault._addr
+
+#define GET_FAULTINFO_FROM_SI(fi, si) \
+	{ \
+		(fi).cr2 = (unsigned long) (si).si_addr; \
+		(fi).error_code = (si).si_error; \
+		(fi).trap_no = (si).si_trapno; \
+	}
+
+#endif
diff --git a/arch/um/include/skas/mm_id.h b/arch/um/include/skas/mm_id.h
index 48dd098..a2e7643 100644
--- a/arch/um/include/skas/mm_id.h
+++ b/arch/um/include/skas/mm_id.h
@@ -7,7 +7,7 @@
 #define __MM_ID_H
 
 struct mm_id {
-	union {
+	struct {
 		int mm_fd;
 		int pid;
 	} u;
diff --git a/arch/um/include/skas/skas.h b/arch/um/include/skas/skas.h
index b073f8a..6cc9e2a 100644
--- a/arch/um/include/skas/skas.h
+++ b/arch/um/include/skas/skas.h
@@ -6,18 +6,72 @@
 #ifndef __SKAS_H
 #define __SKAS_H
 
+#ifndef __KERNEL__
+#include <unistd.h>
+#include <sys/syscall.h>
+#endif
+#include "uml-config.h"
+
+#ifdef UML_CONFIG_X86_32
+#define __NR_new_mm             325
+#define __NR_switch_mm          326
+#else
+#define __NR_new_mm             286
+#define __NR_switch_mm          287
+#endif
+
+#define PTRACE_SWITCH_MM 33
+
+#ifndef __ASSEMBLY__
+
 #include "sysdep/ptrace.h"
 
+#define STUB_ADDR(x) (STUB_CODE + (unsigned long) (x) - \
+		      (unsigned long) &__syscall_stub_start)
+
 extern int userspace_pid[];
 extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
 extern int skas_needs_stub;
 
+extern int have_switch_mm;
+extern int have_ptrace_switch_mm;
+extern int have_siginfo_segv;
+extern int self_mm_fd;
+
 extern int user_thread(unsigned long stack, int flags);
 extern void new_thread_handler(void);
 extern void handle_syscall(struct uml_pt_regs *regs);
-extern int new_mm(unsigned long stack);
+extern int make_new_mm(unsigned long stack);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
 
+#ifndef __KERNEL__
+#include <errno.h>
+
+static inline long new_mm(void)
+{
+	int ret = syscall(__NR_new_mm, 0, 0, 0, 0, 0, 0);
+
+	if (ret < 0)
+		return -errno;
+
+	return ret;
+}
+
+static inline long switch_mm(int mm_fd, unsigned long *save_regs,
+			     unsigned long *new_regs, unsigned long ip,
+			     unsigned long sp)
+{
+	int ret = syscall(__NR_switch_mm, mm_fd, save_regs, new_regs, ip, sp, 0);
+
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+#endif
+
+#endif
+
 #endif
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
index 47b57b4..25721bf 100644
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
 
@@ -292,3 +292,14 @@ void syscall_trace(struct uml_pt_regs *regs, int entryexit)
 		current->exit_code = 0;
 	}
 }
+
+int ptrace_to_pt_regs(struct pt_regs *to, struct user_regs __user *from)
+{
+	memcpy(to, &from->regs, sizeof(from->regs));
+	return 0;
+}
+
+int pt_regs_to_ptrace(struct user_regs __user *to, struct pt_regs *from)
+{
+	return copy_to_user(&to->regs, &from->regs.gp, sizeof(from->regs.gp));
+}
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 04cebcf..0a5468e 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -11,7 +11,7 @@ void (*pm_power_off)(void);
 
 static void kill_off_processes(void)
 {
-	if(proc_mm)
+	if(proc_mm || have_switch_mm)
 		/*
 		 * FIXME: need to loop over userspace_pids
 		 */
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index f859ec3..2672829 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -65,6 +65,9 @@ static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
 	return -ENOMEM;
 }
 
+extern int copy_context_skas4(struct mm_id *id);
+extern int get_new_mm(void);
+
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
  	struct mm_context *from_mm = NULL;
@@ -101,14 +104,28 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		from_mm = &current->mm->context;
 
 	if (proc_mm) {
-		ret = new_mm(stack);
+		ret = make_new_mm(stack);
 		if (ret < 0) {
 			printk(KERN_ERR "init_new_context_skas - "
-			       "new_mm failed, errno = %d\n", ret);
+			       "make_new_mm failed, errno = %d\n", ret);
 			goto out_free;
 		}
 		to_mm->id.u.mm_fd = ret;
 	}
+	else if (have_switch_mm) {
+		to_mm->id.u.mm_fd = get_new_mm();
+		if(to_mm->id.u.mm_fd < 0) {
+			ret = to_mm->id.u.mm_fd;
+			goto out_free;
+		}
+
+		ret = copy_context_skas4(&to_mm->id);
+		if (ret < 0) {
+			os_close_file(to_mm->id.u.mm_fd);
+			to_mm->id.u.mm_fd = -1;
+			goto out_free;
+		}
+	}
 	else {
 		if (from_mm)
 			to_mm->id.u.pid = copy_context_skas0(stack,
@@ -136,11 +153,15 @@ void destroy_context(struct mm_struct *mm)
 {
 	struct mm_context *mmu = &mm->context;
 
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		os_close_file(mmu->id.u.mm_fd);
-	else
+	else {
 		os_kill_ptraced_process(mmu->id.u.pid, 1);
 
+		if (have_switch_mm)
+			os_close_file(mmu->id.u.mm_fd);
+	}
+
 	if (!proc_mm || !ptrace_faultinfo) {
 		free_page(mmu->id.stack);
 		pte_lock_deinit(virt_to_page(mmu->last_page_table));
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index fce389c..e5e8613 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -9,7 +9,7 @@
 #include "os.h"
 #include "skas.h"
 
-int new_mm(unsigned long stack)
+int make_new_mm(unsigned long stack)
 {
 	int fd;
 
@@ -49,7 +49,7 @@ int __init start_uml(void)
 {
 	stack_protections((unsigned long) &cpu0_irqstack);
 	set_sigstack(cpu0_irqstack, THREAD_SIZE);
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		userspace_pid[0] = start_userspace(0);
 
 	init_new_thread_signals();
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index b9d92b2..9e6c11a 100644
--- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -151,3 +151,13 @@ int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 
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
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index f1c7139..d92108b 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -271,7 +271,9 @@ int __init linux_main(int argc, char **argv)
 
 	can_do_skas();
 
-	if (proc_mm && ptrace_faultinfo)
+	if (have_switch_mm)
+		mode = "SKAS4";
+	else if (proc_mm && ptrace_faultinfo)
 		mode = "SKAS3";
 	else
 		mode = "SKAS0";
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 484e68f..19ff668 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -6,6 +6,7 @@
 #include <stddef.h>
 #include <unistd.h>
 #include <errno.h>
+#include <signal.h>
 #include <string.h>
 #include <sys/mman.h>
 #include "init.h"
@@ -22,7 +23,7 @@
 #include "sysdep/stub.h"
 #include "uml-config.h"
 
-extern unsigned long batch_syscall_stub, __syscall_stub_start;
+extern unsigned long batch_syscall_stub, switch_mm_stub, __syscall_stub_start;
 
 extern void wait_stub_done(int pid);
 
@@ -41,34 +42,63 @@ static unsigned long syscall_regs[MAX_REG_NR];
 static int __init init_syscall_regs(void)
 {
 	get_safe_registers(syscall_regs);
-	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
-		((unsigned long) &batch_syscall_stub -
-		 (unsigned long) &__syscall_stub_start);
+
+	syscall_regs[REGS_IP_INDEX] = STUB_ADDR(&batch_syscall_stub);
 	return 0;
 }
 
 __initcall(init_syscall_regs);
 
-extern int proc_mm;
+static int syscall_stub_done(unsigned long stack)
+{
+	unsigned long *syscall, *data, offset;
+	int ret, n;
 
-int single_count = 0;
-int multi_count = 0;
-int multi_op_count = 0;
+	/*
+	 * When the stub stops, we find the following values on the
+	 * beginning of the stack:
+	 * (long) return_value
+	 * (long) offset to failed sycall data (0 if no error)
+	 */
+	ret = *((unsigned long *) stack);
+	offset = *((unsigned long *) stack + 1);
+	if (offset == 0)
+		return 0;
 
-static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
+	data = (unsigned long *)(stack + offset - STUB_DATA);
+	printk(UM_KERN_ERR "syscall_stub_done : ret = %d, offset = %ld, "
+	       "data = %p\n", ret, offset, data);
+	syscall = (unsigned long *)((unsigned long)data + data[0]);
+	printk(UM_KERN_ERR "syscall_stub_done : syscall %ld failed, "
+	       "return value = 0x%x, expected return value = 0x%lx\n",
+	       syscall[0], ret, syscall[7]);
+	printk(UM_KERN_ERR "    syscall parameters: "
+	       "0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
+	       syscall[1], syscall[2], syscall[3],
+	       syscall[4], syscall[5], syscall[6]);
+	for (n = 1; n < data[0]/sizeof(long); n++) {
+		if (n == 1)
+			printk(UM_KERN_ERR "    additional syscall "
+			       "data:");
+		if (n % 4 == 1)
+			printk("\n" UM_KERN_ERR "      ");
+		printk("  0x%lx", data[n]);
+	}
+	if (n > 1)
+		printk("\n");
+
+	return ret;
+}
+
+static long do_syscall_stub(struct mm_id *mm_idp, void **addr)
 {
-	int n, i;
-	long ret, offset;
-	unsigned long * data;
-	unsigned long * syscall;
-	int err, pid = mm_idp->u.pid;
+	long ret;
+	int n, i, err, pid = mm_idp->u.pid;
 
 	if (proc_mm)
 		/* FIXME: Need to look up userspace_pid by cpu */
 		pid = userspace_pid[0];
 
-	multi_count++;
-
 	n = ptrace_setregs(pid, syscall_regs);
 	if (n < 0) {
 		printk(UM_KERN_ERR "Registers - \n");
@@ -85,52 +115,71 @@ static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 
 	wait_stub_done(pid);
 
-	/*
-	 * When the stub stops, we find the following values on the
-	 * beginning of the stack:
-	 * (long )return_value
-	 * (long )offset to failed sycall-data (0, if no error)
-	 */
-	ret = *((unsigned long *) mm_idp->stack);
-	offset = *((unsigned long *) mm_idp->stack + 1);
-	if (offset) {
-		data = (unsigned long *)(mm_idp->stack + offset - STUB_DATA);
-		printk(UM_KERN_ERR "do_syscall_stub : ret = %ld, offset = %ld, "
-		       "data = %p\n", ret, offset, data);
-		syscall = (unsigned long *)((unsigned long)data + data[0]);
-		printk(UM_KERN_ERR "do_syscall_stub: syscall %ld failed, "
-		       "return value = 0x%lx, expected return value = 0x%lx\n",
-		       syscall[0], ret, syscall[7]);
-		printk(UM_KERN_ERR "    syscall parameters: "
-		       "0x%lx 0x%lx 0x%lx 0x%lx 0x%lx 0x%lx\n",
-		       syscall[1], syscall[2], syscall[3],
-		       syscall[4], syscall[5], syscall[6]);
-		for (n = 1; n < data[0]/sizeof(long); n++) {
-			if (n == 1)
-				printk(UM_KERN_ERR "    additional syscall "
-				       "data:");
-			if (n % 4 == 1)
-				printk("\n" UM_KERN_ERR "      ");
-			printk("  0x%lx", data[n]);
-		}
-		if (n > 1)
-			printk("\n");
-	}
-	else ret = 0;
+	ret = syscall_stub_done(mm_idp->stack);
+
+	*addr = check_init_stack(mm_idp, NULL);
+
+	return ret;
+}
+
+long do_syscall_stub_skas4(struct mm_id *mm_idp, void **addr, unsigned long ip,
+			   unsigned long sp)
+{
+	long ret;
+	unsigned long return_regs[MAX_REG_NR], *ptr;
+	int err;
+	sigset_t sigs, old;
+
+	ptr = (unsigned long *) (mm_idp->stack + UM_KERN_PAGE_SIZE -
+				 sizeof(long));
+	*ptr = (unsigned long) return_regs;
+	*(ptr - 1) = self_mm_fd;
+
+	sigfillset(&sigs);
+	sigprocmask(SIG_SETMASK, &sigs, &old);
+	err = switch_mm(mm_idp->u.mm_fd, return_regs, NULL, ip, sp);
+	sigprocmask(SIG_SETMASK, &old, NULL);
+
+	ret = syscall_stub_done(mm_idp->stack);
 
 	*addr = check_init_stack(mm_idp, NULL);
 
 	return ret;
 }
 
-long run_syscall_stub(struct mm_id * mm_idp, int syscall,
+static int flush_syscalls(struct mm_id *mm_idp, void **addr, int extra)
+{
+	unsigned long *stack = check_init_stack(mm_idp, *addr);
+	int current, end;
+
+	current = ((unsigned long) stack) & ~UM_KERN_PAGE_MASK;
+	end = UM_KERN_PAGE_SIZE;
+
+	if(have_switch_mm)
+		end -= 2 * sizeof(long);
+
+	if (current + (10 + extra) * sizeof(long) < end)
+		return 0;
+
+	if (have_switch_mm)
+		return do_syscall_stub_skas4(mm_idp, addr,
+					     STUB_ADDR(&switch_mm_stub), 0);
+	else
+		return do_syscall_stub(mm_idp, addr);
+}
+
+long run_syscall_stub(struct mm_id *mm_idp, int syscall,
 		      unsigned long *args, long expected, void **addr,
 		      int done)
 {
-	unsigned long *stack = check_init_stack(mm_idp, *addr);
+	unsigned long *stack;
+	int ret;
 
-	if (done && *addr == NULL)
-		single_count++;
+	ret = flush_syscalls(mm_idp, addr, 0);
+	if (ret)
+		return ret;
+
+	stack = check_init_stack(mm_idp, *addr);
 
 	*stack += sizeof(long);
 	stack += *stack / sizeof(long);
@@ -144,45 +193,39 @@ long run_syscall_stub(struct mm_id * mm_idp, int syscall,
 	*stack++ = args[5];
 	*stack++ = expected;
 	*stack = 0;
-	multi_op_count++;
 
-	if (!done && ((((unsigned long) stack) & ~UM_KERN_PAGE_MASK) <
-		     UM_KERN_PAGE_SIZE - 10 * sizeof(long))) {
+	if (!done) {
 		*addr = stack;
 		return 0;
 	}
 
-	return do_syscall_stub(mm_idp, addr);
+	if (have_switch_mm)
+		return do_syscall_stub_skas4(mm_idp, addr,
+					     STUB_ADDR(&switch_mm_stub), 0);
+	else
+		return do_syscall_stub(mm_idp, addr);
+
+	*addr = stack;
+	return 0;
 }
 
-long syscall_stub_data(struct mm_id * mm_idp,
-		       unsigned long *data, int data_count,
-		       void **addr, void **stub_addr)
+long syscall_stub_data(struct mm_id *mm_idp, unsigned long *data,
+		       int data_count, void **addr, void **stub_addr)
 {
 	unsigned long *stack;
-	int ret = 0;
+	int ret;
 
-	/*
-	 * If *addr still is uninitialized, it *must* contain NULL.
-	 * Thus in this case do_syscall_stub correctly won't be called.
-	 */
-	if ((((unsigned long) *addr) & ~UM_KERN_PAGE_MASK) >=
-	   UM_KERN_PAGE_SIZE - (10 + data_count) * sizeof(long)) {
-		ret = do_syscall_stub(mm_idp, addr);
-		/* in case of error, don't overwrite data on stack */
-		if (ret)
-			return ret;
-	}
+	ret = flush_syscalls(mm_idp, addr, data_count);
+	if (ret)
+		return ret;
 
 	stack = check_init_stack(mm_idp, *addr);
-	*addr = stack;
-
-	*stack = data_count * sizeof(long);
+	*stack++ = data_count * sizeof(long);
 
-	memcpy(stack + 1, data, data_count * sizeof(long));
+	memcpy(stack, data, data_count * sizeof(long));
 
-	*stub_addr = (void *)(((unsigned long)(stack + 1) &
-			       ~UM_KERN_PAGE_MASK) + STUB_DATA);
+	*stub_addr = (void *)(((unsigned long) stack & ~UM_KERN_PAGE_MASK) +
+			      STUB_DATA);
 
 	return 0;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index e8b7a97..d4da448 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -3,6 +3,9 @@
  * Licensed under the GPL
  */
 
+/* Include this first, before anything else includes <signal.h> */
+#include "siginfo_segv.h"
+
 #include <stdlib.h>
 #include <unistd.h>
 #include <sched.h>
@@ -91,11 +94,23 @@ bad_wait:
 
 extern unsigned long current_stub_stack(void);
 
+#ifndef PTRACE_GETSIGINFO
+#define PTRACE_GETSIGINFO	0x4202
+#endif
+
 void get_skas_faultinfo(int pid, struct faultinfo * fi)
 {
+	siginfo_t si;
 	int err;
 
-	if (ptrace_faultinfo) {
+	if(have_siginfo_segv){
+		err = ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
+		if(err)
+			printk("PTRACE_GETSIGINFO failed, err = %d\n", errno);
+
+		GET_FAULTINFO_FROM_SI(*fi, si);
+	}
+	else if (ptrace_faultinfo) {
 		err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
 		if (err)
 			panic("get_skas_faultinfo - PTRACE_FAULTINFO failed, "
@@ -212,12 +227,9 @@ static int userspace_tramp(void *stack)
 			}
 		}
 	}
-	if (!ptrace_faultinfo && (stack != NULL)) {
+	if (!ptrace_faultinfo) {
 		struct sigaction sa;
-
-		unsigned long v = STUB_CODE +
-				  (unsigned long) stub_segv_handler -
-				  (unsigned long) &__syscall_stub_start;
+		unsigned long v = STUB_ADDR(stub_segv_handler);
 
 		set_sigstack((void *) STUB_DATA, UM_KERN_PAGE_SIZE);
 		sigemptyset(&sa.sa_mask);
@@ -256,7 +268,7 @@ int start_userspace(unsigned long stub_stack)
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);
 
 	flags = CLONE_FILES;
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		flags |= CLONE_VM;
 	else
 		flags |= SIGCHLD;
@@ -369,8 +381,14 @@ void userspace(struct uml_pt_regs *regs)
 			        printk(UM_KERN_ERR "userspace - child stopped "
 				       "with signal %d\n", sig);
 			}
-			pid = userspace_pid[0];
+
+			/*
+			 * userspace_pid can change in in_interrupt since
+			 * PTRACE_SWITCH_MM can cause a process to change
+			 * address spaces
+			 */
 			interrupt_end();
+			pid = userspace_pid[0];
 
 			/* Avoid -ERESTARTSYS handling in host */
 			if (PT_SYSCALL_NR_OFFSET != PT_SYSCALL_RET_OFFSET)
@@ -385,9 +403,7 @@ static int __init init_thread_regs(void)
 {
 	get_safe_registers(thread_regs);
 	/* Set parent's instruction pointer to start of clone-stub */
-	thread_regs[REGS_IP_INDEX] = STUB_CODE +
-				(unsigned long) stub_clone_handler -
-				(unsigned long) &__syscall_stub_start;
+	thread_regs[REGS_IP_INDEX] = STUB_ADDR(stub_clone_handler);
 	thread_regs[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
 		sizeof(void *);
 #ifdef __SIGNAL_FRAMESIZE
@@ -458,6 +474,56 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	return pid;
 }
 
+extern unsigned long switch_mm_stub;
+extern long task_size;
+
+static void unmap_new_as(void)
+{
+	void (*p)(void);
+	void *addr;
+	unsigned long stack = (unsigned long) &stack & ~(UM_KERN_PAGE_SIZE - 1);
+	unsigned long long data_offset, code_offset;
+	int fd = phys_mapping(to_phys((void *) stack), &data_offset);
+
+	addr = mmap((void *) STUB_DATA, UM_KERN_PAGE_SIZE,
+		    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd,
+		    data_offset);
+	if (addr == MAP_FAILED)
+		panic("Failed to remap stack");
+
+	fd = phys_mapping(to_phys(&__syscall_stub_start), &code_offset);
+	addr = mmap((void *) STUB_CODE, UM_KERN_PAGE_SIZE,
+		    PROT_READ | PROT_WRITE, MAP_SHARED | MAP_FIXED, fd,
+		    code_offset);
+	if (addr == MAP_FAILED)
+		panic("Failed to remap code");
+
+	p = (void (*)(void)) (STUB_ADDR(&switch_mm_stub));
+	(*p)();
+}
+
+extern long do_syscall_stub_skas4(struct mm_id *mm_idp, void **addr,
+				  unsigned long ip, unsigned long sp);
+
+int copy_context_skas4(struct mm_id *id)
+{
+	void *data = NULL;
+	int err;
+
+	err = unmap(id, 0, STUB_START, 0, &data);
+	if (err)
+		return err;
+
+	if (STUB_END < task_size) {
+		err = unmap(id, STUB_END, task_size - STUB_END, 0, &data);
+		if (err)
+			return err;
+	}
+
+	return do_syscall_stub_skas4(id, &data, (unsigned long) unmap_new_as,
+				     id->stack + UM_KERN_PAGE_SIZE / 2);
+}
+
 /*
  * This is used only, if stub pages are needed, while proc_mm is
  * available. Opening /proc/mm creates a new mm_context, which lacks
@@ -612,11 +678,18 @@ void __switch_mm(struct mm_id *mm_idp)
 
 	/* FIXME: need cpu pid in __switch_mm */
 	if (proc_mm) {
-		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+		err = ptrace(OLD_PTRACE_SWITCH_MM, userspace_pid[0], 0,
 			     mm_idp->u.mm_fd);
 		if (err)
-			panic("__switch_mm - PTRACE_SWITCH_MM failed, "
+			panic("__switch_mm - OLD_PTRACE_SWITCH_MM failed, "
 			      "errno = %d\n", errno);
 	}
+	else if (have_ptrace_switch_mm) {
+		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+			     mm_idp->u.mm_fd);
+		if (err)
+			panic("__switch_mm - PTRACE_SWITCH_MM "
+ 			       "failed, errno = %d\n", errno);
+	}
 	else userspace_pid[0] = mm_idp->u.pid;
 }
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 7b81f6c..9e866b4 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -3,6 +3,9 @@
  * Licensed under the GPL
  */
 
+/* Include this first, before anything else includes <signal.h> */
+#include "siginfo_segv.h"
+
 #include <stdio.h>
 #include <stdlib.h>
 #include <stdarg.h>
@@ -23,7 +26,9 @@
 #include "mem_user.h"
 #include "ptrace_user.h"
 #include "registers.h"
+#include "skas.h"
 #include "skas_ptrace.h"
+#include "sysdep/sigcontext.h"
 
 static int ptrace_child(void)
 {
@@ -141,14 +146,36 @@ static int stop_ptraced_child(int pid, int exitcode, int mustexit)
 }
 
 /* Changed only during early boot */
-int ptrace_faultinfo = 1;
-int ptrace_ldt = 1;
-int proc_mm = 1;
-int skas_needs_stub = 0;
+int ptrace_faultinfo;
+static int disable_ptrace_faultinfo;
+
+int ptrace_ldt;
+static int disable_ptrace_ldt;
+
+int proc_mm;
+static int disable_proc_mm;
+
+int have_switch_mm;
+static int disable_switch_mm;
+
+int have_siginfo_segv;
+static int disable_siginfo_segv;
+
+int have_ptrace_switch_mm;
+static int disable_ptrace_switch_mm;
+
+int skas_needs_stub;
 
 static int __init skas0_cmd_param(char *str, int* add)
 {
-	ptrace_faultinfo = proc_mm = 0;
+	disable_ptrace_faultinfo = 1;
+	disable_ptrace_ldt = 1;
+	disable_proc_mm = 1;
+
+	disable_switch_mm = 1;
+	disable_siginfo_segv = 1;
+	disable_ptrace_switch_mm = 1;
+
 	return 0;
 }
 
@@ -158,15 +185,12 @@ static int __init mode_skas0_cmd_param(char *str, int* add)
 	__attribute__((alias("skas0_cmd_param")));
 
 __uml_setup("skas0", skas0_cmd_param,
-		"skas0\n"
-		"    Disables SKAS3 usage, so that SKAS0 is used, unless \n"
-	        "    you specify mode=tt.\n\n");
+"skas0\n"
+"    Disables SKAS3 and SKAS4 usage, so that SKAS0 is used\n\n");
 
 __uml_setup("mode=skas0", mode_skas0_cmd_param,
-		"mode=skas0\n"
-		"    Disables SKAS3 usage, so that SKAS0 is used, unless you \n"
-		"    specify mode=tt. Note that this was recently added - on \n"
-		"    older kernels you must use simply \"skas0\".\n\n");
+"mode=skas0\n"
+"    Disables SKAS3 and SKAS4 usage, so that SKAS0 is used.\n\n");
 
 /* Changed only during early boot */
 static int force_sysemu_disabled = 0;
@@ -341,6 +365,8 @@ static void __init check_coredump_limit(void)
 
 void __init os_early_checks(void)
 {
+	int pid;
+
 	/* Print out the core dump limits early */
 	check_coredump_limit();
 
@@ -350,11 +376,15 @@ void __init os_early_checks(void)
 	 * kernel is running.
 	 */
 	check_tmpexec();
+
+	pid = start_ptraced_child();
+	init_registers(pid);
+	stop_ptraced_child(pid, 1, 1);
 }
 
 static int __init noprocmm_cmd_param(char *str, int* add)
 {
-	proc_mm = 0;
+	disable_proc_mm = 1;
 	return 0;
 }
 
@@ -366,7 +396,7 @@ __uml_setup("noprocmm", noprocmm_cmd_param,
 
 static int __init noptracefaultinfo_cmd_param(char *str, int* add)
 {
-	ptrace_faultinfo = 0;
+	disable_ptrace_faultinfo = 1;
 	return 0;
 }
 
@@ -378,7 +408,7 @@ __uml_setup("noptracefaultinfo", noptracefaultinfo_cmd_param,
 
 static int __init noptraceldt_cmd_param(char *str, int* add)
 {
-	ptrace_ldt = 0;
+	disable_ptrace_ldt = 1;
 	return 0;
 }
 
@@ -398,20 +428,18 @@ static inline void check_skas3_ptrace_faultinfo(void)
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
 	if (n < 0) {
-		ptrace_faultinfo = 0;
 		if (errno == EIO)
 			non_fatal("not found\n");
 		else
 			perror("not found");
 	}
+	else if (disable_ptrace_faultinfo)
+		non_fatal("found but disabled on command line\n");
 	else {
-		if (!ptrace_faultinfo)
-			non_fatal("found but disabled on command line\n");
-		else
-			non_fatal("found\n");
+		ptrace_faultinfo = 1;
+		non_fatal("found\n");
 	}
 
-	init_registers(pid);
 	stop_ptraced_child(pid, 1, 1);
 }
 
@@ -435,38 +463,32 @@ static inline void check_skas3_ptrace_ldt(void)
 		else {
 			perror("not found");
 		}
-		ptrace_ldt = 0;
 	}
+	else if (disable_ptrace_ldt)
+		non_fatal("found, but use is disabled\n");
 	else {
-		if (ptrace_ldt)
-			non_fatal("found\n");
-		else
-			non_fatal("found, but use is disabled\n");
+		ptrace_ldt = 1;
+		non_fatal("found\n");
 	}
 
 	stop_ptraced_child(pid, 1, 1);
-#else
-	/* PTRACE_LDT might be disabled via cmdline option.
-	 * We want to override this, else we might use the stub
-	 * without real need
-	 */
-	ptrace_ldt = 1;
 #endif
 }
 
 static inline void check_skas3_proc_mm(void)
 {
 	non_fatal("  - /proc/mm...");
-	if (access("/proc/mm", W_OK) < 0) {
-		proc_mm = 0;
+	if (access("/proc/mm", W_OK) < 0)
 		perror("not found");
-	}
-	else if (!proc_mm)
+	else if (disable_proc_mm)
 		non_fatal("found but disabled on command line\n");
-	else non_fatal("found\n");
+	else {
+		proc_mm = 1;
+		non_fatal("found\n");
+	}
 }
 
-int can_do_skas(void)
+static void can_do_skas3(void)
 {
 	non_fatal("Checking for the skas3 patch in the host:\n");
 
@@ -476,8 +498,338 @@ int can_do_skas(void)
 
 	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
 		skas_needs_stub = 1;
+}
+
+static void *fault_address;
+
+static int check_fault_info(struct faultinfo *fi)
+{
+	return (FAULT_ADDRESS(*fi) == (unsigned long) fault_address) &&
+		FAULT_WRITE(*fi) && SEGV_IS_FIXABLE(fi);
+}
+
+static jmp_buf siginfo_buf;
+
+static void segv_handler(int sig, siginfo_t *si, void *foo)
+{
+	struct faultinfo fi;
+	int n;
+
+	GET_FAULTINFO_FROM_SI(fi, *si);
+	n = check_fault_info(&fi) ? 1 : 2;
+	longjmp(siginfo_buf, n);
+}
+
+static int fault(void)
+{
+	struct sigaction sa, old;
+	int err, n;
+
+	/*
+	 * The cast is needed because the CPP manipulations of
+	 * siginfo_t resulted in sa_sigaction having an old_siginfo_t
+	 * parameter.
+	 */
+	sa.sa_sigaction = (void (*)(int, old_siginfo_t *, void *)) segv_handler;
+	sigemptyset(&sa.sa_mask);
+	sa.sa_flags = SA_SIGINFO | SA_NODEFER;
+
+	err = sigaction(SIGSEGV, &sa, &old);
+	if (err)
+		fatal_perror("sigaction");
+
+	/*
+	 * Provide a guaranteed invalid address by mapping a page into
+	 * a hole in the address space and then unmapping it.
+	 */
+	fault_address = mmap(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if (fault_address == MAP_FAILED)
+		fatal_perror("mmap failed");
+
+	if (munmap(fault_address, UM_KERN_PAGE_SIZE) < 0)
+		fatal_perror("munmap failed");
+
+	n = setjmp(siginfo_buf);
+	if (n == 0)
+		*((unsigned long *) fault_address) = 0;
+
+	err = sigaction(SIGSEGV, &old, NULL);
+
+	return n;
+}
+
+static int __init nogetsiginfo_cmd_param(char *str, int *add)
+{
+	disable_siginfo_segv = 1;
+	return 0;
+}
+
+__uml_setup("nogetsiginfo", nogetsiginfo_cmd_param,
+"nogetsiginfo\n"
+"    Turns off usage of PTRACE_GETSIGINFO to read page fault information\n"
+"    from a child process, even if the host supports it.\n\n");
+
+#ifndef PTRACE_GETSIGINFO
+#define PTRACE_GETSIGINFO	0x4202
+#endif
+
+static int check_siginfo(void)
+{
+	siginfo_t si;
+	struct faultinfo fi;
+	int ok, pid, err, status;
+
+	non_fatal("\tFull CPU fault information in siginfo_t ... ");
+	ok = fault();
+	if (ok)
+		non_fatal("OK\n");
+	else {
+		non_fatal("Failed\n");
+		return 0;
+	}
+
+	non_fatal("\tFull CPU fault information in PTRACE_GETSIGINFO ... ");
+
+	pid = fork();
+	if (pid < 0)
+		fatal_perror("fork failed");
+	else if (pid == 0) {
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+		fault();
+		exit(1);
+	}
+
+	while(1){
+		err = waitpid(pid, &status, WUNTRACED);
+		if (err < 0)
+			fatal_perror("wait failed");
+
+		if (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGSEGV))
+			break;
+	}
+
+	err = ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
+	if (err < 0)
+		fatal_perror("PTRACE_GETSIGINFO failed");
+
+	ptrace(PTRACE_KILL, pid, 0, 0);
+
+	GET_FAULTINFO_FROM_SI(fi, si);
+	ok = check_fault_info(&fi);
+	if (ok)
+		non_fatal("OK\n");
+	else
+		non_fatal("Failed\n");
+
+	if (disable_siginfo_segv)
+		non_fatal("Extended PTRACE_GETSIGINFO disabled on command "
+			  "line");
+	else
+		have_siginfo_segv = 1;
+
+	return ok;
+}
+
+static char *mm_stack;
+static unsigned long return_regs[MAX_REG_NR];
+int self_mm_fd;
+
+static int switch_mm_works;
+
+static void after_switch(void)
+{
+	/*
+	 * If we are really in a new address space, setting this to
+	 * zero won't affect the value of 1 already set in the old
+	 * address space.
+	 */
+	switch_mm_works = 0;
+
+	switch_mm(self_mm_fd, NULL, return_regs, 0, 0);
+}
+
+static int check_switch_mm(void)
+{
+	int err, there = -1;
+
+	non_fatal("\t/proc/self/mm ... ");
+	self_mm_fd = open("/proc/self/mm", O_RDONLY);
+	if (self_mm_fd < 0)
+		goto bad;
+	non_fatal("OK\n");
+
+	mm_stack = mmap(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if(mm_stack == MAP_FAILED)
+		goto bad;
+
+	non_fatal("\tnew_mm ... ");
+	there = new_mm();
+	if(there < 0)
+		goto bad;
+	non_fatal("OK\n");
+
+	switch_mm_works = 1;
+
+	non_fatal("\tswitching over ... ");
+	err = switch_mm(there, return_regs, NULL, (unsigned long) after_switch,
+			((unsigned long) &mm_stack[UM_KERN_PAGE_SIZE]) -
+			sizeof(void *));
+	if (err < 0)
+		goto bad;
+	non_fatal("switched back ... ");
+	if(!switch_mm_works)
+		goto bad;
+	else
+		non_fatal("OK\n");
+
+	munmap(mm_stack, UM_KERN_PAGE_SIZE);
+	close(there);
+
+	if (disable_switch_mm)
+		non_fatal("switch_mm support disabled on command line\n");
+	else
+		have_switch_mm = 1;
+
+  	return 1;
+ bad:
+	if (there > 0)
+		close(there);
+	munmap(mm_stack, UM_KERN_PAGE_SIZE);
+	non_fatal("Failed - \n");
+	perror("");
+	return 0;
+}
+
+static int ptrace_switch_mm_works;
+
+static int after_ptrace_switch(void)
+{
+	ptrace_switch_mm_works = 1;
+	exit(0);
+}
+
+static int check_ptrace_switch_mm(void)
+{
+	void *stack;
+	unsigned long regs[MAX_REG_NR];
+	int pid, here, err, status;
+
+	non_fatal("\tPTRACE_SWITCH_MM ... ");
+	pid = fork();
+	if(pid == 0){
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+		kill(getpid(), SIGSTOP);
+
+		exit(0);
+	}
+	else if(pid < 0)
+		goto bad;
+
+	stack = mmap(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if(stack == MAP_FAILED)
+		goto bad;
+
+	here = open("/proc/self/mm", O_RDONLY);
+	if(here < 0)
+		goto bad_unmap;
+
+	err = waitpid(pid, &status, WUNTRACED);
+	if (err < 0)
+		goto bad_close;
+	else if (err != pid) {
+		non_fatal("waitpid returned %d, expected %d\n", err, pid);
+		goto bad_close;
+	}
+	else if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
+		non_fatal("waitpid returned status 0x%d\n", status);
+		goto bad_close;
+	}
+
+	err = ptrace(PTRACE_GETREGS, pid, 0, regs);
+	if (err < 0)
+		goto bad_close;
+
+	regs[REGS_IP_INDEX] = (unsigned long) after_ptrace_switch;
+	regs[REGS_SP_INDEX] = (unsigned long) stack + UM_KERN_PAGE_SIZE -
+		sizeof(void *);
+
+	if (ptrace(PTRACE_SETREGS, pid, 0, regs) < 0)
+		goto bad_close;
+
+	if (ptrace(PTRACE_SWITCH_MM, pid, NULL, here) < 0)
+		goto bad_close;
+
+	if (ptrace(PTRACE_CONT, pid, NULL, 0) < 0)
+		goto bad_close;
+
+	err = waitpid(pid, &status, WUNTRACED);
+	if (err < 0)
+		goto bad_close;
+	else if(err != pid) {
+		non_fatal("waitpid returned %d, expected %d\n", err, pid);
+		goto bad_close;
+	}
+	else if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0)) {
+		non_fatal("waitpid returned status 0x%d\n", status);
+		goto bad_close;
+	}
+
+	if (!ptrace_switch_mm_works)
+		goto bad_close;
+	else non_fatal("OK\n");
+
+	if (disable_ptrace_switch_mm)
+		non_fatal("PTRACE_SWITCH_MM support disabled on command "
+			  "line\n");
+	else
+		have_ptrace_switch_mm = 1;
+
+	close(here);
+	munmap(stack, UM_KERN_PAGE_SIZE);
 
 	return 1;
+
+ bad_close:
+	close(here);
+ bad_unmap:
+	munmap(stack, UM_KERN_PAGE_SIZE);
+ bad:
+	non_fatal("Failed - \n");
+	perror("");
+	return 0;
+}
+
+static int can_do_skas4(void)
+{
+	int ret;
+
+	non_fatal("Checking for new_mm and switch_mm support in the host:\n");
+
+	ret = check_switch_mm() && check_ptrace_switch_mm() && check_siginfo();
+	if (ret)
+		skas_needs_stub = 1;
+
+	return ret;
+}
+
+void can_do_skas(void)
+{
+	if (!can_do_skas4())
+		can_do_skas3();
+}
+
+int get_new_mm(void)
+{
+	int err;
+
+	err = new_mm();
+	if (err < 0)
+		err = -errno;
+
+	return err;
 }
 
 int __init parse_iomem(char *str, int *add)
diff --git a/arch/um/sys-i386/ldt.c b/arch/um/sys-i386/ldt.c
index 67c0958..c06c66c 100644
--- a/arch/um/sys-i386/ldt.c
+++ b/arch/um/sys-i386/ldt.c
@@ -436,7 +436,7 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 		/*
 		 * We have a valid from_mm, so we now have to copy the LDT of
 		 * from_mm to new_mm, because using proc_mm an new mm with
-		 * an empty/default LDT was created in new_mm()
+		 * an empty/default LDT was created in make_new_mm()
 		 */
 		copy = ((struct proc_mm_op) { .op 	= MM_COPY_SEGMENTS,
 					      .u 	=
diff --git a/arch/um/sys-i386/stub.S b/arch/um/sys-i386/stub.S
index e730772..b7e893e 100644
--- a/arch/um/sys-i386/stub.S
+++ b/arch/um/sys-i386/stub.S
@@ -1,52 +1,60 @@
 #include "uml-config.h"
 #include "as-layout.h"
+#include "skas/skas.h"
+
+#define PROCESS_LIST \
+	/* load pointer to first operation */ \
+	mov	$(ASM_STUB_DATA + 8), %esp; \
+1: \
+	/* load length of additional data */ \
+	mov	0x0(%esp), %eax; \
+	/* if(length == 0) : end of list */ \
+	/* write possible 0 to header */ \
+	mov	%eax, ASM_STUB_DATA + 4; \
+	cmpl	$0, %eax; \
+	jz	2f; \
+	/* save current pointer */ \
+	mov	%esp, ASM_STUB_DATA + 4; \
+	/* skip additional data */ \
+	add	%eax, %esp; \
+	/* load syscall-# */ \
+	pop	%eax; \
+	/* load syscall params */ \
+	pop	%ebx; \
+	pop	%ecx; \
+	pop	%edx; \
+	pop	%esi; \
+ 	pop	%edi; \
+	pop	%ebp; \
+	/* execute syscall */ \
+	int	$0x80; \
+	/* check return value */ \
+	pop	%ebx; \
+	cmp	%ebx, %eax; \
+	je	1b; \
+2: \
+	/* save return value */ \
+	mov	%eax, ASM_STUB_DATA;
 
 	.globl syscall_stub
 .section .__syscall_stub, "x"
 
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	/* load pointer to first operation */
-	mov	$(ASM_STUB_DATA+8), %esp
-
-again:
-	/* load length of additional data */
-	mov	0x0(%esp), %eax
-
-	/* if(length == 0) : end of list */
-	/* write possible 0 to header */
-	mov	%eax, ASM_STUB_DATA+4
-	cmpl	$0, %eax
-	jz	done
-
-	/* save current pointer */
-	mov	%esp, ASM_STUB_DATA+4
-
-	/* skip additional data */
-	add	%eax, %esp
-
-	/* load syscall-# */
-	pop	%eax
+	PROCESS_LIST
+	/* stop */
+	int3
 
-	/* load syscall params */
-	pop	%ebx
-	pop	%ecx
-	pop	%edx
-	pop	%esi
- 	pop	%edi
-	pop	%ebp
+ 	.globl switch_mm_stub
+switch_mm_stub:
+	PROCESS_LIST
 
-	/* execute syscall */
+	mov	$__NR_switch_mm, %eax
+	mov	ASM_STUB_DATA + UM_KERN_PAGE_SIZE - 8, %ebx
+	xor	%ecx, %ecx
+	mov	ASM_STUB_DATA + UM_KERN_PAGE_SIZE - 4, %edx
+	xor	%esi, %esi
+	xor	%edi, %edi
 	int	$0x80
 
-	/* check return value */
-	pop	%ebx
-	cmp	%ebx, %eax
-	je	again
-
-done:
-	/* save return value */
-	mov	%eax, ASM_STUB_DATA
-
-	/* stop */
 	int3
diff --git a/arch/um/sys-x86_64/stub.S b/arch/um/sys-x86_64/stub.S
index 4afe204..20b682d 100644
--- a/arch/um/sys-x86_64/stub.S
+++ b/arch/um/sys-x86_64/stub.S
@@ -1,67 +1,68 @@
 #include "uml-config.h"
 #include "as-layout.h"
+#include "skas/skas.h"
 
-	.globl syscall_stub
-.section .__syscall_stub, "x"
-syscall_stub:
-	syscall
-	/* We don't have 64-bit constants, so this constructs the address
-	 * we need.
-	 */
-	movq	$(ASM_STUB_DATA >> 32), %rbx
-	salq	$32, %rbx
-	movq	$(ASM_STUB_DATA & 0xffffffff), %rcx
-	or	%rcx, %rbx
-	movq	%rax, (%rbx)
-	int3
+#define PROCESS_LIST \
+	mov	$(ASM_STUB_DATA >> 32), %rbx; \
+	sal	$32, %rbx; \
+	mov	$(ASM_STUB_DATA & 0xffffffff), %rax; \
+	or	%rax, %rbx; \
+	/* load pointer to first operation */ \
+	mov	%rbx, %rsp; \
+	add	$0x10, %rsp; \
+1: \
+	/* load length of additional data */ \
+	mov	0x0(%rsp), %rax; \
+	/* if(length == 0) : end of list */ \
+	/* write possible 0 to header */ \
+	mov	%rax, 8(%rbx); \
+	cmp	$0, %rax; \
+	jz	2f; \
+	/* save current pointer */ \
+	mov	%rsp, 8(%rbx); \
+	/* skip additional data */ \
+	add	%rax, %rsp; \
+	/* load syscall-# */ \
+	pop	%rax; \
+	/* load syscall params */ \
+	pop	%rdi; \
+	pop	%rsi; \
+	pop	%rdx; \
+	pop	%r10; \
+ 	pop	%r8; \
+	pop	%r9; \
+	/* execute syscall */ \
+	syscall; \
+	/* check return value */ \
+	pop	%rcx; \
+	cmp	%rcx, %rax; \
+	je	1b; \
+2: \
+	/* save return value */ \
+	mov	%rax, (%rbx); \
 
+.section .__syscall_stub, "x"
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	mov	$(ASM_STUB_DATA >> 32), %rbx
-	sal	$32, %rbx
-	mov	$(ASM_STUB_DATA & 0xffffffff), %rax
-	or	%rax, %rbx
-	/* load pointer to first operation */
-	mov	%rbx, %rsp
-	add	$0x10, %rsp
-again:
-	/* load length of additional data */
-	mov	0x0(%rsp), %rax
-
-	/* if(length == 0) : end of list */
-	/* write possible 0 to header */
-	mov	%rax, 8(%rbx)
-	cmp	$0, %rax
-	jz	done
-
-	/* save current pointer */
-	mov	%rsp, 8(%rbx)
-
-	/* skip additional data */
-	add	%rax, %rsp
-
-	/* load syscall-# */
-	pop	%rax
+	PROCESS_LIST
+	/* stop */
+	int3
 
-	/* load syscall params */
-	pop	%rdi
-	pop	%rsi
-	pop	%rdx
-	pop	%r10
- 	pop	%r8
-	pop	%r9
+ 	.globl switch_mm_stub
+switch_mm_stub:
+	PROCESS_LIST
 
-	/* execute syscall */
+	mov	$__NR_switch_mm, %rax
+	mov	$(ASM_STUB_DATA >> 32), %rdi
+	sal	$32, %rdi
+	mov	$(ASM_STUB_DATA & 0xffffffff + 4096 - 8), %rsi
+	add	%rdi, %rsi
+	mov	(%rsi), %rdx
+	sub	$8, %rsi
+	mov	(%rsi), %rdi
+	xor	%rsi, %rsi
+	xor	%r10, %r10
+	xor	%r8, %r8
 	syscall
 
-	/* check return value */
-	pop	%rcx
-	cmp	%rcx, %rax
-	je	again
-
-done:
-	/* save return value */
-	mov	%rax, (%rbx)
-
-	/* stop */
 	int3
diff --git a/arch/um/sys-x86_64/syscall_table.c b/arch/um/sys-x86_64/syscall_table.c
index 71b2ae4..c2567dd 100644
--- a/arch/um/sys-x86_64/syscall_table.c
+++ b/arch/um/sys-x86_64/syscall_table.c
@@ -33,6 +33,7 @@
 #define stub_rt_sigsuspend sys_rt_sigsuspend
 #define stub_sigaltstack sys_sigaltstack
 #define stub_rt_sigreturn sys_rt_sigreturn
+#define stub_switch_mm sys_switch_mm
 
 #define __SYSCALL(nr, sym) extern asmlinkage void sym(void) ;
 #undef _ASM_X86_64_UNISTD_H_
diff --git a/arch/um/sys-x86_64/syscalls.c b/arch/um/sys-x86_64/syscalls.c
index 86f6b18..1d52eb5 100644
--- a/arch/um/sys-x86_64/syscalls.c
+++ b/arch/um/sys-x86_64/syscalls.c
@@ -30,7 +30,7 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 {
 	unsigned long *ptr = addr, tmp;
 	long ret;
-	int pid = task->mm->context.id.u.pid;
+	int pid = userspace_pid[0];
 
 	/*
 	 * With ARCH_SET_FS (and ARCH_SET_GS is treated similarly to
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 6ea19c2..2f74adf 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -65,6 +65,8 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 		err |= __put_user(from->_sifields._pad[0], &to->_sifields._pad[0]);
 		switch (from->si_code >> 16) {
 		case __SI_FAULT >> 16:
+			err |= __put_user(from->si_trapno, &to->si_trapno);
+			err |= __put_user(from->si_error, &to->si_error);
 			break;
 		case __SI_CHLD >> 16:
 			err |= __put_user(from->si_utime, &to->si_utime);
diff --git a/arch/x86/ia32/ia32entry.S b/arch/x86/ia32/ia32entry.S
index df588f0..2d97495 100644
--- a/arch/x86/ia32/ia32entry.S
+++ b/arch/x86/ia32/ia32entry.S
@@ -374,6 +374,7 @@ quiet_ni_syscall:
 	PTREGSCALL stub32_vfork, sys_vfork, %rdi
 	PTREGSCALL stub32_iopl, sys_iopl, %rsi
 	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend, %rdx
+	PTREGSCALL stub32_switch_mm, sys_switch_mm, %r9
 
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
index 3a058bb..96abdf5 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -412,6 +412,7 @@ END(\label)
 	PTREGSCALL stub_rt_sigsuspend, sys_rt_sigsuspend, %rdx
 	PTREGSCALL stub_sigaltstack, sys_sigaltstack, %rdx
 	PTREGSCALL stub_iopl, sys_iopl, %rsi
+	PTREGSCALL stub_switch_mm, sys_switch_mm, %r9
 
 ENTRY(ptregscall_common)
 	popq %r11
diff --git a/arch/x86/kernel/ptrace_32.c b/arch/x86/kernel/ptrace_32.c
index ff5431c..1f349e3 100644
--- a/arch/x86/kernel/ptrace_32.c
+++ b/arch/x86/kernel/ptrace_32.c
@@ -83,8 +83,7 @@ static inline int put_stack_long(struct task_struct *task, int offset,
 	return 0;
 }
 
-static int putreg(struct task_struct *child,
-	unsigned long regno, unsigned long value)
+int putreg(struct task_struct *child, unsigned long regno, unsigned long value)
 {
 	switch (regno >> 2) {
 		case GS:
@@ -116,8 +115,7 @@ static int putreg(struct task_struct *child,
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *child,
-	unsigned long regno)
+unsigned long getreg(struct task_struct *child, unsigned long regno)
 {
 	unsigned long retval = ~0UL;
 
@@ -715,3 +713,38 @@ out:
 		audit_syscall_exit(AUDITSC_RESULT(regs->eax), regs->eax);
 	return 1;
 }
+
+int ptrace_to_pt_regs(struct pt_regs *regs, struct __user user_regs *ptrace)
+{
+	int i, err;
+
+	if (!access_ok(VERIFY_READ, ptrace, sizeof(*ptrace)))
+		return -EFAULT;
+
+	for (i = 0; i < FRAME_SIZE; i++){
+		unsigned long n;
+
+		if (__get_user(n, &ptrace->regs[i]))
+			return -EFAULT;
+		err = putreg(current, i * 4, n);
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
+int pt_regs_to_ptrace(struct __user user_regs *ptrace, struct pt_regs *regs)
+{
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, ptrace, sizeof(*ptrace)))
+		return -EFAULT;
+
+	for (i = 0; i < FRAME_SIZE; i++){
+		unsigned long n = getreg(current, i * 4), err;
+		err = __put_user(n, &ptrace->regs[i]);
+	}
+
+	return 0;
+}
diff --git a/arch/x86/kernel/ptrace_64.c b/arch/x86/kernel/ptrace_64.c
index 607085f..915c291 100644
--- a/arch/x86/kernel/ptrace_64.c
+++ b/arch/x86/kernel/ptrace_64.c
@@ -226,8 +226,7 @@ void ptrace_disable(struct task_struct *child)
 	clear_singlestep(child);
 }
 
-static int putreg(struct task_struct *child,
-	unsigned long regno, unsigned long value)
+int putreg(struct task_struct *child, unsigned long regno, unsigned long value)
 {
 	unsigned long tmp; 
 	
@@ -283,7 +282,7 @@ static int putreg(struct task_struct *child,
 	return 0;
 }
 
-static unsigned long getreg(struct task_struct *child, unsigned long regno)
+unsigned long getreg(struct task_struct *child, unsigned long regno)
 {
 	unsigned long val;
 	switch (regno) {
@@ -619,3 +618,91 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
 	    && (current->ptrace & PT_PTRACED))
 		syscall_trace(regs);
 }
+
+extern int putreg32(struct task_struct *child, unsigned regno, u32 val);
+
+int ptrace_to_pt_regs(struct pt_regs *regs, struct user_regs *ptrace)
+{
+	int i, err;
+
+#ifdef CONFIG_IA32_EMULATION
+	if (test_thread_flag(TIF_IA32)) {
+		for (i = 0; i < MAX_REG32_NR; i++){
+			err = putreg32(current, i * 4, ptrace->u.regs32[i]);
+			if (err)
+				return err;
+		}
+
+		return 0;
+	}
+#endif
+	for (i = 0; i < MAX_REG_NR; i++){
+		err = putreg(current, i * 8, ptrace->u.regs64[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
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
+		for (i = 0; i < ARRAY_SIZE(ptrace->u.regs32); i++){
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
+	for (i = 0; i < ARRAY_SIZE(ptrace->u.regs64); i++){
+		unsigned long n = getreg(current, i * 8);
+		err = __put_user(n, &ptrace->u.regs64[i]);
+		if (err)
+			return err;
+	}
+
+	return 0;
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
+	return regs->u.regs64[RIP_INDEX];
+}
+
+unsigned long ptrace_sp(struct user_regs *regs)
+{
+#ifdef CONFIG_IA32_EMULATION
+	if (test_thread_flag(TIF_IA32))
+		return ptrace_sp32(regs->u.regs32);
+#endif
+	return regs->u.regs64[RSP_INDEX];
+}
diff --git a/arch/x86/kernel/sys_i386_32.c b/arch/x86/kernel/sys_i386_32.c
index a86d26f..1953ffb 100644
--- a/arch/x86/kernel/sys_i386_32.c
+++ b/arch/x86/kernel/sys_i386_32.c
@@ -261,3 +261,14 @@ int kernel_execve(const char *filename, char *const argv[], char *const envp[])
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
+	return do_switch_mm(regs.ebx, (struct __user user_regs *) regs.ecx,
+			    (struct __user user_regs *) regs.edx, regs.esi,
+			    regs.edi, &regs);
+}
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index 907942e..80a0175 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -153,3 +153,14 @@ asmlinkage long sys_uname(struct new_utsname __user * name)
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
index 8344c70..3346997 100644
--- a/arch/x86/kernel/syscall_table_32.S
+++ b/arch/x86/kernel/syscall_table_32.S
@@ -324,3 +324,5 @@ ENTRY(sys_call_table)
 	.long sys_timerfd
 	.long sys_eventfd
 	.long sys_fallocate
+	.long sys_new_mm
+	.long sys_switch_mm
diff --git a/arch/x86/mm/fault_32.c b/arch/x86/mm/fault_32.c
index a2273d4..0e7940d 100644
--- a/arch/x86/mm/fault_32.c
+++ b/arch/x86/mm/fault_32.c
@@ -211,6 +211,8 @@ static noinline void force_sig_info_fault(int si_signo, int si_code,
 	info.si_errno = 0;
 	info.si_code = si_code;
 	info.si_addr = (void __user *)address;
+	info.si_trapno = tsk->thread.trap_no;
+	info.si_error = tsk->thread.error_code;
 	force_sig_info(si_signo, &info, tsk);
 }
 
diff --git a/arch/x86/mm/fault_64.c b/arch/x86/mm/fault_64.c
index 0e26230..9f5009e 100644
--- a/arch/x86/mm/fault_64.c
+++ b/arch/x86/mm/fault_64.c
@@ -501,6 +501,8 @@ bad_area_nosemaphore:
 		info.si_signo = SIGSEGV;
 		info.si_errno = 0;
 		/* info.si_code has been set above */
+		info.si_trapno = tsk->thread.trap_no;
+		info.si_error = tsk->thread.error_code;
 		info.si_addr = (void __user *)address;
 		force_sig_info(SIGSEGV, &info, tsk);
 		return;
@@ -576,6 +578,8 @@ do_sigbus:
 	info.si_signo = SIGBUS;
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
+	info.si_trapno = tsk->thread.trap_no;
+	info.si_error = tsk->thread.error_code;
 	info.si_addr = (void __user *)address;
 	force_sig_info(SIGBUS, &info, tsk);
 	return;
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
diff --git a/include/asm-generic/siginfo.h b/include/asm-generic/siginfo.h
index 8786e01..b295e86 100644
--- a/include/asm-generic/siginfo.h
+++ b/include/asm-generic/siginfo.h
@@ -82,6 +82,9 @@ typedef struct siginfo {
 #ifdef __ARCH_SI_TRAPNO
 			int _trapno;	/* TRAP # which caused the signal */
 #endif
+#ifdef __ARCH_SI_ERROR
+			int _error;	/* CPU error code */
+#endif
 		} _sigfault;
 
 		/* SIGPOLL */
@@ -112,6 +115,9 @@ typedef struct siginfo {
 #ifdef __ARCH_SI_TRAPNO
 #define si_trapno	_sifields._sigfault._trapno
 #endif
+#ifdef __ARCH_SI_ERROR
+#define si_error	_sifields._sigfault._error
+#endif
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 
diff --git a/include/asm-um/processor-x86_64.h b/include/asm-um/processor-x86_64.h
index d946bf2..0528d9e 100644
--- a/include/asm-um/processor-x86_64.h
+++ b/include/asm-um/processor-x86_64.h
@@ -37,6 +37,7 @@ static inline void arch_flush_thread(struct arch_thread *thread)
 static inline void arch_copy_thread(struct arch_thread *from,
                                     struct arch_thread *to)
 {
+	to->fs = from->fs;
 }
 
 #include "asm/arch/user.h"
diff --git a/include/asm-um/ptrace-generic.h b/include/asm-um/ptrace-generic.h
index 6aefcd3..86dc84c 100644
--- a/include/asm-um/ptrace-generic.h
+++ b/include/asm-um/ptrace-generic.h
@@ -34,6 +34,14 @@ struct pt_regs {
 
 #define instruction_pointer(regs) PT_REGS_IP(regs)
 
+struct user_regs {
+	unsigned long regs[MAX_REG_NR];
+};
+
+extern int copyin_user_regs(struct user_regs *to, unsigned long __user *from);
+extern int ptrace_to_pt_regs(struct pt_regs *to, struct user_regs __user *from);
+extern int pt_regs_to_ptrace(struct user_regs __user *to, struct pt_regs *from);
+
 struct task_struct;
 
 extern long subarch_ptrace(struct task_struct *child, long request, long addr,
diff --git a/include/asm-um/ptrace-i386.h b/include/asm-um/ptrace-i386.h
index b2d24c5..9bec151 100644
--- a/include/asm-um/ptrace-i386.h
+++ b/include/asm-um/ptrace-i386.h
@@ -40,6 +40,12 @@
 
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
index 4c47535..9c5365e 100644
--- a/include/asm-um/ptrace-x86_64.h
+++ b/include/asm-um/ptrace-x86_64.h
@@ -62,6 +62,12 @@
 
 #define PT_FIX_EXEC_STACK(sp) do ; while(0)
 
+#define pt_regs_ip(r) (r).regs.gp[RIP / sizeof(long)]
+#define pt_regs_sp(r) (r).regs.gp[RSP / sizeof(long)]
+
+#define ptrace_ip(r) (r)->regs[RIP / sizeof(long)]
+#define ptrace_sp(r) (r)->regs[RSP / sizeof(long)]
+
 #define profile_pc(regs) PT_REGS_IP(regs)
 
 static inline int ptrace_get_thread_area(struct task_struct *child, int idx,
diff --git a/include/asm-x86/ia32.h b/include/asm-x86/ia32.h
index 0190b7c..afc75c3 100644
--- a/include/asm-x86/ia32.h
+++ b/include/asm-x86/ia32.h
@@ -119,6 +119,8 @@ typedef struct compat_siginfo{
 		/* SIGILL, SIGFPE, SIGSEGV, SIGBUS */
 		struct {
 			unsigned int _addr;	/* faulting insn/memory ref. */
+			int _trapno;	/* TRAP # which caused the signal */
+			int _error;	/* CPU error code */
 		} _sigfault;
 
 		/* SIGPOLL */
diff --git a/include/asm-x86/ptrace.h b/include/asm-x86/ptrace.h
index 51ddb25..379b891 100644
--- a/include/asm-x86/ptrace.h
+++ b/include/asm-x86/ptrace.h
@@ -2,6 +2,7 @@
 #define _ASM_X86_PTRACE_H
 
 #include <linux/compiler.h>	/* For __user */
+#include <asm/user.h>
 #include <asm/ptrace-abi.h>
 
 #ifndef __ASSEMBLY__
@@ -32,6 +33,21 @@ struct pt_regs {
 
 #ifdef __KERNEL__
 
+struct user_regs {
+	unsigned long regs[FRAME_SIZE];
+};
+
+#define pt_regs_ip(r) (r).eip
+#define pt_regs_sp(r) (r).esp
+
+#define ptrace_ip(r) (r)->regs[EIP]
+#define ptrace_sp(r) (r)->regs[UESP]
+
+extern int ptrace_to_pt_regs(struct pt_regs *regs,
+			     struct user_regs __user *ptrace);
+extern int pt_regs_to_ptrace(struct __user user_regs *ptrace,
+			     struct pt_regs *regs);
+
 #include <asm/vm86.h>
 #include <asm/segment.h>
 
@@ -98,6 +114,39 @@ struct pt_regs {
 
 #ifdef __KERNEL__
 
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
+		unsigned long regs64[MAX_REG_NR];
+#ifdef CONFIG_IA32_EMULATION
+		u32 regs32[MAX_REG32_NR];
+#endif
+	} u;
+};
+
+#define pt_regs_ip(regs) (regs).rip
+#define pt_regs_sp(regs) (regs).rsp
+
+extern unsigned long ptrace_ip(struct user_regs *regs);
+extern unsigned long ptrace_sp(struct user_regs *regs);
+
+extern int ptrace_to_pt_regs(struct pt_regs *regs,
+			     struct user_regs __user *ptrace);
+extern int pt_regs_to_ptrace(struct __user user_regs *ptrace,
+			     struct pt_regs *regs);
+
 #define user_mode(regs) (!!((regs)->cs & 3))
 #define user_mode_vm(regs) user_mode(regs)
 #define instruction_pointer(regs) ((regs)->rip)
diff --git a/include/asm-x86/siginfo.h b/include/asm-x86/siginfo.h
index a477bea..59c8d37 100644
--- a/include/asm-x86/siginfo.h
+++ b/include/asm-x86/siginfo.h
@@ -5,6 +5,9 @@
 # define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #endif
 
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
+
 #include <asm-generic/siginfo.h>
 
 #endif
diff --git a/include/asm-x86/unistd_32.h b/include/asm-x86/unistd_32.h
index 9b15545..87221d1 100644
--- a/include/asm-x86/unistd_32.h
+++ b/include/asm-x86/unistd_32.h
@@ -330,6 +330,8 @@
 #define __NR_timerfd		322
 #define __NR_eventfd		323
 #define __NR_fallocate		324
+#define __NR_new_mm		325
+#define __NR_switch_mm		326
 
 #ifdef __KERNEL__
 
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
index cc14656..9d11cca 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1652,6 +1652,7 @@ static inline int sas_ss_flags(unsigned long sp)
  * Routines for handling mm_structs
  */
 extern struct mm_struct * mm_alloc(void);
+extern struct mm_struct *dup_mm(struct task_struct *tsk);
 
 /* mmdrop drops the mm and the page tables */
 extern void FASTCALL(__mmdrop(struct mm_struct *));
diff --git a/include/linux/signalfd.h b/include/linux/signalfd.h
index 86f9b1e..71e3c45 100644
--- a/include/linux/signalfd.h
+++ b/include/linux/signalfd.h
@@ -26,6 +26,8 @@ struct signalfd_siginfo {
 	__u64 ssi_utime;
 	__u64 ssi_stime;
 	__u64 ssi_addr;
+	__u32 ssi_trap_no;
+	__u32 ssi_error_code;
 
 	/*
 	 * Pad strcture to 128 bytes. Remember to update the
@@ -36,7 +38,7 @@ struct signalfd_siginfo {
 	 * comes out of a read(2) and we really don't want to have
 	 * a compat on read(2).
 	 */
-	__u8 __pad[48];
+	__u8 __pad[40];
 };
 
 
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
diff --git a/kernel/ptrace.c b/kernel/ptrace.c
index c25db86..2f5cec0 100644
--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -366,6 +366,8 @@ static int ptrace_setsiginfo(struct task_struct *child, siginfo_t __user * data)
 	return error;
 }
 
+extern int do_switch(struct task_struct *task, int fd);
+
 int ptrace_request(struct task_struct *child, long request,
 		   long addr, long data)
 {
@@ -390,6 +392,9 @@ int ptrace_request(struct task_struct *child, long request,
 	case PTRACE_DETACH:	 /* detach a process that was attached. */
 		ret = ptrace_detach(child, data);
 		break;
+	case PTRACE_SWITCH_MM:
+		ret = do_switch(child, data);
+		break;
 	default:
 		break;
 	}
diff --git a/kernel/signal.c b/kernel/signal.c
index afa4f78..28813b1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -2088,7 +2088,7 @@ int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from)
 	 */
 	err = __put_user(from->si_signo, &to->si_signo);
 	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user((short)from->si_code, &to->si_code);
+	err |= __put_user(from->si_code, &to->si_code);
 	switch (from->si_code & __SI_MASK) {
 	case __SI_KILL:
 		err |= __put_user(from->si_pid, &to->si_pid);
@@ -2108,6 +2108,9 @@ int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from)
 #ifdef __ARCH_SI_TRAPNO
 		err |= __put_user(from->si_trapno, &to->si_trapno);
 #endif
+#ifdef __ARCH_SI_ERROR
+		err |= __put_user(from->si_error, &to->si_error);
+#endif
 		break;
 	case __SI_CHLD:
 		err |= __put_user(from->si_pid, &to->si_pid);
diff --git a/mm/Makefile b/mm/Makefile
index 5c0b0ea..9351c4e 100644
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
index 0000000..12ac235
--- /dev/null
+++ b/mm/mmfs.c
@@ -0,0 +1,210 @@
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
+extern const struct file_operations proc_pid_mm_operations;
+
+int do_switch(struct task_struct *task, int fd)
+{
+	struct mm_struct *old = task->mm, *new;
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
+	new = file->private_data;
+
+	task_lock(task);
+
+	atomic_inc(&new->mm_users);
+	task->mm = new;
+	task->active_mm = new;
+
+	if(task == current)
+		switch_mm(old, task->mm, task);
+
+	task_unlock(task);
+
+	mmput(old);
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
