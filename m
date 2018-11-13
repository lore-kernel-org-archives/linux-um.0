Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMXMQ-0001oY-R5
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 12:00:04 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 3/4] um: Remove unsafe printks from the io thread
Date: Tue, 13 Nov 2018 11:59:46 +0000
Message-Id: <20181113115947.19290-4-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
References: <20181113115947.19290-1-anton.ivanov@cambridgegreys.com>
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

Printk out of the io thread has been proven to be unsafe. It is
safer to pass the error to the block IO layer nad let it print
it if need be.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c | 28 +++-------------------------
 1 file changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0f02373ef632..e78f27f5ce88 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1447,11 +1447,8 @@ static int update_bitmap(struct io_thread_req *req)
 
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
@@ -1465,12 +1462,7 @@ static void do_io(struct io_thread_req *req)
 
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
 
@@ -1495,9 +1487,7 @@ static void do_io(struct io_thread_req *req)
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
@@ -1506,8 +1496,6 @@ static void do_io(struct io_thread_req *req)
 		} else {
 			n = os_pwrite_file(req->fds[bit], buf, len, off);
 			if(n != len){
-				printk("do_io - write failed err = %d "
-				       "fd = %d\n", -n, req->fds[bit]);
 				req->error = map_error(-n);
 				return;
 			}
@@ -1545,11 +1533,6 @@ int io_thread(void *arg)
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
 
@@ -1564,11 +1547,6 @@ int io_thread(void *arg)
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

