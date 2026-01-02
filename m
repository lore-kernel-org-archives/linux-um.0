Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9F7E9410B
	for <linux-um@archiver.kernel.org>; Fri,  2 Jan 2026 07:02:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9pBPAmCex859p6JrPopJFcFxfKxR6uVnsR3JS1C8yI=; b=SL0bN9Kpo6oUGPF8SEuEC9wj98
	W53Lkm4OsOBVyUg4qUvFd3dq8QDhB9UbcVSXh4xCgRyLfCHlelcMHFYXbo1s2WokcG/HNn15a95L2
	E8s5nA/8m3N0+NX7btGS4G58L+i6cSZ6eLNEpmEYK+OlGh+JmgHa2NSGVpOJyamH3ARxM8selACLa
	dWTBSQuKe0F65MDPx8i/dTXZ2UZcBobB9ax7jYDInMcmDdEn7J+8cj4z8k91LXfL/nCvOWY9m/FKI
	Esz6GfIHPigZXxz7FlgLJdg4qtxPRbjowECah0JOrSFZCXHH8EVAYyQyO25ktlDG6/WmFKDgKtiCK
	ggQ/aUag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbZBW-00000007tdB-0F7I;
	Fri, 02 Jan 2026 07:02:54 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbZBQ-00000007tZA-3vVD;
	Fri, 02 Jan 2026 07:02:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6D3EE43396;
	Fri,  2 Jan 2026 07:02:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72BECC116D0;
	Fri,  2 Jan 2026 07:02:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767337368;
	bh=es+FUCZqCY2a3nIkrdLdpQV/rxxtDtuUgA954vVF+nw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=dFiMKhjqyf+PfkCOMts11njbpfGwqQefsvvZvfGAgXrmmyP02aiCpmX8wvtgXmjh2
	 JGcds5OsjQOsg8MVVqzy4zBA255m75qdXO1si07Ky/r2zB4hmu01u39hsqm0ewanZN
	 LSjxiEoJP0frsXlr6bA5f68JZ0ShXcr0PT6HvGZ0JX23uSXRxwIaNc/T1RSWoD84TE
	 DI6A7tJWLRiX8jI6Ss9SIxVHDO7YvahppzQZFaJQT4eHA/41c1EOHZ979ycVclWE56
	 dcJdXB2lF+KLdNfaYQTsmd0q+sw9v0hQGXGsrYx/8NwnWCiyzXxykXpWhWDh/oVgy4
	 FJ6eCa9gtAd0g==
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
Subject: [PATCH v2 10/28] mips: introduce arch_zone_limits_init()
Date: Fri,  2 Jan 2026 08:59:46 +0200
Message-ID: <20260102070005.65328-11-rppt@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260102070005.65328-1-rppt@kernel.org>
References: <20260102070005.65328-1-rppt@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260101_230249_033574_B6FA3C58 
X-CRM114-Status: GOOD (  13.54  )
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
 arch/mips/loongson64/numa.c      |  9 +++++++--
 arch/mips/mm/init.c              | 14 +++++++++-----
 arch/mips/sgi-ip27/ip27-memory.c |  7 ++++++-
 3 files changed, 22 insertions(+), 8 deletions(-)

diff --git a/arch/mips/loongson64/numa.c b/arch/mips/loongson64/numa.c
index 95d5f553ce19..f72a58f87878 100644
--- a/arch/mips/loongson64/numa.c
+++ b/arch/mips/loongson64/numa.c
@@ -154,13 +154,18 @@ static __init void prom_meminit(void)
 	}
 }
 
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	max_zone_pfns[ZONE_DMA32] = MAX_DMA32_PFN;
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+}
+
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
 	pagetable_init();
-	zones_size[ZONE_DMA32] = MAX_DMA32_PFN;
-	zones_size[ZONE_NORMAL] = max_low_pfn;
+	arch_zone_limits_init(zones_size);
 	free_area_init(zones_size);
 }
 
diff --git a/arch/mips/mm/init.c b/arch/mips/mm/init.c
index a673d3d68254..ab08249cfede 100644
--- a/arch/mips/mm/init.c
+++ b/arch/mips/mm/init.c
@@ -394,12 +394,8 @@ void maar_init(void)
 }
 
 #ifndef CONFIG_NUMA
-void __init paging_init(void)
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
 {
-	unsigned long max_zone_pfns[MAX_NR_ZONES];
-
-	pagetable_init();
-
 #ifdef CONFIG_ZONE_DMA
 	max_zone_pfns[ZONE_DMA] = MAX_DMA_PFN;
 #endif
@@ -417,7 +413,15 @@ void __init paging_init(void)
 		max_zone_pfns[ZONE_HIGHMEM] = max_low_pfn;
 	}
 #endif
+}
+
+void __init paging_init(void)
+{
+	unsigned long max_zone_pfns[MAX_NR_ZONES];
+
+	pagetable_init();
 
+	arch_zone_limits_init(max_zone_pfns);
 	free_area_init(max_zone_pfns);
 }
 
diff --git a/arch/mips/sgi-ip27/ip27-memory.c b/arch/mips/sgi-ip27/ip27-memory.c
index 2b3e46e2e607..babeb0e07687 100644
--- a/arch/mips/sgi-ip27/ip27-memory.c
+++ b/arch/mips/sgi-ip27/ip27-memory.c
@@ -406,11 +406,16 @@ void __init prom_meminit(void)
 	}
 }
 
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
+}
+
 void __init paging_init(void)
 {
 	unsigned long zones_size[MAX_NR_ZONES] = {0, };
 
 	pagetable_init();
-	zones_size[ZONE_NORMAL] = max_low_pfn;
+	arch_zone_limits_init(zones_size);
 	free_area_init(zones_size);
 }
-- 
2.51.0


