Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHTqx-005UJD-2J
 for linux-um@lists.infradead.org; Wed, 03 Mar 2021 15:56:07 +0000
From: Benjamin Berg <benjamin@sipsolutions.net>
Subject: [PATCH 03/27] um: Drop support for hosts without SYSEMU_SINGLESTEP
 support
Date: Wed,  3 Mar 2021 16:54:59 +0100
Message-Id: <20210303155523.124277-4-benjamin@sipsolutions.net>
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
Cc: Benjamin Berg <benjamin@sipsolutions.net>

These features have existed since Linux 2.6.14 and can be considered
widely available at this point.

Signed-off-by: Benjamin Berg <benjamin@sipsolutions.net>
---
 arch/um/include/asm/processor-generic.h |  1 -
 arch/um/include/shared/kern_util.h      |  1 -
 arch/um/include/shared/ptrace_user.h    | 41 --------------
 arch/um/kernel/process.c                | 75 +------------------------
 arch/um/kernel/ptrace.c                 |  2 -
 arch/um/kernel/signal.c                 | 12 ----
 arch/um/os-Linux/skas/process.c         | 56 +++---------------
 arch/um/os-Linux/start_up.c             | 70 ++---------------------
 arch/x86/um/ptrace_32.c                 | 24 --------
 arch/x86/um/ptrace_64.c                 | 26 ---------
 arch/x86/um/shared/sysdep/ptrace_32.h   |  4 --
 11 files changed, 15 insertions(+), 297 deletions(-)

diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index afd9b267cf81..1cafe30a0241 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -21,7 +21,6 @@ struct mm_struct;
 struct thread_struct {
 	struct pt_regs regs;
 	struct pt_regs *segv_regs;
-	int singlestep_syscall;
 	void *fault_addr;
 	jmp_buf *fault_catcher;
 	struct task_struct *prev_sched;
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 2888ec812f6e..d474a5f3d131 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -35,7 +35,6 @@ extern int handle_page_fault(unsigned long address, unsigned long ip,
 extern unsigned int do_IRQ(int irq, struct uml_pt_regs *regs);
 extern int smp_sigio_handler(void);
 extern void initial_thread_cb(void (*proc)(void *), void *arg);
-extern int is_syscall(unsigned long addr);
 
 extern void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs);
 
diff --git a/arch/um/include/shared/ptrace_user.h b/arch/um/include/shared/ptrace_user.h
index 95455e8996e7..8a705d8f96ce 100644
--- a/arch/um/include/shared/ptrace_user.h
+++ b/arch/um/include/shared/ptrace_user.h
@@ -12,45 +12,4 @@
 extern int ptrace_getregs(long pid, unsigned long *regs_out);
 extern int ptrace_setregs(long pid, unsigned long *regs_in);
 
-/* syscall emulation path in ptrace */
-
-#ifndef PTRACE_SYSEMU
-#define PTRACE_SYSEMU 31
-#endif
-#ifndef PTRACE_SYSEMU_SINGLESTEP
-#define PTRACE_SYSEMU_SINGLESTEP 32
-#endif
-
-/* On architectures, that started to support PTRACE_O_TRACESYSGOOD
- * in linux 2.4, there are two different definitions of
- * PTRACE_SETOPTIONS: linux 2.4 uses 21 while linux 2.6 uses 0x4200.
- * For binary compatibility, 2.6 also supports the old "21", named
- * PTRACE_OLDSETOPTION. On these architectures, UML always must use
- * "21", to ensure the kernel runs on 2.4 and 2.6 host without
- * recompilation. So, we use PTRACE_OLDSETOPTIONS in UML.
- * We also want to be able to build the kernel on 2.4, which doesn't
- * have PTRACE_OLDSETOPTIONS. So, if it is missing, we declare
- * PTRACE_OLDSETOPTIONS to be the same as PTRACE_SETOPTIONS.
- *
- * On architectures, that start to support PTRACE_O_TRACESYSGOOD on
- * linux 2.6, PTRACE_OLDSETOPTIONS never is defined, and also isn't
- * supported by the host kernel. In that case, our trick lets us use
- * the new 0x4200 with the name PTRACE_OLDSETOPTIONS.
- */
-#ifndef PTRACE_OLDSETOPTIONS
-#define PTRACE_OLDSETOPTIONS PTRACE_SETOPTIONS
-#endif
-
-void set_using_sysemu(int value);
-int get_using_sysemu(void);
-extern int sysemu_supported;
-
-#define SELECT_PTRACE_OPERATION(sysemu_mode, singlestep_mode) \
-	(((int[3][3] ) { \
-		{ PTRACE_SYSCALL, PTRACE_SYSCALL, PTRACE_SINGLESTEP }, \
-		{ PTRACE_SYSEMU, PTRACE_SYSEMU, PTRACE_SINGLESTEP }, \
-		{ PTRACE_SYSEMU, PTRACE_SYSEMU_SINGLESTEP, \
-		  PTRACE_SYSEMU_SINGLESTEP } }) \
-		[sysemu_mode][singlestep_mode])
-
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index c5011064b5dd..a7eaad38e40e 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -268,84 +268,11 @@ int cpu(void)
 	return current_thread_info()->cpu;
 }
 
-static atomic_t using_sysemu = ATOMIC_INIT(0);
-int sysemu_supported;
-
-void set_using_sysemu(int value)
-{
-	if (value > sysemu_supported)
-		return;
-	atomic_set(&using_sysemu, value);
-}
-
-int get_using_sysemu(void)
-{
-	return atomic_read(&using_sysemu);
-}
-
-static int sysemu_proc_show(struct seq_file *m, void *v)
-{
-	seq_printf(m, "%d\n", get_using_sysemu());
-	return 0;
-}
-
-static int sysemu_proc_open(struct inode *inode, struct file *file)
-{
-	return single_open(file, sysemu_proc_show, NULL);
-}
-
-static ssize_t sysemu_proc_write(struct file *file, const char __user *buf,
-				 size_t count, loff_t *pos)
-{
-	char tmp[2];
-
-	if (copy_from_user(tmp, buf, 1))
-		return -EFAULT;
-
-	if (tmp[0] >= '0' && tmp[0] <= '2')
-		set_using_sysemu(tmp[0] - '0');
-	/* We use the first char, but pretend to write everything */
-	return count;
-}
-
-static const struct proc_ops sysemu_proc_ops = {
-	.proc_open	= sysemu_proc_open,
-	.proc_read	= seq_read,
-	.proc_lseek	= seq_lseek,
-	.proc_release	= single_release,
-	.proc_write	= sysemu_proc_write,
-};
-
-int __init make_proc_sysemu(void)
-{
-	struct proc_dir_entry *ent;
-	if (!sysemu_supported)
-		return 0;
-
-	ent = proc_create("sysemu", 0600, NULL, &sysemu_proc_ops);
-
-	if (ent == NULL)
-	{
-		printk(KERN_WARNING "Failed to register /proc/sysemu\n");
-		return 0;
-	}
-
-	return 0;
-}
-
-late_initcall(make_proc_sysemu);
-
 int singlestepping(void * t)
 {
 	struct task_struct *task = t ? t : current;
 
-	if (!(task->ptrace & PT_DTRACE))
-		return 0;
-
-	if (task->thread.singlestep_syscall)
-		return 1;
-
-	return 2;
+	return !!(task->ptrace & PT_DTRACE);
 }
 
 /*
diff --git a/arch/um/kernel/ptrace.c b/arch/um/kernel/ptrace.c
index b425f47bddbb..dd56b6a80616 100644
--- a/arch/um/kernel/ptrace.c
+++ b/arch/um/kernel/ptrace.c
@@ -13,7 +13,6 @@
 void user_enable_single_step(struct task_struct *child)
 {
 	child->ptrace |= PT_DTRACE;
-	child->thread.singlestep_syscall = 0;
 
 #ifdef SUBARCH_SET_SINGLESTEPPING
 	SUBARCH_SET_SINGLESTEPPING(child, 1);
@@ -23,7 +22,6 @@ void user_enable_single_step(struct task_struct *child)
 void user_disable_single_step(struct task_struct *child)
 {
 	child->ptrace &= ~PT_DTRACE;
-	child->thread.singlestep_syscall = 0;
 
 #ifdef SUBARCH_SET_SINGLESTEPPING
 	SUBARCH_SET_SINGLESTEPPING(child, 0);
diff --git a/arch/um/kernel/signal.c b/arch/um/kernel/signal.c
index 88cd9b5c1b74..87c9c625f29b 100644
--- a/arch/um/kernel/signal.c
+++ b/arch/um/kernel/signal.c
@@ -120,18 +120,6 @@ void do_signal(struct pt_regs *regs)
 		}
 	}
 
-	/*
-	 * This closes a way to execute a system call on the host.  If
-	 * you set a breakpoint on a system call instruction and singlestep
-	 * from it, the tracing thread used to PTRACE_SINGLESTEP the process
-	 * rather than PTRACE_SYSCALL it, allowing the system call to execute
-	 * on the host.  The tracing thread will check this flag and
-	 * PTRACE_SYSCALL if necessary.
-	 */
-	if (current->ptrace & PT_DTRACE)
-		current->thread.singlestep_syscall =
-			is_syscall(PT_REGS_IP(&current->thread.regs));
-
 	/*
 	 * if there's no signal to deliver, we just put the saved sigmask
 	 * back
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 8c524e27571c..d30c96b599ac 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -176,48 +176,11 @@ static void handle_segv(int pid, struct uml_pt_regs *regs, unsigned long *aux_fp
 	segv(regs->faultinfo, 0, 1, NULL);
 }
 
-/*
- * To use the same value of using_sysemu as the caller, ask it that value
- * (in local_using_sysemu
- */
-static void handle_trap(int pid, struct uml_pt_regs *regs,
-			int local_using_sysemu)
+static void handle_trap(int pid, struct uml_pt_regs *regs)
 {
-	int err, status;
-
 	if ((UPT_IP(regs) >= STUB_START) && (UPT_IP(regs) < STUB_END))
 		fatal_sigsegv();
 
-	if (!local_using_sysemu)
-	{
-		err = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_NR_OFFSET,
-			     __NR_getpid);
-		if (err < 0) {
-			printk(UM_KERN_ERR "%s - nullifying syscall failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
-
-		err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
-		if (err < 0) {
-			printk(UM_KERN_ERR "%s - continuing to end of syscall failed, errno = %d\n",
-			       __func__, errno);
-			fatal_sigsegv();
-		}
-
-		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED | __WALL));
-		if ((err < 0) || !WIFSTOPPED(status) ||
-		    (WSTOPSIG(status) != SIGTRAP + 0x80)) {
-			err = ptrace_dump_regs(pid);
-			if (err)
-				printk(UM_KERN_ERR "Failed to get registers from process, errno = %d\n",
-				       -err);
-			printk(UM_KERN_ERR "%s - failed to wait at end of syscall, errno = %d, status = %d\n",
-			       __func__, errno, status);
-			fatal_sigsegv();
-		}
-	}
-
 	handle_syscall(regs);
 }
 
@@ -354,7 +317,7 @@ int start_userspace(unsigned long stub_stack)
 		goto out_kill;
 	}
 
-	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
+	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
@@ -379,8 +342,6 @@ int start_userspace(unsigned long stub_stack)
 void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 {
 	int err, status, op, pid = userspace_pid[0];
-	/* To prevent races if using_sysemu changes under us.*/
-	int local_using_sysemu;
 	siginfo_t si;
 
 	/* Handle any immediate reschedules or signals */
@@ -410,11 +371,10 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 			fatal_sigsegv();
 		}
 
-		/* Now we set local_using_sysemu to be used for one loop */
-		local_using_sysemu = get_using_sysemu();
-
-		op = SELECT_PTRACE_OPERATION(local_using_sysemu,
-					     singlestepping(NULL));
+		if (singlestepping(NULL))
+			op = PTRACE_SYSEMU_SINGLESTEP;
+		else
+			op = PTRACE_SYSEMU;
 
 		if (ptrace(op, pid, 0, 0)) {
 			printk(UM_KERN_ERR "%s - ptrace continue failed, op = %d, errno = %d\n",
@@ -473,7 +433,7 @@ void userspace(struct uml_pt_regs *regs, unsigned long *aux_fp_regs)
 				else handle_segv(pid, regs, aux_fp_regs);
 				break;
 			case SIGTRAP + 0x80:
-			        handle_trap(pid, regs, local_using_sysemu);
+				handle_trap(pid, regs);
 				break;
 			case SIGTRAP:
 				relay_signal(SIGTRAP, (struct siginfo *)&si, regs);
@@ -596,7 +556,7 @@ int copy_context_skas0(unsigned long new_stack, int pid)
 		goto out_kill;
 	}
 
-	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL,
+	if (ptrace(PTRACE_SETOPTIONS, pid, NULL,
 		   (void *)PTRACE_O_TRACESYSGOOD) < 0) {
 		err = -errno;
 		printk(UM_KERN_ERR "%s : PTRACE_OLDSETOPTIONS failed, errno = %d\n",
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index f79dc338279e..4f8fbe51fad6 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -143,71 +143,16 @@ static int stop_ptraced_child(int pid, int exitcode, int mustexit)
 	return ret;
 }
 
-/* Changed only during early boot */
-static int force_sysemu_disabled = 0;
-
-static int __init nosysemu_cmd_param(char *str, int* add)
-{
-	force_sysemu_disabled = 1;
-	return 0;
-}
-
-__uml_setup("nosysemu", nosysemu_cmd_param,
-"nosysemu\n"
-"    Turns off syscall emulation patch for ptrace (SYSEMU).\n"
-"    SYSEMU is a performance-patch introduced by Laurent Vivier. It changes\n"
-"    behaviour of ptrace() and helps reduce host context switch rates.\n"
-"    To make it work, you need a kernel patch for your host, too.\n"
-"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further \n"
-"    information.\n\n");
-
 static void __init check_sysemu(void)
 {
-	unsigned long regs[MAX_REG_NR];
 	int pid, n, status, count=0;
 
-	os_info("Checking syscall emulation patch for ptrace...");
-	sysemu_supported = 0;
-	pid = start_ptraced_child();
-
-	if (ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
-		goto fail;
-
-	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
-	if (n < 0)
-		fatal_perror("check_sysemu : wait failed");
-	if (!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-		fatal("check_sysemu : expected SIGTRAP, got status = %d\n",
-		      status);
-
-	if (ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
-		fatal_perror("check_sysemu : PTRACE_GETREGS failed");
-	if (PT_SYSCALL_NR(regs) != __NR_getpid) {
-		non_fatal("check_sysemu got system call number %d, "
-			  "expected %d...", PT_SYSCALL_NR(regs), __NR_getpid);
-		goto fail;
-	}
-
-	n = ptrace(PTRACE_POKEUSER, pid, PT_SYSCALL_RET_OFFSET, os_getpid());
-	if (n < 0) {
-		non_fatal("check_sysemu : failed to modify system call "
-			  "return");
-		goto fail;
-	}
-
-	if (stop_ptraced_child(pid, 0, 0) < 0)
-		goto fail_stopped;
-
-	sysemu_supported = 1;
-	os_info("OK\n");
-	set_using_sysemu(!force_sysemu_disabled);
-
-	os_info("Checking advanced syscall emulation patch for ptrace...");
+	os_info("Checking syscall emulation for ptrace...");
 	pid = start_ptraced_child();
 
-	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
+	if ((ptrace(PTRACE_SETOPTIONS, pid, 0,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0))
-		fatal_perror("check_sysemu: PTRACE_OLDSETOPTIONS failed");
+		fatal_perror("check_sysemu: PTRACE_SETOPTIONS failed");
 
 	while (1) {
 		count++;
@@ -243,17 +188,14 @@ static void __init check_sysemu(void)
 	if (stop_ptraced_child(pid, 0, 0) < 0)
 		goto fail_stopped;
 
-	sysemu_supported = 2;
 	os_info("OK\n");
 
-	if (!force_sysemu_disabled)
-		set_using_sysemu(sysemu_supported);
 	return;
 
 fail:
 	stop_ptraced_child(pid, 1, 0);
 fail_stopped:
-	non_fatal("missing\n");
+	fatal("missing\n");
 }
 
 static void __init check_ptrace(void)
@@ -263,9 +205,9 @@ static void __init check_ptrace(void)
 	os_info("Checking that ptrace can change system call numbers...");
 	pid = start_ptraced_child();
 
-	if ((ptrace(PTRACE_OLDSETOPTIONS, pid, 0,
+	if ((ptrace(PTRACE_SETOPTIONS, pid, 0,
 		   (void *) PTRACE_O_TRACESYSGOOD) < 0))
-		fatal_perror("check_ptrace: PTRACE_OLDSETOPTIONS failed");
+		fatal_perror("check_ptrace: PTRACE_SETOPTIONS failed");
 
 	while (1) {
 		if (ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
diff --git a/arch/x86/um/ptrace_32.c b/arch/x86/um/ptrace_32.c
index 2497bac56066..0c3439aeb2d2 100644
--- a/arch/x86/um/ptrace_32.c
+++ b/arch/x86/um/ptrace_32.c
@@ -24,30 +24,6 @@ void arch_switch_to(struct task_struct *to)
 		printk(KERN_WARNING "arch_switch_tls failed, errno = EINVAL\n");
 }
 
-int is_syscall(unsigned long addr)
-{
-	unsigned short instr;
-	int n;
-
-	n = copy_from_user(&instr, (void __user *) addr, sizeof(instr));
-	if (n) {
-		/* access_process_vm() grants access to vsyscall and stub,
-		 * while copy_from_user doesn't. Maybe access_process_vm is
-		 * slow, but that doesn't matter, since it will be called only
-		 * in case of singlestepping, if copy_from_user failed.
-		 */
-		n = access_process_vm(current, addr, &instr, sizeof(instr),
-				FOLL_FORCE);
-		if (n != sizeof(instr)) {
-			printk(KERN_ERR "is_syscall : failed to read "
-			       "instruction from 0x%lx\n", addr);
-			return 1;
-		}
-	}
-	/* int 0x80 or sysenter */
-	return (instr == 0x80cd) || (instr == 0x340f);
-}
-
 /* determines which flags the user has access to. */
 /* 1 = access 0 = no access */
 #define FLAG_MASK 0x00044dd5
diff --git a/arch/x86/um/ptrace_64.c b/arch/x86/um/ptrace_64.c
index 1401899dee9b..727f3ef3a76b 100644
--- a/arch/x86/um/ptrace_64.c
+++ b/arch/x86/um/ptrace_64.c
@@ -187,32 +187,6 @@ int peek_user(struct task_struct *child, long addr, long data)
 	return put_user(tmp, (unsigned long *) data);
 }
 
-/* XXX Mostly copied from sys-i386 */
-int is_syscall(unsigned long addr)
-{
-	unsigned short instr;
-	int n;
-
-	n = copy_from_user(&instr, (void __user *) addr, sizeof(instr));
-	if (n) {
-		/*
-		 * access_process_vm() grants access to vsyscall and stub,
-		 * while copy_from_user doesn't. Maybe access_process_vm is
-		 * slow, but that doesn't matter, since it will be called only
-		 * in case of singlestepping, if copy_from_user failed.
-		 */
-		n = access_process_vm(current, addr, &instr, sizeof(instr),
-				FOLL_FORCE);
-		if (n != sizeof(instr)) {
-			printk("is_syscall : failed to read instruction from "
-			       "0x%lx\n", addr);
-			return 1;
-		}
-	}
-	/* sysenter */
-	return instr == 0x050f;
-}
-
 static int get_fpregs(struct user_i387_struct __user *buf, struct task_struct *child)
 {
 	int err, n, cpu = ((struct thread_info *) child->stack)->cpu;
diff --git a/arch/x86/um/shared/sysdep/ptrace_32.h b/arch/x86/um/shared/sysdep/ptrace_32.h
index db8478a83a09..0c4989842fbe 100644
--- a/arch/x86/um/shared/sysdep/ptrace_32.h
+++ b/arch/x86/um/shared/sysdep/ptrace_32.h
@@ -8,10 +8,6 @@
 
 #define MAX_FP_NR HOST_FPX_SIZE
 
-void set_using_sysemu(int value);
-int get_using_sysemu(void);
-extern int sysemu_supported;
-
 #define UPT_SYSCALL_ARG1(r) UPT_BX(r)
 #define UPT_SYSCALL_ARG2(r) UPT_CX(r)
 #define UPT_SYSCALL_ARG3(r) UPT_DX(r)
-- 
2.29.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

