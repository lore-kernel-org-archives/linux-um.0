Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72305E92725
	for <linux-um@archiver.kernel.org>; Sun, 28 Dec 2025 12:44:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XCeW4b5bx6EOK5QjFUW3uRjrRx8sG0IrVuSe7S4JU8I=; b=mhgY6P+l+K5T/Nh4FX+T5BVvQ/
	WYTt2lY9QhEb/7OCcsPN/WNBhfvu+9aFJiMw3e2bulNF86BJ/c8P4MR1/ABWU61ObUSXwkHzb+MC9
	p/5PqA0S34sxVcaovI5ROafrzgNdQkWAnwL/Sr6dTX+7mKknUDTbFGUzCricXB8xIfhOOHG3Prmcc
	RZBdPNly1FNaQvIfMUla3cgarOcKj2O7tis3crquMccED+qBNRoyFHWjnoKV8sFcBjjvIPChLUcbI
	yKeMrT0RVroE4t/VKRJzZVqM5e5tqKIh33u/mTj7nvnJsRkyfs4A8Yri6jdh+q3xywc+H2FmUdCQ7
	6CzDsxtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZq8Z-00000002jS2-0az0;
	Sun, 28 Dec 2025 12:44:43 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vZq8S-00000002jOe-2At1;
	Sun, 28 Dec 2025 12:44:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1625B4013A;
	Sun, 28 Dec 2025 12:44:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6A573C113D0;
	Sun, 28 Dec 2025 12:44:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766925875;
	bh=oB6QCqWGlUcVzO7N8KoxEGaOaNJpg/wuZYHeNsCpdgU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=GEARsU2p+EZgFjCyr9uyzZ8hj2re6eD/C923QhGvMMzHuSCkKZytNmeZxflu9jkn+
	 Ppetcw1V5leg6VH3ggoT2pItHYZTxfo/oyIWHLFsGUZ8jPgjmd2ugFiVcvcbuH43oy
	 c94di+9wYXVA02fLVIEPud2jr2wZF6CazDTX4rNh22wu5gpZ7KtiuBI4xhIBXDOmSL
	 RRif8oZtzD3AqNLNQidA7D3P3awFsxGTATE8jB0P7elm42vJSPqaqhGg1UJnjG1bnj
	 3RnJniQjMgOHBMWKI7HkIR9dVwVy/YdaTbCkFX4tkcz8jitWxQWcWWx91604v63IVd
	 Ng+6vXu0vT9NQ==
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
Subject: [PATCH 18/28] sparc: introduce arch_zone_limits_init()
Date: Sun, 28 Dec 2025 14:39:48 +0200
Message-ID: <20251228124001.3624742-19-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251228124001.3624742-1-rppt@kernel.org>
References: <20251228124001.3624742-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251228_044436_693030_54267542 
X-CRM114-Status: GOOD (  11.98  )
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
 arch/sparc/mm/init_64.c |  6 ++++++
 arch/sparc/mm/srmmu.c   | 12 ++++++++----
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
index df9f7c444c39..fbaad449dfc9 100644
--- a/arch/sparc/mm/init_64.c
+++ b/arch/sparc/mm/init_64.c
@@ -2279,6 +2279,11 @@ static void __init reduce_memory(phys_addr_t limit_ram)
 	memblock_enforce_memory_limit(limit_ram);
 }
 
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	max_zone_pfns[ZONE_NORMAL] = last_valid_pfn;
+}
+
 void __init paging_init(void)
 {
 	unsigned long end_pfn, shift, phys_base;
@@ -2461,6 +2466,7 @@ void __init paging_init(void)
 
 		max_zone_pfns[ZONE_NORMAL] = end_pfn;
 
+		arch_zone_limits_init(max_zone_pfns);
 		free_area_init(max_zone_pfns);
 	}
 
diff --git a/arch/sparc/mm/srmmu.c b/arch/sparc/mm/srmmu.c
index f8fb4911d360..81e90151db90 100644
--- a/arch/sparc/mm/srmmu.c
+++ b/arch/sparc/mm/srmmu.c
@@ -884,6 +884,13 @@ static void __init map_kernel(void)
 
 void (*poke_srmmu)(void) = NULL;
 
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	max_zone_pfns[ZONE_DMA] = max_low_pfn;
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+	max_zone_pfns[ZONE_HIGHMEM] = highend_pfn;
+}
+
 void __init srmmu_paging_init(void)
 {
 	int i;
@@ -967,10 +974,7 @@ void __init srmmu_paging_init(void)
 	{
 		unsigned long max_zone_pfn[MAX_NR_ZONES] = { 0 };
 
-		max_zone_pfn[ZONE_DMA] = max_low_pfn;
-		max_zone_pfn[ZONE_NORMAL] = max_low_pfn;
-		max_zone_pfn[ZONE_HIGHMEM] = highend_pfn;
-
+		arch_zone_limits_init(max_zone_pfn);
 		free_area_init(max_zone_pfn);
 	}
 }
-- 
2.51.0


