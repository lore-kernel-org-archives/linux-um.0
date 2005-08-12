Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3ean-0006aN-O9	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:21 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eam-0007nB-VF
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:21 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183605.E823924E7D6@zion.home.lan>
Subject: [uml-devel] [patch 27/39] remap_file_pages protection support: fixups
	to ppc32 bits
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
Date: Fri, 12 Aug 2005 20:36:05 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, paulus@samba.org


From: Paul Mackerras <paulus@samba.org>

When I tried -mm4 on a ppc32 box, it hit a BUG because I hadn't excluded
_PAGE_FILE from the bits used for swap entries.  While looking at that I
realised that the pte_to_pgoff and pgoff_prot_to_pte macros were wrong for
4xx and 8xx (embedded) PPC chips, since they use

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-ppc/pgtable.h |   48 +++++++++++++++++++++-----
 1 files changed, 39 insertions(+), 9 deletions(-)

diff -puN include/asm-ppc/pgtable.h~rfp-arch-ppc32-pgtable-fixes include/asm-ppc/pgtable.h
--- linux-2.6.git/include/asm-ppc/pgtable.h~rfp-arch-ppc32-pgtable-fixes	2005-08-12 18:18:44.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-ppc/pgtable.h	2005-08-12 18:18:44.000000000 +0200
@@ -205,6 +205,7 @@ extern unsigned long ioremap_bot, iorema
  */
 #define _PAGE_PRESENT	0x00000001		/* S: PTE valid */
 #define	_PAGE_RW	0x00000002		/* S: Write permission */
+#define _PAGE_FILE	0x00000004		/* S: nonlinear file mapping */
 #define	_PAGE_DIRTY	0x00000004		/* S: Page dirty */
 #define _PAGE_ACCESSED	0x00000008		/* S: Page referenced */
 #define _PAGE_HWWRITE	0x00000010		/* H: Dirty & RW */
@@ -213,7 +214,6 @@ extern unsigned long ioremap_bot, iorema
 #define	_PAGE_ENDIAN	0x00000080		/* H: E bit */
 #define	_PAGE_GUARDED	0x00000100		/* H: G bit */
 #define	_PAGE_COHERENT	0x00000200		/* H: M bit */
-#define _PAGE_FILE	0x00000400		/* S: nonlinear file mapping */
 #define	_PAGE_NO_CACHE	0x00000400		/* H: I bit */
 #define	_PAGE_WRITETHRU	0x00000800		/* H: W bit */
 
@@ -724,20 +724,50 @@ extern void paging_init(void);
 #define __swp_type(entry)		((entry).val & 0x1f)
 #define __swp_offset(entry)		((entry).val >> 5)
 #define __swp_entry(type, offset)	((swp_entry_t) { (type) | ((offset) << 5) })
+
+#if defined(CONFIG_4xx) || defined(CONFIG_8xx)
+/* _PAGE_FILE and _PAGE_PRESENT are in the bottom 3 bits on all these chips. */
 #define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val(pte) >> 3 })
 #define __swp_entry_to_pte(x)		((pte_t) { (x).val << 3 })
+#else	/* Classic PPC */
+#define __pte_to_swp_entry(pte)		\
+    ((swp_entry_t) { ((pte_val(pte) >> 3) & ~1) | ((pte_val(pte) >> 2) & 1) })
+#define __swp_entry_to_pte(x)		\
+    ((pte_t) { (((x).val & ~1) << 3) | (((x).val & 1) << 2) })
+#endif
 
 /* Encode and decode a nonlinear file mapping entry */
-#define PTE_FILE_MAX_BITS	27
-#define pte_to_pgoff(pte)	(((pte_val(pte) & ~0x7ff) >> 5)		\
-				 | ((pte_val(pte) & 0x3f0) >> 4))
-#define pte_to_pgprot(pte)	\
-__pgprot((pte_val(pte) & (_PAGE_USER|_PAGE_RW|_PAGE_PRESENT)) | _PAGE_ACCESSED)
+/* We can't use any the _PAGE_PRESENT, _PAGE_FILE, _PAGE_USER, _PAGE_RW,
+   or _PAGE_HASHPTE bits for storing a page offset. */
+#if defined(CONFIG_40x)
+/* 40x, avoid the 0x53 bits - to simplify things, avoid 0x73 */ */
+#define __pgoff_split(x)	((((x) << 5) & ~0x7f) | (((x) << 2) & 0xc))
+#define __pgoff_glue(x)		((((x) & ~0x7f) >> 5) | (((x) & 0xc) >> 2))
+#elif defined(CONFIG_44x)
+/* 44x, avoid the 0x47 bits */
+#define __pgoff_split(x)	((((x) << 4) & ~0x7f) | (((x) << 3) & 0x38))
+#define __pgoff_glue(x)		((((x) & ~0x7f) >> 4) | (((x) & 0x38) >> 3))
+#elif defined(CONFIG_8xx)
+/* 8xx, avoid the 0x843 bits */
+#define __pgoff_split(x)	((((x) << 4) & ~0xfff) | (((x) << 3) & 0x780) \
+				 | (((x) << 2) & 0x3c))
+#define __pgoff_glue(x)		((((x) & ~0xfff) >> 4) | (((x) & 0x780) >> 3))\
+				 | (((x) & 0x3c) >> 2))
+#else
+/* classic PPC, avoid the 0x40f bits */
+#define __pgoff_split(x)	((((x) << 5) & ~0x7ff) | (((x) << 4) & 0x3f0))
+#define __pgoff_glue(x)		((((x) & ~0x7ff) >> 5) | (((x) & 0x3f0) >> 4))
+#endif
 
+#define PTE_FILE_MAX_BITS	27
+#define pte_to_pgoff(pte)	__pgoff_glue(pte_val(pte))
 #define pgoff_prot_to_pte(off, prot)					\
-	((pte_t) { (((off) << 5) & ~0x7ff) | (((off) << 4) & 0x3f0)	\
-		   | (pgprot_val(prot) & (_PAGE_USER|_PAGE_RW))		\
-		   | _PAGE_FILE })
+	((pte_t) { __pgoff_split(off) | _PAGE_FILE |			\
+		   (pgprot_val(prot) & (_PAGE_USER|_PAGE_RW)) })
+
+#define pte_to_pgprot(pte)						\
+	__pgprot((pte_val(pte) & (_PAGE_USER|_PAGE_RW|_PAGE_PRESENT))	\
+		 | _PAGE_ACCESSED)
 
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
