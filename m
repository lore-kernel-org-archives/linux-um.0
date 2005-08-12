Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaY-0006YT-7n	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:06 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaW-0007eQ-WE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:06 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183557.D15FE24E7CB@zion.home.lan>
Subject: [uml-devel] [patch 24/39] remap_file_pages protection support: adapt
	to uml peculiarities
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
Date: Fri, 12 Aug 2005 20:35:57 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Uml is particular in respect with other architectures (and possibly this is to
fix) in the fact that our arch fault handler handles indifferently both TLB
and page faults. In particular, we may get to call handle_mm_fault() when the
PTE is already correct, but simply it's not flushed.

And rfp-fault-sigsegv-2 breaks this, because when getting a fault on a
pte_present PTE and non-uniform VMA, it assumes the fault is due to a
protection fault, and signals the caller a SIGSEGV must be sent.

This isn't the final fix for UML, that's the next one.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/arch/um/kernel/trap_kern.c |   19 +++++++++++++++----
 1 files changed, 15 insertions(+), 4 deletions(-)

diff -puN arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-3 arch/um/kernel/trap_kern.c
--- linux-2.6.git/arch/um/kernel/trap_kern.c~rfp-sigsegv-uml-3	2005-08-11 23:13:06.000000000 +0200
+++ linux-2.6.git-paolo/arch/um/kernel/trap_kern.c	2005-08-11 23:14:26.000000000 +0200
@@ -75,8 +75,21 @@ handle_fault:
 			err = -EACCES;
 			goto out;
 		case VM_FAULT_SIGSEGV:
-			err = -EFAULT;
-			goto out;
+			/* Duplicate this code here. */
+			pgd = pgd_offset(mm, address);
+			pud = pud_offset(pgd, address);
+			pmd = pmd_offset(pud, address);
+			pte = pte_offset_kernel(pmd, address);
+			if (likely (pte_newpage(*pte) || pte_newprot(*pte))) {
+				/* This wasn't done by __handle_mm_fault(), and
+				 * the page hadn't been flushed. */
+				*pte = pte_mkyoung(*pte);
+				if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
+				break;
+			} else {
+				err = -EFAULT;
+				goto out;
+			}
 		case VM_FAULT_OOM:
 			err = -ENOMEM;
 			goto out_of_memory;
@@ -89,8 +102,6 @@ handle_fault:
 		pte = pte_offset_kernel(pmd, address);
 	} while(!pte_present(*pte));
 	err = 0;
-	*pte = pte_mkyoung(*pte);
-	if(pte_write(*pte)) *pte = pte_mkdirty(*pte);
 	flush_tlb_page(vma, address);
 
 	/* If the PTE is not present, the vma protection are not accurate if
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
