Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYG85-0007MF-Pj	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:25:57 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DYG83-0006Rl-La	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:25:57 -0700
Message-Id: <200505180420.j4I4KXrD017344@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/9] UML - fixrange_init 3-level page table
	support
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
Date: Wed, 18 May 2005 00:20:33 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

From Al Viro - add three-level page table support to fixrange_init.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/kernel/mem.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/kernel/mem.c	2005-05-17 18:21:32.000000000 -0400
@@ -100,12 +100,37 @@ void mem_init(void)
 #endif
 }
 
+/*
+ * Create a page table and place a pointer to it in a middle page
+ * directory entry.
+ */
+static void __init one_page_table_init(pmd_t *pmd)
+{
+	if (pmd_none(*pmd)) {
+		pte_t *pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+		set_pmd(pmd, __pmd(_KERNPG_TABLE + 
+					   (unsigned long) __pa(pte)));
+		if (pte != pte_offset_kernel(pmd, 0))
+			BUG();
+	}
+}
+
+static void __init one_md_table_init(pud_t *pud)
+{
+#ifdef CONFIG_3_LEVEL_PGTABLES
+	pmd_t *pmd_table = (pmd_t *) alloc_bootmem_low_pages(PAGE_SIZE);
+	set_pud(pud, __pud(_KERNPG_TABLE + (unsigned long) __pa(pmd_table)));
+	if (pmd_table != pmd_offset(pud, 0)) 
+		BUG();
+#endif
+}
+
 static void __init fixrange_init(unsigned long start, unsigned long end, 
 				 pgd_t *pgd_base)
 {
 	pgd_t *pgd;
+	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
 	int i, j;
 	unsigned long vaddr;
 
@@ -115,15 +140,12 @@ static void __init fixrange_init(unsigne
 	pgd = pgd_base + i;
 
 	for ( ; (i < PTRS_PER_PGD) && (vaddr < end); pgd++, i++) {
-		pmd = (pmd_t *)pgd;
+		pud = pud_offset(pgd, vaddr);
+		if (pud_none(*pud)) 
+			one_md_table_init(pud);
+		pmd = pmd_offset(pud, vaddr);
 		for (; (j < PTRS_PER_PMD) && (vaddr != end); pmd++, j++) {
-			if (pmd_none(*pmd)) {
-				pte = (pte_t *) alloc_bootmem_low_pages(PAGE_SIZE);
-				set_pmd(pmd, __pmd(_KERNPG_TABLE + 
-						   (unsigned long) __pa(pte)));
-				if (pte != pte_offset_kernel(pmd, 0))
-					BUG();
-			}
+			one_page_table_init(pmd);
 			vaddr += PMD_SIZE;
 		}
 		j = 0;



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
