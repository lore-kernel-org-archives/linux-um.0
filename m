Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9OAU-0002WQ-6b	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Aug 2005 07:29:54 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9OAT-0005JE-NO
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 28 Aug 2005 07:29:54 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Re: [uml-user] Hardware Requirements -Some Questions
	about UML by a Newbie
Message-ID: <20050828140355.GF3192@ccure.user-mode-linux.org>
References: <396648218@web.de>
	<20050811232256.GF11873@ccure.user-mode-linux.org>
	<200508121814.43201.blaisorblade@yahoo.it>
	<1124960678.28722.29.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="CE+1k2dSO48ffgeK"
Content-Disposition: inline
In-Reply-To: <1124960678.28722.29.camel@localhost.localdomain>
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
Date: Sun, 28 Aug 2005 10:03:55 -0400
To: Antoine Martin <antoine@nagafix.co.uk>
Cc: UML devel <user-mode-linux-devel@lists.sourceforge.net>, Blaisorblade <blaisorblade@yahoo.it>, Jeff Dike <jdike@addtoit.com>, eric_leitner@web.de


--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 25, 2005 at 10:04:38AM +0100, Antoine Martin wrote:
> 64-bit is broken atm, you'll run out of memory very quickly.

Um, and the patch is really included this time.

				Jeff

--CE+1k2dSO48ffgeK
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=page-leak

Index: linux-2.6.13-rc6-mm2/arch/um/include/skas/mmu-skas.h
===================================================================
--- linux-2.6.13-rc6-mm2.orig/arch/um/include/skas/mmu-skas.h	2005-08-23 10:51:42.000000000 -0400
+++ linux-2.6.13-rc6-mm2/arch/um/include/skas/mmu-skas.h	2005-08-25 23:15:24.000000000 -0400
@@ -6,6 +6,7 @@
 #ifndef __SKAS_MMU_H
 #define __SKAS_MMU_H
 
+#include "linux/config.h"
 #include "mm_id.h"
 #include "asm/ldt.h"
 
@@ -13,6 +14,9 @@
 	struct mm_id id;
 
         unsigned long last_page_table;
+#ifdef CONFIG_3_LEVEL_PGTABLES
+        unsigned long last_pmd;
+#endif
         uml_ldt_t ldt;
 };
 
Index: linux-2.6.13-rc6-mm2/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.13-rc6-mm2.orig/arch/um/kernel/skas/mmu.c	2005-08-23 10:51:42.000000000 -0400
+++ linux-2.6.13-rc6-mm2/arch/um/kernel/skas/mmu.c	2005-08-26 11:22:25.000000000 -0400
@@ -55,6 +55,9 @@
 	 */
 
         mm->context.skas.last_page_table = pmd_page_kernel(*pmd);
+#ifdef CONFIG_3_LEVEL_PGTABLES
+        mm->context.skas.last_pmd = (unsigned long) __va(pud_val(*pud));
+#endif
 
 	*pte = mk_pte(virt_to_page(kernel), __pgprot(_PAGE_PRESENT));
         *pte = pte_mkwrite(*pte);
@@ -143,6 +146,11 @@
 
 	if(!proc_mm || !ptrace_faultinfo){
 		free_page(mmu->id.stack);
-		free_page(mmu->last_page_table);
+		pte_free_kernel((pte_t *) mmu->last_page_table);
+                dec_page_state(nr_page_table_pages);
+#ifdef CONFIG_3_LEVEL_PGTABLES
+                log_info("Freeing last pmd 0x%x\n", mmu->last_pmd);
+		pmd_free((pmd_t *) mmu->last_pmd);
+#endif
 	}
 }
Index: linux-2.6.13-rc6-mm2/include/asm-um/pgalloc.h
===================================================================
--- linux-2.6.13-rc6-mm2.orig/include/asm-um/pgalloc.h	2005-08-23 10:51:42.000000000 -0400
+++ linux-2.6.13-rc6-mm2/include/asm-um/pgalloc.h	2005-08-25 22:20:38.000000000 -0400
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
Index: linux-2.6.13-rc6-mm2/include/asm-um/pgtable-3level.h
===================================================================
--- linux-2.6.13-rc6-mm2.orig/include/asm-um/pgtable-3level.h	2005-08-23 10:51:41.000000000 -0400
+++ linux-2.6.13-rc6-mm2/include/asm-um/pgtable-3level.h	2005-08-27 12:19:30.000000000 -0400
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
 

--CE+1k2dSO48ffgeK--


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
