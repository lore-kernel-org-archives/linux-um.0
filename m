Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3eaj-0006Zm-Pw	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:17 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3eaj-0007aH-FR
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:49:17 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812183608.6AEB924E7D8@zion.home.lan>
Subject: [uml-devel] [patch 28/39] remap_file_pages protection support:
	sparc64 bits.
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
Date: Fri, 12 Aug 2005 20:36:08 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, wli@holomorphy.com


From: William Lee Irwin III <wli@holomorphy.com>

Implement remap_file_pages-with-per-page-protections for sparc64.

See

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/remap-file-pages-prot-2.6.4-rc1-mm1-A1.patch

and

ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.4/2.6.4-mm1/broken-out/remap-file-pages-prot-ia64-2.6.4-rc2-mm1-A0.patch

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-sparc64/pgtable.h |   13 ++++++++++---
 1 files changed, 10 insertions(+), 3 deletions(-)

diff -puN include/asm-sparc64/pgtable.h~rfp-arch-sparc64 include/asm-sparc64/pgtable.h
--- linux-2.6.git/include/asm-sparc64/pgtable.h~rfp-arch-sparc64	2005-08-12 18:41:31.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-sparc64/pgtable.h	2005-08-12 18:41:31.000000000 +0200
@@ -367,9 +367,16 @@ static inline pte_t mk_pte_io(unsigned l
 
 /* File offset in PTE support. */
 #define pte_file(pte)		(pte_val(pte) & _PAGE_FILE)
-#define pte_to_pgoff(pte)	(pte_val(pte) >> PAGE_SHIFT)
-#define pgoff_to_pte(off)	(__pte(((off) << PAGE_SHIFT) | _PAGE_FILE))
-#define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 1UL)
+#define __pte_to_pgprot(pte) \
+		__pgprot(pte_val(pte) & (_PAGE_READ|_PAGE_WRITE))
+#define __file_pte_to_pgprot(pte) \
+		__pgprot(((pte_val(pte) >> PAGE_SHIFT) & 0x3UL) << 8)
+#define pte_to_pgprot(pte) \
+	(pte_file(pte) ? __file_pte_to_pgprot(pte) : __pte_to_pgprot(pte))
+#define pte_to_pgoff(pte)	(pte_val(pte) >> (PAGE_SHIFT+2))
+#define pgoff_prot_to_pte(off, prot) \
+	((__pte(((off) | ((pgprot_val(prot) >> 8) & 0x3UL)))) << (PAGE_SHIFT+2) | _PAGE_FILE)
+#define PTE_FILE_MAX_BITS	(64UL - PAGE_SHIFT - 3UL)
 
 extern unsigned long prom_virt_to_phys(unsigned long, int *);
 
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
