Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EAy0i-0007SG-AT	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:58:20 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EAy0h-00087T-3N
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 01 Sep 2005 15:58:20 -0700
Message-Id: <200509012217.j81MHOUf011578@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 12/12] UML - Fix x86_64 page leak
Sender: user-mode-linux-devel-admin@lists.sourceforge.net
Errors-To: user-mode-linux-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
Date: Thu, 01 Sep 2005 18:17:24 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

We were leaking pmd pages when 3_LEVEL_PGTABLES was enabled.  This fixes that.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/kernel/skas/include/mmu-skas.h
===================================================================
--- test.orig/arch/um/kernel/skas/include/mmu-skas.h	2005-09-01 16:54:41.000000000 -0400
+++ test/arch/um/kernel/skas/include/mmu-skas.h	2005-09-01 16:54:59.000000000 -0400
@@ -6,11 +6,15 @@
 #ifndef __SKAS_MMU_H
 #define __SKAS_MMU_H
 
+#include "linux/config.h"
 #include "mm_id.h"
 
 struct mmu_context_skas {
 	struct mm_id id;
         unsigned long last_page_table;
+#ifdef CONFIG_3_LEVEL_PGTABLES
+        unsigned long last_pmd;
+#endif
 };
 
 extern void switch_mm_skas(struct mm_id * mm_idp);
Index: test/arch/um/kernel/skas/mmu.c
===================================================================
--- test.orig/arch/um/kernel/skas/mmu.c	2005-09-01 16:51:15.000000000 -0400
+++ test/arch/um/kernel/skas/mmu.c	2005-09-01 16:57:00.000000000 -0400
@@ -56,6 +56,9 @@
 	 */
 
         mm->context.skas.last_page_table = pmd_page_kernel(*pmd);
+#ifdef CONFIG_3_LEVEL_PGTABLES
+        mm->context.skas.last_pmd = (unsigned long) __va(pud_val(*pud));
+#endif
 
 	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
 	*pte = pte_mkexec(*pte);
@@ -144,6 +147,10 @@
 
 	if(!proc_mm || !ptrace_faultinfo){
 		free_page(mmu->id.stack);
-		free_page(mmu->last_page_table);
+		pte_free_kernel((pte_t *) mmu->last_page_table);
+                dec_page_state(nr_page_table_pages);
+#ifdef CONFIG_3_LEVEL_PGTABLES
+		pmd_free((pmd_t *) mmu->last_pmd);
+#endif
 	}
 }
Index: test/include/asm-um/pgalloc.h
===================================================================
--- test.orig/include/asm-um/pgalloc.h	2005-09-01 16:51:15.000000000 -0400
+++ test/include/asm-um/pgalloc.h	2005-09-01 16:51:36.000000000 -0400
@@ -42,11 +42,13 @@
 #define __pte_free_tlb(tlb,pte) tlb_remove_page((tlb),(pte))
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
-/*
- * In the 3-level case we free the pmds as part of the pgd.
- */
-#define pmd_free(x)			do { } while (0)
-#define __pmd_free_tlb(tlb,x)		do { } while (0)
+
+extern __inline__ void pmd_free(pmd_t *pmd)
+{
+	free_page((unsigned long)pmd);
+}
+
+#define __pmd_free_tlb(tlb,x)   tlb_remove_page((tlb),virt_to_page(x))
 #endif
 
 #define check_pgt_cache()	do { } while (0)
Index: test/include/asm-um/pgtable-3level.h
===================================================================
--- test.orig/include/asm-um/pgtable-3level.h	2005-09-01 16:51:15.000000000 -0400
+++ test/include/asm-um/pgtable-3level.h	2005-09-01 16:51:36.000000000 -0400
@@ -69,14 +69,11 @@
         return pmd;
 }
 
-static inline void pmd_free(pmd_t *pmd){
-	free_page((unsigned long) pmd);
+extern inline void pud_clear (pud_t *pud)
+{
+        set_pud(pud, __pud(0));
 }
 
-#define __pmd_free_tlb(tlb,x)   do { } while (0)
-
-static inline void pud_clear (pud_t * pud) { }
-
 #define pud_page(pud) \
 	((struct page *) __va(pud_val(pud) & PAGE_MASK))
 



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
