Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E951110BA426
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 06:21:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=07vOovAtUwNz4Cgfu6Afqnyvj7rNswjLnNiipxDT/U4=; b=XhfNuN1qHOJrRK5mopFcxAv8gY
	bquKIdualy7ChVgUUqLMSEHbH4GEuEwi7zndwWSkeK2C1gFMphFogFr7YDeG2wSa/HBR9gkOxHBnW
	dMQ2EGMlbMNSsR/q01AlYyM+4TrH9h3JqGrfUvDyMeG2WgJjREEIU8RJAiaa1DDu2pCDHKu7x766z
	2U8Zz87pTIzYPVvQio5I5vZN+2Xa7u+WBa1CT8N/p5F3GtyNR2hZnN4MdoebGO09bLN3M/V0SmdZo
	8UUebtOtLDaUSZsyHMth6Yi0CA3QQ54QrIqqA8+O/v2B21TSJE2Yw/mLJmTr4l468jASBHyWHeBRy
	BjnyrNmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60ZK-00000006mpK-2MN9;
	Fri, 27 Mar 2026 06:21:18 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w60ZG-00000006mcg-2DiH;
	Fri, 27 Mar 2026 06:21:15 +0000
From: Christoph Hellwig <hch@lst.de>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Ard Biesheuvel <ardb@kernel.org>,
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
Subject: [PATCH 16/28] riscv: move the XOR code to lib/raid/
Date: Fri, 27 Mar 2026 07:16:48 +0100
Message-ID: <20260327061704.3707577-17-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260327061704.3707577-1-hch@lst.de>
References: <20260327061704.3707577-1-hch@lst.de>
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
 arch/riscv/include/asm/xor.h                 | 54 +------------------
 arch/riscv/lib/Makefile                      |  1 -
 lib/raid/xor/Makefile                        |  1 +
 lib/raid/xor/riscv/xor-glue.c                | 56 ++++++++++++++++++++
 {arch/riscv/lib => lib/raid/xor/riscv}/xor.S |  4 --
 5 files changed, 59 insertions(+), 57 deletions(-)
 create mode 100644 lib/raid/xor/riscv/xor-glue.c
 rename {arch/riscv/lib => lib/raid/xor/riscv}/xor.S (92%)

diff --git a/arch/riscv/include/asm/xor.h b/arch/riscv/include/asm/xor.h
index ed5f27903efc..614d9209d078 100644
--- a/arch/riscv/include/asm/xor.h
+++ b/arch/riscv/include/asm/xor.h
@@ -2,60 +2,10 @@
 /*
  * Copyright (C) 2021 SiFive
  */
-
-#include <linux/hardirq.h>
-#include <asm-generic/xor.h>
-#ifdef CONFIG_RISCV_ISA_V
 #include <asm/vector.h>
-#include <asm/switch_to.h>
-#include <asm/asm-prototypes.h>
-
-static void xor_vector_2(unsigned long bytes, unsigned long *__restrict p1,
-			 const unsigned long *__restrict p2)
-{
-	kernel_vector_begin();
-	xor_regs_2_(bytes, p1, p2);
-	kernel_vector_end();
-}
-
-static void xor_vector_3(unsigned long bytes, unsigned long *__restrict p1,
-			 const unsigned long *__restrict p2,
-			 const unsigned long *__restrict p3)
-{
-	kernel_vector_begin();
-	xor_regs_3_(bytes, p1, p2, p3);
-	kernel_vector_end();
-}
-
-static void xor_vector_4(unsigned long bytes, unsigned long *__restrict p1,
-			 const unsigned long *__restrict p2,
-			 const unsigned long *__restrict p3,
-			 const unsigned long *__restrict p4)
-{
-	kernel_vector_begin();
-	xor_regs_4_(bytes, p1, p2, p3, p4);
-	kernel_vector_end();
-}
-
-static void xor_vector_5(unsigned long bytes, unsigned long *__restrict p1,
-			 const unsigned long *__restrict p2,
-			 const unsigned long *__restrict p3,
-			 const unsigned long *__restrict p4,
-			 const unsigned long *__restrict p5)
-{
-	kernel_vector_begin();
-	xor_regs_5_(bytes, p1, p2, p3, p4, p5);
-	kernel_vector_end();
-}
+#include <asm-generic/xor.h>
 
-static struct xor_block_template xor_block_rvv = {
-	.name = "rvv",
-	.do_2 = xor_vector_2,
-	.do_3 = xor_vector_3,
-	.do_4 = xor_vector_4,
-	.do_5 = xor_vector_5
-};
-#endif /* CONFIG_RISCV_ISA_V */
+extern struct xor_block_template xor_block_rvv;
 
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
diff --git a/arch/riscv/lib/Makefile b/arch/riscv/lib/Makefile
index bbc031124974..e220c35764eb 100644
--- a/arch/riscv/lib/Makefile
+++ b/arch/riscv/lib/Makefile
@@ -16,5 +16,4 @@ lib-$(CONFIG_MMU)	+= uaccess.o
 lib-$(CONFIG_64BIT)	+= tishift.o
 lib-$(CONFIG_RISCV_ISA_ZICBOZ)	+= clear_page.o
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
-lib-$(CONFIG_RISCV_ISA_V)	+= xor.o
 lib-$(CONFIG_RISCV_ISA_V)	+= riscv_v_helpers.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index 006b44ce46bf..9e729b50e775 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -17,6 +17,7 @@ xor-$(CONFIG_ARM64)		+= arm64/xor-neon.o arm64/xor-neon-glue.o
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd.o
 xor-$(CONFIG_CPU_HAS_LSX)	+= loongarch/xor_simd_glue.o
 xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
+xor-$(CONFIG_RISCV_ISA_V)	+= riscv/xor.o riscv/xor-glue.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
diff --git a/lib/raid/xor/riscv/xor-glue.c b/lib/raid/xor/riscv/xor-glue.c
new file mode 100644
index 000000000000..11666a4b6b68
--- /dev/null
+++ b/lib/raid/xor/riscv/xor-glue.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright (C) 2021 SiFive
+ */
+
+#include <linux/raid/xor_impl.h>
+#include <asm/vector.h>
+#include <asm/switch_to.h>
+#include <asm/asm-prototypes.h>
+#include <asm/xor.h>
+
+static void xor_vector_2(unsigned long bytes, unsigned long *__restrict p1,
+			 const unsigned long *__restrict p2)
+{
+	kernel_vector_begin();
+	xor_regs_2_(bytes, p1, p2);
+	kernel_vector_end();
+}
+
+static void xor_vector_3(unsigned long bytes, unsigned long *__restrict p1,
+			 const unsigned long *__restrict p2,
+			 const unsigned long *__restrict p3)
+{
+	kernel_vector_begin();
+	xor_regs_3_(bytes, p1, p2, p3);
+	kernel_vector_end();
+}
+
+static void xor_vector_4(unsigned long bytes, unsigned long *__restrict p1,
+			 const unsigned long *__restrict p2,
+			 const unsigned long *__restrict p3,
+			 const unsigned long *__restrict p4)
+{
+	kernel_vector_begin();
+	xor_regs_4_(bytes, p1, p2, p3, p4);
+	kernel_vector_end();
+}
+
+static void xor_vector_5(unsigned long bytes, unsigned long *__restrict p1,
+			 const unsigned long *__restrict p2,
+			 const unsigned long *__restrict p3,
+			 const unsigned long *__restrict p4,
+			 const unsigned long *__restrict p5)
+{
+	kernel_vector_begin();
+	xor_regs_5_(bytes, p1, p2, p3, p4, p5);
+	kernel_vector_end();
+}
+
+struct xor_block_template xor_block_rvv = {
+	.name = "rvv",
+	.do_2 = xor_vector_2,
+	.do_3 = xor_vector_3,
+	.do_4 = xor_vector_4,
+	.do_5 = xor_vector_5
+};
diff --git a/arch/riscv/lib/xor.S b/lib/raid/xor/riscv/xor.S
similarity index 92%
rename from arch/riscv/lib/xor.S
rename to lib/raid/xor/riscv/xor.S
index b28f2430e52f..56fb7fc1e2cd 100644
--- a/arch/riscv/lib/xor.S
+++ b/lib/raid/xor/riscv/xor.S
@@ -18,7 +18,6 @@ SYM_FUNC_START(xor_regs_2_)
 	bnez a0, xor_regs_2_
 	ret
 SYM_FUNC_END(xor_regs_2_)
-EXPORT_SYMBOL(xor_regs_2_)
 
 SYM_FUNC_START(xor_regs_3_)
 	vsetvli a4, a0, e8, m8, ta, ma
@@ -35,7 +34,6 @@ SYM_FUNC_START(xor_regs_3_)
 	bnez a0, xor_regs_3_
 	ret
 SYM_FUNC_END(xor_regs_3_)
-EXPORT_SYMBOL(xor_regs_3_)
 
 SYM_FUNC_START(xor_regs_4_)
 	vsetvli a5, a0, e8, m8, ta, ma
@@ -55,7 +53,6 @@ SYM_FUNC_START(xor_regs_4_)
 	bnez a0, xor_regs_4_
 	ret
 SYM_FUNC_END(xor_regs_4_)
-EXPORT_SYMBOL(xor_regs_4_)
 
 SYM_FUNC_START(xor_regs_5_)
 	vsetvli a6, a0, e8, m8, ta, ma
@@ -78,4 +75,3 @@ SYM_FUNC_START(xor_regs_5_)
 	bnez a0, xor_regs_5_
 	ret
 SYM_FUNC_END(xor_regs_5_)
-EXPORT_SYMBOL(xor_regs_5_)
-- 
2.47.3


