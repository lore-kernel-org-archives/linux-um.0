Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HWGVt-00028m-IK for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:35:21 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HWGRe-000309-93
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Mar 2007 11:30:58 -0700
Date: Tue, 27 Mar 2007 14:27:49 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070327182749.GA8411@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 4/6] UML - Fix pte bit collision
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Andrew Morton <akpm@osdl.org>
Cc: Miklos Szeredi <mszeredi@suse.cz>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

From: Miklos Szeredi <mszeredi@suse.cz>

_PAGE_PROTNONE conflicts with the lowest bit of pgoff.  This causes
all sorts of weirdness when nonlinear mappings are used.

Took me a good half day to track this down.

Signed-off-by: Miklos Szeredi <mszeredi@suse.cz>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 include/asm-um/pgtable-2level.h |    8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

Index: linux-2.6.21-mm/include/asm-um/pgtable-2level.h
===================================================================
--- linux-2.6.21-mm.orig/include/asm-um/pgtable-2level.h	2007-03-27 12:34:31.000000000 -0400
+++ linux-2.6.21-mm/include/asm-um/pgtable-2level.h	2007-03-27 12:52:12.000000000 -0400
@@ -45,12 +45,12 @@ static inline void pgd_mkuptodate(pgd_t 
 	((unsigned long) __va(pmd_val(pmd) & PAGE_MASK))
 
 /*
- * Bits 0 through 3 are taken
+ * Bits 0 through 4 are taken
  */
-#define PTE_FILE_MAX_BITS	28
+#define PTE_FILE_MAX_BITS	27
 
-#define pte_to_pgoff(pte) (pte_val(pte) >> 4)
+#define pte_to_pgoff(pte) (pte_val(pte) >> 5)
 
-#define pgoff_to_pte(off) ((pte_t) { ((off) << 4) + _PAGE_FILE })
+#define pgoff_to_pte(off) ((pte_t) { ((off) << 5) + _PAGE_FILE })
 
 #endif

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
