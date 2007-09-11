Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1IV76L-0006jD-7V for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:52:30 -0700
Received: from saraswathi.solana.com ([198.99.130.12])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1IV76J-0007mC-Fr
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 11 Sep 2007 07:52:29 -0700
Date: Tue, 11 Sep 2007 10:52:20 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070911145220.GA6313@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [ PATCH 1/3 ] UML - Remove unneeded void * cast
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
Cc: Jesper Juhl <jesper.juhl@gmail.com>, LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

vmalloc() returns a void pointer, so casting to (void *) is pretty pointless.   

Signed-off-by: Jesper Juhl <jesper.juhl@gmail.com>
Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/ubd_kern.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: linux-2.6.22/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.22.orig/arch/um/drivers/ubd_kern.c	2007-08-23 20:22:40.000000000 -0400
+++ linux-2.6.22/arch/um/drivers/ubd_kern.c	2007-08-30 16:27:33.000000000 -0400
@@ -615,7 +615,7 @@ static int ubd_open_dev(struct ubd *ubd_
 		blk_queue_max_sectors(ubd_dev->queue, 8 * sizeof(long));
 
 		err = -ENOMEM;
-		ubd_dev->cow.bitmap = (void *) vmalloc(ubd_dev->cow.bitmap_len);
+		ubd_dev->cow.bitmap = vmalloc(ubd_dev->cow.bitmap_len);
 		if(ubd_dev->cow.bitmap == NULL){
 			printk(KERN_ERR "Failed to vmalloc COW bitmap\n");
 			goto error;

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
