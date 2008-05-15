Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 15 May 2008 16:11:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080515201115.GA12347@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 0/12] SKAS4
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

Major changes since version 5 -
	Rebased on 2.6.25
	Added sys_vcpu support

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
    three new system calls -
	new_mm - creates a new address space and returns a file
descriptor referencing it
	switch_mm - moves the calling process to the address space
referenced by the file descriptor passed to it
	vcpu - allows both UML's kernel and processes to run in a
single host process by creating a new context in which system calls
and signals cause an exit back to the original context by returning
from the vcpu call.

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

This patchset contains 12 patches.  Six of them contain the siginfo
extension, guest siginfo support, host new_mm/switch_mm support,
guest new_mm/switch_mm support, and host and guest vcpu support.  The
rest are preparation patches which shouldn't change anything
functionally, but which make the four functional patches smaller and
easier to read.

These are against 2.6.25.  Build both host and guest from the same
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
index cac542d..929d053 100644
--- a/arch/um/include/as-layout.h
+++ b/arch/um/include/as-layout.h
@@ -23,16 +23,15 @@
  */
 
 #ifdef __ASSEMBLY__
-#define _AC(X, Y)	(Y)
+#define _C(Y)	(Y)
 #else
-#define __AC(X, Y)	(X (Y))
-#define _AC(X, Y)	__AC(X, Y)
+#define _C(Y)	((unsigned long) (Y))
 #endif
 
-#define STUB_START _AC(, 0x100000)
-#define STUB_CODE _AC((unsigned long), STUB_START)
-#define STUB_DATA _AC((unsigned long), STUB_CODE + UM_KERN_PAGE_SIZE)
-#define STUB_END _AC((unsigned long), STUB_DATA + UM_KERN_PAGE_SIZE)
+#define STUB_START _C(0x100000)
+#define STUB_CODE STUB_START
+#define STUB_DATA (STUB_CODE + UM_KERN_PAGE_SIZE)
+#define STUB_END (STUB_DATA + UM_KERN_PAGE_SIZE)
 
 #ifndef __ASSEMBLY__
 
diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index 3c34122..3421c47 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -20,9 +20,9 @@ extern int kmalloc_ok;
 extern unsigned long alloc_stack(int order, int atomic);
 extern void free_stack(unsigned long stack, int order);
 
-extern int do_signal(void);
+extern void do_signal(void);
 extern void copy_sc(struct uml_pt_regs *regs, void *from);
-extern void interrupt_end(void);
+extern int interrupt_end(void);
 extern void relay_signal(int sig, struct uml_pt_regs *regs);
 
 extern unsigned long segv(struct faultinfo fi, unsigned long ip,
diff --git a/arch/um/include/os.h b/arch/um/include/os.h
index 32c799e..309dd51 100644
--- a/arch/um/include/os.h
+++ b/arch/um/include/os.h
@@ -265,6 +265,7 @@ extern int is_skas_winch(int pid, int fd, void *data);
 extern int start_userspace(unsigned long stub_stack);
 extern int copy_context_skas0(unsigned long stack, int pid);
 extern void userspace(struct uml_pt_regs *regs);
+extern void vcpu_userspace(struct uml_pt_regs *regs, int mm_fd);
 extern int map_stub_pages(int fd, unsigned long code, unsigned long data,
 			  unsigned long stack);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
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
index b073f8a..590fcff 100644
--- a/arch/um/include/skas/skas.h
+++ b/arch/um/include/skas/skas.h
@@ -6,18 +6,128 @@
 #ifndef __SKAS_H
 #define __SKAS_H
 
+#ifndef __KERNEL__
+#include <unistd.h>
+#include <sys/syscall.h>
+#endif
+#include "uml-config.h"
+
+#ifdef UML_CONFIG_X86_32
+#define __NR_new_mm             327
+#define __NR_switch_mm          328
+#define __NR_vcpu		329
+#else
+#define __NR_new_mm             288
+#define __NR_switch_mm          289
+#define __NR_vcpu		290
+#endif
+
+#define PTRACE_SWITCH_MM 34
+
+#ifndef __ASSEMBLY__
+
+#include <asm/user.h>
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
+extern int have_vcpu;
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
+#include <asm/ldt.h>
+#include "siginfo_segv.h"
+
+#ifdef UML_CONFIG_X86_32
+#define GDT_ENTRY_TLS_ENTRIES 3
+
+struct vcpu_arch {
+	struct user_desc tls_array[GDT_ENTRY_TLS_ENTRIES];
+};
+#else
+struct vcpu_arch { };
+#endif
+
+struct user_regs {
+	unsigned long regs[MAX_REG_NR];
+#ifdef UML_CONFIG_X86_32
+	struct user_fxsr_struct *fp_state;
+	struct user_fxsr_struct fpregs;
+#else
+	struct user_i387_struct *fp_state;
+	struct user_i387_struct fpregs;
+#endif
+};
+
+struct vcpu_user {
+	enum { VCPU_SYSCALL, VCPU_SIGNAL } event;
+	struct user_regs regs;
+	siginfo_t siginfo;
+	struct vcpu_arch arch;
+};
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
+static inline long switch_mm(int mm_fd, struct user_regs *save_regs,
+			     struct user_regs *new_regs, unsigned long ip,
+			     unsigned long sp)
+{
+	int ret = syscall(__NR_switch_mm, mm_fd, save_regs, new_regs, ip, sp,
+			  0);
+
+	if (ret < 0)
+		return -errno;
+
+	return 0;
+}
+
+static inline long vcpu(long mm_fd, struct vcpu_user *vcpu)
+{
+	int ret = syscall(__NR_vcpu, mm_fd, vcpu, 0, 0, 0, 0);
+
+	if (ret < 0)
+		return -errno;
+
+	return ret;
+}
+
+static inline int get_thread_area(struct user_desc *u_info)
+{
+	int ret = syscall(__NR_get_thread_area, u_info, 0, 0, 0, 0, 0);
+
+	if (ret < 0)
+		return -errno;
+
+	return ret;
+}
+
+#endif
+
+#endif
+
 #endif
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
diff --git a/arch/um/include/sysdep-i386/ptrace.h b/arch/um/include/sysdep-i386/ptrace.h
index 11c0896..510c80f 100644
--- a/arch/um/include/sysdep-i386/ptrace.h
+++ b/arch/um/include/sysdep-i386/ptrace.h
@@ -156,7 +156,7 @@ struct syscall_args {
 	} while (0)
 
 #define UPT_SET_SYSCALL_RETURN(r, res) \
-	REGS_SET_SYSCALL_RETURN((r)->regs, (res))
+	REGS_SET_SYSCALL_RETURN((r)->gp, (res))
 
 #define UPT_RESTART_SYSCALL(r) REGS_RESTART_SYSCALL((r)->gp)
 
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
diff --git a/arch/um/include/sysdep-i386/tls.h b/arch/um/include/sysdep-i386/tls.h
index 918fd3c..844f0c2 100644
--- a/arch/um/include/sysdep-i386/tls.h
+++ b/arch/um/include/sysdep-i386/tls.h
@@ -1,7 +1,7 @@
 #ifndef _SYSDEP_TLS_H
 #define _SYSDEP_TLS_H
 
-# ifndef __KERNEL__
+#ifndef __KERNEL__
 
 /* Change name to avoid conflicts with the original one from <asm/ldt.h>, which
  * may be named user_desc (but in 2.4 and in header matching its API was named
@@ -19,13 +19,19 @@ typedef struct um_dup_user_desc {
 	unsigned int  useable:1;
 } user_desc_t;
 
-# else /* __KERNEL__ */
+#else /* __KERNEL__ */
 
-#  include <asm/ldt.h>
+#include <asm/host_ldt.h>
 typedef struct user_desc user_desc_t;
 
 # endif /* __KERNEL__ */
 
+struct uml_tls_struct {
+	user_desc_t tls;
+	unsigned flushed:1;
+	unsigned present:1;
+};
+
 #define GDT_ENTRY_TLS_MIN_I386 6
 #define GDT_ENTRY_TLS_MIN_X86_64 12
 
diff --git a/arch/um/include/sysdep-x86_64/ptrace.h b/arch/um/include/sysdep-x86_64/ptrace.h
index 9ea44d1..18ad3a8 100644
--- a/arch/um/include/sysdep-x86_64/ptrace.h
+++ b/arch/um/include/sysdep-x86_64/ptrace.h
@@ -225,16 +225,14 @@ struct syscall_args {
 	})
 
 #define UPT_SET_SYSCALL_RETURN(r, res) \
-	REGS_SET_SYSCALL_RETURN((r)->regs, (res))
+	REGS_SET_SYSCALL_RETURN((r)->gp, (res))
 
 #define UPT_RESTART_SYSCALL(r) REGS_RESTART_SYSCALL((r)->gp)
 
-#define UPT_SEGV_IS_FIXABLE(r) REGS_SEGV_IS_FIXABLE(&r->skas)
+#define UPT_SEGV_IS_FIXABLE(r) REGS_SEGV_IS_FIXABLE(&(r)->skas)
 
 #define UPT_FAULTINFO(r) (&(r)->faultinfo)
 
-static inline void arch_init_registers(int pid)
-{
-}
+extern void arch_init_registers(int pid);
 
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
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index e8cb9ff..7f07ad3 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -111,12 +111,13 @@ void *_switch_to(void *prev, void *next, void *last)
 
 }
 
-void interrupt_end(void)
+int interrupt_end(void)
 {
 	if (need_resched())
 		schedule();
-	if (test_tsk_thread_flag(current, TIF_SIGPENDING))
+	if (test_thread_flag(TIF_SIGPENDING))
 		do_signal();
+	return current->mm->context.id.u.mm_fd;
 }
 
 void exit_thread(void)
@@ -152,7 +153,11 @@ void new_thread_handler(void)
 	if (n == 1) {
 		/* Handle any immediate reschedules or signals */
 		interrupt_end();
-		userspace(&current->thread.regs.regs);
+		if (have_vcpu)
+			vcpu_userspace(&current->thread.regs.regs,
+				       current->mm->context.id.u.mm_fd);
+		else
+			userspace(&current->thread.regs.regs);
 	}
 	else do_exit(0);
 }
@@ -176,7 +181,11 @@ void fork_handler(void)
 	/* Handle any immediate reschedules or signals */
 	interrupt_end();
 
-	userspace(&current->thread.regs.regs);
+	if (have_vcpu)
+		vcpu_userspace(&current->thread.regs.regs,
+			       current->mm->context.id.u.mm_fd);
+	else
+		userspace(&current->thread.regs.regs);
 }
 
 int copy_thread(int nr, unsigned long clone_flags, unsigned long sp,
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
diff --git a/arch/um/kernel/reboot.c b/arch/um/kernel/reboot.c
index 00197d3..a597b5d 100644
--- a/arch/um/kernel/reboot.c
+++ b/arch/um/kernel/reboot.c
@@ -12,7 +12,7 @@ void (*pm_power_off)(void);
 
 static void kill_off_processes(void)
 {
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		/*
 		 * FIXME: need to loop over userspace_pids
 		 */
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index b0fce72..b1fcfde 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -85,8 +85,11 @@ static int handle_signal(struct pt_regs *regs, unsigned long signr,
 	return err;
 }
 
-static int kern_do_signal(struct pt_regs *regs)
+extern int unvcpu(struct pt_regs *regs, siginfo_t *siginfo);
+
+void do_signal(void)
 {
+	struct pt_regs *regs = &current->thread.regs;
 	struct k_sigaction ka_copy;
 	siginfo_t info;
 	sigset_t *oldset;
@@ -98,6 +101,11 @@ static int kern_do_signal(struct pt_regs *regs)
 		oldset = &current->blocked;
 
 	while ((sig = get_signal_to_deliver(&info, &ka_copy, regs, NULL)) > 0) {
+		if (test_thread_flag(TIF_VCPU)) {
+			PT_REGS_SET_SYSCALL_RETURN(regs, unvcpu(regs, &info));
+			return;
+		}
+
 		handled_sig = 1;
 		/* Whee!  Actually deliver the signal.  */
 		if (!handle_signal(regs, sig, &ka_copy, &info, oldset)) {
@@ -150,12 +158,6 @@ static int kern_do_signal(struct pt_regs *regs)
 		clear_thread_flag(TIF_RESTORE_SIGMASK);
 		sigprocmask(SIG_SETMASK, &current->saved_sigmask, NULL);
 	}
-	return handled_sig;
-}
-
-int do_signal(void)
-{
-	return kern_do_signal(&current->thread.regs);
 }
 
 /*
diff --git a/arch/um/kernel/skas/clone.c b/arch/um/kernel/skas/clone.c
index 2c8583c..6b19d0a 100644
--- a/arch/um/kernel/skas/clone.c
+++ b/arch/um/kernel/skas/clone.c
@@ -3,8 +3,8 @@
  * Licensed under the GPL
  */
 
-#include <signal.h>
 #include <sched.h>
+#include <signal.h>
 #include <asm/unistd.h>
 #include <sys/time.h>
 #include "as-layout.h"
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index 0cd9a7a..5f4c32e 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -46,6 +46,9 @@ static int init_stub_pte(struct mm_struct *mm, unsigned long proc,
 	return -ENOMEM;
 }
 
+extern int copy_context_skas4(struct mm_id *id);
+extern int get_new_mm(void);
+
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
  	struct mm_context *from_mm = NULL;
@@ -64,13 +67,26 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
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
+	} else if (have_switch_mm) {
+		to_mm->id.u.mm_fd = get_new_mm();
+		if (to_mm->id.u.mm_fd < 0) {
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
 	}
 	else {
 		if (from_mm)
@@ -167,7 +183,7 @@ void destroy_context(struct mm_struct *mm)
 {
 	struct mm_context *mmu = &mm->context;
 
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		os_close_file(mmu->id.u.mm_fd);
 	else {
 		/*
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 2e9852c..ec82db3 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -10,7 +10,7 @@
 #include "os.h"
 #include "skas.h"
 
-int new_mm(unsigned long stack)
+int make_new_mm(unsigned long stack)
 {
 	int fd, err;
 
@@ -55,7 +55,8 @@ int __init start_uml(void)
 {
 	stack_protections((unsigned long) &cpu0_irqstack);
 	set_sigstack(cpu0_irqstack, THREAD_SIZE);
-	if (proc_mm) {
+
+	if (!have_vcpu && (proc_mm || have_switch_mm)) {
 		userspace_pid[0] = start_userspace(0);
 		if (userspace_pid[0] < 0) {
 			printf("start_uml - start_userspace returned %d\n",
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index 4e3b820..c677b8e 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -12,12 +12,19 @@
 extern int syscall_table_size;
 #define NR_syscalls (syscall_table_size / sizeof(void *))
 
+extern int unvcpu(struct pt_regs *regs, siginfo_t *siginfo);
+
 void handle_syscall(struct uml_pt_regs *r)
 {
 	struct pt_regs *regs = container_of(r, struct pt_regs, regs);
 	long result;
 	int syscall;
 
+	if (test_thread_flag(TIF_VCPU)) {
+		REGS_SET_SYSCALL_RETURN(r->gp, unvcpu(regs, NULL));
+		return;
+	}
+
 	syscall_trace(r, 0);
 
 	/*
diff --git a/arch/um/kernel/syscall.c b/arch/um/kernel/syscall.c
index 9cffc62..63c782d 100644
--- a/arch/um/kernel/syscall.c
+++ b/arch/um/kernel/syscall.c
@@ -1,17 +1,17 @@
 /*
- * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright (C) 2000 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
-#include "linux/file.h"
-#include "linux/fs.h"
-#include "linux/mm.h"
-#include "linux/sched.h"
-#include "linux/utsname.h"
-#include "asm/current.h"
-#include "asm/mman.h"
-#include "asm/uaccess.h"
-#include "asm/unistd.h"
+#include <linux/file.h>
+#include <linux/fs.h>
+#include <linux/mm.h>
+#include <linux/sched.h>
+#include <linux/utsname.h>
+#include <asm/current.h>
+#include <asm/mman.h>
+#include <asm/uaccess.h>
+#include <asm/unistd.h>
 
 long sys_fork(void)
 {
@@ -148,3 +148,21 @@ int kernel_execve(const char *filename, char *const argv[], char *const envp[])
 
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
+
+extern long do_vcpu(int mm_fd, struct vcpu_user __user *new,
+		    struct pt_regs *regs);
+
+long sys_vcpu(int mm_fd, struct vcpu_user __user *new)
+{
+	return do_vcpu(mm_fd, new, &current->thread.regs);
+}
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index a6c1dd1..d00ebbd 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -284,7 +284,9 @@ int __init linux_main(int argc, char **argv)
 
 	can_do_skas();
 
-	if (proc_mm && ptrace_faultinfo)
+	if (have_switch_mm)
+		mode = "SKAS4";
+	else if (proc_mm && ptrace_faultinfo)
 		mode = "SKAS3";
 	else
 		mode = "SKAS0";
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 484e68f..73b1dff 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -22,7 +22,7 @@
 #include "sysdep/stub.h"
 #include "uml-config.h"
 
-extern unsigned long batch_syscall_stub, __syscall_stub_start;
+extern unsigned long batch_syscall_stub, switch_mm_stub, __syscall_stub_start;
 
 extern void wait_stub_done(int pid);
 
@@ -41,34 +41,63 @@ static unsigned long syscall_regs[MAX_REG_NR];
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
+
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
+
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
+		printk(UM_KERN_CONT "  0x%lx", data[n]);
+	}
+	if (n > 1)
+		printk("\n");
 
-int single_count = 0;
-int multi_count = 0;
-int multi_op_count = 0;
+	return ret;
+}
 
-static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
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
@@ -85,52 +114,73 @@ static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 
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
 
 	*addr = check_init_stack(mm_idp, NULL);
 
 	return ret;
 }
 
-long run_syscall_stub(struct mm_id * mm_idp, int syscall,
+static struct user_regs return_regs;
+
+long do_syscall_stub_skas4(struct mm_id *mm_idp, void **addr, unsigned long ip,
+			   unsigned long sp)
+{
+	long ret;
+	unsigned long *ptr;
+	int err;
+	sigset_t sigs, old;
+
+	ptr = (unsigned long *) (mm_idp->stack + UM_KERN_PAGE_SIZE -
+				 sizeof(long));
+	*ptr = (unsigned long) &return_regs;
+	*(ptr - 1) = self_mm_fd;
+
+	sigfillset(&sigs);
+	sigprocmask(SIG_SETMASK, &sigs, &old);
+	err = switch_mm(mm_idp->u.mm_fd, &return_regs, NULL, ip, sp);
+	sigprocmask(SIG_SETMASK, &old, NULL);
+
+	ret = syscall_stub_done(mm_idp->stack);
+
+	*addr = check_init_stack(mm_idp, NULL);
+
+	return ret;
+}
+
+static int flush_syscalls(struct mm_id *mm_idp, void **addr, int extra)
+{
+	unsigned long *stack = check_init_stack(mm_idp, *addr);
+	int current, end;
+
+	current = ((unsigned long) stack) & ~UM_KERN_PAGE_MASK;
+	end = UM_KERN_PAGE_SIZE;
+
+	if (have_switch_mm)
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
@@ -144,45 +194,40 @@ long run_syscall_stub(struct mm_id * mm_idp, int syscall,
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
+	*stack = data_count;
+	*addr = stack++;
 
-	memcpy(stack + 1, data, data_count * sizeof(long));
+	memcpy(stack, data, data_count);
 
-	*stub_addr = (void *)(((unsigned long)(stack + 1) &
-			       ~UM_KERN_PAGE_MASK) + STUB_DATA);
+	*stub_addr = (void *)(((unsigned long) stack & ~UM_KERN_PAGE_MASK) +
+			      STUB_DATA);
 
 	return 0;
 }
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 1e8cba6..593df24 100644
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
@@ -96,11 +99,23 @@ bad_wait:
 
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
+	if (have_siginfo_segv) {
+		err = ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
+		if (err)
+			printk(UM_KERN_ERR "PTRACE_GETSIGINFO failed, "
+			       "err = %d\n", errno);
+
+		GET_FAULTINFO_FROM_SI(*fi, si);
+	} else if (ptrace_faultinfo) {
 		err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
 		if (err) {
 			printk(UM_KERN_ERR "get_skas_faultinfo - "
@@ -113,8 +128,7 @@ void get_skas_faultinfo(int pid, struct faultinfo * fi)
 			memset((char *)fi + sizeof(struct ptrace_faultinfo), 0,
 			       sizeof(struct faultinfo) -
 			       sizeof(struct ptrace_faultinfo));
-	}
-	else {
+	} else {
 		unsigned long fpregs[FP_SIZE];
 
 		err = get_fp_registers(pid, fpregs);
@@ -248,12 +262,9 @@ static int userspace_tramp(void *stack)
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
@@ -295,7 +306,7 @@ int start_userspace(unsigned long stub_stack)
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);
 
 	flags = CLONE_FILES;
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		flags |= CLONE_VM;
 	else
 		flags |= SIGCHLD;
@@ -347,6 +358,85 @@ int start_userspace(unsigned long stub_stack)
 	return err;
 }
 
+#ifdef UML_CONFIG_X86_32
+extern void init_vcpu_tls(struct user_desc *tls);
+
+static void arch_init_vcpu(struct vcpu_arch *vcpu)
+{
+	init_vcpu_tls(vcpu->tls_array);
+}
+#else
+static void arch_init_vcpu(struct vcpu_arch *vcpu)
+{
+}
+#endif
+
+extern unsigned long fp_regs[FP_SIZE];
+
+void vcpu_userspace(struct uml_pt_regs *regs, int mm_fd)
+{
+	struct vcpu_user vcpu_state;
+	int err;
+
+	memcpy(&vcpu_state.regs.fpregs, fp_regs, sizeof(fp_regs));
+	vcpu_state.regs.fp_state = &vcpu_state.regs.fpregs;
+	while (1) {
+		memcpy(&vcpu_state.regs.regs, &regs->gp,
+		       sizeof(vcpu_state.regs.regs));
+		arch_init_vcpu(&vcpu_state.arch);
+
+		err = vcpu(mm_fd, &vcpu_state);
+		if (err)
+			panic("userspace - could not resume userspace process, "
+			      "errno = %d\n", errno);
+
+		regs->is_user = 1;
+		memcpy(&regs->gp, &vcpu_state.regs.regs,
+		       sizeof(vcpu_state.regs.regs));
+
+		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
+		if (vcpu_state.event == VCPU_SYSCALL) {
+			UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->gp);
+			handle_syscall(regs);
+		}
+		else if (vcpu_state.event == VCPU_SIGNAL){
+			int sig = vcpu_state.siginfo.si_signo;
+		  	switch(sig) {
+			case SIGSEGV:
+				GET_FAULTINFO_FROM_SI(regs->faultinfo,
+						      vcpu_state.siginfo);
+				(*sig_info[SIGSEGV])(SIGSEGV, regs);
+				break;
+			case SIGTRAP:
+				relay_signal(SIGTRAP, regs);
+				break;
+			case SIGVTALRM:
+				block_signals();
+				(*sig_info[sig])(sig, regs);
+				unblock_signals();
+				break;
+			case SIGIO:
+			case SIGILL:
+			case SIGBUS:
+			case SIGFPE:
+			case SIGWINCH:
+				block_signals();
+				(*sig_info[sig])(sig, regs);
+				unblock_signals();
+				break;
+			default:
+			        printk(UM_KERN_ERR "userspace - child stopped "
+				       "with signal %d\n", sig);
+			}
+			/* Avoid -ERESTARTSYS handling in host */
+			if (PT_SYSCALL_NR_OFFSET != PT_SYSCALL_RET_OFFSET)
+				PT_SYSCALL_NR(regs->gp) = -1;
+		}
+
+		mm_fd = interrupt_end();
+	}
+}
+
 void userspace(struct uml_pt_regs *regs)
 {
 	struct itimerval timer;
@@ -446,8 +536,14 @@ void userspace(struct uml_pt_regs *regs)
 				       "with signal %d\n", sig);
 				fatal_sigsegv();
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
@@ -462,9 +558,7 @@ static int __init init_thread_regs(void)
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
@@ -554,6 +648,56 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 	return err;
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
@@ -713,16 +857,24 @@ void reboot_skas(void)
 void __switch_mm(struct mm_id *mm_idp)
 {
 	int err;
-
 	/* FIXME: need cpu pid in __switch_mm */
+
+	if (have_vcpu)
+		return;
+
 	if (proc_mm) {
-		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+		err = ptrace(OLD_PTRACE_SWITCH_MM, userspace_pid[0], 0,
 			     mm_idp->u.mm_fd);
 		if (err) {
 			printk(UM_KERN_ERR "__switch_mm - PTRACE_SWITCH_MM "
 			       "failed, errno = %d\n", errno);
 			fatal_sigsegv();
 		}
-	}
-	else userspace_pid[0] = mm_idp->u.pid;
+	} else if (have_ptrace_switch_mm) {
+		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+			     mm_idp->u.mm_fd);
+		if (err)
+			panic("__switch_mm - PTRACE_SWITCH_MM "
+			      "failed, errno = %d\n", errno);
+	} else userspace_pid[0] = mm_idp->u.pid;
 }
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index b616e15..28a7984 100644
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
@@ -23,7 +26,10 @@
 #include "mem_user.h"
 #include "ptrace_user.h"
 #include "registers.h"
+#include "skas.h"
 #include "skas_ptrace.h"
+#include "sysdep/sigcontext.h"
+#include "user.h"
 
 static int ptrace_child(void)
 {
@@ -142,14 +148,40 @@ static int stop_ptraced_child(int pid, int exitcode, int mustexit)
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
+int have_vcpu;
+static int disable_vcpu;
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
+	disable_vcpu = 1;
+
 	return 0;
 }
 
@@ -159,15 +191,12 @@ static int __init mode_skas0_cmd_param(char *str, int* add)
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
@@ -362,7 +391,7 @@ void __init os_early_checks(void)
 
 static int __init noprocmm_cmd_param(char *str, int* add)
 {
-	proc_mm = 0;
+	disable_proc_mm = 1;
 	return 0;
 }
 
@@ -374,7 +403,7 @@ __uml_setup("noprocmm", noprocmm_cmd_param,
 
 static int __init noptracefaultinfo_cmd_param(char *str, int* add)
 {
-	ptrace_faultinfo = 0;
+	disable_ptrace_faultinfo = 1;
 	return 0;
 }
 
@@ -386,7 +415,7 @@ __uml_setup("noptracefaultinfo", noptracefaultinfo_cmd_param,
 
 static int __init noptraceldt_cmd_param(char *str, int* add)
 {
-	ptrace_ldt = 0;
+	disable_ptrace_ldt = 1;
 	return 0;
 }
 
@@ -396,7 +425,7 @@ __uml_setup("noptraceldt", noptraceldt_cmd_param,
 "    To support PTRACE_LDT, the host needs to be patched using\n"
 "    the current skas3 patch.\n\n");
 
-static inline void check_skas3_ptrace_faultinfo(void)
+static inline void __init check_skas3_ptrace_faultinfo(void)
 {
 	struct ptrace_faultinfo fi;
 	int pid, n;
@@ -406,23 +435,21 @@ static inline void check_skas3_ptrace_faultinfo(void)
 
 	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
 	if (n < 0) {
-		ptrace_faultinfo = 0;
 		if (errno == EIO)
 			non_fatal("not found\n");
 		else
 			perror("not found");
-	}
+	} else if (disable_ptrace_faultinfo)
+		non_fatal("found but disabled on command line\n");
 	else {
-		if (!ptrace_faultinfo)
-			non_fatal("found but disabled on command line\n");
-		else
-			non_fatal("found\n");
+		ptrace_faultinfo = 1;
+		non_fatal("found\n");
 	}
 
 	stop_ptraced_child(pid, 1, 1);
 }
 
-static inline void check_skas3_ptrace_ldt(void)
+static inline void __init check_skas3_ptrace_ldt(void)
 {
 #ifdef PTRACE_LDT
 	int pid, n;
@@ -442,38 +469,31 @@ static inline void check_skas3_ptrace_ldt(void)
 		else {
 			perror("not found");
 		}
-		ptrace_ldt = 0;
-	}
+	} else if (disable_ptrace_ldt)
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
 
-static inline void check_skas3_proc_mm(void)
+static inline void __init check_skas3_proc_mm(void)
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
 
-void can_do_skas(void)
+static void __init can_do_skas3(void)
 {
 	non_fatal("Checking for the skas3 patch in the host:\n");
 
@@ -481,8 +501,417 @@ void can_do_skas(void)
 	check_skas3_ptrace_faultinfo();
 	check_skas3_ptrace_ldt();
 
-	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
+	if (!proc_mm || (!ptrace_faultinfo && !have_siginfo_segv) ||
+	    !ptrace_ldt)
+		skas_needs_stub = 1;
+}
+
+static void *fault_address;
+
+static __init int check_fault_info(struct faultinfo *fi)
+{
+	return (FAULT_ADDRESS(*fi) == (unsigned long) fault_address) &&
+		FAULT_WRITE(*fi) && SEGV_IS_FIXABLE(fi);
+}
+
+static jmp_buf siginfo_buf;
+
+static void __init segv_handler(int sig, siginfo_t *si, void *foo)
+{
+	struct faultinfo fi;
+	int n;
+
+	GET_FAULTINFO_FROM_SI(fi, *si);
+	n = check_fault_info(&fi) ? 1 : 2;
+	longjmp(siginfo_buf, n);
+}
+
+static int __init fault(void)
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
+static int __init check_siginfo(void)
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
+	while (1) {
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
+			  "line\n");
+	else
+		have_siginfo_segv = 1;
+
+	return ok;
+}
+
+static struct user_regs return_regs;
+int self_mm_fd;
+
+static int switch_mm_works;
+
+static __init void after_switch(void)
+{
+	/*
+	 * If we are really in a new address space, setting this to
+	 * zero won't affect the value of 1 already set in the old
+	 * address space.
+	 */
+	switch_mm_works = 0;
+
+	switch_mm(self_mm_fd, NULL, &return_regs, 0, 0);
+}
+
+static int __init check_switch_mm(void)
+{
+	char *mm_stack;
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
+	if (mm_stack == MAP_FAILED)
+		goto bad;
+
+	non_fatal("\tnew_mm ... ");
+	there = new_mm();
+	if (there < 0)
+		goto bad_unmap;
+	non_fatal("OK\n");
+
+	switch_mm_works = 1;
+
+	non_fatal("\tswitching over ... ");
+	err = switch_mm(there, &return_regs, NULL, (unsigned long) after_switch,
+			((unsigned long) &mm_stack[UM_KERN_PAGE_SIZE]) -
+			sizeof(void *));
+	if (err < 0)
+		goto bad_close;
+	non_fatal("switched back ... ");
+	if (!switch_mm_works)
+		goto bad_close;
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
+	return 1;
+ bad_close:
+	if (there > 0)
+		close(there);
+ bad_unmap:
+	munmap(mm_stack, UM_KERN_PAGE_SIZE);
+ bad:
+	non_fatal("Failed - \n");
+	perror("");
+	return 0;
+}
+
+static int ptrace_switch_mm_works;
+
+static int __init after_ptrace_switch(void)
+{
+	ptrace_switch_mm_works = 1;
+	exit(0);
+}
+
+static int __init check_ptrace_switch_mm(void)
+{
+	void *stack;
+	unsigned long regs[MAX_REG_NR];
+	int pid, here, err, status;
+
+	non_fatal("\tPTRACE_SWITCH_MM ... ");
+	pid = fork();
+	if (pid == 0){
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+		kill(getpid(), SIGSTOP);
+
+		exit(0);
+	}
+	else if (pid < 0)
+		goto bad;
+
+	stack = mmap(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (stack == MAP_FAILED)
+		goto bad;
+
+	here = open("/proc/self/mm", O_RDONLY);
+	if (here < 0)
+		goto bad_unmap;
+
+	err = waitpid(pid, &status, WUNTRACED);
+	if (err < 0)
+		goto bad_close;
+	else if (err != pid) {
+		non_fatal("waitpid returned %d, expected %d\n", err, pid);
+		goto bad_close;
+	} else if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
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
+	} else if (!WIFEXITED(status) || (WEXITSTATUS(status) != 0)) {
+		non_fatal("waitpid returned status 0x%d\n", status);
+		goto bad_close;
+	}
+
+	if (!ptrace_switch_mm_works)
+		goto bad_close;
+	else
+		non_fatal("OK\n");
+
+	if (disable_ptrace_switch_mm)
+		non_fatal("PTRACE_SWITCH_MM support disabled on command "
+			  "line\n");
+	else
+		have_ptrace_switch_mm = 1;
+
+	close(here);
+	munmap(stack, UM_KERN_PAGE_SIZE);
+
+	return 1;
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
+#ifdef UML_CONFIG_X86_32
+extern int host_gdt_entry_tls_min;
+extern void host_tls_support(void);
+
+static __init int init_vcpu_arch(struct vcpu_arch *vcpu){
+	struct user_desc *tls = vcpu->tls_array;
+	int i, err;
+
+	host_tls_support();
+	memset(tls, 0, sizeof(vcpu->tls_array));
+	for (i = 0; i < ARRAY_SIZE(vcpu->tls_array); i++) {
+		tls[i].entry_number = host_gdt_entry_tls_min + i;
+		err = get_thread_area(&tls[i]);
+		if (err) {
+			perror("get_thread_area");
+			return err;
+		}
+	}
+	return 0;
+}
+#else
+static int init_vcpu_arch(struct vcpu_arch *vcpu){
+	return 0;
+}
+#endif
+
+static struct vcpu_user vcpu_data;
+
+static __init int check_vcpu(void)
+{
+	void *stack;
+	int err;
+
+	non_fatal("\tvcpu ... ");
+
+	stack = mmap(NULL, UM_KERN_PAGE_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_SHARED | MAP_ANONYMOUS, -1, 0);
+	if (stack == MAP_FAILED)
+		goto bad;
+
+	get_safe_registers(vcpu_data.regs.regs);
+ 	vcpu_data.regs.regs[REGS_IP_INDEX] = (unsigned long) ptrace_child;
+	vcpu_data.regs.regs[REGS_SP_INDEX] = (unsigned long) stack +
+		UM_KERN_PAGE_SIZE - sizeof(void *);
+
+	if (init_vcpu_arch(&vcpu_data.arch))
+		goto bad;
+
+	err = vcpu(-1, &vcpu_data);
+	munmap(stack, UM_KERN_PAGE_SIZE);
+	if (err) {
+		non_fatal("vcpu failed with errno %d\n", err);
+		goto bad;
+	}
+
+	if (vcpu_data.event != VCPU_SYSCALL) {
+		non_fatal("vcpu returned with event = %d\n", vcpu_data.event);
+		goto bad;
+	}
+
+	non_fatal("OK\n");
+
+	if (disable_vcpu)
+		non_fatal("vcpu support disabled on command line\n");
+	else
+		have_vcpu = 1;
+
+	return 1;
+
+ bad:
+	non_fatal("Failed\n");
+	return 0;
+}
+
+static int __init can_do_skas4(void)
+{
+	int ret;
+
+	non_fatal("Checking for SKAS4 support in the host:\n");
+
+	ret = check_switch_mm() && check_ptrace_switch_mm() && check_siginfo()
+		&& check_vcpu();
+	if (ret)
 		skas_needs_stub = 1;
+
+	return ret;
+}
+
+void __init can_do_skas(void)
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
diff --git a/arch/um/os-Linux/sys-i386/registers.c b/arch/um/os-Linux/sys-i386/registers.c
index b613473..6dfd56f 100644
--- a/arch/um/os-Linux/sys-i386/registers.c
+++ b/arch/um/os-Linux/sys-i386/registers.c
@@ -4,10 +4,16 @@
  * Licensed under the GPL
  */
 
+#include <stdio.h>
+#include <stdlib.h>
 #include <errno.h>
+#include <asm/ldt.h>
+#include <sys/syscall.h>
+#include <unistd.h>
 #include "kern_constants.h"
 #include "longjmp.h"
 #include "user.h"
+#include "skas.h"
 #include "sysdep/ptrace_user.h"
 
 int save_fp_registers(int pid, unsigned long *fp_regs)
@@ -72,12 +78,32 @@ int put_fp_registers(int pid, unsigned long *regs)
 		return restore_fp_registers(pid, regs);
 }
 
+extern int host_gdt_entry_tls_min;
+
+#define GDT_ENTRY_TLS_ENTRIES 3
+#define GDT_ENTRY_TLS_MIN 6
+#define GDT_ENTRY_TLS_MAX (GDT_ENTRY_TLS_MIN + GDT_ENTRY_TLS_ENTRIES - 1)
+
+struct user_desc tls[GDT_ENTRY_TLS_ENTRIES];
+
+unsigned long fp_regs[FP_SIZE];
+
 void arch_init_registers(int pid)
 {
-	unsigned long fpx_regs[HOST_XFP_SIZE];
-	int err;
+	struct user_desc *entry;
+	int err, i;
 
-	err = ptrace(PTRACE_GETFPXREGS, pid, 0, fpx_regs);
+	for (i = 0; i < GDT_ENTRY_TLS_ENTRIES; i++) {
+		entry = &tls[i];
+		entry->entry_number = i + GDT_ENTRY_TLS_MIN;
+		err = get_thread_area(entry);
+		if (err) {
+			perror("get_thread_area");
+			exit(1);
+		}
+	}
+
+	err = ptrace(PTRACE_GETFPXREGS, pid, 0, fp_regs);
 	if (!err)
 		return;
 
@@ -87,3 +113,4 @@ void arch_init_registers(int pid)
 
 	have_fpx_regs = 0;
 }
+
diff --git a/arch/um/os-Linux/sys-x86_64/registers.c b/arch/um/os-Linux/sys-x86_64/registers.c
index 594d97a..43731fe 100644
--- a/arch/um/os-Linux/sys-x86_64/registers.c
+++ b/arch/um/os-Linux/sys-x86_64/registers.c
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2006 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright (C) 2006 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
@@ -10,6 +10,7 @@
 #include "kern_constants.h"
 #include "longjmp.h"
 #include "user.h"
+#include "sysdep/ptrace_user.h"
 
 int save_fp_registers(int pid, unsigned long *fp_regs)
 {
@@ -50,3 +51,15 @@ int put_fp_registers(int pid, unsigned long *regs)
 {
 	return restore_fp_registers(pid, regs);
 }
+
+unsigned long fp_regs[FP_SIZE];
+
+void arch_init_registers(int pid)
+{
+	int err;
+
+	err = ptrace(PTRACE_GETFPREGS, pid, 0, fp_regs);
+	if(err)
+		panic("arch_init_registers : PTRACE_GETFPREGS failed, "
+		      "errno = %d", errno);
+}
diff --git a/arch/um/sys-i386/ldt.c b/arch/um/sys-i386/ldt.c
index a34263e..8642b56 100644
--- a/arch/um/sys-i386/ldt.c
+++ b/arch/um/sys-i386/ldt.c
@@ -437,7 +437,7 @@ long init_new_ldt(struct mm_context *new_mm, struct mm_context *from_mm)
 		/*
 		 * We have a valid from_mm, so we now have to copy the LDT of
 		 * from_mm to new_mm, because using proc_mm an new mm with
-		 * an empty/default LDT was created in new_mm()
+		 * an empty/default LDT was created in make_new_mm()
 		 */
 		copy = ((struct proc_mm_op) { .op 	= MM_COPY_SEGMENTS,
 					      .u 	=
diff --git a/arch/um/sys-i386/signal.c b/arch/um/sys-i386/signal.c
index fd0c25a..68251f2 100644
--- a/arch/um/sys-i386/signal.c
+++ b/arch/um/sys-i386/signal.c
@@ -164,6 +164,8 @@ static int convert_fxsr_from_user(struct user_fxsr_struct *fxsave,
 
 extern int have_fpx_regs;
 
+extern unsigned long fp_regs[FP_SIZE];
+
 static int copy_sc_from_user(struct pt_regs *regs,
 			     struct sigcontext __user *from)
 {
@@ -177,24 +179,12 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	pid = userspace_pid[current_thread_info()->cpu];
 	copy_sc(&regs->regs, &sc);
 	if (have_fpx_regs) {
-		struct user_fxsr_struct fpx;
-
-		err = copy_from_user(&fpx, &sc.fpstate->_fxsr_env[0],
-				     sizeof(struct user_fxsr_struct));
-		if (err)
-			return 1;
+		struct user_fxsr_struct *fpx =
+			(struct user_fxsr_struct *) &fp_regs;
 
-		err = convert_fxsr_from_user(&fpx, sc.fpstate);
+		err = convert_fxsr_from_user(fpx, sc.fpstate);
 		if (err)
 			return 1;
-
-		err = restore_fpx_registers(pid, (unsigned long *) &fpx);
-		if (err < 0) {
-			printk(KERN_ERR "copy_sc_from_user - "
-			       "restore_fpx_registers failed, errno = %d\n",
-			       -err);
-			return 1;
-		}
 	}
 	else {
 		struct user_i387_struct fp;
@@ -250,25 +240,19 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 
 	pid = userspace_pid[current_thread_info()->cpu];
 	if (have_fpx_regs) {
-		struct user_fxsr_struct fpx;
-
-		err = save_fpx_registers(pid, (unsigned long *) &fpx);
-		if (err < 0){
-			printk(KERN_ERR "copy_sc_to_user - save_fpx_registers "
-			       "failed, errno = %d\n", err);
-			return 1;
-		}
+		struct user_fxsr_struct *fpx =
+			(struct user_fxsr_struct *) &fp_regs;
 
-		err = convert_fxsr_to_user(to_fp, &fpx);
+		err = convert_fxsr_to_user(to_fp, fpx);
 		if (err)
 			return 1;
 
-		err |= __put_user(fpx.swd, &to_fp->status);
+		err |= __put_user(fpx->swd, &to_fp->status);
 		err |= __put_user(X86_FXSR_MAGIC, &to_fp->magic);
 		if (err)
 			return 1;
 
-		if (copy_to_user(&to_fp->_fxsr_env[0], &fpx,
+		if (copy_to_user(&to_fp->_fxsr_env[0], fpx,
 				 sizeof(struct user_fxsr_struct)))
 			return 1;
 	}
diff --git a/arch/um/sys-i386/stub.S b/arch/um/sys-i386/stub.S
index 7699e89..117462e 100644
--- a/arch/um/sys-i386/stub.S
+++ b/arch/um/sys-i386/stub.S
@@ -1,52 +1,60 @@
 #include "uml-config.h"
 #include "as-layout.h"
+#include "skas/skas.h"
+
+#define PROCESS_LIST \
+	/* load pointer to first operation */ \
+	mov	$(STUB_DATA + 8), %esp; \
+1: \
+	/* load length of additional data */ \
+	mov	0x0(%esp), %eax; \
+	/* if(length == 0) : end of list */ \
+	/* write possible 0 to header */ \
+	mov	%eax, STUB_DATA + 4; \
+	cmpl	$0, %eax; \
+	jz	2f; \
+	/* save current pointer */ \
+	mov	%esp, STUB_DATA + 4; \
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
+	mov	%eax, STUB_DATA;
 
 	.globl syscall_stub
 .section .__syscall_stub, "x"
 
 	.globl batch_syscall_stub
 batch_syscall_stub:
-	/* load pointer to first operation */
-	mov	$(STUB_DATA+8), %esp
-
-again:
-	/* load length of additional data */
-	mov	0x0(%esp), %eax
-
-	/* if(length == 0) : end of list */
-	/* write possible 0 to header */
-	mov	%eax, STUB_DATA+4
-	cmpl	$0, %eax
-	jz	done
-
-	/* save current pointer */
-	mov	%esp, STUB_DATA+4
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
+	mov	STUB_DATA + UM_KERN_PAGE_SIZE - 8, %ebx
+	xor	%ecx, %ecx
+	mov	STUB_DATA + UM_KERN_PAGE_SIZE - 4, %edx
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
-	mov	%eax, STUB_DATA
-
-	/* stop */
 	int3
diff --git a/arch/um/sys-i386/tls.c b/arch/um/sys-i386/tls.c
index c6c7131..a45d7ab 100644
--- a/arch/um/sys-i386/tls.c
+++ b/arch/um/sys-i386/tls.c
@@ -6,10 +6,19 @@
 #include "linux/percpu.h"
 #include "linux/sched.h"
 #include "asm/uaccess.h"
+#include <asm/unistd.h>
+#include <asm/segment.h>
+#include "kern.h"
 #include "os.h"
 #include "skas.h"
 #include "sysdep/tls.h"
 
+void copy_tls(struct user_desc *to)
+{
+	memcpy(to, current->thread.arch.tls_array,
+	       sizeof(current->thread.arch.tls_array));
+}
+
 /*
  * If needed we can detect when it's uninitialized.
  *
@@ -18,11 +27,14 @@
 static int host_supports_tls = -1;
 int host_gdt_entry_tls_min;
 
-int do_set_thread_area(struct user_desc *info)
+static int do_set_thread_area(struct user_desc *info)
 {
 	int ret;
 	u32 cpu;
 
+	if(have_vcpu)
+		return 0;
+
 	cpu = get_cpu();
 	ret = os_set_thread_area(info, userspace_pid[cpu]);
 	put_cpu();
@@ -300,6 +312,7 @@ int sys_set_thread_area(struct user_desc __user *user_desc)
 	ret = do_set_thread_area(&info);
 	if (ret)
 		return ret;
+
 	return set_tls_entry(current, &info, idx, 1);
 }
 
@@ -366,31 +379,38 @@ out:
 	return ret;
 }
 
+extern struct user_desc tls[GDT_ENTRY_TLS_ENTRIES];
+
 /*
  * This code is really i386-only, but it detects and logs x86_64 GDT indexes
  * if a 32-bit UML is running on a 64-bit host.
  */
-static int __init __setup_host_supports_tls(void)
+void __init host_tls_support(void)
 {
 	check_host_supports_tls(&host_supports_tls, &host_gdt_entry_tls_min);
 	if (host_supports_tls) {
-		printk(KERN_INFO "Host TLS support detected\n");
-		printk(KERN_INFO "Detected host type: ");
+		printf("Host TLS support detected\n");
+		printf("Detected host type: ");
 		switch (host_gdt_entry_tls_min) {
 		case GDT_ENTRY_TLS_MIN_I386:
-			printk(KERN_CONT "i386");
+			printf("i386\n");
 			break;
 		case GDT_ENTRY_TLS_MIN_X86_64:
-			printk(KERN_CONT "x86_64");
+			printf("x86_64\n");
 			break;
 		}
-		printk(KERN_CONT " (GDT indexes %d to %d)\n",
-		       host_gdt_entry_tls_min,
+		printf(" (GDT indexes %d to %d)\n", host_gdt_entry_tls_min,
 		       host_gdt_entry_tls_min + GDT_ENTRY_TLS_ENTRIES);
 	} else
-		printk(KERN_ERR "  Host TLS support NOT detected! "
-				"TLS support inside UML will not work\n");
-	return 0;
+		printf("Host TLS support NOT detected! "
+		       "TLS support inside UML will not work\n");
 }
 
-__initcall(__setup_host_supports_tls);
+void init_vcpu_tls(struct user_desc *to)
+{
+	struct uml_tls_struct *tls = current->thread.arch.tls_array;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(current->thread.arch.tls_array); i++)
+		to[i] = tls[i].tls;
+}
diff --git a/arch/um/sys-x86_64/signal.c b/arch/um/sys-x86_64/signal.c
index 1a899a7..1e426f8 100644
--- a/arch/um/sys-x86_64/signal.c
+++ b/arch/um/sys-x86_64/signal.c
@@ -42,6 +42,8 @@ void copy_sc(struct uml_pt_regs *regs, void *from)
 #undef GETREG
 }
 
+static unsigned long fp_regs[HOST_FP_SIZE];
+
 static int copy_sc_from_user(struct pt_regs *regs,
 			     struct sigcontext __user *from,
 			     struct _fpstate __user *fpp)
@@ -81,13 +83,17 @@ static int copy_sc_from_user(struct pt_regs *regs,
 	if (err)
 		return 1;
 
-	err = restore_fp_registers(userspace_pid[current_thread_info()->cpu],
-				   (unsigned long *) &fp);
-	if (err < 0) {
-		printk(KERN_ERR "copy_sc_from_user - "
-		       "restore_fp_registers failed, errno = %d\n",
-		       -err);
-		return 1;
+	if (have_vcpu)
+		memcpy(fp_regs, &fp, sizeof(fp_regs));
+	else {
+		err = restore_fp_registers(userspace_pid[current_thread_info()->cpu],
+					   (unsigned long *) &fp);
+		if (err < 0) {
+			printk(KERN_ERR "copy_sc_from_user - "
+			       "restore_fp_registers failed, errno = %d\n",
+			       -err);
+			return 1;
+		}
 	}
 
 	return 0;
@@ -143,14 +149,18 @@ static int copy_sc_to_user(struct sigcontext __user *to,
 	if (err)
 		return 1;
 
-	err = save_fp_registers(userspace_pid[current_thread_info()->cpu],
-				(unsigned long *) &fp);
-	if (err < 0) {
-		printk(KERN_ERR "copy_sc_from_user - restore_fp_registers "
-		       "failed, errno = %d\n", -err);
-		return 1;
+	if (have_vcpu)
+		memcpy(&fp, fp_regs, sizeof(fp));
+	else {
+		err = save_fp_registers(userspace_pid[current_thread_info()->cpu],
+					(unsigned long *) &fp);
+		if (err < 0) {
+			printk(KERN_ERR "copy_sc_from_user - "
+			       "restore_fp_registers failed, errno = %d\n",
+			       -err);
+			return 1;
+		}
 	}
-
 	if (copy_to_user(to_fp, &fp, sizeof(struct user_i387_struct)))
 		return 1;
 
diff --git a/arch/um/sys-x86_64/stub.S b/arch/um/sys-x86_64/stub.S
index 5687687..b4043b0 100644
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
-	movq	$(STUB_DATA >> 32), %rbx
-	salq	$32, %rbx
-	movq	$(STUB_DATA & 0xffffffff), %rcx
-	or	%rcx, %rbx
-	movq	%rax, (%rbx)
-	int3
+#define PROCESS_LIST \
+	mov	$(STUB_DATA >> 32), %rbx; \
+	sal	$32, %rbx; \
+	mov	$(STUB_DATA & 0xffffffff), %rax; \
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
-	mov	$(STUB_DATA >> 32), %rbx
-	sal	$32, %rbx
-	mov	$(STUB_DATA & 0xffffffff), %rax
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
+	mov	$(STUB_DATA >> 32), %rdi
+	sal	$32, %rdi
+	mov	$(STUB_DATA & 0xffffffff + 4096 - 8), %rsi
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
index c128eb8..9bb72fc 100644
--- a/arch/um/sys-x86_64/syscall_table.c
+++ b/arch/um/sys-x86_64/syscall_table.c
@@ -39,6 +39,8 @@
 #define stub_rt_sigsuspend sys_rt_sigsuspend
 #define stub_sigaltstack sys_sigaltstack
 #define stub_rt_sigreturn sys_rt_sigreturn
+#define stub_switch_mm sys_switch_mm
+#define stub_vcpu sys_vcpu
 
 #define __SYSCALL(nr, sym) extern asmlinkage void sym(void) ;
 #undef _ASM_X86_64_UNISTD_H_
diff --git a/arch/um/sys-x86_64/syscalls.c b/arch/um/sys-x86_64/syscalls.c
index f1199fd..fbbc903 100644
--- a/arch/um/sys-x86_64/syscalls.c
+++ b/arch/um/sys-x86_64/syscalls.c
@@ -28,61 +28,78 @@ asmlinkage long sys_uname64(struct new_utsname __user * name)
 
 long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 {
-	unsigned long *ptr = addr, tmp;
-	long ret;
-	int pid = task->mm->context.id.u.pid;
+	long ret = 0;
+
+	if (have_vcpu) {
+		unsigned long *regs = task->thread.regs.regs.gp;
+		switch (code) {
+		case ARCH_SET_FS:
+			task->thread.arch.fs = (unsigned long) addr;
+			regs[HOST_FS_BASE] = (unsigned long) addr;
+			break;
+		case ARCH_SET_GS:
+			regs[HOST_GS_BASE] = (unsigned long) addr;
+			break;
+		case ARCH_GET_FS:
+			ret = put_user(regs[HOST_FS_BASE], addr);
+			break;
+		case ARCH_GET_GS:
+			ret = put_user(regs[HOST_GS_BASE], addr);
+			break;
+		}
+	} else {
+		unsigned long *ptr = addr, tmp;
+		int pid = userspace_pid[0];
 
-	/*
-	 * With ARCH_SET_FS (and ARCH_SET_GS is treated similarly to
-	 * be safe), we need to call arch_prctl on the host because
-	 * setting %fs may result in something else happening (like a
-	 * GDT or thread.fs being set instead).  So, we let the host
-	 * fiddle the registers and thread struct and restore the
-	 * registers afterwards.
-	 *
-	 * So, the saved registers are stored to the process (this
-	 * needed because a stub may have been the last thing to run),
-	 * arch_prctl is run on the host, then the registers are read
-	 * back.
-	 */
-	switch (code) {
-	case ARCH_SET_FS:
-	case ARCH_SET_GS:
-		ret = restore_registers(pid, &current->thread.regs.regs);
-		if (ret)
-			return ret;
-		break;
-	case ARCH_GET_FS:
-	case ARCH_GET_GS:
 		/*
-		 * With these two, we read to a local pointer and
-		 * put_user it to the userspace pointer that we were
-		 * given.  If addr isn't valid (because it hasn't been
-		 * faulted in or is just bogus), we want put_user to
-		 * fault it in (or return -EFAULT) instead of having
-		 * the host return -EFAULT.
+		 * With ARCH_SET_FS (and ARCH_SET_GS is treated similarly to
+		 * be safe), we need to call arch_prctl on the host because
+		 * setting %fs may result in something else happening (like a
+		 * GDT or thread.fs being set instead).  So, we let the host
+		 * fiddle the registers and thread struct and restore the
+		 * registers afterwards.
+		 *
+		 * So, the saved registers are stored to the process (this
+		 * needed because a stub may have been the last thing to run),
+		 * arch_prctl is run on the host, then the registers are read
+		 * back.
 		 */
-		ptr = &tmp;
-	}
-
-	ret = os_arch_prctl(pid, code, ptr);
-	if (ret)
-		return ret;
+		switch (code) {
+		case ARCH_SET_FS:
+		case ARCH_SET_GS:
+			restore_registers(pid, &current->thread.regs.regs);
+			break;
+		case ARCH_GET_FS:
+		case ARCH_GET_GS:
+			/*
+			 * With these two, we read to a local pointer and
+			 * put_user it to the userspace pointer that we were
+			 * given.  If addr isn't valid (because it hasn't been
+			 * faulted in or is just bogus), we want put_user to
+			 * fault it in (or return -EFAULT) instead of having
+			 * the host return -EFAULT.
+			 */
+			ptr = &tmp;
+		}
 
-	switch (code) {
-	case ARCH_SET_FS:
-		current->thread.arch.fs = (unsigned long) ptr;
-		ret = save_registers(pid, &current->thread.regs.regs);
-		break;
-	case ARCH_SET_GS:
-		ret = save_registers(pid, &current->thread.regs.regs);
-		break;
-	case ARCH_GET_FS:
-		ret = put_user(tmp, addr);
-		break;
-	case ARCH_GET_GS:
-		ret = put_user(tmp, addr);
-		break;
+		ret = os_arch_prctl(pid, code, ptr);
+		if (ret)
+			return ret;
+		switch (code) {
+		case ARCH_SET_FS:
+			current->thread.arch.fs = (unsigned long) ptr;
+			save_registers(pid, &current->thread.regs.regs);
+			break;
+		case ARCH_SET_GS:
+			save_registers(pid, &current->thread.regs.regs);
+			break;
+		case ARCH_GET_FS:
+			ret = put_user(tmp, addr);
+			break;
+		case ARCH_GET_GS:
+			ret = put_user(tmp, addr);
+			break;
+		}
 	}
 
 	return ret;
diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 5e7771a..a2a4c1c 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -68,6 +68,8 @@ int copy_siginfo_to_user32(compat_siginfo_t __user *to, siginfo_t *from)
 				  &to->_sifields._pad[0]);
 		switch (from->si_code >> 16) {
 		case __SI_FAULT >> 16:
+			err |= __put_user(from->si_trapno, &to->si_trapno);
+			err |= __put_user(from->si_error, &to->si_error);
 			break;
 		case __SI_CHLD >> 16:
 			err |= __put_user(from->si_utime, &to->si_utime);
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
diff --git a/arch/x86/kernel/entry_32.S b/arch/x86/kernel/entry_32.S
index 4b87c32..1e2adae 100644
--- a/arch/x86/kernel/entry_32.S
+++ b/arch/x86/kernel/entry_32.S
@@ -371,7 +371,7 @@ ENTRY(system_call)
 	GET_THREAD_INFO(%ebp)
 					# system call tracing in operation / emulation
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
-	testw $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT),TI_flags(%ebp)
+	testl $(_TIF_SYSCALL_EMU|_TIF_SYSCALL_TRACE|_TIF_SECCOMP|_TIF_SYSCALL_AUDIT|_TIF_VCPU),TI_flags(%ebp)
 	jnz syscall_trace_entry
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
diff --git a/arch/x86/kernel/entry_64.S b/arch/x86/kernel/entry_64.S
index c20c9e7..f3f403a 100644
--- a/arch/x86/kernel/entry_64.S
+++ b/arch/x86/kernel/entry_64.S
@@ -244,7 +244,7 @@ ENTRY(system_call_after_swapgs)
 	movq  %rcx,RIP-ARGOFFSET(%rsp)
 	CFI_REL_OFFSET rip,RIP-ARGOFFSET
 	GET_THREAD_INFO(%rcx)
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%rcx)
+	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP|_TIF_VCPU),threadinfo_flags(%rcx)
 	jnz tracesys
 	cmpq $__NR_syscall_max,%rax
 	ja badsys
@@ -323,6 +323,12 @@ tracesys:
 	FIXUP_TOP_OF_STACK %rdi
 	movq %rsp,%rdi
 	call syscall_trace_enter
+	testl %eax, %eax
+	jz 2f
+	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
+	RESTORE_REST
+	jmp int_ret_from_sys_call
+2:
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
 	cmpq $__NR_syscall_max,%rax
@@ -425,6 +431,7 @@ END(\label)
 	PTREGSCALL stub_rt_sigsuspend, sys_rt_sigsuspend, %rdx
 	PTREGSCALL stub_sigaltstack, sys_sigaltstack, %rdx
 	PTREGSCALL stub_iopl, sys_iopl, %rsi
+	PTREGSCALL stub_switch_mm, sys_switch_mm, %r9
 
 ENTRY(ptregscall_common)
 	popq %r11
@@ -481,6 +488,23 @@ ENTRY(stub_rt_sigreturn)
 END(stub_rt_sigreturn)
 
 /*
+ * vcpu is special too
+ */
+ENTRY(stub_vcpu)
+	CFI_STARTPROC
+	addq $8, %rsp
+	CFI_ADJUST_CFA_OFFSET	-8
+	SAVE_REST
+	movq %rsp,%rdx
+	FIXUP_TOP_OF_STACK %r11
+	call sys_vcpu
+	movq %rax,RAX(%rsp) # fixme, this could be done at the higher layer
+	RESTORE_REST
+	jmp int_ret_from_sys_call
+	CFI_ENDPROC
+END(stub_vcpu)
+
+/*
  * initial frame state for interrupts and exceptions
  */
 	.macro _frame ref
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index eb92ccb..44334e2 100644
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
@@ -1453,6 +1453,8 @@ void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code)
 	force_sig_info(SIGTRAP, &info, tsk);
 }
 
+extern int unvcpu(struct pt_regs *regs, siginfo_t *siginfo);
+
 /* notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
@@ -1489,6 +1491,14 @@ int do_syscall_trace(struct pt_regs *regs, int entryexit)
 			goto out;
 	}
 
+	if (test_thread_flag(TIF_VCPU)) {
+		if (entryexit)
+			return 0;
+
+		regs->ax = unvcpu(regs, NULL);
+		return 1;
+	}
+
 	if (!(current->ptrace & PT_PTRACED))
 		goto out;
 
@@ -1533,6 +1543,64 @@ out:
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
@@ -1558,11 +1626,18 @@ static void syscall_trace(struct pt_regs *regs)
 	}
 }
 
-asmlinkage void syscall_trace_enter(struct pt_regs *regs)
+extern int unvcpu(struct pt_regs *regs, siginfo_t *siginfo);
+
+asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 {
 	/* do the secure computing check first */
 	secure_computing(regs->orig_ax);
 
+	if (test_thread_flag(TIF_VCPU)) {
+		regs->ax = unvcpu(regs, NULL);
+		return 1;
+	}
+
 	if (test_thread_flag(TIF_SYSCALL_TRACE)
 	    && (current->ptrace & PT_PTRACED))
 		syscall_trace(regs);
@@ -1580,6 +1655,8 @@ asmlinkage void syscall_trace_enter(struct pt_regs *regs)
 					    regs->dx, regs->r10);
 		}
 	}
+
+	return 0;
 }
 
 asmlinkage void syscall_trace_leave(struct pt_regs *regs)
@@ -1593,4 +1670,115 @@ asmlinkage void syscall_trace_leave(struct pt_regs *regs)
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
diff --git a/arch/x86/kernel/signal_32.c b/arch/x86/kernel/signal_32.c
index 0157a6f..73b5d21 100644
--- a/arch/x86/kernel/signal_32.c
+++ b/arch/x86/kernel/signal_32.c
@@ -573,6 +573,8 @@ handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
 	return ret;
 }
 
+extern int unvcpu(struct pt_regs *regs, siginfo_t *siginfo);
+
 /*
  * Note that 'init' is a special process: it doesn't get signals it doesn't
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
@@ -603,6 +605,11 @@ static void do_signal(struct pt_regs *regs)
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
+		if (test_thread_flag(TIF_VCPU)) {
+			regs->ax = unvcpu(regs, &info);
+			return;
+		}
+
 		/* Re-enable any watchpoints before delivering the
 		 * signal to user space. The processor register will
 		 * have been cleared if the watchpoint triggered
diff --git a/arch/x86/kernel/signal_64.c b/arch/x86/kernel/signal_64.c
index 1c83e51..8978b40 100644
--- a/arch/x86/kernel/signal_64.c
+++ b/arch/x86/kernel/signal_64.c
@@ -407,6 +407,8 @@ handle_signal(unsigned long sig, siginfo_t *info, struct k_sigaction *ka,
 	return ret;
 }
 
+extern int unvcpu(struct pt_regs *regs, siginfo_t *siginfo);
+
 /*
  * Note that 'init' is a special process: it doesn't get signals it doesn't
  * want to handle. Thus you cannot kill init even with a SIGKILL even by
@@ -435,6 +437,11 @@ static void do_signal(struct pt_regs *regs)
 
 	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
+		if (test_thread_flag(TIF_VCPU)) {
+			regs->ax = unvcpu(regs, &info);
+			return;
+		}
+
 		/* Re-enable any watchpoints before delivering the
 		 * signal to user space. The processor register will
 		 * have been cleared if the watchpoint triggered
diff --git a/arch/x86/kernel/sys_i386_32.c b/arch/x86/kernel/sys_i386_32.c
index a86d26f..d5d54f6 100644
--- a/arch/x86/kernel/sys_i386_32.c
+++ b/arch/x86/kernel/sys_i386_32.c
@@ -21,6 +21,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/unistd.h>
+#include <asm/user.h>
 
 /*
  * sys_pipe() is the normal C calling standard for creating
@@ -261,3 +262,28 @@ int kernel_execve(const char *filename, char *const argv[], char *const envp[])
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
+
+extern long do_vcpu(int mm_fd, struct vcpu_user __user *new,
+		    struct pt_regs *regs);
+
+asmlinkage long sys_vcpu(struct pt_regs regs)
+{
+	int err;
+
+	err = do_vcpu(regs.bx, (struct vcpu_user __user *) regs.cx, &regs);
+	if (err)
+		return err;
+
+	return regs.ax;
+}
diff --git a/arch/x86/kernel/sys_x86_64.c b/arch/x86/kernel/sys_x86_64.c
index bd802a5..aab9121 100644
--- a/arch/x86/kernel/sys_x86_64.c
+++ b/arch/x86/kernel/sys_x86_64.c
@@ -251,3 +251,29 @@ asmlinkage long sys_uname(struct new_utsname __user * name)
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
+
+extern long do_vcpu(int mm_fd, struct vcpu_user __user *new,
+		    struct pt_regs *regs);
+
+asmlinkage long sys_vcpu(int mm_fd, struct vcpu_user __user *new,
+			 struct pt_regs *regs)
+{
+	int err;
+
+	err = do_vcpu(mm_fd, new, regs);
+	if (err)
+		return err;
+
+	return regs->ax;
+}
diff --git a/arch/x86/kernel/syscall_table_32.S b/arch/x86/kernel/syscall_table_32.S
index adff556..5b9803a 100644
--- a/arch/x86/kernel/syscall_table_32.S
+++ b/arch/x86/kernel/syscall_table_32.S
@@ -326,3 +326,6 @@ ENTRY(sys_call_table)
 	.long sys_fallocate
 	.long sys_timerfd_settime	/* 325 */
 	.long sys_timerfd_gettime
+	.long sys_new_mm
+	.long sys_switch_mm
+	.long sys_vcpu
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index ec08d83..f6f3990 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -173,6 +173,8 @@ static void force_sig_info_fault(int si_signo, int si_code,
 	info.si_errno = 0;
 	info.si_code = si_code;
 	info.si_addr = (void __user *)address;
+	info.si_trapno = tsk->thread.trap_no;
+	info.si_error = tsk->thread.error_code;
 	force_sig_info(si_signo, &info, tsk);
 }
 
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
 
diff --git a/include/asm-um/desc.h b/include/asm-um/desc.h
index 4ec34a5..efbabaf 100644
--- a/include/asm-um/desc.h
+++ b/include/asm-um/desc.h
@@ -1,6 +1,11 @@
 #ifndef __UM_DESC_H
 #define __UM_DESC_H
 
+#ifdef CONFIG_64BIT
+#define LM(info) (info)->lm == 0
+#else
+#define LM(info) (1)
+#endif
 /* Taken from asm-i386/desc.h, it's the only thing we need. The rest wouldn't
  * compile, and has never been used. */
 #define LDT_empty(info) (\
@@ -11,6 +16,7 @@
 	(info)->seg_32bit	== 0	&& \
 	(info)->limit_in_pages	== 0	&& \
 	(info)->seg_not_present	== 1	&& \
+	LM(info)			&& \
 	(info)->useable		== 0	)
 
 #endif
diff --git a/include/asm-um/host_ldt-i386.h b/include/asm-um/host_ldt-i386.h
index b27cb0a..e2ad59c 100644
--- a/include/asm-um/host_ldt-i386.h
+++ b/include/asm-um/host_ldt-i386.h
@@ -1,7 +1,8 @@
 #ifndef __ASM_HOST_LDT_I386_H
 #define __ASM_HOST_LDT_I386_H
 
-#include "asm/arch/ldt.h"
+#include <asm/desc.h>
+#include <asm/arch/ldt.h>
 
 /*
  * macros stolen from include/asm-i386/desc.h
@@ -21,14 +22,4 @@
 	((info)->useable << 20) | \
 	0x7000)
 
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	)
-
 #endif
diff --git a/include/asm-um/host_ldt-x86_64.h b/include/asm-um/host_ldt-x86_64.h
index 74a63f7..585c162 100644
--- a/include/asm-um/host_ldt-x86_64.h
+++ b/include/asm-um/host_ldt-x86_64.h
@@ -1,7 +1,8 @@
 #ifndef __ASM_HOST_LDT_X86_64_H
 #define __ASM_HOST_LDT_X86_64_H
 
-#include "asm/arch/ldt.h"
+#include <asm/desc.h>
+#include <asm/arch/ldt.h>
 
 /*
  * macros stolen from include/asm-x86_64/desc.h
@@ -24,15 +25,4 @@
 	/* ((info)->lm << 21) | */ \
 	0x7000)
 
-#define LDT_empty(info) (\
-	(info)->base_addr	== 0	&& \
-	(info)->limit		== 0	&& \
-	(info)->contents	== 0	&& \
-	(info)->read_exec_only	== 1	&& \
-	(info)->seg_32bit	== 0	&& \
-	(info)->limit_in_pages	== 0	&& \
-	(info)->seg_not_present	== 1	&& \
-	(info)->useable		== 0	&& \
-	(info)->lm              == 0)
-
 #endif
diff --git a/include/asm-um/processor-i386.h b/include/asm-um/processor-i386.h
index a2b7fe1..d7bca3e 100644
--- a/include/asm-um/processor-i386.h
+++ b/include/asm-um/processor-i386.h
@@ -1,25 +1,19 @@
 /*
- * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2002 - 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
 #ifndef __UM_PROCESSOR_I386_H
 #define __UM_PROCESSOR_I386_H
 
-#include "linux/string.h"
-#include "asm/host_ldt.h"
-#include "asm/segment.h"
-
-extern int host_has_cmov;
-
-/* include faultinfo structure */
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <asm/host_ldt.h>
+#include <asm/segment.h>
 #include "sysdep/faultinfo.h"
+#include "sysdep/tls.h"
 
-struct uml_tls_struct {
-	struct user_desc tls;
-	unsigned flushed:1;
-	unsigned present:1;
-};
+extern int host_has_cmov;
 
 struct arch_thread {
 	struct uml_tls_struct tls_array[GDT_ENTRY_TLS_ENTRIES];
@@ -38,8 +32,12 @@ struct arch_thread {
 
 static inline void arch_flush_thread(struct arch_thread *thread)
 {
+	int i;
+
 	/* Clear any TLS still hanging */
 	memset(&thread->tls_array, 0, sizeof(thread->tls_array));
+	for (i = 0; i < ARRAY_SIZE(thread->tls_array); i++)
+		thread->tls_array[i].tls.entry_number = GDT_ENTRY_TLS_MIN + i;
 }
 
 static inline void arch_copy_thread(struct arch_thread *from,
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
diff --git a/include/asm-um/thread_info.h b/include/asm-um/thread_info.h
index 356b83e..6aa19f3 100644
--- a/include/asm-um/thread_info.h
+++ b/include/asm-um/thread_info.h
@@ -83,6 +83,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_MEMDIE	 	5
 #define TIF_SYSCALL_AUDIT	6
 #define TIF_RESTORE_SIGMASK	7
+#define TIF_VCPU		8
 
 #define _TIF_SYSCALL_TRACE	(1 << TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
@@ -91,5 +92,6 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_MEMDIE		(1 << TIF_MEMDIE)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_RESTORE_SIGMASK	(1 << TIF_RESTORE_SIGMASK)
+#define _TIF_VCPU		(1 << TIF_VCPU)
 
 #endif
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
diff --git a/include/asm-x86/ia32.h b/include/asm-x86/ia32.h
index aa97332..b1c76ef 100644
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
diff --git a/include/asm-x86/thread_info_32.h b/include/asm-x86/thread_info_32.h
index 5bd5082..920c94a 100644
--- a/include/asm-x86/thread_info_32.h
+++ b/include/asm-x86/thread_info_32.h
@@ -142,6 +142,7 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_DEBUGCTLMSR		22	/* uses thread_struct.debugctlmsr */
 #define TIF_DS_AREA_MSR 	23      /* uses thread_struct.ds_area_msr */
 #define TIF_BTS_TRACE_TS        24      /* record scheduling event timestamps */
+#define TIF_VCPU		25
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
@@ -161,6 +162,7 @@ static inline struct thread_info *current_thread_info(void)
 #define _TIF_DEBUGCTLMSR	(1<<TIF_DEBUGCTLMSR)
 #define _TIF_DS_AREA_MSR	(1<<TIF_DS_AREA_MSR)
 #define _TIF_BTS_TRACE_TS	(1<<TIF_BTS_TRACE_TS)
+#define _TIF_VCPU		(1<<TIF_VCPU)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
diff --git a/include/asm-x86/thread_info_64.h b/include/asm-x86/thread_info_64.h
index 6c9b214..179d036 100644
--- a/include/asm-x86/thread_info_64.h
+++ b/include/asm-x86/thread_info_64.h
@@ -125,6 +125,7 @@ static inline struct thread_info *stack_thread_info(void)
 #define TIF_DEBUGCTLMSR		25	/* uses thread_struct.debugctlmsr */
 #define TIF_DS_AREA_MSR		26      /* uses thread_struct.ds_area_msr */
 #define TIF_BTS_TRACE_TS	27      /* record scheduling event timestamps */
+#define TIF_VCPU		28
 
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
 #define _TIF_SIGPENDING		(1<<TIF_SIGPENDING)
@@ -146,6 +147,7 @@ static inline struct thread_info *stack_thread_info(void)
 #define _TIF_DEBUGCTLMSR	(1<<TIF_DEBUGCTLMSR)
 #define _TIF_DS_AREA_MSR	(1<<TIF_DS_AREA_MSR)
 #define _TIF_BTS_TRACE_TS	(1<<TIF_BTS_TRACE_TS)
+#define _TIF_VCPU		(1<<TIF_VCPU)
 
 /* work to do on interrupt/exception return */
 #define _TIF_WORK_MASK \
diff --git a/include/asm-x86/unistd_32.h b/include/asm-x86/unistd_32.h
index 984123a..cadbdb1 100644
--- a/include/asm-x86/unistd_32.h
+++ b/include/asm-x86/unistd_32.h
@@ -332,6 +332,9 @@
 #define __NR_fallocate		324
 #define __NR_timerfd_settime	325
 #define __NR_timerfd_gettime	326
+#define __NR_new_mm		327
+#define __NR_switch_mm		328
+#define __NR_vcpu		329
 
 #ifdef __KERNEL__
 
diff --git a/include/asm-x86/unistd_64.h b/include/asm-x86/unistd_64.h
index 3883ceb..51bd17c 100644
--- a/include/asm-x86/unistd_64.h
+++ b/include/asm-x86/unistd_64.h
@@ -639,6 +639,12 @@ __SYSCALL(__NR_fallocate, sys_fallocate)
 __SYSCALL(__NR_timerfd_settime, sys_timerfd_settime)
 #define __NR_timerfd_gettime			287
 __SYSCALL(__NR_timerfd_gettime, sys_timerfd_gettime)
+#define __NR_new_mm				288
+__SYSCALL(__NR_new_mm, sys_new_mm)
+#define __NR_switch_mm				289
+__SYSCALL(__NR_switch_mm, stub_switch_mm)
+#define __NR_vcpu				290
+__SYSCALL(__NR_vcpu, stub_vcpu)
 
 
 #ifndef __NO_STUBS
diff --git a/include/linux/init_task.h b/include/linux/init_task.h
index 1f74e1d..5ed65eb 100644
--- a/include/linux/init_task.h
+++ b/include/linux/init_task.h
@@ -193,6 +193,7 @@ extern struct group_info init_groups;
 		[PIDTYPE_SID]  = INIT_PID_LINK(PIDTYPE_SID),		\
 	},								\
 	.dirties = INIT_PROP_LOCAL_SINGLE(dirties),			\
+	.vcpu		= NULL,						\
 	INIT_IDS							\
 	INIT_TRACE_IRQFLAGS						\
 	INIT_LOCKDEP							\
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
index 6a1e7af..5759bba 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -65,6 +65,7 @@ struct sched_param {
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/cputime.h>
+#include <asm/ldt.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -991,6 +992,24 @@ struct sched_rt_entity {
 #endif
 };
 
+struct vcpu_user {
+	enum { VCPU_SYSCALL, VCPU_SIGNAL } event;
+	struct user_regs regs;
+	siginfo_t siginfo;
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
+	struct user_desc tls_array[GDT_ENTRY_TLS_ENTRIES];
+#endif
+};
+
+struct vcpu {
+	struct vcpu_user user;
+	struct mm_struct *mm;
+	struct vcpu_user __user *state;
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
+	struct user_desc tls[GDT_ENTRY_TLS_ENTRIES];
+#endif
+};
+
 struct task_struct {
 	volatile long state;	/* -1 unrunnable, 0 runnable, >0 stopped */
 	void *stack;
@@ -1103,6 +1122,7 @@ struct task_struct {
   	cputime_t it_prof_expires, it_virt_expires;
 	unsigned long long it_sched_expires;
 	struct list_head cpu_timers[3];
+	struct vcpu *vcpu;
 
 /* process credentials */
 	uid_t uid,euid,suid,fsuid;
@@ -1750,6 +1770,7 @@ static inline int sas_ss_flags(unsigned long sp)
  * Routines for handling mm_structs
  */
 extern struct mm_struct * mm_alloc(void);
+extern struct mm_struct *dup_mm(struct task_struct *tsk);
 
 /* mmdrop drops the mm and the page tables */
 extern void __mmdrop(struct mm_struct *);
diff --git a/include/linux/signalfd.h b/include/linux/signalfd.h
index ea037f2..dd6ca3e 100644
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
 
 
diff --git a/kernel/Makefile b/kernel/Makefile
index 6c584c5..0119a37 100644
--- a/kernel/Makefile
+++ b/kernel/Makefile
@@ -9,7 +9,7 @@ obj-y     = sched.o fork.o exec_domain.o panic.o printk.o profile.o \
 	    rcupdate.o extable.o params.o posix-timers.o \
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o mutex.o \
 	    hrtimer.o rwsem.o nsproxy.o srcu.o \
-	    notifier.o ksysfs.o pm_qos_params.o
+	    notifier.o ksysfs.o pm_qos_params.o vcpu.o
 
 obj-$(CONFIG_SYSCTL) += sysctl_check.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
diff --git a/kernel/exit.c b/kernel/exit.c
index 073005b..bda5e7f 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -175,6 +175,11 @@ repeat:
 
 	write_unlock_irq(&tasklist_lock);
 	release_thread(p);
+
+	if (p->vcpu && p->vcpu->mm)
+		mmput(p->vcpu->mm);
+	kfree(p->vcpu);
+
 	call_rcu(&p->rcu, delayed_put_task_struct);
 
 	p = leader;
diff --git a/kernel/fork.c b/kernel/fork.c
index 9c042f9..3b8ed4c 100644
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
@@ -1086,6 +1086,8 @@ static struct task_struct *copy_process(unsigned long clone_flags,
 	clear_tsk_thread_flag(p, TIF_SIGPENDING);
 	init_sigpending(&p->pending);
 
+	p->vcpu = NULL;
+
 	p->utime = cputime_zero;
 	p->stime = cputime_zero;
 	p->gtime = cputime_zero;
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
diff --git a/kernel/signal.c b/kernel/signal.c
index 6af1210..67b5ec5 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1785,6 +1785,9 @@ relock:
 		if (!signr)
 			break; /* will return 0 */
 
+		if (test_thread_flag(TIF_VCPU))
+			break;
+
 		if ((current->ptrace & PT_PTRACED) && signr != SIGKILL) {
 			ptrace_signal_deliver(regs, cookie);
 
@@ -2106,7 +2109,7 @@ int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from)
 	 */
 	err = __put_user(from->si_signo, &to->si_signo);
 	err |= __put_user(from->si_errno, &to->si_errno);
-	err |= __put_user((short)from->si_code, &to->si_code);
+	err |= __put_user(from->si_code, &to->si_code);
 	switch (from->si_code & __SI_MASK) {
 	case __SI_KILL:
 		err |= __put_user(from->si_pid, &to->si_pid);
@@ -2126,6 +2129,9 @@ int copy_siginfo_to_user(siginfo_t __user *to, siginfo_t *from)
 #ifdef __ARCH_SI_TRAPNO
 		err |= __put_user(from->si_trapno, &to->si_trapno);
 #endif
+#ifdef __ARCH_SI_ERROR
+		err |= __put_user(from->si_error, &to->si_error);
+#endif
 		break;
 	case __SI_CHLD:
 		err |= __put_user(from->si_pid, &to->si_pid);
diff --git a/kernel/vcpu.c b/kernel/vcpu.c
new file mode 100644
index 0000000..5ca259e
--- /dev/null
+++ b/kernel/vcpu.c
@@ -0,0 +1,129 @@
+/*
+ * Copyright (C) 2008 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Licensed under the GPL
+ */
+
+#include <linux/sched.h>
+#include <asm/uaccess.h>
+#include <asm/desc.h>
+
+extern asmlinkage int sys_get_thread_area(struct user_desc __user *u_info);
+extern asmlinkage int sys_set_thread_area(struct user_desc __user *u_info);
+extern int do_switch(struct task_struct *task, int fd);
+
+long do_vcpu(int mm_fd, struct vcpu_user __user *new, struct pt_regs *regs)
+{
+	mm_segment_t fs;
+	struct vcpu *vcpu;
+	int err;
+
+	if (current->vcpu == NULL) {
+		current->vcpu = kmalloc(sizeof(struct vcpu), GFP_KERNEL);
+		if (current->vcpu == NULL)
+			return -ENOMEM;
+	}
+
+	vcpu = current->vcpu;
+	vcpu->mm = NULL;
+	vcpu->state = new;
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = pt_regs_to_ptrace(&vcpu->user.regs, regs);
+	set_fs(fs);
+	if (err)
+		return err;
+
+	err = ptrace_to_pt_regs(regs, &new->regs);
+	if (err)
+		return err;
+
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
+	{ int i;
+
+	memcpy(vcpu->tls, current->thread.tls_array, sizeof(vcpu->tls));
+	for (i = 0; i < ARRAY_SIZE(new->tls_array); i++){
+		fs = get_fs();
+		set_fs(KERNEL_DS);
+		vcpu->tls[i].entry_number = GDT_ENTRY_TLS_MIN + i;
+		err = sys_get_thread_area(&vcpu->tls[i]);
+		set_fs(fs);
+		if (err)
+			return err;
+
+		err = sys_set_thread_area(&new->tls_array[i]);
+		if (err)
+			return err;
+	}
+	}
+#endif
+
+	if (mm_fd != -1) {
+		vcpu->mm = current->mm;
+		atomic_inc(&vcpu->mm->mm_users);
+
+		err = do_switch(current, mm_fd);
+		if (err)
+			return err;
+	}
+
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
+	loadsegment(gs, current->thread.gs);
+#endif
+	set_thread_flag(TIF_VCPU);
+
+	return 0;
+}
+
+extern void do_switch_mm_struct(struct task_struct *task,
+				struct mm_struct *new);
+
+int unvcpu(struct pt_regs *regs, siginfo_t *siginfo)
+{
+	mm_segment_t fs;
+	struct vcpu *vcpu;
+	int err, event;
+
+	clear_thread_flag(TIF_VCPU);
+
+	vcpu = current->vcpu;
+	if (vcpu->mm != NULL) {
+		do_switch_mm_struct(current, vcpu->mm);
+		mmput(vcpu->mm);
+		vcpu->mm = NULL;
+	}
+
+	err = pt_regs_to_ptrace(&vcpu->state->regs, regs);
+	if (err)
+		return err;
+
+	err = -EFAULT;
+	if ((siginfo != NULL) &&
+	    (copy_to_user(&vcpu->state->siginfo, siginfo,
+			  sizeof(siginfo_t)) != 0))
+		return err;
+
+	event = (siginfo != NULL) ? VCPU_SIGNAL : VCPU_SYSCALL;
+	if (copy_to_user(&vcpu->state->event, &event, sizeof(event)) != 0)
+		return err;
+
+#if defined(CONFIG_X86_32) && !defined(CONFIG_UML)
+	{ int i;
+	for (i = 0; i < ARRAY_SIZE(vcpu->state->tls_array); i++){
+		fs = get_fs();
+		set_fs(KERNEL_DS);
+		err = sys_set_thread_area(&vcpu->tls[i]);
+		set_fs(fs);
+		if (err)
+			return err;
+	}
+	}
+#endif
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	err = ptrace_to_pt_regs(regs, &vcpu->user.regs);
+	set_fs(fs);
+
+	return err;
+}
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
