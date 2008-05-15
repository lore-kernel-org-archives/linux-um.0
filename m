Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Date: Thu, 15 May 2008 16:11:23 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080515201123.GA12355@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [RFC PATCH 12/12] SKAS4 - Guest vcpu support
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

This patch implements sys_vcpu support in UML.

diff --git a/arch/um/include/kern_util.h b/arch/um/include/kern_util.h
index 0a91cb1..3421c47 100644
--- a/arch/um/include/kern_util.h
+++ b/arch/um/include/kern_util.h
@@ -22,7 +22,7 @@ extern void free_stack(unsigned long stack, int order);
 
 extern void do_signal(void);
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
diff --git a/arch/um/include/skas/skas.h b/arch/um/include/skas/skas.h
index ea56428..590fcff 100644
--- a/arch/um/include/skas/skas.h
+++ b/arch/um/include/skas/skas.h
@@ -15,15 +15,18 @@
 #ifdef UML_CONFIG_X86_32
 #define __NR_new_mm             327
 #define __NR_switch_mm          328
+#define __NR_vcpu		329
 #else
 #define __NR_new_mm             288
 #define __NR_switch_mm          289
+#define __NR_vcpu		290
 #endif
 
 #define PTRACE_SWITCH_MM 34
 
 #ifndef __ASSEMBLY__
 
+#include <asm/user.h>
 #include "sysdep/ptrace.h"
 
 #define STUB_ADDR(x) (STUB_CODE + (unsigned long) (x) - \
@@ -36,6 +39,7 @@ extern int skas_needs_stub;
 extern int have_switch_mm;
 extern int have_ptrace_switch_mm;
 extern int have_siginfo_segv;
+extern int have_vcpu;
 extern int self_mm_fd;
 
 extern int user_thread(unsigned long stack, int flags);
@@ -48,7 +52,18 @@ extern unsigned long current_stub_stack(void);
 
 #ifndef __KERNEL__
 #include <errno.h>
-#include <asm/user.h>
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
 
 struct user_regs {
 	unsigned long regs[MAX_REG_NR];
@@ -61,6 +76,13 @@ struct user_regs {
 #endif
 };
 
+struct vcpu_user {
+	enum { VCPU_SYSCALL, VCPU_SIGNAL } event;
+	struct user_regs regs;
+	siginfo_t siginfo;
+	struct vcpu_arch arch;
+};
+
 static inline long new_mm(void)
 {
 	int ret = syscall(__NR_new_mm, 0, 0, 0, 0, 0, 0);
@@ -83,6 +105,27 @@ static inline long switch_mm(int mm_fd, struct user_regs *save_regs,
 
 	return 0;
 }
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
 #endif
 
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
index d3d1dda..18ad3a8 100644
--- a/arch/um/include/sysdep-x86_64/ptrace.h
+++ b/arch/um/include/sysdep-x86_64/ptrace.h
@@ -233,8 +233,6 @@ struct syscall_args {
 
 #define UPT_FAULTINFO(r) (&(r)->faultinfo)
 
-static inline void arch_init_registers(int pid)
-{
-}
+extern void arch_init_registers(int pid);
 
 #endif
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 0963fcd..7f07ad3 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -111,12 +111,13 @@ void *_switch_to(void *prev, void *next, void *last)
 
 }
 
-void interrupt_end(void)
+int interrupt_end(void)
 {
 	if (need_resched())
 		schedule();
 	if (test_thread_flag(TIF_SIGPENDING))
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
diff --git a/arch/um/kernel/skas/process.c b/arch/um/kernel/skas/process.c
index 32e84d7..ec82db3 100644
--- a/arch/um/kernel/skas/process.c
+++ b/arch/um/kernel/skas/process.c
@@ -55,7 +55,8 @@ int __init start_uml(void)
 {
 	stack_protections((unsigned long) &cpu0_irqstack);
 	set_sigstack(cpu0_irqstack, THREAD_SIZE);
-	if (proc_mm || have_switch_mm) {
+
+	if (!have_vcpu && (proc_mm || have_switch_mm)) {
 		userspace_pid[0] = start_userspace(0);
 		if (userspace_pid[0] < 0) {
 			printf("start_uml - start_userspace returned %d\n",
diff --git a/arch/um/os-Linux/skas/mem.c b/arch/um/os-Linux/skas/mem.c
index 42a3026..73b1dff 100644
--- a/arch/um/os-Linux/skas/mem.c
+++ b/arch/um/os-Linux/skas/mem.c
@@ -6,7 +6,6 @@
 #include <stddef.h>
 #include <unistd.h>
 #include <errno.h>
-#include <signal.h>
 #include <string.h>
 #include <sys/mman.h>
 #include "init.h"
@@ -122,11 +121,12 @@ static long do_syscall_stub(struct mm_id *mm_idp, void **addr)
 	return ret;
 }
 
+static struct user_regs return_regs;
+
 long do_syscall_stub_skas4(struct mm_id *mm_idp, void **addr, unsigned long ip,
 			   unsigned long sp)
 {
 	long ret;
-	struct user_regs return_regs;
 	unsigned long *ptr;
 	int err;
 	sigset_t sigs, old;
@@ -221,9 +221,10 @@ long syscall_stub_data(struct mm_id *mm_idp, unsigned long *data,
 		return ret;
 
 	stack = check_init_stack(mm_idp, *addr);
-	*stack++ = data_count * sizeof(long);
+	*stack = data_count;
+	*addr = stack++;
 
-	memcpy(stack, data, data_count * sizeof(long));
+	memcpy(stack, data, data_count);
 
 	*stub_addr = (void *)(((unsigned long) stack & ~UM_KERN_PAGE_MASK) +
 			      STUB_DATA);
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 23a9b42..593df24 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -358,6 +358,85 @@ int start_userspace(unsigned long stub_stack)
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
@@ -778,8 +857,11 @@ void reboot_skas(void)
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
 		err = ptrace(OLD_PTRACE_SWITCH_MM, userspace_pid[0], 0,
 			     mm_idp->u.mm_fd);
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index 021d41c..28a7984 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -29,6 +29,7 @@
 #include "skas.h"
 #include "skas_ptrace.h"
 #include "sysdep/sigcontext.h"
+#include "user.h"
 
 static int ptrace_child(void)
 {
@@ -165,6 +166,9 @@ static int disable_siginfo_segv;
 int have_ptrace_switch_mm;
 static int disable_ptrace_switch_mm;
 
+int have_vcpu;
+static int disable_vcpu;
+
 int skas_needs_stub;
 
 static int __init skas0_cmd_param(char *str, int* add)
@@ -176,6 +180,7 @@ static int __init skas0_cmd_param(char *str, int* add)
 	disable_switch_mm = 1;
 	disable_siginfo_segv = 1;
 	disable_ptrace_switch_mm = 1;
+	disable_vcpu = 1;
 
 	return 0;
 }
@@ -503,7 +508,7 @@ static void __init can_do_skas3(void)
 
 static void *fault_address;
 
-static int check_fault_info(struct faultinfo *fi)
+static __init int check_fault_info(struct faultinfo *fi)
 {
 	return (FAULT_ADDRESS(*fi) == (unsigned long) fault_address) &&
 		FAULT_WRITE(*fi) && SEGV_IS_FIXABLE(fi);
@@ -637,7 +642,7 @@ int self_mm_fd;
 
 static int switch_mm_works;
 
-static void after_switch(void)
+static __init void after_switch(void)
 {
 	/*
 	 * If we are really in a new address space, setting this to
@@ -804,13 +809,88 @@ static int __init check_ptrace_switch_mm(void)
 	return 0;
 }
 
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
 static int __init can_do_skas4(void)
 {
 	int ret;
 
 	non_fatal("Checking for SKAS4 support in the host:\n");
 
-	ret = check_switch_mm() && check_ptrace_switch_mm() && check_siginfo();
+	ret = check_switch_mm() && check_ptrace_switch_mm() && check_siginfo()
+		&& check_vcpu();
 	if (ret)
 		skas_needs_stub = 1;
 
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
 
diff --git a/arch/um/sys-x86_64/syscalls.c b/arch/um/sys-x86_64/syscalls.c
index e861ad6..fbbc903 100644
--- a/arch/um/sys-x86_64/syscalls.c
+++ b/arch/um/sys-x86_64/syscalls.c
@@ -28,61 +28,78 @@ asmlinkage long sys_uname64(struct new_utsname __user * name)
 
 long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 {
-	unsigned long *ptr = addr, tmp;
-	long ret;
-	int pid = userspace_pid[0];
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

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
