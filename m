Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HZYZw-00031V-Qm for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2007 13:29:08 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HZYZw-0004o2-6R
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 05 Apr 2007 13:29:08 -0700
Date: Thu, 5 Apr 2007 16:24:52 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070405202452.GA8923@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 1/4] UML - drivers get release methods
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
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Define release methods for the ubd and net drivers.  They contain as
much of the remove methods as make sense.  All error checking must
have already been done as well as anything else that might be holding
a reference on the device kobject.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/net_kern.c |   19 +++++++++++++++----
 arch/um/drivers/ubd_kern.c |   17 ++++++++++++-----
 2 files changed, 27 insertions(+), 9 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/ubd_kern.c	2007-04-05 12:39:08.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/ubd_kern.c	2007-04-05 12:39:11.000000000 -0400
@@ -622,6 +622,14 @@ static int ubd_open_dev(struct ubd *ubd_
 	return(err);
 }
 
+static void ubd_device_release(struct device *dev)
+{
+	struct ubd *ubd_dev = dev->driver_data;
+
+	blk_cleanup_queue(ubd_dev->queue);
+	*ubd_dev = ((struct ubd) DEFAULT_UBD);
+}
+
 static int ubd_disk_register(int major, u64 size, int unit,
 			     struct gendisk **disk_out)
 {
@@ -644,6 +652,8 @@ static int ubd_disk_register(int major, 
 	if (major == MAJOR_NR) {
 		ubd_devs[unit].pdev.id   = unit;
 		ubd_devs[unit].pdev.name = DRIVER_NAME;
+		ubd_devs[unit].pdev.dev.release = ubd_device_release;
+		ubd_devs[unit].pdev.dev.driver_data = &ubd_devs[unit];
 		platform_device_register(&ubd_devs[unit].pdev);
 		disk->driverfs_dev = &ubd_devs[unit].pdev.dev;
 	}
@@ -787,7 +797,7 @@ static int ubd_id(char **str, int *start
 
 static int ubd_remove(int n, char **error_out)
 {
-	struct gendisk *disk;
+	struct gendisk *disk = ubd_gendisk[n];
 	struct ubd *ubd_dev;
 	int err = -ENODEV;
 
@@ -803,7 +813,6 @@ static int ubd_remove(int n, char **erro
 	if(ubd_dev->count > 0)
 		goto out;
 
- 	disk = ubd_gendisk[n];
  	ubd_gendisk[n] = NULL;
 	if(disk != NULL){
 		del_gendisk(disk);
@@ -816,10 +825,8 @@ static int ubd_remove(int n, char **erro
 		fake_gendisk[n] = NULL;
 	}
 
-	blk_cleanup_queue(ubd_dev->queue);
-	platform_device_unregister(&ubd_dev->pdev);
-	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 	err = 0;
+	platform_device_unregister(&ubd_dev->pdev);
 out:
 	mutex_unlock(&ubd_lock);
 	return err;
Index: linux-2.6.21-mm/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/net_kern.c	2007-04-05 12:38:43.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/net_kern.c	2007-04-05 12:39:11.000000000 -0400
@@ -341,6 +341,19 @@ static struct platform_driver uml_net_dr
 };
 static int driver_registered;
 
+static void net_device_release(struct device *dev)
+{
+	struct uml_net *device = dev->driver_data;
+	struct net_device *netdev = device->dev;
+	struct uml_net_private *lp = netdev->priv;
+
+	if(lp->remove != NULL)
+		(*lp->remove)(&lp->user);
+	list_del(&device->list);
+	kfree(device);
+	free_netdev(netdev);
+}
+
 static void eth_configure(int n, void *init, char *mac,
 			  struct transport *transport)
 {
@@ -396,6 +409,8 @@ static void eth_configure(int n, void *i
 	}
 	device->pdev.id = n;
 	device->pdev.name = DRIVER_NAME;
+	device->pdev.dev.release = net_device_release;
+	device->pdev.dev.driver_data = device;
 	if(platform_device_register(&device->pdev))
 		goto out_free_netdev;
 	SET_NETDEV_DEV(dev,&device->pdev.dev);
@@ -689,13 +704,9 @@ static int net_remove(int n, char **erro
 	lp = dev->priv;
 	if(lp->fd > 0)
 		return -EBUSY;
-	if(lp->remove != NULL) (*lp->remove)(&lp->user);
 	unregister_netdev(dev);
 	platform_device_unregister(&device->pdev);
 
-	list_del(&device->list);
-	kfree(device);
-	free_netdev(dev);
 	return 0;
 }
 

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
