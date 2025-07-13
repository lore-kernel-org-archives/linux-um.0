Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC658C83F17
	for <linux-um@archiver.kernel.org>; Sun, 13 Jul 2025 17:26:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hHef48a3kkK+QhUh/sSIbTdBrQTG8GD0guAB1ww0Q+Y=; b=zzMHaMDU19qkJFmNI59oSSf+A7
	U3kT08wiMoOZmefrugBhP13MD8926xnPqhk3jlA4s8R7EzOyRQv4kwYzpTn/0d2ZBBPsSrIGGf5jw
	OI7I5QkVnIuH2Il0ERalIKhIMCCjO3KdZpyc5LPS8gUNTaExMRqQIx03h3m02tDK4LlOQ2gUiZl7a
	Mo3/u91a36tgv6GXhTkiz+bLXgxRT+9rtP1U9C6xeLzaW6keEtWmYlQHgsvMUOBNfdwleGz7FJrN+
	QNi38uMSPxVbdjd+Vne0NmBPNU68t+7HksGwdKL7gbXDBt8tJ/cP+z++lNi2mWwGiwhvtJoL9/NEf
	d96FSwng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Sp-00000000RM3-1Fnv;
	Sun, 13 Jul 2025 17:26:11 +0000
Received: from out-178.mta1.migadu.com ([95.215.58.178])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ub0Sl-00000000RL4-0VI8
	for linux-um@lists.infradead.org;
	Sun, 13 Jul 2025 17:26:10 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752427565;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHef48a3kkK+QhUh/sSIbTdBrQTG8GD0guAB1ww0Q+Y=;
	b=c4gLGsam5gBTSqALmPZhUK6kvMDEFwlZeFLZUCttzjI8iiaaXLRovrBiW6JdwJjwYS3z2X
	z6Btd6jSJ8j/mKfnWHbwFP3uwdhd59fMkiF68hN0MdN1Toz7yRGJpzIEf/CJgq8OVefmbt
	JqiBp0WsRPwrlPl7EHxGvjsqGpFOqqk=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [RFC PATCH 4/4] um: Add SMP support
Date: Mon, 14 Jul 2025 01:25:36 +0800
Message-Id: <20250713172536.404809-5-tiwei.bie@linux.dev>
In-Reply-To: <20250713172536.404809-1-tiwei.bie@linux.dev>
References: <20250713172536.404809-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250713_102607_765444_C411F97A 
X-CRM114-Status: GOOD (  24.03  )
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

This is currently a PoC patch and requires further improvements.

Sorry for the patch size. It will be split into smaller patches
in the future.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/Kconfig                         |  28 ++-
 arch/um/include/asm/Kbuild              |   3 +
 arch/um/include/asm/current.h           |   5 +-
 arch/um/include/asm/hardirq.h           |  24 ++-
 arch/um/include/asm/irqflags.h          |   4 +-
 arch/um/include/asm/mmu.h               |   7 +
 arch/um/include/asm/pgtable.h           |   2 +
 arch/um/include/asm/processor-generic.h |   6 +
 arch/um/include/asm/smp.h               |  31 +++-
 arch/um/include/asm/spinlock.h          |   8 +
 arch/um/include/linux/smp-internal.h    |   8 +
 arch/um/include/linux/time-internal.h   |   3 +
 arch/um/include/shared/kern_util.h      |   2 +
 arch/um/include/shared/longjmp.h        |   3 +-
 arch/um/include/shared/os.h             |  12 +-
 arch/um/include/shared/smp.h            |  14 ++
 arch/um/kernel/Makefile                 |   1 +
 arch/um/kernel/irq.c                    |  31 +++-
 arch/um/kernel/ksyms.c                  |   2 +-
 arch/um/kernel/mem.c                    |   2 +
 arch/um/kernel/process.c                |  19 +-
 arch/um/kernel/skas/mmu.c               |  16 +-
 arch/um/kernel/smp.c                    | 223 ++++++++++++++++++++++++
 arch/um/kernel/time.c                   |  48 +++--
 arch/um/kernel/tlb.c                    |   5 +-
 arch/um/kernel/trap.c                   |   2 +-
 arch/um/kernel/um_arch.c                |  60 ++++++-
 arch/um/os-Linux/Makefile               |   4 +-
 arch/um/os-Linux/file.c                 |  72 ++++++--
 arch/um/os-Linux/main.c                 |   5 +-
 arch/um/os-Linux/process.c              |  15 ++
 arch/um/os-Linux/signal.c               |  16 +-
 arch/um/os-Linux/skas/process.c         |   1 +
 arch/um/os-Linux/smp.c                  |  44 +++++
 arch/um/os-Linux/start_up.c             |   3 +
 arch/um/os-Linux/time.c                 |  29 +--
 arch/um/os-Linux/user_syms.c            |   5 +
 37 files changed, 687 insertions(+), 76 deletions(-)
 create mode 100644 arch/um/include/asm/spinlock.h
 create mode 100644 arch/um/include/linux/smp-internal.h
 create mode 100644 arch/um/include/shared/smp.h
 create mode 100644 arch/um/kernel/smp.c
 create mode 100644 arch/um/os-Linux/smp.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 9083bfdb7735..a3130156c9af 100644
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
@@ -79,10 +80,30 @@ config HZ
 	int
 	default 100
 
-config NR_CPUS
+config SMP
+	bool "Symmetric multi-processing support"
+	default n
+	help
+	  This option enables UML SMP support.
+
+config NR_CPUS_RANGE_BEGIN
+	int
+	default 1 if !SMP
+	default 2
+
+config NR_CPUS_RANGE_END
 	int
-	range 1 1
-	default 1
+	default 256
+
+config NR_CPUS_DEFAULT
+	int
+	default 2 if  SMP
+	default 1 if !SMP
+
+config NR_CPUS
+	int "Maximum number of CPUs" if SMP
+	range NR_CPUS_RANGE_BEGIN NR_CPUS_RANGE_END
+	default NR_CPUS_DEFAULT
 
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
@@ -258,6 +279,7 @@ source "arch/um/drivers/Kconfig"
 
 config ARCH_SUSPEND_POSSIBLE
 	def_bool y
+	depends on !SMP
 
 menu "Power management options"
 
diff --git a/arch/um/include/asm/Kbuild b/arch/um/include/asm/Kbuild
index 04ab3b653a48..d8c436d6eb8c 100644
--- a/arch/um/include/asm/Kbuild
+++ b/arch/um/include/asm/Kbuild
@@ -19,8 +19,11 @@ generic-y += param.h
 generic-y += parport.h
 generic-y += percpu.h
 generic-y += preempt.h
+generic-y += qrwlock.h
+generic-y += qrwlock_types.h
 generic-y += runtime-const.h
 generic-y += softirq_stack.h
+generic-y += spinlock_types.h
 generic-y += switch_to.h
 generic-y += topology.h
 generic-y += trace_clock.h
diff --git a/arch/um/include/asm/current.h b/arch/um/include/asm/current.h
index de64e032d66c..7469ba5f2a42 100644
--- a/arch/um/include/asm/current.h
+++ b/arch/um/include/asm/current.h
@@ -7,15 +7,16 @@
 
 #ifndef __ASSEMBLY__
 
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
 
 #endif /* __ASSEMBLY__ */
diff --git a/arch/um/include/asm/hardirq.h b/arch/um/include/asm/hardirq.h
index 52e2c36267a9..cd6e4fc98436 100644
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
+	printk(KERN_CRIT "unexpected IRQ trap at vector %02x\n", irq);
+}
+
 #endif /* __ASM_UM_HARDIRQ_H */
diff --git a/arch/um/include/asm/irqflags.h b/arch/um/include/asm/irqflags.h
index 1e69ef5bc35e..31e49e0894c5 100644
--- a/arch/um/include/asm/irqflags.h
+++ b/arch/um/include/asm/irqflags.h
@@ -2,7 +2,7 @@
 #ifndef __UM_IRQFLAGS_H
 #define __UM_IRQFLAGS_H
 
-extern int signals_enabled;
+int um_get_signals(void);
 int um_set_signals(int enable);
 void block_signals(void);
 void unblock_signals(void);
@@ -10,7 +10,7 @@ void unblock_signals(void);
 #define arch_local_save_flags arch_local_save_flags
 static inline unsigned long arch_local_save_flags(void)
 {
-	return signals_enabled;
+	return um_get_signals();
 }
 
 #define arch_local_irq_restore arch_local_irq_restore
diff --git a/arch/um/include/asm/mmu.h b/arch/um/include/asm/mmu.h
index 4d0e4239f3cc..2f9fb9c788d2 100644
--- a/arch/um/include/asm/mmu.h
+++ b/arch/um/include/asm/mmu.h
@@ -7,6 +7,7 @@
 #define __ARCH_UM_MMU_H
 
 #include "linux/types.h"
+#include <linux/spinlock.h>
 #include <mm_id.h>
 
 typedef struct mm_context {
@@ -17,6 +18,12 @@ typedef struct mm_context {
 	/* Address range in need of a TLB sync */
 	unsigned long sync_tlb_range_from;
 	unsigned long sync_tlb_range_to;
+	spinlock_t sync_tlb_lock;
 } mm_context_t;
 
+#define INIT_MM_CONTEXT(mm)						\
+	.context = {							\
+		.sync_tlb_lock = __SPIN_LOCK_INITIALIZER(mm.context.sync_tlb_lock),	\
+	}
+
 #endif
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
index 236fdfd7cdbe..792761b9a02b 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -81,6 +81,12 @@ struct cpuinfo_um {
 
 extern struct cpuinfo_um boot_cpu_data;
 
+#if IS_ENABLED(CONFIG_SMP)
+extern struct cpuinfo_um uml_cpu_data[];
+#else
+#define uml_cpu_data     &boot_cpu_data
+#endif
+
 #define cache_line_size()	(boot_cpu_data.cache_alignment)
 
 #define KSTK_REG(tsk, reg) get_thread_reg(reg, &tsk->thread.switch_buf)
diff --git a/arch/um/include/asm/smp.h b/arch/um/include/asm/smp.h
index a8cc1d46ddcb..585f2d59dfc7 100644
--- a/arch/um/include/asm/smp.h
+++ b/arch/um/include/asm/smp.h
@@ -2,6 +2,35 @@
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
+#define raw_smp_processor_id raw_smp_processor_id
+static inline int raw_smp_processor_id(void)
+{
+	return uml_curr_cpu();
+}
+
+#define cpu_logical_map(n) (n)
+#define cpu_number_map(n) (n)
+#define NO_PROC_ID -1
+
+extern int uml_ncpus;
+
+void arch_smp_send_reschedule(int cpu);
+
+void arch_send_call_function_single_ipi(int cpu);
+
+void arch_send_call_function_ipi_mask(const struct cpumask *mask);
+
+static inline void smp_cpus_done(unsigned int maxcpus) { }
+
+#else
+#define raw_smp_processor_id() 0
+#endif
 
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
index 000000000000..689c43c5105f
--- /dev/null
+++ b/arch/um/include/linux/smp-internal.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __SMP_INTERNAL_H__
+#define __SMP_INTERNAL_H__
+
+int smp_sigio_handler(struct uml_pt_regs *regs);
+void IPI_handler(int cpu, struct uml_pt_regs *regs);
+
+#endif /* __SMP_INTERNAL_H__ */
diff --git a/arch/um/include/linux/time-internal.h b/arch/um/include/linux/time-internal.h
index 138908b999d7..286e75f0852a 100644
--- a/arch/um/include/linux/time-internal.h
+++ b/arch/um/include/linux/time-internal.h
@@ -90,4 +90,7 @@ extern unsigned long tt_extra_sched_jiffies;
  * which is intentional since we really shouldn't link it in that case.
  */
 void time_travel_ndelay(unsigned long nsec);
+
+void um_setup_timer(void);
+
 #endif /* __TIMER_INTERNAL_H__ */
diff --git a/arch/um/include/shared/kern_util.h b/arch/um/include/shared/kern_util.h
index 00ca3e12fd9a..894b127bf22f 100644
--- a/arch/um/include/shared/kern_util.h
+++ b/arch/um/include/shared/kern_util.h
@@ -12,8 +12,10 @@
 struct siginfo;
 
 extern int uml_exitcode;
+extern int uml_ncpus;
 
 extern int kmalloc_ok;
+extern int disable_kmalloc[];
 
 #define UML_ROUND_UP(addr) \
 	((((unsigned long) addr) + PAGE_SIZE - 1) & PAGE_MASK)
diff --git a/arch/um/include/shared/longjmp.h b/arch/um/include/shared/longjmp.h
index 8863319039f3..c53e43d980c8 100644
--- a/arch/um/include/shared/longjmp.h
+++ b/arch/um/include/shared/longjmp.h
@@ -5,7 +5,6 @@
 #include <sysdep/archsetjmp.h>
 #include <os.h>
 
-extern int signals_enabled;
 extern int setjmp(jmp_buf);
 extern void longjmp(jmp_buf, int);
 
@@ -15,7 +14,7 @@ extern void longjmp(jmp_buf, int);
 
 #define UML_SETJMP(buf) ({				\
 	int n, enable;					\
-	enable = *(volatile int *)&signals_enabled;	\
+	enable = um_get_signals();			\
 	n = setjmp(*buf);				\
 	if(n != 0)					\
 		um_set_signals_trace(enable);		\
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index b35cc8ce333b..77ecd1104520 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -156,6 +156,7 @@ extern int os_pwrite_file(int fd, const void *buf, int count, unsigned long long
 extern int os_file_modtime(const char *file, long long *modtime);
 extern int os_pipe(int *fd, int stream, int close_on_exec);
 extern int os_set_fd_async(int fd);
+extern int os_set_fd_async_thread(int fd);
 extern int os_clear_fd_async(int fd);
 extern int os_set_fd_block(int fd, int blocking);
 extern int os_accept_connection(int fd);
@@ -203,6 +204,7 @@ extern void os_kill_process(int pid, int reap_child);
 extern void os_kill_ptraced_process(int pid, int reap_child);
 
 extern int os_getpid(void);
+extern int os_gettid(void);
 
 extern void init_new_thread_signals(void);
 
@@ -216,6 +218,8 @@ extern int can_drop_memory(void);
 
 void os_set_pdeathsig(void);
 
+int os_futex_wake(void *uaddr, unsigned int val);
+
 /* execvp.c */
 extern int execvp_noalloc(char *buf, const char *file, char *const argv[]);
 /* helper.c */
@@ -243,6 +247,7 @@ extern void send_sigio_to_self(void);
 extern int change_sig(int signal, int on);
 extern void block_signals(void);
 extern void unblock_signals(void);
+extern int um_get_signals(void);
 extern int um_set_signals(int enable);
 extern int um_set_signals_trace(int enable);
 extern void deliver_alarm(void);
@@ -268,9 +273,9 @@ extern void os_warn(const char *fmt, ...)
 /* time.c */
 extern void os_idle_sleep(void);
 extern int os_timer_create(void);
-extern int os_timer_set_interval(unsigned long long nsecs);
-extern int os_timer_one_shot(unsigned long long nsecs);
-extern void os_timer_disable(void);
+extern int os_timer_set_interval(int cpu, unsigned long long nsecs);
+extern int os_timer_one_shot(int cpu, unsigned long long nsecs);
+extern void os_timer_disable(int cpu);
 extern long long os_persistent_clock_emulation(void);
 extern long long os_nsecs(void);
 
@@ -291,6 +296,7 @@ extern void userspace(struct uml_pt_regs *regs);
 extern void new_thread(void *stack, jmp_buf *buf, void (*handler)(void));
 extern void switch_threads(jmp_buf *me, jmp_buf *you);
 extern int start_idle_thread(void *stack, jmp_buf *switch_buf);
+extern void start_idle_thread_secondary(jmp_buf *switch_buf);
 extern void initial_thread_cb_skas(void (*proc)(void *),
 				 void *arg);
 extern void halt_skas(void);
diff --git a/arch/um/include/shared/smp.h b/arch/um/include/shared/smp.h
new file mode 100644
index 000000000000..21544fad51db
--- /dev/null
+++ b/arch/um/include/shared/smp.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_SHARED_SMP_H
+#define __UM_SHARED_SMP_H
+
+#if IS_ENABLED(CONFIG_SMP)
+int uml_curr_cpu(void);
+#else
+#define uml_curr_cpu() 0
+#endif
+
+int start_cpu_thread(int cpu);
+void start_idle(void);
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
index 0dfaf96bb7da..9c351f537811 100644
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
@@ -683,7 +690,7 @@ void __init init_IRQ(void)
 {
 	int i;
 
-	irq_set_chip_and_handler(TIMER_IRQ, &alarm_irq_type, handle_edge_irq);
+	irq_set_chip_and_handler(TIMER_IRQ, &alarm_irq_type, handle_percpu_irq);
 
 	for (i = 1; i < UM_LAST_SIGNAL_IRQ; i++)
 		irq_set_chip_and_handler(i, &normal_irq_type, handle_edge_irq);
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
+	int cpu;
+
+#if IS_ENABLED(CONFIG_SMP)
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
diff --git a/arch/um/kernel/ksyms.c b/arch/um/kernel/ksyms.c
index f2fb77da08cf..96314c31e61c 100644
--- a/arch/um/kernel/ksyms.c
+++ b/arch/um/kernel/ksyms.c
@@ -6,8 +6,8 @@
 #include <linux/module.h>
 #include <os.h>
 
+EXPORT_SYMBOL(um_get_signals);
 EXPORT_SYMBOL(um_set_signals);
-EXPORT_SYMBOL(signals_enabled);
 
 EXPORT_SYMBOL(os_stat_fd);
 EXPORT_SYMBOL(os_stat_file);
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
index 1be644de9e41..9caa3d56b7c7 100644
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
@@ -299,3 +301,14 @@ unsigned long __get_wchan(struct task_struct *p)
 
 	return 0;
 }
+
+int smp_sigio_handler(struct uml_pt_regs *regs)
+{
+#if IS_ENABLED(CONFIG_SMP)
+	int cpu = raw_smp_processor_id();
+	IPI_handler(cpu, regs);
+	if (cpu != 0)
+		return 1;
+#endif
+	return 0;
+}
diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index afe9a2f251ef..fbb4b1c39185 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -29,6 +29,8 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	unsigned long stack = 0;
 	int ret = -ENOMEM;
 
+	spin_lock_init(&mm->context.sync_tlb_lock);
+
 	stack = __get_free_pages(GFP_KERNEL | __GFP_ZERO, ilog2(STUB_DATA_PAGES));
 	if (stack == 0)
 		goto out;
@@ -73,6 +75,9 @@ void destroy_context(struct mm_struct *mm)
 		return;
 	}
 
+	scoped_guard(spinlock_irqsave, &mm_list_lock)
+		list_del(&mm->context.list);
+
 	if (mmu->id.pid > 0) {
 		os_kill_ptraced_process(mmu->id.pid, 1);
 		mmu->id.pid = -1;
@@ -82,10 +87,6 @@ void destroy_context(struct mm_struct *mm)
 		os_close_file(mmu->id.sock);
 
 	free_pages(mmu->id.stack, ilog2(STUB_DATA_PAGES));
-
-	guard(spinlock_irqsave)(&mm_list_lock);
-
-	list_del(&mm->context.list);
 }
 
 static irqreturn_t mm_sigchld_irq(int irq, void* dev)
@@ -110,12 +111,11 @@ static irqreturn_t mm_sigchld_irq(int irq, void* dev)
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
index 000000000000..c38af62d04a5
--- /dev/null
+++ b/arch/um/kernel/smp.c
@@ -0,0 +1,223 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
+ * Copyright (C) 2025 Ant Group
+ */
+
+#include <linux/percpu.h>
+#include <asm/pgalloc.h>
+#include <asm/tlb.h>
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
+#include <linux/time-internal.h>
+#include <asm/smp.h>
+#include <asm/processor.h>
+#include <asm/spinlock.h>
+#include <kern.h>
+#include <smp.h>
+#include <irq_user.h>
+#include <as-layout.h>
+#include <os.h>
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
+void smp_send_stop(void)
+{
+	int i;
+
+	printk(KERN_INFO "Stopping all CPUs...");
+	for (i = 0; i < num_online_cpus(); i++) {
+		if (i == current_thread_info()->cpu)
+			continue;
+		os_write_file(uml_cpu_data[i].ipi_pipe[1], "S", 1);
+	}
+	printk(KERN_CONT "done\n");
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
+static cpumask_t smp_commenced_mask = CPU_MASK_NONE;
+static cpumask_t cpu_callin_map = CPU_MASK_NONE;
+
+static int idle_proc(void *unused)
+{
+	int err, cpu = raw_smp_processor_id();
+
+	err = os_pipe(uml_cpu_data[cpu].ipi_pipe, 1, 1);
+	if (err < 0)
+		panic("CPU#%d failed to create IPI pipe, err = %d", cpu, -err);
+
+	os_set_fd_async_thread(uml_cpu_data[cpu].ipi_pipe[0]);
+
+	wmb();
+	if (cpumask_test_and_set_cpu(cpu, &cpu_callin_map)) {
+		printk(KERN_ERR "huh, CPU#%d already present??\n", cpu);
+		BUG();
+	}
+
+	while (!cpumask_test_cpu(cpu, &smp_commenced_mask))
+		cpu_relax();
+
+	notify_cpu_starting(cpu);
+	set_cpu_online(cpu, true);
+
+	um_setup_timer();
+
+	cpu_startup_entry(CPUHP_AP_ONLINE_IDLE);
+	return 0;
+}
+
+static struct task_struct *idle_thread[NR_CPUS];
+static char irqstack[NR_CPUS][THREAD_SIZE] __aligned(THREAD_SIZE);
+
+void start_idle(void)
+{
+	int cpu = raw_smp_processor_id();
+	struct mm_struct *mm = &init_mm;
+	struct task_struct *p = idle_thread[cpu];
+
+	p->thread_info.cpu = cpu;
+
+	stack_protections((unsigned long) &irqstack[cpu]);
+	set_sigstack(&irqstack[cpu], THREAD_SIZE);
+
+	mmgrab(mm);
+	p->active_mm = mm;
+
+	p->thread.request.thread.proc = idle_proc;
+	p->thread.request.thread.arg = NULL;
+
+	new_thread(task_stack_page(p), &p->thread.switch_buf, new_thread_handler);
+	start_idle_thread_secondary(&p->thread.switch_buf);
+}
+
+static struct task_struct *new_idle_thread(int cpu)
+{
+	struct task_struct *new_task;
+
+	new_task = fork_idle(cpu);
+	if (IS_ERR(new_task))
+		panic("%s: fork_idle failed, error = %ld", __func__,
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
+	if (err < 0)
+		panic("CPU#0 failed to create IPI pipe, errno = %d", -err);
+
+	os_set_fd_async_thread(uml_cpu_data[me].ipi_pipe[0]);
+
+	for (cpu = 1; cpu < uml_ncpus; cpu++) {
+		printk(KERN_INFO "Booting processor %d...\n", cpu);
+
+		idle_thread[cpu] = new_idle_thread(cpu);
+		err = start_cpu_thread(cpu);
+		if (err < 0)
+			panic("CPU#%d failed to start cpu thread, errno = %d", cpu, -err);
+
+		waittime = 200000000;
+		while (waittime-- && !cpumask_test_cpu(cpu, &cpu_callin_map))
+			cpu_relax();
+
+		printk(KERN_INFO "%s\n",
+		       cpumask_test_cpu(cpu, &cpu_callin_map) ? "done" : "failed");
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
+void IPI_handler(int cpu, struct uml_pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs((struct pt_regs *)regs);
+	unsigned char c;
+	int fd;
+
+	irq_enter();
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
+			printk(KERN_INFO "CPU#%d stopping\n", cpu);
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
+			printk(KERN_ERR "CPU#%d received unknown IPI [%c]!\n",
+			       cpu, c);
+			break;
+		}
+	}
+
+	irq_exit();
+	set_irq_regs(old_regs);
+}
diff --git a/arch/um/kernel/time.c b/arch/um/kernel/time.c
index ae0fa2173778..83b16d37ce33 100644
--- a/arch/um/kernel/time.c
+++ b/arch/um/kernel/time.c
@@ -625,9 +625,10 @@ void time_travel_sleep(void)
 	 * controller application.
 	 */
 	unsigned long long next = S64_MAX;
+	int cpu = raw_smp_processor_id();
 
 	if (time_travel_mode == TT_MODE_BASIC)
-		os_timer_disable();
+		os_timer_disable(cpu);
 
 	time_travel_update_time(next, true);
 
@@ -638,9 +639,9 @@ void time_travel_sleep(void)
 			 * This is somewhat wrong - we should get the first
 			 * one sooner like the os_timer_one_shot() below...
 			 */
-			os_timer_set_interval(time_travel_timer_interval);
+			os_timer_set_interval(cpu, time_travel_timer_interval);
 		} else {
-			os_timer_one_shot(time_travel_timer_event.time - next);
+			os_timer_one_shot(cpu, time_travel_timer_event.time - next);
 		}
 	}
 }
@@ -758,6 +759,8 @@ extern u64 time_travel_ext_req(u32 op, u64 time);
 #define time_travel_del_event(e) do { } while (0)
 #endif
 
+static struct clock_event_device timer_clockevent[NR_CPUS];
+
 void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
 	unsigned long flags;
@@ -780,12 +783,14 @@ void timer_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 
 static int itimer_shutdown(struct clock_event_device *evt)
 {
+	int cpu = evt - &timer_clockevent[0];
+
 	if (time_travel_mode != TT_MODE_OFF)
 		time_travel_del_event(&time_travel_timer_event);
 
 	if (time_travel_mode != TT_MODE_INFCPU &&
 	    time_travel_mode != TT_MODE_EXTERNAL)
-		os_timer_disable();
+		os_timer_disable(cpu);
 
 	return 0;
 }
@@ -793,6 +798,7 @@ static int itimer_shutdown(struct clock_event_device *evt)
 static int itimer_set_periodic(struct clock_event_device *evt)
 {
 	unsigned long long interval = NSEC_PER_SEC / HZ;
+	int cpu = evt - &timer_clockevent[0];
 
 	if (time_travel_mode != TT_MODE_OFF) {
 		time_travel_del_event(&time_travel_timer_event);
@@ -805,7 +811,7 @@ static int itimer_set_periodic(struct clock_event_device *evt)
 
 	if (time_travel_mode != TT_MODE_INFCPU &&
 	    time_travel_mode != TT_MODE_EXTERNAL)
-		os_timer_set_interval(interval);
+		os_timer_set_interval(cpu, interval);
 
 	return 0;
 }
@@ -825,7 +831,7 @@ static int itimer_next_event(unsigned long delta,
 
 	if (time_travel_mode != TT_MODE_INFCPU &&
 	    time_travel_mode != TT_MODE_EXTERNAL)
-		return os_timer_one_shot(delta);
+		return os_timer_one_shot(raw_smp_processor_id(), delta);
 
 	return 0;
 }
@@ -835,10 +841,9 @@ static int itimer_one_shot(struct clock_event_device *evt)
 	return itimer_next_event(0, evt);
 }
 
-static struct clock_event_device timer_clockevent = {
+static struct clock_event_device _timer_clockevent = {
 	.name			= "posix-timer",
 	.rating			= 250,
-	.cpumask		= cpu_possible_mask,
 	.features		= CLOCK_EVT_FEAT_PERIODIC |
 				  CLOCK_EVT_FEAT_ONESHOT,
 	.set_state_shutdown	= itimer_shutdown,
@@ -856,6 +861,9 @@ static struct clock_event_device timer_clockevent = {
 
 static irqreturn_t um_timer(int irq, void *dev)
 {
+	int cpu = raw_smp_processor_id();
+	struct clock_event_device *evt = &timer_clockevent[cpu];
+
 	/*
 	 * Interrupt the (possibly) running userspace process, technically this
 	 * should only happen if userspace is currently executing.
@@ -867,7 +875,7 @@ static irqreturn_t um_timer(int irq, void *dev)
 	    get_current()->mm)
 		os_alarm_process(get_current()->mm->context.id.pid);
 
-	(*timer_clockevent.event_handler)(&timer_clockevent);
+	evt->event_handler(evt);
 
 	return IRQ_HANDLED;
 }
@@ -904,8 +912,26 @@ static struct clocksource timer_clocksource = {
 	.flags		= CLOCK_SOURCE_IS_CONTINUOUS,
 };
 
+void um_setup_timer(void)
+{
+	int cpu = raw_smp_processor_id();
+	struct clock_event_device *evt = &timer_clockevent[cpu];
+	int err;
+
+	err = os_timer_create();
+	if (err != 0) {
+		printk(KERN_ERR "creation of timer failed - errno = %d\n", -err);
+		return;
+	}
+	memcpy(evt, &_timer_clockevent, sizeof(*evt));
+	evt->cpumask = cpumask_of(cpu);
+	clockevents_register_device(evt);
+}
+
 static void __init um_timer_setup(void)
 {
+	int cpu = raw_smp_processor_id();
+	struct clock_event_device *evt = &timer_clockevent[cpu];
 	int err;
 
 	err = request_irq(TIMER_IRQ, um_timer, IRQF_TIMER, "hr timer", NULL);
@@ -924,7 +950,9 @@ static void __init um_timer_setup(void)
 		printk(KERN_ERR "clocksource_register_hz returned %d\n", err);
 		return;
 	}
-	clockevents_register_device(&timer_clockevent);
+	memcpy(evt, &_timer_clockevent, sizeof(*evt));
+	evt->cpumask = cpumask_of(cpu);
+	clockevents_register_device(evt);
 }
 
 void read_persistent_clock64(struct timespec64 *ts)
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
index 2f5ee045bc7a..d7fbf127021d 100644
--- a/arch/um/kernel/um_arch.c
+++ b/arch/um/kernel/um_arch.c
@@ -74,6 +74,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
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
@@ -90,13 +96,12 @@ static int show_cpuinfo(struct seq_file *m, void *v)
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
@@ -124,6 +129,9 @@ unsigned long uml_reserved; /* Also modified in mem_init */
 unsigned long start_vm;
 unsigned long end_vm;
 
+/* Set in uml_ncpus_setup */
+int uml_ncpus = 1;
+
 /* Set in early boot */
 static int have_root __initdata;
 static int have_console __initdata;
@@ -176,6 +184,27 @@ __uml_setup("console=", uml_console_setup,
 "    Specify the preferred console output driver\n\n"
 );
 
+#if IS_ENABLED(CONFIG_SMP)
+static int __init uml_ncpus_setup(char *line, int *add)
+{
+	*add = 0;
+
+	if (!sscanf(line, "%d", &uml_ncpus)) {
+		os_warn("Couldn't parse '%s'\n", line);
+		return -1;
+	}
+
+	uml_ncpus = min(uml_ncpus, NR_CPUS);
+
+	return 0;
+}
+
+__uml_setup("ncpus=", uml_ncpus_setup,
+"ncpus=<# of desired CPUs>\n"
+"    This tells an SMP kernel how many virtual processors to start.\n\n"
+);
+#endif
+
 static int __init Usage(char *line, int *add)
 {
 	const char **p;
@@ -413,6 +442,20 @@ int __init __weak read_initrd(void)
 	return 0;
 }
 
+#if IS_ENABLED(CONFIG_SMP)
+static void __init prefill_possible_map(void)
+{
+	int i;
+
+	for (i = 0; i < uml_ncpus; i++)
+		set_cpu_possible(i, true);
+	for (; i < NR_CPUS; i++)
+		set_cpu_possible(i, false);
+}
+#else
+static inline void prefill_possible_map(void) {}
+#endif
+
 void __init setup_arch(char **cmdline_p)
 {
 	u8 rng_seed[32];
@@ -426,6 +469,7 @@ void __init setup_arch(char **cmdline_p)
 	strscpy(boot_command_line, command_line, COMMAND_LINE_SIZE);
 	*cmdline_p = command_line;
 	setup_hostinfo(host_info, sizeof host_info);
+	prefill_possible_map();
 
 	if (os_getrandom(rng_seed, sizeof(rng_seed), 0) == sizeof(rng_seed)) {
 		add_bootloader_randomness(rng_seed, sizeof(rng_seed));
@@ -460,6 +504,18 @@ void apply_alternatives(struct alt_instr *start, struct alt_instr *end)
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
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index 617886d1fb1e..1c050d9f1de6 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -78,7 +78,7 @@ int os_access(const char *file, int mode)
 		(mode & OS_ACC_X_OK ? X_OK : 0) |
 		(mode & OS_ACC_F_OK ? F_OK : 0);
 
-	err = access(file, amode);
+	CATCH_EINTR(err = access(file, amode));
 	if (err < 0)
 		return -errno;
 
@@ -90,7 +90,7 @@ int os_ioctl_generic(int fd, unsigned int cmd, unsigned long arg)
 {
 	int err;
 
-	err = ioctl(fd, cmd, arg);
+	CATCH_EINTR(err = ioctl(fd, cmd, arg));
 	if (err < 0)
 		return -errno;
 
@@ -147,13 +147,13 @@ int os_file_mode(const char *file, struct openflags *mode_out)
 
 	*mode_out = OPENFLAGS();
 
-	err = access(file, W_OK);
+	CATCH_EINTR(err = access(file, W_OK));
 	if (err && (errno != EACCES))
 		return -errno;
 	else if (!err)
 		*mode_out = of_write(*mode_out);
 
-	err = access(file, R_OK);
+	CATCH_EINTR(err = access(file, R_OK));
 	if (err && (errno != EACCES))
 		return -errno;
 	else if (!err)
@@ -185,7 +185,7 @@ int os_open_file(const char *file, struct openflags flags, int mode)
 	if (flags.a)
 		f |= O_APPEND;
 
-	fd = open64(file, f, mode);
+	CATCH_EINTR(fd = open64(file, f, mode));
 	if (fd < 0)
 		return -errno;
 
@@ -245,7 +245,7 @@ int os_seek_file(int fd, unsigned long long offset)
 {
 	unsigned long long actual;
 
-	actual = lseek64(fd, offset, SEEK_SET);
+	CATCH_EINTR(actual = lseek64(fd, offset, SEEK_SET));
 	if (actual != offset)
 		return -errno;
 	return 0;
@@ -253,8 +253,9 @@ int os_seek_file(int fd, unsigned long long offset)
 
 int os_read_file(int fd, void *buf, int len)
 {
-	int n = read(fd, buf, len);
+	int n;
 
+	CATCH_EINTR(n = read(fd, buf, len));
 	if (n < 0)
 		return -errno;
 	return n;
@@ -262,8 +263,9 @@ int os_read_file(int fd, void *buf, int len)
 
 int os_pread_file(int fd, void *buf, int len, unsigned long long offset)
 {
-	int n = pread(fd, buf, len, offset);
+	int n;
 
+	CATCH_EINTR(n = pread(fd, buf, len, offset));
 	if (n < 0)
 		return -errno;
 	return n;
@@ -271,8 +273,9 @@ int os_pread_file(int fd, void *buf, int len, unsigned long long offset)
 
 int os_write_file(int fd, const void *buf, int len)
 {
-	int n = write(fd, (void *) buf, len);
+	int n;
 
+	CATCH_EINTR(n = write(fd, (void *) buf, len));
 	if (n < 0)
 		return -errno;
 	return n;
@@ -280,8 +283,9 @@ int os_write_file(int fd, const void *buf, int len)
 
 int os_sync_file(int fd)
 {
-	int n = fdatasync(fd);
+	int n;
 
+	CATCH_EINTR(n = fdatasync(fd));
 	if (n < 0)
 		return -errno;
 	return n;
@@ -289,8 +293,9 @@ int os_sync_file(int fd)
 
 int os_pwrite_file(int fd, const void *buf, int len, unsigned long long offset)
 {
-	int n = pwrite(fd, (void *) buf, len, offset);
+	int n;
 
+	CATCH_EINTR(n = pwrite(fd, (void *) buf, len, offset));
 	if (n < 0)
 		return -errno;
 	return n;
@@ -393,6 +398,41 @@ int os_pipe(int *fds, int stream, int close_on_exec)
 
 int os_set_fd_async(int fd)
 {
+	struct f_owner_ex owner = {
+		.type = F_OWNER_TID,
+		.pid  = os_getpid(),
+	};
+	int err, flags;
+
+	flags = fcntl(fd, F_GETFL);
+	if (flags < 0)
+		return -errno;
+
+	flags |= O_ASYNC | O_NONBLOCK;
+	if (fcntl(fd, F_SETFL, flags) < 0) {
+		err = -errno;
+		printk(UM_KERN_ERR "%s: failed to set O_ASYNC and O_NONBLOCK on fd # %d, errno = %d\n",
+		       __func__, fd, errno);
+		return err;
+	}
+
+	if ((fcntl(fd, F_SETSIG, SIGIO) < 0) ||
+	    (fcntl(fd, F_SETOWN_EX, &owner) < 0)) {
+		err = -errno;
+		printk(UM_KERN_ERR "%s: Failed to fcntl F_SETOWN_EX (or F_SETSIG) fd %d, errno = %d\n",
+		       __func__, fd, errno);
+		return err;
+	}
+
+	return 0;
+}
+
+int os_set_fd_async_thread(int fd)
+{
+	struct f_owner_ex owner = {
+		.type = F_OWNER_TID,
+		.pid  = os_gettid(),
+	};
 	int err, flags;
 
 	flags = fcntl(fd, F_GETFL);
@@ -402,16 +442,16 @@ int os_set_fd_async(int fd)
 	flags |= O_ASYNC | O_NONBLOCK;
 	if (fcntl(fd, F_SETFL, flags) < 0) {
 		err = -errno;
-		printk(UM_KERN_ERR "os_set_fd_async : failed to set O_ASYNC "
-		       "and O_NONBLOCK on fd # %d, errno = %d\n", fd, errno);
+		printk(UM_KERN_ERR "%s: failed to set O_ASYNC and O_NONBLOCK on fd # %d, errno = %d\n",
+		       __func__, fd, errno);
 		return err;
 	}
 
 	if ((fcntl(fd, F_SETSIG, SIGIO) < 0) ||
-	    (fcntl(fd, F_SETOWN, os_getpid()) < 0)) {
+	    (fcntl(fd, F_SETOWN_EX, &owner) < 0)) {
 		err = -errno;
-		printk(UM_KERN_ERR "os_set_fd_async : Failed to fcntl F_SETOWN "
-		       "(or F_SETSIG) fd %d, errno = %d\n", fd, errno);
+		printk(UM_KERN_ERR "%s: Failed to fcntl F_SETOWN_EX (or F_SETSIG) fd %d, errno = %d\n",
+		       __func__, fd, errno);
 		return err;
 	}
 
diff --git a/arch/um/os-Linux/main.c b/arch/um/os-Linux/main.c
index 3c63ce19e3bf..92028c14d2a3 100644
--- a/arch/um/os-Linux/main.c
+++ b/arch/um/os-Linux/main.c
@@ -16,6 +16,7 @@
 #include <init.h>
 #include <kern_util.h>
 #include <os.h>
+#include <smp.h>
 #include <um_malloc.h>
 #include "internal.h"
 
@@ -171,7 +172,7 @@ int __init main(int argc, char **argv, char **envp)
 	 */
 
 	/* stop timers and set timer signal to be ignored */
-	os_timer_disable();
+	os_timer_disable(0);
 
 	/* disable SIGIO for the fds and set SIGIO to be ignored */
 	err = deactivate_all_fds();
@@ -207,7 +208,7 @@ void *__wrap_malloc(int size)
 {
 	void *ret;
 
-	if (!kmalloc_ok)
+	if (!kmalloc_ok || disable_kmalloc[uml_curr_cpu()])
 		return __real_malloc(size);
 	else if (size <= UM_KERN_PAGE_SIZE)
 		/* finding contiguous pages can be hard*/
diff --git a/arch/um/os-Linux/process.c b/arch/um/os-Linux/process.c
index 00b49e90d05f..3cae654cbaf7 100644
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
@@ -82,6 +83,11 @@ int os_getpid(void)
 	return syscall(__NR_getpid);
 }
 
+int os_gettid(void)
+{
+	return syscall(__NR_gettid);
+}
+
 int os_map_memory(void *virt, int fd, unsigned long long off, unsigned long len,
 		  int r, int w, int x)
 {
@@ -189,3 +195,12 @@ void os_set_pdeathsig(void)
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
diff --git a/arch/um/os-Linux/signal.c b/arch/um/os-Linux/signal.c
index 11f07f498270..5fa7909111d5 100644
--- a/arch/um/os-Linux/signal.c
+++ b/arch/um/os-Linux/signal.c
@@ -68,12 +68,12 @@ static void sig_handler_common(int sig, struct siginfo *si, mcontext_t *mc)
 #define SIGCHLD_BIT 2
 #define SIGCHLD_MASK (1 << SIGCHLD_BIT)
 
-int signals_enabled;
+static __thread int signals_enabled;
 #if IS_ENABLED(CONFIG_UML_TIME_TRAVEL_SUPPORT)
 static int signals_blocked, signals_blocked_pending;
 #endif
-static unsigned int signals_pending;
-static unsigned int signals_active = 0;
+static __thread unsigned int signals_pending;
+static __thread unsigned int signals_active;
 
 static void sig_handler(int sig, struct siginfo *si, mcontext_t *mc)
 {
@@ -131,10 +131,9 @@ static void timer_real_alarm_handler(mcontext_t *mc)
 
 static void timer_alarm_handler(int sig, struct siginfo *unused_si, mcontext_t *mc)
 {
-	int enabled;
+	int enabled = signals_enabled;
 
-	enabled = signals_enabled;
-	if (!signals_enabled) {
+	if (!enabled) {
 		signals_pending |= SIGALRM_MASK;
 		return;
 	}
@@ -342,6 +341,11 @@ void unblock_signals(void)
 	}
 }
 
+int um_get_signals(void)
+{
+	return signals_enabled;
+}
+
 int um_set_signals(int enable)
 {
 	int ret;
diff --git a/arch/um/os-Linux/skas/process.c b/arch/um/os-Linux/skas/process.c
index 78f48fa9db8b..790b51328219 100644
--- a/arch/um/os-Linux/skas/process.c
+++ b/arch/um/os-Linux/skas/process.c
@@ -25,6 +25,7 @@
 #include <os.h>
 #include <ptrace_user.h>
 #include <registers.h>
+#include <smp.h>
 #include <skas.h>
 #include <sysdep/stub.h>
 #include <sysdep/mcontext.h>
diff --git a/arch/um/os-Linux/smp.c b/arch/um/os-Linux/smp.c
new file mode 100644
index 000000000000..4b75887f8537
--- /dev/null
+++ b/arch/um/os-Linux/smp.c
@@ -0,0 +1,44 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Ant Group
+ */
+
+#include <stdint.h>
+#include <errno.h>
+#include <pthread.h>
+#include <kern_util.h>
+#include <os.h>
+#include <smp.h>
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
+static void *cpu_thread(void *cpup)
+{
+	__curr_cpu = (uintptr_t)cpup;
+	start_idle();
+	return NULL;
+}
+
+int start_cpu_thread(int cpu)
+{
+	if (pthread_create(&cpu_threads[cpu], NULL, cpu_thread,
+			   (void *)(uintptr_t)cpu) != 0)
+		return -errno;
+	return 0;
+}
+
+void start_idle_thread_secondary(jmp_buf *switch_buf)
+{
+	longjmp(*switch_buf, 1);
+
+	/* unreachable */
+	printk(UM_KERN_ERR "impossible long jump!");
+	fatal_sigsegv();
+}
diff --git a/arch/um/os-Linux/start_up.c b/arch/um/os-Linux/start_up.c
index a827c2e01aa5..240fc3c2fb17 100644
--- a/arch/um/os-Linux/start_up.c
+++ b/arch/um/os-Linux/start_up.c
@@ -481,6 +481,9 @@ void __init os_early_checks(void)
 			fatal("SECCOMP userspace requested but not functional!\n");
 	}
 
+	if (uml_ncpus > 1)
+		fatal("SMP is not supported with PTRACE userspace.\n");
+
 	using_seccomp = 0;
 	check_ptrace();
 
diff --git a/arch/um/os-Linux/time.c b/arch/um/os-Linux/time.c
index 4d5591d96d8c..bbe5cf82642d 100644
--- a/arch/um/os-Linux/time.c
+++ b/arch/um/os-Linux/time.c
@@ -14,9 +14,10 @@
 #include <sys/time.h>
 #include <kern_util.h>
 #include <os.h>
+#include <smp.h>
 #include <string.h>
 
-static timer_t event_high_res_timer = 0;
+static timer_t event_high_res_timer[CONFIG_NR_CPUS] = { 0 };
 
 static inline long long timespec_to_ns(const struct timespec *ts)
 {
@@ -36,15 +37,22 @@ long long os_persistent_clock_emulation(void)
  */
 int os_timer_create(void)
 {
-	timer_t *t = &event_high_res_timer;
+	int cpu = uml_curr_cpu();
+	timer_t *t = &event_high_res_timer[cpu];
+	struct sigevent sigev = {
+		.sigev_notify          = SIGEV_THREAD_ID,
+		.sigev_signo           = SIGALRM,
+		.sigev_value.sival_ptr = t,
+		._sigev_un._tid        = os_gettid(),
+	};
 
-	if (timer_create(CLOCK_MONOTONIC, NULL, t) == -1)
+	if (timer_create(CLOCK_MONOTONIC, &sigev, t) == -1)
 		return -1;
 
 	return 0;
 }
 
-int os_timer_set_interval(unsigned long long nsecs)
+int os_timer_set_interval(int cpu, unsigned long long nsecs)
 {
 	struct itimerspec its;
 
@@ -54,13 +62,13 @@ int os_timer_set_interval(unsigned long long nsecs)
 	its.it_interval.tv_sec = nsecs / UM_NSEC_PER_SEC;
 	its.it_interval.tv_nsec = nsecs % UM_NSEC_PER_SEC;
 
-	if (timer_settime(event_high_res_timer, 0, &its, NULL) == -1)
+	if (timer_settime(event_high_res_timer[cpu], 0, &its, NULL) == -1)
 		return -errno;
 
 	return 0;
 }
 
-int os_timer_one_shot(unsigned long long nsecs)
+int os_timer_one_shot(int cpu, unsigned long long nsecs)
 {
 	struct itimerspec its = {
 		.it_value.tv_sec = nsecs / UM_NSEC_PER_SEC,
@@ -70,19 +78,19 @@ int os_timer_one_shot(unsigned long long nsecs)
 		.it_interval.tv_nsec = 0, // we cheat here
 	};
 
-	timer_settime(event_high_res_timer, 0, &its, NULL);
+	timer_settime(event_high_res_timer[cpu], 0, &its, NULL);
 	return 0;
 }
 
 /**
  * os_timer_disable() - disable the posix (interval) timer
  */
-void os_timer_disable(void)
+void os_timer_disable(int cpu)
 {
 	struct itimerspec its;
 
 	memset(&its, 0, sizeof(struct itimerspec));
-	timer_settime(event_high_res_timer, 0, &its, NULL);
+	timer_settime(event_high_res_timer[cpu], 0, &its, NULL);
 }
 
 long long os_nsecs(void)
@@ -100,6 +108,7 @@ void os_idle_sleep(void)
 {
 	struct itimerspec its;
 	sigset_t set, old;
+	int cpu = uml_curr_cpu();
 
 	/* block SIGALRM while we analyze the timer state */
 	sigemptyset(&set);
@@ -107,7 +116,7 @@ void os_idle_sleep(void)
 	sigprocmask(SIG_BLOCK, &set, &old);
 
 	/* check the timer, and if it'll fire then wait for it */
-	timer_gettime(event_high_res_timer, &its);
+	timer_gettime(event_high_res_timer[cpu], &its);
 	if (its.it_value.tv_sec || its.it_value.tv_nsec)
 		sigsuspend(&old);
 	/* either way, restore the signal mask */
diff --git a/arch/um/os-Linux/user_syms.c b/arch/um/os-Linux/user_syms.c
index a310ae27b479..c22ab1e9e50b 100644
--- a/arch/um/os-Linux/user_syms.c
+++ b/arch/um/os-Linux/user_syms.c
@@ -41,3 +41,8 @@ EXPORT_SYMBOL(vsyscall_end);
 extern int __sprintf_chk(char *str, int flag, size_t len, const char *format);
 EXPORT_SYMBOL(__sprintf_chk);
 #endif
+
+#if IS_ENABLED(CONFIG_SMP)
+int uml_curr_cpu(void);
+EXPORT_SYMBOL(uml_curr_cpu);
+#endif
-- 
2.34.1


