Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JFcTp-00011y-SX for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:40:58 -0800
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1JFcTp-0001a7-5F
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 17 Jan 2008 13:40:57 -0800
Date: Thu, 17 Jan 2008 16:40:40 -0500
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20080117214040.GA6707@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 5/20] UML - Remove fakehd
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

The fakehd switch lost its implementation at some point.  Since no one is
screaming for it, we might as well remove it.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
---
 arch/um/drivers/ubd_kern.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

Index: linux-2.6.22/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/ubd_kern.c	2007-12-14 11:28:06.000000000 -0500
+++ linux-2.6.22/arch/um/drivers/ubd_kern.c	2007-12-14 12:33:26.000000000 -0500
@@ -460,20 +460,6 @@ __uml_help(udb_setup,
 "    in the boot output.\n\n"
 );
 
-static int fakehd_set = 0;
-static int fakehd(char *str)
-{
-	printk(KERN_INFO "fakehd : Changing ubd name to \"hd\".\n");
-	fakehd_set = 1;
-	return 1;
-}
-
-__setup("fakehd", fakehd);
-__uml_help(fakehd,
-"fakehd\n"
-"    Change the ubd device name to \"hd\".\n\n"
-);
-
 static void do_ubd_request(struct request_queue * q);
 
 /* Only changed by ubd_init, which is an initcall. */
@@ -730,8 +716,10 @@ static int ubd_add(int n, char **error_o
 		ubd_disk_register(fake_major, ubd_dev->size, n,
 				  &fake_gendisk[n]);
 
-	/* perhaps this should also be under the "if (fake_major)" above */
-	/* using the fake_disk->disk_name and also the fakehd_set name */
+	/*
+	 * Perhaps this should also be under the "if (fake_major)" above
+	 * using the fake_disk->disk_name
+	 */
 	if (fake_ide)
 		make_ide_entries(ubd_gendisk[n]->disk_name);
 

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2008.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
