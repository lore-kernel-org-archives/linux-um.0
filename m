Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1D9Arn-0000mb-JJ for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 15:45:27 -0800
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1D9Arl-0001bz-SA for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Mar 2005 15:45:27 -0800
Message-Id: <200503100215.j2A2FuDN015227@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 3/9] UML - "Hardware" random number generator
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
Date: Wed, 09 Mar 2005 21:15:56 -0500
To: torvalds@osdl.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This implements a hardware random number generator for UML which attaches
itself to the host's /dev/random.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.11/arch/um/Kconfig_char
===================================================================
--- linux-2.6.11.orig/arch/um/Kconfig_char	2005-03-08 20:13:55.000000000 -0500
+++ linux-2.6.11/arch/um/Kconfig_char	2005-03-08 20:22:24.000000000 -0500
@@ -190,5 +190,19 @@
 	tristate
 	default UML_SOUND
 
+config UML_RANDOM
+	tristate "Hardware random number generator"
+	help
+	This option enables UML's "hardware" random number generator.  It
+	attaches itself to the host's /dev/random, supplying as much entropy
+	as the host has, rather than the small amount the UML gets from its
+	own drivers.  It registers itself as a standard hardware random number
+	generator, major 10, minor 183, and the canonical device name is 
+	/dev/hwrng.
+	The way to make use of this is to install the rng-tools package
+	(check your distro, or download from 
+	http://sourceforge.net/projects/gkernel/).  rngd periodically reads 
+	/dev/hwrng and injects the entropy into /dev/random.
+
 endmenu
 
Index: linux-2.6.11/arch/um/defconfig
===================================================================
--- linux-2.6.11.orig/arch/um/defconfig	2005-03-08 20:13:55.000000000 -0500
+++ linux-2.6.11/arch/um/defconfig	2005-03-08 20:22:24.000000000 -0500
@@ -111,6 +111,7 @@
 CONFIG_UML_SOUND=m
 CONFIG_SOUND=m
 CONFIG_HOSTAUDIO=m
+CONFIG_UML_RANDOM=y
 
 #
 # Block devices
Index: linux-2.6.11/arch/um/drivers/Makefile
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/Makefile	2005-03-08 20:17:34.000000000 -0500
+++ linux-2.6.11/arch/um/drivers/Makefile	2005-03-08 20:22:24.000000000 -0500
@@ -3,7 +3,7 @@
 # Licensed under the GPL
 #
 
-CHAN_OBJS := chan_kern.o chan_user.o line.o 
+CHAN_OBJS := chan_kern.o chan_user.o line.o
 
 # pcap is broken in 2.5 because kbuild doesn't allow pcap.a to be linked
 # in to pcap.o
@@ -41,7 +41,7 @@
 obj-$(CONFIG_XTERM_CHAN) += xterm.o xterm_kern.o
 obj-$(CONFIG_UML_WATCHDOG) += harddog.o
 obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
-
+obj-$(CONFIG_UML_RANDOM) += random.o
 
 USER_SINGLE_OBJS = $(foreach f,$(patsubst %.o,%,$(obj-y) $(obj-m)),$($(f)-objs))
 
Index: linux-2.6.11/arch/um/drivers/random.c
===================================================================
--- linux-2.6.11.orig/arch/um/drivers/random.c	2003-09-15 09:40:47.000000000 -0400
+++ linux-2.6.11/arch/um/drivers/random.c	2005-03-08 20:22:24.000000000 -0500
@@ -0,0 +1,122 @@
+/* Much of this ripped from hw_random.c */
+
+#include <linux/module.h>
+#include <linux/fs.h>
+#include <linux/miscdevice.h>
+#include <linux/delay.h>
+#include <asm/uaccess.h>
+#include "os.h"
+
+/*
+ * core module and version information
+ */
+#define RNG_VERSION "1.0.0"
+#define RNG_MODULE_NAME "random"
+#define RNG_DRIVER_NAME   RNG_MODULE_NAME " virtual driver " RNG_VERSION
+#define PFX RNG_MODULE_NAME ": "
+
+#define RNG_MISCDEV_MINOR		183 /* official */
+
+static int random_fd = -1;
+
+static int rng_dev_open (struct inode *inode, struct file *filp)
+{
+	/* enforce read-only access to this chrdev */
+	if ((filp->f_mode & FMODE_READ) == 0)
+		return -EINVAL;
+	if (filp->f_mode & FMODE_WRITE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
+                             loff_t * offp)
+{
+        u32 data;
+        int n, ret = 0, have_data;
+
+        while(size){
+                n = os_read_file(random_fd, &data, sizeof(data));
+                if(n > 0){
+                        have_data = n;
+                        while (have_data && size) {
+                                if (put_user((u8)data, buf++)) {
+                                        ret = ret ? : -EFAULT;
+                                        break;
+                                }
+                                size--;
+                                ret++;
+                                have_data--;
+                                data>>=8;
+                        }
+                }
+                else if(n == -EAGAIN){
+                        if (filp->f_flags & O_NONBLOCK)
+                                return ret ? : -EAGAIN;
+
+                        if(need_resched()){
+                                current->state = TASK_INTERRUPTIBLE;
+                                schedule_timeout(1);
+                        }
+                }
+                else return n;
+		if (signal_pending (current))
+			return ret ? : -ERESTARTSYS;
+	}
+	return ret;
+}
+
+static struct file_operations rng_chrdev_ops = {
+	.owner		= THIS_MODULE,
+	.open		= rng_dev_open,
+	.read		= rng_dev_read,
+};
+
+static struct miscdevice rng_miscdev = {
+	RNG_MISCDEV_MINOR,
+	RNG_MODULE_NAME,
+	&rng_chrdev_ops,
+};
+
+/*
+ * rng_init - initialize RNG module
+ */
+static int __init rng_init (void)
+{
+	int err;
+
+        err = os_open_file("/dev/random", of_read(OPENFLAGS()), 0);
+        if(err < 0)
+                goto out;
+
+        random_fd = err;
+
+        err = os_set_fd_block(random_fd, 0);
+        if(err)
+		goto err_out_cleanup_hw;
+                
+	err = misc_register (&rng_miscdev);
+	if (err) {
+		printk (KERN_ERR PFX "misc device register failed\n");
+		goto err_out_cleanup_hw;
+	}
+
+ out:
+        return err;
+
+ err_out_cleanup_hw:
+        random_fd = -1;
+        goto out;
+}
+
+/*
+ * rng_cleanup - shutdown RNG module
+ */
+static void __exit rng_cleanup (void)
+{
+	misc_deregister (&rng_miscdev);
+}
+
+module_init (rng_init);
+module_exit (rng_cleanup);



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
