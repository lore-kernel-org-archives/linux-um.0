Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e4u-0004kS-PD	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:16:24 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e4u-0000QX-3I
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:16:24 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182118.C9FBD24E7D9@zion.home.lan>
Subject: [uml-devel] [patch 09/39] remap_file_pages protection support:
	improvement for UML bits
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
Date: Fri, 12 Aug 2005 20:21:18 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


Recover one bit by additionally using _PAGE_NEWPROT. Since I wasn't sure this
would work, I've split this out. We rely on the fact that pte_newprot always
checks first if the PTE is marked present.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-um/pgtable-2level.h |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff -puN include/asm-um/pgtable-2level.h~rfp-arch-uml-improv include/asm-um/pgtable-2level.h
--- linux-2.6.git/include/asm-um/pgtable-2level.h~rfp-arch-uml-improv	2005-08-07 19:09:34.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable-2level.h	2005-08-07 19:09:34.000000000 +0200
@@ -72,19 +72,19 @@ static inline void set_pte(pte_t *pteptr
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
- * Bits 0 to 5 are taken, split up the 26 bits of offset
+ * Bits 0, 1, 3 to 5 are taken, split up the 27 bits of offset
  * into this range:
  */
-#define PTE_FILE_MAX_BITS	26
+#define PTE_FILE_MAX_BITS	27
 
-#define pte_to_pgoff(pte) (pte_val(pte) >> 6)
+#define pte_to_pgoff(pte) (((pte_val(pte) >> 6) << 1) | ((pte_val(pte) >> 2) & 0x1))
 #define pte_to_pgprot(pte) \
 	__pgprot((pte_val(pte) & (_PAGE_RW | _PAGE_PROTNONE)) \
 		| ((pte_val(pte) & _PAGE_PROTNONE) ? 0 : \
 			(_PAGE_USER | _PAGE_PRESENT)) | _PAGE_ACCESSED)
 
 #define pgoff_prot_to_pte(off, prot) \
-	((pte_t) { ((off) << 6) + \
-	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE })
+	__pte((((off) >> 1) << 6) + (((off) & 0x1) << 2) + \
+	 (pgprot_val(prot) & (_PAGE_RW | _PAGE_PROTNONE)) + _PAGE_FILE)
 
 #endif
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
