Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J0KBV-0005lt-H6 for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 09:06:50 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J0KBU-0008VV-SE
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 06 Dec 2007 09:06:49 -0800
Date: Thu, 6 Dec 2007 12:06:43 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071206170643.GA7445@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 6/6] UML - 64-bit tlb fixes
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

Some 64-bit tlb fixes -
	moved pmd_page_vaddr to pgtable.h since it's the same for both
2-level and 3-level page tables
	fixed a bogus cast on pud_page_vaddr
	made the address checking in update_*_range more careful

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/kernel/tlb.c            |    8 ++++----
 include/asm-um/pgtable-2level.h |    3 ---
 include/asm-um/pgtable-3level.h |    3 +--
 include/asm-um/pgtable.h        |    3 +++
 4 files changed, 8 insertions(+), 9 deletions(-)

Index: linux-2.6-git/arch/um/kernel/tlb.c
===================================================================
--- linux-2.6-git.orig/arch/um/kernel/tlb.c	2007-12-06 10:34:41.000000000 -0500
+++ linux-2.6-git/arch/um/kernel/tlb.c	2007-12-06 11:26:20.000000000 -0500
@@ -207,7 +207,7 @@ static inline int update_pte_range(pmd_t
 		} else if (pte_newprot(*pte))
 			ret = add_mprotect(addr, PAGE_SIZE, prot, hvc);
 		*pte = pte_mkuptodate(*pte);
-	} while (pte++, addr += PAGE_SIZE, ((addr != end) && !ret));
+	} while (pte++, addr += PAGE_SIZE, ((addr < end) && !ret));
 	return ret;
 }
 
@@ -229,7 +229,7 @@ static inline int update_pmd_range(pud_t
 			}
 		}
 		else ret = update_pte_range(pmd, addr, next, hvc);
-	} while (pmd++, addr = next, ((addr != end) && !ret));
+	} while (pmd++, addr = next, ((addr < end) && !ret));
 	return ret;
 }
 
@@ -251,7 +251,7 @@ static inline int update_pud_range(pgd_t
 			}
 		}
 		else ret = update_pmd_range(pud, addr, next, hvc);
-	} while (pud++, addr = next, ((addr != end) && !ret));
+	} while (pud++, addr = next, ((addr < end) && !ret));
 	return ret;
 }
 
@@ -274,7 +274,7 @@ void fix_range_common(struct mm_struct *
 			}
 		}
 		else ret = update_pud_range(pgd, addr, next, &hvc);
-	} while (pgd++, addr = next, ((addr != end_addr) && !ret));
+	} while (pgd++, addr = next, ((addr < end_addr) && !ret));
 
 	if (!ret)
 		ret = do_ops(&hvc, hvc.index, 1);
Index: linux-2.6-git/include/asm-um/pgtable-2level.h
===================================================================
--- linux-2.6-git.orig/include/asm-um/pgtable-2level.h	2007-12-03 23:57:24.000000000 -0500
+++ linux-2.6-git/include/asm-um/pgtable-2level.h	2007-12-06 11:26:20.000000000 -0500
@@ -41,9 +41,6 @@ static inline void pgd_mkuptodate(pgd_t 
 #define pfn_pte(pfn, prot) __pte(pfn_to_phys(pfn) | pgprot_val(prot))
 #define pfn_pmd(pfn, prot) __pmd(pfn_to_phys(pfn) | pgprot_val(prot))
 
-#define pmd_page_vaddr(pmd) \
-	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
-
 /*
  * Bits 0 through 4 are taken
  */
Index: linux-2.6-git/include/asm-um/pgtable-3level.h
===================================================================
--- linux-2.6-git.orig/include/asm-um/pgtable-3level.h	2007-12-06 10:32:12.000000000 -0500
+++ linux-2.6-git/include/asm-um/pgtable-3level.h	2007-12-06 11:26:20.000000000 -0500
@@ -87,8 +87,7 @@ static inline void pud_clear (pud_t *pud
 }
 
 #define pud_page(pud) phys_to_page(pud_val(pud) & PAGE_MASK)
-#define pud_page_vaddr(pud) \
-	((struct page *) __va(pud_val(pud) & PAGE_MASK))
+#define pud_page_vaddr(pud) ((unsigned long) __va(pud_val(pud) & PAGE_MASK))
 
 /* Find an entry in the second-level page table.. */
 #define pmd_offset(pud, address) ((pmd_t *) pud_page_vaddr(*(pud)) + \
Index: linux-2.6-git/include/asm-um/pgtable.h
===================================================================
--- linux-2.6-git.orig/include/asm-um/pgtable.h	2007-12-06 10:32:12.000000000 -0500
+++ linux-2.6-git/include/asm-um/pgtable.h	2007-12-06 11:26:20.000000000 -0500
@@ -307,6 +307,9 @@ static inline pte_t pte_modify(pte_t pte
  */
 #define pmd_index(address) (((address) >> PMD_SHIFT) & (PTRS_PER_PMD-1))
 
+#define pmd_page_vaddr(pmd) \
+	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
+
 /*
  * the pte page can be thought of an array like this: pte_t[PTRS_PER_PTE]
  *

-------------------------------------------------------------------------
SF.Net email is sponsored by: The Future of Linux Business White Paper
from Novell.  From the desktop to the data center, Linux is going
mainstream.  Let it simplify your IT future.
http://altfarm.mediaplex.com/ad/ck/8857-50307-18918-4
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
