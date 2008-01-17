Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcU1-000186-OK for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcU0-00014M-Ot
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:41:09 -0800
Date: Thu, 17 Jan 2008 16:40:44 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214044.GA6742@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 11/20] UML - Remove unused fields from mm_context
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

The 3-level page table fixes forgot to remove a couple now-unused
fields from struct mm_context.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/include/um_mmu.h |    4 ----
 1 file changed, 4 deletions(-)

Index: linux-2.6.22/arch/um/include/um_mmu.h
===================================================================
--- linux-2.6.22.orig/arch/um/include/um_mmu.h	2007-12-19 13:17:20.000000000 -0500
+++ linux-2.6.22/arch/um/include/um_mmu.h	2007-12-19 19:34:49.000000000 -0500
@@ -12,10 +12,6 @@
 
 typedef struct mm_context {
 	struct mm_id id;
-	unsigned long last_page_table;
-#ifdef CONFIG_3_LEVEL_PGTABLES
-	unsigned long last_pmd;
-#endif
 	struct uml_ldt ldt;
 } mm_context_t;
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
