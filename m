Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1HbfL5-000257-CC for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 09:06:31 -0700
Received: from [198.99.130.12] (helo=saraswathi.solana.com)
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1HbfL4-0001J2-Bf
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 11 Apr 2007 09:06:31 -0700
Date: Wed, 11 Apr 2007 12:01:26 -0400
From: Jeff Dike <jdike@addtoit.com>
Message-ID: <20070411160126.GA6324@c2.user-mode-linux.org>
Mime-Version: 1.0
Content-Disposition: inline
Subject: [uml-devel] [PATCH 2/4] UML - Send pointers instead of structures
	to I/O thread
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
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, uml-devel <user-mode-linux-devel@lists.sourceforge.net>

Instead of writing entire structures between UML and the I/O thread,
we send pointers.  This cuts down on the amount of data being copied
and possibly allows more requests to be pending between the two.

This requires that the requests be kmalloced and freed instead of
living on the stack.

Signed-off-by: Jeff Dike <jdike@linux.intel.com>
--
 arch/um/drivers/ubd_kern.c |   41 ++++++++++++++++++++++++++---------------
 1 file changed, 26 insertions(+), 15 deletions(-)

Index: linux-2.6.21-mm/arch/um/drivers/ubd_kern.c
===================================================================
--- linux-2.6.21-mm.orig/arch/um/drivers/ubd_kern.c	2007-04-10 10:59:03.000000000 -0400
+++ linux-2.6.21-mm/arch/um/drivers/ubd_kern.c	2007-04-10 10:59:17.000000000 -0400
@@ -503,7 +503,7 @@ static struct list_head restart = LIST_H
 /* Called without dev->lock held, and only in interrupt context. */
 static void ubd_handler(void)
 {
-	struct io_thread_req req;
+	struct io_thread_req *req;
 	struct request *rq;
 	struct ubd *ubd;
 	struct list_head *list, *next_ele;
@@ -511,7 +511,8 @@ static void ubd_handler(void)
 	int n;
 
 	while(1){
-		n = os_read_file_k(thread_fd, &req, sizeof(req));
+		n = os_read_file_k(thread_fd, &req,
+				   sizeof(struct io_thread_req *));
 		if(n != sizeof(req)){
 			if(n == -EAGAIN)
 				break;
@@ -520,10 +521,11 @@ static void ubd_handler(void)
 			return;
 		}
 
-		rq = req.req;
-		rq->nr_sectors -= req.length >> 9;
+		rq = req->req;
+		rq->nr_sectors -= req->length >> 9;
 		if(rq->nr_sectors == 0)
 			ubd_finish(rq, rq->hard_nr_sectors << 9);
+		kfree(req);
 	}
 	reactivate_fd(thread_fd, UBD_IRQ);
 
@@ -1078,7 +1080,7 @@ static void prepare_request(struct reque
 /* Called with dev->lock held */
 static void do_ubd_request(request_queue_t *q)
 {
-	struct io_thread_req io_req;
+	struct io_thread_req *io_req;
 	struct request *req;
 	int n;
 
@@ -1099,13 +1101,20 @@ static void do_ubd_request(request_queue
 		while(dev->start_sg < dev->end_sg){
 			struct scatterlist *sg = &dev->sg[dev->start_sg];
 
-			prepare_request(req, &io_req,
+			io_req = kmalloc(sizeof(struct io_thread_req),
+					 GFP_KERNEL | GFP_ATOMIC);
+			if(io_req == NULL){
+				if(list_empty(&dev->restart))
+					list_add(&dev->restart, &restart);
+				return;
+			}
+			prepare_request(req, io_req,
 					(unsigned long long) req->sector << 9,
 					sg->offset, sg->length, sg->page);
 
-			n = os_write_file_k(thread_fd, (char *) &io_req,
-					    sizeof(io_req));
-			if(n != sizeof(io_req)){
+			n = os_write_file_k(thread_fd, &io_req,
+					    sizeof(struct io_thread_req *));
+			if(n != sizeof(struct io_thread_req *)){
 				if(n != -EAGAIN)
 					printk("write to io thread failed, "
 					       "errno = %d\n", -n);
@@ -1437,13 +1446,14 @@ static int io_count = 0;
 
 int io_thread(void *arg)
 {
-	struct io_thread_req req;
+	struct io_thread_req *req;
 	int n;
 
 	ignore_sigwinch_sig();
 	while(1){
-		n = os_read_file_k(kernel_fd, &req, sizeof(req));
-		if(n != sizeof(req)){
+		n = os_read_file_k(kernel_fd, &req,
+				 sizeof(struct io_thread_req *));
+		if(n != sizeof(struct io_thread_req *)){
 			if(n < 0)
 				printk("io_thread - read failed, fd = %d, "
 				       "err = %d\n", kernel_fd, -n);
@@ -1454,9 +1464,10 @@ int io_thread(void *arg)
 			continue;
 		}
 		io_count++;
-		do_io(&req);
-		n = os_write_file_k(kernel_fd, &req, sizeof(req));
-		if(n != sizeof(req))
+		do_io(req);
+		n = os_write_file_k(kernel_fd, &req,
+				  sizeof(struct io_thread_req *));
+		if(n != sizeof(struct io_thread_req *))
 			printk("io_thread - write failed, fd = %d, err = %d\n",
 			       kernel_fd, -n);
 	}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys-and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
