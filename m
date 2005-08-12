Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3h-0004fP-TD	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:09 -0700
Received: from mail-relay-4.tiscali.it ([213.205.33.44])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3h-0000kw-6e
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:09 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182121.4F80824E7DB@zion.home.lan>
Subject: [uml-devel] [patch 10/39] remap_file_pages protection support: i386
	and x86-64 bits
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
Date: Fri, 12 Aug 2005 20:21:21 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Update pte encoding macros for i386 and x86-64.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-i386/pgtable-2level.h |   15 ++++++++++-----
 linux-2.6.git-paolo/include/asm-i386/pgtable-3level.h |   11 ++++++++++-
 linux-2.6.git-paolo/include/asm-x86_64/pgtable.h      |   12 +++++++++++-
 3 files changed, 31 insertions(+), 7 deletions(-)

diff -puN include/asm-i386/pgtable-2level.h~rfp-arch-i386-x86_64 include/asm-i386/pgtable-2level.h
--- linux-2.6.git/include/asm-i386/pgtable-2level.h~rfp-arch-i386-x86_64	2005-08-11 11:42:28.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/pgtable-2level.h	2005-08-11 11:42:28.000000000 +0200
@@ -48,16 +48,21 @@ static inline int pte_exec_kernel(pte_t 
 }
 
 /*
- * Bits 0, 6 and 7 are taken, split up the 29 bits of offset
+ * Bits 0, 1, 6 and 7 are taken, split up the 28 bits of offset
  * into this range:
  */
-#define PTE_FILE_MAX_BITS	29
+#define PTE_FILE_MAX_BITS	28
 
 #define pte_to_pgoff(pte) \
-	((((pte).pte_low >> 1) & 0x1f ) + (((pte).pte_low >> 8) << 5 ))
+	((((pte).pte_low >> 2) & 0xf ) + (((pte).pte_low >> 8) << 4 ))
+#define pte_to_pgprot(pte) \
+	__pgprot(((pte).pte_low & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| (((pte).pte_low & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
 
-#define pgoff_to_pte(off) \
-	((pte_t) { (((off) & 0x1f) << 1) + (((off) >> 5) << 8) + _PAGE_FILE })
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { (((off) & 0xf) << 2) + (((off) >> 4) << 8) + \
+	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE })
 
 /* Encode and de-code a swap entry */
 #define __swp_type(x)			(((x).val >> 1) & 0x1f)
diff -puN include/asm-i386/pgtable-3level.h~rfp-arch-i386-x86_64 include/asm-i386/pgtable-3level.h
--- linux-2.6.git/include/asm-i386/pgtable-3level.h~rfp-arch-i386-x86_64	2005-08-11 11:42:28.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/pgtable-3level.h	2005-08-11 11:42:28.000000000 +0200
@@ -145,7 +145,16 @@ static inline pmd_t pfn_pmd(unsigned lon
  * put the 32 bits of offset into the high part.
  */
 #define pte_to_pgoff(pte) ((pte).pte_high)
-#define pgoff_to_pte(off) ((pte_t) { _PAGE_FILE, (off) })
+
+#define pte_to_pgprot(pte) \
+	__pgprot(((pte).pte_low & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| (((pte).pte_low & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { _PAGE_FILE + \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) , (off) })
+
 #define PTE_FILE_MAX_BITS       32
 
 /* Encode and de-code a swap entry */
diff -puN include/asm-x86_64/pgtable.h~rfp-arch-i386-x86_64 include/asm-x86_64/pgtable.h
--- linux-2.6.git/include/asm-x86_64/pgtable.h~rfp-arch-i386-x86_64	2005-08-11 11:42:28.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-x86_64/pgtable.h	2005-08-11 11:42:28.000000000 +0200
@@ -343,9 +343,19 @@ static inline pud_t *__pud_offset_k(pud_
 #define pmd_pfn(x)  ((pmd_val(x) >> PAGE_SHIFT) & __PHYSICAL_MASK)
 
 #define pte_to_pgoff(pte) ((pte_val(pte) & PHYSICAL_PAGE_MASK) >> PAGE_SHIFT)
-#define pgoff_to_pte(off) ((pte_t) { ((off) << PAGE_SHIFT) | _PAGE_FILE })
 #define PTE_FILE_MAX_BITS __PHYSICAL_MASK_SHIFT
 
+#define pte_to_pgprot(pte) \
+	__pgprot((pte_val(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
+		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
+			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
+
+#define pgoff_prot_to_pte(off, prot) \
+	((pte_t) { _PAGE_FILE + \
+		(pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + \
+			((off) << PAGE_SHIFT) })
+
+
 /* PTE - Level 1 access. */
 
 /* page, protection -> pte */
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
