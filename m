Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v11 4/7] x86/syscalls/32: Wire up arch_prctl on x86-32
Date: Thu, 10 Nov 2016 15:40:52 -0800
Message-Id: <20161110234055.8654-5-khuey@kylehuey.com>
In-Reply-To: <20161110234055.8654-1-khuey@kylehuey.com>
References: <20161110234055.8654-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Hook up arch_prctl to call do_arch_prctl() on x86-32, and in 32 bit compat
mode on x86-64. This allows us to have arch_prctls that are not specific to
64 bits.

On UML, simply stub out this syscall.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/entry/syscalls/syscall_32.tbl | 1 +
 arch/x86/kernel/process_32.c           | 7 +++++++
 arch/x86/kernel/process_64.c           | 7 +++++++
 arch/x86/um/Makefile                   | 2 +-
 arch/x86/um/syscalls_32.c              | 7 +++++++
 include/linux/compat.h                 | 2 ++
 6 files changed, 25 insertions(+), 1 deletion(-)
 create mode 100644 arch/x86/um/syscalls_32.c

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 2b36185..d78c6b5 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -384,8 +384,9 @@
 375	i386	membarrier		sys_membarrier
 376	i386	mlock2			sys_mlock2
 377	i386	copy_file_range		sys_copy_file_range
 378	i386	preadv2			sys_preadv2			compat_sys_preadv2
 379	i386	pwritev2		sys_pwritev2			compat_sys_pwritev2
 380	i386	pkey_mprotect		sys_pkey_mprotect
 381	i386	pkey_alloc		sys_pkey_alloc
 382	i386	pkey_free		sys_pkey_free
+385	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
diff --git a/arch/x86/kernel/process_32.c b/arch/x86/kernel/process_32.c
index bd7be8e..95d3adc 100644
--- a/arch/x86/kernel/process_32.c
+++ b/arch/x86/kernel/process_32.c
@@ -30,16 +30,17 @@
 #include <linux/ptrace.h>
 #include <linux/personality.h>
 #include <linux/percpu.h>
 #include <linux/prctl.h>
 #include <linux/ftrace.h>
 #include <linux/uaccess.h>
 #include <linux/io.h>
 #include <linux/kdebug.h>
+#include <linux/syscalls.h>
 
 #include <asm/pgtable.h>
 #include <asm/ldt.h>
 #include <asm/processor.h>
 #include <asm/fpu/internal.h>
 #include <asm/desc.h>
 #ifdef CONFIG_MATH_EMULATION
 #include <asm/math_emu.h>
@@ -49,16 +50,17 @@
 
 #include <asm/tlbflush.h>
 #include <asm/cpu.h>
 #include <asm/idle.h>
 #include <asm/syscalls.h>
 #include <asm/debugreg.h>
 #include <asm/switch_to.h>
 #include <asm/vm86.h>
+#include <asm/proto.h>
 
 void __show_regs(struct pt_regs *regs, int all)
 {
 	unsigned long cr0 = 0L, cr2 = 0L, cr3 = 0L, cr4 = 0L;
 	unsigned long d0, d1, d2, d3, d6, d7;
 	unsigned long sp;
 	unsigned short ss, gs;
 
@@ -296,8 +298,13 @@ __switch_to(struct task_struct *prev_p, struct task_struct *next_p)
 		lazy_load_gs(next->gs);
 
 	switch_fpu_finish(next_fpu, fpu_switch);
 
 	this_cpu_write(current_task, next_p);
 
 	return prev_p;
 }
+
+SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+{
+	return do_arch_prctl_common(current, code, arg2);
+}
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index bf75d26..3a2a84d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -621,12 +621,19 @@ SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
 
 	ret = do_arch_prctl_64(current, code, arg2);
 	if (ret == -EINVAL)
 		ret = do_arch_prctl_common(current, code, arg2);
 
 	return ret;
 }
 
+#ifdef CONFIG_IA32_EMULATION
+COMPAT_SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+{
+	return do_arch_prctl_common(current, code, arg2);
+}
+#endif
+
 unsigned long KSTK_ESP(struct task_struct *task)
 {
 	return task_pt_regs(task)->sp;
 }
diff --git a/arch/x86/um/Makefile b/arch/x86/um/Makefile
index e7e7055..69f0827 100644
--- a/arch/x86/um/Makefile
+++ b/arch/x86/um/Makefile
@@ -11,17 +11,17 @@ endif
 obj-y = bug.o bugs_$(BITS).o delay.o fault.o ldt.o \
 	ptrace_$(BITS).o ptrace_user.o setjmp_$(BITS).o signal.o \
 	stub_$(BITS).o stub_segv.o \
 	sys_call_table_$(BITS).o sysrq_$(BITS).o tls_$(BITS).o \
 	mem_$(BITS).o subarch.o os-$(OS)/
 
 ifeq ($(CONFIG_X86_32),y)
 
-obj-y += checksum_32.o
+obj-y += checksum_32.o syscalls_32.o
 obj-$(CONFIG_ELF_CORE) += elfcore.o
 
 subarch-y = ../lib/string_32.o ../lib/atomic64_32.o ../lib/atomic64_cx8_32.o
 subarch-$(CONFIG_RWSEM_XCHGADD_ALGORITHM) += ../lib/rwsem.o
 
 else
 
 obj-y += syscalls_64.o vdso/
diff --git a/arch/x86/um/syscalls_32.c b/arch/x86/um/syscalls_32.c
new file mode 100644
index 0000000..ccf0598
--- /dev/null
+++ b/arch/x86/um/syscalls_32.c
@@ -0,0 +1,7 @@
+#include <linux/syscalls.h>
+#include <os.h>
+
+SYSCALL_DEFINE2(arch_prctl, int, code, unsigned long, arg2)
+{
+	return -EINVAL;
+}
diff --git a/include/linux/compat.h b/include/linux/compat.h
index 6360939..500cdb3 100644
--- a/include/linux/compat.h
+++ b/include/linux/compat.h
@@ -716,16 +716,18 @@ int __compat_save_altstack(compat_stack_t __user *, unsigned long);
 } while (0);
 
 asmlinkage long compat_sys_sched_rr_get_interval(compat_pid_t pid,
 						 struct compat_timespec __user *interval);
 
 asmlinkage long compat_sys_fanotify_mark(int, unsigned int, __u32, __u32,
 					    int, const char __user *);
 
+asmlinkage long compat_sys_arch_prctl(int, unsigned long);
+
 /*
  * For most but not all architectures, "am I in a compat syscall?" and
  * "am I a compat task?" are the same question.  For architectures on which
  * they aren't the same question, arch code can override in_compat_syscall.
  */
 
 #ifndef in_compat_syscall
 static inline bool in_compat_syscall(void) { return is_compat_task(); }
-- 
2.10.2


