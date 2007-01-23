Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1H9RPD-0003TO-8v for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:07 -0800
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1H9RPC-0003OI-3d
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 23 Jan 2007 11:34:07 -0800
Message-Id: <200701231927.l0NJRdFx005338@ccure.user-mode-linux.org>
Mime-Version: 1.0
Date: Tue, 23 Jan 2007 14:27:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] [PATCH 1/7] UML - Add per-device queues and locks to
	ubd driver
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net

Replace global queue and lock with per-device queues and locks.  Mostly a
straightforward replacement of ubd_io_lock with dev->lock and ubd_queue with
dev->queue.

Complications -
	There was no way to get a request struct (and queue) from the
structure sent to the io_thread, so a pointer to the request was
added.  This is needed in ubd_handler in order to kick do_ubd_request
to process another request.
	Queue initialization is moved from ubd_init to ubd_add.

Signed-off-by: Jeff Dike <jdike@addtoit.com>
--
 arch/um/drivers/ubd_kern.c |   70 +++++++++++++++++++++++++--------------------
 1 file changed, 40 insertions(+), 30 deletions(-)

Index: linux-2.6.18-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/drivers/ubd_kern.c	2007-01-17 12:46:25.000000000 +1100
+++ linux-2.6.18-mm/arch/um/drivers/ubd_kern.c	2007-01-17 12:46:28.000000000 +1100
@@ -56,6 +56,7 @@
 enum ubd_req { UBD_READ, UBD_WRITE };
 
 struct io_thread_req {
+	struct request *req;
 	enum ubd_req op;
 	int fds[2];
 	unsigned long offsets[2];
@@ -106,10 +107,6 @@ static inline void ubd_set_bit(__u64 bit
 
 #define DRIVER_NAME "uml-blkdev"
 
-/* Can be taken in interrupt context, and is passed to the block layer to lock
- * the request queue. Kernel side code knows that. */
-static DEFINE_SPINLOCK(ubd_io_lock);
-
 static DEFINE_MUTEX(ubd_lock);
 
 /* XXX - this made sense in 2.4 days, now it's only used as a boolean, and
@@ -132,9 +129,6 @@ static const struct block_device_operati
 	.getgeo		= ubd_getgeo,
 };
 
-/* Protected by the queue_lock */
-static request_queue_t *ubd_queue;
-
 /* Protected by ubd_lock */
 static int fake_major = MAJOR_NR;
 
@@ -178,6 +172,8 @@ struct ubd {
 	unsigned no_cow:1;
 	struct cow cow;
 	struct platform_device pdev;
+	struct request_queue *queue;
+	spinlock_t lock;
 };
 
 #define DEFAULT_COW { \
@@ -198,6 +194,7 @@ struct ubd {
         .no_cow =               0, \
 	.shared =		0, \
         .cow =			DEFAULT_COW, \
+	.lock =			SPIN_LOCK_UNLOCKED,	\
 }
 
 struct ubd ubd_devs[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
@@ -503,17 +500,20 @@ static void __ubd_finish(struct request 
  * spin_lock_irq()/spin_lock_irqsave() */
 static inline void ubd_finish(struct request *req, int error)
 {
- 	spin_lock(&ubd_io_lock);
+	struct ubd *dev = req->rq_disk->private_data;
+
+	spin_lock(&dev->lock);
 	__ubd_finish(req, error);
-	spin_unlock(&ubd_io_lock);
+	spin_unlock(&dev->lock);
 }
 
 /* XXX - move this inside ubd_intr. */
-/* Called without ubd_io_lock held, and only in interrupt context. */
+/* Called without dev->lock held, and only in interrupt context. */
 static void ubd_handler(void)
 {
 	struct io_thread_req req;
-	struct request *rq = elv_next_request(ubd_queue);
+	struct request *rq;
+	struct ubd *dev;
 	int n;
 
 	do_ubd = 0;
@@ -522,17 +522,17 @@ static void ubd_handler(void)
 	if(n != sizeof(req)){
 		printk(KERN_ERR "Pid %d - spurious interrupt in ubd_handler, "
 		       "err = %d\n", os_getpid(), -n);
-		spin_lock(&ubd_io_lock);
-		end_request(rq, 0);
-		spin_unlock(&ubd_io_lock);
 		return;
 	}
 
+	rq = req.req;
+	dev = rq->rq_disk->private_data;
+
 	ubd_finish(rq, req.error);
-	reactivate_fd(thread_fd, UBD_IRQ);	
-	spin_lock(&ubd_io_lock);
-	do_ubd_request(ubd_queue);
-	spin_unlock(&ubd_io_lock);
+	reactivate_fd(thread_fd, UBD_IRQ);
+	spin_lock(&dev->lock);
+	do_ubd_request(dev->queue);
+	spin_unlock(&dev->lock);
 }
 
 static irqreturn_t ubd_intr(int irq, void *dev)
@@ -663,7 +663,7 @@ static int ubd_disk_register(int major, 
 	}
 
 	disk->private_data = &ubd_devs[unit];
-	disk->queue = ubd_queue;
+	disk->queue = ubd_devs[unit].queue;
 	add_disk(disk);
 
 	*disk_out = disk;
@@ -688,13 +688,23 @@ static int ubd_add(int n, char **error_o
 
 	ubd_dev->size = ROUND_BLOCK(ubd_dev->size);
 
-	err = ubd_disk_register(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
-	if(err)
+	err = -ENOMEM;
+	ubd_dev->queue = blk_init_queue(do_ubd_request, &ubd_dev->lock);
+	if (ubd_dev->queue == NULL) {
+		*error_out = "Failed to initialize device queue";
 		goto out;
+	}
+	ubd_dev->queue->queuedata = ubd_dev;
+
+	err = ubd_disk_register(MAJOR_NR, ubd_dev->size, n, &ubd_gendisk[n]);
+	if(err){
+		*error_out = "Failed to register device";
+		goto out_cleanup;
+	}
 
 	if(fake_major != MAJOR_NR)
 		ubd_disk_register(fake_major, ubd_dev->size, n,
-			     &fake_gendisk[n]);
+				  &fake_gendisk[n]);
 
 	/* perhaps this should also be under the "if (fake_major)" above */
 	/* using the fake_disk->disk_name and also the fakehd_set name */
@@ -704,6 +714,10 @@ static int ubd_add(int n, char **error_o
 	err = 0;
 out:
 	return err;
+
+out_cleanup:
+	blk_cleanup_queue(ubd_dev->queue);
+	goto out;
 }
 
 static int ubd_config(char *str, char **error_out)
@@ -815,6 +829,7 @@ static int ubd_remove(int n, char **erro
 		fake_gendisk[n] = NULL;
 	}
 
+	blk_cleanup_queue(ubd_dev->queue);
 	platform_device_unregister(&ubd_dev->pdev);
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 	err = 0;
@@ -868,12 +883,6 @@ static int __init ubd_init(void)
 	if (register_blkdev(MAJOR_NR, "ubd"))
 		return -1;
 
-	ubd_queue = blk_init_queue(do_ubd_request, &ubd_io_lock);
-	if (!ubd_queue) {
-		unregister_blkdev(MAJOR_NR, "ubd");
-		return -1;
-	}
-		
 	if (fake_major != MAJOR_NR) {
 		char name[sizeof("ubd_nnn\0")];
 
@@ -1019,7 +1028,7 @@ static void cowify_req(struct io_thread_
 			   req->bitmap_words, bitmap_len);
 }
 
-/* Called with ubd_io_lock held */
+/* Called with dev->lock held */
 static int prepare_request(struct request *req, struct io_thread_req *io_req)
 {
 	struct gendisk *disk = req->rq_disk;
@@ -1038,6 +1047,7 @@ static int prepare_request(struct reques
 	offset = ((__u64) req->sector) << 9;
 	len = req->current_nr_sectors << 9;
 
+	io_req->req = req;
 	io_req->fds[0] = (ubd_dev->cow.file != NULL) ? ubd_dev->cow.fd : ubd_dev->fd;
 	io_req->fds[1] = ubd_dev->fd;
 	io_req->cow_offset = -1;
@@ -1059,7 +1069,7 @@ static int prepare_request(struct reques
 	return(0);
 }
 
-/* Called with ubd_io_lock held */
+/* Called with dev->lock held */
 static void do_ubd_request(request_queue_t *q)
 {
 	struct io_thread_req io_req;


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
