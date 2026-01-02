Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04B47E9410B
	for <linux-um@archiver.kernel.org>; Fri,  2 Jan 2026 07:00:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hMSeghU9mFb/iSGNjAJ2/WETrT3nayTRWjrK9prgUyE=; b=NlPmuEv9vl6ZeXLIOkoE7kGVKk
	us/lMV6pYeqEc729IsRCWe8QQHxoJ9nx3knBy7vzb0fxGiMCA2fuVjF84BvfX3i9gzkQQR3p0vLlP
	UaKyGg+0cm80WQMY4IcN2sdiVpdfRvikzQcrxKMbX/RmaUj9tF5okECu3Yl+BZ2AF2afJpKR45/kt
	l6u0w/P+tqFzpFlYIecmMu5IqFqaShXPG7AlSStv7DFFBI74MzHfz1sDObutfXmv7s4CU+4NHwFP1
	gH6X2xK+9CpizSqsI/FzgL/jLN/2wOn2+9LIsdhxDiE/QCCDTeJWJ135kQlDn0KW/3skQfwa/hGQI
	UE8gr67g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbZ9S-00000007ryS-38Cd;
	Fri, 02 Jan 2026 07:00:46 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbZ9N-00000007rwZ-0S5w;
	Fri, 02 Jan 2026 07:00:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 22B9160125;
	Fri,  2 Jan 2026 07:00:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1F09C116D0;
	Fri,  2 Jan 2026 07:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767337238;
	bh=KgO7SaOs49km6xau9XjjDmzydPHNaHbDsqRu17wGsEs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ApU/C+wNb4idNTK1zz1rLmf7qMnQiTC69e5uyInO+Kw/+8zgij+cWb8B1RufqXU26
	 1wwAkDpliKwcZM980+Xgpsrz9pj1f3b4c4DAWujjPkDCfQWq4BkvD/f8FippBrzSQO
	 KbiqOWCGO+PDtGqsU79y82rc/RtNyo6RJJXmHSxwe5v1EVVeniyX4YJ8VYClntcefc
	 6bNEl/xqs/e7MJSfTN3oSKRvHYgLidvtUF3HM0HkqeXsKG9V3CNaMeRVAp10jZFrHR
	 a2+yXy2rd/ds/cJTsRv4zQKRp7NOtOqrhkbdkQHjNFRSNKPR8+JeTwPjQchjqqMdSB
	 O39qW/PrqZb6w==
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
Subject: [PATCH v2 01/28] alpha: introduce arch_zone_limits_init()
Date: Fri,  2 Jan 2026 08:59:37 +0200
Message-ID: <20260102070005.65328-2-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102070005.65328-1-rppt@kernel.org>
References: <20260102070005.65328-1-rppt@kernel.org>
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
Acked-by: Magnus Lindholm <linmag7@gmail.com>
---
 arch/alpha/mm/init.c | 15 ++++++++++-----
 include/linux/mm.h   |  1 +
 2 files changed, 11 insertions(+), 5 deletions(-)

diff --git a/arch/alpha/mm/init.c b/arch/alpha/mm/init.c
index 4c5ab9cd8a0a..cd0cb1abde5f 100644
--- a/arch/alpha/mm/init.c
+++ b/arch/alpha/mm/init.c
@@ -208,12 +208,8 @@ callback_init(void * kernel_end)
 	return kernel_end;
 }
 
-/*
- * paging_init() sets up the memory map.
- */
-void __init paging_init(void)
+void __init arch_zone_limits_init(unsigned long *max_zone_pfn)
 {
-	unsigned long max_zone_pfn[MAX_NR_ZONES] = {0, };
 	unsigned long dma_pfn;
 
 	dma_pfn = virt_to_phys((char *)MAX_DMA_ADDRESS) >> PAGE_SHIFT;
@@ -221,8 +217,17 @@ void __init paging_init(void)
 
 	max_zone_pfn[ZONE_DMA] = dma_pfn;
 	max_zone_pfn[ZONE_NORMAL] = max_pfn;
+}
+
+/*
+ * paging_init() sets up the memory map.
+ */
+void __init paging_init(void)
+{
+	unsigned long max_zone_pfn[MAX_NR_ZONES] = {0, };
 
 	/* Initialize mem_map[].  */
+	arch_zone_limits_init(max_zone_pfn);
 	free_area_init(max_zone_pfn);
 
 	/* Initialize the kernel's ZERO_PGE. */
diff --git a/include/linux/mm.h b/include/linux/mm.h
index 15076261d0c2..628c0e0ac313 100644
--- a/include/linux/mm.h
+++ b/include/linux/mm.h
@@ -3552,6 +3552,7 @@ static inline unsigned long get_num_physpages(void)
  * free_area_init(max_zone_pfns);
  */
 void free_area_init(unsigned long *max_zone_pfn);
+void arch_zone_limits_init(unsigned long *max_zone_pfn);
 unsigned long node_map_pfn_alignment(void);
 extern unsigned long absent_pages_in_range(unsigned long start_pfn,
 						unsigned long end_pfn);
-- 
2.51.0


