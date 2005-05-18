Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DYG81-0007Gp-EW	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:25:53 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DYG80-0006zD-OT	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 17 May 2005 21:25:53 -0700
Message-Id: <200505180420.j4I4KYFd017349@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 9/9] UML - Change printf to printk in console
	driver
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
Date: Wed, 18 May 2005 00:20:34 -0400
To: akpm@osdl.org, torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, Al Viro <viro@parcelfarce.linux.theplanet.co.uk>

From Al Viro - we have error messages with KERN_ERR in them, so they
should be printk-ed rather than printf-ed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.12-rc/arch/um/drivers/chan_kern.c
===================================================================
--- linux-2.6.12-rc.orig/arch/um/drivers/chan_kern.c	2005-05-17 18:02:25.000000000 -0400
+++ linux-2.6.12-rc/arch/um/drivers/chan_kern.c	2005-05-17 18:27:15.000000000 -0400
@@ -20,9 +20,17 @@
 #include "os.h"
 
 #ifdef CONFIG_NOCONFIG_CHAN
+
+/* The printk's here are wrong because we are complaining that there is no
+ * output device, but printk is printing to that output device.  The user will 
+ * never see the error.  printf would be better, except it can't run on a 
+ * kernel stack because it will overflow it.  
+ * Use printk for now since that will avoid crashing.
+ */
+
 static void *not_configged_init(char *str, int device, struct chan_opts *opts)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(NULL);
 }
@@ -30,27 +38,27 @@ static void *not_configged_init(char *st
 static int not_configged_open(int input, int output, int primary, void *data,
 			      char **dev_out)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-ENODEV);
 }
 
 static void not_configged_close(int fd, void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 }
 
 static int not_configged_read(int fd, char *c_out, void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
 
 static int not_configged_write(int fd, const char *buf, int len, void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
@@ -58,7 +66,7 @@ static int not_configged_write(int fd, c
 static int not_configged_console_write(int fd, const char *buf, int len,
 				       void *data)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-EIO);
 }
@@ -66,7 +74,7 @@ static int not_configged_console_write(i
 static int not_configged_window_size(int fd, void *data, unsigned short *rows,
 				     unsigned short *cols)
 {
-	printf(KERN_ERR "Using a channel type which is configured out of "
+	printk(KERN_ERR "Using a channel type which is configured out of "
 	       "UML\n");
 	return(-ENODEV);
 }



-------------------------------------------------------
This SF.Net email is sponsored by Oracle Space Sweepstakes
Want to be the first software developer in space?
Enter now for the Oracle Space Sweepstakes!
http://ads.osdn.com/?ad_id=7412&alloc_id=16344&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
