Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kleVi-0002pB-KX
 for linux-um@lists.infradead.org; Sat, 05 Dec 2020 20:50:31 +0000
From: Johannes Berg <johannes@sipsolutions.net>
Subject: [PATCH 1/2] um: support some of ARCH_HAS_SET_MEMORY
Date: Sat,  5 Dec 2020 21:50:17 +0100
Message-Id: <20201205215016.eac3b08ee1a2.I47d69ccd6a474726b83813c60a75aa82556b69ae@changeid>
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
Cc: Johannes Berg <johannes.berg@intel.com>

From: Johannes Berg <johannes.berg@intel.com>

For now, only support set_memory_ro()/rw() which we need for
the stack protection in the next patch.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/Kconfig                  |  1 +
 arch/um/include/asm/pgtable.h    |  3 ++
 arch/um/include/asm/set_memory.h |  1 +
 arch/um/kernel/tlb.c             | 54 ++++++++++++++++++++++++++++++++
 4 files changed, 59 insertions(+)
 create mode 100644 arch/um/include/asm/set_memory.h

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 1c57599b82fa..70ee19cc6ec6 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -15,6 +15,7 @@ config UML
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DEBUG_BUGVERBOSE
 	select NO_DMA
+	select ARCH_HAS_SET_MEMORY
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
 	select GENERIC_CLOCKEVENTS
diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
index def376194dce..39376bb63abf 100644
--- a/arch/um/include/asm/pgtable.h
+++ b/arch/um/include/asm/pgtable.h
@@ -55,12 +55,15 @@ extern unsigned long end_iomem;
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define __PAGE_KERNEL_EXEC                                              \
 	 (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
+#define __PAGE_KERNEL_RO						\
+	 (_PAGE_PRESENT | _PAGE_DIRTY | _PAGE_ACCESSED)
 #define PAGE_NONE	__pgprot(_PAGE_PROTNONE | _PAGE_ACCESSED)
 #define PAGE_SHARED	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
 #define PAGE_KERNEL_EXEC	__pgprot(__PAGE_KERNEL_EXEC)
+#define PAGE_KERNEL_RO		__pgprot(__PAGE_KERNEL_RO)
 
 /*
  * The i386 can't do page protection for execute, and considers that the same
diff --git a/arch/um/include/asm/set_memory.h b/arch/um/include/asm/set_memory.h
new file mode 100644
index 000000000000..24266c63720d
--- /dev/null
+++ b/arch/um/include/asm/set_memory.h
@@ -0,0 +1 @@
+#include <asm-generic/set_memory.h>
diff --git a/arch/um/kernel/tlb.c b/arch/um/kernel/tlb.c
index 61776790cd67..437d1f1cc5ec 100644
--- a/arch/um/kernel/tlb.c
+++ b/arch/um/kernel/tlb.c
@@ -608,3 +608,57 @@ void force_flush_all(void)
 		vma = vma->vm_next;
 	}
 }
+
+struct page_change_data {
+	unsigned int set_mask, clear_mask;
+};
+
+static int change_page_range(pte_t *ptep, unsigned long addr, void *data)
+{
+	struct page_change_data *cdata = data;
+	pte_t pte = READ_ONCE(*ptep);
+
+	pte_clear_bits(pte, cdata->clear_mask);
+	pte_set_bits(pte, cdata->set_mask);
+
+	set_pte(ptep, pte);
+	return 0;
+}
+
+static int change_memory(unsigned long start, unsigned long pages,
+			 unsigned int set_mask, unsigned int clear_mask)
+{
+	unsigned long size = pages * PAGE_SIZE;
+	struct page_change_data data;
+	int ret;
+
+	data.set_mask = set_mask;
+	data.clear_mask = clear_mask;
+
+	ret = apply_to_page_range(&init_mm, start, size, change_page_range,
+				  &data);
+
+	flush_tlb_kernel_range(start, start + size);
+
+	return ret;
+}
+
+int set_memory_ro(unsigned long addr, int numpages)
+{
+	return change_memory(addr, numpages, 0, _PAGE_RW);
+}
+
+int set_memory_rw(unsigned long addr, int numpages)
+{
+	return change_memory(addr, numpages, _PAGE_RW, 0);
+}
+
+int set_memory_nx(unsigned long addr, int numpages)
+{
+	return -EOPNOTSUPP;
+}
+
+int set_memory_x(unsigned long addr, int numpages)
+{
+	return -EOPNOTSUPP;
+}
-- 
2.26.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

