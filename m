Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ea6-0006WJ-JZ	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:38 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3ea5-0007Y1-6a
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:48:38 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183603.0927F24E7D2@zion.home.lan>
Subject: [uml-devel] [patch 26/39] remap_file_pages protection support: ppc32
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
Date: Fri, 12 Aug 2005 20:36:02 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, mingo@elte.hu


From: Ingo Molnar <mingo@elte.hu>

PPC32 bits of RFP - as in original patch.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-ppc/pgtable.h |   15 +++++++++++----
 1 files changed, 11 insertions(+), 4 deletions(-)

diff -puN include/asm-ppc/pgtable.h~rfp-arch-ppc include/asm-ppc/pgtable.h
--- linux-2.6.git/include/asm-ppc/pgtable.h~rfp-arch-ppc	2005-08-12 18:18:43.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc/pgtable.h	2005-08-12 18:39:57.000000000 +0200
@@ -309,8 +309,8 @@ extern unsigned long ioremap_bot, iorema
 /* Definitions for 60x, 740/750, etc. */
 #define _PAGE_PRESENT	0x001	/* software: pte contains a translation */
 #define _PAGE_HASHPTE	0x002	/* hash_page has made an HPTE for this pte */
-#define _PAGE_FILE	0x004	/* when !present: nonlinear file mapping */
 #define _PAGE_USER	0x004	/* usermode access allowed */
+#define _PAGE_FILE	0x008	/* when !present: nonlinear file mapping */
 #define _PAGE_GUARDED	0x008	/* G: prohibit speculative access */
 #define _PAGE_COHERENT	0x010	/* M: enforce memory coherence (SMP systems) */
 #define _PAGE_NO_CACHE	0x020	/* I: cache inhibit */
@@ -728,9 +728,16 @@ extern void paging_init(void);
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
 
 /* Encode and decode a nonlinear file mapping entry */
-#define PTE_FILE_MAX_BITS	29
-#define pte_to_pgoff(pte)	(pte_val(pte) >> 3)
-#define pgoff_to_pte(off)	((pte_t) { ((off) << 3) | _PAGE_FILE })
+#define PTE_FILE_MAX_BITS	27
+#define pte_to_pgoff(pte)	(((pte_val(pte) & ~0x7ff) >> 5)		\
+				 | ((pte_val(pte) & 0x3f0) >> 4))
+#define pte_to_pgprot(pte)	\
+__pgprot((pte_val(pte) & (_PAGE_USER|_PAGE_RW|_PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot)					\
+	((pte_t) { (((off) << 5) & ~0x7ff) | (((off) << 4) & 0x3f0)	\
+		   | (pgprot_val(prot) & (_PAGE_USER|_PAGE_RW))		\
+		   | _PAGE_FILE })
 
 /* CONFIG_APUS */
 /* For virtual address to physical address conversion */
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
