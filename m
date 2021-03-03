Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTwW-005VcO-LQ
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 16:01:50 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 26/27] um: Implement kernel side of SECCOMP based process
 handling
Date: Wed,  3 Mar 2021 16:55:22 +0100
Message-Id: <20210303155523.124277-27-benjamin@sipsolutions.net>
In-Reply-To: <20210303155523.124277-1-benjamin@sipsolutions.net>
References: <20210303155523.124277-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>, Johannes Berg <johannes@sipsolutions.net>

This adds the kernel side of the seccomp based process handling.

Co-authored-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/os-Linux/skas/mem.c     |  36 ++-
 arch/um/os-Linux/skas/process.c | 534 +++++++++++++++++++++++---------
 arch/um/os-Linux/start_up.c     |   3 -
 3 files changed, 414 insertions(+), 159 deletions(-)

diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index b52d536d2d4d..648d9406eb25 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -4,6 +4,7 @@
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/kconfig.h>
 #include <stddef.h>
 #include <unistd.h>
 #include <errno.h>
@@ -22,6 +23,7 @@
 extern char __syscall_stub_start[];
 
 extern void wait_stub_done(int pid);
+void wait_stub_done_seccomp(int pid, struct stub_data *data, int running);
 
 static inline unsigned long *check_init_stack(struct mm_id *mm_idp,
 					      unsigned long *stack)
@@ -56,24 +58,30 @@ static inline long do_syscall_stub(struct mm_id *mm_idp)
 	int n, i;
 	int err, pid = mm_idp->u.pid;
 
-	n = ptrace_setregs(pid, syscall_regs);
-	if (n < 0) {
-		printk(UM_KERN_ERR "Registers - \n");
-		for (i = 0; i < MAX_REG_NR; i++)
-			printk(UM_KERN_ERR "\t%d\t0x%lx\n", i, syscall_regs[i]);
-		panic("%s : PTRACE_SETREGS failed, errno = %d\n",
-		      __func__, -n);
-	}
-
 	/* Inform process how much we have filled in. */
 	proc_data->syscall_data_len = mm_idp->syscall_data_len;
 
-	err = ptrace(PTRACE_CONT, pid, 0, 0);
-	if (err)
-		panic("Failed to continue stub, pid = %d, errno = %d\n", pid,
-		      errno);
+	if (using_seccomp) {
+		/* We never leave the signal seccomp signal handler in the child. */
+		proc_data->restart_wait = 1;
+		wait_stub_done_seccomp(pid, proc_data, 0);
+	} else {
+		n = ptrace_setregs(pid, syscall_regs);
+		if (n < 0) {
+			printk(UM_KERN_ERR "Registers -\n");
+			for (i = 0; i < MAX_REG_NR; i++)
+				printk(UM_KERN_ERR "\t%d\t0x%lx\n", i, syscall_regs[i]);
+			panic("%s : PTRACE_SETREGS failed, errno = %d\n",
+			      __func__, -n);
+		}
+
+		err = ptrace(PTRACE_CONT, pid, 0, 0);
+		if (err)
+			panic("Failed to continue stub, pid = %d, errno = %d\n",
+			      pid, errno);
 
-	wait_stub_done(pid);
+		wait_stub_done(pid);
+	}
 
 	/*
 	 * proc_data->err will be non-zero if there was an (unexpected) error.
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index a3f0dd0f47d0..ceb75ac47b5f 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -1,9 +1,11 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
+ * Copyright (C) 2021 Benjamin Berg <benjamin@sipsolutions.net>
  * Copyright (C) 2015 Thomas Meyer (thomas@m3y3r.de)
  * Copyright (C) 2002- 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  */
 
+#include <linux/kconfig.h>
 #include <stdlib.h>
 #include <unistd.h>
 #include <sched.h>
@@ -21,7 +23,13 @@
 #include <registers.h>
 #include <skas.h>
 #include <sysdep/stub.h>
+#include <sysdep/mcontext.h>
 #include <linux/threads.h>
+#include <sys/resource.h>
+#include <sys/prctl.h>
+#include <linux/filter.h>
+#include <linux/seccomp.h>
+#include <linux/futex.h>
 
 int is_skas_winch(int pid, int fd, void *data)
 {
@@ -136,6 +144,58 @@ void wait_stub_done(int pid)
 	fatal_sigsegv();
 }
 
+#ifdef CONFIG_UML_SECCOMP
+void wait_stub_done_seccomp(int pid, struct stub_data *data, int running)
+{
+	int ret;
+
+	do {
+		if (!running) {
+			data->signal = 0;
+			data->futex = FUTEX_IN_CHILD;
+			CATCH_EINTR(syscall(__NR_futex, &data->futex,
+					    FUTEX_WAKE, 1, NULL, NULL, 0));
+		}
+
+		do {
+			ret = syscall(__NR_futex, &data->futex,
+				      FUTEX_WAIT, FUTEX_IN_CHILD,
+				      NULL, NULL, 0);
+		} while ((ret == -1 && errno == EINTR) || data->futex == FUTEX_IN_CHILD);
+
+		running = 0;
+
+		/* We may receive a SIGALRM, if we do, we are not done yet and need to iterate. */
+	} while (data->signal == SIGALRM);
+
+	if (ret < 0 && errno != EAGAIN) {
+		printk(UM_KERN_ERR "%s : waiting for child futex failed, errno = %d\n",
+		       __func__, errno);
+		goto out_kill;
+	}
+
+	if (data->mctx_offset > sizeof(data->sigstack) - sizeof(mcontext_t)) {
+		printk(UM_KERN_ERR "%s : invalid mcontext offset", __func__);
+		goto out_kill;
+	}
+
+	if (data->signal != SIGTRAP) {
+		printk(UM_KERN_ERR "%s : expected SIGTRAP but got %d",
+		       __func__, data->signal);
+		goto out_kill;
+	}
+
+	return;
+
+out_kill:
+	printk(UM_KERN_ERR "%s : failed to wait for SIGTRAP, pid = %d, errno = %d\n",
+	       __func__, pid, errno);
+	fatal_sigsegv();
+}
+#else
+void wait_stub_done_seccomp(int pid, struct stub_data *data, int running);
+#endif
+
 extern unsigned long current_stub_stack(void);
 
 static void get_skas_faultinfo(int pid, struct faultinfo *fi, unsigned long *aux_fp_regs)
@@ -197,16 +257,16 @@ extern char __syscall_stub_start[];
  */
 static int userspace_tramp(void *stack)
 {
-	struct sigaction sa;
 	struct stub_data *data;
 	void *addr;
 	int fd;
 	unsigned long long offset;
-	unsigned long segv_handler = STUB_CODE +
-				     (unsigned long) stub_segv_handler -
-				     (unsigned long) __syscall_stub_start;
 
-	ptrace(PTRACE_TRACEME, 0, 0, 0);
+	if (!using_seccomp)
+		ptrace(PTRACE_TRACEME, 0, 0, 0);
+
+	/* Needed for seccomp, but this is sane anyway. */
+	prctl(PR_SET_NO_NEW_PRIVS, 1, 0, 0, 0);
 
 	signal(SIGTERM, SIG_DFL);
 	signal(SIGWINCH, SIG_IGN);
@@ -237,17 +297,127 @@ static int userspace_tramp(void *stack)
 	 */
 
 	set_sigstack((void *) &data->sigstack, sizeof(data->sigstack));
-	sigemptyset(&sa.sa_mask);
-	sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
-	sa.sa_sigaction = (void *) segv_handler;
-	sa.sa_restorer = NULL;
-	if (sigaction(SIGSEGV, &sa, NULL) < 0) {
-		os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
-			__func__, errno);
-		exit(1);
+
+	if (using_seccomp) {
+		struct rlimit lim;
+			struct sock_filter filter[] = {
+#if __BITS_PER_LONG > 32
+			/* [0] Load upper 32bit of instruction pointer from seccomp_data */
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+				(offsetof(struct seccomp_data, instruction_pointer) + 4)),
+
+			/* [1] Jump forward 3 instructions if the upper address is not identical */
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (STUB_CODE) >> 32, 0, 4),
+#endif
+			/* [2] Load lower 32bit of instruction pointer from seccomp_data */
+			BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
+				(offsetof(struct seccomp_data, instruction_pointer))),
+
+			/* [3] Mask out lower bits */
+			BPF_STMT(BPF_ALU | BPF_AND | BPF_K, 0xfffff000),
+
+			/* [4] Jump to [6] if the lower bits are not on the expected page */
+			BPF_JUMP(BPF_JMP | BPF_JEQ | BPF_K, (STUB_CODE) & 0xfffff000, 0, 1),
+
+			/* [5] Permitted call, allow */
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW),
+
+			/* [6] Restricted call, replace with SIGSYS */
+			BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_TRAP),
+		};
+		struct sock_fprog prog = {
+			.len = ARRAY_SIZE(filter),
+			.filter = filter,
+		};
+
+		/*
+		 *With seccomp we return normally from the signal handler, so
+		 * avoid setting things up through libc which may do its own
+		 * thing for restoring.
+		 */
+		struct sigaction_real {
+			void *sa_handler_;
+			unsigned long sa_flags;
+			void *sa_restorer;
+			sigset_t sa_mask;
+		} sa;
+
+		unsigned long v = STUB_CODE +
+				  (unsigned long) stub_signal_interrupt -
+				  (unsigned long) __syscall_stub_start;
+		unsigned long r = STUB_CODE +
+				  (unsigned long) stub_signal_restorer -
+				  (unsigned long) __syscall_stub_start;
+
+		/* Never coredump */
+		lim.rlim_cur = 0;
+		lim.rlim_max = 0;
+		if (setrlimit(RLIMIT_CORE, &lim) < 0) {
+			os_info("Could not set coredump size limit, errno = %d\n",
+				errno);
+			exit(1);
+		}
+
+		sigemptyset(&sa.sa_mask);
+		sigaddset(&sa.sa_mask, SIGALRM);
+		sigaddset(&sa.sa_mask, SIGCHLD);
+		sa.sa_flags = SA_ONSTACK | SA_SIGINFO | 0x04000000; /* SA_RESTORER */
+		sa.sa_handler_ = (void *)v;
+		sa.sa_restorer = (void *)r;
+		if (syscall(__NR_rt_sigaction, SIGSEGV, &sa, NULL, 8) < 0) {
+			os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
+				__func__, errno);
+			exit(1);
+		}
+
+		if (syscall(__NR_rt_sigaction, SIGSYS, &sa, NULL, 8) < 0) {
+			os_info("%s - setting SIGSYS handler failed - errno = %d\n",
+				__func__, errno);
+			exit(1);
+		}
+
+		if (syscall(__NR_rt_sigaction, SIGALRM, &sa, NULL, 8) < 0) {
+			os_info("%s - setting SIGALRM handler failed - errno = %d\n",
+				__func__, errno);
+			exit(1);
+		}
+
+		if (syscall(__NR_rt_sigaction, SIGTRAP, &sa, NULL, 8) < 0) {
+			os_info("%s - setting SIGTRAP handler failed - errno = %d\n",
+				__func__, errno);
+			exit(1);
+		}
+
+		if (syscall(__NR_rt_sigaction, SIGFPE, &sa, NULL, 8) < 0) {
+			os_info("%s - setting SIGFPE handler failed - errno = %d\n",
+				__func__, errno);
+			exit(1);
+		}
+
+		if (syscall(__NR_seccomp, SECCOMP_SET_MODE_FILTER,
+			    SECCOMP_FILTER_FLAG_TSYNC, &prog) != 0)
+			exit(42);
+
+		trap_myself();
+	} else {
+		struct sigaction sa;
+		unsigned long segv_handler = STUB_CODE +
+					     (unsigned long) stub_segv_handler -
+					     (unsigned long) __syscall_stub_start;
+
+		sigemptyset(&sa.sa_mask);
+		sa.sa_flags = SA_ONSTACK | SA_NODEFER | SA_SIGINFO;
+		sa.sa_sigaction = (void *) segv_handler;
+		sa.sa_restorer = NULL;
+		if (sigaction(SIGSEGV, &sa, NULL) < 0) {
+			os_info("%s - setting SIGSEGV handler failed - errno = %d\n",
+				__func__, errno);
+			exit(1);
+		}
+
+		kill(os_getpid(), SIGSTOP);
 	}
 
-	kill(os_getpid(), SIGSTOP);
 	return 0;
 }
 
@@ -273,6 +443,7 @@ int start_userspace(struct mm_id *id)
 	void *stack;
 	unsigned long sp;
 	int status, n, flags, err;
+	struct stub_data *proc_data = (void *) id->stack;
 
 	/* setup a temporary stack page */
 	stack = mmap(NULL, UM_KERN_PAGE_SIZE,
@@ -290,6 +461,9 @@ int start_userspace(struct mm_id *id)
 
 	flags = CLONE_FILES | SIGCHLD;
 
+	if (using_seccomp)
+		proc_data->futex = FUTEX_IN_CHILD;
+
 	/* clone into new userspace process */
 	id->u.pid = clone(userspace_tramp, (void *) sp, flags, (void *) id->stack);
 	if (id->u.pid < 0) {
@@ -299,29 +473,33 @@ int start_userspace(struct mm_id *id)
 		return err;
 	}
 
-	do {
-		CATCH_EINTR(n = waitpid(id->u.pid, &status, WUNTRACED | __WALL));
-		if (n < 0) {
+	if (using_seccomp) {
+		wait_stub_done_seccomp(id->u.pid, proc_data, 1);
+	} else {
+		do {
+			CATCH_EINTR(n = waitpid(id->u.pid, &status, WUNTRACED | __WALL));
+			if (n < 0) {
+				err = -errno;
+				printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
+				       __func__, errno);
+				goto out_kill;
+			}
+		} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
+
+		if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
+			err = -EINVAL;
+			printk(UM_KERN_ERR "%s : expected SIGSTOP, got status = %d\n",
+			       __func__, status);
+			goto out_kill;
+		}
+
+		if (ptrace(PTRACE_SETOPTIONS, id->u.pid, NULL,
+			   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
 			err = -errno;
-			printk(UM_KERN_ERR "%s : wait failed, errno = %d\n",
+			printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
 			       __func__, errno);
 			goto out_kill;
 		}
-	} while (WIFSTOPPED(status) && (WSTOPSIG(status) == SIGALRM));
-
-	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP)) {
-		err = -EINVAL;
-		printk(UM_KERN_ERR "%s : expected SIGSTOP, got status = %d\n",
-		       __func__, status);
-		goto out_kill;
-	}
-
-	if (ptrace(PTRACE_SETOPTIONS, id->u.pid, NULL,
-		   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
-		       __func__, errno);
-		goto out_kill;
 	}
 
 	if (munmap(stack, UM_KERN_PAGE_SIZE) < 0) {
@@ -341,7 +519,9 @@ int start_userspace(struct mm_id *id)
 void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 {
 	int err, status, op, pid = userspace_pid[0];
-	siginfo_t si;
+	siginfo_t si_ptrace;
+	siginfo_t *si;
+	int sig;
 
 	/* Handle any immediate reschedules or signals */
 	interrupt_end();
@@ -350,94 +530,148 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 		if (kill_userspace_mm[0])
 			fatal_sigsegv();
 
-		/*
-		 * This can legitimately fail if the process loads a
-		 * bogus value into a segment register.  It will
-		 * segfault and PTRACE_GETREGS will read that value
-		 * out of the process.  However, PTRACE_SETREGS will
-		 * fail.  In this case, there is nothing to do but
-		 * just kill the process.
-		 */
-		if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp)) {
-			printk(UM_KERN_ERR "%s - ptrace set regs failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+		if (using_seccomp) {
+			struct stub_data *proc_data = (void *)current_stub_stack();
+			int ret;
 
-		if (put_fp_registers(pid, regs->fp)) {
-			printk(UM_KERN_ERR "%s - ptrace set fp regs failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+			set_stub_state(regs, proc_data, singlestepping(NULL));
 
-		if (singlestepping(NULL))
-			op = PTRACE_SYSEMU_SINGLESTEP;
-		else
-			op = PTRACE_SYSEMU;
+			/* Must have been reset by the syscall caller */
+			if (proc_data->restart_wait != 0)
+				panic("Programming error: Flag to only run syscalls in child was not cleared!");
 
-		if (ptrace(op, pid, 0, 0)) {
-			printk(UM_KERN_ERR "%s - ptrace continue failed, op = %d, errno = %d\n",
-			       __func__, op, errno);
-			fatal_sigsegv();
-		}
+			proc_data->signal = 0;
+			proc_data->futex = FUTEX_IN_CHILD;
+			CATCH_EINTR(syscall(__NR_futex, &proc_data->futex,
+					    FUTEX_WAKE, 1, NULL, NULL, 0));
+			do {
+				ret = syscall(__NR_futex, &proc_data->futex,
+					      FUTEX_WAIT, FUTEX_IN_CHILD, NULL, NULL, 0);
+			} while ((ret == -1 && errno == EINTR) ||
+				 proc_data->futex == FUTEX_IN_CHILD);
 
-		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
-		if (err < 0) {
-			printk(UM_KERN_ERR "%s - wait failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+			sig = proc_data->signal;
 
-		regs->is_user = 1;
-		if (ptrace(PTRACE_GETREGS, pid, 0, regs->gp)) {
-			printk(UM_KERN_ERR "%s - PTRACE_GETREGS failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+			get_stub_state(regs, proc_data);
 
-		if (get_fp_registers(pid, regs->fp)) {
-			printk(UM_KERN_ERR "%s -  get_fp_registers failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
+			if (proc_data->si_offset > sizeof(proc_data->sigstack) - sizeof(*si))
+				panic("%s - Invalid siginfo offset from child",
+				      __func__);
+			si = (void *)&proc_data->sigstack[proc_data->si_offset];
 
-		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
+			regs->is_user = 1;
 
-		if (WIFSTOPPED(status)) {
-			int sig = WSTOPSIG(status);
+			/* Fill in ORIG_RAX and extract fault information */
+			PT_SYSCALL_NR(regs->gp) = si->si_syscall;
+			if (sig == SIGSEGV) {
+				mcontext_t *mcontext = (void *)&proc_data->sigstack[proc_data->mctx_offset];
 
-			/* These signal handlers need the si argument.
-			 * The SIGIO and SIGALARM handlers which constitute the
-			 * majority of invocations, do not use it.
+				GET_FAULTINFO_FROM_MC(regs->faultinfo, mcontext);
+			}
+		} else {
+			/*
+			 * This can legitimately fail if the process loads a
+			 * bogus value into a segment register.  It will
+			 * segfault and PTRACE_GETREGS will read that value
+			 * out of the process.  However, PTRACE_SETREGS will
+			 * fail.  In this case, there is nothing to do but
+			 * just kill the process.
 			 */
-			switch (sig) {
-			case SIGSEGV:
-			case SIGTRAP:
-			case SIGILL:
-			case SIGBUS:
-			case SIGFPE:
-			case SIGWINCH:
-				ptrace(PTRACE_GETSIGINFO, pid, 0, (struct siginfo *)&si);
-				break;
+			if (ptrace(PTRACE_SETREGS, pid, 0, regs->gp)) {
+				printk(UM_KERN_ERR "%s - ptrace set regs failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
+			}
+
+			if (put_fp_registers(pid, regs->fp)) {
+				printk(UM_KERN_ERR "%s - ptrace set fp regs failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
+			}
+
+			if (singlestepping(NULL))
+				op = PTRACE_SYSEMU_SINGLESTEP;
+			else
+				op = PTRACE_SYSEMU;
+
+			if (ptrace(op, pid, 0, 0)) {
+				printk(UM_KERN_ERR "%s - ptrace continue failed, op = %d, errno = %d\n",
+				       __func__, op, errno);
+				fatal_sigsegv();
+			}
+
+			CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
+			if (err < 0) {
+				printk(UM_KERN_ERR "%s - wait failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
+			}
+
+			regs->is_user = 1;
+			if (ptrace(PTRACE_GETREGS, pid, 0, regs->gp)) {
+				printk(UM_KERN_ERR "%s - PTRACE_GETREGS failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
+			}
+
+			if (get_fp_registers(pid, regs->fp)) {
+				printk(UM_KERN_ERR "%s -  get_fp_registers failed, errno = %d\n",
+				       __func__, errno);
+				fatal_sigsegv();
 			}
 
+			if (WIFSTOPPED(status)) {
+				sig = WSTOPSIG(status);
+
+				/* These signal handlers need the si argument
+				 * and SIGSEGV needs the faultinfo.
+				 * The SIGIO and SIGALARM handlers which constitute the
+				 * majority of invocations, do not use it.
+				 */
+				switch (sig) {
+				case SIGSEGV:
+					get_skas_faultinfo(pid,
+							   &regs->faultinfo,
+							   aux_fp_regs);
+					fallthrough;
+				case SIGTRAP:
+				case SIGILL:
+				case SIGBUS:
+				case SIGFPE:
+				case SIGWINCH:
+					ptrace(PTRACE_GETSIGINFO, pid, 0,
+					       (struct siginfo *)&si_ptrace);
+					si = &si_ptrace;
+					break;
+				default:
+					si = NULL;
+					break;
+				}
+			} else {
+				sig = 0;
+			}
+		}
+
+		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
+
+		if (sig) {
 			switch (sig) {
 			case SIGSEGV:
-				get_skas_faultinfo(pid,
-						   &regs->faultinfo, aux_fp_regs);
-
-				if (PTRACE_FULL_FAULTINFO)
-					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)&si,
-							     regs);
+				if (using_seccomp || PTRACE_FULL_FAULTINFO)
+					(*sig_info[SIGSEGV])(SIGSEGV, (struct siginfo *)si,
+						     regs);
 				else
 					segv(regs->faultinfo, 0, 1, NULL);
 
+				break;
+			case SIGSYS:
+				handle_syscall(regs);
 				break;
 			case SIGTRAP + 0x80:
 				handle_trap(pid, regs);
 				break;
 			case SIGTRAP:
-				relay_signal(SIGTRAP, (struct siginfo *)&si, regs);
+				relay_signal(SIGTRAP, (struct siginfo *)si, regs);
 				break;
 			case SIGALRM:
 				break;
@@ -447,7 +681,7 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 			case SIGFPE:
 			case SIGWINCH:
 				block_signals_trace();
-				(*sig_info[sig])(sig, (struct siginfo *)&si, regs);
+				(*sig_info[sig])(sig, (struct siginfo *)si, regs);
 				unblock_signals_trace();
 				break;
 			default:
@@ -471,9 +705,15 @@ static int __init init_thread_regs(void)
 {
 	get_safe_registers(thread_regs.gp, thread_regs.fp);
 	/* Set parent's instruction pointer to start of clone-stub */
-	thread_regs.gp[REGS_IP_INDEX] = STUB_CODE +
-				(unsigned long) stub_clone_handler -
-				(unsigned long) __syscall_stub_start;
+	if (using_seccomp)
+		thread_regs.gp[REGS_IP_INDEX] = STUB_CODE +
+					(unsigned long) stub_clone_handler_seccomp -
+					(unsigned long) __syscall_stub_start;
+	else
+		thread_regs.gp[REGS_IP_INDEX] = STUB_CODE +
+					(unsigned long) stub_clone_handler -
+					(unsigned long) __syscall_stub_start;
+
 	thread_regs.gp[REGS_SP_INDEX] = STUB_DATA + UM_KERN_PAGE_SIZE -
 		sizeof(void *);
 #ifdef __SIGNAL_FRAMESIZE
@@ -497,45 +737,50 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 	 * prepare offset and fd of child's stack as argument for parent's
 	 * and child's mmap2 calls
 	 */
-	*data = ((struct stub_data) {
-		.offset	= MMAP_OFFSET(new_offset),
-		.fd     = new_fd,
-		.err    = -ESRCH,
-		.child_err = 0,
-	});
-
-	*child_data = ((struct stub_data) {
-		.child_err = -ESRCH,
-	});
-
-	err = ptrace_setregs(from->u.pid, thread_regs.gp);
-	if (err < 0) {
-		err = -errno;
-		printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
-		      __func__, from->u.pid, -err);
-		return err;
-	}
+	data->offset     = MMAP_OFFSET(new_offset);
+	data->fd         = new_fd;
+	data->err        = -ESRCH;
+	data->child_err  = 0;
 
-	err = put_fp_registers(from->u.pid, thread_regs.fp);
-	if (err < 0) {
-		printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
-		       __func__, from->u.pid, err);
-		return err;
-	}
+	child_data->child_err = -ESRCH;
 
-	/*
-	 * Wait, until parent has finished its work: read child's pid from
-	 * parent's stack, and check, if bad result.
-	 */
-	err = ptrace(PTRACE_CONT, from->u.pid, 0, 0);
-	if (err) {
-		err = -errno;
-		printk(UM_KERN_ERR "Failed to continue new process, pid = %d, errno = %d\n",
-		       from->u.pid, errno);
-		return err;
-	}
+	if (using_seccomp) {
+		set_stub_state(&thread_regs, data, 0);
+
+		child_data->futex = FUTEX_IN_CHILD;
+
+		data->restart_wait = 0;
+		wait_stub_done_seccomp(from->u.pid, data, 0);
+	} else {
+		err = ptrace_setregs(from->u.pid, thread_regs.gp);
+		if (err < 0) {
+			err = -errno;
+			printk(UM_KERN_ERR "%s : PTRACE_SETREGS failed, pid = %d, errno = %d\n",
+			      __func__, from->u.pid, -err);
+			return err;
+		}
+
+		err = put_fp_registers(from->u.pid, thread_regs.fp);
+		if (err < 0) {
+			printk(UM_KERN_ERR "%s : put_fp_registers failed, pid = %d, err = %d\n",
+			       __func__, from->u.pid, err);
+			return err;
+		}
 
-	wait_stub_done(from->u.pid);
+		/*
+		 * Wait, until parent has finished its work: read child's pid from
+		 * parent's stack, and check, if bad result.
+		 */
+		err = ptrace(PTRACE_CONT, from->u.pid, 0, 0);
+		if (err) {
+			err = -errno;
+			printk(UM_KERN_ERR "Failed to continue new process, pid = %d, errno = %d\n",
+			       from->u.pid, errno);
+			return err;
+		}
+
+		wait_stub_done(from->u.pid);
+	}
 
 	id->u.pid = data->err;
 	if (id->u.pid < 0) {
@@ -548,7 +793,11 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 	 * Wait, until child has finished too: read child's result from
 	 * child's stack and check it.
 	 */
-	wait_stub_done(id->u.pid);
+	if (using_seccomp)
+		wait_stub_done_seccomp(id->u.pid, child_data, 1);
+	else
+		wait_stub_done(id->u.pid);
+
 	if (child_data->child_err != STUB_DATA) {
 		printk(UM_KERN_ERR "%s - stub-child %d reports error %ld\n",
 		       __func__, id->u.pid, data->child_err);
@@ -556,7 +805,8 @@ int copy_context_skas0(struct mm_id *id, struct mm_id *from)
 		goto out_kill;
 	}
 
-	if (ptrace(PTRACE_SETOPTIONS, id->u.pid, NULL,
+	if (!using_seccomp &&
+	    ptrace(PTRACE_SETOPTIONS, id->u.pid, NULL,
 		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 2a581ea1b0ef..3f8473a58de1 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -377,12 +377,9 @@ void __init os_early_checks(void)
 	using_seccomp = 0;
 
 	if (init_seccomp()) {
-		/* Not fully implemented */
-#if 0
 		using_seccomp = 1;
 
 		return;
-#endif
 	}
 #endif
 
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

