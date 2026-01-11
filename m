Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34A15D25030
	for <linux-um@archiver.kernel.org>; Sun, 11 Jan 2026 08:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OJatOTiXEPNp/W52LlXUaW1EIsFN/BNV7MmBuJg1xZQ=; b=njo2sfGWNR9kh4bFaBU7ba8FW5
	ybDgE4I71OTCyeQ5NBx/JjP3G4trNmE4fA4+e4zHAKkAa8FJZJ75rbHun7XNjDwMqqfFIBooHbDH3
	fINj8fTxxesMoetu4BKiAl2n5A6AP2i9hBzwF61wZnw6bHz3/j9ZyiutxI6j/SWMjE5x6dHhDC5zi
	6I/cXXpFvpZKoF+ZBfDtm4IHVhsXy8G0WUbtoIF3bUjfr7u82z1LH1guG0i7qknc89XTsdJM/cajQ
	vdoybriy+DACha7+e4E0svXixaWlrbNtHUr+i+q1TMReLlPfhQl0RkJNBK/N+9lCuC9y3M/AlznLV
	QakWv6/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqje-00000003z2r-3jEW;
	Sun, 11 Jan 2026 08:23:42 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1veqjc-00000003z1R-3c4o;
	Sun, 11 Jan 2026 08:23:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 2B13F60122;
	Sun, 11 Jan 2026 08:23:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41A52C4CEF7;
	Sun, 11 Jan 2026 08:23:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768119819;
	bh=qGV3crV7vYfN1DCsmhF37VWmOXuApg3MmNmGXJVotqE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=fxotzz0k2KwCNp5gWh6cgEcUYH8E0BhaEKKXTdT2pUdivBywvI4T+qXqHxIZASCzv
	 1gDvHJBccnnzMaLHh7DBlSuaqDoWKk743xL7Oou07E6HNfZWS0zPTWLM4rs5OOguuo
	 GUAoxRtqYBs/qxZg0L3WKkhSzJKWvFzo7bwsjWtl2FO4jLNuQVwJYrxBJFZgt1ghP2
	 0kdmI1lYTpCBQUUqGWKOjqYFpVyhQUuN851OKnj8uy6V7dRr5kMl9pPSzvbRlL8i0d
	 I2u0gSIfQN5q/tcK4hqFkCMxPsVumAIFJF5vuk9i0Tc/89H6zAhA9SuDwA9yercaDb
	 vOxbNKYOZaN5w==
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
Subject: [PATCH v3 09/29] m68k: introduce arch_zone_limits_init()
Date: Sun, 11 Jan 2026 10:20:43 +0200
Message-ID: <20260111082105.290734-10-rppt@kernel.org>
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

Since all variants of m68k add all memory to ZONE_DMA, it is possible to
use unified implementation for arch_zone_limits_init() that sets the end
of ZONE_DMA to memblock_end_of_DRAM().

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/m68k/mm/init.c     | 7 ++++++-
 arch/m68k/mm/mcfmmu.c   | 2 +-
 arch/m68k/mm/motorola.c | 2 +-
 arch/m68k/mm/sun3mmu.c  | 2 +-
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/m68k/mm/init.c b/arch/m68k/mm/init.c
index 488411af1b3f..6b1d9d2434b5 100644
--- a/arch/m68k/mm/init.c
+++ b/arch/m68k/mm/init.c
@@ -40,6 +40,11 @@
 void *empty_zero_page;
 EXPORT_SYMBOL(empty_zero_page);
 
+void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
+{
+	max_zone_pfns[ZONE_DMA] = PFN_DOWN(memblock_end_of_DRAM());
+}
+
 #ifdef CONFIG_MMU
 
 int m68k_virt_to_node_shift;
@@ -69,7 +74,7 @@ void __init paging_init(void)
 	high_memory = (void *) end_mem;
 
 	empty_zero_page = memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
-	max_zone_pfn[ZONE_DMA] = end_mem >> PAGE_SHIFT;
+	arch_zone_limits_init(max_zone_pfn);
 	free_area_init(max_zone_pfn);
 }
 
diff --git a/arch/m68k/mm/mcfmmu.c b/arch/m68k/mm/mcfmmu.c
index 19a75029036c..24a6f7bbd1ce 100644
--- a/arch/m68k/mm/mcfmmu.c
+++ b/arch/m68k/mm/mcfmmu.c
@@ -73,7 +73,7 @@ void __init paging_init(void)
 	}
 
 	current->mm = NULL;
-	max_zone_pfn[ZONE_DMA] = PFN_DOWN(_ramend);
+	arch_zone_limits_init(max_zone_pfn);
 	free_area_init(max_zone_pfn);
 }
 
diff --git a/arch/m68k/mm/motorola.c b/arch/m68k/mm/motorola.c
index 62283bc2ed79..d6ccd23caf61 100644
--- a/arch/m68k/mm/motorola.c
+++ b/arch/m68k/mm/motorola.c
@@ -517,6 +517,6 @@ void __init paging_init(void)
 		if (node_present_pages(i))
 			node_set_state(i, N_NORMAL_MEMORY);
 
-	max_zone_pfn[ZONE_DMA] = memblock_end_of_DRAM();
+	arch_zone_limits_init(max_zone_pfn);
 	free_area_init(max_zone_pfn);
 }
diff --git a/arch/m68k/mm/sun3mmu.c b/arch/m68k/mm/sun3mmu.c
index 1ecf6bdd08bf..fdd69cc4240c 100644
--- a/arch/m68k/mm/sun3mmu.c
+++ b/arch/m68k/mm/sun3mmu.c
@@ -82,7 +82,7 @@ void __init paging_init(void)
 	current->mm = NULL;
 
 	/* memory sizing is a hack stolen from motorola.c..  hope it works for us */
-	max_zone_pfn[ZONE_DMA] = ((unsigned long)high_memory) >> PAGE_SHIFT;
+	arch_zone_limits_init(max_zone_pfn);
 
 	/* I really wish I knew why the following change made things better...  -- Sam */
 	free_area_init(max_zone_pfn);
-- 
2.51.0


