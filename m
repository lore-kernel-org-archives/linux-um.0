Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E3e3n-0004g7-60	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:15 -0700
Received: from mail-relay-2.tiscali.it ([213.205.33.42])
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E3e3m-0000lw-Ck
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Aug 2005 11:15:15 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050812182110.D887224E7D1@zion.home.lan>
Subject: [uml-devel] [patch 06/39] correct _PAGE_FILE comment
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
Date: Fri, 12 Aug 2005 20:21:10 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it


_PAGE_FILE does not indicate whether a file is in page / swap cache, it is set
just for non-linear PTE's. Correct the comment for i386, x86_64, UML. Also
clearify _PAGE_NONE.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.git-paolo/include/asm-i386/pgtable.h   |   10 +++++-----
 linux-2.6.git-paolo/include/asm-um/pgtable.h     |    8 +++++---
 linux-2.6.git-paolo/include/asm-x86_64/pgtable.h |    2 +-
 3 files changed, 11 insertions(+), 9 deletions(-)

diff -puN include/asm-i386/pgtable.h~correct-_PAGE_FILE-comment include/asm-i386/pgtable.h
--- linux-2.6.git/include/asm-i386/pgtable.h~correct-_PAGE_FILE-comment	2005-08-11 11:17:04.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-i386/pgtable.h	2005-08-11 11:17:04.000000000 +0200
@@ -86,9 +86,7 @@ void paging_init(void);
 #endif
 
 /*
- * The 4MB page is guessing..  Detailed in the infamous "Chapter H"
- * of the Pentium details, but assuming intel did the straightforward
- * thing, this bit set in the page directory entry just means that
+ * _PAGE_PSE set in the page directory entry just means that
  * the page directory entry points directly to a 4MB-aligned block of
  * memory. 
  */
@@ -119,8 +117,10 @@ void paging_init(void);
 #define _PAGE_UNUSED2	0x400
 #define _PAGE_UNUSED3	0x800
 
-#define _PAGE_FILE	0x040	/* set:pagecache unset:swap */
-#define _PAGE_PROTNONE	0x080	/* If not present */
+/* If _PAGE_PRESENT is clear, we use these: */
+#define _PAGE_FILE	0x040	/* nonlinear file mapping, saved PTE; unset:swap */
+#define _PAGE_PROTNONE	0x080	/* if the user mapped it with PROT_NONE;
+				   pte_present gives true */
 #ifdef CONFIG_X86_PAE
 #define _PAGE_NX	(1ULL<<_PAGE_BIT_NX)
 #else
diff -puN include/asm-x86_64/pgtable.h~correct-_PAGE_FILE-comment include/asm-x86_64/pgtable.h
--- linux-2.6.git/include/asm-x86_64/pgtable.h~correct-_PAGE_FILE-comment	2005-08-11 11:17:04.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-x86_64/pgtable.h	2005-08-11 11:17:04.000000000 +0200
@@ -143,7 +143,7 @@ extern inline void pgd_clear (pgd_t * pg
 #define _PAGE_ACCESSED	0x020
 #define _PAGE_DIRTY	0x040
 #define _PAGE_PSE	0x080	/* 2MB page */
-#define _PAGE_FILE	0x040	/* set:pagecache, unset:swap */
+#define _PAGE_FILE	0x040	/* nonlinear file mapping, saved PTE; unset:swap */
 #define _PAGE_GLOBAL	0x100	/* Global TLB entry */
 
 #define _PAGE_PROTNONE	0x080	/* If not present */
diff -puN include/asm-um/pgtable.h~correct-_PAGE_FILE-comment include/asm-um/pgtable.h
--- linux-2.6.git/include/asm-um/pgtable.h~correct-_PAGE_FILE-comment	2005-08-11 11:17:04.000000000 +0200
+++ linux-2.6.git-paolo/include/asm-um/pgtable.h	2005-08-11 11:17:04.000000000 +0200
@@ -16,13 +16,15 @@
 
 #define _PAGE_PRESENT	0x001
 #define _PAGE_NEWPAGE	0x002
-#define _PAGE_NEWPROT   0x004
-#define _PAGE_FILE	0x008   /* set:pagecache unset:swap */
-#define _PAGE_PROTNONE	0x010	/* If not present */
+#define _PAGE_NEWPROT	0x004
 #define _PAGE_RW	0x020
 #define _PAGE_USER	0x040
 #define _PAGE_ACCESSED	0x080
 #define _PAGE_DIRTY	0x100
+/* If _PAGE_PRESENT is clear, we use these: */
+#define _PAGE_FILE	0x008	/* nonlinear file mapping, saved PTE; unset:swap */
+#define _PAGE_PROTNONE	0x010	/* if the user mapped it with PROT_NONE;
+				   pte_present gives true */
 
 #ifdef CONFIG_3_LEVEL_PGTABLES
 #include "asm/pgtable-3level.h"
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
