Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H2u6L-0001QP-Jt for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:37 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H2u6K-0007S0-QL
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 05 Jan 2007 10:47:37 -0800
Message-Id: <200701051842.l05IgHvh004642@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Fri, 05 Jan 2007 13:42:17 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 8/9] UML - Locking comments in iomem driver
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
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Comment some lack of locking in the iomem driver.

Also, a couple of variables are in the wrong place, so they are moved.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/kernel/mem.c     |   10 ----------
 arch/um/kernel/physmem.c |   17 +++++++++++++++++
 2 files changed, 17 insertions(+), 10 deletions(-)
Index: linux-2.6.18-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/mem.c	2007-01-03 11:36:39.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/mem.c	2007-01-03 11:38:35.000000000 -0500
@@ -368,16 +368,6 @@ struct page *pte_alloc_one(struct mm_str
 	return pte;
 }
 
-struct iomem_region *iomem_regions = NULL;
-int iomem_size = 0;
-
-extern int parse_iomem(char *str, int *add) __init;
-
-__uml_setup("iomem=", parse_iomem,
-"iomem=<name>,<file>\n"
-"    Configure <file> as an IO memory region named <name>.\n\n"
-);
-
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: linux-2.6.18-mm/arch/um/kernel/physmem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/physmem.c	2007-01-01 13:34:20.000000000 -0500
+++ linux-2.6.18-mm/arch/um/kernel/physmem.c	2007-01-03 11:38:45.000000000 -0500
@@ -398,6 +398,23 @@ __uml_setup("mem=", uml_mem_setup,
 "	Example: mem=64M\n\n"
 );
 
+extern int __init parse_iomem(char *str, int *add);
+
+__uml_setup("iomem=", parse_iomem,
+"iomem=<name>,<file>\n"
+"    Configure <file> as an IO memory region named <name>.\n\n"
+);
+
+/*
+ * This list is constructed in parse_iomem and addresses filled in in
+ * setup_iomem, both of which run during early boot.  Afterwards, it's
+ * unchanged.
+ */
+struct iomem_region *iomem_regions = NULL;
+
+/* Initialized in parse_iomem */
+int iomem_size = 0;
+
 unsigned long find_iomem(char *driver, unsigned long *len_out)
 {
 	struct iomem_region *region = iomem_regions;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
