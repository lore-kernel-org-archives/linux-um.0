Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.12]
	helo=sc8-sf-mx2.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DQ9BF-0001cd-JG for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 12:23:41 -0700
Received: from mail-relay-3.tiscali.it ([213.205.33.43])
	by sc8-sf-mx2.sourceforge.net with esmtp (Exim 4.41)
	id 1DQ9At-0007Oq-Hc for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 25 Apr 2005 12:23:41 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050425191949.E56D145EBB@zion>
Subject: [uml-devel] [patch 1/1] uml ubd: handle readonly status
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
Date: Mon, 25 Apr 2005 21:19:49 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, axboe@suse.de


CC: Jens Axboe <axboe@suse.de>

Use the set_disk_ro() API when the backing file is read-only, to mark the disk
read-only, during the ->open(). The current hack does not work when doing a
mount -o remount.

Also, mark explicitly the code paths which should no more be triggerable (I've
removed the WARN_ON(1) things). They should actually become BUG()s probably
but I'll avoid that since I'm not so sure the change works so well. I gave it
only some limited testing.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/drivers/ubd_kern.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-handle-readonly arch/um/drivers/ubd_kern.c
--- linux-2.6.12/arch/um/drivers/ubd_kern.c~uml-ubd-handle-readonly	2005-04-25 21:16:03.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/ubd_kern.c	2005-04-25 21:16:47.000000000 +0200
@@ -156,6 +156,7 @@ static struct gendisk *fake_gendisk[MAX_
 static struct openflags global_openflags = OPEN_FLAGS;
 
 struct cow {
+	/* This is the backing file, actually */
 	char *file;
 	int fd;
 	unsigned long *bitmap;
@@ -927,10 +928,14 @@ static int ubd_open(struct inode *inode,
 		}
 	}
 	dev->count++;
-	if((filp->f_mode & FMODE_WRITE) && !dev->openflags.w){
+	set_disk_ro(disk, !dev->openflags.w);
+
+	/* This should no more be needed. And it didn't work anyway to exclude
+	 * read-write remounting of filesystems.*/
+	/*if((filp->f_mode & FMODE_WRITE) && !dev->openflags.w){
 	        if(--dev->count == 0) ubd_close(dev);
 	        err = -EROFS;
-	}
+	}*/
  out:
 	return(err);
 }
@@ -1096,6 +1101,7 @@ static int prepare_request(struct reques
 
 	if(req->rq_status == RQ_INACTIVE) return(1);
 
+	/* This should be impossible now */
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
@@ -1243,6 +1249,7 @@ static int ubd_check_remapped(int fd, un
 
 		/* It's a write to a ubd device */
 
+		/* This should be impossible now */
 		if(!dev->openflags.w){
 			/* It's a write access on a read-only device - probably
 			 * shouldn't happen.  If the kernel is trying to change
@@ -1605,8 +1612,7 @@ void do_io(struct io_thread_req *req)
 				}
 			} while((n < len) && (n != 0));
 			if (n < len) memset(&buf[n], 0, len - n);
-		}
-		else {
+		} else {
 			n = os_write_file(req->fds[bit], buf, len);
 			if(n != len){
 				printk("do_io - write failed err = %d "
_


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
