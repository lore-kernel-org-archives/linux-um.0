Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v14 9/9] x86/arch_prctl: Rename 'code' argument to 'option'
Date: Wed,  8 Feb 2017 00:09:17 -0800
Message-Id: <20170208080917.24320-10-khuey@kylehuey.com>
In-Reply-To: <20170208080917.24320-1-khuey@kylehuey.com>
References: <20170208080917.24320-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

arch_prctl arbitrarily changed prctl's 'option' to 'code'. Now that we're
adding additional options, fix that.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/um/include/shared/os.h               |  2 +-
 arch/x86/include/asm/proto.h              |  4 ++--
 arch/x86/kernel/process.c                 |  4 ++--
 arch/x86/kernel/process_32.c              |  4 ++--
 arch/x86/kernel/process_64.c              | 14 +++++++-------
 arch/x86/um/asm/ptrace.h                  |  2 +-
 arch/x86/um/os-Linux/prctl.c              |  4 ++--
 arch/x86/um/syscalls_32.c                 |  2 +-
 arch/x86/um/syscalls_64.c                 | 13 +++++++------
 include/linux/compat.h                    |  2 +-
 tools/testing/selftests/x86/cpuid_fault.c |  4 ++--
 11 files changed, 28 insertions(+), 27 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 2b47e0e8d414..fbabca435e7f 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -298,17 +298,17 @@ extern void os_set_ioignore(void);
 
 /* sigio.c */
 extern int add_sigio_fd(int fd);
 extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd, int read);
 extern void sigio_broken(int fd, int read);
 
 /* sys-x86_64/prctl.c */
-extern int os_arch_prctl(int pid, int code, unsigned long *arg2);
+extern int os_arch_prctl(int pid, int option, unsigned long *arg2);
 
 /* tty.c */
 extern int get_pty(void);
 
 /* sys-$ARCH/task_size.c */
 extern unsigned long os_get_top_address(void);
 
 long syscall(long number, ...);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 99836d9a893a..8d3964fc5f91 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -4,17 +4,17 @@
 #include <asm/ldt.h>
 
 /* misc architecture specific prototypes */
 
 void syscall_init(void);
 
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
-long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2);
+long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
 #ifdef CONFIG_X86_32
 void entry_INT80_32(void);
 void entry_SYSENTER_32(void);
 void __begin_SYSENTER_singlestep_region(void);
 void __end_SYSENTER_singlestep_region(void);
 #endif
@@ -26,12 +26,12 @@ void entry_SYSCALL_compat(void);
 void entry_INT80_compat(void);
 #endif
 
 void x86_configure_nx(void);
 void x86_report_nx(void);
 
 extern int reboot_force;
 
-long do_arch_prctl_common(struct task_struct *task, int code,
+long do_arch_prctl_common(struct task_struct *task, int option,
 			  unsigned long cpuid_enabled);
 
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 1c973b5ea70e..91c748f3f8cb 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -591,20 +591,20 @@ unsigned long get_wchan(struct task_struct *p)
 		fp = READ_ONCE_NOCHECK(*(unsigned long *)fp);
 	} while (count++ < 16 && p->state != TASK_RUNNING);
 
 out:
 	put_task_stack(p);
 	return ret;
 }
 
-long do_arch_prctl_common(struct task_struct *task, int code,
+long do_arch_prctl_common(struct task_struct *task, int option,
 			  unsigned long cpuid_enabled)
 {
-	switch (code) {
+	switch (option) {
 	case ARCH_GET_CPUID:
 		return get_cpuid_mode();
 	case ARCH_SET_CPUID:
 		return set_cpuid_mode(task, cpuid_enabled);
 	}
 
 	return -EINVAL;
 }
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index c24e72d7ce83..d36964ed6d96 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -300,12 +300,12 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 	this_cpu_write(current_task, next_p);
 
 	/* Load the Intel cache allocation PQR MSR. */
 	intel_rdt_sched_in();
 
 	return prev_p;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return do_arch_prctl_common(current, code, arg2);
+	return do_arch_prctl_common(current, option, arg2);
 }
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index e67cd9557ff8..bab02cf43439 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -541,23 +541,23 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 	ret = map_vdso_once(image, addr);
 	if (ret)
 		return ret;
 
 	return (long)image->size;
 }
 #endif
 
-long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2)
+long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
 	int ret = 0;
 	int doit = task == current;
 	int cpu;
 
-	switch (code) {
+	switch (option) {
 	case ARCH_SET_GS:
 		if (arg2 >= TASK_SIZE_MAX)
 			return -EPERM;
 		cpu = get_cpu();
 		task->thread.gsindex = 0;
 		task->thread.gsbase = arg2;
 		if (doit) {
 			load_gs_index(0);
@@ -617,30 +617,30 @@ long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2)
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
 	return ret;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
 	long ret;
 
-	ret = do_arch_prctl_64(current, code, arg2);
+	ret = do_arch_prctl_64(current, option, arg2);
 	if (ret == -EINVAL)
-		ret = do_arch_prctl_common(current, code, arg2);
+		ret = do_arch_prctl_common(current, option, arg2);
 
 	return ret;
 }
 
 #ifdef CONFIG_IA32_EMULATION
-COMPAT_SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+COMPAT_SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return do_arch_prctl_common(current, code, arg2);
+	return do_arch_prctl_common(current, option, arg2);
 }
 #endif
 
 unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
diff --git a/arch/x86/um/asm/ptrace.h b/arch/x86/um/asm/ptrace.h
index e59eef20647b..b291ca5cf66b 100644
--- a/arch/x86/um/asm/ptrace.h
+++ b/arch/x86/um/asm/ptrace.h
@@ -73,14 +73,14 @@ static inline int ptrace_get_thread_area(struct task_struct *child, int idx,
 }
 
 static inline int ptrace_set_thread_area(struct task_struct *child, int idx,
                                          struct user_desc __user *user_desc)
 {
         return -ENOSYS;
 }
 
-extern long arch_prctl(struct task_struct *task, int code,
+extern long arch_prctl(struct task_struct *task, int option,
 		       unsigned long __user *addr);
 
 #endif
 #define user_stack_pointer(regs) PT_REGS_SP(regs)
 #endif /* __UM_X86_PTRACE_H */
diff --git a/arch/x86/um/os-Linux/prctl.c b/arch/x86/um/os-Linux/prctl.c
index efc9d7484e72..8431e87ac333 100644
--- a/arch/x86/um/os-Linux/prctl.c
+++ b/arch/x86/um/os-Linux/prctl.c
@@ -1,12 +1,12 @@
 /*
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit.com,linux.intel.com})
  * Licensed under the GPL
  */
 
 #include <sys/ptrace.h>
 #include <asm/ptrace.h>
 
-int os_arch_prctl(int pid, int code, unsigned long *arg2)
+int os_arch_prctl(int pid, int option, unsigned long *arg2)
 {
-	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) arg2, code);
+	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) arg2, option);
 }
diff --git a/arch/x86/um/syscalls_32.c b/arch/x86/um/syscalls_32.c
index ccf0598c3fc0..627d68836b16 100644
--- a/arch/x86/um/syscalls_32.c
+++ b/arch/x86/um/syscalls_32.c
@@ -1,7 +1,7 @@
 #include <linux/syscalls.h>
 #include <os.h>
 
-SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
 	return -EINVAL;
 }
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index d472c6b79a90..da4252e27055 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -6,17 +6,18 @@
  */
 
 #include <linux/sched.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <os.h>
 
-long arch_prctl(struct task_struct *task, int code, unsigned long __user *arg2)
+long arch_prctl(struct task_struct *task, int option,
+		unsigned long __user *arg2)
 {
 	unsigned long *ptr = arg2, tmp;
 	long ret;
 	int pid = task->mm->context.id.u.pid;
 
 	/*
 	 * With ARCH_SET_FS (and ARCH_SET_GS is treated similarly to
 	 * be safe), we need to call arch_prctl on the host because
@@ -25,17 +26,17 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *arg2)
 	 * fiddle the registers and thread struct and restore the
 	 * registers afterwards.
 	 *
 	 * So, the saved registers are stored to the process (this
 	 * needed because a stub may have been the last thing to run),
 	 * arch_prctl is run on the host, then the registers are read
 	 * back.
 	 */
-	switch (code) {
+	switch (option) {
 	case ARCH_SET_FS:
 	case ARCH_SET_GS:
 		ret = restore_registers(pid, &current->thread.regs.regs);
 		if (ret)
 			return ret;
 		break;
 	case ARCH_GET_FS:
 	case ARCH_GET_GS:
@@ -45,21 +46,21 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *arg2)
 		 * given.  If addr isn't valid (because it hasn't been
 		 * faulted in or is just bogus), we want put_user to
 		 * fault it in (or return -EFAULT) instead of having
 		 * the host return -EFAULT.
 		 */
 		ptr = &tmp;
 	}
 
-	ret = os_arch_prctl(pid, code, ptr);
+	ret = os_arch_prctl(pid, option, ptr);
 	if (ret)
 		return ret;
 
-	switch (code) {
+	switch (option) {
 	case ARCH_SET_FS:
 		current->thread.arch.fs = (unsigned long) ptr;
 		ret = save_registers(pid, &current->thread.regs.regs);
 		break;
 	case ARCH_SET_GS:
 		ret = save_registers(pid, &current->thread.regs.regs);
 		break;
 	case ARCH_GET_FS:
@@ -68,19 +69,19 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *arg2)
 	case ARCH_GET_GS:
 		ret = put_user(tmp, arg2);
 		break;
 	}
 
 	return ret;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return arch_prctl(current, code, (unsigned long __user *) arg2);
+	return arch_prctl(current, option, (unsigned long __user *) arg2);
 }
 
 void arch_switch_to(struct task_struct *to)
 {
 	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
 		return;
 
 	arch_prctl(to, ARCH_SET_FS, (void __user *) to->thread.arch.fs);
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 0ddfc2ba0d06..d64998fa4728 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -716,17 +716,17 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 } while (0);
 
 asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
 						 struct compat_timespec __user *interval);
 
 asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
 					    int, const char __user *);
 
-asmlinkage long compat_sys_arch_prctl(int code, unsigned long arg2);
+asmlinkage long compat_sys_arch_prctl(int option, unsigned long arg2);
 
 /*
  * For most but not all architectures, "am I in a compat syscall?" and
  * "am I a compat task?" are the same question.  For architectures on which
  * they aren't the same question, arch code can override in_compat_syscall.
  */
 
 #ifndef in_compat_syscall
diff --git a/tools/testing/selftests/x86/cpuid_fault.c b/tools/testing/selftests/x86/cpuid_fault.c
index d061abde85e8..a1fae06b8324 100644
--- a/tools/testing/selftests/x86/cpuid_fault.c
+++ b/tools/testing/selftests/x86/cpuid_fault.c
@@ -28,19 +28,19 @@
 #endif
 */
 
 const char *cpuid_names[] = {
 	[0] = "[cpuid disabled]",
 	[1] = "[cpuid enabled]",
 };
 
-int arch_prctl(int code, unsigned long arg2)
+int arch_prctl(int option, unsigned long arg2)
 {
-	return syscall(SYS_arch_prctl, code, arg2);
+	return syscall(SYS_arch_prctl, option, arg2);
 }
 
 int cpuid(unsigned int *eax, unsigned int *ebx, unsigned int *ecx,
 	  unsigned int *edx)
 {
 	return __get_cpuid(0, eax, ebx, ecx, edx);
 }
 
-- 
2.11.0


