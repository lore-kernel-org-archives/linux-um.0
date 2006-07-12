Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1G0hkU-0000WG-Q0 for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 09:39:42 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1G0hkS-0007gN-WA
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 12 Jul 2006 09:39:42 -0700
Message-Id: <200607121639.k6CGdiMw021221@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Wed, 12 Jul 2006 12:39:43 -0400
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/5] UML - Fix ZONE_HIGHMEM compilation error
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

References to ZONE_HIGHMEM need to depend on CONFIG_HIGHMEM.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/kernel/mem.c
===================================================================
--- linux-2.6.17.orig/arch/um/kernel/mem.c	2006-07-12 11:29:02.000000000 -0400
+++ linux-2.6.17/arch/um/kernel/mem.c	2006-07-12 11:29:11.000000000 -0400
@@ -226,7 +226,9 @@ void paging_init(void)
 	for(i=0;i<sizeof(zones_size)/sizeof(zones_size[0]);i++) 
 		zones_size[i] = 0;
 	zones_size[ZONE_DMA] = (end_iomem >> PAGE_SHIFT) - (uml_physmem >> PAGE_SHIFT);
+#ifdef CONFIG_HIGHMEM
 	zones_size[ZONE_HIGHMEM] = highmem >> PAGE_SHIFT;
+#endif
 	free_area_init(zones_size);
 
 	/*



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
