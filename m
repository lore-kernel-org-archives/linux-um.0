Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e4t-0004kK-G1	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:16:23 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e4r-0000zY-L2
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:16:23 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182116.3746D24E7D7@zion.home.lan>
Subject: [uml-devel] [patch 08/39] remap_file_pages protection support: uml
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
Date: Fri, 12 Aug 2005 20:21:15 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Update pte encoding macros for UML.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/pgtable-2level.h |   15 ++++++++++----
 linux-2.6.git-paolo/include/asm-um/pgtable-3level.h |   21 +++++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

diff -puN include/asm-um/pgtable-2level.h~rfp-arch-uml include/asm-um/pgtable-2level.h
--- linux-2.6.git/include/asm-um/pgtable-2level.h~rfp-arch-uml	2005-08-11 11:23:21.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-2level.h	2005-08-11 11:23:21.000000000 +0200
@@ -72,12 +72,19 @@ static inline void set_pte(pte_t *pteptr
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
- * Bits 0 through 3 are taken
+ * Bits 0 to 5 are taken, split up the 26 bits of offset
+ * into this range:
  */
-#define PTE_FILE_MAX_BITS	28
+#define PTE_FILE_MAX_BITS	26
 
-#define pte_to_pgoff(pte) (pte_val(pte) >> 4)
+#define pte_to_pgoff(pte) (pte_val(pte) >> 6)
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
 
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 4) + _PAGE_FILE })
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { ((off) << 6) + \
+	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE })
 
 #endif
diff -puN include/asm-um/pgtable-3level.h~rfp-arch-uml include/asm-um/pgtable-3level.h
--- linux-2.6.git/include/asm-um/pgtable-3level.h~rfp-arch-uml	2005-08-11 11:23:21.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-3level.h	2005-08-11 11:23:21.000000000 +0200
@@ -140,25 +140,36 @@ static inline pmd_t pfn_pmd(pfn_t page_n
 }
 
 /*
- * Bits 0 through 3 are taken in the low part of the pte,
+ * Bits 0 through 5 are taken in the low part of the pte,
  * put the 32 bits of offset into the high part.
  */
 #define PTE_FILE_MAX_BITS	32
 
+
 #ifdef CONFIG_64BIT
 
 #define pte_to_pgoff(p) ((p).pte >> 32)
-
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 32) | _PAGE_FILE })
+#define pgoff_to_pte(off) ((pte_t) { ((off) << 32) | _PAGE_FILE | \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) })
+#define pte_flags(pte) pte_val(pte)
 
 #else
 
 #define pte_to_pgoff(pte) ((pte).pte_high)
-
-#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+#define pgoff_prot_to_pte(off, prot) ((pte_t) { \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) | _PAGE_FILE, \
+		(off) })
+/* Don't use pte_val below, useless to join the two halves */
+#define pte_flags(pte) ((pte).pte_low)
 
 #endif
 
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_flags(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| ((pte_flags(pte) & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
+#undef pte_flags
+
 #endif
 
 /*
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
