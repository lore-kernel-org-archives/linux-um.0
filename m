Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C625FF532D4
	for <linux-um@archiver.kernel.org>; Tue, 24 Mar 2026 06:25:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JnfUHQL3AqIKnx8oBCU9aD5TjgiTvg++db28KpYsRbM=; b=2kSm6QbLMpC1LbwUcFfBVuLOCR
	SVxARmAj9IL4HDBP/C7jgtyVoNSIX0sIj9kt3FRcPLxTrr67FuuaqHCryaEpXO574DMkfpiw09+Kd
	AsHedoz20dTRILbeXscVYmrO3JqI6Qjxo4jPS7KZdxD+Yjv8W62GOB6ck4/S8ZHUd775cgBnj1mQM
	t/yxnVvozveFj3g6pRCYcG/8h6nRuC/LkEqcHv/igZJAL9EgBSf1NxrkRX9yyapUN8Aa9b0X14XxV
	XSYkW9R6phtn+vqSt3er7gXIJDQnyM+cZiuwsAqFJSMr+9dBUy/Gy5jfLK33Ec12tTFOxGQF16/T3
	Yl+EXIpA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vCG-00000000iBt-2Cpl;
	Tue, 24 Mar 2026 06:25:00 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w4vCD-00000000i1b-1LqG;
	Tue, 24 Mar 2026 06:24:57 +0000
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
Subject: [PATCH 12/26] arm64: move the XOR code to lib/raid/
Date: Tue, 24 Mar 2026 07:21:48 +0100
Message-ID: <20260324062211.3216301-13-hch@lst.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260324062211.3216301-1-hch@lst.de>
References: <20260324062211.3216301-1-hch@lst.de>
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

Move the optimized XOR into lib/raid and include it it in the main
xor.ko instead of building a separate module for it.

Note that this drops the CONFIG_KERNEL_MODE_NEON dependency, as that is
always set for arm64.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm64/include/asm/xor.h                  | 58 +------------------
 arch/arm64/lib/Makefile                       |  6 --
 lib/raid/xor/Makefile                         |  4 ++
 lib/raid/xor/arm64/xor-neon-glue.c            | 57 ++++++++++++++++++
 .../lib => lib/raid/xor/arm64}/xor-neon.c     | 20 +------
 5 files changed, 67 insertions(+), 78 deletions(-)
 create mode 100644 lib/raid/xor/arm64/xor-neon-glue.c
 rename {arch/arm64/lib => lib/raid/xor/arm64}/xor-neon.c (95%)

diff --git a/arch/arm64/include/asm/xor.h b/arch/arm64/include/asm/xor.h
index bfa6122f55ce..81718f010761 100644
--- a/arch/arm64/include/asm/xor.h
+++ b/arch/arm64/include/asm/xor.h
@@ -1,73 +1,21 @@
 /* SPDX-License-Identifier: GPL-2.0-only */
 /*
- * arch/arm64/include/asm/xor.h
- *
  * Authors: Jackie Liu <liuyun01@kylinos.cn>
  * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
  */
 
-#include <linux/hardirq.h>
 #include <asm-generic/xor.h>
-#include <asm/hwcap.h>
 #include <asm/simd.h>
 
-#ifdef CONFIG_KERNEL_MODE_NEON
-
-extern struct xor_block_template const xor_block_inner_neon;
-
-static void
-xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2)
-{
-	scoped_ksimd()
-		xor_block_inner_neon.do_2(bytes, p1, p2);
-}
-
-static void
-xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3)
-{
-	scoped_ksimd()
-		xor_block_inner_neon.do_3(bytes, p1, p2, p3);
-}
-
-static void
-xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3,
-	   const unsigned long * __restrict p4)
-{
-	scoped_ksimd()
-		xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
-}
-
-static void
-xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
-	   const unsigned long * __restrict p2,
-	   const unsigned long * __restrict p3,
-	   const unsigned long * __restrict p4,
-	   const unsigned long * __restrict p5)
-{
-	scoped_ksimd()
-		xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
-}
-
-static struct xor_block_template xor_block_arm64 = {
-	.name   = "arm64_neon",
-	.do_2   = xor_neon_2,
-	.do_3   = xor_neon_3,
-	.do_4   = xor_neon_4,
-	.do_5	= xor_neon_5
-};
+extern struct xor_block_template xor_block_arm64;
+void __init xor_neon_init(void);
 
 #define arch_xor_init arch_xor_init
 static __always_inline void __init arch_xor_init(void)
 {
+	xor_neon_init();
 	xor_register(&xor_block_8regs);
 	xor_register(&xor_block_32regs);
 	if (cpu_has_neon())
 		xor_register(&xor_block_arm64);
 }
-
-#endif /* ! CONFIG_KERNEL_MODE_NEON */
diff --git a/arch/arm64/lib/Makefile b/arch/arm64/lib/Makefile
index 633e5223d944..448c917494f3 100644
--- a/arch/arm64/lib/Makefile
+++ b/arch/arm64/lib/Makefile
@@ -5,12 +5,6 @@ lib-y		:= clear_user.o delay.o copy_from_user.o		\
 		   memset.o memcmp.o strcmp.o strncmp.o strlen.o	\
 		   strnlen.o strchr.o strrchr.o tishift.o
 
-ifeq ($(CONFIG_KERNEL_MODE_NEON), y)
-obj-$(CONFIG_XOR_BLOCKS)	+= xor-neon.o
-CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU)
-CFLAGS_REMOVE_xor-neon.o	+= $(CC_FLAGS_NO_FPU)
-endif
-
 lib-$(CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE) += uaccess_flushcache.o
 
 obj-$(CONFIG_FUNCTION_ERROR_INJECTION) += error-inject.o
diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index fb760edae54b..4ab0e7411ff7 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -13,7 +13,11 @@ xor-$(CONFIG_ARM)		+= arm/xor.o
 ifeq ($(CONFIG_ARM),y)
 xor-$(CONFIG_KERNEL_MODE_NEON)	+= arm/xor-neon.o arm/xor-neon-glue.o
 endif
+xor-$(CONFIG_ARM64)		+= arm64/xor-neon.o arm64/xor-neon-glue.o
 
 
 CFLAGS_arm/xor-neon.o		+= $(CC_FLAGS_FPU)
 CFLAGS_REMOVE_arm/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
+
+CFLAGS_arm64/xor-neon.o		+= $(CC_FLAGS_FPU)
+CFLAGS_REMOVE_arm64/xor-neon.o	+= $(CC_FLAGS_NO_FPU)
diff --git a/lib/raid/xor/arm64/xor-neon-glue.c b/lib/raid/xor/arm64/xor-neon-glue.c
new file mode 100644
index 000000000000..067a2095659a
--- /dev/null
+++ b/lib/raid/xor/arm64/xor-neon-glue.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Authors: Jackie Liu <liuyun01@kylinos.cn>
+ * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
+ */
+
+#include <linux/raid/xor_impl.h>
+#include <asm/simd.h>
+#include <asm/xor.h>
+
+extern struct xor_block_template const xor_block_inner_neon;
+
+static void
+xor_neon_2(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2)
+{
+	scoped_ksimd()
+		xor_block_inner_neon.do_2(bytes, p1, p2);
+}
+
+static void
+xor_neon_3(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3)
+{
+	scoped_ksimd()
+		xor_block_inner_neon.do_3(bytes, p1, p2, p3);
+}
+
+static void
+xor_neon_4(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3,
+	   const unsigned long * __restrict p4)
+{
+	scoped_ksimd()
+		xor_block_inner_neon.do_4(bytes, p1, p2, p3, p4);
+}
+
+static void
+xor_neon_5(unsigned long bytes, unsigned long * __restrict p1,
+	   const unsigned long * __restrict p2,
+	   const unsigned long * __restrict p3,
+	   const unsigned long * __restrict p4,
+	   const unsigned long * __restrict p5)
+{
+	scoped_ksimd()
+		xor_block_inner_neon.do_5(bytes, p1, p2, p3, p4, p5);
+}
+
+struct xor_block_template xor_block_arm64 = {
+	.name   = "arm64_neon",
+	.do_2   = xor_neon_2,
+	.do_3   = xor_neon_3,
+	.do_4   = xor_neon_4,
+	.do_5	= xor_neon_5
+};
diff --git a/arch/arm64/lib/xor-neon.c b/lib/raid/xor/arm64/xor-neon.c
similarity index 95%
rename from arch/arm64/lib/xor-neon.c
rename to lib/raid/xor/arm64/xor-neon.c
index 351aba92d932..8d2d185090db 100644
--- a/arch/arm64/lib/xor-neon.c
+++ b/lib/raid/xor/arm64/xor-neon.c
@@ -1,15 +1,13 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * arch/arm64/lib/xor-neon.c
- *
  * Authors: Jackie Liu <liuyun01@kylinos.cn>
  * Copyright (C) 2018,Tianjin KYLIN Information Technology Co., Ltd.
  */
 
-#include <linux/raid/xor.h>
 #include <linux/raid/xor_impl.h>
-#include <linux/module.h>
+#include <linux/cache.h>
 #include <asm/neon-intrinsics.h>
+#include <asm/xor.h>
 
 static void xor_arm64_neon_2(unsigned long bytes, unsigned long * __restrict p1,
 	const unsigned long * __restrict p2)
@@ -180,7 +178,6 @@ struct xor_block_template xor_block_inner_neon __ro_after_init = {
 	.do_4	= xor_arm64_neon_4,
 	.do_5	= xor_arm64_neon_5,
 };
-EXPORT_SYMBOL(xor_block_inner_neon);
 
 static inline uint64x2_t eor3(uint64x2_t p, uint64x2_t q, uint64x2_t r)
 {
@@ -318,22 +315,11 @@ static void xor_arm64_eor3_5(unsigned long bytes,
 	} while (--lines > 0);
 }
 
-static int __init xor_neon_init(void)
+void __init xor_neon_init(void)
 {
 	if (cpu_have_named_feature(SHA3)) {
 		xor_block_inner_neon.do_3 = xor_arm64_eor3_3;
 		xor_block_inner_neon.do_4 = xor_arm64_eor3_4;
 		xor_block_inner_neon.do_5 = xor_arm64_eor3_5;
 	}
-	return 0;
 }
-module_init(xor_neon_init);
-
-static void __exit xor_neon_exit(void)
-{
-}
-module_exit(xor_neon_exit);
-
-MODULE_AUTHOR("Jackie Liu <liuyun01@kylinos.cn>");
-MODULE_DESCRIPTION("ARMv8 XOR Extensions");
-MODULE_LICENSE("GPL");
-- 
2.47.3


