Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbgpB-0001M5-MS for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:21 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CbgpB-0001H2-2t
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:21 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041207143852.GA23644@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] uml: sysfs support for uml network driver.
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
Date: Tue, 7 Dec 2004 15:38:53 +0100
To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, uml devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade_spam@yahoo.it>

Add sysfs support to the uml network driver.  Also comment
the eth_init function, I think that one is never ever needed
as the devices are initialized when the underlying transport
mechanism registeres.

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/drivers/net_kern.c |   24 ++++++++++++++++++++++--
 arch/um/include/net_kern.h |    1 +
 2 files changed, 23 insertions(+), 2 deletions(-)

Index: linux-2.6.10-rc3/arch/um/include/net_kern.h
===================================================================
--- linux-2.6.10-rc3.orig/arch/um/include/net_kern.h	2004-12-07 12:12:18.000000000 +0100
+++ linux-2.6.10-rc3/arch/um/include/net_kern.h	2004-12-07 13:11:07.059493999 +0100
@@ -14,6 +14,7 @@
 struct uml_net {
 	struct list_head list;
 	struct net_device *dev;
+	struct platform_device pdev;
 	int index;
 	unsigned char mac[ETH_ALEN];
 	int have_mac;
Index: linux-2.6.10-rc3/arch/um/drivers/net_kern.c
===================================================================
--- linux-2.6.10-rc3.orig/arch/um/drivers/net_kern.c	2004-12-07 12:11:53.000000000 +0100
+++ linux-2.6.10-rc3/arch/um/drivers/net_kern.c	2004-12-07 14:23:20.664164072 +0100
@@ -30,6 +30,8 @@
 #include "irq_user.h"
 #include "irq_kern.h"
 
+#define DRIVER_NAME "uml-netdev"
+
 static spinlock_t opened_lock = SPIN_LOCK_UNLOCKED;
 LIST_HEAD(opened);
 
@@ -252,7 +254,7 @@ static int uml_net_ioctl(struct net_devi
 {
 	static const struct ethtool_drvinfo info = {
 		.cmd     = ETHTOOL_GDRVINFO,
-		.driver  = "uml virtual ethernet",
+		.driver  = DRIVER_NAME,
 		.version = "42",
 	};
 	void *useraddr;
@@ -289,6 +291,12 @@ void uml_net_user_timer_expire(unsigned 
 static spinlock_t devices_lock = SPIN_LOCK_UNLOCKED;
 static struct list_head devices = LIST_HEAD_INIT(devices);
 
+static struct device_driver uml_net_driver = {
+	.name  = DRIVER_NAME,
+	.bus   = &platform_bus_type,
+};
+static int driver_registered;
+
 static int eth_configure(int n, void *init, char *mac,
 			 struct transport *transport)
 {
@@ -330,6 +338,16 @@ static int eth_configure(int n, void *in
 		return 1;
 	}
 
+	/* sysfs register */
+	if (!driver_registered) {
+		driver_register(&uml_net_driver);
+		driver_registered = 1;
+	}
+	device->pdev.id = n;
+	device->pdev.name = DRIVER_NAME;
+	platform_device_register(&device->pdev);
+	SET_NETDEV_DEV(dev,&device->pdev.dev);
+
 	/* If this name ends up conflicting with an existing registered
 	 * netdevice, that is OK, register_netdev{,ice}() will notice this
 	 * and fail.
@@ -560,6 +578,7 @@ __uml_help(eth_setup,
 "    Configure a network device.\n\n"
 );
 
+#if 0
 static int eth_init(void)
 {
 	struct list_head *ele, *next;
@@ -574,8 +593,8 @@ static int eth_init(void)
 	
 	return(1);
 }
-
 __initcall(eth_init);
+#endif
 
 static int net_config(char *str)
 {
@@ -616,6 +635,7 @@ static int net_remove(char *str)
 	if(lp->fd > 0) return(-1);
 	if(lp->remove != NULL) (*lp->remove)(&lp->user);
 	unregister_netdev(dev);
+	platform_device_unregister(&device->pdev);
 
 	list_del(&device->list);
 	kfree(device);

-- 
#define printk(args...) fprintf(stderr, ## args)


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
