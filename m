Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1It8xU-0000B9-Qk for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Nov 2007 13:42:40 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1It8xT-0000f6-RB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 16 Nov 2007 13:42:40 -0800
Date: Fri, 16 Nov 2007 16:42:25 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071116214225.GA13867@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 3/8] UML - Style cleanup
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

Style fixes in elf-i386.h and arch/um/kernel/mem.c.
      update the copyright
      get rid of an emacs formatting comment
      some formatting fixes
      inclusion trimming
      whitespace fixes

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/mem.c      |   86 +++++++++++++++++++++-------------------------
 include/asm-um/elf-i386.h |   19 ++--------
 2 files changed, 45 insertions(+), 60 deletions(-)

Index: linux-2.6.22/include/asm-um/elf-i386.h
===================================================================
--- linux-2.6.22.orig/include/asm-um/elf-i386.h	2007-11-16 15:16:54.000000000 -0500
+++ linux-2.6.22/include/asm-um/elf-i386.h	2007-11-16 15:21:20.000000000 -0500
@@ -1,5 +1,5 @@
 /*
- * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 #ifndef __UM_ELF_I386_H
@@ -46,7 +46,7 @@ typedef struct user_i387_struct elf_fpre
 	PT_REGS_EDI(regs) = 0; \
 	PT_REGS_EBP(regs) = 0; \
 	PT_REGS_EAX(regs) = 0; \
-} while(0)
+} while (0)
 
 #define USE_ELF_CORE_DUMP
 #define ELF_EXEC_PAGESIZE 4096
@@ -74,7 +74,7 @@ typedef struct user_i387_struct elf_fpre
 	pr_reg[14] = PT_REGS_EFLAGS(regs);	\
 	pr_reg[15] = PT_REGS_SP(regs);		\
 	pr_reg[16] = PT_REGS_SS(regs);		\
-} while(0);
+} while (0);
 
 extern int elf_core_copy_fpregs(struct task_struct *t, elf_fpregset_t *fpu);
 
@@ -86,7 +86,7 @@ extern long elf_aux_hwcap;
 extern char * elf_aux_platform;
 #define ELF_PLATFORM (elf_aux_platform)
 
-#define SET_PERSONALITY(ex, ibcs2) do ; while(0)
+#define SET_PERSONALITY(ex, ibcs2) do { } while (0)
 
 extern unsigned long vsyscall_ehdr;
 extern unsigned long vsyscall_end;
@@ -161,14 +161,3 @@ if ( vsyscall_ehdr ) {							      \
 }
 
 #endif
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
Index: linux-2.6.22/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.22.orig/arch/um/kernel/mem.c	2007-11-16 15:18:34.000000000 -0500
+++ linux-2.6.22/arch/um/kernel/mem.c	2007-11-16 15:33:46.000000000 -0500
@@ -1,28 +1,22 @@
 /*
- * Copyright (C) 2000 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Copyright (C) 2000 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
 
-#include "linux/stddef.h"
-#include "linux/kernel.h"
-#include "linux/mm.h"
-#include "linux/bootmem.h"
-#include "linux/swap.h"
-#include "linux/highmem.h"
-#include "linux/gfp.h"
-#include "asm/page.h"
-#include "asm/fixmap.h"
-#include "asm/pgalloc.h"
-#include "kern_util.h"
+#include <linux/stddef.h>
+#include <linux/bootmem.h>
+#include <linux/gfp.h>
+#include <linux/highmem.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <asm/fixmap.h>
+#include <asm/page.h>
 #include "as-layout.h"
+#include "init.h"
 #include "kern.h"
+#include "kern_util.h"
 #include "mem_user.h"
-#include "um_uaccess.h"
 #include "os.h"
-#include "linux/types.h"
-#include "linux/string.h"
-#include "init.h"
-#include "kern_constants.h"
 
 /* allocated in paging_init, zeroed in mem_init, and unchanged thereafter */
 unsigned long *empty_zero_page = NULL;
@@ -53,7 +47,7 @@ static void setup_highmem(unsigned long 
 	int i;
 
 	highmem_pfn = __pa(highmem_start) >> PAGE_SHIFT;
-	for(i = 0; i < highmem_len >> PAGE_SHIFT; i++){
+	for (i = 0; i < highmem_len >> PAGE_SHIFT; i++) {
 		page = &mem_map[highmem_pfn + i];
 		ClearPageReserved(page);
 		init_page_count(page);
@@ -85,7 +79,7 @@ void __init mem_init(void)
 #endif
 	num_physpages = totalram_pages;
 	max_pfn = totalram_pages;
-	printk(KERN_INFO "Memory: %luk available\n", 
+	printk(KERN_INFO "Memory: %luk available\n",
 	       (unsigned long) nr_free_pages() << (PAGE_SHIFT-10));
 	kmalloc_ok = 1;
 
@@ -119,7 +113,7 @@ static void __init one_md_table_init(pud
 #endif
 }
 
-static void __init fixrange_init(unsigned long start, unsigned long end, 
+static void __init fixrange_init(unsigned long start, unsigned long end,
 				 pgd_t *pgd_base)
 {
 	pgd_t *pgd;
@@ -206,7 +200,8 @@ static void __init fixaddr_user_init( vo
 	paddr = (unsigned long)alloc_bootmem_low_pages( size);
 	memcpy( (void *)paddr, (void *)FIXADDR_USER_START, size);
 	paddr = __pa(paddr);
-	for ( ; size > 0; size-=PAGE_SIZE, vaddr+=PAGE_SIZE, paddr+=PAGE_SIZE){
+	for ( ; size > 0; size -= PAGE_SIZE, vaddr += PAGE_SIZE,
+		      paddr += PAGE_SIZE) {
 		pgd = swapper_pg_dir + pgd_index(vaddr);
 		pud = pud_offset(pgd, vaddr);
 		pmd = pmd_offset(pud, vaddr);
@@ -223,7 +218,7 @@ void __init paging_init(void)
 
 	empty_zero_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
 	empty_bad_page = (unsigned long *) alloc_bootmem_low_pages(PAGE_SIZE);
-	for(i = 0; i < ARRAY_SIZE(zones_size); i++)
+	for (i = 0; i < ARRAY_SIZE(zones_size); i++)
 		zones_size[i] = 0;
 
 	zones_size[ZONE_NORMAL] = (end_iomem >> PAGE_SHIFT) -
@@ -253,26 +248,26 @@ struct page *arch_validate(struct page *
 	int i;
 
  again:
-	if(page == NULL)
+	if (page == NULL)
 		return page;
-	if(PageHighMem(page))
+	if (PageHighMem(page))
 		return page;
 
 	addr = (unsigned long) page_address(page);
-	for(i = 0; i < (1 << order); i++){
+	for (i = 0; i < (1 << order); i++) {
 		current->thread.fault_addr = (void *) addr;
-		if(__do_copy_to_user((void __user *) addr, &zero,
+		if (__do_copy_to_user((void __user *) addr, &zero,
 				     sizeof(zero),
 				     &current->thread.fault_addr,
-				     &current->thread.fault_catcher)){
-			if(!(mask & __GFP_WAIT))
+				     &current->thread.fault_catcher)) {
+			if (!(mask & __GFP_WAIT))
 				return NULL;
 			else break;
 		}
 		addr += PAGE_SIZE;
 	}
 
-	if(i == (1 << order))
+	if (i == (1 << order))
 		return page;
 	page = alloc_pages(mask, order);
 	goto again;
@@ -291,8 +286,8 @@ void free_initmem(void)
 void free_initrd_mem(unsigned long start, unsigned long end)
 {
 	if (start < end)
-		printk ("Freeing initrd memory: %ldk freed\n", 
-			(end - start) >> 10);
+		printk(KERN_INFO "Freeing initrd memory: %ldk freed\n",
+		       (end - start) >> 10);
 	for (; start < end; start += PAGE_SIZE) {
 		ClearPageReserved(virt_to_page(start));
 		init_page_count(virt_to_page(start));
@@ -309,27 +304,28 @@ void show_mem(void)
 	int highmem = 0;
 	struct page *page;
 
-	printk("Mem-info:\n");
+	printk(KERN_INFO "Mem-info:\n");
 	show_free_areas();
-	printk("Free swap:       %6ldkB\n", nr_swap_pages<<(PAGE_SHIFT-10));
+	printk(KERN_INFO "Free swap:       %6ldkB\n",
+	       nr_swap_pages<<(PAGE_SHIFT-10));
 	pfn = max_mapnr;
-	while(pfn-- > 0) {
+	while (pfn-- > 0) {
 		page = pfn_to_page(pfn);
 		total++;
-		if(PageHighMem(page))
+		if (PageHighMem(page))
 			highmem++;
-		if(PageReserved(page))
+		if (PageReserved(page))
 			reserved++;
-		else if(PageSwapCache(page))
+		else if (PageSwapCache(page))
 			cached++;
-		else if(page_count(page))
+		else if (page_count(page))
 			shared += page_count(page) - 1;
 	}
-	printk("%d pages of RAM\n", total);
-	printk("%d pages of HIGHMEM\n", highmem);
-	printk("%d reserved pages\n", reserved);
-	printk("%d pages shared\n", shared);
-	printk("%d pages swap cached\n", cached);
+	printk(KERN_INFO "%d pages of RAM\n", total);
+	printk(KERN_INFO "%d pages of HIGHMEM\n", highmem);
+	printk(KERN_INFO "%d reserved pages\n", reserved);
+	printk(KERN_INFO "%d pages shared\n", shared);
+	printk(KERN_INFO "%d pages swap cached\n", cached);
 }
 
 /* Allocate and free page tables. */
@@ -340,8 +336,8 @@ pgd_t *pgd_alloc(struct mm_struct *mm)
 
 	if (pgd) {
 		memset(pgd, 0, USER_PTRS_PER_PGD * sizeof(pgd_t));
-		memcpy(pgd + USER_PTRS_PER_PGD, 
-		       swapper_pg_dir + USER_PTRS_PER_PGD, 
+		memcpy(pgd + USER_PTRS_PER_PGD,
+		       swapper_pg_dir + USER_PTRS_PER_PGD,
 		       (PTRS_PER_PGD - USER_PTRS_PER_PGD) * sizeof(pgd_t));
 	}
 	return pgd;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
