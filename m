Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 04/10] x86/arch_prctl/64: Rename do_arch_prctl to do_arch_prctl_64
Date: Mon, 20 Mar 2017 01:16:22 -0700
Message-Id: <20170320081628.18952-5-khuey@kylehuey.com>
In-Reply-To: <20170320081628.18952-1-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
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
 arch/x86/um/syscalls_64.c    | 14 +++++++-------
 6 files changed, 32 insertions(+), 31 deletions(-)

diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 32e41c4ef6d3..cd1fa97776c3 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -303,7 +303,7 @@ extern void maybe_sigio_broken(int fd, int read);
 extern void sigio_broken(int fd, int read);
 
 /* prctl.c */
-extern int os_arch_prctl(int pid, int option, unsigned long *addr);
+extern int os_arch_prctl(int pid, int option, unsigned long *arg2);
 
 /* tty.c */
 extern int get_pty(void);
diff --git a/arch/x86/include/asm/proto.h b/arch/x86/include/asm/proto.h
index 91675a960391..4e276f6cb1c1 100644
--- a/arch/x86/include/asm/proto.h
+++ b/arch/x86/include/asm/proto.h
@@ -9,6 +9,7 @@ void syscall_init(void);
 
 #ifdef CONFIG_X86_64
 void entry_SYSCALL_64(void);
+long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2);
 #endif
 
 #ifdef CONFIG_X86_32
@@ -30,6 +31,4 @@ void x86_report_nx(void);
 
 extern int reboot_force;
 
-long do_arch_prctl(struct task_struct *task, int option, unsigned long addr);
-
 #endif /* _ASM_X86_PROTO_H */
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index bf9d7b6c0223..e37f764c11cc 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -205,7 +205,7 @@ int copy_thread_tls(unsigned long clone_flags, unsigned long sp,
 				(struct user_desc __user *)tls, 0);
 		else
 #endif
-			err = do_arch_prctl(p, ARCH_SET_FS, tls);
+			err = do_arch_prctl_64(p, ARCH_SET_FS, tls);
 		if (err)
 			goto out;
 	}
@@ -548,7 +548,7 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 }
 #endif
 
-long do_arch_prctl(struct task_struct *task, int option, unsigned long addr)
+long do_arch_prctl_64(struct task_struct *task, int option, unsigned long arg2)
 {
 	int ret = 0;
 	int doit = task == current;
@@ -556,62 +556,64 @@ long do_arch_prctl(struct task_struct *task, int option, unsigned long addr)
 
 	switch (option) {
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
@@ -622,9 +624,9 @@ long do_arch_prctl(struct task_struct *task, int option, unsigned long addr)
 	return ret;
 }
 
-SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, addr)
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return do_arch_prctl(current, option, addr);
+	return do_arch_prctl_64(current, option, arg2);
 }
 
 unsigned long KSTK_ESP(struct task_struct *task)
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 2364b23ea3e5..f37d18124648 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -396,12 +396,12 @@ static int putreg(struct task_struct *child,
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
@@ -410,7 +410,7 @@ static int putreg(struct task_struct *child,
 		if (value >= TASK_SIZE_MAX)
 			return -EIO;
 		if (child->thread.gsbase != value)
-			return do_arch_prctl(child, ARCH_SET_GS, value);
+			return do_arch_prctl_64(child, ARCH_SET_GS, value);
 		return 0;
 #endif
 	}
@@ -869,7 +869,7 @@ long arch_ptrace(struct task_struct *child, long request,
 		   Works just like arch_prctl, except that the arguments
 		   are reversed. */
 	case PTRACE_ARCH_PRCTL:
-		ret = do_arch_prctl(child, data, addr);
+		ret = do_arch_prctl_64(child, data, addr);
 		break;
 #endif
 
diff --git a/arch/x86/um/os-Linux/prctl.c b/arch/x86/um/os-Linux/prctl.c
index 0a6e16a35b77..8431e87ac333 100644
--- a/arch/x86/um/os-Linux/prctl.c
+++ b/arch/x86/um/os-Linux/prctl.c
@@ -6,7 +6,7 @@
 #include <sys/ptrace.h>
 #include <asm/ptrace.h>
 
-int os_arch_prctl(int pid, int option, unsigned long *addr)
+int os_arch_prctl(int pid, int option, unsigned long *arg2)
 {
-	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) addr, option);
+	return ptrace(PTRACE_ARCH_PRCTL, pid, (unsigned long) arg2, option);
 }
diff --git a/arch/x86/um/syscalls_64.c b/arch/x86/um/syscalls_64.c
index 42369fa5421f..81b9fe100f7c 100644
--- a/arch/x86/um/syscalls_64.c
+++ b/arch/x86/um/syscalls_64.c
@@ -12,10 +12,10 @@
 #include <asm/prctl.h> /* XXX This should get the constants from libc */
 #include <os.h>
 
-long arch_prctl(struct task_struct *task, int option
-		unsigned long __user *addr)
+long arch_prctl(struct task_struct *task, int option)
+		unsigned long __user *arg2)
 {
-	unsigned long *ptr = addr, tmp;
+	unsigned long *ptr = arg2, tmp;
 	long ret;
 	int pid = task->mm->context.id.u.pid;
 
@@ -65,19 +65,19 @@ long arch_prctl(struct task_struct *task, int option
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
 
-SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, addr)
+SYSCALL_DEFINE2(arch_prctl, int, option, unsigned long, arg2)
 {
-	return arch_prctl(current, option, (unsigned long __user *) addr);
+	return arch_prctl(current, option, (unsigned long __user *) arg2);
 }
 
 void arch_switch_to(struct task_struct *to)
-- 
2.11.0


