Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1CbgpB-0001M6-Uu for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:21 -0800
Received: from hirsch.in-berlin.de ([192.109.42.6] ident=root)
	by sc8-sf-mx1.sourceforge.net with esmtp (TLSv1:AES256-SHA:256)
	(Exim 4.41) id 1CbgpB-0001H4-2u
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Dec 2004 07:00:21 -0800
From: Gerd Knorr <kraxel@bytesex.org>
Message-ID: <20041207143913.GA23659@bytesex>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Subject: [uml-devel] [patch] uml: sysfs support for the uml block devices.
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
Date: Tue, 7 Dec 2004 15:39:13 +0100
To: Andrew Morton <akpm@osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, uml devel <user-mode-linux-devel@lists.sourceforge.net>, Jeff Dike <jdike@addtoit.com>, Blaisorblade <blaisorblade_spam@yahoo.it>

$subject says all ;)

Signed-off-by: Gerd Knorr <kraxel@bytesex.org>
---
 arch/um/drivers/ubd_kern.c |   18 ++++++++++++++++++
 1 files changed, 18 insertions(+)

Index: linux-2004-11-23/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2004-11-23.orig/arch/um/drivers/ubd_kern.c	2004-11-24 12:52:38.000000000 +0100
+++ linux-2004-11-23/arch/um/drivers/ubd_kern.c	2004-11-26 17:29:27.138934607 +0100
@@ -54,6 +54,8 @@
 #include "mem.h"
 #include "mem_kern.h"
 
+#define DRIVER_NAME "uml-blkdev"
+
 static spinlock_t ubd_io_lock = SPIN_LOCK_UNLOCKED;
 static spinlock_t ubd_lock = SPIN_LOCK_UNLOCKED;
 
@@ -117,6 +119,7 @@ struct ubd {
 	struct openflags openflags;
 	int no_cow;
 	struct cow cow;
+	struct platform_device pdev;
 
 	int map_writes;
 	int map_reads;
@@ -585,6 +588,14 @@ static int ubd_new_disk(int major, u64 s
 		sprintf(disk->devfs_name, "ubd_fake/disc%d", unit);
 	}
 
+	/* sysfs register (not for ide fake devices) */
+	if (major == MAJOR_NR) {
+		ubd_dev[unit].pdev.id   = unit;
+		ubd_dev[unit].pdev.name = DRIVER_NAME;
+		platform_device_register(&ubd_dev[unit].pdev);
+		disk->driverfs_dev = &ubd_dev[unit].pdev.dev;
+	}
+
 	disk->private_data = &ubd_dev[unit];
 	disk->queue = ubd_queue;
 	add_disk(disk);
@@ -718,6 +729,7 @@ static int ubd_remove(char *str)
 		fake_gendisk[n] = NULL;
 	}
 
+	platform_device_unregister(&dev->pdev);
 	*dev = ((struct ubd) DEFAULT_UBD);
 	err = 0;
  out:
@@ -740,6 +752,11 @@ static int ubd_mc_init(void)
 
 __initcall(ubd_mc_init);
 
+static struct device_driver ubd_driver = {
+	.name  = DRIVER_NAME,
+	.bus   = &platform_bus_type,
+};
+
 int ubd_init(void)
 {
         int i;
@@ -762,6 +779,7 @@ int ubd_init(void)
 		if (register_blkdev(fake_major, "ubd"))
 			return -1;
 	}
+	driver_register(&ubd_driver);
 	for (i = 0; i < MAX_DEV; i++) 
 		ubd_add(i);
 	return 0;

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
