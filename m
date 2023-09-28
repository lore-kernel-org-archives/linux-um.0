Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5999CE7B0E
	for <linux-um@archiver.kernel.org>; Thu, 28 Sep 2023 09:11:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=I8y9rP6ynN3MSZQV1NXmVW3lXIp3vCJBMsiclzXEAjU=; b=aZrw6QO++nZkUN
	yHg5URn93LOjjVklqXUan3MFG2C2BhlHsE+5ELN44UzdYSSGOlhuxQXeTMSdhrSLTc+g3U3GvWia8
	5PhByjZKs3sI1ZmLaojOo75NkkcYjuqETQiTnEKreJocnnjsLN0TMxM4hs2CS76tqmmd6VGoq1U7h
	gNUFAIlc3hIVTXIEuQ1oQ4hAe2hV6vncQTxjSpcMrsIGPFE9FF0P/mKgEzu9xL6fQwEwPuOXPaJUH
	7nTGgKb2bqMP81dz/MIyBeXnfgUweauVACBQnV2X+er10Mz5KyBc7S06hqB5EsS86PkOCOMzGbi4x
	J6cHF83BUlicVjkc+5kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qln2w-002ha2-24;
	Thu, 28 Sep 2023 09:10:58 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qln2s-002hYq-1J
	for linux-um@lists.infradead.org;
	Thu, 28 Sep 2023 09:10:57 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qln2m-002yqb-M2; Thu, 28 Sep 2023 09:10:49 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qln2i-005y6V-37;
	Thu, 28 Sep 2023 10:10:46 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net,
	richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v7] um: Enable preemption in UML
Date: Thu, 28 Sep 2023 10:10:42 +0100
Message-Id: <20230928091042.1422353-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230928_021054_621524_DD4881AD 
X-CRM114-Status: GOOD (  23.46  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

1. Preemption requires saving/restoring FPU state. This patch
adds support for it using GCC intrinsics as well as appropriate
storage space in the thread structure. We reuse the space
which is already allocated for the userspace threads in the
thread_info structure.

2. irq critical sections need preempt_disable()/preempt_enable().

3. TLB critical sections need preempt_disable()/preempt_enable().

4. UML TLB flush is also invoked during a fork. This happens
with interrupts and preempt disabled which disagrees with the
standard mm locking via rwsem. The mm lock for this code path
had to be replaced with an rcu.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/Kconfig                   |  2 +-
 arch/um/include/asm/fpu/api.h     |  9 ++--
 arch/um/include/asm/thread_info.h |  2 +-
 arch/um/kernel/Makefile           |  4 ++
 arch/um/kernel/fpu.c              | 75 +++++++++++++++++++++++++++++++
 arch/um/kernel/irq.c              |  2 +
 arch/um/kernel/tlb.c              | 12 +++++
 7 files changed, 101 insertions(+), 5 deletions(-)
 create mode 100644 arch/um/kernel/fpu.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index b5e179360534..19176fde82f3 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,7 +11,7 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_NO_PREEMPT
+	select ARCH_NO_PREEMPT_DYNAMIC
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KASAN if X86_64
 	select HAVE_ARCH_KASAN_VMALLOC if HAVE_ARCH_KASAN
diff --git a/arch/um/include/asm/fpu/api.h b/arch/um/include/asm/fpu/api.h
index 71bfd9ef3938..9e7680bf48f0 100644
--- a/arch/um/include/asm/fpu/api.h
+++ b/arch/um/include/asm/fpu/api.h
@@ -4,12 +4,15 @@
 
 /* Copyright (c) 2020 Cambridge Greys Ltd
  * Copyright (c) 2020 Red Hat Inc.
- * A set of "dummy" defines to allow the direct inclusion
- * of x86 optimized copy, xor, etc routines into the
- * UML code tree. */
+ */
 
+#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
+extern void kernel_fpu_begin(void);
+extern void kernel_fpu_end(void);
+#else
 #define kernel_fpu_begin() (void)0
 #define kernel_fpu_end() (void)0
+#endif
 
 static inline bool irq_fpu_usable(void)
 {
diff --git a/arch/um/include/asm/thread_info.h b/arch/um/include/asm/thread_info.h
index c7b4b49826a2..02935c37d58f 100644
--- a/arch/um/include/asm/thread_info.h
+++ b/arch/um/include/asm/thread_info.h
@@ -23,7 +23,7 @@ struct thread_info {
 	int			preempt_count;  /* 0 => preemptable,
 						   <0 => BUG */
 	struct thread_info	*real_thread;    /* Points to non-IRQ stack */
-	unsigned long aux_fp_regs[FP_SIZE];	/* auxiliary fp_regs to save/restore
+	unsigned long aux_fp_regs[FP_SIZE] __aligned(64);	/* auxiliary fp_regs to save/restore
 						   them out-of-band */
 };
 
diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
index 811188be954c..c616e884a488 100644
--- a/arch/um/kernel/Makefile
+++ b/arch/um/kernel/Makefile
@@ -26,9 +26,13 @@ obj-$(CONFIG_OF) += dtb.o
 obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
 obj-$(CONFIG_STACKTRACE) += stacktrace.o
 obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
+obj-$(CONFIG_PREEMPT) += fpu.o
+obj-$(CONFIG_PREEMPT_VOLUNTARY) += fpu.o
 
 USER_OBJS := config.o
 
+CFLAGS_fpu.o += -mxsave -mxsaveopt
+
 include $(srctree)/arch/um/scripts/Makefile.rules
 
 targets := config.c config.tmp capflags.c
diff --git a/arch/um/kernel/fpu.c b/arch/um/kernel/fpu.c
new file mode 100644
index 000000000000..fb9eb6678e01
--- /dev/null
+++ b/arch/um/kernel/fpu.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2023 Cambridge Greys Ltd
+ * Copyright (C) 2023 Red Hat Inc
+ */
+
+#include <linux/cpu.h>
+#include <linux/init.h>
+#include <asm/fpu/api.h>
+#include <asm/cpufeature.h>
+
+/*
+ * The critical section between kernel_fpu_begin() and kernel_fpu_end()
+ * is non-reentrant. It is the caller's responsibility to avoid reentrance.
+ */
+
+static DEFINE_PER_CPU(bool, in_kernel_fpu);
+
+/* UML and driver code it pulls out of the x86 tree knows about 387 features
+ * up to and including AVX512. TILE, etc are not yet supported.
+ */
+
+#define KNOWN_387_FEATURES 0xFF
+
+void kernel_fpu_begin(void)
+{
+	preempt_disable();
+
+	WARN_ON(this_cpu_read(in_kernel_fpu));
+
+	this_cpu_write(in_kernel_fpu, true);
+
+#ifdef CONFIG_64BIT
+	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
+		__builtin_ia32_xsaveopt64(&current_thread_info()->aux_fp_regs, KNOWN_387_FEATURES);
+	else {
+		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
+			__builtin_ia32_xsave64(&current_thread_info()->aux_fp_regs, KNOWN_387_FEATURES);
+		else
+			__builtin_ia32_fxsave64(&current_thread_info()->aux_fp_regs);
+	}
+#else
+	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
+		__builtin_ia32_xsaveopt(&current->aux_fp_regs, KNOWN_387_FEATURES);
+	else {
+		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
+			__builtin_ia32_xsave(&current->aux_fp_regs, KNOWN_387_FEATURES);
+		else
+			__builtin_ia32_fxsave(&current->aux_fp_regs);
+	}
+#endif
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+
+void kernel_fpu_end(void)
+{
+	WARN_ON(!this_cpu_read(in_kernel_fpu));
+
+#ifdef CONFIG_64BIT
+	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
+		__builtin_ia32_xrstor64(&current_thread_info()->aux_fp_regs, KNOWN_387_FEATURES);
+	else
+		__builtin_ia32_fxrstor64(&current_thread_info()->aux_fp_regs);
+#else
+	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
+		__builtin_ia32_xrstor(&current_tread_info()->aux_fp_regs, KNOWN_387_FEATURES);
+	else
+		__builtin_ia32_fxrstor(&current_thread_info()->aux_fp_regs);
+#endif
+	this_cpu_write(in_kernel_fpu, false);
+
+	preempt_enable();
+}
+EXPORT_SYMBOL_GPL(kernel_fpu_end);
+
diff --git a/arch/um/kernel/irq.c b/arch/um/kernel/irq.c
index 635d44606bfe..c02525da45df 100644
--- a/arch/um/kernel/irq.c
+++ b/arch/um/kernel/irq.c
@@ -195,7 +195,9 @@ static void _sigio_handler(struct uml_pt_regs *regs,
 
 void sigio_handler(int sig, struct siginfo *unused_si, struct uml_pt_regs *regs)
 {
+	preempt_disable();
 	_sigio_handler(regs, irqs_suspended);
+	preempt_enable();
 }
 
 static struct irq_entry *get_irq_entry_by_fd(int fd)
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 247396b732e5..862174a2a3f5 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -322,6 +322,8 @@ static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 	unsigned long addr = start_addr, next;
 	int ret = 0, userspace = 1;
 
+	preempt_disable();
+
 	hvc = INIT_HVC(mm, force, userspace);
 	pgd = pgd_offset(mm, addr);
 	do {
@@ -346,6 +348,7 @@ static void fix_range_common(struct mm_struct *mm, unsigned long start_addr,
 		       "process: %d\n", task_tgid_vnr(current));
 		mm_idp->kill = 1;
 	}
+	preempt_enable();
 }
 
 static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
@@ -362,6 +365,9 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 
 	mm = &init_mm;
 	hvc = INIT_HVC(mm, force, userspace);
+
+	preempt_disable();
+
 	for (addr = start; addr < end;) {
 		pgd = pgd_offset(mm, addr);
 		if (!pgd_present(*pgd)) {
@@ -449,6 +455,9 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 
 	if (err < 0)
 		panic("flush_tlb_kernel failed, errno = %d\n", err);
+
+	preempt_enable();
+
 	return updated;
 }
 
@@ -466,6 +475,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 
 	address &= PAGE_MASK;
 
+	preempt_disable();
+
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
 		goto kill;
@@ -520,6 +531,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 
 	*pte = pte_mkuptodate(*pte);
 
+	preempt_enable();
 	return;
 
 kill:
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
