Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1Ipplh-00007S-6t for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Nov 2007 10:36:49 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1Ipple-0004Kc-Cl
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 07 Nov 2007 10:36:49 -0800
Date: Wed, 7 Nov 2007 13:36:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071107183639.GA8477@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/5] UML - Tidy pgtable.h
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

Large pieces of include/asm/pgtable.h were unused cruft.

This uncovered arch/um/kernel/trap.c needing skas.h in order to get
ptrace_faultinfo.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/trap.c    |    1 
 include/asm-um/pgtable.h |   86 +++--------------------------------------------
 2 files changed, 8 insertions(+), 79 deletions(-)

Index: linux-2.6/arch/um/kernel/trap.c
===================================================================
--- linux-2.6.orig/arch/um/kernel/trap.c	2007-11-07 12:44:55.000000000 -0500
+++ linux-2.6/arch/um/kernel/trap.c	2007-11-07 13:22:28.000000000 -0500
@@ -13,6 +13,7 @@
 #include "as-layout.h"
 #include "kern_util.h"
 #include "os.h"
+#include "skas.h"
 #include "sysdep/sigcontext.h"
 
 /*
Index: linux-2.6/include/asm-um/pgtable.h
===================================================================
--- linux-2.6.orig/include/asm-um/pgtable.h	2007-07-19 11:46:41.000000000 -0400
+++ linux-2.6/include/asm-um/pgtable.h	2007-11-07 12:56:04.000000000 -0500
@@ -1,5 +1,5 @@
 /* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Copyright 2003 PathScale, Inc.
  * Derived from include/asm-i386/pgtable.h
  * Licensed under the GPL
@@ -9,10 +9,6 @@
 #define __UM_PGTABLE_H
 
 #include "linux/sched.h"
-#include "linux/linkage.h"
-#include "asm/processor.h"
-#include "asm/page.h"
-#include "asm/fixmap.h"
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEWPAGE	0x002
@@ -42,14 +38,6 @@ extern unsigned long *empty_zero_page;
 
 #define pgtable_cache_init() do ; while (0)
 
-/*
- * pgd entries used up by user/kernel:
- */
-
-#define USER_PGD_PTRS (TASK_SIZE >> PGDIR_SHIFT)
-#define KERNEL_PGD_PTRS (PTRS_PER_PGD-USER_PGD_PTRS)
-
-#ifndef __ASSEMBLY__
 /* Just any arbitrary offset to the start of the vmalloc VM area: the
  * current 8MB value just means that there will be a 8MB "hole" after the
  * physical memory until the kernel virtual memory starts.  That means that
@@ -62,16 +50,12 @@ extern unsigned long end_iomem;
 
 #define VMALLOC_OFFSET	(__va_space)
 #define VMALLOC_START ((end_iomem + VMALLOC_OFFSET) & ~(VMALLOC_OFFSET-1))
-
 #ifdef CONFIG_HIGHMEM
 # define VMALLOC_END	(PKMAP_BASE-2*PAGE_SIZE)
 #else
 # define VMALLOC_END	(FIXADDR_START-2*PAGE_SIZE)
 #endif
 
-#define REGION_SHIFT	(sizeof(pte_t) * 8 - 4)
-#define REGION_MASK	(((unsigned long) 0xf) << REGION_SHIFT)
-
 #define _PAGE_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_USER | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _KERNPG_TABLE	(_PAGE_PRESENT | _PAGE_RW | _PAGE_ACCESSED | _PAGE_DIRTY)
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY)
@@ -81,11 +65,12 @@ extern unsigned long end_iomem;
 #define PAGE_COPY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_READONLY	__pgprot(_PAGE_PRESENT | _PAGE_USER | _PAGE_ACCESSED)
 #define PAGE_KERNEL	__pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | _PAGE_ACCESSED)
-#define PAGE_KERNEL_RO	__pgprot(_PAGE_PRESENT | _PAGE_DIRTY | _PAGE_ACCESSED)
 
 /*
- * The i386 can't do page protection for execute, and considers that the same are read.
- * Also, write permissions imply read permissions. This is the closest we can get..
+ * The i386 can't do page protection for execute, and considers that the same
+ * are read.
+ * Also, write permissions imply read permissions. This is the closest we can
+ * get..
  */
 #define __P000	PAGE_NONE
 #define __P001	PAGE_READONLY
@@ -106,40 +91,16 @@ extern unsigned long end_iomem;
 #define __S111	PAGE_SHARED
 
 /*
- * Define this if things work differently on an i386 and an i486:
- * it will (on an i486) warn about kernel memory accesses that are
- * done without a 'access_ok(VERIFY_WRITE,..)'
- */
-#undef TEST_VERIFY_AREA
-
-/* page table for 0-4MB for everybody */
-extern unsigned long pg0[1024];
-
-/*
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-
 #define ZERO_PAGE(vaddr) virt_to_page(empty_zero_page)
 
-/* number of bits that fit into a memory pointer */
-#define BITS_PER_PTR			(8*sizeof(unsigned long))
-
-/* to align the pointer to a pointer address */
-#define PTR_MASK			(~(sizeof(void*)-1))
-
-/* sizeof(void*)==1<<SIZEOF_PTR_LOG2 */
-/* 64-bit machines, beware!  SRB. */
-#define SIZEOF_PTR_LOG2			3
-
-/* to find an entry in a page-table */
-#define PAGE_PTR(address) \
-((unsigned long)(address)>>(PAGE_SHIFT-SIZEOF_PTR_LOG2)&PTR_MASK&~PAGE_MASK)
-
 #define pte_clear(mm,addr,xp) pte_set_val(*(xp), (phys_t) 0, __pgprot(_PAGE_NEWPAGE))
 
 #define pmd_none(x)	(!((unsigned long)pmd_val(x) & ~_PAGE_NEWPAGE))
 #define	pmd_bad(x)	((pmd_val(x) & (~PAGE_MASK & ~_PAGE_USER)) != _KERNPG_TABLE)
+
 #define pmd_present(x)	(pmd_val(x) & _PAGE_PRESENT)
 #define pmd_clear(xp)	do { pmd_val(*(xp)) = _PAGE_NEWPAGE; } while (0)
 
@@ -149,14 +110,9 @@ extern unsigned long pg0[1024];
 #define pud_newpage(x)  (pud_val(x) & _PAGE_NEWPAGE)
 #define pud_mkuptodate(x) (pud_val(x) &= ~_PAGE_NEWPAGE)
 
-#define pages_to_mb(x) ((x) >> (20-PAGE_SHIFT))
-
 #define pmd_page(pmd) phys_to_page(pmd_val(pmd) & PAGE_MASK)
 
 #define pte_page(x) pfn_to_page(pte_pfn(x))
-#define pte_address(x) (__va(pte_val(x) & PAGE_MASK))
-#define mk_phys(a, r) ((a) + (((unsigned long) r) << REGION_SHIFT))
-#define phys_addr(p) ((p) & ~REGION_MASK)
 
 #define pte_present(x)	pte_get_bits(x, (_PAGE_PRESENT | _PAGE_PROTNONE))
 
@@ -310,6 +266,7 @@ static inline void set_pte(pte_t *pteptr
 #define phys_to_page(phys) pfn_to_page(phys_to_pfn(phys))
 #define __virt_to_page(virt) phys_to_page(__pa(virt))
 #define page_to_phys(page) pfn_to_phys(page_to_pfn(page))
+#define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
 
 #define mk_pte(page, pgprot) \
 	({ pte_t pte;					\
@@ -325,8 +282,6 @@ static inline pte_t pte_modify(pte_t pte
 	return pte; 
 }
 
-#define pmd_page_vaddr(pmd) ((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
-
 /*
  * the pgd page can be thought of an array like this: pgd_t[PTRS_PER_PGD]
  *
@@ -335,8 +290,6 @@ static inline pte_t pte_modify(pte_t pte
  */
 #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
 
-#define pgd_index_k(addr) pgd_index(addr)
-
 /*
  * pgd_offset() returns a (pgd_t *)
  * pgd_index() is used get the offset into the pgd page's array of pgd_t's;
@@ -388,29 +341,4 @@ static inline pte_t pte_modify(pte_t pte
 
 #include <asm-generic/pgtable.h>
 
-#include <asm-generic/pgtable-nopud.h>
-
-#ifdef CONFIG_HIGHMEM
-/* Clear a kernel PTE and flush it from the TLB */
-#define kpte_clear_flush(ptep, vaddr)					\
-do {									\
-	pte_clear(&init_mm, vaddr, ptep);				\
-	__flush_tlb_one(vaddr);						\
-} while (0)
-#endif
-
-#endif
 #endif
-
-#define virt_to_page(addr) __virt_to_page((const unsigned long) addr)
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
