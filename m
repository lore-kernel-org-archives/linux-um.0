Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v16 08/10] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Date: Mon, 20 Mar 2017 01:16:26 -0700
Message-Id: <20170320081628.18952-9-khuey@kylehuey.com>
In-Reply-To: <20170320081628.18952-1-khuey@kylehuey.com>
References: <20170320081628.18952-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>, Grzegorz Andrejczuk <grzegorz.andrejczuk@intel.com>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kselftest@vger.kernel.org, kvm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Intel supports faulting on the CPUID instruction beginning with Ivy Bridge.
When enabled, the processor will fault on attempts to execute the CPUID
instruction with CPL>0. Exposing this feature to userspace will allow a
ptracer to trap and emulate the CPUID instruction.

When supported, this feature is controlled by toggling bit 0 of
MSR_MISC_FEATURES_ENABLES. It is documented in detail in Section 2.3.2 of
https://bugzilla.kernel.org/attachment.cgi?id=243991

Implement a new pair of arch_prctls, available on both x86-32 and x86-64.

ARCH_GET_CPUID: Returns the current CPUID state, either 0 if CPUID faulting
    is enabled (and thus the CPUID instruction is not available) or 1 if
    CPUID faulting is not enabled.

ARCH_SET_CPUID: Set the CPUID state to the second argument. If
    cpuid_enabled is 0 CPUID faulting will be activated, otherwise it will
    be deactivated. Returns ENODEV if CPUID faulting is not supported on
    this system.

The state of the CPUID faulting flag is propagated across forks, but reset
upon exec.

Signed-off-by: Kyle Huey <khuey@kylehuey.com>
---
 arch/x86/include/asm/msr-index.h   |  2 +
 arch/x86/include/asm/processor.h   |  2 +
 arch/x86/include/asm/thread_info.h |  6 ++-
 arch/x86/include/uapi/asm/prctl.h  |  9 +++++
 arch/x86/kernel/cpu/intel.c        | 18 +++++----
 arch/x86/kernel/process.c          | 78 ++++++++++++++++++++++++++++++++++++++
 fs/exec.c                          |  1 +
 include/linux/thread_info.h        |  4 ++
 8 files changed, 111 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index b1f75daca34b..673f9ac50f6d 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -558,6 +558,8 @@
 /* MISC_FEATURES_ENABLES non-architectural features */
 #define MSR_MISC_FEATURES_ENABLES	0x00000140
 
+#define MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT	0
+#define MSR_MISC_FEATURES_ENABLES_CPUID_FAULT		BIT_ULL(MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT)
 #define MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT	1
 
 #define MSR_IA32_TSC_DEADLINE		0x000006E0
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index f385eca5407a..a80c1b3997ed 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -884,6 +884,8 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 extern int get_tsc_mode(unsigned long adr);
 extern int set_tsc_mode(unsigned int val);
 
+DECLARE_PER_CPU(u64, msr_misc_features_shadow);
+
 /* Register/unregister a process' MPX related resource */
 #define MPX_ENABLE_MANAGEMENT()	mpx_enable_management()
 #define MPX_DISABLE_MANAGEMENT()	mpx_disable_management()
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index ad6f5eb07a95..9fc44b95f7cb 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -87,6 +87,7 @@ struct thread_info {
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
+#define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
@@ -110,6 +111,7 @@ struct thread_info {
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
+#define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
@@ -138,7 +140,7 @@ struct thread_info {
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOTSC|_TIF_BLOCKSTEP)
+	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
@@ -239,6 +241,8 @@ static inline int arch_within_stack_frames(const void * const stack,
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
+extern void arch_setup_new_exec(void);
+#define arch_setup_new_exec arch_setup_new_exec
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_THREAD_INFO_H */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index 835aa51c7f6e..5dbbd1be6b97 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -6,8 +6,17 @@
 #define ARCH_GET_FS 0x1003
 #define ARCH_GET_GS 0x1004
 
+#define ARCH_GET_CPUID 0x1005
+#define ARCH_SET_CPUID 0x1006
+
 #define ARCH_MAP_VDSO_X32	0x2001
 #define ARCH_MAP_VDSO_32	0x2002
 #define ARCH_MAP_VDSO_64	0x2003
 
+#ifdef CONFIG_CHECKPOINT_RESTORE
+# define ARCH_MAP_VDSO_X32	0x2001
+# define ARCH_MAP_VDSO_32	0x2002
+# define ARCH_MAP_VDSO_64	0x2003
+#endif
+
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index a07f8295c9ed..dfa90a3a5145 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -90,16 +90,12 @@ static void probe_xeon_phi_r3mwait(struct cpuinfo_x86 *c)
 		return;
 	}
 
-	if (ring3mwait_disabled) {
-		msr_clear_bit(MSR_MISC_FEATURES_ENABLES,
-			      MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT);
+	if (ring3mwait_disabled)
 		return;
-	}
-
-	msr_set_bit(MSR_MISC_FEATURES_ENABLES,
-		    MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT);
 
 	set_cpu_cap(c, X86_FEATURE_RING3MWAIT);
+	this_cpu_or(msr_misc_features_shadow,
+		    1UL << MSR_MISC_FEATURES_ENABLES_RING3MWAIT_BIT);
 
 	if (c == &boot_cpu_data)
 		ELF_HWCAP2 |= HWCAP2_RING3MWAIT;
@@ -505,9 +501,15 @@ static void init_intel_misc_features(struct cpuinfo_x86 *c)
 	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &msr))
 		return;
 
-	/* Check features and update capabilities */
+	/* Clear all MISC features */
+	this_cpu_write(msr_misc_features_shadow, 0);
+
+	/* Check features and update capabilities and shadow control bits */
 	init_cpuid_fault(c);
 	probe_xeon_phi_r3mwait(c);
+
+	msr = this_cpu_read(msr_misc_features_shadow);
+	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
 }
 
 static void init_intel(struct cpuinfo_x86 *c)
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index b12e95eceb83..0bb88428cbf2 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -37,6 +37,7 @@
 #include <asm/vm86.h>
 #include <asm/switch_to.h>
 #include <asm/desc.h>
+#include <asm/prctl.h>
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
@@ -172,6 +173,73 @@ int set_tsc_mode(unsigned int val)
 	return 0;
 }
 
+DEFINE_PER_CPU(u64, msr_misc_features_shadow);
+
+static void set_cpuid_faulting(bool on)
+{
+	u64 msrval;
+
+	msrval = this_cpu_read(msr_misc_features_shadow);
+	msrval &= ~MSR_MISC_FEATURES_ENABLES_CPUID_FAULT;
+	msrval |= (on << MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT);
+	this_cpu_write(msr_misc_features_shadow, msrval);
+	wrmsrl(MSR_MISC_FEATURES_ENABLES, msrval);
+}
+
+static void disable_cpuid(void)
+{
+	preempt_disable();
+	if (!test_and_set_thread_flag(TIF_NOCPUID)) {
+		/*
+		 * Must flip the CPU state synchronously with
+		 * TIF_NOCPUID in the current running context.
+		 */
+		set_cpuid_faulting(true);
+	}
+	preempt_enable();
+}
+
+static void enable_cpuid(void)
+{
+	preempt_disable();
+	if (test_and_clear_thread_flag(TIF_NOCPUID)) {
+		/*
+		 * Must flip the CPU state synchronously with
+		 * TIF_NOCPUID in the current running context.
+		 */
+		set_cpuid_faulting(false);
+	}
+	preempt_enable();
+}
+
+static int get_cpuid_mode(void)
+{
+	return !test_thread_flag(TIF_NOCPUID);
+}
+
+static int set_cpuid_mode(struct task_struct *task, unsigned long cpuid_enabled)
+{
+	if (!static_cpu_has(X86_FEATURE_CPUID_FAULT))
+		return -ENODEV;
+
+	if (cpuid_enabled)
+		enable_cpuid();
+	else
+		disable_cpuid();
+
+	return 0;
+}
+
+/*
+ * Called immediately after a successful exec.
+ */
+void arch_setup_new_exec(void)
+{
+	/* If cpuid was previously disabled for this task, re-enable it. */
+	if (test_thread_flag(TIF_NOCPUID))
+		enable_cpuid();
+}
+
 static inline void switch_to_bitmap(struct tss_struct *tss,
 				    struct thread_struct *prev,
 				    struct thread_struct *next,
@@ -225,6 +293,9 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 
 	if ((tifp ^ tifn) & _TIF_NOTSC)
 		cr4_toggle_bits(X86_CR4_TSD);
+
+	if ((tifp ^ tifn) & _TIF_NOCPUID)
+		set_cpuid_faulting(!!(tifn & _TIF_NOCPUID));
 }
 
 /*
@@ -549,5 +620,12 @@ unsigned long get_wchan(struct task_struct *p)
 long do_arch_prctl_common(struct task_struct *task, int option,
 			  unsigned long cpuid_enabled)
 {
+	switch (option) {
+	case ARCH_GET_CPUID:
+		return get_cpuid_mode();
+	case ARCH_SET_CPUID:
+		return set_cpuid_mode(task, cpuid_enabled);
+	}
+
 	return -EINVAL;
 }
diff --git a/fs/exec.c b/fs/exec.c
index 65145a3df065..72934df68471 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1320,6 +1320,7 @@ void setup_new_exec(struct linux_binprm * bprm)
 	else
 		set_dumpable(current->mm, suid_dumpable);
 
+	arch_setup_new_exec();
 	perf_event_exec();
 	__set_task_comm(current, kbasename(bprm->filename), true);
 
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 58373875e8ee..1539e08757f3 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -101,6 +101,10 @@ static inline void check_object_size(const void *ptr, unsigned long n,
 { }
 #endif /* CONFIG_HARDENED_USERCOPY */
 
+#ifndef arch_setup_new_exec
+static inline void arch_setup_new_exec(void) {}
+#endif
+
 #endif	/* __KERNEL__ */
 
 #endif /* _LINUX_THREAD_INFO_H */
-- 
2.11.0


