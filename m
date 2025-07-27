Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 103EBC87FCC
	for <linux-um@archiver.kernel.org>; Sun, 27 Jul 2025 06:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=eIxGAWuGUo01Ki8drqKVcpyfvbVyQigMnaakWFoulGg=; b=aa3AdZiPjuMiwqVKZzerDqlGQQ
	xj2Tn1F8Qn025eVubWeDjQPauyekMubQBEoBb/AEcvwmLSvi7Ll+qPh7eGgT3LqIGRAXVIjs+6oCa
	6RnFrUUlQ/KszsvclatLT3fzYw+3rgm1a7b3knA1v0m4mFnkYuTq0mEdekvGY0FBnEnELgxtVOEgj
	nEyewlETfUA9tNUrjiEUwAkJnfPOqphDiojv21kNXk2W/R4bPwZOrOkzuvLoA/yzBt89939szMUtD
	I1Fv6Wc4bcyM1Ijyq554g0gtUAdE2MdtxwoPBcDs2nxv4/tVv6XDAjJD0QjKcnf4lZQ7YLLEVUT3L
	o+7G4TTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufuu9-0000000CO4N-3On8;
	Sun, 27 Jul 2025 06:30:41 +0000
Received: from out-173.mta0.migadu.com ([91.218.175.173])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ufuu6-0000000CO1M-1AOs
	for linux-um@lists.infradead.org;
	Sun, 27 Jul 2025 06:30:40 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1753597836;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eIxGAWuGUo01Ki8drqKVcpyfvbVyQigMnaakWFoulGg=;
	b=X3oYGqpp9IQoFv+F5ZkU3m5NLfHjA7AASQcZFK0GCV1XZj70F3Bert7y1HFq4iy365nWSZ
	htE7IAiE5LKvFnuh+osRY5VEcE837sMilqBKmPsRQ01HJ9QDqYwqWGtEpBgkbN/nHXO0qC
	Az+3KVyAkqgc86hm7z1oMRkDBJjUAP4=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH 9/9] um: Add initial SMP support
Date: Sun, 27 Jul 2025 14:29:37 +0800
Message-Id: <20250727062937.1369050-10-tiwei.bie@linux.dev>
In-Reply-To: <20250727062937.1369050-1-tiwei.bie@linux.dev>
References: <20250727062937.1369050-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250726_233038_779866_3E3F20C9 
X-CRM114-Status: GOOD (  26.05  )
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Tiwei Bie <tiwei.btw@antgroup.com>

Add initial symmetric multi-processing (SMP) support to UML. With
this support, it is now possible for users to tell UML to start
multiple virtual CPUs, each represented as a separate host thread.

In UML, kthreads and normal threads (when running in kernel mode)
can be scheduled and executed simultaneously on different virtual
CPUs. However, the userspace code of normal threads still runs
within their single-threaded stubs, meaning that true SMP support
in userspace is not yet realized within the same process.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/Kconfig                         |  39 +++-
 arch/um/include/asm/Kbuild              |   3 +-
 arch/um/include/asm/current.h           |   5 +-
 arch/um/include/asm/hardirq.h           |  24 ++-
 arch/um/include/asm/mmu.h               |  10 +
 arch/um/include/asm/percpu.h            |  20 ++
 arch/um/include/asm/pgtable.h           |   2 +
 arch/um/include/asm/processor-generic.h |   6 +
 arch/um/include/asm/smp.h               |  23 +-
 arch/um/include/asm/spinlock.h          |   8 +
 arch/um/include/linux/smp-internal.h    |  21 ++
 arch/um/include/shared/kern_util.h      |   1 +
 arch/um/include/shared/os.h             |   6 +
 arch/um/include/shared/skas/mm_id.h     |   3 +
 arch/um/include/shared/smp.h            |  19 ++
 arch/um/kernel/Makefile                 |   1 +
 arch/um/kernel/irq.c                    |  29 +++
 arch/um/kernel/mem.c                    |   2 +
 arch/um/kernel/process.c                |   8 +-
 arch/um/kernel/skas/mmu.c               |  32 ++-
 arch/um/kernel/smp.c                    | 266 ++++++++++++++++++++++++
 arch/um/kernel/tlb.c                    |   5 +-
 arch/um/kernel/trap.c                   |   2 +-
 arch/um/kernel/um_arch.c                |  24 ++-
 arch/um/os-Linux/Makefile               |   4 +-
 arch/um/os-Linux/main.c                 |   3 +-
 arch/um/os-Linux/process.c              |  10 +
 arch/um/os-Linux/skas/process.c         |   9 +
 arch/um/os-Linux/smp.c                  |  86 ++++++++
 arch/um/os-Linux/start_up.c             |   4 +
 arch/um/os-Linux/time.c                 |   7 +-
 31 files changed, 655 insertions(+), 27 deletions(-)
 create mode 100644 arch/um/include/asm/percpu.h
 create mode 100644 arch/um/include/asm/spinlock.h
 create mode 100644 arch/um/include/linux/smp-internal.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..9678fe25be22 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -30,6 +30,7 @@ config UML
 	select HAVE_GCC_PLUGINS
 	select ARCH_SUPPORTS_LTO_CLANG
 	select ARCH_SUPPORTS_LTO_CLANG_THIN
+	select ARCH_USE_QUEUED_RWLOCKS
 	select TRACE_IRQFLAGS_SUPPORT
 	select TTY # Needed for line.c
 	select HAVE_ARCH_VMAP_STACK
@@ -79,10 +80,41 @@ config HZ
 	int
 	default 100
 
-config NR_CPUS
+config SMP
+	bool "Symmetric multi-processing support"
+	default n
+	help
+	  This option enables UML SMP support.
+
+	  With this enabled, it is possible for users to tell UML to start
+	  multiple virtual processors. Each virtual processor is represented
+	  as a separate host thread.
+
+	  In UML, kthreads and normal threads (when running in kernel mode)
+	  can be scheduled and executed simultaneously on different virtual
+	  processors. However, the userspace code of normal threads still
+	  runs within their respective single-threaded stubs, meaning that
+	  true SMP support in userspace is not yet realized within the same
+	  process.
+
+config NR_CPUS_RANGE_BEGIN
+	int
+	default 1 if !SMP
+	default 2
+
+config NR_CPUS_RANGE_END
+	int
+	default 256
+
+config NR_CPUS_DEFAULT
 	int
-	range 1 1
-	default 1
+	default 2 if  SMP
+	default 1 if !SMP
+
+config NR_CPUS
+	int "Maximum number of CPUs" if SMP
+	range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
+	default NR_CPUS_DEFAULT
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
@@ -258,6 +290,7 @@ source "arch/um/drivers/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
+	depends on !SMP
 
 menu "Power management options"
 
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 04ab3b653a48..22c6409e7815 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -17,10 +17,11 @@ generic-y += module.h
 generic-y += module.lds.h
 generic-y += param.h
 generic-y += parport.h
-generic-y += percpu.h
 generic-y += preempt.h
+generic-y += qrwlock.h
 generic-y += runtime-const.h
 generic-y += softirq_stack.h
+generic-y += spinlock_types.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/um/include/asm/current.h b/arch/um/include/asm/current.h
index 8accc6d6f502..c563af70dcf2 100644
--- a/arch/um/include/asm/current.h
+++ b/arch/um/include/asm/current.h
@@ -7,15 +7,16 @@
 
 #ifndef __ASSEMBLER__
 
+#include <asm/smp.h>
+
 struct task_struct;
 extern struct task_struct *cpu_tasks[NR_CPUS];
 
 static __always_inline struct task_struct *get_current(void)
 {
-	return cpu_tasks[0];
+	return cpu_tasks[raw_smp_processor_id()];
 }
 
-
 #define current get_current()
 
 #endif /* __ASSEMBLER__ */
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index 52e2c36267a9..8de71752a9b8 100644
--- a/arch/um/include/asm/hardirq.h
+++ b/arch/um/include/asm/hardirq.h
@@ -2,8 +2,30 @@
 #ifndef __ASM_UM_HARDIRQ_H
 #define __ASM_UM_HARDIRQ_H
 
-#include <asm-generic/hardirq.h>
+#include <linux/cache.h>
+#include <linux/threads.h>
 
 #define __ARCH_IRQ_EXIT_IRQS_DISABLED 1
 
+typedef struct {
+	unsigned int __softirq_pending;
+#if IS_ENABLED(CONFIG_SMP)
+	unsigned int irq_resched_count;
+	unsigned int irq_call_count;
+#endif
+} ____cacheline_aligned irq_cpustat_t;
+
+DECLARE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+
+#define __ARCH_IRQ_STAT
+
+#define inc_irq_stat(member)	this_cpu_inc(irq_stat.member)
+
+#include <linux/irq.h>
+
+static inline void ack_bad_irq(unsigned int irq)
+{
+	pr_crit("unexpected IRQ trap at vector %02x\n", irq);
+}
+
 #endif /* __ASM_UM_HARDIRQ_H */
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 4d0e4239f3cc..07d48738b402 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -7,16 +7,26 @@
 #define __ARCH_UM_MMU_H
 
 #include "linux/types.h"
+#include <linux/mutex.h>
+#include <linux/spinlock.h>
 #include <mm_id.h>
 
 typedef struct mm_context {
 	struct mm_id id;
+	struct mutex turnstile;
 
 	struct list_head list;
 
 	/* Address range in need of a TLB sync */
+	spinlock_t sync_tlb_lock;
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
 } mm_context_t;
 
+#define INIT_MM_CONTEXT(mm)						\
+	.context = {							\
+		.turnstile = __MUTEX_INITIALIZER(mm.context.turnstile),	\
+		.sync_tlb_lock = __SPIN_LOCK_INITIALIZER(mm.context.sync_tlb_lock), \
+	}
+
 #endif
diff --git a/arch/um/include/asm/percpu.h b/arch/um/include/asm/percpu.h
new file mode 100644
index 000000000000..77e13a38f220
--- /dev/null
+++ b/arch/um/include/asm/percpu.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_UM_PERCPU_H
+#define __ASM_UM_PERCPU_H
+
+#include <linux/threads.h>
+
+#if IS_ENABLED(CONFIG_SMP)
+
+#define __per_cpu_offset __per_cpu_offset
+#ifndef __ASSEMBLER__
+extern unsigned long __per_cpu_offset[NR_CPUS];
+#endif
+
+#define per_cpu_offset(x) (__per_cpu_offset[x])
+
+#endif /* CONFIG_SMP */
+
+#include <asm-generic/percpu.h>
+
+#endif /* __ASM_UM_PERCPU_H */
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 24fdea6f88c3..91aec3698475 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -225,6 +225,8 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
 static inline void um_tlb_mark_sync(struct mm_struct *mm, unsigned long start,
 				    unsigned long end)
 {
+	guard(spinlock_irqsave)(&mm->context.sync_tlb_lock);
+
 	if (!mm->context.sync_tlb_range_to) {
 		mm->context.sync_tlb_range_from = start;
 		mm->context.sync_tlb_range_to = end;
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 236fdfd7cdbe..0c4dd680f8bb 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -81,6 +81,12 @@ struct cpuinfo_um {
 
 extern struct cpuinfo_um boot_cpu_data;
 
+#if IS_ENABLED(CONFIG_SMP)
+extern struct cpuinfo_um uml_cpu_data[];
+#else
+#define uml_cpu_data     (&boot_cpu_data)
+#endif
+
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
diff --git a/arch/um/include/asm/smp.h b/arch/um/include/asm/smp.h
index a8cc1d46ddcb..242ad4da5723 100644
--- a/arch/um/include/asm/smp.h
+++ b/arch/um/include/asm/smp.h
@@ -2,6 +2,27 @@
 #ifndef __UM_SMP_H
 #define __UM_SMP_H
 
-#define hard_smp_processor_id()		0
+#if IS_ENABLED(CONFIG_SMP)
+
+#include <linux/bitops.h>
+#include <asm/current.h>
+#include <linux/cpumask.h>
+#include <shared/smp.h>
+
+#define raw_smp_processor_id() uml_curr_cpu()
+
+void arch_smp_send_reschedule(int cpu);
+
+void arch_send_call_function_single_ipi(int cpu);
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+
+static inline void smp_cpus_done(unsigned int maxcpus) { }
+
+#else /* !CONFIG_SMP */
+
+#define raw_smp_processor_id() 0
+
+#endif /* CONFIG_SMP */
 
 #endif
diff --git a/arch/um/include/asm/spinlock.h b/arch/um/include/asm/spinlock.h
new file mode 100644
index 000000000000..f2258443c316
--- /dev/null
+++ b/arch/um/include/asm/spinlock.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_UM_SPINLOCK_H
+#define __ASM_UM_SPINLOCK_H
+
+#include <asm/processor.h>
+#include <asm-generic/spinlock.h>
+
+#endif /* __ASM_UM_SPINLOCK_H */
diff --git a/arch/um/include/linux/smp-internal.h b/arch/um/include/linux/smp-internal.h
new file mode 100644
index 000000000000..e7ad2b879cbb
--- /dev/null
+++ b/arch/um/include/linux/smp-internal.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_SMP_INTERNAL_H
+#define __UM_SMP_INTERNAL_H
+
+#if IS_ENABLED(CONFIG_SMP)
+
+int smp_sigio_handler(struct uml_pt_regs *regs);
+void prefill_possible_map(void);
+
+#else /* !CONFIG_SMP */
+
+static inline int smp_sigio_handler(struct uml_pt_regs *regs)
+{
+	return 0;
+}
+
+static inline void prefill_possible_map(void) { }
+
+#endif /* CONFIG_SMP */
+
+#endif /* __UM_SMP_INTERNAL_H */
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 3daaa5c4b35d..52db56400a06 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -14,6 +14,7 @@ struct siginfo;
 extern int uml_exitcode;
 
 extern int kmalloc_ok;
+extern int disable_kmalloc[];
 
 #define UML_ROUND_UP(addr) \
 	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index ca377421181d..e26655a7763e 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -216,6 +216,8 @@ extern int can_drop_memory(void);
 
 void os_set_pdeathsig(void);
 
+int os_futex_wake(void *uaddr, unsigned int val);
+
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 /* helper.c */
@@ -339,4 +341,8 @@ extern void um_trace_signals_off(void);
 /* time-travel */
 extern void deliver_time_travel_irqs(void);
 
+/* smp.c */
+int start_cpu_thread(int cpu);
+void start_idle_thread_secondary(void *arg, jmp_buf *switch_buf);
+
 #endif
diff --git a/arch/um/include/shared/skas/mm_id.h b/arch/um/include/shared/skas/mm_id.h
index 4f977ef5dda5..bb9f8bd32ccb 100644
--- a/arch/um/include/shared/skas/mm_id.h
+++ b/arch/um/include/shared/skas/mm_id.h
@@ -19,6 +19,9 @@ struct mm_id {
 	int syscall_fd_map[STUB_MAX_FDS];
 };
 
+void enter_turnstile(struct mm_id *mm_id);
+void exit_turnstile(struct mm_id *mm_id);
+
 void notify_mm_kill(int pid);
 
 #endif
diff --git a/arch/um/include/shared/smp.h b/arch/um/include/shared/smp.h
new file mode 100644
index 000000000000..c1049835bd1d
--- /dev/null
+++ b/arch/um/include/shared/smp.h
@@ -0,0 +1,19 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_SHARED_SMP_H
+#define __UM_SHARED_SMP_H
+
+#if IS_ENABLED(CONFIG_SMP)
+
+extern int uml_ncpus;
+
+int uml_curr_cpu(void);
+void uml_start_idle(void *opaque);
+
+#else /* !CONFIG_SMP */
+
+#define uml_ncpus 1
+#define uml_curr_cpu() 0
+
+#endif /* CONFIG_SMP */
+
+#endif /* __UM_SHARED_SMP_H */
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index b8f4e9281599..be60bc451b3f 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_GPROF)	+= gprof_syms.o
 obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
+obj-$(CONFIG_SMP) += smp.o
 
 USER_OBJS := config.o
 
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 193b6374d890..c57cfbef6f2b 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -20,8 +20,12 @@
 #include <os.h>
 #include <irq_user.h>
 #include <irq_kern.h>
+#include <linux/smp-internal.h>
 #include <linux/time-internal.h>
 
+DEFINE_PER_CPU_SHARED_ALIGNED(irq_cpustat_t, irq_stat);
+
+#define irq_stats(x)		(&per_cpu(irq_stat, x))
 
 /* When epoll triggers we do not know why it did so
  * we can also have different IRQs for read and write.
@@ -205,6 +209,9 @@ static void _sigio_handler(struct uml_pt_regs *regs,
 	if (!irqs_suspended)
 		irq_do_pending_events(timetravel_handlers_only);
 
+	if (smp_sigio_handler(regs))
+		return;
+
 	while (1) {
 		/* This is now lockless - epoll keeps back-referencesto the irqs
 		 * which have trigger it so there is no need to walk the irq
@@ -696,3 +703,25 @@ void sigchld_handler(int sig, struct siginfo *unused_si,
 {
 	do_IRQ(SIGCHLD_IRQ, regs);
 }
+
+/*
+ * /proc/interrupts printing for arch specific interrupts
+ */
+int arch_show_interrupts(struct seq_file *p, int prec)
+{
+#if IS_ENABLED(CONFIG_SMP)
+	int cpu;
+
+	seq_printf(p, "%*s: ", prec, "RES");
+	for_each_online_cpu(cpu)
+		seq_printf(p, "%10u ", irq_stats(cpu)->irq_resched_count);
+	seq_puts(p, "  Rescheduling interrupts\n");
+
+	seq_printf(p, "%*s: ", prec, "CAL");
+	for_each_online_cpu(cpu)
+		seq_printf(p, "%10u ", irq_stats(cpu)->irq_call_count);
+	seq_puts(p, "  Function call interrupts\n");
+#endif
+
+	return 0;
+}
diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
index 76bec7de81b5..8e7742140e93 100644
--- a/arch/um/kernel/mem.c
+++ b/arch/um/kernel/mem.c
@@ -53,6 +53,8 @@ pgd_t swapper_pg_dir[PTRS_PER_PGD];
 /* Initialized at boot time, and readonly after that */
 int kmalloc_ok = 0;
 
+int disable_kmalloc[NR_CPUS] = { 0 };
+
 /* Used during early boot */
 static unsigned long brk_end;
 
diff --git a/arch/um/kernel/process.c b/arch/um/kernel/process.c
index 01b935c00454..ec390f334853 100644
--- a/arch/um/kernel/process.c
+++ b/arch/um/kernel/process.c
@@ -35,6 +35,7 @@
 #include <os.h>
 #include <skas.h>
 #include <registers.h>
+#include <linux/smp-internal.h>
 #include <linux/time-internal.h>
 #include <linux/elfcore.h>
 
@@ -185,11 +186,12 @@ int copy_thread(struct task_struct * p, const struct kernel_clone_args *args)
 
 void initial_thread_cb(void (*proc)(void *), void *arg)
 {
-	int save_kmalloc_ok = kmalloc_ok;
+	int cpu = raw_smp_processor_id();
+	int save_kmalloc = disable_kmalloc[cpu];
 
-	kmalloc_ok = 0;
+	disable_kmalloc[cpu] = 1;
 	initial_thread_cb_skas(proc, arg);
-	kmalloc_ok = save_kmalloc_ok;
+	disable_kmalloc[cpu] = save_kmalloc;
 }
 
 int arch_dup_task_struct(struct task_struct *dst,
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index afe9a2f251ef..d3a71008f43e 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -23,12 +23,30 @@ static_assert(sizeof(struct stub_data) == STUB_DATA_PAGES * UM_KERN_PAGE_SIZE);
 static spinlock_t mm_list_lock;
 static struct list_head mm_list;
 
+void enter_turnstile(struct mm_id *mm_id)
+{
+	struct mm_context *ctx = container_of(mm_id, struct mm_context, id);
+
+	mutex_lock(&ctx->turnstile);
+}
+
+void exit_turnstile(struct mm_id *mm_id)
+{
+	struct mm_context *ctx = container_of(mm_id, struct mm_context, id);
+
+	mutex_unlock(&ctx->turnstile);
+}
+
 int init_new_context(struct task_struct *task, struct mm_struct *mm)
 {
 	struct mm_id *new_id = &mm->context.id;
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
 
+	mutex_init(&mm->context.turnstile);
+
+	spin_lock_init(&mm->context.sync_tlb_lock);
+
 	stack = __get_free_pages(GFP_KERNEL | __GFP_ZERO, ilog2(STUB_DATA_PAGES));
 	if (stack == 0)
 		goto out;
@@ -73,6 +91,9 @@ void destroy_context(struct mm_struct *mm)
 		return;
 	}
 
+	scoped_guard(spinlock_irqsave, &mm_list_lock)
+		list_del(&mm->context.list);
+
 	if (mmu->id.pid > 0) {
 		os_kill_ptraced_process(mmu->id.pid, 1);
 		mmu->id.pid = -1;
@@ -82,10 +103,6 @@ void destroy_context(struct mm_struct *mm)
 		os_close_file(mmu->id.sock);
 
 	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
-
-	guard(spinlock_irqsave)(&mm_list_lock);
-
-	list_del(&mm->context.list);
 }
 
 static irqreturn_t mm_sigchld_irq(int irq, void* dev)
@@ -110,12 +127,11 @@ static irqreturn_t mm_sigchld_irq(int irq, void* dev)
 				/* Marks the MM as dead */
 				mm_context->id.pid = -1;
 
-				/*
-				 * NOTE: If SMP is implemented, a futex_wake
-				 * needs to be added here.
-				 */
 				stub_data = (void *)mm_context->id.stack;
 				stub_data->futex = FUTEX_IN_KERN;
+#if IS_ENABLED(CONFIG_SMP)
+				os_futex_wake(&stub_data->futex, 1);
+#endif
 
 				/*
 				 * NOTE: Currently executing syscalls by
diff --git a/arch/um/kernel/smp.c b/arch/um/kernel/smp.c
new file mode 100644
index 000000000000..53bd57dda13a
--- /dev/null
+++ b/arch/um/kernel/smp.c
@@ -0,0 +1,266 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright (C) 2025 Ant Group
+ *     Author: Tiwei Bie <tiwei.btw@antgroup.com>
+ */
+
+#include <linux/sched.h>
+#include <linux/sched/task.h>
+#include <linux/sched/task_stack.h>
+#include <linux/module.h>
+#include <linux/threads.h>
+#include <linux/interrupt.h>
+#include <linux/err.h>
+#include <linux/hardirq.h>
+#include <linux/cpu.h>
+#include <linux/smp-internal.h>
+#include <asm/smp.h>
+#include <asm/processor.h>
+#include <init.h>
+#include <kern.h>
+#include <os.h>
+#include <smp.h>
+
+/*
+ * Per CPU bogomips and other parameters
+ * The only piece used here is the ipi pipe, which is set before SMP is
+ * started and never changed.
+ */
+struct cpuinfo_um uml_cpu_data[NR_CPUS];
+
+void arch_smp_send_reschedule(int cpu)
+{
+	os_write_file(uml_cpu_data[cpu].ipi_pipe[1], "R", 1);
+}
+
+void arch_send_call_function_single_ipi(int cpu)
+{
+	os_write_file(uml_cpu_data[cpu].ipi_pipe[1], "I", 1);
+}
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask)
+{
+	int cpu;
+
+	for_each_cpu(cpu, mask)
+		os_write_file(uml_cpu_data[cpu].ipi_pipe[1], "M", 1);
+}
+
+void smp_send_stop(void)
+{
+	int cpu;
+
+	pr_info("Stopping all CPUs...");
+	for (cpu = 0; cpu < num_online_cpus(); cpu++) {
+		if (cpu == current_thread_info()->cpu)
+			continue;
+		os_write_file(uml_cpu_data[cpu].ipi_pipe[1], "S", 1);
+	}
+	pr_cont(" done\n");
+}
+
+static cpumask_t smp_commenced_mask = CPU_MASK_NONE;
+static cpumask_t cpu_callin_map = CPU_MASK_NONE;
+
+static int idle_proc(void *unused)
+{
+	int err, cpu = raw_smp_processor_id();
+
+	err = os_pipe(uml_cpu_data[cpu].ipi_pipe, 1, 1);
+	if (err)
+		panic("CPU#%d failed to create IPI pipe, err = %d", cpu, err);
+
+	os_set_fd_async(uml_cpu_data[cpu].ipi_pipe[0], 1);
+
+	wmb();
+	if (cpumask_test_and_set_cpu(cpu, &cpu_callin_map)) {
+		pr_err("huh, CPU#%d already present??\n", cpu);
+		BUG();
+	}
+
+	while (!cpumask_test_cpu(cpu, &smp_commenced_mask))
+		cpu_relax();
+
+	notify_cpu_starting(cpu);
+	set_cpu_online(cpu, true);
+
+	err = um_setup_timer();
+	if (err)
+		panic("CPU#%d failed to setup timer, err = %d", cpu, err);
+
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+	return 0;
+}
+
+static struct task_struct *idle_threads[NR_CPUS];
+static char irqstacks[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
+
+void uml_start_idle(void *opaque)
+{
+	int cpu = raw_smp_processor_id();
+	struct mm_struct *mm = &init_mm;
+	struct task_struct *p = idle_threads[cpu];
+
+	p->thread_info.cpu = cpu;
+
+	stack_protections((unsigned long) &irqstacks[cpu]);
+	set_sigstack(&irqstacks[cpu], THREAD_SIZE);
+
+	mmgrab(mm);
+	p->active_mm = mm;
+
+	p->thread.request.thread.proc = idle_proc;
+	p->thread.request.thread.arg = NULL;
+
+	new_thread(task_stack_page(p), &p->thread.switch_buf, new_thread_handler);
+	start_idle_thread_secondary(opaque, &p->thread.switch_buf);
+}
+
+static struct task_struct *new_idle_thread(int cpu)
+{
+	struct task_struct *new_task;
+
+	new_task = fork_idle(cpu);
+	if (IS_ERR(new_task))
+		panic("%s: fork_idle failed, err = %ld", __func__,
+		      PTR_ERR(new_task));
+
+	cpu_tasks[cpu] = new_task;
+	return new_task;
+}
+
+void __init smp_prepare_cpus(unsigned int maxcpus)
+{
+	unsigned long waittime;
+	int err, cpu, me = smp_processor_id();
+
+	set_cpu_online(me, true);
+	cpumask_set_cpu(me, &cpu_callin_map);
+
+	err = os_pipe(uml_cpu_data[me].ipi_pipe, 1, 1);
+	if (err)
+		panic("CPU#0 failed to create IPI pipe, err = %d", err);
+
+	os_set_fd_async(uml_cpu_data[me].ipi_pipe[0], 1);
+
+	for (cpu = 1; cpu < uml_ncpus; cpu++) {
+		pr_info("Booting processor %d...", cpu);
+
+		idle_threads[cpu] = new_idle_thread(cpu);
+		err = start_cpu_thread(cpu);
+		if (err)
+			panic("CPU#%d failed to start cpu thread, err = %d", cpu, err);
+
+		waittime = 200000000;
+		while (waittime-- && !cpumask_test_cpu(cpu, &cpu_callin_map))
+			cpu_relax();
+
+		pr_cont(" %s\n", cpumask_test_cpu(cpu, &cpu_callin_map) ? "done" : "failed");
+		set_cpu_present(cpu, true);
+	}
+}
+
+void smp_prepare_boot_cpu(void)
+{
+	set_cpu_online(smp_processor_id(), true);
+}
+
+int __cpu_up(unsigned int cpu, struct task_struct *tidle)
+{
+	cpumask_set_cpu(cpu, &smp_commenced_mask);
+	while (!cpu_online(cpu))
+		mb();
+	return 0;
+}
+
+static void IPI_handler(int cpu, struct uml_pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs((struct pt_regs *)regs);
+	unsigned char c;
+	int fd;
+
+	irq_enter();
+
+	if (current->mm)
+		os_alarm_process(current->mm->context.id.pid);
+
+	fd = uml_cpu_data[cpu].ipi_pipe[0];
+	while (os_read_file(fd, &c, 1) == 1) {
+		switch (c) {
+		case 'R':
+			inc_irq_stat(irq_resched_count);
+			scheduler_ipi();
+			break;
+
+		case 'S':
+			pr_info("CPU#%d stopping\n", cpu);
+			while (1)
+				pause();
+			break;
+
+		case 'I':
+			inc_irq_stat(irq_call_count);
+			generic_smp_call_function_single_interrupt();
+			break;
+
+		case 'M':
+			inc_irq_stat(irq_call_count);
+			generic_smp_call_function_interrupt();
+			break;
+
+		default:
+			pr_err("CPU#%d received unknown IPI [%c]!\n", cpu, c);
+			break;
+		}
+	}
+
+	irq_exit();
+	set_irq_regs(old_regs);
+}
+
+int smp_sigio_handler(struct uml_pt_regs *regs)
+{
+	int cpu = raw_smp_processor_id();
+
+	IPI_handler(cpu, regs);
+	if (cpu != 0)
+		return 1;
+	return 0;
+}
+
+EXPORT_SYMBOL(uml_curr_cpu);
+
+/* Set in uml_ncpus_setup */
+int uml_ncpus = 1;
+
+void __init prefill_possible_map(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < uml_ncpus; cpu++)
+		set_cpu_possible(cpu, true);
+	for (; cpu < NR_CPUS; cpu++)
+		set_cpu_possible(cpu, false);
+}
+
+static int __init uml_ncpus_setup(char *line, int *add)
+{
+	*add = 0;
+
+	if (kstrtoint(line, 10, &uml_ncpus)) {
+		os_warn("%s: Couldn't parse '%s'\n", __func__, line);
+		return -1;
+	}
+
+	uml_ncpus = clamp(uml_ncpus, 1, NR_CPUS);
+
+	return 0;
+}
+
+__uml_setup("ncpus=", uml_ncpus_setup,
+"ncpus=<# of desired CPUs>\n"
+"    This tells UML how many virtual processors to start. The maximum\n"
+"    number of supported virtual processors can be obtained by querying\n"
+"    the CONFIG_NR_CPUS option using --showconfig.\n\n"
+);
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index cf7e0d4407f2..39608cccf2c6 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -162,9 +162,11 @@ int um_tlb_sync(struct mm_struct *mm)
 {
 	pgd_t *pgd;
 	struct vm_ops ops;
-	unsigned long addr = mm->context.sync_tlb_range_from, next;
+	unsigned long addr, next;
 	int ret = 0;
 
+	guard(spinlock_irqsave)(&mm->context.sync_tlb_lock);
+
 	if (mm->context.sync_tlb_range_to == 0)
 		return 0;
 
@@ -177,6 +179,7 @@ int um_tlb_sync(struct mm_struct *mm)
 		ops.unmap = unmap;
 	}
 
+	addr = mm->context.sync_tlb_range_from;
 	pgd = pgd_offset(mm, addr);
 	do {
 		next = pgd_addr_end(addr, mm->context.sync_tlb_range_to);
diff --git a/arch/um/kernel/trap.c b/arch/um/kernel/trap.c
index 5b80a3a89c20..177615820a4c 100644
--- a/arch/um/kernel/trap.c
+++ b/arch/um/kernel/trap.c
@@ -316,7 +316,7 @@ unsigned long segv(struct faultinfo fi, unsigned long ip, int is_user,
 	if (!is_user && regs)
 		current->thread.segv_regs = container_of(regs, struct pt_regs, regs);
 
-	if (!is_user && init_mm.context.sync_tlb_range_to) {
+	if (!is_user && address >= start_vm && address < end_vm) {
 		/*
 		 * Kernel has pending updates from set_ptes that were not
 		 * flushed yet. Syncing them should fix the pagefault (if not
diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
index 2f5ee045bc7a..a84fba9992f2 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -19,6 +19,7 @@
 #include <linux/kmsg_dump.h>
 #include <linux/suspend.h>
 #include <linux/random.h>
+#include <linux/smp-internal.h>
 
 #include <asm/processor.h>
 #include <asm/cpufeature.h>
@@ -32,6 +33,7 @@
 #include <kern_util.h>
 #include <mem_user.h>
 #include <os.h>
+#include <smp.h>
 
 #include "um_arch.h"
 
@@ -74,6 +76,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 {
 	int i = 0;
 
+#if IS_ENABLED(CONFIG_SMP)
+	i = (struct cpuinfo_um *) v - uml_cpu_data;
+	if (!cpu_online(i))
+		return 0;
+#endif
+
 	seq_printf(m, "processor\t: %d\n", i);
 	seq_printf(m, "vendor_id\t: User Mode Linux\n");
 	seq_printf(m, "model name\t: UML\n");
@@ -90,13 +98,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
 		   loops_per_jiffy/(500000/HZ),
 		   (loops_per_jiffy/(5000/HZ)) % 100);
 
-
 	return 0;
 }
 
 static void *c_start(struct seq_file *m, loff_t *pos)
 {
-	return *pos < nr_cpu_ids ? &boot_cpu_data + *pos : NULL;
+	return *pos < nr_cpu_ids ? uml_cpu_data + *pos : NULL;
 }
 
 static void *c_next(struct seq_file *m, void *v, loff_t *pos)
@@ -426,6 +433,7 @@ void __init setup_arch(char **cmdline_p)
 	strscpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	setup_hostinfo(host_info, sizeof host_info);
+	prefill_possible_map();
 
 	if (os_getrandom(rng_seed, sizeof(rng_seed), 0) == sizeof(rng_seed)) {
 		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
@@ -460,6 +468,18 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
 {
 }
 
+#if IS_ENABLED(CONFIG_SMP)
+void alternatives_smp_module_add(struct module *mod, char *name,
+				 void *locks, void *locks_end,
+				 void *text,  void *text_end)
+{
+}
+
+void alternatives_smp_module_del(struct module *mod)
+{
+}
+#endif
+
 void *text_poke(void *addr, const void *opcode, size_t len)
 {
 	/*
diff --git a/arch/um/os-Linux/Makefile b/arch/um/os-Linux/Makefile
index fae836713487..70c73c22f715 100644
--- a/arch/um/os-Linux/Makefile
+++ b/arch/um/os-Linux/Makefile
@@ -16,8 +16,10 @@ CFLAGS_main.o += -Wno-frame-larger-than
 
 obj-$(CONFIG_ARCH_REUSE_HOST_VSYSCALL_AREA) += elf_aux.o
 
+obj-$(CONFIG_SMP) += smp.o
+
 USER_OBJS := $(user-objs-y) elf_aux.o execvp.o file.o helper.o irq.o \
 	main.o mem.o process.o registers.o sigio.o signal.o start_up.o time.o \
-	tty.o umid.o util.o
+	tty.o umid.o util.o smp.o
 
 include $(srctree)/arch/um/scripts/Makefile.rules
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 730723106228..92028c14d2a3 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -16,6 +16,7 @@
 #include <init.h>
 #include <kern_util.h>
 #include <os.h>
+#include <smp.h>
 #include <um_malloc.h>
 #include "internal.h"
 
@@ -207,7 +208,7 @@ void *__wrap_malloc(int size)
 {
 	void *ret;
 
-	if (!kmalloc_ok)
+	if (!kmalloc_ok || disable_kmalloc[uml_curr_cpu()])
 		return __real_malloc(size);
 	else if (size <= UM_KERN_PAGE_SIZE)
 		/* finding contiguous pages can be hard*/
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 00b49e90d05f..87aec6b5beeb 100644
--- a/arch/um/os-Linux/process.c
+++ b/arch/um/os-Linux/process.c
@@ -10,6 +10,7 @@
 #include <errno.h>
 #include <signal.h>
 #include <fcntl.h>
+#include <linux/futex.h>
 #include <sys/mman.h>
 #include <sys/ptrace.h>
 #include <sys/prctl.h>
@@ -189,3 +190,12 @@ void os_set_pdeathsig(void)
 {
 	prctl(PR_SET_PDEATHSIG, SIGKILL);
 }
+
+int os_futex_wake(void *uaddr, unsigned int val)
+{
+	int r;
+
+	CATCH_EINTR(r = syscall(__NR_futex, uaddr, FUTEX_WAKE, val,
+				NULL, NULL, 0));
+	return r < 0 ? -errno : r;
+}
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 78f48fa9db8b..d3440a6c6616 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -563,6 +563,13 @@ void userspace(struct uml_pt_regs *regs)
 	while (1) {
 		struct mm_id *mm_id = current_mm_id();
 
+		/*
+		 * At any given time, only one CPU thread can enter the
+		 * turnstile to operate on the same stub process, including
+		 * executing stub system calls (mmap and munmap).
+		 */
+		enter_turnstile(mm_id);
+
 		/*
 		 * When we are in time-travel mode, userspace can theoretically
 		 * do a *lot* of work without being scheduled. The problem with
@@ -740,6 +747,8 @@ void userspace(struct uml_pt_regs *regs)
 			}
 		}
 
+		exit_turnstile(mm_id);
+
 		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
 
 		if (sig) {
diff --git a/arch/um/os-Linux/smp.c b/arch/um/os-Linux/smp.c
new file mode 100644
index 000000000000..0877ccc54717
--- /dev/null
+++ b/arch/um/os-Linux/smp.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Ant Group
+ * Author: Tiwei Bie <tiwei.btw@antgroup.com>
+ */
+
+#include <stdint.h>
+#include <errno.h>
+#include <pthread.h>
+#include <signal.h>
+#include <kern_util.h>
+#include <um_malloc.h>
+#include <os.h>
+#include <smp.h>
+
+struct cpu_thread_data {
+	int cpu;
+	sigset_t sigset;
+};
+
+static __thread int __curr_cpu;
+
+int uml_curr_cpu(void)
+{
+	return __curr_cpu;
+}
+
+static pthread_t cpu_threads[CONFIG_NR_CPUS];
+
+static void *cpu_thread(void *arg)
+{
+	struct cpu_thread_data *data = arg;
+
+	__curr_cpu = data->cpu;
+
+	uml_start_idle(data);
+
+	return NULL;
+}
+
+int start_cpu_thread(int cpu)
+{
+	struct cpu_thread_data *data;
+	sigset_t sigset, oset;
+	int err;
+
+	data = uml_kmalloc(sizeof(*data), UM_GFP_ATOMIC);
+	if (!data)
+		return -ENOMEM;
+
+	sigfillset(&sigset);
+	if (sigprocmask(SIG_SETMASK, &sigset, &oset) < 0) {
+		err = errno;
+		goto err;
+	}
+
+	data->cpu = cpu;
+	data->sigset = oset;
+
+	err = pthread_create(&cpu_threads[cpu], NULL, cpu_thread, data);
+	if (sigprocmask(SIG_SETMASK, &oset, NULL) < 0)
+		panic("Failed to restore the signal mask: %d", errno);
+	if (err != 0)
+		goto err;
+
+	return 0;
+
+err:
+	kfree(data);
+	return -err;
+}
+
+void start_idle_thread_secondary(void *arg, jmp_buf *switch_buf)
+{
+	struct cpu_thread_data *data = arg;
+
+	if (sigprocmask(SIG_SETMASK, &data->sigset, NULL) < 0)
+		panic("Failed to restore the signal mask: %d", errno);
+
+	kfree(data);
+	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+}
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index a827c2e01aa5..61c61e9c246c 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -22,6 +22,7 @@
 #include <asm/unistd.h>
 #include <init.h>
 #include <os.h>
+#include <smp.h>
 #include <kern_util.h>
 #include <mem_user.h>
 #include <ptrace_user.h>
@@ -481,6 +482,9 @@ void __init os_early_checks(void)
 			fatal("SECCOMP userspace requested but not functional!\n");
 	}
 
+	if (uml_ncpus > 1)
+		fatal("SMP is not supported with PTRACE userspace.\n");
+
 	using_seccomp = 0;
 	check_ptrace();
 
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index e38b6f84287b..ecf2fde01889 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -14,6 +14,7 @@
 #include <sys/time.h>
 #include <kern_util.h>
 #include <os.h>
+#include <smp.h>
 #include <string.h>
 
 static timer_t event_high_res_timer[CONFIG_NR_CPUS] = { 0 };
@@ -40,7 +41,8 @@ long long os_persistent_clock_emulation(void)
  */
 int os_timer_create(void)
 {
-	timer_t *t = &event_high_res_timer[0];
+	int cpu = uml_curr_cpu();
+	timer_t *t = &event_high_res_timer[cpu];
 	struct sigevent sev = {
 		.sigev_notify = SIGEV_THREAD_ID,
 		.sigev_signo = SIGALRM,
@@ -110,9 +112,10 @@ void os_idle_sleep(void)
 {
 	sigset_t set, old;
 
-	/* Block SIGALRM while performing the need_resched check. */
+	/* Block SIGALRM and SIGIO while performing the need_resched check. */
 	sigemptyset(&set);
 	sigaddset(&set, SIGALRM);
+	sigaddset(&set, SIGIO);
 	sigprocmask(SIG_BLOCK, &set, &old);
 
 	/* Sleep if no resched is pending. */
-- 
2.34.1


