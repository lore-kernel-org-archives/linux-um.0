Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1E9qCD-00025a-IF	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:25:33 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1E9qCD-0005Du-5v
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 29 Aug 2005 13:25:33 -0700
Message-Id: <200508292006.j7TK6ru5029910@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/9] UML - Error path cleanup
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
Date: Mon, 29 Aug 2005 16:06:52 -0400
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

This cleans up the error path in ubd_open, causing it now to call
ubd_close appropriately when something fails.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.13-rc6-mm1/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.13-rc6-mm1.orig/arch/um/drivers/ubd_kern.c	2005-08-29 11:51:22.000000000 -0400
+++ linux-2.6.13-rc6-mm1/arch/um/drivers/ubd_kern.c	2005-08-29 11:57:44.000000000 -0400
@@ -668,21 +668,22 @@
 	struct ubd *dev = &ubd_dev[n];
 	int err;
 
+	err = -ENODEV;
 	if(dev->file == NULL)
-		return(-ENODEV);
+		goto out;
 
 	if (ubd_open_dev(dev))
-		return(-ENODEV);
+		goto out;
 
 	err = ubd_file_size(dev, &dev->size);
 	if(err < 0)
-		return(err);
+		goto out_close;
 
 	dev->size = ROUND_BLOCK(dev->size);
 
 	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
 	if(err) 
-		return(err);
+		goto out_close;
  
 	if(fake_major != MAJOR_NR)
 		ubd_new_disk(fake_major, dev->size, n, 
@@ -693,8 +694,11 @@
 	if (fake_ide)
 		make_ide_entries(ubd_gendisk[n]->disk_name);
 
+	err = 0;
+out_close:
 	ubd_close(dev);
-	return 0;
+out:
+	return err;
 }
 
 static int ubd_config(char *str)



-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practices
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & QA
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
