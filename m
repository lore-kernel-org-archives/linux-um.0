Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1ILi9M-0003u1-AG for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 09:24:44 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1ILi9J-00056N-PM
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 16 Aug 2007 09:24:44 -0700
Date: Thu, 16 Aug 2007 12:24:27 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070816162427.GA8123@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH] UML - Fix previous request size limit fix
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
To: Andrew Morton <akpm@osdl.org>, stable@kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

[ This is both 2.6.24 and -stable material ]

The previous patch which limited the number of sectors in a single
request to a COWed device was correct in concept, but the limit was
implemented in the wrong place.

By putting it in ubd_add, it covered the cases where the COWing was
specified on the command line.  However, when the command line only
has the COW file specified, the fact that it's a COW file isn't known
until it's opened, so the limit is missed in these cases.

This patch moves the sector limit from ubd_add to ubd_open_dev.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/ubd_kern.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/ubd_kern.c	2007-08-07 13:25:47.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/ubd_kern.c	2007-08-09 13:08:20.000000000 -0400
@@ -612,6 +612,8 @@ static int ubd_open_dev(struct ubd *ubd_
 	ubd_dev->fd = fd;
 
 	if(ubd_dev->cow.file != NULL){
+		blk_queue_max_sectors(ubd_dev->queue, 8 * sizeof(long));
+
 		err = -ENOMEM;
 		ubd_dev->cow.bitmap = (void *) vmalloc(ubd_dev->cow.bitmap_len);
 		if(ubd_dev->cow.bitmap == NULL){
@@ -712,8 +714,6 @@ static int ubd_add(int n, char **error_o
 	ubd_dev->queue->queuedata = ubd_dev;
 
 	blk_queue_max_hw_segments(ubd_dev->queue, MAX_SG);
-	if(ubd_dev->cow.file != NULL)
-		blk_queue_max_sectors(ubd_dev->queue, 8 * sizeof(long));
 	err = ubd_disk_register(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
 	if(err){
 		*error_out = "Failed to register device";

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
