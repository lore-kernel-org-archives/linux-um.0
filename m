Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B20FD063E
	for <linux-um@archiver.kernel.org>; Wed, 11 Mar 2026 07:07:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YPyANLqg5hqrVsVOEPNjtS+GLiKI++rSSPuBBCl9deQ=; b=0q2zvBFPmzKXthz9lzkU9lOfQ6
	vBTHoquxqZ1SzVLCF/6mNHLpjnsNe/sw1jhPi9l08QddmKn/3fDihQSKFFVWG89aE/rDdfH2iXPMu
	up3x5aUF891JzaNTNjGRxmJATTUEh5eFYK0MCcsGirVKvyrDWSkWsfzlgZHAyMbGb4z04jVc3S4Lu
	IwOFcrNjTQTHM3bWal0Lz6cnQR0VRhWP1ptu2y4JJmLpTuznG3nPcd1xvMPv7jVWeCXmvm68peFDw
	Qe5NVu3WETanqvTTr9CJ26jOCFlWGJBDG3N/wael6Xmi3nRyaw8ICabWrHhGcS50t7wD/xqM+seku
	WPuQcetQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Dfd-0000000B00c-0ETc;
	Wed, 11 Mar 2026 07:07:53 +0000
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Dfa-0000000AzpY-1BOO;
	Wed, 11 Mar 2026 07:07:50 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>,
	"Theodore Ts'o" <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org,
	linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org,
	linux-raid@vger.kernel.org
Subject: [PATCH 14/27] powerpc: move the XOR code to lib/raid/
Date: Wed, 11 Mar 2026 08:03:46 +0100
Message-ID: <20260311070416.972667-15-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260311070416.972667-1-hch@lst.de>
References: <20260311070416.972667-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Move the optimized XOR into lib/raid and include it it in xor.ko
instead of always building it into the main kernel image.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/powerpc/include/asm/xor.h                | 17 +----
 arch/powerpc/include/asm/xor_altivec.h        | 22 ------
 arch/powerpc/lib/Makefile                     |  5 --
 arch/powerpc/lib/xor_vmx_glue.c               | 63 -----------------
 lib/raid/xor/Makefile                         |  5 ++
 .../lib => lib/raid/xor/powerpc}/xor_vmx.c    |  0
 .../lib => lib/raid/xor/powerpc}/xor_vmx.h    |  0
 lib/raid/xor/powerpc/xor_vmx_glue.c           | 67 +++++++++++++++++++
 8 files changed, 74 insertions(+), 105 deletions(-)
 delete mode 100644 arch/powerpc/include/asm/xor_altivec.h
 delete mode 100644 arch/powerpc/lib/xor_vmx_glue.c
 rename {arch/powerpc/lib => lib/raid/xor/powerpc}/xor_vmx.c (100%)
 rename {arch/powerpc/lib => lib/raid/xor/powerpc}/xor_vmx.h (100%)
 create mode 100644 lib/raid/xor/powerpc/xor_vmx_glue.c

diff --git a/arch/powerpc/include/asm/xor.h b/arch/powerpc/include/asm/xor.h
index 30224c5279c4..3293ac87181c 100644
--- a/arch/powerpc/include/asm/xor.h
+++ b/arch/powerpc/include/asm/xor.h
@@ -8,24 +8,11 @@
 #ifndef _ASM_POWERPC_XOR_H
 #define _ASM_POWERPC_XOR_H
 
-#ifdef CONFIG_ALTIVEC
-
-#include <asm/cputable.h>
 #include <asm/cpu_has_feature.h>
-#include <asm/xor_altivec.h>
-
-static struct xor_block_template xor_block_altivec = {
-	.name = "altivec",
-	.do_2 = xor_altivec_2,
-	.do_3 = xor_altivec_3,
-	.do_4 = xor_altivec_4,
-	.do_5 = xor_altivec_5,
-};
-#endif /* CONFIG_ALTIVEC */
-
-/* Also try the generic routines. */
 #include <asm-generic/xor.h>
 
+extern struct xor_block_template xor_block_altivec;
+
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
 {
diff --git a/arch/powerpc/include/asm/xor_altivec.h b/arch/powerpc/include/asm/xor_altivec.h
deleted file mode 100644
index 294620a25f80..000000000000
--- a/arch/powerpc/include/asm/xor_altivec.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _ASM_POWERPC_XOR_ALTIVEC_H
-#define _ASM_POWERPC_XOR_ALTIVEC_H
-
-#ifdef CONFIG_ALTIVEC
-void xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2);
-void xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3);
-void xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3,
-		   const unsigned long * __restrict p4);
-void xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3,
-		   const unsigned long * __restrict p4,
-		   const unsigned long * __restrict p5);
-
-#endif
-#endif /* _ASM_POWERPC_XOR_ALTIVEC_H */
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index f14ecab674a3..002edc3f01d5 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -73,9 +73,4 @@ obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
 
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
 
-obj-$(CONFIG_ALTIVEC)	+= xor_vmx.o xor_vmx_glue.o
-CFLAGS_xor_vmx.o += -mhard-float -maltivec $(call cc-option,-mabi=altivec)
-# Enable <altivec.h>
-CFLAGS_xor_vmx.o += -isystem $(shell $(CC) -print-file-name=include)
-
 obj-$(CONFIG_PPC64) += $(obj64-y)
diff --git a/arch/powerpc/lib/xor_vmx_glue.c b/arch/powerpc/lib/xor_vmx_glue.c
deleted file mode 100644
index 35d917ece4d1..000000000000
--- a/arch/powerpc/lib/xor_vmx_glue.c
+++ /dev/null
@@ -1,63 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/*
- * Altivec XOR operations
- *
- * Copyright 2017 IBM Corp.
- */
-
-#include <linux/preempt.h>
-#include <linux/export.h>
-#include <linux/sched.h>
-#include <asm/switch_to.h>
-#include <asm/xor_altivec.h>
-#include "xor_vmx.h"
-
-void xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2)
-{
-	preempt_disable();
-	enable_kernel_altivec();
-	__xor_altivec_2(bytes, p1, p2);
-	disable_kernel_altivec();
-	preempt_enable();
-}
-EXPORT_SYMBOL(xor_altivec_2);
-
-void xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3)
-{
-	preempt_disable();
-	enable_kernel_altivec();
-	__xor_altivec_3(bytes, p1, p2, p3);
-	disable_kernel_altivec();
-	preempt_enable();
-}
-EXPORT_SYMBOL(xor_altivec_3);
-
-void xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3,
-		   const unsigned long * __restrict p4)
-{
-	preempt_disable();
-	enable_kernel_altivec();
-	__xor_altivec_4(bytes, p1, p2, p3, p4);
-	disable_kernel_altivec();
-	preempt_enable();
-}
-EXPORT_SYMBOL(xor_altivec_4);
-
-void xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
-		   const unsigned long * __restrict p2,
-		   const unsigned long * __restrict p3,
-		   const unsigned long * __restrict p4,
-		   const unsigned long * __restrict p5)
-{
-	preempt_disable();
-	enable_kernel_altivec();
-	__xor_altivec_5(bytes, p1, p2, p3, p4, p5);
-	disable_kernel_altivec();
-	preempt_enable();
-}
-EXPORT_SYMBOL(xor_altivec_5);
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index fafd131cef27..3df9e04a1a9b 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -17,6 +17,7 @@ xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm64/xor-neon.o arm64/xor-neon-glue.o
 endif
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd.o
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd_glue.o
+xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
@@ -24,3 +25,7 @@ CFLAGS_REMOVE_arm/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
 
 CFLAGS_arm64/xor-neon.o		+= $(CC_FLAGS_FPU)
 CFLAGS_REMOVE_arm64/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
+
+CFLAGS_powerpc/xor_vmx.o	+= -mhard-float -maltivec \
+				   $(call cc-option,-mabi=altivec) \
+				   -isystem $(shell $(CC) -print-file-name=include)
diff --git a/arch/powerpc/lib/xor_vmx.c b/lib/raid/xor/powerpc/xor_vmx.c
similarity index 100%
rename from arch/powerpc/lib/xor_vmx.c
rename to lib/raid/xor/powerpc/xor_vmx.c
diff --git a/arch/powerpc/lib/xor_vmx.h b/lib/raid/xor/powerpc/xor_vmx.h
similarity index 100%
rename from arch/powerpc/lib/xor_vmx.h
rename to lib/raid/xor/powerpc/xor_vmx.h
diff --git a/lib/raid/xor/powerpc/xor_vmx_glue.c b/lib/raid/xor/powerpc/xor_vmx_glue.c
new file mode 100644
index 000000000000..c41e38340700
--- /dev/null
+++ b/lib/raid/xor/powerpc/xor_vmx_glue.c
@@ -0,0 +1,67 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Altivec XOR operations
+ *
+ * Copyright 2017 IBM Corp.
+ */
+
+#include <linux/preempt.h>
+#include <linux/sched.h>
+#include <linux/raid/xor_impl.h>
+#include <asm/switch_to.h>
+#include <asm/xor.h>
+#include "xor_vmx.h"
+
+static void xor_altivec_2(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_2(bytes, p1, p2);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+
+static void xor_altivec_3(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_3(bytes, p1, p2, p3);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+
+static void xor_altivec_4(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_4(bytes, p1, p2, p3, p4);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+
+static void xor_altivec_5(unsigned long bytes, unsigned long * __restrict p1,
+		const unsigned long * __restrict p2,
+		const unsigned long * __restrict p3,
+		const unsigned long * __restrict p4,
+		const unsigned long * __restrict p5)
+{
+	preempt_disable();
+	enable_kernel_altivec();
+	__xor_altivec_5(bytes, p1, p2, p3, p4, p5);
+	disable_kernel_altivec();
+	preempt_enable();
+}
+
+struct xor_block_template xor_block_altivec = {
+	.name = "altivec",
+	.do_2 = xor_altivec_2,
+	.do_3 = xor_altivec_3,
+	.do_4 = xor_altivec_4,
+	.do_5 = xor_altivec_5,
+};
-- 
2.47.3


