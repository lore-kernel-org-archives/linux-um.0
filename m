Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EKK64-0000AO-Ae	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 11:22:32 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EKK60-0006lo-Sf
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 27 Sep 2005 11:22:32 -0700
From: Jeff Dike <jdike@addtoit.com>
Subject: Re: [uml-devel] Review needed for ubd fixes
Message-ID: <20050927181218.GA28937@ccure.user-mode-linux.org>
References: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
	<200509212106.39169.blaisorblade@yahoo.it>
	<20050921204507.GA9918@ccure.user-mode-linux.org>
	<200509222251.31918.blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="45Z9DzgjV8m4Oswq"
Content-Disposition: inline
In-Reply-To: <200509222251.31918.blaisorblade@yahoo.it>
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
Date: Tue, 27 Sep 2005 14:12:18 -0400
To: Blaisorblade <blaisorblade@yahoo.it>
Cc: user-mode-linux-devel@lists.sourceforge.net, Bodo Stroesser <bstroesser@fujitsu-siemens.com>


--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Attached is my current set of I/O patches.  It's significantly different,
and simpler, than my previous set.

Now, there is no sleeping while running the queue, so the spinlock is never
dropped, and all of the extra synchronization is gone.

do_ubd_handler runs the queue until it's empty, or the host refuses to take
any more AIO requests.  If the queue not empty, then the current state
of the in-process request (the request itself and which sg entries have
not yet been sent to the host) is saved in the device structure.  When 
the interrupt handler empties out the host some, it will take the queue
lock and call the request handler to push some more requests to the host.

I also made the queues and locks per-device rather than having one for
all devices.  This means that when a device gets -EAGAIN from the host,
the interrupt handler needs to know which queues got stalled.  This is 
handled by having the request handler stick the device on a list when
this happems, and the interrupt handler walks that list when rerunning
request handlers.

The patch name is the same as before, and now quite misleading because
the queue lock is now not dropped.

ubd-atomic is much the same as before, except simple flags is used to
indicate whether the static buffers are available.  This is OK since 
any reading or writing of the flags happens under the queue spinlock.

init_aio_err is a simple error path cleanup patch.

aio-batching causes the AIO thread not to process completions until the
current batch of I/O is submitted.  I added this because I was seeing
a context switch between UML and the AIO thread on every AIO submission.
This keeps the AIO thread asleep until the current I/O is fully submitted 
and it may be able to process a bunch of completions at once.

o_direct adds O_DIRECT support to UML and makes the ubd driver use it.

aio-errors makes submit_aio_24 return -errno instead of -1.

I've given this a bunch of testing and it has survived overnight kernel
build loops on both x86 and x86_64.

The attached patches are against 2.6.14-rc2.

			Jeff

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ubd-drop-lock

# This patch changes the ubd I/O submission process to avoid some sleeping.
# When the host returns -EAGAIN from io_submit, do_ubd_request returns to
# its caller, saving the current state of the request submission in the 
# struct ubd.  This state consists of the request structure and the range
# of sg entries which have not yet been submitted.  If the request queue is
# drained, then this state is reset to indicate that, the next time it is 
# called, a new request needs to be pulled from the request queue.
# When do_ubd_request returns because the host can handle no more requests,
# it is necessary to rerun the queue after some completions have been handled.
# This is done by adding the device to the restart list.  ubd_intr walks
# this list before returning, calling do_ubd_request for each device.
# In addition, the queues and queue locks are now per-device, rather than
# having a single queue and lock for all devices.
# Note that kmalloc is still called, and can sleep.  This is fixed in a 
# future patch.
Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-27 11:33:43.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-27 12:02:00.000000000 -0400
@@ -82,7 +82,7 @@
 			   unsigned long *bitmap_len_out,
 			   int *data_offset_out);
 extern int read_cow_bitmap(int fd, void *buf, int offset, int len);
-extern void do_io(struct io_thread_req *req, struct request *r,
+static int do_io(struct io_thread_req *req, struct request *r,
 		  unsigned long *bitmap);
 
 static inline int ubd_test_bit(__u64 bit, void *data)
@@ -112,7 +112,6 @@
 
 #define DRIVER_NAME "uml-blkdev"
 
-static DEFINE_SPINLOCK(ubd_io_lock);
 static DEFINE_SPINLOCK(ubd_lock);
 
 static int ubd_open(struct inode * inode, struct file * filp);
@@ -129,9 +128,6 @@
         .ioctl		= ubd_ioctl,
 };
 
-/* Protected by the queue_lock */
-static request_queue_t *ubd_queue;
-
 /* Protected by ubd_lock */
 static int fake_major = MAJOR_NR;
 
@@ -164,6 +160,7 @@
 #define MAX_SG 64
 
 struct ubd {
+	struct list_head restart;
 	char *file;
 	int count;
 	int fd;
@@ -174,6 +171,10 @@
 	struct cow cow;
 	struct platform_device pdev;
         struct scatterlist sg[MAX_SG];
+	struct request_queue *queue;
+	spinlock_t lock;
+	struct request *request;
+	int start_sg, end_sg;
 };
 
 #define DEFAULT_COW { \
@@ -193,6 +194,10 @@
 	.openflags =		OPEN_FLAGS, \
         .no_cow =               0, \
         .cow =			DEFAULT_COW, \
+	.lock =			SPIN_LOCK_UNLOCKED, \
+	.request =		NULL, \
+	.start_sg =		0, \
+	.end_sg =		0, \
 }
 
 struct ubd ubd_dev[MAX_DEV] = { [ 0 ... MAX_DEV - 1 ] = DEFAULT_UBD };
@@ -466,7 +471,6 @@
 );
 
 static void do_ubd_request(request_queue_t * q);
-static int in_ubd;
 
 /* Changed by ubd_handler, which is serialized because interrupts only
  * happen on CPU 0.
@@ -494,9 +498,11 @@
 
 static inline void ubd_finish(struct request *req, int bytes)
 {
-   	spin_lock(&ubd_io_lock);
+	struct ubd *dev = req->rq_disk->private_data;
+
+   	spin_lock(&dev->lock);
 	__ubd_finish(req, bytes);
-  	spin_unlock(&ubd_io_lock);
+  	spin_unlock(&dev->lock);
 }
 
 struct bitmap_io {
@@ -513,12 +519,16 @@
 };
 
 static int ubd_reply_fd = -1;
+static struct list_head restart = LIST_HEAD_INIT(restart);
 
 static irqreturn_t ubd_intr(int irq, void *dev, struct pt_regs *unused)
 {
 	struct aio_thread_reply reply;
 	struct ubd_aio *aio;
 	struct request *req;
+	struct ubd *ubd;
+	struct list_head *list, *next;
+	unsigned long flags;
 	int err, n, fd = (int) (long) dev;
 
 	while(1){
@@ -532,10 +542,10 @@
 		}
 
                 aio = container_of(reply.data, struct ubd_aio, aio);
+		req = aio->req;
                 n = reply.err;
 
 		if(n == 0){
-			req = aio->req;
 			req->nr_sectors -= aio->len >> 9;
 
 			if((aio->bitmap != NULL) &&
@@ -559,7 +569,7 @@
 			}
 		}
                 else if(n < 0){
-                        ubd_finish(aio->req, n);
+                        ubd_finish(req, n);
                         if(aio->bitmap != NULL)
                                 kfree(aio->bitmap);
                         if(aio->bitmap_buf != NULL)
@@ -567,10 +577,15 @@
                         kfree(aio);
                 }
 	}
-	reactivate_fd(fd, UBD_IRQ);
-
-        do_ubd_request(ubd_queue);
+	list_for_each_safe(list, next, &restart){
+		ubd = container_of(list, struct ubd, restart);
+		list_del_init(&ubd->restart);
+		spin_lock_irqsave(&ubd->lock, flags);
+		do_ubd_request(ubd->queue);
+		spin_unlock_irqrestore(&ubd->lock, flags);
+	}
 
+	reactivate_fd(fd, UBD_IRQ);
 	return(IRQ_HANDLED);
 }
 
@@ -693,7 +708,7 @@
 	}
 
 	disk->private_data = &ubd_dev[unit];
-	disk->queue = ubd_queue;
+	disk->queue = ubd_dev[unit].queue;
 	add_disk(disk);
 
 	*disk_out = disk;
@@ -719,10 +734,19 @@
 		goto out_close;
 
 	dev->size = ROUND_BLOCK(dev->size);
+	INIT_LIST_HEAD(&dev->restart);
+
+	err = -ENOMEM;
+	dev->queue = blk_init_queue(do_ubd_request, &dev->lock);
+	if (!dev->queue)
+		goto out_close;
 
+	blk_queue_max_hw_segments(dev->queue, MAX_SG);
+	dev->queue->queuedata = dev;
+		
 	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
 	if(err) 
-		goto out_close;
+		goto out_cleanup;
  
 	if(fake_major != MAJOR_NR)
 		ubd_new_disk(fake_major, dev->size, n, 
@@ -738,6 +762,10 @@
 	ubd_close(dev);
 out:
 	return err;
+
+out_cleanup:
+	blk_cleanup_queue(dev->queue);
+	goto out_close;
 }
 
 static int ubd_config(char *str)
@@ -878,13 +906,6 @@
 	if (register_blkdev(MAJOR_NR, "ubd"))
 		return -1;
 
-	ubd_queue = blk_init_queue(do_ubd_request, &ubd_io_lock);
-	if (!ubd_queue) {
-		unregister_blkdev(MAJOR_NR, "ubd");
-		return -1;
-	}
-		
-	blk_queue_max_hw_segments(ubd_queue, MAX_SG);
 	if (fake_major != MAJOR_NR) {
 		char name[sizeof("ubd_nnn\0")];
 
@@ -956,22 +977,13 @@
         }
 }
 
-/* Called with ubd_io_lock held */
-static int prepare_request(struct request *req, struct io_thread_req *io_req,
-                           unsigned long long offset, int page_offset,
-                           int len, struct page *page)
+static void prepare_request(struct request *req, struct io_thread_req *io_req,
+			    unsigned long long offset, int page_offset,
+			    int len, struct page *page)
 {
 	struct gendisk *disk = req->rq_disk;
 	struct ubd *dev = disk->private_data;
 
-	/* This should be impossible now */
-	if((rq_data_dir(req) == WRITE) && !dev->openflags.w){
-		printk("Write attempted on readonly ubd device %s\n", 
-		       disk->disk_name);
-                ubd_end_request(req, 0, 0);
-		return(1);
-	}
-
 	io_req->fds[0] = (dev->cow.file != NULL) ? dev->cow.fd : dev->fd;
 	io_req->fds[1] = dev->fd;
 	io_req->offset = offset;
@@ -988,44 +1000,51 @@
 
         if((dev->cow.file != NULL) && (io_req->op == UBD_WRITE))
                 cowify_bitmap(io_req, dev->cow.bitmap);
-	return(0);
 }
 
-/* Called with ubd_io_lock held */
+/* Called with dev->lock held */
 static void do_ubd_request(request_queue_t *q)
 {
 	struct io_thread_req io_req;
 	struct request *req;
-	__u64 sector;
-	int err;
 
-	if(in_ubd)
-		return;
-	in_ubd = 1;
-	while((req = elv_next_request(q)) != NULL){
-		struct gendisk *disk = req->rq_disk;
-		struct ubd *dev = disk->private_data;
-		int n, i;
+	while(1){
+		struct ubd *dev = q->queuedata;
 
-		blkdev_dequeue_request(req);
+		if(dev->end_sg == 0){
+			struct request *req = elv_next_request(q);
+			if(req == NULL)
+				return;
+
+			dev->request = req;
+			blkdev_dequeue_request(req);
+			dev->start_sg = 0;
+			dev->end_sg = blk_rq_map_sg(q, req, dev->sg);
+		}
 
-		sector = req->sector;
-		n = blk_rq_map_sg(q, req, dev->sg);
+		req = dev->request;
 
-		for(i = 0; i < n; i++){
-			struct scatterlist *sg = &dev->sg[i];
+		while(dev->start_sg < dev->end_sg){
+			struct scatterlist *sg = &dev->sg[dev->start_sg];
 
-			err = prepare_request(req, &io_req, sector << 9,
+			err = prepare_request(req, &io_req, req->sector << 9,
 					      sg->offset, sg->length,
 					      sg->page);
 			if(err)
 				continue;
 
-			sector += sg->length >> 9;
-			do_io(&io_req, req, dev->cow.bitmap);
+			if(do_io(&io_req, req, dev->cow.bitmap) == -EAGAIN){
+				if(list_empty(&dev->restart))
+					list_add(&dev->restart, &restart);
+				return;
+			}
+
+			req->sector += sg->length >> 9;
+			dev->start_sg++;
 		}
+		dev->end_sg = 0;
+		dev->request = NULL;
 	}
-	in_ubd = 0;
 }
 
 static int ubd_ioctl(struct inode * inode, struct file * file,
@@ -1241,7 +1260,8 @@
 	return(err);
 }
 
-void do_io(struct io_thread_req *req, struct request *r, unsigned long *bitmap)
+static int do_io(struct io_thread_req *req, struct request *r, 
+		 unsigned long *bitmap)
 {
         struct ubd_aio *aio;
         struct bitmap_io *bitmap_io = NULL;
@@ -1265,7 +1285,7 @@
                 if(bitmap_io == NULL){
                         printk("Failed to kmalloc bitmap IO\n");
                         req->error = 1;
-                        return;
+                        return -ENOMEM;
                 }
 
                 bitmap_buf = kmalloc(len, GFP_KERNEL);
@@ -1274,7 +1294,7 @@
                                "failed\n");
                         kfree(bitmap_io);
                         req->error = 1;
-                        return;
+                        return -ENOMEM;
                 }
                 memcpy(bitmap_buf, &bitmap[off / sizeof(bitmap[0])], len);
 
@@ -1308,7 +1328,7 @@
                 aio = kmalloc(sizeof(*aio), GFP_KERNEL);
                 if(aio == NULL){
                         req->error = 1;
-                        return;
+                        return -ENOMEM;
                 }
 
                 *aio = ((struct ubd_aio)
@@ -1322,14 +1342,18 @@
                 if(aio->bitmap != NULL)
                         atomic_inc(&aio->bitmap->count);
 
-                err = submit_aio(&aio->aio);
+		err = submit_aio(&aio->aio);
                 if(err){
-                        printk("do_io - submit_aio failed, "
-                               "err = %d\n", err);
-                        req->error = 1;
-                        return;
+			if(err != -EAGAIN){
+				printk("do_io - submit_aio failed, "
+				       "err = %d\n", err);
+				req->error = 1;
+			}
+                        return err;
                 }
 
                 start = end;
         } while(start < nsectors);
+
+	return 0;
 }
Index: test/arch/um/os-Linux/aio.c
===================================================================
--- test.orig/arch/um/os-Linux/aio.c	2005-09-27 11:33:43.000000000 -0400
+++ test/arch/um/os-Linux/aio.c	2005-09-27 12:02:00.000000000 -0400
@@ -296,6 +296,9 @@
 	int err;
 
 	err = do_aio(ctx, aio);
+	if(err == -EAGAIN)
+		return err;
+
 	if(err){
 		reply = ((struct aio_thread_reply) { .data = aio,
 					             .err  = err });

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=ubd-atomic

# To ensure that I/O can always make progress, even when there is no
# memory, we provide static buffers which are to be used when dynamic
# ones can't be allocated.  These buffers are protected by flags which
# are set when they are currently in use.  The use of these flags is 
# protected by the queue lock, which is held for the duration of the 
# do_ubd_request call.
#
# There is an allocation failure emulation
# mechanism here - setting fail_start and fail_end will cause
# allocations in that range (fail_start <= allocations < fail_end) to
# fail, invoking the emergency mechanism.
# When this is happening, I/O requests proceed one at a time,
# essentially synchronously, until allocations start succeeding again.
#
# This currently doesn't handle the bitmap array, since that can be of
# any length, so we can't have a static version of it at this point.
Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-27 12:02:00.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-27 12:02:19.000000000 -0400
@@ -518,6 +518,73 @@
         void *bitmap_buf;
 };
 
+static int allocations;
+static int fail_start, fail_end;
+
+static struct bitmap_io emergency_bitmap_io;
+static int bitmap_io_taken = 0;
+
+static struct bitmap_io *alloc_bitmap_io(void)
+{
+	struct bitmap_io *ret;
+
+	allocations++;
+	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
+
+	if((allocations >= fail_start) && (allocations < fail_end)){
+		kfree(ret);
+		ret = NULL;
+	}
+
+	if(ret != NULL)
+		return ret;
+
+	if(bitmap_io_taken)
+		return ERR_PTR(-EAGAIN);
+
+	bitmap_io_taken = 1;
+	return(&emergency_bitmap_io);
+}
+
+static void free_bitmap_io(struct bitmap_io *io)
+{
+	if(io == &emergency_bitmap_io)
+		bitmap_io_taken = 0;
+	else kfree(io);
+}
+
+static struct ubd_aio emergency_aio;
+static int aio_taken = 0;
+
+static struct ubd_aio *alloc_ubd_aio(void)
+{
+	struct ubd_aio *ret;
+
+	allocations++;
+	ret = kmalloc(sizeof(*ret), GFP_ATOMIC);
+
+	if((allocations >= fail_start) && (allocations < fail_end)){
+		kfree(ret);
+		ret = NULL;
+	}
+
+	if(ret != NULL)
+		return ret;
+
+	if(aio_taken)
+		return ERR_PTR(-EAGAIN);
+
+	aio_taken = 1;
+	return(&emergency_aio);
+}
+
+static void free_ubd_aio(struct ubd_aio *aio)
+{
+	if(aio == &emergency_aio)
+		aio_taken = 0;
+	else kfree(aio);
+}
+
 static int ubd_reply_fd = -1;
 static struct list_head restart = LIST_HEAD_INIT(restart);
 
@@ -552,7 +619,7 @@
 			   (atomic_dec_and_test(&aio->bitmap->count))){
                                 aio->aio = aio->bitmap->aio;
                                 aio->len = 0;
-                                kfree(aio->bitmap);
+				free_bitmap_io(aio->bitmap);
                                 aio->bitmap = NULL;
                                 submit_aio(&aio->aio);
 			}
@@ -565,16 +632,16 @@
 
                                 if(aio->bitmap_buf != NULL)
                                         kfree(aio->bitmap_buf);
-				kfree(aio);
+				free_ubd_aio(aio);
 			}
 		}
                 else if(n < 0){
                         ubd_finish(req, n);
                         if(aio->bitmap != NULL)
-                                kfree(aio->bitmap);
+				free_bitmap_io(aio->bitmap);
                         if(aio->bitmap_buf != NULL)
                                 kfree(aio->bitmap_buf);
-                        kfree(aio);
+			free_ubd_aio(aio);
                 }
 	}
 	list_for_each_safe(list, next, &restart){
@@ -1274,6 +1341,10 @@
         if(req->bitmap_start != -1){
                 /* Round up to the nearest word */
                 int round = sizeof(unsigned long);
+		bitmap_io = alloc_bitmap_io();
+		if(IS_ERR(bitmap_io))
+			return PTR_ERR(bitmap_io);
+
                 len = (req->bitmap_end - req->bitmap_start +
                        round * 8 - 1) / (round * 8);
                 len *= round;
@@ -1281,18 +1352,11 @@
                 off = req->bitmap_start / (8 * round);
                 off *= round;
 
-                bitmap_io = kmalloc(sizeof(*bitmap_io), GFP_KERNEL);
-                if(bitmap_io == NULL){
-                        printk("Failed to kmalloc bitmap IO\n");
-                        req->error = 1;
-                        return -ENOMEM;
-                }
-
                 bitmap_buf = kmalloc(len, GFP_KERNEL);
                 if(bitmap_buf == NULL){
                         printk("do_io : kmalloc of bitmap chunk "
                                "failed\n");
-                        kfree(bitmap_io);
+			free_bitmap_io(bitmap_io);
                         req->error = 1;
                         return -ENOMEM;
                 }
@@ -1325,11 +1389,9 @@
                 len = (end - start) * req->sectorsize;
                 buf = &req->buffer[start * req->sectorsize];
 
-                aio = kmalloc(sizeof(*aio), GFP_KERNEL);
-                if(aio == NULL){
-                        req->error = 1;
-                        return -ENOMEM;
-                }
+		aio = alloc_ubd_aio();
+		if(IS_ERR(aio))
+			return PTR_ERR(aio);
 
                 *aio = ((struct ubd_aio)
                         { .aio		= INIT_AIO(req->op, req->fds[bit], buf,

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=init_aio_err

Index: test/arch/um/os-Linux/aio.c
===================================================================
--- test.orig/arch/um/os-Linux/aio.c	2005-09-27 12:02:00.000000000 -0400
+++ test/arch/um/os-Linux/aio.c	2005-09-27 12:02:42.000000000 -0400
@@ -321,21 +321,23 @@
 		err = -errno;
                 printk("aio_thread failed to initialize context, err = %d\n",
                        errno);
-                return err;
+		goto out;
         }
 
         err = run_helper_thread(aio_thread, NULL,
                                 CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
         if(err < 0)
-                return err;
+		goto out;
 
         aio_pid = err;
+	err = 0;
 
 	printk("Using 2.6 host AIO\n");
 
 	submit_proc = submit_aio_26;
 
-        return 0;
+out:
+        return err;
 }
 
 #else

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=aio-batching

Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-27 12:02:19.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-27 12:03:00.000000000 -0400
@@ -1081,7 +1081,7 @@
 		if(dev->end_sg == 0){
 			struct request *req = elv_next_request(q);
 			if(req == NULL)
-				return;
+				goto out;
 
 			dev->request = req;
 			blkdev_dequeue_request(req);
@@ -1103,7 +1103,7 @@
 			if(do_io(&io_req, req, dev->cow.bitmap) == -EAGAIN){
 				if(list_empty(&dev->restart))
 					list_add(&dev->restart, &restart);
-				return;
+				goto out;
 			}
 
 			req->sector += sg->length >> 9;
@@ -1112,6 +1112,8 @@
 		dev->end_sg = 0;
 		dev->request = NULL;
 	}
+out:
+	finish_aio();
 }
 
 static int ubd_ioctl(struct inode * inode, struct file * file,
Index: test/arch/um/include/aio.h
===================================================================
--- test.orig/arch/um/include/aio.h	2005-09-27 11:33:43.000000000 -0400
+++ test/arch/um/include/aio.h	2005-09-27 12:03:00.000000000 -0400
@@ -36,5 +36,6 @@
 			   .next	= NULL }
 
 extern int submit_aio(struct aio_context *aio);
+extern int finish_aio(void);
 
 #endif
Index: test/arch/um/os-Linux/aio.c
===================================================================
--- test.orig/arch/um/os-Linux/aio.c	2005-09-27 12:02:42.000000000 -0400
+++ test/arch/um/os-Linux/aio.c	2005-09-27 12:03:00.000000000 -0400
@@ -80,6 +80,9 @@
  * that it now backs the mmapped area.
  */
 
+/* XXX Fix for SMP */
+static int pending_events;
+
 static int do_aio(aio_context_t ctx, struct aio_context *aio)
 {
         struct iocb iocb, *iocbp = &iocb;
@@ -115,8 +118,10 @@
         }
 
         err = io_submit(ctx, 1, &iocbp);
-        if(err > 0)
+        if(err > 0){
                 err = 0;
+		pending_events++;
+	}
 	else
 		err = -errno;
 
@@ -124,6 +129,21 @@
         return err;
 }
 
+static int aio_wakeup_r_fd;
+static int aio_wakeup_w_fd;
+
+static int finish_aio_26(void)
+{
+	int err;
+
+	err = write(aio_wakeup_w_fd, &pending_events, sizeof(pending_events));
+	err = (err != sizeof(pending_events)) ? errno : 0;
+
+	pending_events = 0;
+
+	return err;
+}
+
 static aio_context_t ctx = 0;
 
 static int aio_thread(void *arg)
@@ -131,35 +151,44 @@
         struct aio_thread_reply reply;
         struct aio_context *aio;
         struct io_event event;
-        int err, n;
+        int err, i, n, nevents;
 
         signal(SIGWINCH, SIG_IGN);
 
         while(1){
-                n = io_getevents(ctx, 1, 1, &event, NULL);
-                if(n < 0){
-                        if(errno == EINTR)
-                                continue;
-                        printk("aio_thread - io_getevents failed, "
-                               "errno = %d\n", errno);
-                }
-                else {
-			aio = (struct aio_context *) (long) event.data;
-			if(update_aio(aio, event.res)){
-				do_aio(ctx, aio);
-				continue;
+		n = read(aio_wakeup_r_fd, &nevents, sizeof(nevents));
+		if(n != sizeof(nevents)){
+			   printk("aio_thread - reading wakeup fd returned "
+				  "%d, errno = %d\n", n, errno);
+			   continue;
+		}
+
+		for(i = 0; i < nevents; i++){
+			n = io_getevents(ctx, 1, 1, &event, NULL);
+			if(n < 0){
+				if(errno == EINTR)
+					continue;
+				printk("aio_thread - io_getevents failed, "
+				       "errno = %d\n", errno);
 			}
-
-                        reply = ((struct aio_thread_reply)
-				{ .data = aio,
-				  .err	= aio->len });
-			err = os_write_file(aio->reply_fd, &reply,
-					    sizeof(reply));
-                        if(err != sizeof(reply))
-				printk("aio_thread - write failed, "
-				       "fd = %d, err = %d\n", aio->reply_fd,
-				       -err);
-                }
+			else {
+				aio = (struct aio_context *) (long) event.data;
+				if(update_aio(aio, event.res)){
+					do_aio(ctx, aio);
+					continue;
+				}
+
+				reply = ((struct aio_thread_reply)
+					{ .data = aio,
+							.err	= aio->len });
+				err = os_write_file(aio->reply_fd, &reply,
+						    sizeof(reply));
+				if(err != sizeof(reply))
+					printk("aio_thread - write failed, "
+					       "fd = %d, err = %d\n", 
+					       aio->reply_fd, -err);
+			}
+		}
         }
         return 0;
 }
@@ -251,6 +280,7 @@
 
 static int aio_pid = -1;
 static int (*submit_proc)(struct aio_context *aio);
+static int (*finish_proc)(void);
 
 static int init_aio_24(void)
 {
@@ -315,7 +345,7 @@
 static int init_aio_26(void)
 {
         unsigned long stack;
-        int err;
+        int err, wakeup_pipe[2];
 
         if(io_setup(256, &ctx)){
 		err = -errno;
@@ -324,10 +354,18 @@
 		goto out;
         }
 
+	if(pipe(wakeup_pipe) < 0){
+		err = -errno;
+		goto out;
+	}
+
+	aio_wakeup_r_fd = wakeup_pipe[0];
+	aio_wakeup_w_fd = wakeup_pipe[1];
+
         err = run_helper_thread(aio_thread, NULL,
                                 CLONE_FILES | CLONE_VM | SIGCHLD, &stack, 0);
         if(err < 0)
-		goto out;
+		goto out_close;
 
         aio_pid = err;
 	err = 0;
@@ -335,9 +373,15 @@
 	printk("Using 2.6 host AIO\n");
 
 	submit_proc = submit_aio_26;
+	finish_proc = finish_aio_26;
 
 out:
         return err;
+
+out_close:
+	close(wakeup_pipe[0]);
+	close(wakeup_pipe[1]);
+	goto out;
 }
 
 #else
@@ -350,6 +394,7 @@
 static int init_aio_26(void)
 {
 	submit_proc = submit_aio_26;
+	finish_proc = finish_aio_26;
         return -ENOSYS;
 }
 #endif
@@ -420,3 +465,11 @@
 {
 	return (*submit_proc)(aio);
 }
+
+int finish_aio(void)
+{
+	if(finish_proc == NULL)
+		return 0;
+
+	return (*finish_proc)();
+}

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=o_direct

Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-27 12:03:00.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-27 12:03:15.000000000 -0400
@@ -136,10 +136,10 @@
  
 #ifdef CONFIG_BLK_DEV_UBD_SYNC
 #define OPEN_FLAGS ((struct openflags) { .r = 1, .w = 1, .s = 1, .c = 0, \
-					 .cl = 1 })
+				         .cl = 1, .d = 1 })
 #else
 #define OPEN_FLAGS ((struct openflags) { .r = 1, .w = 1, .s = 0, .c = 0, \
-					 .cl = 1 })
+					 .cl = 1, .d = 1  })
 #endif
 
 /* Not protected - changed only in ubd_setup_common and then only to
@@ -809,6 +809,8 @@
 		goto out_close;
 
 	blk_queue_max_hw_segments(dev->queue, MAX_SG);
+	blk_queue_hardsect_size(dev->queue, PAGE_SIZE);
+
 	dev->queue->queuedata = dev;
 		
 	err = ubd_new_disk(MAJOR_NR, dev->size, n, &ubd_gendisk[n]);
@@ -1094,11 +1096,8 @@
 		while(dev->start_sg < dev->end_sg){
 			struct scatterlist *sg = &dev->sg[dev->start_sg];
 
-			err = prepare_request(req, &io_req, req->sector << 9,
-					      sg->offset, sg->length,
-					      sg->page);
-			if(err)
-				continue;
+			prepare_request(req, &io_req, req->sector << 9,
+					sg->offset, sg->length, sg->page);
 
 			if(do_io(&io_req, req, dev->cow.bitmap) == -EAGAIN){
 				if(list_empty(&dev->restart))
Index: test/arch/um/include/os.h
===================================================================
--- test.orig/arch/um/include/os.h	2005-09-27 11:33:43.000000000 -0400
+++ test/arch/um/include/os.h	2005-09-27 12:19:15.000000000 -0400
@@ -52,10 +52,12 @@
 	unsigned int a : 1;	/* O_APPEND */
 	unsigned int e : 1;	/* O_EXCL */
 	unsigned int cl : 1;    /* FD_CLOEXEC */
+        unsigned int d : 1;     /* O_DIRECT */
 };
 
 #define OPENFLAGS() ((struct openflags) { .r = 0, .w = 0, .s = 0, .c = 0, \
- 					  .t = 0, .a = 0, .e = 0, .cl = 0 })
+                                          .t = 0, .a = 0, .e = 0, .cl = 0, \
+                                          .d = 0 })
 
 static inline struct openflags of_read(struct openflags flags)
 {
@@ -117,6 +119,12 @@
 	return(flags); 
 }
   
+static inline struct openflags of_direct(struct openflags flags)
+{ 
+	flags.d = 1; 
+	return(flags); 
+}
+
 extern int os_stat_file(const char *file_name, struct uml_stat *buf);
 extern int os_stat_fd(const int fd, struct uml_stat *buf);
 extern int os_access(const char *file, int mode);
Index: test/arch/um/os-Linux/file.c
===================================================================
--- test.orig/arch/um/os-Linux/file.c	2005-09-27 11:33:43.000000000 -0400
+++ test/arch/um/os-Linux/file.c	2005-09-27 12:03:15.000000000 -0400
@@ -249,6 +249,7 @@
 	if(flags.c) f |= O_CREAT;
 	if(flags.t) f |= O_TRUNC;
 	if(flags.e) f |= O_EXCL;
+	if(flags.d) f |= O_DIRECT;
 
 	fd = open64(file, f, mode);
 	if(fd < 0)

--45Z9DzgjV8m4Oswq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=aio-errors

Index: test/arch/um/os-Linux/aio.c
===================================================================
--- test.orig/arch/um/os-Linux/aio.c	2005-09-27 12:03:00.000000000 -0400
+++ test/arch/um/os-Linux/aio.c	2005-09-27 12:03:29.000000000 -0400
@@ -274,6 +274,7 @@
         err = os_write_file(aio_req_fd_w, &aio, sizeof(aio));
         if(err == sizeof(aio))
                 err = 0;
+	else err = -errno;
 
         return err;
 }

--45Z9DzgjV8m4Oswq--


-------------------------------------------------------
This SF.Net email is sponsored by:
Power Architecture Resource Center: Free content, downloads, discussions,
and more. http://solutions.newsforge.com/ibmarch.tmpl
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
