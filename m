Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCnTb-0005Qm-ES for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 18:49:03 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JCnTa-0002qA-2k
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 18:49:03 -0800
Received: from c2.user-mode-linux.org (littleton.addtoit.com [198.99.130.129])
	by saraswathi.solana.com (8.13.1/8.13.1) with ESMTP id m0A2mxcA008375
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 21:48:59 -0500
Received: from c2.user-mode-linux.org (localhost.localdomain [127.0.0.1])
	by c2.user-mode-linux.org (8.14.1/8.13.8) with ESMTP id m0A2mxgi011439
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Wed, 9 Jan 2008 21:48:59 -0500
Date: Wed, 9 Jan 2008 21:48:59 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080110024859.GA11424@c2.user-mode-linux.org>
References: <20080109220949.GA9185@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20080109220949.GA9185@c2.user-mode-linux.org>
Subject: Re: [uml-devel] [RFC PATCH 0/9] SKAS4
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

On Wed, Jan 09, 2008 at 05:09:49PM -0500, Jeff Dike wrote:
> These patches implement host and guest SKAS4 support for both 32- and
> 64-bit x86.

I forgot to include a single rolled-up patch, so it's below - again,
against 2.6.24-rc7.

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
index b073f8a..5953647 100644
--- a/arch/um/include/skas/skas.h
+++ b/arch/um/include/skas/skas.h
@@ -6,18 +6,61 @@
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
+#define MM_COPY 0
+
+#define MM_ALL_REGS 0
+#define MM_SP_IP 1
+#define MM_SAME 2
+
+#define PTRACE_SWITCH_MM 33
+
+#ifndef __ASSEMBLY__
+
 #include "sysdep/ptrace.h"
 
 extern int userspace_pid[];
 extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
 extern int skas_needs_stub;
 
+extern int have_switch_mm;
+extern int self_mm_fd;
+extern int have_ptrace_switch_mm;
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
+static inline long new_mm(int flags)
+{
+	return syscall(__NR_new_mm, MM_COPY, 0, 0, 0, 0, 0, 0);
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
index f859ec3..3155263 100644
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
@@ -101,7 +104,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 		from_mm = &current->mm->context;
 
 	if (proc_mm) {
-		ret = new_mm(stack);
+		ret = make_new_mm(stack);
 		if (ret < 0) {
 			printk(KERN_ERR "init_new_context_skas - "
 			       "new_mm failed, errno = %d\n", ret);
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
index 484e68f..cc86c0b 100644
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
 
@@ -40,35 +41,72 @@ static unsigned long syscall_regs[MAX_REG_NR];
 
 static int __init init_syscall_regs(void)
 {
+	unsigned long *stub_entry;
+
 	get_safe_registers(syscall_regs);
+	if (have_switch_mm)
+		stub_entry = &switch_mm_stub;
+	else
+		stub_entry = &batch_syscall_stub;
+
 	syscall_regs[REGS_IP_INDEX] = STUB_CODE +
-		((unsigned long) &batch_syscall_stub -
+		((unsigned long) stub_entry -
 		 (unsigned long) &__syscall_stub_start);
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
+		printk("  0x%lx", data[n]);
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
@@ -85,52 +123,71 @@ static inline long do_syscall_stub(struct mm_id * mm_idp, void **addr)
 
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
+static int flush_syscalls(struct mm_id *mm_idp, void **addr, int extra)
+{
+	unsigned long *stack = check_init_stack(mm_idp, *addr);
+	int current, end;
+
+	current = ((unsigned long) stack) & ~UM_KERN_PAGE_MASK;
+	end = UM_KERN_PAGE_SIZE;
+
+	if(have_switch_mm)
+		end -= (MAX_REG_NR + 1) * sizeof(long);
+
+	if (current + (10 + extra) * sizeof(long) < end)
+		return 0;
+
+	if (have_switch_mm)
+		return do_syscall_stub_skas4(mm_idp, addr);
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
+
+	ret = flush_syscalls(mm_idp, addr, 0);
+	if (ret)
+		return ret;
 
-	if (done && *addr == NULL)
-		single_count++;
+	stack = check_init_stack(mm_idp, *addr);
 
 	*stack += sizeof(long);
 	stack += *stack / sizeof(long);
@@ -144,45 +201,36 @@ long run_syscall_stub(struct mm_id * mm_idp, int syscall,
 	*stack++ = args[5];
 	*stack++ = expected;
 	*stack = 0;
-	multi_op_count++;
 
-	if (!done && ((((unsigned long) stack) & ~UM_KERN_PAGE_MASK) <
-		     UM_KERN_PAGE_SIZE - 10 * sizeof(long))) {
-		*addr = stack;
-		return 0;
+	if (done) {
+		if (have_switch_mm)
+			return do_syscall_stub_skas4(mm_idp, addr);
+		else
+ 			return do_syscall_stub(mm_idp, addr);
 	}
 
-	return do_syscall_stub(mm_idp, addr);
+	*addr = stack;
+
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
index e8b7a97..725af32 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -3,6 +3,9 @@
  * Licensed under the GPL
  */
 
+#define siginfo old_siginfo
+#define siginfo_t old_siginfo_t
+
 #include <stdlib.h>
 #include <unistd.h>
 #include <sched.h>
@@ -26,6 +29,108 @@
 #include "user.h"
 #include "sysdep/stub.h"
 
+#undef siginfo
+#undef siginfo_t
+
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
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
 int is_skas_winch(int pid, int fd, void *data)
 {
 	if (pid != getpgrp())
@@ -91,11 +196,25 @@ bad_wait:
 
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
+	if(1){
+		err = ptrace(PTRACE_GETSIGINFO, pid, 0, &si);
+		if(err)
+			printk("PTRACE_GETSIGINFO failed, err = %d\n", errno);
+
+		fi->cr2 = (unsigned long) si.si_addr;
+		fi->error_code = si.si_error;
+		fi->trap_no = si.si_trapno;
+	}
+	else if (ptrace_faultinfo) {
 		err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
 		if (err)
 			panic("get_skas_faultinfo - PTRACE_FAULTINFO failed, "
@@ -212,7 +331,7 @@ static int userspace_tramp(void *stack)
 			}
 		}
 	}
-	if (!ptrace_faultinfo && (stack != NULL)) {
+	if (!ptrace_faultinfo) {
 		struct sigaction sa;
 
 		unsigned long v = STUB_CODE +
@@ -256,7 +375,7 @@ int start_userspace(unsigned long stub_stack)
 	sp = (unsigned long) stack + UM_KERN_PAGE_SIZE - sizeof(void *);
 
 	flags = CLONE_FILES;
-	if (proc_mm)
+	if (proc_mm || have_switch_mm)
 		flags |= CLONE_VM;
 	else
 		flags |= SIGCHLD;
@@ -369,8 +488,14 @@ void userspace(struct uml_pt_regs *regs)
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
@@ -458,6 +583,69 @@ int copy_context_skas0(unsigned long new_stack, int pid)
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
@@ -612,11 +800,18 @@ void __switch_mm(struct mm_id *mm_idp)
 
 	/* FIXME: need cpu pid in __switch_mm */
 	if (proc_mm) {
-		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+		err = ptrace(OLD_PTRACE_SWITCH_MM, userspace_pid[0], 0,
 			     mm_idp->u.mm_fd);
 		if (err)
 			panic("__switch_mm - PTRACE_SWITCH_MM failed, "
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
index 7b81f6c..20a3c0c 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -23,6 +23,7 @@
 #include "mem_user.h"
 #include "ptrace_user.h"
 #include "registers.h"
+#include "skas.h"
 #include "skas_ptrace.h"
 
 static int ptrace_child(void)
@@ -141,14 +142,27 @@ static int stop_ptraced_child(int pid, int exitcode, int mustexit)
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
+int skas_needs_stub;
 
 static int __init skas0_cmd_param(char *str, int* add)
 {
-	ptrace_faultinfo = proc_mm = 0;
+	disable_ptrace_faultinfo = 1;
+	disable_ptrace_ldt = 1;
+	disable_proc_mm = 1;
+	disable_switch_mm = 1;
+
 	return 0;
 }
 
@@ -158,15 +172,12 @@ static int __init mode_skas0_cmd_param(char *str, int* add)
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
@@ -341,6 +352,8 @@ static void __init check_coredump_limit(void)
 
 void __init os_early_checks(void)
 {
+	int pid;
+
 	/* Print out the core dump limits early */
 	check_coredump_limit();
 
@@ -350,11 +363,15 @@ void __init os_early_checks(void)
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
 
@@ -366,7 +383,7 @@ __uml_setup("noprocmm", noprocmm_cmd_param,
 
 static int __init noptracefaultinfo_cmd_param(char *str, int* add)
 {
-	ptrace_faultinfo = 0;
+	disable_ptrace_faultinfo = 1;
 	return 0;
 }
 
@@ -378,7 +395,7 @@ __uml_setup("noptracefaultinfo", noptracefaultinfo_cmd_param,
 
 static int __init noptraceldt_cmd_param(char *str, int* add)
 {
-	ptrace_ldt = 0;
+	disable_ptrace_ldt = 1;
 	return 0;
 }
 
@@ -398,20 +415,18 @@ static inline void check_skas3_ptrace_faultinfo(void)
 
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
 
@@ -435,49 +450,236 @@ static inline void check_skas3_ptrace_ldt(void)
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
 
 	check_skas3_proc_mm();
 	check_skas3_ptrace_faultinfo();
 	check_skas3_ptrace_ldt();
+}
 
-	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
-		skas_needs_stub = 1;
+int get_new_mm(void)
+{
+	int err;
+
+	err = new_mm(MM_COPY);
+	if (err < 0)
+		err = -errno;
+
+	return err;
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
+	switch_mm_works = 0;
+
+	switch_mm(self_mm_fd, MM_ALL_REGS, return_regs, NULL);
+}
+
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
+	there = new_mm(MM_COPY);
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
+		non_fatal("SKAS4 support disabled on command line\n");
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
+int have_ptrace_switch_mm;
+static int disable_ptrace_switch_mm;
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
+	non_fatal("Checking for new_mm and switch_mm support in the host:\n");
+
+	return check_switch_mm() && check_ptrace_switch_mm();
+}
+
+void can_do_skas(void)
+{
+	if(!can_do_skas4())
+		can_do_skas3();
+
+	if (!proc_mm || !ptrace_faultinfo || !ptrace_ldt)
+		skas_needs_stub = 1;
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
index e730772..3cfb6e8 100644
--- a/arch/um/sys-i386/stub.S
+++ b/arch/um/sys-i386/stub.S
@@ -1,52 +1,61 @@
 #include "uml-config.h"
 #include "as-layout.h"
+#include "skas/skas.h"
+
+#define MAX_REG_NR 17
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
+	mov	ASM_STUB_DATA + UM_KERN_PAGE_SIZE - MAX_REG_NR * 4 - 4, %ebx
+	mov	$MM_ALL_REGS, %ecx
+	mov	$(ASM_STUB_DATA + UM_KERN_PAGE_SIZE - MAX_REG_NR * 4), %edx
+	xor	%esi, %esi
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
diff --git a/arch/um/sys-x86_64/stub.S b/arch/um/sys-x86_64/stub.S
index 4afe204..fb10353 100644
--- a/arch/um/sys-x86_64/stub.S
+++ b/arch/um/sys-x86_64/stub.S
@@ -1,67 +1,69 @@
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
+#define MAX_REG_NR 27
+
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
+	mov	$(ASM_STUB_DATA & 0xffffffff), %rsi
+	add	%rsi, %rdi
+	add	$(UM_KERN_PAGE_SIZE - MAX_REG_NR * 8 - 8), %rdi
+	mov	(%rdi), %rdi
+	mov	$MM_ALL_REGS, %rsi
+	mov	$(ASM_STUB_DATA + UM_KERN_PAGE_SIZE - MAX_REG_NR * 8), %rdx
+	xor	%r10, %r10
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
diff --git a/arch/um/sys-x86_64/syscalls.c b/arch/um/sys-x86_64/syscalls.c
index 86f6b18..00131f9 100644
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
index 0e26230..6365ba8 100644
--- a/arch/x86/mm/fault_64.c
+++ b/arch/x86/mm/fault_64.c
@@ -502,6 +502,8 @@ bad_area_nosemaphore:
 		info.si_errno = 0;
 		/* info.si_code has been set above */
 		info.si_addr = (void __user *)address;
+		info.si_trapno = tsk->thread.trap_no;
+		info.si_error = tsk->thread.error_code;
 		force_sig_info(SIGSEGV, &info, tsk);
 		return;
 	}
@@ -577,6 +579,8 @@ do_sigbus:
 	info.si_errno = 0;
 	info.si_code = BUS_ADRERR;
 	info.si_addr = (void __user *)address;
+	info.si_trapno = tsk->thread.trap_no;
+	info.si_error = tsk->thread.error_code;
 	force_sig_info(SIGBUS, &info, tsk);
 	return;
 }
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
index 8786e01..ffe5e49 100644
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
@@ -112,6 +115,12 @@ typedef struct siginfo {
 #ifdef __ARCH_SI_TRAPNO
 #define si_trapno	_sifields._sigfault._trapno
 #endif
+#ifdef __ARCH_SI_ERROR
+#define si_error	_sifields._sigfault._error
+#endif
+#ifdef __ARCH_SI_ERROR
+#define si_error	_sifields._sigfault._error
+#endif
 #define si_band		_sifields._sigpoll._band
 #define si_fd		_sifields._sigpoll._fd
 
diff --git a/include/asm-um/processor-x86_64.h b/include/asm-um/processor-x86_64.h
index d946bf2..fd026c3 100644
--- a/include/asm-um/processor-x86_64.h
+++ b/include/asm-um/processor-x86_64.h
@@ -26,7 +26,7 @@ static inline void rep_nop(void)
 #define cpu_relax()   rep_nop()
 
 #define INIT_ARCH_THREAD { .debugregs  		= { [ 0 ... 7 ] = 0 }, \
-                           .debugregs_seq	= 0,			       \
+                           .debugregs_seq	= 0, \
 			   .fs			= 0, \
 			   .faultinfo		= { 0, 0, 0 } }
 
@@ -37,6 +37,7 @@ static inline void arch_flush_thread(struct arch_thread *thread)
 static inline void arch_copy_thread(struct arch_thread *from,
                                     struct arch_thread *to)
 {
+	to->fs = from->fs;
 }
 
 #include "asm/arch/user.h"
diff --git a/include/asm-x86/siginfo.h b/include/asm-x86/siginfo.h
index a477bea..796ac81 100644
--- a/include/asm-x86/siginfo.h
+++ b/include/asm-x86/siginfo.h
@@ -5,6 +5,12 @@
 # define __ARCH_SI_PREAMBLE_SIZE	(4 * sizeof(int))
 #endif
 
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
+
+#define __ARCH_SI_TRAPNO
+#define __ARCH_SI_ERROR
+
 #include <asm-generic/siginfo.h>
 
 #endif
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
diff --git a/kernel/signal.c b/kernel/signal.c
index afa4f78..1e067a1 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
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

-------------------------------------------------------------------------
Check out the new SourceForge.net Marketplace.
It's the best place to buy or sell services for
just about anything Open Source.
http://ad.doubleclick.net/clk;164216239;13503038;w?http://sf.net/marketplace
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
