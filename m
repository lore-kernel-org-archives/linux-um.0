Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90144FD063E
	for <linux-um@archiver.kernel.org>; Wed, 11 Mar 2026 07:06:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=X4zeNPSksMx/cgAVpJRzn4lXyMObGN1ImU5c6xdQw8g=; b=hutGSuvPKZSSsvFpvtohfYQcjk
	N/HqBL8Ef53dSBcsBC95olCB6DU8BYbfyqA97uT0JDIcSZxjSh4POxxGAWDGxrgfyoOzjTb6kELoG
	G37mRYv5tV+1WHuvyF8TL9s3mMJYpWiHR4cQXzno4wAK60YYo015PUVOHDBIHTQakeLFSy+hnt0c4
	zGpHprnTPcS4coegeeFSqvU20zXn0W2kydYnx5h+I8QHbY8qbiTxLodeBDaufOIrTP3+K4JTQxh0r
	v0g4ta2rGhQeQgizjK6tUPEIVCuUULooROJLbCL4YL60qAFtMhWOKGGAmY+GLDQElQsqZy5AGkY9N
	wOoCAkVQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Ddz-0000000AyxH-2BiW;
	Wed, 11 Mar 2026 07:06:11 +0000
Received: from [212.243.42.10] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w0Ddv-0000000AyoR-2IIP;
	Wed, 11 Mar 2026 07:06:07 +0000
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
Subject: [PATCH 07/27] xor: split xor.h
Date: Wed, 11 Mar 2026 08:03:39 +0100
Message-ID: <20260311070416.972667-8-hch@lst.de>
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

Keep xor.h for the public API, and split the struct xor_block_template
definition that is only needed by the xor.ko core and
architecture-specific optimizations into a separate xor_impl.h header.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/arm/lib/xor-neon.c       |  1 +
 arch/arm64/lib/xor-neon.c     |  1 +
 arch/s390/lib/xor.c           |  2 +-
 include/linux/raid/xor.h      | 22 +---------------------
 include/linux/raid/xor_impl.h | 25 +++++++++++++++++++++++++
 lib/raid/xor/xor-core.c       |  1 +
 6 files changed, 30 insertions(+), 22 deletions(-)
 create mode 100644 include/linux/raid/xor_impl.h

diff --git a/arch/arm/lib/xor-neon.c b/arch/arm/lib/xor-neon.c
index cf57fca97908..282980b9bf2a 100644
--- a/arch/arm/lib/xor-neon.c
+++ b/arch/arm/lib/xor-neon.c
@@ -6,6 +6,7 @@
  */
 
 #include <linux/raid/xor.h>
+#include <linux/raid/xor_impl.h>
 #include <linux/module.h>
 
 MODULE_DESCRIPTION("NEON accelerated XOR implementation");
diff --git a/arch/arm64/lib/xor-neon.c b/arch/arm64/lib/xor-neon.c
index 8fffebfa17b2..351aba92d932 100644
--- a/arch/arm64/lib/xor-neon.c
+++ b/arch/arm64/lib/xor-neon.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/raid/xor.h>
+#include <linux/raid/xor_impl.h>
 #include <linux/module.h>
 #include <asm/neon-intrinsics.h>
 
diff --git a/arch/s390/lib/xor.c b/arch/s390/lib/xor.c
index 5363e4c2462d..3bbe21b40e66 100644
--- a/arch/s390/lib/xor.c
+++ b/arch/s390/lib/xor.c
@@ -8,7 +8,7 @@
 
 #include <linux/types.h>
 #include <linux/export.h>
-#include <linux/raid/xor.h>
+#include <linux/raid/xor_impl.h>
 #include <asm/xor.h>
 
 static void xor_xc_2(unsigned long bytes, unsigned long * __restrict p1,
diff --git a/include/linux/raid/xor.h b/include/linux/raid/xor.h
index 51b811b62322..02bda8d99534 100644
--- a/include/linux/raid/xor.h
+++ b/include/linux/raid/xor.h
@@ -7,24 +7,4 @@
 extern void xor_blocks(unsigned int count, unsigned int bytes,
 	void *dest, void **srcs);
 
-struct xor_block_template {
-        struct xor_block_template *next;
-        const char *name;
-        int speed;
-	void (*do_2)(unsigned long, unsigned long * __restrict,
-		     const unsigned long * __restrict);
-	void (*do_3)(unsigned long, unsigned long * __restrict,
-		     const unsigned long * __restrict,
-		     const unsigned long * __restrict);
-	void (*do_4)(unsigned long, unsigned long * __restrict,
-		     const unsigned long * __restrict,
-		     const unsigned long * __restrict,
-		     const unsigned long * __restrict);
-	void (*do_5)(unsigned long, unsigned long * __restrict,
-		     const unsigned long * __restrict,
-		     const unsigned long * __restrict,
-		     const unsigned long * __restrict,
-		     const unsigned long * __restrict);
-};
-
-#endif
+#endif /* _XOR_H */
diff --git a/include/linux/raid/xor_impl.h b/include/linux/raid/xor_impl.h
new file mode 100644
index 000000000000..a1890cd66812
--- /dev/null
+++ b/include/linux/raid/xor_impl.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _XOR_IMPL_H
+#define _XOR_IMPL_H
+
+struct xor_block_template {
+	struct xor_block_template *next;
+	const char *name;
+	int speed;
+	void (*do_2)(unsigned long, unsigned long * __restrict,
+		     const unsigned long * __restrict);
+	void (*do_3)(unsigned long, unsigned long * __restrict,
+		     const unsigned long * __restrict,
+		     const unsigned long * __restrict);
+	void (*do_4)(unsigned long, unsigned long * __restrict,
+		     const unsigned long * __restrict,
+		     const unsigned long * __restrict,
+		     const unsigned long * __restrict);
+	void (*do_5)(unsigned long, unsigned long * __restrict,
+		     const unsigned long * __restrict,
+		     const unsigned long * __restrict,
+		     const unsigned long * __restrict,
+		     const unsigned long * __restrict);
+};
+
+#endif /* _XOR_IMPL_H */
diff --git a/lib/raid/xor/xor-core.c b/lib/raid/xor/xor-core.c
index 88667a89b75b..58f2d0c16420 100644
--- a/lib/raid/xor/xor-core.c
+++ b/lib/raid/xor/xor-core.c
@@ -9,6 +9,7 @@
 #include <linux/module.h>
 #include <linux/gfp.h>
 #include <linux/raid/xor.h>
+#include <linux/raid/xor_impl.h>
 #include <linux/jiffies.h>
 #include <linux/preempt.h>
 #include <asm/xor.h>
-- 
2.47.3


