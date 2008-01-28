Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Mon, 28 Jan 2008 16:38:34 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080128213834.GA10281@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 10/10] SKAS4 - Guest get_mm and switch_mm
	support
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

UML guest SKAS4 support.

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
index 061a362..69c7470 100644
--- a/arch/um/include/skas/skas.h
+++ b/arch/um/include/skas/skas.h
@@ -6,14 +6,38 @@
 #ifndef __SKAS_H
 #define __SKAS_H
 
-#include "sysdep/ptrace.h"
+#ifndef __KERNEL__
+#include <unistd.h>
+#include <sys/syscall.h>
+#endif
+#include "uml-config.h"
 
-extern int have_siginfo_segv;
+#ifdef UML_CONFIG_X86_32
+#define __NR_new_mm             325
+#define __NR_switch_mm          326
+#else
+#define __NR_new_mm             286
+#define __NR_switch_mm          287
+#endif
+
+#define MM_ALL_REGS 0
+#define MM_SP_IP 1
+
+#define PTRACE_SWITCH_MM 33
+
+#ifndef __ASSEMBLY__
+
+#include "sysdep/ptrace.h"
 
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
@@ -22,4 +46,19 @@ extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
 
+#ifndef __KERNEL__
+static inline long new_mm(void)
+{
+	return syscall(__NR_new_mm, 0, 0, 0, 0, 0, 0, 0);
+}
+
+static inline long switch_mm(int mm_fd, unsigned long flags,
+			     unsigned long *new_regs, unsigned long *save_regs)
+{
+	return syscall(__NR_switch_mm, mm_fd, flags, new_regs, save_regs, 0, 0);
+}
+#endif
+
+#endif
+
 #endif
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
index 7595f77..2672829 100644
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
@@ -109,6 +112,20 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
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
index 2c6de0a..e5e8613 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -49,7 +49,7 @@ int __init start_uml(void)
 {
 	stack_protections((unsigned long) &cpu0_irqstack);
 	set_sigstack(cpu0_irqstack, THREAD_SIZE);
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		userspace_pid[0] = start_userspace(0);
 
 	init_new_thread_signals();
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
index efda5e1..cc86c0b 100644
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
 
@@ -43,7 +44,10 @@ static int __init init_syscall_regs(void)
 	unsigned long *stub_entry;
 
 	get_safe_registers(syscall_regs);
-	stub_entry = &batch_syscall_stub;
+	if (have_switch_mm)
+		stub_entry = &switch_mm_stub;
+	else
+		stub_entry = &batch_syscall_stub;
 
 	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
 		((unsigned long) stub_entry -
@@ -126,6 +130,32 @@ static long do_syscall_stub(struct mm_id *mm_idp, void **addr)
 	return ret;
 }
 
+static long do_syscall_stub_skas4(struct mm_id *mm_idp, void **addr)
+{
+	long ret;
+	unsigned long *return_regs;
+	int err;
+	sigset_t sigs, old;
+
+	return_regs = (unsigned long *) (mm_idp->stack + UM_KERN_PAGE_SIZE) -
+		MAX_REG_NR;
+	*(return_regs - 1) = self_mm_fd;
+
+	return_regs = (unsigned long *) (STUB_DATA + UM_KERN_PAGE_SIZE) -
+		MAX_REG_NR;
+
+	sigfillset(&sigs);
+	sigprocmask(SIG_SETMASK, &sigs, &old);
+	err = switch_mm(mm_idp->u.mm_fd, MM_SP_IP, syscall_regs, return_regs);
+	sigprocmask(SIG_SETMASK, &old, NULL);
+
+	ret = syscall_stub_done(mm_idp->stack);
+
+	*addr = check_init_stack(mm_idp, NULL);
+
+	return ret;
+}
+
 static int flush_syscalls(struct mm_id *mm_idp, void **addr, int extra)
 {
 	unsigned long *stack = check_init_stack(mm_idp, *addr);
@@ -134,10 +164,16 @@ static int flush_syscalls(struct mm_id *mm_idp, void **addr, int extra)
 	current = ((unsigned long) stack) & ~UM_KERN_PAGE_MASK;
 	end = UM_KERN_PAGE_SIZE;
 
+	if(have_switch_mm)
+		end -= (MAX_REG_NR + 1) * sizeof(long);
+
 	if (current + (10 + extra) * sizeof(long) < end)
 		return 0;
 
-	return do_syscall_stub(mm_idp, addr);
+	if (have_switch_mm)
+		return do_syscall_stub_skas4(mm_idp, addr);
+	else
+		return do_syscall_stub(mm_idp, addr);
 }
 
 long run_syscall_stub(struct mm_id *mm_idp, int syscall,
@@ -166,8 +202,12 @@ long run_syscall_stub(struct mm_id *mm_idp, int syscall,
 	*stack++ = expected;
 	*stack = 0;
 
-	if (done)
-		return do_syscall_stub(mm_idp, addr);
+	if (done) {
+		if (have_switch_mm)
+			return do_syscall_stub_skas4(mm_idp, addr);
+		else
+ 			return do_syscall_stub(mm_idp, addr);
+	}
 
 	*addr = stack;
 
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 522d0f1..9c2c086 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -227,7 +227,7 @@ static int userspace_tramp(void *stack)
 			}
 		}
 	}
-	if (!ptrace_faultinfo && (stack != NULL)) {
+	if (!ptrace_faultinfo) {
 		struct sigaction sa;
 
 		unsigned long v = STUB_CODE +
@@ -271,7 +271,7 @@ int start_userspace(unsigned long stub_stack)
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);
 
 	flags = CLONE_FILES;
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		flags |= CLONE_VM;
 	else
 		flags |= SIGCHLD;
@@ -384,8 +384,14 @@ void userspace(struct uml_pt_regs *regs)
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
@@ -473,6 +479,69 @@ int copy_context_skas0(unsigned long new_stack, int pid)
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
+	p = (void (*)(void)) (STUB_CODE +
+			      ((unsigned long) &switch_mm_stub -
+			       (unsigned long) &__syscall_stub_start));
+	(*p)();
+}
+
+int copy_context_skas4(struct mm_id *id)
+{
+	void *data = NULL;
+	unsigned long *return_regs, *fd_ptr, regs[MAX_REG_NR];
+	sigset_t sigs, old;
+	int err;
+
+	err = unmap(id, 0, STUB_START, 0, &data);
+	if (err)
+		return err;
+
+	err = unmap(id, STUB_END, task_size - STUB_END, 0, &data);
+	if (err)
+		return err;
+
+	return_regs = (unsigned long *) (id->stack + UM_KERN_PAGE_SIZE -
+					 MAX_REG_NR * sizeof(long));
+	fd_ptr = return_regs - 1;
+	*fd_ptr = self_mm_fd;
+
+	regs[REGS_IP_INDEX] = (unsigned long) unmap_new_as;
+	regs[REGS_SP_INDEX] = id->stack + UM_KERN_PAGE_SIZE / 2;
+
+	sigfillset(&sigs);
+	sigprocmask(SIG_SETMASK, &sigs, &old);
+
+	err = switch_mm(id->u.mm_fd, MM_SP_IP, regs, return_regs);
+
+	sigprocmask(SIG_SETMASK, &old, NULL);
+
+	return err;
+}
+
 /*
  * This is used only, if stub pages are needed, while proc_mm is
  * available. Opening /proc/mm creates a new mm_context, which lacks
@@ -630,8 +699,15 @@ void __switch_mm(struct mm_id *mm_idp)
 		err = ptrace(OLD_PTRACE_SWITCH_MM, userspace_pid[0], 0,
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
index 0e0f738..a012723 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -161,6 +161,9 @@ static int disable_switch_mm;
 int have_siginfo_segv;
 static int disable_siginfo_segv;
 
+int have_ptrace_switch_mm;
+static int disable_ptrace_switch_mm;
+
 int skas_needs_stub;
 
 static int __init skas0_cmd_param(char *str, int* add)
@@ -168,8 +171,10 @@ static int __init skas0_cmd_param(char *str, int* add)
 	disable_ptrace_faultinfo = 1;
 	disable_ptrace_ldt = 1;
 	disable_proc_mm = 1;
+
 	disable_switch_mm = 1;
 	disable_siginfo_segv = 1;
+	disable_ptrace_switch_mm = 1;
 
 	return 0;
 }
@@ -483,6 +488,18 @@ static inline void check_skas3_proc_mm(void)
 	}
 }
 
+static void can_do_skas3(void)
+{
+	non_fatal("Checking for the skas3 patch in the host:\n");
+
+	check_skas3_proc_mm();
+	check_skas3_ptrace_faultinfo();
+	check_skas3_ptrace_ldt();
+
+	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
+		skas_needs_stub = 1;
+}
+
 static void *fault_address;
 
 static int check_fault_info(struct faultinfo *fi)
@@ -614,17 +631,207 @@ static int check_siginfo(void)
 	return ok;
 }
 
-void can_do_skas(void)
+static char *mm_stack;
+static unsigned long return_regs[MAX_REG_NR];
+int self_mm_fd;
+
+static int switch_mm_works;
+
+static void after_switch(void)
 {
-	non_fatal("Checking for the skas3 patch in the host:\n");
+	/*
+	 * If we are really in a new address space, setting this to
+	 * zero won't affect the value of 1 already set in the old
+	 * address space.
+	 */
+	switch_mm_works = 0;
 
-	check_skas3_proc_mm();
-	check_skas3_ptrace_faultinfo();
-	check_skas3_ptrace_ldt();
-	check_siginfo();
+	switch_mm(self_mm_fd, MM_ALL_REGS, return_regs, NULL);
+}
 
-	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
+static int check_switch_mm(void)
+{
+	unsigned long regs[MAX_REG_NR];
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
+	regs[REGS_IP_INDEX] = (unsigned long) after_switch;
+	regs[REGS_SP_INDEX] = ((unsigned long) &mm_stack[UM_KERN_PAGE_SIZE]) -
+		sizeof(void *);
+
+	non_fatal("\tswitching over ... ");
+	err = switch_mm(there, MM_SP_IP, regs, return_regs);
+	if (err < 0)
+		goto bad;
+	non_fatal("switched back ... ");
+	switch_mm_works = 1;
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
+static int can_do_skas4(void)
+{
+	int ret;
+
+	non_fatal("Checking for new_mm and switch_mm support in the host:\n");
+
+	ret = check_switch_mm() && check_ptrace_switch_mm() && check_siginfo();
+	if (ret)
 		skas_needs_stub = 1;
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
diff --git a/arch/um/sys-i386/stub.S b/arch/um/sys-i386/stub.S
index 890dc50..3cfb6e8 100644
--- a/arch/um/sys-i386/stub.S
+++ b/arch/um/sys-i386/stub.S
@@ -1,5 +1,8 @@
 #include "uml-config.h"
 #include "as-layout.h"
+#include "skas/skas.h"
+
+#define MAX_REG_NR 17
 
 #define PROCESS_LIST \
 	/* load pointer to first operation */ \
@@ -43,3 +46,16 @@ batch_syscall_stub:
 	PROCESS_LIST
 	/* stop */
 	int3
+
+ 	.globl switch_mm_stub
+switch_mm_stub:
+	PROCESS_LIST
+
+	mov	$__NR_switch_mm, %eax
+	mov	ASM_STUB_DATA + UM_KERN_PAGE_SIZE - MAX_REG_NR * 4 - 4, %ebx
+	mov	$MM_ALL_REGS, %ecx
+	mov	$(ASM_STUB_DATA + UM_KERN_PAGE_SIZE - MAX_REG_NR * 4), %edx
+	xor	%esi, %esi
+	int	$0x80
+
+	int3
diff --git a/arch/um/sys-x86_64/stub.S b/arch/um/sys-x86_64/stub.S
index 143a16c..fb10353 100644
--- a/arch/um/sys-x86_64/stub.S
+++ b/arch/um/sys-x86_64/stub.S
@@ -1,5 +1,8 @@
 #include "uml-config.h"
 #include "as-layout.h"
+#include "skas/skas.h"
+
+#define MAX_REG_NR 27
 
 #define PROCESS_LIST \
 	mov	$(ASM_STUB_DATA >> 32), %rbx; \
@@ -46,3 +49,21 @@ batch_syscall_stub:
 	PROCESS_LIST
 	/* stop */
 	int3
+
+ 	.globl switch_mm_stub
+switch_mm_stub:
+	PROCESS_LIST
+
+	mov	$__NR_switch_mm, %rax
+	mov	$(ASM_STUB_DATA >> 32), %rdi
+	sal	$32, %rdi
+	mov	$(ASM_STUB_DATA & 0xffffffff), %rsi
+	add	%rsi, %rdi
+	add	$(UM_KERN_PAGE_SIZE - MAX_REG_NR * 8 - 8), %rdi
+	mov	(%rdi), %rdi
+	mov	$MM_ALL_REGS, %rsi
+	mov	$(ASM_STUB_DATA + UM_KERN_PAGE_SIZE - MAX_REG_NR * 8), %rdx
+	xor	%r10, %r10
+	syscall
+
+	int3
diff --git a/arch/um/sys-x86_64/syscalls.c b/arch/um/sys-x86_64/syscalls.c
index ff012ba..00131f9 100644
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

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
