Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IgNcT-0001da-5i for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 09:44:13 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IgNcR-0003Hn-G0
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 12 Oct 2007 09:44:13 -0700
Date: Fri, 12 Oct 2007 12:43:57 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20071012164357.GA7704@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - header_ops conversion needed for
	non-ethernet drivers
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
Cc: lkml@c2.user-mode-linux.org, Alexander Viro <viro@zeniv.linux.org.uk>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

UML's two non-ethernet drivers need some header_ops conversion.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/slip_kern.c  |    4 +---
 arch/um/drivers/slirp_kern.c |    4 +---
 2 files changed, 2 insertions(+), 6 deletions(-)

Index: linux-2.6.22/arch/um/drivers/slip_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/slip_kern.c	2007-10-12 12:09:00.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/slip_kern.c	2007-10-12 12:24:37.000000000 -0400
@@ -31,10 +31,8 @@ void slip_init(struct net_device *dev, v
 	slip_proto_init(&spri->slip);
 
 	dev->init = NULL;
-	dev->header_cache_update = NULL;
-	dev->hard_header_cache = NULL;
-	dev->hard_header = NULL;
 	dev->hard_header_len = 0;
+	dev->header_ops = NULL;
 	dev->addr_len = 0;
 	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 256;
Index: linux-2.6.22/arch/um/drivers/slirp_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/slirp_kern.c	2007-10-12 12:09:00.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/slirp_kern.c	2007-10-12 12:24:42.000000000 -0400
@@ -34,9 +34,7 @@ void slirp_init(struct net_device *dev, 
 
 	dev->init = NULL;
 	dev->hard_header_len = 0;
-	dev->header_cache_update = NULL;
-	dev->hard_header_cache = NULL;
-	dev->hard_header = NULL;
+	dev->header_ops = NULL;
 	dev->addr_len = 0;
 	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 256;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
