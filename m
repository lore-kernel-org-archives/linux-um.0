Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67D4AE9272A
	for <linux-um@archiver.kernel.org>; Sun, 28 Dec 2025 12:41:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AP0KxVQKlHlLZzBbkI5QvPGqFtczppI+IyG+yF+hUQQ=; b=ZxaZ+giozie1+xmPVTDh1/Pwxe
	k+kV5T8JsZ6A4/GV8mnHW6cjUR8r+c3jsDZFORk3cxMmNZRBNHPRjmcXcgQ01NdombTN6MjeZCTxs
	qz6a4BGwjegedcQaRmjydZhEaLRD0xtVGdaPwQ4b2OrQSTAkWfWniv9Qj7KPysL687FSn/y2j925O
	HR+4dFYyPN3NRY4BoZgQSeKUxi5qdD8K+82mdHRvT2grv9S4RJCHUyp//nccCUIsWCmCxhLHD9LDO
	OAX6oMG1RHUqTdQkPvk7oLlWl5d03Dc6AAiFy9lwR/29z8R4J21Up3O4OH7SqgT70WtnI+kctxU+O
	/A88vZbw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZq5Z-00000002hhd-0Zuc;
	Sun, 28 Dec 2025 12:41:37 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZq5W-00000002hfV-1lsg;
	Sun, 28 Dec 2025 12:41:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id BA2ED60055;
	Sun, 28 Dec 2025 12:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4327C4CEFB;
	Sun, 28 Dec 2025 12:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766925693;
	bh=kW7jFO+a0HNCHZzYrQL1gmYZj5c/PO8Gu3w/sSZkgeU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FfgQ/vc3RZBoItL5pKlOQ6mJvnoQsAGeqpPpdU7zRYHFQGex7i+QdZtMRI3l5Rllw
	 ZrLFvQk9qtWsq6RxUpeOr8prh4q/CdhYAqVHvRtRwVjHkO43GX/qFXaS1qVYcGb1FD
	 qzL2dObl3ki9QvEKg33KBxrNT/j6nPYcZooual0AXhe3vFD8CcA+OOiUuJx0mf1OxA
	 WVLdUC1rJWxouQK5crZX45MUNiK05jCNTvxIYRAmvOUlz7ERTG0JunqJxBP2amG0TG
	 y7+4AV3PANzMZAHRGKed6SN43VGK8AUvIHNJN3y7KKpPCFNAO3P3vfptV4kyFay/sY
	 pPa+fs43iWi4A==
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>,
	Brian Cain <bcain@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>,
	Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>,
	Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>,
	Michal Simek <monstr@monstr.eu>,
	Mike Rapoport <rppt@kernel.org>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>,
	Will Deacon <will@kernel.org>,
	x86@kernel.org,
	linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org,
	linux-cxl@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-hexagon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org,
	linux-mm@kvack.org,
	linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org,
	linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org,
	loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org
Subject: [PATCH 05/28] csky: introduce arch_zone_limits_init()
Date: Sun, 28 Dec 2025 14:39:35 +0200
Message-ID: <20251228124001.3624742-6-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228124001.3624742-1-rppt@kernel.org>
References: <20251228124001.3624742-1-rppt@kernel.org>
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

From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>

Move calculations of zone limits to a dedicated arch_zone_limits_init()
function.

Later MM core will use this function as an architecture specific callback
during nodes and zones initialization and thus there won't be a need to
call free_area_init() from every architecture.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/csky/kernel/setup.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/arch/csky/kernel/setup.c b/arch/csky/kernel/setup.c
index e0d6ca86ea8c..8968815d93e6 100644
--- a/arch/csky/kernel/setup.c
+++ b/arch/csky/kernel/setup.c
@@ -51,6 +51,14 @@ static void __init setup_initrd(void)
 }
 #endif
 
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+#ifdef CONFIG_HIGHMEM
+	max_zone_pfns[ZONE_HIGHMEM] = max_pfn;
+#endif
+}
+
 static void __init csky_memblock_init(void)
 {
 	unsigned long lowmem_size = PFN_DOWN(LOWMEM_LIMIT - PHYS_OFFSET_OFFSET);
@@ -83,12 +91,9 @@ static void __init csky_memblock_init(void)
 	setup_initrd();
 #endif
 
-	max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
-
 	mmu_init(min_low_pfn, max_low_pfn);
 
 #ifdef CONFIG_HIGHMEM
-	max_zone_pfn[ZONE_HIGHMEM] = max_pfn;
 
 	highstart_pfn = max_low_pfn;
 	highend_pfn   = max_pfn;
@@ -97,6 +102,7 @@ static void __init csky_memblock_init(void)
 
 	dma_contiguous_reserve(0);
 
+	arch_zone_limits_init(max_zone_pfn);
 	free_area_init(max_zone_pfn);
 }
 
-- 
2.51.0


