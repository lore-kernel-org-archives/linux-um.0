Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3C29E71090
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 15:55:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=vj27u+VTf/pav5tZdQ2K1bGdZnjugtKGJr2GCyavqo4=; b=avVksFeqyQ0673
	3GxRjXnxvuu87J/JHQ/bos5HQ8KZv0YWbOFOUa3COJvan0AGs1w8mmIgIdSlTlGx7x1D1WMlPEK86
	dQ+7Hk2Zisn3dJ5El4vJs+PTVWLRIl2j2wU8ahyBRXIWEOyaRrY5Dw3Ee0WFQxdPjHWoSSmvCRV1w
	T/WMRv4p+9e6FQyWaIKTt8WC3WzI/3qyb+QPO/HjpoMwAfcRweDd57qVhZVNPI2pbZk6OmnkXKXxm
	AeRzuTcDrX6EVq8kqNjdUjS6whO1i4DNJy05MXVERapP+FLc7xa17g6Z/na69dZRyFLMxZZJrjvM0
	00RrmaYWKmiRyMXEQn9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjM1h-006SK5-0e;
	Thu, 21 Sep 2023 15:55:37 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjM1e-006SJN-1k
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 15:55:36 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjM1Z-002ZCR-8P; Thu, 21 Sep 2023 15:55:29 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjM1V-001C2j-9G; Thu, 21 Sep 2023 16:55:27 +0100
From: anton.ivanov@cambridgegreys.com
To: linux-um@lists.infradead.org
Cc: johannes@sipsolutions.net,
	richard@nod.at,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>
Subject: [PATCH v4] um: Enable preemption in UML
Date: Thu, 21 Sep 2023 16:55:22 +0100
Message-Id: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_085534_604473_72FEEE78 
X-CRM114-Status: GOOD (  18.64  )
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
 6 files changed, 92 insertions(+), 4 deletions(-)
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
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
