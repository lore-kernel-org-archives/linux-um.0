Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sfi-mx-2.v28.ch3.sourceforge.com ([172.29.28.122]
	helo=mx.sourceforge.net)
	by 3yr0jf1.ch3.sourceforge.com with esmtp (Exim 4.69)
	(envelope-from <greg@kroah.com>) id 1M14kV-0001Oi-1h
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 May 2009 20:26:51 +0000
Received: from kroah.org ([198.145.64.141] helo=coco.kroah.org)
	by 72vjzd1.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.69) id 1M14kP-0000ci-Nc
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 04 May 2009 20:26:50 +0000
Date: Mon, 4 May 2009 13:20:21 -0700
From: Greg Kroah-Hartman <gregkh@suse.de>
Message-ID: <20090504202021.GA23223@kroah.com>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] uml: remove driver_data direct access of struct
	device
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Jeff Dike <jdike@addtoit.com>
Cc: Greg KH <greg@kroah.com>, user-mode-linux-devel@lists.sourceforge.net

From: Greg Kroah-Hartman <gregkh@suse.de>

In the near future, the driver core is going to not allow direct access
to the driver_data pointer in struct device.  Instead, the functions
dev_get_drvdata() and dev_set_drvdata() should be used.  These functions
have been around since the beginning, so are backwards compatible with
all older kernel versions.

Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: Jeff Dike <jdike@addtoit.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 arch/um/drivers/net_kern.c |    4 ++--
 arch/um/drivers/ubd_kern.c |    4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

--- a/arch/um/drivers/net_kern.c
+++ b/arch/um/drivers/net_kern.c
@@ -360,7 +360,7 @@ static struct platform_driver uml_net_dr
 
 static void net_device_release(struct device *dev)
 {
-	struct uml_net *device = dev->driver_data;
+	struct uml_net *device = dev_get_drvdata(dev);
 	struct net_device *netdev = device->dev;
 	struct uml_net_private *lp = netdev_priv(netdev);
 
@@ -440,7 +440,7 @@ static void eth_configure(int n, void *i
 	device->pdev.id = n;
 	device->pdev.name = DRIVER_NAME;
 	device->pdev.dev.release = net_device_release;
-	device->pdev.dev.driver_data = device;
+	dev_set_drvdata(&device->pdev.dev, device);
 	if (platform_device_register(&device->pdev))
 		goto out_free_netdev;
 	SET_NETDEV_DEV(dev,&device->pdev.dev);
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -799,7 +799,7 @@ static int ubd_open_dev(struct ubd *ubd_
 
 static void ubd_device_release(struct device *dev)
 {
-	struct ubd *ubd_dev = dev->driver_data;
+	struct ubd *ubd_dev = dev_get_drvdata(dev);
 
 	blk_cleanup_queue(ubd_dev->queue);
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
@@ -828,7 +828,7 @@ static int ubd_disk_register(int major, 
 		ubd_devs[unit].pdev.id   = unit;
 		ubd_devs[unit].pdev.name = DRIVER_NAME;
 		ubd_devs[unit].pdev.dev.release = ubd_device_release;
-		ubd_devs[unit].pdev.dev.driver_data = &ubd_devs[unit];
+		dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
 		platform_device_register(&ubd_devs[unit].pdev);
 		disk->driverfs_dev = &ubd_devs[unit].pdev.dev;
 	}

------------------------------------------------------------------------------
Register Now & Save for Velocity, the Web Performance & Operations 
Conference from O'Reilly Media. Velocity features a full day of 
expert-led, hands-on workshops and two days of sessions from industry 
leaders in dedicated Performance & Operations tracks. Use code vel09scf 
and Save an extra 15% before 5/3. http://p.sf.net/sfu/velocityconf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

