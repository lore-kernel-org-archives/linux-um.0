Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D57DECDE016
	for <linux-um@archiver.kernel.org>; Fri, 26 Jun 2026 04:39:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ldwv45VwiEOFYlgVQV8hIFSZjjAQdZ0G4QBWMChdTjU=; b=rnm6cihMYIS78khp+VOxRSg/3X
	6M217SNy7v3FmYzVHH4ttIY6btiMrqMsI+bWGwCT5C45Izhtai95mWOoiDkxQffuA2jIn86gBD1tn
	TDq1JGbR0wtwbN/uM8lWZjWmLNYIOJM4u8inJ/6+hSNH7+1TcCjp/Yb8A3KTnTAkWxvO8BOXut+ps
	eoiVHRjH+rIx6jtrHSOF5g8JJnL7l7lO8CiicCof4yd2fl2in45vPZiALFpbUtlROZx3iGKaLqb2I
	o7pVYfoL/n904QY1EjNghcQK5V+RIj8NxzIT9OcErVdCCnBkZ81yZwy5QYz/NR0JAuJblMsaJY7hI
	/iKdVwxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLj-0000000ATbd-2UnZ;
	Fri, 26 Jun 2026 04:39:31 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wcyLg-0000000ATYW-1FYw
	for linux-um@lists.infradead.org;
	Fri, 26 Jun 2026 04:39:28 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 388526021C;
	Fri, 26 Jun 2026 04:39:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A1BE91F00ADB;
	Fri, 26 Jun 2026 04:39:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782448766;
	bh=ldwv45VwiEOFYlgVQV8hIFSZjjAQdZ0G4QBWMChdTjU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M40gBEOPhFGE24/z1epkCuVKsdiyDOCbNHw8r+HxH1dYRVnthFi0PwQrW69SOEwOn
	 0gUweKE34cMs+Bv+RfwYpwD/qpUV4IO6aou404qgfB5DcmUSMJ4nwLlUdqR2jS4E+F
	 1Eu+WG2ojRBlDpXvnSQ6oXjoEdarF12yo2MJ6sWWKo1MI8Wc9tM2EZGLmSK5/2h3hv
	 NQo9PrOaVQYur836yqfd+8K0eHP0QLz75GA0dtLUDKorUjM8MU1zPy0tpJ5jaw+qID
	 /22I+/1/aO8In68BL/69qWYzPc65rKM6PtWbIIRJLOXxPFaQjClpMQertqwskDqQYa
	 EouXWVBXzFowg==
From: Eric Biggers <ebiggers@kernel.org>
To: x86@kernel.org
Cc: linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Eric Biggers <ebiggers@kernel.org>,
	David Laight <david.laight.linux@gmail.com>
Subject: [PATCH 8/8] lib/raid/xor: x86: Add AVX-512 optimized xor_gen()
Date: Thu, 25 Jun 2026 21:37:31 -0700
Message-ID: <20260626043731.319287-9-ebiggers@kernel.org>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260626043731.319287-1-ebiggers@kernel.org>
References: <20260626043731.319287-1-ebiggers@kernel.org>
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

Add an implementation of xor_gen() using AVX-512.

It uses 512-bit vectors, i.e. ZMM registers.  It also uses the
vpternlogq instruction to do three-input XORs when applicable.

It's enabled on x86_64 CPUs that have AVX512F && !PREFER_YMM.  In
practice that means:

    - AMD Zen 4 and later (client and server)
    - Intel Sapphire Rapids and later (server)
    - Intel Rocket Lake (client)
    - Intel Nova Lake and later (client)

The !PREFER_YMM condition excludes the older AVX-512 implementations in
Intel Skylake Server and Intel Ice Lake.  They could run this code, but
they're known to have overly-eager downclocking when ZMM registers are
used.  This is the same policy that the crypto and CRC code uses.

Benchmark on AMD Ryzen 9 9950X (Zen 5):

    src_cnt    avx          avx512       Improvement
    =======    ==========   ==========   ===========
    1          56353 MB/s   75388 MB/s   33%
    2          54274 MB/s   68409 MB/s   26%
    3          44649 MB/s   64042 MB/s   43%
    4          41315 MB/s   55002 MB/s   33%

Reviewed-by: David Laight <david.laight.linux@gmail.com>
Signed-off-by: Eric Biggers <ebiggers@kernel.org>
---
 lib/raid/xor/Makefile         |   2 +-
 lib/raid/xor/x86/xor-avx512.c | 121 ++++++++++++++++++++++++++++++++++
 lib/raid/xor/x86/xor_arch.h   |  23 ++++---
 3 files changed, 135 insertions(+), 11 deletions(-)
 create mode 100644 lib/raid/xor/x86/xor-avx512.c

diff --git a/lib/raid/xor/Makefile b/lib/raid/xor/Makefile
index e8ecec3c09f9..4a0e5c6d8298 100644
--- a/lib/raid/xor/Makefile
+++ b/lib/raid/xor/Makefile
@@ -27,11 +27,11 @@ xor-$(CONFIG_ALTIVEC)		+= powerpc/xor_vmx.o powerpc/xor_vmx_glue.o
 xor-$(CONFIG_RISCV_ISA_V)	+= riscv/xor.o riscv/xor-glue.o
 xor-$(CONFIG_SPARC32)		+= sparc/xor-sparc32.o
 xor-$(CONFIG_SPARC64)		+= sparc/xor-sparc64.o sparc/xor-sparc64-glue.o
 xor-$(CONFIG_S390)		+= s390/xor.o
 xor-$(CONFIG_X86_32)		+= x86/xor-avx.o x86/xor-sse.o x86/xor-mmx.o
-xor-$(CONFIG_X86_64)		+= x86/xor-avx.o x86/xor-sse.o
+xor-$(CONFIG_X86_64)		+= x86/xor-avx.o x86/xor-sse.o x86/xor-avx512.o
 obj-y				+= tests/
 
 CFLAGS_xor-neon.o		+= $(CC_FLAGS_FPU) -I$(src)/$(SRCARCH)
 CFLAGS_REMOVE_xor-neon.o	+= $(CC_FLAGS_NO_FPU)
 
diff --git a/lib/raid/xor/x86/xor-avx512.c b/lib/raid/xor/x86/xor-avx512.c
new file mode 100644
index 000000000000..17f57900d827
--- /dev/null
+++ b/lib/raid/xor/x86/xor-avx512.c
@@ -0,0 +1,121 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * AVX-512 optimized implementation of xor_gen()
+ *
+ * Copyright 2026 Google LLC
+ */
+
+#include <linux/types.h>
+#include <asm/fpu/api.h>
+#include "xor_impl.h"
+#include "xor_arch.h"
+
+/*
+ * Implementation notes:
+ *
+ * Unrolling by the number of buffers (2-5) is very important.
+ *
+ * Unrolling by length is less important, especially when using register-indexed
+ * addressing with negative indices from the end of the buffers.  That approach
+ * results in just two loop control instructions being needed per iteration,
+ * regardless of the number of buffers.
+ *
+ * In fact, benchmarks showed that the 2 and 3 buffer cases require only 2x
+ * unrolling by length, while the 4 and 5 buffer cases don't require any
+ * unrolling by length.  Benchmarks also showed that the register-indexed
+ * addressing isn't a bottleneck either; i.e., we can't do any better by
+ * incrementing the pointers as we go along, even with more unrolling.
+ */
+
+static void xor_avx512_2(long bytes, u8 *p1, const u8 *p2)
+{
+	long i = -bytes;
+
+	asm volatile("1: vmovdqa64 (%1,%0), %%zmm0\n"
+		     "vmovdqa64 64(%1,%0), %%zmm1\n"
+		     "vpxorq (%2,%0), %%zmm0, %%zmm0\n"
+		     "vpxorq 64(%2,%0), %%zmm1, %%zmm1\n"
+		     "vmovdqa64 %%zmm0, (%1,%0)\n"
+		     "vmovdqa64 %%zmm1, 64(%1,%0)\n"
+		     "add $128, %0\n"
+		     "jnz 1b\n"
+		     : "+&r"(i)
+		     : "r"(p1 + bytes), "r"(p2 + bytes)
+		     : "memory", "cc");
+}
+
+static void xor_avx512_3(long bytes, u8 *p1, const u8 *p2, const u8 *p3)
+{
+	long i = -bytes;
+
+	asm volatile("1: vmovdqa64 (%1,%0), %%zmm0\n"
+		     "vmovdqa64 64(%1,%0), %%zmm1\n"
+		     "vmovdqa64 (%2,%0), %%zmm2\n"
+		     "vmovdqa64 64(%2,%0), %%zmm3\n"
+		     "vpternlogq $0x96, (%3,%0), %%zmm2, %%zmm0\n"
+		     "vpternlogq $0x96, 64(%3,%0), %%zmm3, %%zmm1\n"
+		     "vmovdqa64 %%zmm0, (%1,%0)\n"
+		     "vmovdqa64 %%zmm1, 64(%1,%0)\n"
+		     "add $128, %0\n"
+		     "jnz 1b\n"
+		     : "+&r"(i)
+		     : "r"(p1 + bytes), "r"(p2 + bytes), "r"(p3 + bytes)
+		     : "memory", "cc");
+}
+
+static void xor_avx512_4(long bytes, u8 *p1, const u8 *p2, const u8 *p3,
+			 const u8 *p4)
+{
+	long i = -bytes;
+
+	asm volatile("1: vmovdqa64 (%1,%0), %%zmm0\n"
+		     "vmovdqa64 (%2,%0), %%zmm1\n"
+		     "vpxorq (%3,%0), %%zmm0, %%zmm0\n"
+		     "vpternlogq $0x96, (%4,%0), %%zmm1, %%zmm0\n"
+		     "vmovdqa64 %%zmm0, (%1,%0)\n"
+		     "add $64, %0\n"
+		     "jnz 1b\n"
+		     : "+&r"(i)
+		     : "r"(p1 + bytes), "r"(p2 + bytes), "r"(p3 + bytes),
+		       "r"(p4 + bytes)
+		     : "memory", "cc");
+}
+
+static void xor_avx512_5(long bytes, u8 *p1, const u8 *p2, const u8 *p3,
+			 const u8 *p4, const u8 *p5)
+{
+	long i = -bytes;
+
+	asm volatile("1: vmovdqa64 (%1,%0), %%zmm0\n"
+		     "vmovdqa64 (%2,%0), %%zmm1\n"
+		     "vpternlogq $0x96, (%3,%0), %%zmm1, %%zmm0\n"
+		     "vmovdqa64 (%4,%0), %%zmm1\n"
+		     "vpternlogq $0x96, (%5,%0), %%zmm1, %%zmm0\n"
+		     "vmovdqa64 %%zmm0, (%1,%0)\n"
+		     "add $64, %0\n"
+		     "jnz 1b\n"
+		     : "+&r"(i)
+		     : "r"(p1 + bytes), "r"(p2 + bytes), "r"(p3 + bytes),
+		       "r"(p4 + bytes), "r"(p5 + bytes)
+		     : "memory", "cc");
+}
+
+DO_XOR_BLOCKS(avx512_inner, xor_avx512_2, xor_avx512_3, xor_avx512_4,
+	      xor_avx512_5);
+
+/*
+ * Preconditions: bytes is a nonzero multiple of 512, and all buffers are
+ * 64-byte aligned.
+ */
+static void xor_gen_avx512(void *dest, void **srcs, unsigned int src_cnt,
+			   unsigned int bytes)
+{
+	kernel_fpu_begin();
+	xor_gen_avx512_inner(dest, srcs, src_cnt, bytes);
+	kernel_fpu_end();
+}
+
+struct xor_block_template xor_block_avx512 = {
+	.name = "avx512",
+	.xor_gen = xor_gen_avx512,
+};
diff --git a/lib/raid/xor/x86/xor_arch.h b/lib/raid/xor/x86/xor_arch.h
index 991abe3f4bbd..d5e192b8793f 100644
--- a/lib/raid/xor/x86/xor_arch.h
+++ b/lib/raid/xor/x86/xor_arch.h
@@ -4,25 +4,28 @@
 extern struct xor_block_template xor_block_pII_mmx;
 extern struct xor_block_template xor_block_p5_mmx;
 extern struct xor_block_template xor_block_sse;
 extern struct xor_block_template xor_block_sse_pf64;
 extern struct xor_block_template xor_block_avx;
+extern struct xor_block_template xor_block_avx512;
 
-/*
- * When SSE is available, use it as it can write around L2.  We may also be able
- * to load into the L1 only depending on how the cpu deals with a load to a line
- * that is being prefetched.
- *
- * When AVX2 is available, force using it as it is better by all measures.
- *
- * 32-bit without MMX can fall back to the generic routines.
- */
 static __always_inline void __init arch_xor_init(void)
 {
-	if (boot_cpu_has(X86_FEATURE_AVX)) {
+	if (IS_ENABLED(CONFIG_X86_64) && boot_cpu_has(X86_FEATURE_AVX512F) &&
+	    !boot_cpu_has(X86_FEATURE_PREFER_YMM)) {
+		/* AVX-512 will be the best; no need to try others. */
+		/* !PREFER_YMM excludes CPUs with overly-eager downclocking. */
+		xor_force(&xor_block_avx512);
+	} else if (boot_cpu_has(X86_FEATURE_AVX)) {
+		/* AVX will be the best; no need to try others. */
 		xor_force(&xor_block_avx);
 	} else if (IS_ENABLED(CONFIG_X86_64) || boot_cpu_has(X86_FEATURE_XMM)) {
+		/*
+		 * When SSE is available, use it as it can write around L2.  We
+		 * may also be able to load into the L1 only depending on how
+		 * the cpu deals with a load to a line that is being prefetched.
+		 */
 		xor_register(&xor_block_sse);
 		xor_register(&xor_block_sse_pf64);
 	} else if (boot_cpu_has(X86_FEATURE_MMX)) {
 		xor_register(&xor_block_pII_mmx);
 		xor_register(&xor_block_p5_mmx);
-- 
2.54.0


