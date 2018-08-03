Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1flgEL-0006ao-4S
 for linux-um@lists.infradead.org; Fri, 03 Aug 2018 19:59:22 +0000
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w73Jx4nK071672
 for <linux-um@lists.infradead.org>; Fri, 3 Aug 2018 15:59:08 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kmtce7300-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linux-um@lists.infradead.org>; Fri, 03 Aug 2018 15:59:07 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linux-um@lists.infradead.org> from <rppt@linux.vnet.ibm.com>;
 Fri, 3 Aug 2018 20:59:03 +0100
From: Mike Rapoport <rppt@linux.vnet.ibm.com>
Subject: [PATCH 1/7] hexagon: switch to NO_BOOTMEM
Date: Fri,  3 Aug 2018 22:58:44 +0300
In-Reply-To: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
References: <1533326330-31677-1-git-send-email-rppt@linux.vnet.ibm.com>
Message-Id: <1533326330-31677-2-git-send-email-rppt@linux.vnet.ibm.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Mike Rapoport <rppt@linux.vnet.ibm.com>, linux-hexagon@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Michal Hocko <mhocko@kernel.org>, linux-mm@kvack.org, nios2-dev@lists.rocketboards.org, Richard Weinberger <richard@nod.at>, Ley Foon Tan <lftan@altera.com>, Richard Kuo <rkuo@codeaurora.org>, Guan Xuetao <gxt@pku.edu.cn>

This patch adds registration of the system memory with memblock, eliminates
bootmem initialization and converts early memory reservations from bootmem
to memblock.

Signed-off-by: Mike Rapoport <rppt@linux.vnet.ibm.com>
Acked-by: Richard Kuo <rkuo@codeaurora.org>
---
 arch/hexagon/Kconfig   |  3 +++
 arch/hexagon/mm/init.c | 20 ++++++++------------
 2 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/arch/hexagon/Kconfig b/arch/hexagon/Kconfig
index 37adb20..66fb2d5 100644
--- a/arch/hexagon/Kconfig
+++ b/arch/hexagon/Kconfig
@@ -28,6 +28,9 @@ config HEXAGON
 	select GENERIC_CLOCKEVENTS_BROADCAST
 	select MODULES_USE_ELF_RELA
 	select GENERIC_CPU_DEVICES
+	select HAVE_MEMBLOCK
+	select ARCH_DISCARD_MEMBLOCK
+	select NO_BOOTMEM
 	---help---
 	  Qualcomm Hexagon is a processor architecture designed for high
 	  performance and low power across a wide variety of applications.
diff --git a/arch/hexagon/mm/init.c b/arch/hexagon/mm/init.c
index 1495d45..d789b9c 100644
--- a/arch/hexagon/mm/init.c
+++ b/arch/hexagon/mm/init.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/mm.h>
 #include <linux/bootmem.h>
+#include <linux/memblock.h>
 #include <asm/atomic.h>
 #include <linux/highmem.h>
 #include <asm/tlb.h>
@@ -176,7 +177,6 @@ size_t hexagon_coherent_pool_size = (size_t) (DMA_RESERVE << 22);
 
 void __init setup_arch_memory(void)
 {
-	int bootmap_size;
 	/*  XXX Todo: this probably should be cleaned up  */
 	u32 *segtable = (u32 *) &swapper_pg_dir[0];
 	u32 *segtable_end;
@@ -195,18 +195,22 @@ void __init setup_arch_memory(void)
 	bootmem_lastpg = PFN_DOWN((bootmem_lastpg << PAGE_SHIFT) &
 		~((BIG_KERNEL_PAGE_SIZE) - 1));
 
+	memblock_add(PHYS_OFFSET,
+		     (bootmem_lastpg - ARCH_PFN_OFFSET) << PAGE_SHIFT);
+
+	/* Reserve kernel text/data/bss */
+	memblock_reserve(PHYS_OFFSET,
+			 (bootmem_startpg - ARCH_PFN_OFFSET) << PAGE_SHIFT);
 	/*
 	 * Reserve the top DMA_RESERVE bytes of RAM for DMA (uncached)
 	 * memory allocation
 	 */
-
 	max_low_pfn = bootmem_lastpg - PFN_DOWN(DMA_RESERVED_BYTES);
 	min_low_pfn = ARCH_PFN_OFFSET;
-	bootmap_size =  init_bootmem_node(NODE_DATA(0), bootmem_startpg, min_low_pfn, max_low_pfn);
+	memblock_reserve(PFN_PHYS(max_low_pfn), DMA_RESERVED_BYTES);
 
 	printk(KERN_INFO "bootmem_startpg:  0x%08lx\n", bootmem_startpg);
 	printk(KERN_INFO "bootmem_lastpg:  0x%08lx\n", bootmem_lastpg);
-	printk(KERN_INFO "bootmap_size:  %d\n", bootmap_size);
 	printk(KERN_INFO "min_low_pfn:  0x%08lx\n", min_low_pfn);
 	printk(KERN_INFO "max_low_pfn:  0x%08lx\n", max_low_pfn);
 
@@ -257,14 +261,6 @@ void __init setup_arch_memory(void)
 #endif
 
 	/*
-	 * Free all the memory that wasn't taken up by the bootmap, the DMA
-	 * reserve, or kernel itself.
-	 */
-	free_bootmem(PFN_PHYS(bootmem_startpg) + bootmap_size,
-		     PFN_PHYS(bootmem_lastpg - bootmem_startpg) - bootmap_size -
-		     DMA_RESERVED_BYTES);
-
-	/*
 	 *  The bootmem allocator seemingly just lives to feed memory
 	 *  to the paging system
 	 */
-- 
2.7.4


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

