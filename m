Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMzs7-0000zY-1A
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 18:26:40 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 3/4] um: Remove unsafe printks from the io thread
Date: Wed, 14 Nov 2018 17:09:42 +0000
Message-Id: <20181114170943.12065-3-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181114170943.12065-1-anton.ivanov@cambridgegreys.com>
References: <20181114170943.12065-1-anton.ivanov@cambridgegreys.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: axboe@kernel.dk, richard@nod.at, hch@lst.de, Anton Ivanov <anton.ivanov@cambridgegreys.com>

From: Anton Ivanov <anton.ivanov@cambridgegreys.com>

Printk out of the io thread has been proven to be unsafe. This
is not surprising as the thread is part of the UML hypervisor
code. It is not supposed to invoke any kernel code/resources.

It is necesssary to pass the error to the block IO layer and let it

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c | 42 +++++++++++++++++-------------------------
 1 file changed, 17 insertions(+), 25 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 58860ef6931a..1672e3c49bfb 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1,4 +1,5 @@
 /*
+ * Copyright (C) 2018 Cambridge Greys Ltd
  * Copyright (C) 2015-2016 Anton Ivanov (aivanov@brocade.com)
  * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
@@ -1440,6 +1441,19 @@ static int map_error(int error_code)
 	return BLK_STS_IOERR;
 }
 
+/*
+ * Everything from here onwards *IS NOT PART OF THE KERNEL*
+ *
+ * The following functions are part of UML hypervisor code.
+ * All functions from here onwards are executed as a helper
+ * thread and are not allowed to execute any kernel functions.
+ *
+ * Any communication must occur strictly via shared memory and IPC.
+ *
+ * Do not add printks, locks, kernel memory operations, etc - it
+ * will result in unpredictable behaviour and/or crashes.
+ */
+
 static int update_bitmap(struct io_thread_req *req)
 {
 	int n;
@@ -1449,11 +1463,8 @@ static int update_bitmap(struct io_thread_req *req)
 
 	n = os_pwrite_file(req->fds[1], &req->bitmap_words,
 			  sizeof(req->bitmap_words), req->cow_offset);
-	if(n != sizeof(req->bitmap_words)){
-		printk("do_io - bitmap update failed, err = %d fd = %d\n", -n,
-		       req->fds[1]);
+	if(n != sizeof(req->bitmap_words))
 		return map_error(-n);
-	}
 
 	return map_error(0);
 }
@@ -1467,12 +1478,7 @@ static void do_io(struct io_thread_req *req)
 
 	if (req_op(req->req) == REQ_OP_FLUSH) {
 		/* fds[0] is always either the rw image or our cow file */
-		n = os_sync_file(req->fds[0]);
-		if (n != 0) {
-			printk("do_io - sync failed err = %d "
-			       "fd = %d\n", -n, req->fds[0]);
-			req->error = map_error(-n);
-		}
+		req->error = map_error(-os_sync_file(req->fds[0]));
 		return;
 	}
 
@@ -1497,9 +1503,7 @@ static void do_io(struct io_thread_req *req)
 				buf = &buf[n];
 				len -= n;
 				n = os_pread_file(req->fds[bit], buf, len, off);
-				if (n < 0) {
-					printk("do_io - read failed, err = %d "
-					       "fd = %d\n", -n, req->fds[bit]);
+				if(n < 0){
 					req->error = map_error(-n);
 					return;
 				}
@@ -1508,8 +1512,6 @@ static void do_io(struct io_thread_req *req)
 		} else {
 			n = os_pwrite_file(req->fds[bit], buf, len, off);
 			if(n != len){
-				printk("do_io - write failed err = %d "
-				       "fd = %d\n", -n, req->fds[bit]);
 				req->error = map_error(-n);
 				return;
 			}
@@ -1547,11 +1549,6 @@ int io_thread(void *arg)
 			if (n == -EAGAIN) {
 				ubd_read_poll(-1);
 				continue;
-			} else {
-				printk("io_thread - read failed, fd = %d, "
-				       "err = %d,"
-				       "reminder = %d\n",
-				       kernel_fd, -n, io_remainder_size);
 			}
 		}
 
@@ -1566,11 +1563,6 @@ int io_thread(void *arg)
 			res = os_write_file(kernel_fd, ((char *) io_req_buffer) + written, n);
 			if (res >= 0) {
 				written += res;
-			} else {
-				if (res != -EAGAIN) {
-					printk("io_thread - write failed, fd = %d, "
-					       "err = %d\n", kernel_fd, -n);
-				}
 			}
 			if (written < n) {
 				ubd_write_poll(-1);
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

