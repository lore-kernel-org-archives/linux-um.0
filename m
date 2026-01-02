Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C2BFA372B
	for <linux-um@archiver.kernel.org>; Fri,  2 Jan 2026 07:01:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pXj0Z2NgAtnlunEa9AvDDLLh6y0q3hS/njeAcboUK1o=; b=sU5hcZ1s7cPaFFDjd1zD5iPPUh
	5PBAiMx4SfnTXWpWwU5hewyAyOhW+AU5tjWOwfuOnKDn3joacMx6yelkX3zE7b6xUhatcRwJ7xq9N
	6IXFyEJct1HlzrELyVc5BJ9L8ExxgH7kW0F+nmDzmvzDdpJhpuLpLNrfwnQ+dnLmOyXjzUlDsjroG
	D3YcN4D8mHNm9QOWdgvo+L1BHwIcaJZ0qI/38G6Jm43n62zvY8DYOLTVOJvOB8MqjkVyphEZAIXl5
	DOPvSycVD19AXoPJqi17236vT0qOurDYn/Xv99ckDsu8C7a1vv6/OUH6VT3Mp0jpXYzyecD3DZpkS
	UYt09WKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbZA7-00000007sNu-2OpK;
	Fri, 02 Jan 2026 07:01:27 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbZA2-00000007sJC-23zf;
	Fri, 02 Jan 2026 07:01:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 063C7439EC;
	Fri,  2 Jan 2026 07:01:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E256C116B1;
	Fri,  2 Jan 2026 07:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767337281;
	bh=djQarGwsnsMGImsgSQVJ5sD5jo+ZigjiDeQZakHIJZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=YfFbGR66VHayErTkQoIoUIc4G3/Zokhn15LvFAqjzKw26utOu1LBn48hs2H6HzNQq
	 enWDeSBA/K3oa8124S39Ky2QzRfQWKFy5skfNoCEkG9sz9vKEVoMX6gEHdOtbCXbst
	 YovEdBmAC4uGLaHGNAqP3BqXeZF+EKxoW8SDO9IcHD6qwesn+Gli/x6/TpHAYsUlrD
	 UCxGtUCULcfUxhXrs9KtImo/ip7nUbo9TQd43s1ekjsaSWhD1ejl+EXFJWf86KxJTp
	 WhffTvUE+ThhBNL4rEwUFZ6nXbB9jltND/rGE7Zw/xtewRIoZJM55k7N+y1oDTnXyg
	 wl/J8tjy8RWJQ==
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
Subject: [PATCH v2 04/28] arm64: introduce arch_zone_limits_init()
Date: Fri,  2 Jan 2026 08:59:40 +0200
Message-ID: <20260102070005.65328-5-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102070005.65328-1-rppt@kernel.org>
References: <20260102070005.65328-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260101_230122_596999_D5620B15 
X-CRM114-Status: GOOD (  15.30  )
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

While on it rename zone_sizes_init() to dma_limits_init() to better
reflect what that function does.

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/arm64/mm/init.c | 22 +++++++++++++++++-----
 1 file changed, 17 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/mm/init.c b/arch/arm64/mm/init.c
index 524d34a0e921..06815d34cc11 100644
--- a/arch/arm64/mm/init.c
+++ b/arch/arm64/mm/init.c
@@ -118,7 +118,21 @@ static phys_addr_t __init max_zone_phys(phys_addr_t zone_limit)
 	return min(zone_limit, memblock_end_of_DRAM() - 1) + 1;
 }
 
-static void __init zone_sizes_init(void)
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	phys_addr_t __maybe_unused dma32_phys_limit =
+		max_zone_phys(DMA_BIT_MASK(32));
+
+#ifdef CONFIG_ZONE_DMA
+	max_zone_pfns[ZONE_DMA] = PFN_DOWN(max_zone_phys(zone_dma_limit));
+#endif
+#ifdef CONFIG_ZONE_DMA32
+	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
+#endif
+	max_zone_pfns[ZONE_NORMAL] = max_pfn;
+}
+
+static void __init dma_limits_init(void)
 {
 	unsigned long max_zone_pfns[MAX_NR_ZONES]  = {0};
 	phys_addr_t __maybe_unused acpi_zone_dma_limit;
@@ -139,17 +153,15 @@ static void __init zone_sizes_init(void)
 	if (memblock_start_of_DRAM() < U32_MAX)
 		zone_dma_limit = min(zone_dma_limit, U32_MAX);
 	arm64_dma_phys_limit = max_zone_phys(zone_dma_limit);
-	max_zone_pfns[ZONE_DMA] = PFN_DOWN(arm64_dma_phys_limit);
 #endif
 #ifdef CONFIG_ZONE_DMA32
-	max_zone_pfns[ZONE_DMA32] = PFN_DOWN(dma32_phys_limit);
 	if (!arm64_dma_phys_limit)
 		arm64_dma_phys_limit = dma32_phys_limit;
 #endif
 	if (!arm64_dma_phys_limit)
 		arm64_dma_phys_limit = PHYS_MASK + 1;
-	max_zone_pfns[ZONE_NORMAL] = max_pfn;
 
+	arch_zone_limits_init(max_zone_pfns);
 	free_area_init(max_zone_pfns);
 }
 
@@ -319,7 +331,7 @@ void __init bootmem_init(void)
 	 * done after the fixed reservations
 	 */
 	sparse_init();
-	zone_sizes_init();
+	dma_limits_init();
 
 	/*
 	 * Reserve the CMA area after arm64_dma_phys_limit was initialised.
-- 
2.51.0


