Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EvnYa-0000nL-Qw for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 19:18:52 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1EvnYa-0000tg-As
	for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 08 Jan 2006 19:18:52 -0800
Message-Id: <200601090411.k094BBJR001207@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 6/6] UML - Kill an unused variable
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
Date: Sun, 08 Jan 2006 23:11:11 -0500
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

The HDIO_GETGEO patch left an unused variable in the UML block
driver.  This gets rid of it.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/drivers/ubd_kern.c	2006-01-06 21:05:23.000000000 -0500
+++ linux-2.6.15-mm/arch/um/drivers/ubd_kern.c	2006-01-08 09:33:13.000000000 -0500
@@ -1073,7 +1073,6 @@ static int ubd_getgeo(struct block_devic
 static int ubd_ioctl(struct inode * inode, struct file * file,
 		     unsigned int cmd, unsigned long arg)
 {
-	struct hd_geometry __user *loc = (struct hd_geometry __user *) arg;
 	struct ubd *dev = inode->i_bdev->bd_disk->private_data;
 	struct hd_driveid ubd_id = {
 		.cyls		= 0,



-------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc. Do you grep through log files
for problems?  Stop!  Download the new AJAX search engine that makes
searching your log files as easy as surfing the  web.  DOWNLOAD SPLUNK!
http://ads.osdn.com/?ad_id=7637&alloc_id=16865&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
