Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D8Ndg-0002Qp-T8 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:11:36 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1D8Ndf-0001ys-84 for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 07 Mar 2005 11:11:36 -0800
Message-Id: <200503072037.j27KbJbc003952@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/16] UML - slirp driver tells the network it's
	not ethernet
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
Date: Mon, 07 Mar 2005 15:37:19 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, tzachar@cs.bgu.ac.il

From: Nir Tzachar <tzachar@cs.bgu.ac.il>
Tell the netdevice code that a slirp device is not ethernet.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/slirp_kern.c	2005-03-05 12:07:31.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/slirp_kern.c	2005-03-05 12:08:16.000000000 -0500
@@ -33,8 +33,11 @@
 
 	dev->init = NULL;
 	dev->hard_header_len = 0;
-	dev->addr_len = 4;
-	dev->type = ARPHRD_ETHER;
+	dev->header_cache_update = NULL;
+	dev->hard_header_cache = NULL;
+	dev->hard_header = NULL;
+	dev->addr_len = 0;
+	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 256;
 	dev->flags = IFF_NOARP;
 	printk("SLIRP backend - command line:");



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
