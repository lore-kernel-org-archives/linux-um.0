Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14142D2502E
	for <linux-um@archiver.kernel.org>; Sun, 11 Jan 2026 08:25:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=O8kExoTLliZANVxlSa71PKoJV58jVF11IqoI4S/DqkA=; b=0sPqi0hp7myzBCGSbF9FnEvwua
	/1keNQBRZOkorXEKTUDTWYp2Qpx3LENEIiCwk45YQo8OyHtDP+4TAmaJybMBX3qm+ky18RJ4tDpCQ
	HZsYNQ468B9V22d1ZEcixAvRRsLNOH8A7d3tsO7jcRGJshRr5vdBiKrsNpymp/GN2Cj7jcuTnhHA6
	1gOJTwZWKMd2GKbny+yG+VK5yWrzm6NIJ5tzeJ2s1B0CakDNcGrmVJ4fNDsajZFBfYKGW2GBI+gfv
	Z+feB7oq2xecrMEwJfspRmZUVMWshdOdx7ZOkanPHEN0Kqj45rxzxKXErcdOixc0E3rXwc2wfqfWZ
	gb2F1AHg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqlb-0000000408I-3Q9W;
	Sun, 11 Jan 2026 08:25:43 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqlZ-0000000406v-3PrN;
	Sun, 11 Jan 2026 08:25:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 28AAD60121;
	Sun, 11 Jan 2026 08:25:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E397C4CEF7;
	Sun, 11 Jan 2026 08:25:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768119940;
	bh=hFJveYfaCrIw0+iDVEP3vQL9fd/XBHyX+JYd2Rm0RhA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ejea3zjxcNk55gNO0bbLBhxe4NsBzp6h2dbs/uOwmj7bbdTrm/aLn1CsdSYQKFNyy
	 MIgW724HlUOkhiogpK1xlqx1PfJ9vKR44ePzsM2MgEMnwLOTLYReW2B1UTZtcIh8qV
	 HscmT3ORaZ3YNpVrsvYWLb9xhAvf3GwE+1yTZ8bLpTWXBeJ/ZCly/j0T5NtIzfIx6y
	 1wPtCTY7OtWi8bK+mO5MGkaG9OvtDG3md54oVLJwaZjJezEVKKVPB/mpNay0l7xI6c
	 OP0eAip/WOsG1W062M/zkogcxJrAkYPvW6p7Fzk4WPU8E58buvamLYO9CoxJxr46de
	 UnewUkKtu81TQ==
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
	Klara Modin <klarasmodin@gmail.com>,
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
	Ritesh Harjani <ritesh.list@gmail.com>,
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
Subject: [PATCH v3 17/29] s390: introduce arch_zone_limits_init()
Date: Sun, 11 Jan 2026 10:20:51 +0200
Message-ID: <20260111082105.290734-18-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260111082105.290734-1-rppt@kernel.org>
References: <20260111082105.290734-1-rppt@kernel.org>
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
 arch/s390/mm/init.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index e4953453d254..1c11ad84dddb 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -86,6 +86,12 @@ static void __init setup_zero_pages(void)
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
 
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	max_zone_pfns[ZONE_DMA] = virt_to_pfn(MAX_DMA_ADDRESS);
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+}
+
 /*
  * paging_init() sets up the page tables
  */
@@ -97,8 +103,7 @@ void __init paging_init(void)
 	sparse_init();
 	zone_dma_limit = DMA_BIT_MASK(31);
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
-	max_zone_pfns[ZONE_DMA] = virt_to_pfn(MAX_DMA_ADDRESS);
-	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+	arch_zone_limits_init(max_zone_pfns);
 	free_area_init(max_zone_pfns);
 }
 
-- 
2.51.0


