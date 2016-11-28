Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Kyle Huey <me@kylehuey.com>
Subject: [PATCH v13 6/8] x86/arch_prctl: Add ARCH_[GET|SET]_CPUID
Date: Sun, 27 Nov 2016 19:05:19 -0800
Message-Id: <20161128030521.4423-7-khuey@kylehuey.com>
In-Reply-To: <20161128030521.4423-1-khuey@kylehuey.com>
References: <20161128030521.4423-1-khuey@kylehuey.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Robert O'Callahan <robert@ocallahan.org>, Thomas Gleixner <tglx@linutronix.de>, Andy Lutomirski <luto@kernel.org>, Ingo Molnar <mingo@redhat.com>, "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org, Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Alexander Viro <viro@zeniv.linux.org.uk>, Shuah Khan <shuah@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>, Borislav Petkov <bp@suse.de>, Peter Zijlstra <peterz@infradead.org>, Boris Ostrovsky <boris.ostrovsky@oracle.com>, Len Brown <len.brown@intel.com>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Dmitry Safonov <dsafonov@virtuozzo.com>, David Matlack <dmatlack@google.com>, Nadav Amit <nadav.amit@gmail.com>, Andi Kleen <andi@firstfloor.org>
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
 arch/x86/include/asm/msr-index.h   |  3 ++
 arch/x86/include/asm/processor.h   |  2 +
 arch/x86/include/asm/thread_info.h |  6 ++-
 arch/x86/include/uapi/asm/prctl.h  |  3 ++
 arch/x86/kernel/cpu/intel.c        |  7 ++++
 arch/x86/kernel/process.c          | 82 ++++++++++++++++++++++++++++++++++++++
 fs/exec.c                          |  1 +
 include/linux/thread_info.h        |  4 ++
 8 files changed, 107 insertions(+), 1 deletion(-)

diff --git a/arch/x86/include/asm/msr-index.h b/arch/x86/include/asm/msr-index.h
index 3ac0acf..b138b8f 100644
--- a/arch/x86/include/asm/msr-index.h
+++ b/arch/x86/include/asm/msr-index.h
@@ -49,16 +49,19 @@
 #define NHM_C1_AUTO_DEMOTE		(1UL << 26)
 #define ATM_LNC_C6_AUTO_DEMOTE		(1UL << 25)
 #define SNB_C1_AUTO_UNDEMOTE		(1UL << 27)
 #define SNB_C3_AUTO_UNDEMOTE		(1UL << 28)
 
 #define MSR_MTRRcap			0x000000fe
 #define MSR_IA32_BBL_CR_CTL		0x00000119
 #define MSR_IA32_BBL_CR_CTL3		0x0000011e
+#define MSR_MISC_FEATURES_ENABLES	0x00000140
+#define MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT	0
+#define MSR_MISC_FEATURES_ENABLES_CPUID_FAULT		BIT_ULL(MSR_MISC_FEATURES_ENABLES_CPUID_FAULT_BIT)
 
 #define MSR_IA32_SYSENTER_CS		0x00000174
 #define MSR_IA32_SYSENTER_ESP		0x00000175
 #define MSR_IA32_SYSENTER_EIP		0x00000176
 
 #define MSR_IA32_MCG_CAP		0x00000179
 #define MSR_IA32_MCG_STATUS		0x0000017a
 #define MSR_IA32_MCG_CTL		0x0000017b
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 984a7bf..65b2494 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -803,16 +803,18 @@ extern void start_thread(struct pt_regs *regs, unsigned long new_ip,
 
 /* Get/set a process' ability to use the timestamp counter instruction */
 #define GET_TSC_CTL(adr)	get_tsc_mode((adr))
 #define SET_TSC_CTL(val)	set_tsc_mode((val))
 
 extern int get_tsc_mode(unsigned long adr);
 extern int set_tsc_mode(unsigned int val);
 
+DECLARE_PER_CPU(u64, msr_misc_features_shadow);
+
 /* Register/unregister a process' MPX related resource */
 #define MPX_ENABLE_MANAGEMENT()	mpx_enable_management()
 #define MPX_DISABLE_MANAGEMENT()	mpx_disable_management()
 
 #ifdef CONFIG_X86_INTEL_MPX
 extern int mpx_enable_management(void);
 extern int mpx_disable_management(void);
 #else
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index ad6f5eb0..9fc44b9 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -82,16 +82,17 @@ struct thread_info {
 #define TIF_SIGPENDING		2	/* signal pending */
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* reenable singlestep on user return*/
 #define TIF_SYSCALL_EMU		6	/* syscall emulation active */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
+#define TIF_NOCPUID		15	/* CPUID is not accessible in userland */
 #define TIF_NOTSC		16	/* TSC is not accessible in userland */
 #define TIF_IA32		17	/* IA32 compatibility process */
 #define TIF_NOHZ		19	/* in adaptive nohz mode */
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
@@ -105,16 +106,17 @@ struct thread_info {
 #define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
 #define _TIF_SINGLESTEP		(1 << TIF_SINGLESTEP)
 #define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
 #define _TIF_SYSCALL_EMU	(1 << TIF_SYSCALL_EMU)
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
+#define _TIF_NOCPUID		(1 << TIF_NOCPUID)
 #define _TIF_NOTSC		(1 << TIF_NOTSC)
 #define _TIF_IA32		(1 << TIF_IA32)
 #define _TIF_NOHZ		(1 << TIF_NOHZ)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
@@ -133,17 +135,17 @@ struct thread_info {
 
 /* work to do on any return to user space */
 #define _TIF_ALLWORK_MASK						\
 	((0x0000FFFF & ~_TIF_SECCOMP) | _TIF_SYSCALL_TRACEPOINT |	\
 	_TIF_NOHZ)
 
 /* flags to check in __switch_to() */
 #define _TIF_WORK_CTXSW							\
-	(_TIF_IO_BITMAP|_TIF_NOTSC|_TIF_BLOCKSTEP)
+	(_TIF_IO_BITMAP|_TIF_NOCPUID|_TIF_NOTSC|_TIF_BLOCKSTEP)
 
 #define _TIF_WORK_CTXSW_PREV (_TIF_WORK_CTXSW|_TIF_USER_RETURN_NOTIFY)
 #define _TIF_WORK_CTXSW_NEXT (_TIF_WORK_CTXSW)
 
 #define STACK_WARN		(THREAD_SIZE/8)
 
 /*
  * macros/functions for gaining access to the thread information structure
@@ -234,11 +236,13 @@ static inline int arch_within_stack_frames(const void * const stack,
  * EFLAGS values that other (fast) syscall return instructions
  * are not able to restore properly.
  */
 #define force_iret() set_thread_flag(TIF_NOTIFY_RESUME)
 
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
+extern void arch_setup_new_exec(void);
+#define arch_setup_new_exec arch_setup_new_exec
 #endif	/* !__ASSEMBLY__ */
 
 #endif /* _ASM_X86_THREAD_INFO_H */
diff --git a/arch/x86/include/uapi/asm/prctl.h b/arch/x86/include/uapi/asm/prctl.h
index ae135de..80240a2 100644
--- a/arch/x86/include/uapi/asm/prctl.h
+++ b/arch/x86/include/uapi/asm/prctl.h
@@ -1,15 +1,18 @@
 #ifndef _ASM_X86_PRCTL_H
 #define _ASM_X86_PRCTL_H
 
 #define ARCH_SET_GS 0x1001
 #define ARCH_SET_FS 0x1002
 #define ARCH_GET_FS 0x1003
 #define ARCH_GET_GS 0x1004
 
+#define ARCH_GET_CPUID 0x1005
+#define ARCH_SET_CPUID 0x1006
+
 #ifdef CONFIG_CHECKPOINT_RESTORE
 # define ARCH_MAP_VDSO_X32	0x2001
 # define ARCH_MAP_VDSO_32	0x2002
 # define ARCH_MAP_VDSO_64	0x2003
 #endif
 
 #endif /* _ASM_X86_PRCTL_H */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 12ddddf..11e4a0a 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -451,16 +451,23 @@ static void intel_bsp_resume(struct cpuinfo_x86 *c)
 	 */
 	init_intel_energy_perf(c);
 }
 
 static void init_intel_misc_features(struct cpuinfo_x86 *c)
 {
 	u64 msr;
 
+	if (rdmsrl_safe(MSR_MISC_FEATURES_ENABLES, &msr))
+		return;
+
+	msr = 0;
+	wrmsrl(MSR_MISC_FEATURES_ENABLES, msr);
+	this_cpu_write(msr_misc_features_shadow, msr);
+
 	if (!rdmsrl_safe(MSR_PLATFORM_INFO, &msr)) {
 		if (msr & MSR_PLATFORM_INFO_CPUID_FAULT)
 			set_cpu_cap(c, X86_FEATURE_CPUID_FAULT);
 	}
 }
 
 static void init_intel(struct cpuinfo_x86 *c)
 {
diff --git a/arch/x86/kernel/process.c b/arch/x86/kernel/process.c
index 5ac20b5..ba39090 100644
--- a/arch/x86/kernel/process.c
+++ b/arch/x86/kernel/process.c
@@ -28,16 +28,17 @@
 #include <asm/mwait.h>
 #include <asm/fpu/internal.h>
 #include <asm/debugreg.h>
 #include <asm/nmi.h>
 #include <asm/tlbflush.h>
 #include <asm/mce.h>
 #include <asm/vm86.h>
 #include <asm/switch_to.h>
+#include <asm/prctl.h>
 
 /*
  * per-CPU TSS segments. Threads are completely 'soft' on Linux,
  * no more per-task TSS's. The TSS size is kept cacheline-aligned
  * so they are allowed to end up in the .data..cacheline_aligned
  * section. Since TSS's are completely CPU-local, we want them
  * on exact cacheline boundaries, to eliminate cacheline ping-pong.
  */
@@ -187,16 +188,85 @@ int set_tsc_mode(unsigned int val)
 	else if (val == PR_TSC_ENABLE)
 		enable_TSC();
 	else
 		return -EINVAL;
 
 	return 0;
 }
 
+DEFINE_PER_CPU(u64, msr_misc_features_shadow);
+
+static void set_cpuid_faulting(bool on)
+{
+	u64 msrval;
+
+	DEBUG_LOCKS_WARN_ON(!irqs_disabled());
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
 void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 		      struct tss_struct *tss)
 {
 	struct thread_struct *prev, *next;
 
 	prev = &prev_p->thread;
 	next = &next_p->thread;
 
@@ -206,16 +276,21 @@ void __switch_to_xtra(struct task_struct *prev_p, struct task_struct *next_p,
 
 		debugctl &= ~DEBUGCTLMSR_BTF;
 		if (test_tsk_thread_flag(next_p, TIF_BLOCKSTEP))
 			debugctl |= DEBUGCTLMSR_BTF;
 
 		update_debugctlmsr(debugctl);
 	}
 
+	if (test_tsk_thread_flag(prev_p, TIF_NOCPUID) ^
+	    test_tsk_thread_flag(next_p, TIF_NOCPUID)) {
+		set_cpuid_faulting(test_tsk_thread_flag(next_p, TIF_NOCPUID));
+	}
+
 	if (test_tsk_thread_flag(prev_p, TIF_NOTSC) ^
 	    test_tsk_thread_flag(next_p, TIF_NOTSC)) {
 		/* prev and next are different */
 		if (test_tsk_thread_flag(next_p, TIF_NOTSC))
 			hard_disable_TSC();
 		else
 			hard_enable_TSC();
 	}
@@ -583,10 +658,17 @@ unsigned long get_wchan(struct task_struct *p)
 out:
 	put_task_stack(p);
 	return ret;
 }
 
 long do_arch_prctl_common(struct task_struct *task, int code,
 			  unsigned long cpuid_enabled)
 {
+	switch (code) {
+	case ARCH_GET_CPUID:
+		return get_cpuid_mode();
+	case ARCH_SET_CPUID:
+		return set_cpuid_mode(task, cpuid_enabled);
+	}
+
 	return -EINVAL;
 }
diff --git a/fs/exec.c b/fs/exec.c
index 4e497b9..3e6872c 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -1287,16 +1287,17 @@ void setup_new_exec(struct linux_binprm * bprm)
 	/* This is the point of no return */
 	current->sas_ss_sp = current->sas_ss_size = 0;
 
 	if (uid_eq(current_euid(), current_uid()) && gid_eq(current_egid(), current_gid()))
 		set_dumpable(current->mm, SUID_DUMP_USER);
 	else
 		set_dumpable(current->mm, suid_dumpable);
 
+	arch_setup_new_exec();
 	perf_event_exec();
 	__set_task_comm(current, kbasename(bprm->filename), true);
 
 	/* Set the new mm task size. We have to do that late because it may
 	 * depend on TIF_32BIT which is only updated in flush_thread() on
 	 * some architectures like powerpc
 	 */
 	current->mm->task_size = TASK_SIZE;
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 2873baf..d46f50d 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -129,11 +129,15 @@ static __always_inline void check_object_size(const void *ptr, unsigned long n,
 		__check_object_size(ptr, n, to_user);
 }
 #else
 static inline void check_object_size(const void *ptr, unsigned long n,
 				     bool to_user)
 { }
 #endif /* CONFIG_HARDENED_USERCOPY */
 
+#ifndef arch_setup_new_exec
+static inline void arch_setup_new_exec(void) {}
+#endif
+
 #endif	/* __KERNEL__ */
 
 #endif /* _LINUX_THREAD_INFO_H */
-- 
2.10.2


