Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1It8xY-0000Bk-VW for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Nov 2007 13:42:45 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1It8xY-0007wd-7D
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Nov 2007 13:42:44 -0800
Date: Fri, 16 Nov 2007 16:42:26 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071116214226.GA13857@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/8] UML - Fix page table data sizes
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Get the sizes of various pieces of data right when using three-level
page tables.  pgd and pmd entries remain at 32 bits in a 32-bit
compilation because page tables will remain in low memory.  So,
PGDIR_SHIFT, the PTRS_PER_* values, set_pud, set_pmd are conditional
on 64BIT.

More use of phys_t is made when there are physical memory addresses
floating around.

ObCheckpatchViolationJustification - the new typedef is an alternate
definition of pmd_t, which I can't really live without.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/mem.c            |   17 +++++++++--------
 include/asm-um/page.h           |    6 +++---
 include/asm-um/pgtable-3level.h |   21 ++++++++++++++++++++-
 include/asm-um/pgtable.h        |    2 +-
 4 files changed, 33 insertions(+), 13 deletions(-)

Index: linux-2.6.22/include/asm-um/page.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/page.h	2007-11-16 15:16:54.000000000 -0500
+++ linux-2.6.22/include/asm-um/page.h	2007-11-16 15:35:38.000000000 -0500
@@ -30,7 +30,7 @@ struct page;
 #if defined(CONFIG_3_LEVEL_PGTABLES) && !defined(CONFIG_64BIT)
 
 typedef struct { unsigned long pte_low, pte_high; } pte_t;
-typedef struct { unsigned long long pmd; } pmd_t;
+typedef struct { unsigned long pmd; } pmd_t;
 typedef struct { unsigned long pgd; } pgd_t;
 #define pte_val(x) ((x).pte_low | ((unsigned long long) (x).pte_high << 32))
 
@@ -108,8 +108,8 @@ extern unsigned long uml_physmem;
 #define __pa(virt) to_phys((void *) (unsigned long) (virt))
 #define __va(phys) to_virt((unsigned long) (phys))
 
-#define phys_to_pfn(p) ((p) >> PAGE_SHIFT)
-#define pfn_to_phys(pfn) ((pfn) << PAGE_SHIFT)
+#define phys_to_pfn(p) ((pfn_t) ((p) >> PAGE_SHIFT))
+#define pfn_to_phys(pfn) ((phys_t) ((pfn) << PAGE_SHIFT))
 
 #define pfn_valid(pfn) ((pfn) < max_mapnr)
 #define virt_addr_valid(v) pfn_valid(phys_to_pfn(__pa(v)))
Index: linux-2.6.22/include/asm-um/pgtable-3level.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/pgtable-3level.h	2007-11-16 15:16:54.000000000 -0500
+++ linux-2.6.22/include/asm-um/pgtable-3level.h	2007-11-16 15:35:38.000000000 -0500
@@ -12,7 +12,11 @@
 
 /* PGDIR_SHIFT determines what a third-level page table entry can map */
 
+#ifdef CONFIG_64BIT
 #define PGDIR_SHIFT	30
+#else
+#define PGDIR_SHIFT	31
+#endif
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
@@ -29,9 +33,15 @@
  */
 
 #define PTRS_PER_PTE 512
+#ifdef CONFIG_64BIT
 #define PTRS_PER_PMD 512
-#define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 #define PTRS_PER_PGD 512
+#else
+#define PTRS_PER_PMD 1024
+#define PTRS_PER_PGD 1024
+#endif
+
+#define USER_PTRS_PER_PGD ((TASK_SIZE + (PGDIR_SIZE - 1)) / PGDIR_SIZE)
 #define FIRST_USER_ADDRESS	0
 
 #define pte_ERROR(e) \
@@ -50,7 +60,12 @@
 #define pud_populate(mm, pud, pmd) \
 	set_pud(pud, __pud(_PAGE_TABLE + __pa(pmd)))
 
+#ifdef CONFIG_64BIT
 #define set_pud(pudptr, pudval) set_64bit((phys_t *) (pudptr), pud_val(pudval))
+#else
+#define set_pud(pudptr, pudval) (*(pudptr) = (pudval))
+#endif
+
 static inline int pgd_newpage(pgd_t pgd)
 {
 	return(pgd_val(pgd) & _PAGE_NEWPAGE);
@@ -58,7 +73,11 @@ static inline int pgd_newpage(pgd_t pgd)
 
 static inline void pgd_mkuptodate(pgd_t pgd) { pgd_val(pgd) &= ~_PAGE_NEWPAGE; }
 
+#ifdef CONFIG_64BIT
 #define set_pmd(pmdptr, pmdval) set_64bit((phys_t *) (pmdptr), pmd_val(pmdval))
+#else
+#define set_pmd(pmdptr, pmdval) (*(pmdptr) = (pmdval))
+#endif
 
 struct mm_struct;
 extern pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address);
Index: linux-2.6.22/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/pgtable.h	2007-11-16 15:16:54.000000000 -0500
+++ linux-2.6.22/include/asm-um/pgtable.h	2007-11-16 15:35:38.000000000 -0500
@@ -262,7 +262,7 @@ static inline void set_pte(pte_t *pteptr
 
 #define phys_to_page(phys) pfn_to_page(phys_to_pfn(phys))
 #define __virt_to_page(virt) phys_to_page(__pa(virt))
-#define page_to_phys(page) pfn_to_phys(page_to_pfn(page))
+#define page_to_phys(page) pfn_to_phys((pfn_t) page_to_pfn(page))
 #define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
 
 #define mk_pte(page, pgprot) \
Index: linux-2.6.22/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/mem.c	2007-11-16 15:33:46.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/mem.c	2007-11-16 15:38:05.000000000 -0500
@@ -132,7 +132,7 @@ static void __init fixrange_init(unsigne
 		if (pud_none(*pud))
 			one_md_table_init(pud);
 		pmd = pmd_offset(pud, vaddr);
-		for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
+		for (; (j < PTRS_PER_PMD) && (vaddr < end); pmd++, j++) {
 			one_page_table_init(pmd);
 			vaddr += PMD_SIZE;
 		}
@@ -191,22 +191,23 @@ static void __init fixaddr_user_init( vo
 	pud_t *pud;
 	pmd_t *pmd;
 	pte_t *pte;
-	unsigned long paddr, vaddr = FIXADDR_USER_START;
+	phys_t p;
+	unsigned long v, vaddr = FIXADDR_USER_START;
 
-	if (  ! size )
+	if (!size)
 		return;
 
 	fixrange_init( FIXADDR_USER_START, FIXADDR_USER_END, swapper_pg_dir);
-	paddr = (unsigned long)alloc_bootmem_low_pages( size);
-	memcpy( (void *)paddr, (void *)FIXADDR_USER_START, size);
-	paddr = __pa(paddr);
+	v = (unsigned long) alloc_bootmem_low_pages(size);
+	memcpy((void *) v , (void *) FIXADDR_USER_START, size);
+	p = __pa(v);
 	for ( ; size > 0; size -= PAGE_SIZE, vaddr += PAGE_SIZE,
-		      paddr += PAGE_SIZE) {
+		      p += PAGE_SIZE) {
 		pgd = swapper_pg_dir + pgd_index(vaddr);
 		pud = pud_offset(pgd, vaddr);
 		pmd = pmd_offset(pud, vaddr);
 		pte = pte_offset_kernel(pmd, vaddr);
-		pte_set_val( (*pte), paddr, PAGE_READONLY);
+		pte_set_val(*pte, p, PAGE_READONLY);
 	}
 #endif
 }

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
