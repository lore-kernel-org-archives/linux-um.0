Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v12 2/7] x86/arch_prctl/64: Rename do_arch_prctl to do_arch_prctl_64
Date: Wed, 16 Nov 2016 18:06:05 -0800
Message-Id: <20161117020610.5302-3-khuey@kylehuey.com>
In-Reply-To: <20161117020610.5302-1-khuey@kylehuey.com>
References: <20161117020610.5302-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

In order to introduce new arch_prctls that are not 64 bit only, rename the
existing 64 bit implementation to do_arch_prctl_64(). Also rename the second
argument to arch_prctl(), which will no longer always be an address.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
---
 arch/um/include/shared/os.h  |  2 +-
 arch/x86/include/asm/proto.h |  3 +--
 arch/x86/kernel/process_64.c | 32 +++++++++++++++++---------------
 arch/x86/kernel/ptrace.c     |  8 ++++----
 arch/x86/um/os-Linux/prctl.c |  4 ++--
 arch/x86/um/syscalls_64.c    | 12 ++++++------
 6 files changed, 31 insertions(+), 30 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index de5d572..2b47e0e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -298,17 +298,17 @@ extern void os_set_ioignore(void);
 
 /* sigio.c */
 extern int add_sigio_fd(int fd);
 extern int ignore_sigio_fd(int fd);
 extern void maybe_sigio_broken(int fd, int read);
 extern void sigio_broken(int fd, int read);
 
 /* sys-x86_64/prctl.c */
-extern int os_arch_prctl(int pid, int code, unsigned long *addr);
+extern int os_arch_prctl(int pid, int code, unsigned long *arg2);
 
 /* tty.c */
 extern int get_pty(void);
 
 /* sys-$ARCH/task_size.c */
 extern unsigned long os_get_top_address(void);
 
 long syscall(long number, ...);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 9b9b30b..f8e9194 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -4,16 +4,17 @@
 #include <asm/ldt.h>
 
 /* misc architecture specific prototypes */
 
 void syscall_init(void);
 
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
+long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2);
 #endif
 
 #ifdef CONFIG_X86_32
 void entry_INT80_32(void);
 void entry_SYSENTER_32(void);
 void __begin_SYSENTER_singlestep_region(void);
 void __end_SYSENTER_singlestep_region(void);
 #endif
@@ -25,11 +26,9 @@ void entry_SYSCALL_compat(void);
 void entry_INT80_compat(void);
 #endif
 
 void x86_configure_nx(void);
 void x86_report_nx(void);
 
 extern int reboot_force;
 
-long do_arch_prctl(struct task_struct *task, int code, unsigned long addr);
-
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 2718cf9..611df20 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -193,17 +193,17 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 	 */
 	if (clone_flags & CLONE_SETTLS) {
 #ifdef CONFIG_IA32_EMULATION
 		if (in_ia32_syscall())
 			err = do_set_thread_area(p, -1,
 				(struct user_desc __user *)tls, 0);
 		else
 #endif
-			err = do_arch_prctl(p, ARCH_SET_FS, tls);
+			err = do_arch_prctl_64(p, ARCH_SET_FS, tls);
 		if (err)
 			goto out;
 	}
 	err = 0;
 out:
 	if (err && p->thread.io_bitmap_ptr) {
 		kfree(p->thread.io_bitmap_ptr);
 		p->thread.io_bitmap_max = 0;
@@ -534,91 +534,93 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 	ret = map_vdso_once(image, addr);
 	if (ret)
 		return ret;
 
 	return (long)image->size;
 }
 #endif
 
-long do_arch_prctl(struct task_struct *task, int code, unsigned long addr)
+long do_arch_prctl_64(struct task_struct *task, int code, unsigned long arg2)
 {
 	int ret = 0;
 	int doit = task == current;
 	int cpu;
 
 	switch (code) {
 	case ARCH_SET_GS:
-		if (addr >= TASK_SIZE_MAX)
+		if (arg2 >= TASK_SIZE_MAX)
 			return -EPERM;
 		cpu = get_cpu();
 		task->thread.gsindex = 0;
-		task->thread.gsbase = addr;
+		task->thread.gsbase = arg2;
 		if (doit) {
 			load_gs_index(0);
-			ret = wrmsrl_safe(MSR_KERNEL_GS_BASE, addr);
+			ret = wrmsrl_safe(MSR_KERNEL_GS_BASE, arg2);
 		}
 		put_cpu();
 		break;
 	case ARCH_SET_FS:
 		/* Not strictly needed for fs, but do it for symmetry
 		   with gs */
-		if (addr >= TASK_SIZE_MAX)
+		if (arg2 >= TASK_SIZE_MAX)
 			return -EPERM;
 		cpu = get_cpu();
 		task->thread.fsindex = 0;
-		task->thread.fsbase = addr;
+		task->thread.fsbase = arg2;
 		if (doit) {
 			/* set the selector to 0 to not confuse __switch_to */
 			loadsegment(fs, 0);
-			ret = wrmsrl_safe(MSR_FS_BASE, addr);
+			ret = wrmsrl_safe(MSR_FS_BASE, arg2);
 		}
 		put_cpu();
 		break;
 	case ARCH_GET_FS: {
 		unsigned long base;
+
 		if (doit)
 			rdmsrl(MSR_FS_BASE, base);
 		else
 			base = task->thread.fsbase;
-		ret = put_user(base, (unsigned long __user *)addr);
+		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
 	case ARCH_GET_GS: {
 		unsigned long base;
+
 		if (doit)
 			rdmsrl(MSR_KERNEL_GS_BASE, base);
 		else
 			base = task->thread.gsbase;
-		ret = put_user(base, (unsigned long __user *)addr);
+		ret = put_user(base, (unsigned long __user *)arg2);
 		break;
 	}
 
 #ifdef CONFIG_CHECKPOINT_RESTORE
 # ifdef CONFIG_X86_X32_ABI
 	case ARCH_MAP_VDSO_X32:
-		return prctl_map_vdso(&vdso_image_x32, addr);
+		return prctl_map_vdso(&vdso_image_x32, arg2);
 # endif
 # if defined CONFIG_X86_32 || defined CONFIG_IA32_EMULATION
 	case ARCH_MAP_VDSO_32:
-		return prctl_map_vdso(&vdso_image_32, addr);
+		return prctl_map_vdso(&vdso_image_32, arg2);
 # endif
 	case ARCH_MAP_VDSO_64:
-		return prctl_map_vdso(&vdso_image_64, addr);
+		return prctl_map_vdso(&vdso_image_64, arg2);
 #endif
 
 	default:
 		ret = -EINVAL;
 		break;
 	}
 
 	return ret;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, addr)
+SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
 {
-	return do_arch_prctl(current, code, addr);
+	return do_arch_prctl_64(current, code, arg2);
 }
 
 unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 0e63c02..5004302 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -390,31 +390,31 @@ static int putreg(struct task_struct *child,
 	case offsetof(struct user_regs_struct, flags):
 		return set_flags(child, value);
 
 #ifdef CONFIG_X86_64
 	case offsetof(struct user_regs_struct,fs_base):
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		/*
-		 * When changing the segment base, use do_arch_prctl
+		 * When changing the segment base, use do_arch_prctl_64
 		 * to set either thread.fs or thread.fsindex and the
 		 * corresponding GDT slot.
 		 */
 		if (child->thread.fsbase != value)
-			return do_arch_prctl(child, ARCH_SET_FS, value);
+			return do_arch_prctl_64(child, ARCH_SET_FS, value);
 		return 0;
 	case offsetof(struct user_regs_struct,gs_base):
 		/*
 		 * Exactly the same here as the %fs handling above.
 		 */
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		if (child->thread.gsbase != value)
-			return do_arch_prctl(child, ARCH_SET_GS, value);
+			return do_arch_prctl_64(child, ARCH_SET_GS, value);
 		return 0;
 #endif
 	}
 
 	*pt_regs_access(task_pt_regs(child), offset) = value;
 	return 0;
 }
 
@@ -863,17 +863,17 @@ long arch_ptrace(struct task_struct *child, long request,
 		break;
 #endif
 
 #ifdef CONFIG_X86_64
 		/* normal 64bit interface to access TLS data.
 		   Works just like arch_prctl, except that the arguments
 		   are reversed. */
 	case PTRACE_ARCH_PRCTL:
-		ret = do_arch_prctl(child, data, addr);
+		ret = do_arch_prctl_64(child, data, addr);
 		break;
 #endif
 
 	default:
 		ret = ptrace_request(child, request, addr, data);
 		break;
 	}
 
diff --git a/arch/x86/um/os-Linux/prctl.c b/arch/x86/um/os-Linux/prctl.c
index 96eb2bd..efc9d74 100644
--- a/arch/x86/um/os-Linux/prctl.c
+++ b/arch/x86/um/os-Linux/prctl.c
@@ -1,12 +1,12 @@
 /*
  * Copyright (C) 2007 Jeff Dike (jdike@{addtoit.com,linux.intel.com})
  * Licensed under the GPL
  */
 
 #include <sys/ptrace.h>
 #include <asm/ptrace.h>
 
-int os_arch_prctl(int pid, int code, unsigned long *addr)
+int os_arch_prctl(int pid, int code, unsigned long *arg2)
 {
-        return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) addr, code);
+	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) arg2, code);
 }
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index ab3f7f4..d472c6b 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -6,19 +6,19 @@
  */
 
 #include <linux/sched.h>
 #include <linux/syscalls.h>
 #include <linux/uaccess.h>
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <os.h>
 
-long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
+long arch_prctl(struct task_struct *task, int code, unsigned long __user *arg2)
 {
-	unsigned long *ptr = addr, tmp;
+	unsigned long *ptr = arg2, tmp;
 	long ret;
 	int pid = task->mm->context.id.u.pid;
 
 	/*
 	 * With ARCH_SET_FS (and ARCH_SET_GS is treated similarly to
 	 * be safe), we need to call arch_prctl on the host because
 	 * setting %fs may result in something else happening (like a
 	 * GDT or thread.fs being set instead).  So, we let the host
@@ -58,29 +58,29 @@ long arch_prctl(struct task_struct *task, int code, unsigned long __user *addr)
 	case ARCH_SET_FS:
 		current->thread.arch.fs = (unsigned long) ptr;
 		ret = save_registers(pid, &current->thread.regs.regs);
 		break;
 	case ARCH_SET_GS:
 		ret = save_registers(pid, &current->thread.regs.regs);
 		break;
 	case ARCH_GET_FS:
-		ret = put_user(tmp, addr);
+		ret = put_user(tmp, arg2);
 		break;
 	case ARCH_GET_GS:
-		ret = put_user(tmp, addr);
+		ret = put_user(tmp, arg2);
 		break;
 	}
 
 	return ret;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, addr)
+SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
 {
-	return arch_prctl(current, code, (unsigned long __user *) addr);
+	return arch_prctl(current, code, (unsigned long __user *) arg2);
 }
 
 void arch_switch_to(struct task_struct *to)
 {
 	if ((to->thread.arch.fs == 0) || (to->mm == NULL))
 		return;
 
 	arch_prctl(to, ARCH_SET_FS, (void __user *) to->thread.arch.fs);
-- 
2.10.2


