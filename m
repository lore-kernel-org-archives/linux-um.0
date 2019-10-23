Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iN8QD-0001iQ-Uh
 for linux-um@lists.infradead.org; Wed, 23 Oct 2019 04:38:59 +0000
Received: by mail-pf1-x441.google.com with SMTP id a2so12079807pfo.10
 for <linux-um@lists.infradead.org>; Tue, 22 Oct 2019 21:38:57 -0700 (PDT)
From: Hajime Tazaki <thehajime@gmail.com>
Subject: [RFC PATCH 05/47] lkl: memory handling
Date: Wed, 23 Oct 2019 13:37:39 +0900
Message-Id: <98f540e974077726ebe09ce575ba3f8eefc05ee8.1571798507.git.thehajime@gmail.com>
In-Reply-To: <cover.1571798507.git.thehajime@gmail.com>
References: <cover.1571798507.git.thehajime@gmail.com>
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
Cc: "H . K . Jerry Chu" <hkchu@google.com>, Levente Kurusa <levex@linux.com>, Octavian Purdila <tavi.purdila@gmail.com>, Hajime Tazaki <thehajime@gmail.com>, Akira Moroo <retrage01@gmail.com>, Yuan Liu <liuyuan@google.com>

From: Octavian Purdila <tavi.purdila@gmail.com>

LKL is a non MMU architecture and hence there is not much work left to
do other than initializing the boot allocator and providing the page
and page table definitions.

The backstore memory is allocated via a host operation and the memory
size to be used is specified when the kernel is started, in the
lkl_start_kernel call.

Signed-off-by: H.K. Jerry Chu <hkchu@google.com>
Signed-off-by: Hajime Tazaki <thehajime@gmail.com>
Signed-off-by: Levente Kurusa <levex@linux.com>
Signed-off-by: Yuan Liu <liuyuan@google.com>
Signed-off-by: Octavian Purdila <tavi.purdila@gmail.com>
---
 arch/um/lkl/include/asm/page.h    | 14 +++++++
 arch/um/lkl/include/asm/pgtable.h | 62 +++++++++++++++++++++++++++++
 arch/um/lkl/mm/bootmem.c          | 66 +++++++++++++++++++++++++++++++
 3 files changed, 142 insertions(+)
 create mode 100644 arch/um/lkl/include/asm/page.h
 create mode 100644 arch/um/lkl/include/asm/pgtable.h
 create mode 100644 arch/um/lkl/mm/bootmem.c

diff --git a/arch/um/lkl/include/asm/page.h b/arch/um/lkl/include/asm/page.h
new file mode 100644
index 000000000000..e77f3da22031
--- /dev/null
+++ b/arch/um/lkl/include/asm/page.h
@@ -0,0 +1,14 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_LKL_PAGE_H
+#define _ASM_LKL_PAGE_H
+
+#define CONFIG_KERNEL_RAM_BASE_ADDRESS memory_start
+
+#ifndef __ASSEMBLY__
+void free_mem(void);
+void bootmem_init(unsigned long mem_size);
+#endif
+
+#include <asm-generic/page.h>
+
+#endif /* _ASM_LKL_PAGE_H */
diff --git a/arch/um/lkl/include/asm/pgtable.h b/arch/um/lkl/include/asm/pgtable.h
new file mode 100644
index 000000000000..b790296abfac
--- /dev/null
+++ b/arch/um/lkl/include/asm/pgtable.h
@@ -0,0 +1,62 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LKL_PGTABLE_H
+#define _LKL_PGTABLE_H
+
+#include <asm-generic/4level-fixup.h>
+
+/*
+ * (C) Copyright 2000-2002, Greg Ungerer <gerg@snapgear.com>
+ */
+
+#include <linux/slab.h>
+#include <asm/processor.h>
+#include <asm/io.h>
+
+#define pgd_present(pgd)	(1)
+#define pgd_none(pgd)		(0)
+#define pgd_bad(pgd)		(0)
+#define pgd_clear(pgdp)
+#define kern_addr_valid(addr)	(1)
+#define	pmd_offset(a, b)	((void *)0)
+
+#define PAGE_NONE		__pgprot(0)
+#define PAGE_SHARED		__pgprot(0)
+#define PAGE_COPY		__pgprot(0)
+#define PAGE_READONLY		__pgprot(0)
+#define PAGE_KERNEL		__pgprot(0)
+
+void paging_init(void);
+#define swapper_pg_dir		((pgd_t *)0)
+
+#define __swp_type(x)		(0)
+#define __swp_offset(x)		(0)
+#define __swp_entry(typ, off)	((swp_entry_t) { ((typ) | ((off) << 7)) })
+#define __pte_to_swp_entry(pte)	((swp_entry_t) { pte_val(pte) })
+#define __swp_entry_to_pte(x)	((pte_t) { (x).val })
+
+/*
+ * ZERO_PAGE is a global shared page that is always zero: used
+ * for zero-mapped memory areas etc..
+ */
+extern void *empty_zero_page;
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
+
+/*
+ * No page table caches to initialise.
+ */
+#define pgtable_cache_init()	do { } while (0)
+
+/*
+ * All 32bit addresses are effectively valid for vmalloc...
+ * Sort of meaningless for non-VM targets.
+ */
+#define	VMALLOC_START		0
+#define	VMALLOC_END		0xffffffff
+#define	KMAP_START		0
+#define	KMAP_END		0xffffffff
+
+#include <asm-generic/pgtable.h>
+
+#define check_pgt_cache()	do { } while (0)
+
+#endif
diff --git a/arch/um/lkl/mm/bootmem.c b/arch/um/lkl/mm/bootmem.c
new file mode 100644
index 000000000000..39dd0d22b44e
--- /dev/null
+++ b/arch/um/lkl/mm/bootmem.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/memblock.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+
+unsigned long memory_start, memory_end;
+static unsigned long _memory_start, mem_size;
+
+void *empty_zero_page;
+
+void __init bootmem_init(unsigned long mem_sz)
+{
+	mem_size = mem_sz;
+
+	_memory_start = (unsigned long)lkl_ops->mem_alloc(mem_size);
+	memory_start = _memory_start;
+	WARN_ON(!memory_start);
+	memory_end = memory_start + mem_size;
+
+	if (PAGE_ALIGN(memory_start) != memory_start) {
+		mem_size -= PAGE_ALIGN(memory_start) - memory_start;
+		memory_start = PAGE_ALIGN(memory_start);
+		mem_size = (mem_size / PAGE_SIZE) * PAGE_SIZE;
+	}
+	pr_info("memblock address range: 0x%lx - 0x%lx\n", memory_start,
+		memory_start + mem_size);
+	/*
+	 * Give all the memory to the bootmap allocator, tell it to put the
+	 * boot mem_map at the start of memory.
+	 */
+	max_low_pfn = virt_to_pfn(memory_end);
+	min_low_pfn = virt_to_pfn(memory_start);
+	memblock_add(memory_start, mem_size);
+
+	empty_zero_page = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
+	memset((void *)empty_zero_page, 0, PAGE_SIZE);
+
+	{
+		unsigned long zones_size[MAX_NR_ZONES] = {0, };
+
+		zones_size[ZONE_NORMAL] = (mem_size) >> PAGE_SHIFT;
+		free_area_init(zones_size);
+	}
+}
+
+void __init mem_init(void)
+{
+	max_mapnr = (((unsigned long)high_memory) - PAGE_OFFSET) >> PAGE_SHIFT;
+	/* this will put all memory onto the freelists */
+	totalram_pages_add(memblock_free_all());
+	pr_info("Memory available: %luk/%luk RAM\n",
+		(nr_free_pages() << PAGE_SHIFT) >> 10, mem_size >> 10);
+}
+
+/*
+ * In our case __init memory is not part of the page allocator so there is
+ * nothing to free.
+ */
+void free_initmem(void)
+{
+}
+
+void free_mem(void)
+{
+	lkl_ops->mem_free((void *)_memory_start);
+}
-- 
2.20.1 (Apple Git-117)


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

