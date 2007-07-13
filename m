Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1I9MHf-0006sm-QY for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 07:38:16 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1I9MHe-0008Ca-AB
	for user-mode-linux-devel@lists.sourceforge.net;
	Fri, 13 Jul 2007 07:38:15 -0700
Date: Fri, 13 Jul 2007 10:37:55 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070713143755.GA6244@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/3] UML - Limit request size on COWed devices
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
Cc: Nix <nix@esperi.org.uk>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

COWed devices can't handle more than 32 (64 on x86_64) sectors in one
request due to the size of the bitmap being carried around in the
io_thread_req.

Enforce that by telling the block layer not to put too many sectors in
requests to COWed devices.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/ubd_kern.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6.17/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.17.orig/arch/um/drivers/ubd_kern.c	2007-07-09 08:53:09.000000000 -0400
+++ linux-2.6.17/arch/um/drivers/ubd_kern.c	2007-07-09 18:08:33.000000000 -0400
@@ -712,6 +712,8 @@ static int ubd_add(int n, char **error_o
 	ubd_dev->queue->queuedata = ubd_dev;
 
 	blk_queue_max_hw_segments(ubd_dev->queue, MAX_SG);
+	if(ubd_dev->cow.file != NULL)
+		blk_queue_max_sectors(ubd_dev->queue, 8 * sizeof(long));
 	err = ubd_disk_register(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
 	if(err){
 		*error_out = "Failed to register device";

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
