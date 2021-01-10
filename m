Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyf5i-0006pP-SI
 for linux-um@lists.infradead.org; Sun, 10 Jan 2021 18:05:29 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 2/2] Revert "um: support some of ARCH_HAS_SET_MEMORY"
Date: Sun, 10 Jan 2021 19:05:09 +0100
Message-Id: <20210110180518.60785-1-johannes@sipsolutions.net>
In-Reply-To: <20210110190509.65a0c174fcca.I148fc32a2b85fd17746ca528f3811c80483232bd@changeid>
References: <20210110190509.65a0c174fcca.I148fc32a2b85fd17746ca528f3811c80483232bd@changeid>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin@sipsolutions.net>, Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

This reverts commit 963285b0b47a ("um: support some of
ARCH_HAS_SET_MEMORY"), as it turns out that it's not only not
working (due to um never using the protection bits in the
page tables) but also corrupts the page tables if used on a
non-vmalloc page, since um never allocates proper page tables
for the 'physmem' in the first place.

Fixing all this will take more effort, so for now revert it.

Reported-by: Benjamin Berg <benjamin@sipsolutions.net>
Fixes: 963285b0b47a ("um: support some of ARCH_HAS_SET_MEMORY")
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig                  |  1 -
 arch/um/include/asm/pgtable.h    |  3 --
 arch/um/include/asm/set_memory.h |  1 -
 arch/um/kernel/tlb.c             | 54 --------------------------------
 4 files changed, 59 deletions(-)
 delete mode 100644 arch/um/include/asm/set_memory.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 34d302d1a07f..c3030db3325f 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -15,7 +15,6 @@ config UML
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
 	select NO_DMA
-	select ARCH_HAS_SET_MEMORY
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select HAVE_GCC_PLUGINS
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index 39376bb63abf..def376194dce 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -55,15 +55,12 @@ extern unsigned long end_iomem;
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define __PAGE_KERNEL_EXEC                                              \
 	 (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
-#define __PAGE_KERNEL_RO						\
-	 (_PAGE_PRESENT | _PAGE_DIRTY | _PAGE_ACCESSED)
 #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
 #define PAGE_KERNEL_EXEC	__pgprot(__PAGE_KERNEL_EXEC)
-#define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO)
 
 /*
  * The i386 can't do page protection for execute, and considers that the same
diff --git a/arch/um/include/asm/set_memory.h b/arch/um/include/asm/set_memory.h
deleted file mode 100644
index 24266c63720d..000000000000
--- a/arch/um/include/asm/set_memory.h
+++ /dev/null
@@ -1 +0,0 @@
-#include <asm-generic/set_memory.h>
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 437d1f1cc5ec..61776790cd67 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -608,57 +608,3 @@ void force_flush_all(void)
 		vma = vma->vm_next;
 	}
 }
-
-struct page_change_data {
-	unsigned int set_mask, clear_mask;
-};
-
-static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
-{
-	struct page_change_data *cdata = data;
-	pte_t pte = READ_ONCE(*ptep);
-
-	pte_clear_bits(pte, cdata->clear_mask);
-	pte_set_bits(pte, cdata->set_mask);
-
-	set_pte(ptep, pte);
-	return 0;
-}
-
-static int change_memory(unsigned long start, unsigned long pages,
-			 unsigned int set_mask, unsigned int clear_mask)
-{
-	unsigned long size = pages * PAGE_SIZE;
-	struct page_change_data data;
-	int ret;
-
-	data.set_mask = set_mask;
-	data.clear_mask = clear_mask;
-
-	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
-				  &data);
-
-	flush_tlb_kernel_range(start, start + size);
-
-	return ret;
-}
-
-int set_memory_ro(unsigned long addr, int numpages)
-{
-	return change_memory(addr, numpages, 0, _PAGE_RW);
-}
-
-int set_memory_rw(unsigned long addr, int numpages)
-{
-	return change_memory(addr, numpages, _PAGE_RW, 0);
-}
-
-int set_memory_nx(unsigned long addr, int numpages)
-{
-	return -EOPNOTSUPP;
-}
-
-int set_memory_x(unsigned long addr, int numpages)
-{
-	return -EOPNOTSUPP;
-}
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

