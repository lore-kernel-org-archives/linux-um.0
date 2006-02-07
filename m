Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1F6IV6-0003pt-1W for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:40 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1F6IV4-0008AW-IR
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Feb 2006 18:22:40 -0800
Message-Id: <200602070224.k172O0oH009669@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 5/8] UML - Balance list_add and list_del in the
	network driver
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
Date: Mon, 06 Feb 2006 21:24:00 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The network driver added an interface to the "opened" list when it was
configured, not when it was brought up, and removed it when it was taken
down.  A sequence of ifconfig up, ifconfig down, ... caused it to be removed
multiple times from the list without being added in between, resulting in
a crash.  This patch moves the add to when the interface is brought up.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/drivers/net_kern.c	2006-02-06 17:33:55.000000000 -0500
+++ linux-2.6.15/arch/um/drivers/net_kern.c	2006-02-06 17:35:58.000000000 -0500
@@ -131,9 +131,8 @@ static int uml_net_open(struct net_devic
 			     SA_INTERRUPT | SA_SHIRQ, dev->name, dev);
 	if(err != 0){
 		printk(KERN_ERR "uml_net_open: failed to get irq(%d)\n", err);
-		if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
-		lp->fd = -1;
 		err = -ENETUNREACH;
+		goto out_close;
 	}
 
 	lp->tl.data = (unsigned long) &lp->user;
@@ -145,9 +144,19 @@ static int uml_net_open(struct net_devic
 	 */
 	while((err = uml_net_rx(dev)) > 0) ;
 
- out:
 	spin_unlock(&lp->lock);
-	return(err);
+
+	spin_lock(&opened_lock);
+	list_add(&lp->list, &opened);
+	spin_unlock(&opened_lock);
+
+	return 0;
+out_close:
+	if(lp->close != NULL) (*lp->close)(lp->fd, &lp->user);
+	lp->fd = -1;
+out:
+	spin_unlock(&lp->lock);
+	return err;
 }
 
 static int uml_net_close(struct net_device *dev)
@@ -161,9 +170,13 @@ static int uml_net_close(struct net_devi
 	if(lp->close != NULL)
 		(*lp->close)(lp->fd, &lp->user);
 	lp->fd = -1;
-	list_del(&lp->list);
 
 	spin_unlock(&lp->lock);
+
+	spin_lock(&opened_lock);
+	list_del(&lp->list);
+	spin_unlock(&opened_lock);
+
 	return 0;
 }
 
@@ -410,11 +423,7 @@ static int eth_configure(int n, void *in
 	if (device->have_mac)
 		set_ether_mac(dev, device->mac);
 
-	spin_lock(&opened_lock);
-	list_add(&lp->list, &opened);
-	spin_unlock(&opened_lock);
-
-	return(0);
+	return 0;
 }
 
 static struct uml_net *find_device(int n)



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=103432&bid=230486&dat=121642
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
