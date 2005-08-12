Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaH-0006XA-DW	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:49 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaH-0007cu-0r
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:49 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183600.7D46D24E7D0@zion.home.lan>
Subject: [uml-devel] [patch 25/39] remap_file_pages protection support: fix
	unflushed TLB errors detection
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
Date: Fri, 12 Aug 2005 20:36:00 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

We got unflushed PTE's marked up-to-date, because they were protected to get
dirtying / accessing faults. So, don't test the PTE for being up-to-date, but
check directly the permission (since the PTE is not protected for that).

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   28 +++++++++++++++++++------
 1 files changed, 22 insertions(+), 6 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-3-fix arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-3-fix	2005-08-11 23:14:58.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-11 23:14:58.000000000 +0200
@@ -35,7 +35,7 @@ int handle_page_fault(unsigned long addr
 	pgd_t *pgd;
 	pud_t *pud;
 	pmd_t *pmd;
-	pte_t *pte;
+	pte_t *pte, entry;
 	int err = -EFAULT;
 	int access_mask = 0;
 
@@ -75,16 +75,32 @@ handle_fault:
 			err = -EACCES;
 			goto out;
 		case VM_FAULT_SIGSEGV:
+			WARN_ON(!(vma->vm_flags & VM_NONUNIFORM));
 			/* Duplicate this code here. */
 			pgd = pgd_offset(mm, address);
 			pud = pud_offset(pgd, address);
 			pmd = pmd_offset(pud, address);
 			pte = pte_offset_kernel(pmd, address);
-			if (likely (pte_newpage(*pte) || pte_newprot(*pte))) {
-				/* This wasn't done by __handle_mm_fault(), and
-				 * the page hadn't been flushed. */
-				*pte = pte_mkyoung(*pte);
-				if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
+			if (likely (pte_newpage(*pte) || pte_newprot(*pte)) ||
+				(is_write ? pte_write(*pte) : pte_read(*pte)) ) {
+				/* The page hadn't been flushed, or it had been
+				 * flushed but without access to get a dirtying
+				 * / accessing fault. */
+
+				/* __handle_mm_fault() didn't dirty / young this
+				 * PTE, probably we won't get another fault for
+				 * this page, so fix things now. */
+				entry = *pte;
+				entry = pte_mkyoung(*pte);
+				if(pte_write(entry))
+					entry = pte_mkdirty(entry);
+				/* Yes, this will set the page as NEWPAGE. We
+				 * want this, otherwise things won't work.
+				 * Indeed, the
+				 * *pte = pte_mkyoung(*pte);
+				 * we used to have (uselessly) didn't work at
+				 * all! */
+				set_pte(pte, entry);
 				break;
 			} else {
 				err = -EFAULT;
_


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
