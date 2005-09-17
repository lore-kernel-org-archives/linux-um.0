Return-Path: <user-mode-linux-devel-admin@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1.sourceforge.net with esmtp (Exim 4.30)
	id 1EGlm9-0004FJ-65	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 16:07:17 -0700
Received: from lakshmi.addtoit.com ([198.99.130.6] helo=lakshmi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44)	id 1EGlm7-0002TB-U5
	for user-mode-linux-devel@lists.sourceforge.net;
	Sat, 17 Sep 2005 16:07:17 -0700
Message-Id: <200509172245.j8HMjqJD009056@ccure.user-mode-linux.org>
Mime-Version: 1.0
Content-Type: multipart/mixed ;
	boundary="==_Exmh_1126996877_57630"
From: Jeff Dike <jdike@addtoit.com>
Subject: [uml-devel] Review needed for ubd fixes
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
Date: Sat, 17 Sep 2005 18:45:52 -0400
To: Blaisorblade <blaisorblade@yahoo.it>, Bodo Stroesser <bstroesser@fujitsu-siemens.com>
Cc: user-mode-linux-devel@lists.sourceforge.net

This is a multipart MIME message.

--==_Exmh_1126996877_57630
Content-Type: text/plain; charset=us-ascii

I've spent some time working on the ubd and AIO problems that have cropped up 
recently.  Patches are attached - a critical look at them would be appreciated.

I'm going to start with a problem that hasn't exactly cropped up, and move on
to the other ones from there.

That is that the ubd driver must issue I/O requests to the host even if there
is no memory available.  It must make progress, because the request for which
it can't get memory might be the swapping that will free some up.

The driver allocates memory for several purposes -
	a header-type buffer per request which holds the bitmap data
	one aio request per chunk - a request may be broken into chunks because
of COWing - some pieces from the backing file, some from the COW file

To allow the driver to always make progress, even when no memory is available,
I added a static instance of each buffer and made the kmalloc calls atomic.  
When kmalloc fails, then the static buffer is used.  When it is in use, the
user acquires a semaphore, which is released in the interrupt handler when the
buffer is freed.  This implies that future I/O submissions will sleep on the
semaphore, so we have changed the reason for sleeping rather than eliminating 
it.

Any I/O submissions which need memory will sleep on the semaphore until the
buffer is released, resulting in synchronous, one at a time, I/O submission
until the memory shortage has cleared up.

Now that it is established that we must sleep, the next problem is making sure
the requests get submitted to the host in the order that they were queued to
the driver.  Because we must sleep, we must drop the queue spinlock, which opens
the queue to any other processes that want to do I/O.  One of these can queue
to the allocation semaphore (or just kmalloc memory now that some is available)
and sneak ahead of a process handling an earlier request.

To solve this, I add two atomic variables and a wait queue.  One of the 
variables, started, counts the number of requests that have been submitted 
to the driver and the other, submitted, counts the number that have been 
submitted to the host.  started is incremented before any submissions, submitted
is incremented after all submissions for the request.

The driver gets the value of started and waits for submitted to catch up to
it.  When that happens, it is now that requests's turn, and it wakes up from 
the sequence wake queue.

I believe these three fixes - dropping the spinlock around host I/O submission,
adding the static buffers, and sequencing requests - cover the scheduling while
atomic problem and associated problems.

Next is a deadlock that I found during a kernel build loop.  The AIO thread
seems to be able to fill the pipe back to UML with I/O completions.  When this
happens, it sleeps in a write and stops calling io_getevents.  If UML keeps
submitting events, the AIO ring buffer will fill, and io_submit will start
returning -EAGAIN.  At this point, UML will try to write the error to itself
through the same pipe that the AIO thread has filled.  It will now sleep.
Since interrupts are off, that pipe can never be emptied since it is handled
by the driver's interrupt routine, and we are deadlocked.

Enabling interrups during the submission seems to help, but doesn't eliminate
the deadlock.  To fix it for real, I now have the -EAGAIN returned to the 
driver, which sleeps on a wait queue which is woken up by the interrupt 
routine.  Interrupts are enabled, as they must be during sleep, so the handler
can wake the queue after it has processed some completions, and the driver
can retry.

As for the interactions between the wait queues and the semaphores - the 
sequence wait queue controls access to everything else.  Once a request is
past that, it can only deadlock with itself.  The allocation semaphore is used
by a finishing request to wake up the next one.  The eagain wait queue is taken
in a loop with no sleeping on anything else.

The patches are attached.  They are:

ubd-drop-lock - drops the ubd_io_lock around the call to do_io and takes it
before dequeuing the next request.  It also removes the call of do_ubd_request
from the interrupt handler since the request handler now processes the entire 
queue in one call.

ubd-atomic - makes the kmalloc calls atomic and adds the static buffers, 
associated semaphores and related synchronization.  Unfinished - it doesn't
have a static version of the bitmap, since that is variable length, so it's not
so easy to have a static copy of it.

ubd-sequence - makes the requests go out in the right order.  Adds the sequence
wait queue which controls access to the actual submission code.

ubd-eagain - the -EAGAIN handling - waits in the eagain wait queue to be woken
up by the interrupt handler after it has processed some completions.

These are all against 2.6.14-rc1-mm1.  They should apply to 2.6.14-rc1, but I
haven't checked that.

				Jeff

P.S. exmh insisted on a crazy attachment order - the order is the one listed
above, not the order of attachment.

--==_Exmh_1126996877_57630
Content-Type: text/plain ; name="ubd-eagain"; charset=us-ascii
Content-Description: ubd-eagain
Content-Disposition: attachment; filename="ubd-eagain"

# We may submit more requests to the host than it is prepared to
# handle.  In this case, io_submit returns -EAGAIN.  When this
# happens, we return from submit_aio and sleep on the eagain_queue
# wait_queue.  We are woken from the interrupt handler - if some
# requests have come back from the host, presumably there's some room
# on the host to submit more requests.
#
# Interactions between this wait_queue and the sequence_queue and the
# allocation semaphore - the sequence queue and any allocations always
# happen first.  While looping on this wait_queue, we do nothing but
# try to resubmit to the host.
Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-17 17:40:53.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-17 17:41:03.000000000 -0400
@@ -574,6 +574,9 @@
 
 static int ubd_reply_fd = -1;
 
+DECLARE_WAIT_QUEUE_HEAD(eagain_queue);
+static int dequeued;
+
 static irqreturn_t ubd_intr(int irq, void *dev, struct pt_regs *unused)
 {
 	struct aio_thread_reply reply;
@@ -629,6 +632,9 @@
 	}
 	reactivate_fd(fd, UBD_IRQ);
 
+	dequeued = 1;
+	wake_up(&eagain_queue);
+
 	return(IRQ_HANDLED);
 }
 
@@ -1376,7 +1382,19 @@
                 if(aio->bitmap != NULL)
                         atomic_inc(&aio->bitmap->count);
 
-                err = submit_aio(&aio->aio);
+		while(1){
+			unsigned long flags;
+
+			err = submit_aio(&aio->aio);
+			if(err != -EAGAIN)
+				break;
+			dequeued = 0;
+			local_save_flags(flags);
+			local_irq_enable();
+			wait_event(eagain_queue, dequeued);
+			local_irq_restore(flags);
+		}
+
                 if(err){
                         printk("do_io - submit_aio failed, "
                                "err = %d\n", err);
Index: test/arch/um/os-Linux/aio.c
===================================================================
--- test.orig/arch/um/os-Linux/aio.c	2005-09-17 17:39:33.000000000 -0400
+++ test/arch/um/os-Linux/aio.c	2005-09-17 17:41:03.000000000 -0400
@@ -296,6 +296,9 @@
 	int err;
 
 	err = do_aio(ctx, aio);
+	if(err == -EAGAIN)
+		return err;
+
 	if(err){
 		reply = ((struct aio_thread_reply) { .data = aio,
 					             .err  = err });

--==_Exmh_1126996877_57630
Content-Type: text/plain ; name="ubd-sequence"; charset=us-ascii
Content-Description: ubd-sequence
Content-Disposition: attachment; filename="ubd-sequence"

# It is important that I/O requests be submitted to the host in the
# order that they are received by the driver, especially since the
# driver can sleep.  This patch adds two atomic counters, one for
# requests started and one for requests submitted to the host.  A new
# request can proceed when started (after being incremented) is one
# more than submitted.  submitted is incremented after all pieces of
# the request have been sent to the host.
# When a request is proceeding out of order, it will sleep on a wait
# queue until its number comes up.
#
# Interaction between this wait_queue and the emergency allocation
# semaphore - a request will only try to allocate data when it is
# its turn to go.  The wait_queue is finished before the semaphore is
# acquired, so there can't be a deadlock between one process holding
# the allocation semaphore and sleeping because it's out of order and
# one proceeding in order and sleeping on the allocation semaphore.
#
# This currently doesn't correctly handle the bitmap, which must be
# written after the data has been finished.  These must be sequenced
# in the same way as the data.
Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-17 17:40:34.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-17 17:40:53.000000000 -0400
@@ -1297,6 +1297,10 @@
 	return(err);
 }
 
+static atomic_t started = ATOMIC_INIT(0);
+static atomic_t submitted = ATOMIC_INIT(0);
+DECLARE_WAIT_QUEUE_HEAD(sequence_queue);
+
 void do_io(struct io_thread_req *req, struct request *r, unsigned long *bitmap)
 {
         struct ubd_aio *aio;
@@ -1304,14 +1308,18 @@
         char *buf;
         void *bitmap_buf = NULL;
         unsigned long len, sector;
-        int nsectors, start, end, bit, err;
+        int nsectors, start, end, bit, err, want;
         __u64 off;
 
-        if(req->bitmap_start != -1){
-		bitmap_io = alloc_bitmap_io();
+	want = atomic_add_return(1, &started);
+	wait_event(sequence_queue, want - 1 == atomic_read(&submitted));
 
+        if(req->bitmap_start != -1){
                 /* Round up to the nearest word */
                 int round = sizeof(unsigned long);
+
+		bitmap_io = alloc_bitmap_io();
+
                 len = (req->bitmap_end - req->bitmap_start +
                        round * 8 - 1) / (round * 8);
                 len *= round;
@@ -1378,4 +1386,7 @@
 
                 start = end;
         } while(start < nsectors);
+
+	atomic_inc(&submitted);
+	wake_up(&sequence_queue);
 }

--==_Exmh_1126996877_57630
Content-Type: text/plain ; name="ubd-drop-lock"; charset=us-ascii
Content-Description: ubd-drop-lock
Content-Disposition: attachment; filename="ubd-drop-lock"

# This patch drops the ubd_io_lock around do_io, where we might sleep,
# and picks it up afterwards.  This looks safe since it protects the
# queue, and we have already picked a request off it and are dealing
# with it without referring to the queue again.  It is picked up
# before dequeueing the next request.
#
# It also removes the chaining from the interrupt routine, where it
# calls do_ubd_request to start the next request.  This is unecessary
# since do_ubd_request now processes the entire queue before
# returning.
#
# This is needed because we currently do non-atomic allocations.
# These will be removed later, but we will also be introducing new
# ways to sleep.
Index: test/arch/um/drivers/ubd_kern.c
===================================================================
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-17 17:39:24.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-17 17:40:08.000000000 -0400
@@ -466,7 +466,6 @@
 );
 
 static void do_ubd_request(request_queue_t * q);
-static int in_ubd;
 
 /* Changed by ubd_handler, which is serialized because interrupts only
  * happen on CPU 0.
@@ -569,8 +568,6 @@
 	}
 	reactivate_fd(fd, UBD_IRQ);
 
-        do_ubd_request(ubd_queue);
-
 	return(IRQ_HANDLED);
 }
 
@@ -999,15 +996,13 @@
 	__u64 sector;
 	int err;
 
-	if(in_ubd)
-		return;
-	in_ubd = 1;
 	while((req = elv_next_request(q)) != NULL){
 		struct gendisk *disk = req->rq_disk;
 		struct ubd *dev = disk->private_data;
 		int n, i;
 
 		blkdev_dequeue_request(req);
+		spin_unlock(&ubd_io_lock);
 
 		sector = req->sector;
 		n = blk_rq_map_sg(q, req, dev->sg);
@@ -1024,8 +1019,8 @@
 			sector += sg->length >> 9;
 			do_io(&io_req, req, dev->cow.bitmap);
 		}
+		spin_lock(&ubd_io_lock);
 	}
-	in_ubd = 0;
 }
 
 static int ubd_ioctl(struct inode * inode, struct file * file,

--==_Exmh_1126996877_57630
Content-Type: text/plain ; name="ubd-atomic"; charset=us-ascii
Content-Description: ubd-atomic
Content-Disposition: attachment; filename="ubd-atomic"

# To ensure that I/O can always make progress, even when there is no
# memory, we provide static buffers which are to be used when dynamic
# ones can't be allocated.  These are protected by a semaphore when in
# use.  When one is freed, the semaphore is released, and one of the
# waiters gets to use it.  There is an allocation failure emulation
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
--- test.orig/arch/um/drivers/ubd_kern.c	2005-09-17 17:40:08.000000000 -0400
+++ test/arch/um/drivers/ubd_kern.c	2005-09-17 17:40:34.000000000 -0400
@@ -511,6 +511,67 @@
         void *bitmap_buf;
 };
 
+static int allocations;
+static int fail_start, fail_end;
+
+static struct bitmap_io emergency_bitmap_io;
+DECLARE_MUTEX(bitmap_io_sem);
+
+static struct bitmap_io *alloc_bitmap_io(void)
+{
+	struct bitmap_io *ret;
+
+	allocations++;
+	ret = kmalloc(sizeof(*ret), GFP_KERNEL | GFP_ATOMIC);
+
+	if((allocations >= fail_start) && (allocations < fail_end)){
+		kfree(ret);
+		ret = NULL;
+	}
+
+	if(ret != NULL)
+		return ret;
+
+	down(&bitmap_io_sem);
+	return(&emergency_bitmap_io);
+}
+
+static void free_bitmap_io(struct bitmap_io *io)
+{
+	if(io == &emergency_bitmap_io)
+		up(&bitmap_io_sem);
+	else kfree(io);
+}
+
+static struct ubd_aio emergency_aio;
+DECLARE_MUTEX(aio_sem);
+
+static struct ubd_aio *alloc_ubd_aio(void)
+{
+	struct ubd_aio *ret;
+
+	allocations++;
+	ret = kmalloc(sizeof(*ret), GFP_KERNEL | GFP_ATOMIC);
+
+	if((allocations >= fail_start) && (allocations < fail_end)){
+		kfree(ret);
+		ret = NULL;
+	}
+
+	if(ret != NULL)
+		return ret;
+
+	down(&aio_sem);
+	return(&emergency_aio);
+}
+
+static void free_ubd_aio(struct ubd_aio *aio)
+{
+	if(aio == &emergency_aio)
+		up(&aio_sem);
+	else kfree(aio);
+}
+
 static int ubd_reply_fd = -1;
 
 static irqreturn_t ubd_intr(int irq, void *dev, struct pt_regs *unused)
@@ -541,7 +602,7 @@
 			   (atomic_dec_and_test(&aio->bitmap->count))){
                                 aio->aio = aio->bitmap->aio;
                                 aio->len = 0;
-                                kfree(aio->bitmap);
+				free_bitmap_io(aio->bitmap);
                                 aio->bitmap = NULL;
                                 submit_aio(&aio->aio);
 			}
@@ -554,16 +615,16 @@
 
                                 if(aio->bitmap_buf != NULL)
                                         kfree(aio->bitmap_buf);
-				kfree(aio);
+				free_ubd_aio(aio);
 			}
 		}
                 else if(n < 0){
                         ubd_finish(aio->req, n);
                         if(aio->bitmap != NULL)
-                                kfree(aio->bitmap);
+                                free_bitmap_io(aio->bitmap);
                         if(aio->bitmap_buf != NULL)
                                 kfree(aio->bitmap_buf);
-                        kfree(aio);
+                        free_ubd_aio(aio);
                 }
 	}
 	reactivate_fd(fd, UBD_IRQ);
@@ -1247,6 +1308,8 @@
         __u64 off;
 
         if(req->bitmap_start != -1){
+		bitmap_io = alloc_bitmap_io();
+
                 /* Round up to the nearest word */
                 int round = sizeof(unsigned long);
                 len = (req->bitmap_end - req->bitmap_start +
@@ -1256,18 +1319,11 @@
                 off = req->bitmap_start / (8 * round);
                 off *= round;
 
-                bitmap_io = kmalloc(sizeof(*bitmap_io), GFP_KERNEL);
-                if(bitmap_io == NULL){
-                        printk("Failed to kmalloc bitmap IO\n");
-                        req->error = 1;
-                        return;
-                }
-
                 bitmap_buf = kmalloc(len, GFP_KERNEL);
                 if(bitmap_buf == NULL){
                         printk("do_io : kmalloc of bitmap chunk "
                                "failed\n");
-                        kfree(bitmap_io);
+                        free_bitmap_io(bitmap_io);
                         req->error = 1;
                         return;
                 }
@@ -1300,12 +1356,7 @@
                 len = (end - start) * req->sectorsize;
                 buf = &req->buffer[start * req->sectorsize];
 
-                aio = kmalloc(sizeof(*aio), GFP_KERNEL);
-                if(aio == NULL){
-                        req->error = 1;
-                        return;
-                }
-
+		aio = alloc_ubd_aio();
                 *aio = ((struct ubd_aio)
                         { .aio		= INIT_AIO(req->op, req->fds[bit], buf,
                                                    len, off, ubd_reply_fd),

--==_Exmh_1126996877_57630--



-------------------------------------------------------
SF.Net email is sponsored by:
Tame your development challenges with Apache's Geronimo App Server. Download
it for free - -and be entered to win a 42" plasma tv or your very own
Sony(tm)PSP.  Click here to play: http://sourceforge.net/geronimo.php
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
