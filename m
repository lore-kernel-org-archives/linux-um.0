Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaK-0006XK-5E	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:52 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaJ-0007eQ-UE
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:52 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183613.AE59524E7DC@zion.home.lan>
Subject: [uml-devel] [patch 30/39] remap_file_pages protection support: ia64
	bits
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
Date: Fri, 12 Aug 2005 20:36:13 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, mingo@elte.hu


From: Ingo Molnar <mingo@elte.hu>

I've attached a 'blind' port of the prot bits of fremap to ia64.  I've
compiled it with a cross-compiler but otherwise it's untested.  (and it's
very likely i got the pte bits wrong - but it's roughly OK.)

This should at least make ia64 compile.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-ia64/pgtable.h |   17 +++++++++++++----
 1 files changed, 13 insertions(+), 4 deletions(-)

diff -puN include/asm-ia64/pgtable.h~rfp-arch-ia64 include/asm-ia64/pgtable.h
--- linux-2.6.git/include/asm-ia64/pgtable.h~rfp-arch-ia64	2005-08-12 19:27:03.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ia64/pgtable.h	2005-08-12 19:27:03.000000000 +0200
@@ -433,7 +433,8 @@ extern void paging_init (void);
  * Format of file pte:
  *	bit   0   : present bit (must be zero)
  *	bit   1   : _PAGE_FILE (must be one)
- *	bits  2-62: file_offset/PAGE_SIZE
+ *	bit   2   : _PAGE_AR_RW
+ *	bits  3-62: file_offset/PAGE_SIZE
  *	bit  63   : _PAGE_PROTNONE bit
  */
 #define __swp_type(entry)		(((entry).val >> 2) & 0x7f)
@@ -442,9 +443,17 @@ extern void paging_init (void);
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val })
 
-#define PTE_FILE_MAX_BITS		61
-#define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 3)
-#define pgoff_to_pte(off)		((pte_t) { ((off) << 2) | _PAGE_FILE })
+#define PTE_FILE_MAX_BITS		59
+#define pte_to_pgoff(pte)		((pte_val(pte) << 1) >> 4)
+
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & (_PAGE_AR_RW | _PAGE_PROTNONE)) \
+		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
+			(__ACCESS_BITS | _PAGE_PL_3)))
+
+#define pgoff_prot_to_pte(off, prot) \
+       ((pte_t) { _PAGE_FILE + \
+               (pgprot_val(prot) & (_PAGE_AR_RW | _PAGE_PROTNONE)) + (off) })
 
 /* XXX is this right? */
 #define io_remap_page_range(vma, vaddr, paddr, size, prot)		\
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
