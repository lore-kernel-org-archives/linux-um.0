Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DfQ4j-0006Aj-R5	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:28:05 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DfQ4i-0000mB-D6	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 06 Jun 2005 15:28:05 -0700
Message-Id: <200506062008.j56K87sZ008947@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/5] UML - Make the emulated iomem driver work on
	2.6
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
Date: Mon, 06 Jun 2005 16:08:06 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This makes the minimal fixes needed to make the UML iomem driver work in
2.6.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/Kconfig_char
===================================================================
--- linux-2.6.12-rc.orig/arch/um/Kconfig_char	2005-05-26 17:15:14.000000000 -0400
+++ linux-2.6.12-rc/arch/um/Kconfig_char	2005-05-28 22:50:34.000000000 -0400
@@ -204,5 +204,11 @@ config UML_RANDOM
 	http://sourceforge.net/projects/gkernel/).  rngd periodically reads
 	/dev/hwrng and injects the entropy into /dev/random.
 
+config MMAPPER
+	tristate "iomem emulation driver"
+	help
+	This driver allows a host file to be used as emulated IO memory inside
+	UML.
+
 endmenu
 
Index: linux-2.6.12-rc/arch/um/drivers/mmapper_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/mmapper_kern.c	2005-05-28 22:39:00.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/mmapper_kern.c	2005-05-28 22:49:05.000000000 -0400
@@ -18,6 +18,7 @@
 #include <linux/slab.h>
 #include <linux/init.h> 
 #include <linux/smp_lock.h>
+#include <linux/miscdevice.h>
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/pgtable.h>
@@ -117,24 +118,39 @@ static struct file_operations mmapper_fo
 	.release	= mmapper_release,
 };
 
+static struct miscdevice mmapper_dev = {
+	.minor		= MISC_DYNAMIC_MINOR,
+	.name		= "mmapper",
+	.fops		= &mmapper_fops
+};
+
 static int __init mmapper_init(void)
 {
+	int err;
+
 	printk(KERN_INFO "Mapper v0.1\n");
 
 	v_buf = (char *) find_iomem("mmapper", &mmapper_size);
 	if(mmapper_size == 0){
 		printk(KERN_ERR "mmapper_init - find_iomem failed\n");
-		return(0);
+		goto out;
 	}
 
-	p_buf = __pa(v_buf);
+	err = misc_register(&mmapper_dev);
+	if(err){
+		printk(KERN_ERR "mmapper - misc_register failed, err = %d\n", 
+		       err);
+		goto out;
+	}
 
-	devfs_mk_cdev(MKDEV(30, 0), S_IFCHR|S_IRUGO|S_IWUGO, "mmapper");
-	return(0);
+	p_buf = __pa(v_buf);
+out:
+	return 0;
 }
 
 static void mmapper_exit(void)
 {
+	misc_deregister(&mmapper_dev);
 }
 
 module_init(mmapper_init);



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.  How far can you shotput
a projector? How fast can you ride your desk chair down the office luge track?
If you want to score the big prize, get to know the little guy.  
Play to win an NEC 61" plasma display: http://www.necitguy.com/?r=20
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
