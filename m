Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.11]
	helo=sc8-sf-mx1.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1DPmLW-0006kJ-JK for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 12:00:46 -0700
Received: from mail-relay-1.tiscali.it ([213.205.33.41])
	by sc8-sf-mx1.sourceforge.net with esmtp (Exim 4.41)
	id 1DPmLT-0006VT-Qk for user-mode-linux-devel@lists.sourceforge.net;
	Sun, 24 Apr 2005 12:00:46 -0700
From: blaisorblade@yahoo.it
Message-Id: <20050424181924.EAFCB55D06@zion>
Subject: [uml-devel] [patch 7/7] uml ubd: handle readonly status
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
Date: Sun, 24 Apr 2005 20:19:24 +0200
To: akpm@osdl.org
Cc: jdike@addtoit.com, bstroesser@fujitsu-siemens.com, linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net, blaisorblade@yahoo.it, axboe@suse.de


CC: Jens Axboe <axboe@suse.de>

Use the set_disk_ro() API when the backing file is read-only, to mark the disk
read-only, during the ->open(). The current hack does not work when doing a
mount -o remount.

Also, upgrade some warnings to WARN_ON(1) statements. They should actually
become BUG()s probably but I'll avoid that since I'm not so sure the change
works so well. I gave it only some limited testing.

Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
---

 linux-2.6.12-paolo/arch/um/drivers/ubd_kern.c |   14 ++++++++++----
 1 files changed, 10 insertions(+), 4 deletions(-)

diff -puN arch/um/drivers/ubd_kern.c~uml-ubd-handle-readonly arch/um/drivers/ubd_kern.c
--- linux-2.6.12/arch/um/drivers/ubd_kern.c~uml-ubd-handle-readonly	2005-04-24 20:17:06.000000000 +0200
+++ linux-2.6.12-paolo/arch/um/drivers/ubd_kern.c	2005-04-24 20:17:06.000000000 +0200
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
@@ -1099,6 +1104,7 @@ static int prepare_request(struct reques
 	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
 		printk("Write attempted on readonly ubd device %s\n", 
 		       disk->disk_name);
+		WARN_ON(1); /* This should be impossible now */
 		end_request(req, 0);
 		return(1);
 	}
@@ -1252,6 +1258,7 @@ static int ubd_check_remapped(int fd, un
 			 */
 			printk("Write access to mapped page from readonly ubd "
 			       "device %d\n", i);
+			WARN_ON(1); /* This should be impossible now */
 			return(0);
 		}
 
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
