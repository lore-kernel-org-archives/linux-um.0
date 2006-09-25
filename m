Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1GRvIp-0004LW-KS for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:39 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1GRvIo-0005wD-4J
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Sep 2006 11:35:39 -0700
Message-Id: <200609251834.k8PIYU2o005026@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Mon, 25 Sep 2006 14:34:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 2/8] UML - Get rid of ZONE_DMA use
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

ZONE_DMA is now dependent on CONFIG_ZONE_DMA, which UML doesn't define.
So, let's change ZONE_DMA to ZONE_NORMAL.

This is prompted by optional-zone_dma-in-the-vm.patch, but should be harmless
on its own.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/mem.c	2006-09-22 13:17:47.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/mem.c	2006-09-22 13:18:11.000000000 -0400
@@ -226,7 +226,8 @@ void paging_init(void)
 	for(i = 0; i < ARRAY_SIZE(zones_size); i++)
 		zones_size[i] = 0;
 
-	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
+	zones_size[ZONE_NORMAL] = (end_iomem >> PAGE_SHIFT) -
+		(uml_physmem >> PAGE_SHIFT);
 #ifdef CONFIG_HIGHMEM
 	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
 #endif


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
