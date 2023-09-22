Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEAEFE7D0D5
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 06:52:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=tm711zWBxeaoK8iByZzDWas23O2zix4bYISrUQGOm8k=; b=cGsf2x/1OBqf1K
	xvYbRIYnzuJsYjpyDugLv2+0VtT2Z3QeIlYHaKKnVM6r1730mt/Gd8Qp0tD+0OVm6GUiVOe/nVn9+
	5L7nHg3ma+Ea/rXvSBUEzpeYpQtIpLy2NO4/jBBUwWsA3eXC0lehzB8gAxOi9H5ByvLMt70EsuXTa
	AGDruR4mJnv0HPoJ7IEXzMVN0zKYaiy5IoPpxzn72R1abaF9B2hYfK1pmLUwuJEa2xO06ulwDQ9e4
	241UYqXMK8oUvPKH7kSF1C74VNjkwIfCqoB6o4+NkyNjJoBjyG5oPyPhSJZXlll2dJlOnXAizo2ni
	Dr4lKub1PHaWy1QAviVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qja1Y-0085yJ-10;
	Fri, 22 Sep 2023 06:52:24 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qja1U-0085wv-2r
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 06:52:22 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qja1S-002awa-Oe; Fri, 22 Sep 2023 06:52:19 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qja1O-00223P-Es; Fri, 22 Sep 2023 07:52:16 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net,
	richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v5] um: Enable preemption in UML
Date: Fri, 22 Sep 2023 07:52:12 +0100
Message-Id: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_235220_947548_5660D8FB 
X-CRM114-Status: GOOD (  20.80  )
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

Preemption requires saving/restoring FPU state. This patch
adds support for it using GCC intrinsics.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/Kconfig                         |  1 -
 arch/um/include/asm/fpu/api.h           |  9 ++-
 arch/um/include/asm/processor-generic.h |  3 +
 arch/um/kernel/Makefile                 |  4 ++
 arch/um/kernel/fpu.c                    | 77 +++++++++++++++++++++++++
 arch/um/kernel/irq.c                    |  2 +
 arch/um/kernel/tlb.c                    |  9 +++
 7 files changed, 101 insertions(+), 4 deletions(-)
 create mode 100644 arch/um/kernel/fpu.c

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index b5e179360534..603f5fd82293 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -11,7 +11,6 @@ config UML
 	select ARCH_HAS_KCOV
 	select ARCH_HAS_STRNCPY_FROM_USER
 	select ARCH_HAS_STRNLEN_USER
-	select ARCH_NO_PREEMPT
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
diff --git a/arch/um/include/asm/processor-generic.h b/arch/um/include/asm/processor-generic.h
index 7414154b8e9a..c08e8c5b0249 100644
--- a/arch/um/include/asm/processor-generic.h
+++ b/arch/um/include/asm/processor-generic.h
@@ -44,6 +44,9 @@ struct thread_struct {
 			} cb;
 		} u;
 	} request;
+#if defined(CONFIG_PREEMPT) || defined(CONFIG_PREEMPT_VOLUNTARY)
+    u8 fpu[2048] __aligned(64); /* Intel docs require xsave/xrestore area to be aligned to 64 bytes */
+#endif
 };
 
 #define INIT_THREAD \
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
index 000000000000..346c07236185
--- /dev/null
+++ b/arch/um/kernel/fpu.c
@@ -0,0 +1,77 @@
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
+		__builtin_ia32_xsaveopt64(&current->thread.fpu, KNOWN_387_FEATURES);
+	else {
+		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
+			__builtin_ia32_xsave64(&current->thread.fpu, KNOWN_387_FEATURES);
+		else
+			__builtin_ia32_fxsave64(&current->thread.fpu);
+	}
+#else
+	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVEOPT)))
+		__builtin_ia32_xsaveopt(&current->thread.fpu, KNOWN_387_FEATURES);
+	else {
+		if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
+			__builtin_ia32_xsave(&current->thread.fpu, KNOWN_387_FEATURES);
+		else
+			__builtin_ia32_fxsave(&current->thread.fpu);
+	}
+#endif
+}
+
+EXPORT_SYMBOL_GPL(kernel_fpu_begin);
+
+void kernel_fpu_end(void)
+{
+	WARN_ON(!this_cpu_read(in_kernel_fpu));
+
+#ifdef CONFIG_64BIT
+	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
+		__builtin_ia32_xrstor64(&current->thread.fpu, KNOWN_387_FEATURES);
+	else
+		__builtin_ia32_fxrstor64(&current->thread.fpu);
+#else
+	if (likely(cpu_has(&boot_cpu_data, X86_FEATURE_XSAVE)))
+		__builtin_ia32_xrstor(&current->thread.fpu, KNOWN_387_FEATURES);
+	else
+		__builtin_ia32_fxrstor(&current->thread.fpu);
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
index 7d050ab0f78a..34ec8e677fb9 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -362,6 +362,9 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 
 	mm = &init_mm;
 	hvc = INIT_HVC(mm, force, userspace);
+
+    preempt_disable();
+
 	for (addr = start; addr < end;) {
 		pgd = pgd_offset(mm, addr);
 		if (!pgd_present(*pgd)) {
@@ -449,6 +452,9 @@ static int flush_tlb_kernel_range_common(unsigned long start, unsigned long end)
 
 	if (err < 0)
 		panic("flush_tlb_kernel failed, errno = %d\n", err);
+
+    preempt_enable();
+
 	return updated;
 }
 
@@ -466,6 +472,8 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 
 	address &= PAGE_MASK;
 
+    preempt_disable();
+
 	pgd = pgd_offset(mm, address);
 	if (!pgd_present(*pgd))
 		goto kill;
@@ -520,6 +528,7 @@ void flush_tlb_page(struct vm_area_struct *vma, unsigned long address)
 
 	*pte = pte_mkuptodate(*pte);
 
+    preempt_enable();
 	return;
 
 kill:
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
