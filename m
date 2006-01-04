Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EuFjX-0006M5-4u for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:47 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EuFjV-0005PB-SU
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 04 Jan 2006 12:59:47 -0800
Message-Id: <200601042152.k04Lq8Sh009263@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 9/9] UML - Free network IRQ correctly
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
Date: Wed, 04 Jan 2006 16:52:08 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Free the network IRQ when closing down the network devices at shutdown.
Delete the device from the opened devices list on close.
These prevent an -EBADF when later disabling SIGIO on all extant 
descriptors and a complaint from free_irq about freeing the IRQ twice.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/net_kern.c	2006-01-03 17:29:31.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/net_kern.c	2006-01-04 14:57:58.000000000 -0500
@@ -150,6 +150,7 @@ static int uml_net_close(struct net_devi
 	if(lp->close != NULL)
 		(*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
+	list_del(&lp->list);
 
 	spin_unlock(&lp->lock);
 	return 0;
@@ -715,6 +716,7 @@ static void close_devices(void)
 
 	list_for_each(ele, &opened){
 		lp = list_entry(ele, struct uml_net_private, list);
+		free_irq(lp->dev->irq, lp->dev);
 		if((lp->close != NULL) && (lp->fd >= 0))
 			(*lp->close)(lp->fd, &lp->user);
 		if(lp->remove != NULL) (*lp->remove)(&lp->user);



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
