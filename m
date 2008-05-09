Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from [10.3.1.92] (helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JuVsl-00020r-3J for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2008 09:55:44 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JuVs8-00061S-AU
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 09 May 2008 09:55:13 -0700
Date: Fri, 9 May 2008 12:54:17 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080509165417.GA10627@c2.user-mode-linux.org>
MIME-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/3] UML - Style fixes in the random driver
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
To: Andrew Morton <akpm@osdl.org>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Give random.c a style workover while I'm changing it.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/random.c |   77 ++++++++++++++++++++++++-----------------------
 1 file changed, 40 insertions(+), 37 deletions(-)

Index: linux-2.6-git/arch/um/drivers/random.c
===================================================================
--- linux-2.6-git.orig/arch/um/drivers/random.c	2008-05-09 12:14:49.000000000 -0400
+++ linux-2.6-git/arch/um/drivers/random.c	2008-05-09 12:15:15.000000000 -0400
@@ -1,4 +1,5 @@
-/* Copyright (C) 2005 Jeff Dike <jdike@addtoit.com> */
+/* Copyright (C) 2005 - 2008 Jeff Dike <jdike@{linux.intel,addtoit}.com> */
+
 /* Much of this ripped from drivers/char/hw_random.c, see there for other
  * copyright.
  *
@@ -35,7 +36,7 @@ static int rng_dev_open (struct inode *i
 	/* enforce read-only access to this chrdev */
 	if ((filp->f_mode & FMODE_READ) == 0)
 		return -EINVAL;
-	if (filp->f_mode & FMODE_WRITE)
+	if ((filp->f_mode & FMODE_WRITE) != 0)
 		return -EINVAL;
 
 	return 0;
@@ -44,31 +45,31 @@ static int rng_dev_open (struct inode *i
 static atomic_t host_sleep_count = ATOMIC_INIT(0);
 
 static ssize_t rng_dev_read (struct file *filp, char __user *buf, size_t size,
-                             loff_t * offp)
+			     loff_t *offp)
 {
-        u32 data;
-        int n, ret = 0, have_data;
+	u32 data;
+	int n, ret = 0, have_data;
 
-        while(size){
-                n = os_read_file(random_fd, &data, sizeof(data));
-                if(n > 0){
-                        have_data = n;
-                        while (have_data && size) {
-                                if (put_user((u8)data, buf++)) {
-                                        ret = ret ? : -EFAULT;
-                                        break;
-                                }
-                                size--;
-                                ret++;
-                                have_data--;
-                                data>>=8;
-                        }
-                }
-                else if(n == -EAGAIN){
+	while (size) {
+		n = os_read_file(random_fd, &data, sizeof(data));
+		if (n > 0) {
+			have_data = n;
+			while (have_data && size) {
+				if (put_user((u8) data, buf++)) {
+					ret = ret ? : -EFAULT;
+					break;
+				}
+				size--;
+				ret++;
+				have_data--;
+				data >>= 8;
+			}
+		}
+		else if (n == -EAGAIN) {
 			DECLARE_WAITQUEUE(wait, current);
 
-                        if (filp->f_flags & O_NONBLOCK)
-                                return ret ? : -EAGAIN;
+			if (filp->f_flags & O_NONBLOCK)
+				return ret ? : -EAGAIN;
 
 			atomic_inc(&host_sleep_count);
 			reactivate_fd(random_fd, RANDOM_IRQ);
@@ -85,8 +86,10 @@ static ssize_t rng_dev_read (struct file
 				ignore_sigio_fd(random_fd);
 				deactivate_fd(random_fd, RANDOM_IRQ);
 			}
-                }
-                else return n;
+		}
+		else
+			return n;
+
 		if (signal_pending (current))
 			return ret ? : -ERESTARTSYS;
 	}
@@ -120,33 +123,33 @@ static int __init rng_init (void)
 {
 	int err;
 
-        err = os_open_file("/dev/random", of_read(OPENFLAGS()), 0);
-        if(err < 0)
-                goto out;
+	err = os_open_file("/dev/random", of_read(OPENFLAGS()), 0);
+	if (err < 0)
+		goto out;
 
-        random_fd = err;
+	random_fd = err;
 
 	err = um_request_irq(RANDOM_IRQ, random_fd, IRQ_READ, random_interrupt,
 			     IRQF_DISABLED | IRQF_SAMPLE_RANDOM, "random",
 			     NULL);
-        if(err)
+	if (err)
 		goto err_out_cleanup_hw;
 
 	sigio_broken(random_fd, 1);
 
 	err = misc_register (&rng_miscdev);
 	if (err) {
-		printk (KERN_ERR RNG_MODULE_NAME ": misc device register failed\n");
+		printk (KERN_ERR RNG_MODULE_NAME ": misc device register "
+			"failed\n");
 		goto err_out_cleanup_hw;
 	}
+out:
+	return err;
 
- out:
-        return err;
-
- err_out_cleanup_hw:
+err_out_cleanup_hw:
 	os_close_file(random_fd);
-        random_fd = -1;
-        goto out;
+	random_fd = -1;
+	goto out;
 }
 
 /*

-------------------------------------------------------------------------
This SF.net email is sponsored by the 2008 JavaOne(SM) Conference 
Don't miss this year's exciting event. There's still time to save $100. 
Use priority code J8TL2D2. 
http://ad.doubleclick.net/clk;198757673;13503038;p?http://java.sun.com/javaone
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
