Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EEC6C28B24
	for <linux-um@archiver.kernel.org>; Thu,  6 Mar 2025 18:52:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+ade8eAKcDIFtXQJgshQWuspJvzYLQoG9wyU5NjeFQQ=; b=fGRvVbDbVWESgIdE/1wPN8org2
	zgRAhKSjC7g9PDJpotCBcLcvZAEMiqayEDd0WHIhDPhdEXc1igM+iV3e9Rs3GHKWAN68B6MpnDoWy
	HBAi5WJ5MKG2X5HPjQGknPdZYK4mYt0Oo56dDuXta5dfgIWQ9Gi+RmyyQgBiF/WMs7tJo7mgXqazr
	j4qY9yYd8vA+pDGTXiaaEqQR4L50daNIsjY0CiiUPxNutTDShpcEslZLqWRW3IRWr8cTH2HIkbZXh
	GhuEvHrDBub4eeWj1lw5gTJGFn69J7ar+ZP3ujJsIjkHgYUnSbjVe0uCWJgvJMpnVZxtBu8SComl6
	pMqeu97Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGKP-0000000Bumu-1E9m;
	Thu, 06 Mar 2025 18:52:17 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tqGKK-0000000Buih-3Gy2;
	Thu, 06 Mar 2025 18:52:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ECBF95C58B7;
	Thu,  6 Mar 2025 18:49:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5485C4CEEC;
	Thu,  6 Mar 2025 18:51:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741287131;
	bh=8AVATLG9lzmcQcx5E69jKjTsUN+LZvQn92lo4/jx/sQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=jV0L4MxA7ZLOPXJ7CzvIBhifnvQ3cLfWLbGX9Kpq+TJV+I4pYEortTLjsgEQ+JgOz
	 MJeD/6kqeK3kbbbLebIrILdKUS+MINmZ+/B/sNOxLIGg7XbVwZV42EgAZnZAp6YA9n
	 29WDsIsPmNqboWrzBZPQWiBq4xZoUqUHc5X/w6ZGtfzGGa8bFcwxmZypQhUi8SVeUt
	 4+S4ZR8z1jIcZBlvxst+95F7MqZZIvNp+reY2KbX5iWIXdOVrbfew191sYutRBEayR
	 2jUlJelZWwvqGeLBlQ86aq/GxBuU3JetL31MovldgywY/67riRZKdTJu068ZWyNYvD
	 NqjbY0mINjozA==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>,
	Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>,
	linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org,
	linux-mm@kvack.org,
	x86@kernel.org
Subject: [PATCH 02/13] csky: move setup_initrd() to setup.c
Date: Thu,  6 Mar 2025 20:51:12 +0200
Message-ID: <20250306185124.3147510-3-rppt@kernel.org>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250306185124.3147510-1-rppt@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250306_105212_897086_9AAFBA89 
X-CRM114-Status: GOOD (  15.24  )
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Memory used by initrd should be reserved as soon as possible before
there any memblock allocations that might overwrite that memory.

This will also help with pulling out memblock_free_all() to the generic
code and reducing code duplication in arch::mem_init().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/csky/kernel/setup.c | 43 ++++++++++++++++++++++++++++++++++++++++
 arch/csky/mm/init.c      | 43 ----------------------------------------
 2 files changed, 43 insertions(+), 43 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index fe715b707fd0..e0d6ca86ea8c 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -12,6 +12,45 @@
 #include <asm/mmu_context.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_BLK_DEV_INITRD
+static void __init setup_initrd(void)
+{
+	unsigned long size;
+
+	if (initrd_start >= initrd_end) {
+		pr_err("initrd not found or empty");
+		goto disable;
+	}
+
+	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
+		pr_err("initrd extends beyond end of memory");
+		goto disable;
+	}
+
+	size = initrd_end - initrd_start;
+
+	if (memblock_is_region_reserved(__pa(initrd_start), size)) {
+		pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory region",
+		       __pa(initrd_start), size);
+		goto disable;
+	}
+
+	memblock_reserve(__pa(initrd_start), size);
+
+	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
+		(void *)(initrd_start), size);
+
+	initrd_below_start_ok = 1;
+
+	return;
+
+disable:
+	initrd_start = initrd_end = 0;
+
+	pr_err(" - disabling initrd\n");
+}
+#endif
+
 static void __init csky_memblock_init(void)
 {
 	unsigned long lowmem_size = PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
@@ -40,6 +79,10 @@ static void __init csky_memblock_init(void)
 		max_low_pfn = min_low_pfn + sseg_size;
 	}
 
+#ifdef CONFIG_BLK_DEV_INITRD
+	setup_initrd();
+#endif
+
 	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
 
 	mmu_init(min_low_pfn, max_low_pfn);
diff --git a/arch/csky/mm/init.c b/arch/csky/mm/init.c
index bde7cabd23df..ab51acbc19b2 100644
--- a/arch/csky/mm/init.c
+++ b/arch/csky/mm/init.c
@@ -42,45 +42,6 @@ unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)]
 						__page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-static void __init setup_initrd(void)
-{
-	unsigned long size;
-
-	if (initrd_start >= initrd_end) {
-		pr_err("initrd not found or empty");
-		goto disable;
-	}
-
-	if (__pa(initrd_end) > PFN_PHYS(max_low_pfn)) {
-		pr_err("initrd extends beyond end of memory");
-		goto disable;
-	}
-
-	size = initrd_end - initrd_start;
-
-	if (memblock_is_region_reserved(__pa(initrd_start), size)) {
-		pr_err("INITRD: 0x%08lx+0x%08lx overlaps in-use memory region",
-		       __pa(initrd_start), size);
-		goto disable;
-	}
-
-	memblock_reserve(__pa(initrd_start), size);
-
-	pr_info("Initial ramdisk at: 0x%p (%lu bytes)\n",
-		(void *)(initrd_start), size);
-
-	initrd_below_start_ok = 1;
-
-	return;
-
-disable:
-	initrd_start = initrd_end = 0;
-
-	pr_err(" - disabling initrd\n");
-}
-#endif
-
 void __init mem_init(void)
 {
 #ifdef CONFIG_HIGHMEM
@@ -92,10 +53,6 @@ void __init mem_init(void)
 #endif
 	high_memory = (void *) __va(max_low_pfn << PAGE_SHIFT);
 
-#ifdef CONFIG_BLK_DEV_INITRD
-	setup_initrd();
-#endif
-
 	memblock_free_all();
 
 #ifdef CONFIG_HIGHMEM
-- 
2.47.2


