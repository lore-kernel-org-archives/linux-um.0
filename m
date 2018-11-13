Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMXMY-0004A1-DX
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 12:00:16 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 1/4] um: Switch to block-mq constants in the UML UBD driver
Date: Tue, 13 Nov 2018 11:59:44 +0000
Message-Id: <20181113115947.19290-2-anton.ivanov@cambridgegreys.com>
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

Switch to block mq-constants for both commands and error codes.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c | 51 ++++++++++++++++++++++++++++------------------
 1 file changed, 31 insertions(+), 20 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 28c40624bcb6..331837f1f632 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -43,11 +43,12 @@
 #include <os.h>
 #include "cow.h"
 
-enum ubd_req { UBD_READ, UBD_WRITE, UBD_FLUSH };
+#define UBD_SECTOR_SIZE (1 << 9)
+/* Max request size is determined by sector mask - 32K */
+#define UBD_MAX_REQUEST (8 * sizeof(long))
 
 struct io_thread_req {
 	struct request *req;
-	enum ubd_req op;
 	int fds[2];
 	unsigned long offsets[2];
 	unsigned long long offset;
@@ -511,15 +512,13 @@ static void ubd_handler(void)
 		}
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
 			struct io_thread_req *io_req = (*irq_req_buffer)[count];
-			int err = io_req->error ? BLK_STS_IOERR : BLK_STS_OK;
 
-			if (!blk_update_request(io_req->req, err, io_req->length))
-				__blk_mq_end_request(io_req->req, err);
+			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
+				__blk_mq_end_request(io_req->req, io_req->error);
 
 			kfree(io_req);
 		}
 	}
-
 	reactivate_fd(thread_fd, UBD_IRQ);
 }
 
@@ -830,6 +829,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
  error:
 	os_close_file(ubd_dev->fd);
@@ -882,7 +882,7 @@ static int ubd_disk_register(int major, u64 size, int unit,
 	return 0;
 }
 
-#define ROUND_BLOCK(n) ((n + ((1 << 9) - 1)) & (-1 << 9))
+#define ROUND_BLOCK(n) ((n + (UBD_SECTOR_SIZE - 1)) & (-UBD_SECTOR_SIZE))
 
 static const struct blk_mq_ops ubd_mq_ops = {
 	.queue_rq = ubd_queue_rq,
@@ -1277,7 +1277,7 @@ static void cowify_req(struct io_thread_req *req, unsigned long *bitmap,
 	if(req->length > (sizeof(req->sector_mask) * 8) << 9)
 		panic("Operation too long");
 
-	if(req->op == UBD_READ) {
+	if (req_op(req->req) == REQ_OP_READ) {
 		for(i = 0; i < req->length >> 9; i++){
 			if(ubd_test_bit(sector + i, (unsigned char *) bitmap))
 				ubd_set_bit(i, (unsigned char *)
@@ -1307,15 +1307,12 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
 		io_req->fds[0] = dev->fd;
 	io_req->error = 0;
 
-	if (req_op(req) == REQ_OP_FLUSH) {
-		io_req->op = UBD_FLUSH;
-	} else {
+	if (req_op(req) != REQ_OP_FLUSH) {
 		io_req->fds[1] = dev->fd;
 		io_req->cow_offset = -1;
 		io_req->offset = off;
 		io_req->length = bvec->bv_len;
 		io_req->sector_mask = 0;
-		io_req->op = rq_data_dir(req) == READ ? UBD_READ : UBD_WRITE;
 		io_req->offsets[0] = 0;
 		io_req->offsets[1] = dev->cow.data_offset;
 		io_req->buffer = page_address(bvec->bv_page) + bvec->bv_offset;
@@ -1413,22 +1410,36 @@ static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
 	return -EINVAL;
 }
 
+static int map_error(int error_code)
+{
+	switch (error_code) {
+	case 0:
+		return BLK_STS_OK;
+	case ENOSYS:
+	case EOPNOTSUPP:
+		return BLK_STS_NOTSUPP;
+	case ENOSPC:
+		return BLK_STS_NOSPC;
+	}
+	return BLK_STS_IOERR;
+}
+
 static int update_bitmap(struct io_thread_req *req)
 {
 	int n;
 
 	if(req->cow_offset == -1)
-		return 0;
+		return map_error(0);
 
 	n = os_pwrite_file(req->fds[1], &req->bitmap_words,
 			  sizeof(req->bitmap_words), req->cow_offset);
 	if(n != sizeof(req->bitmap_words)){
 		printk("do_io - bitmap update failed, err = %d fd = %d\n", -n,
 		       req->fds[1]);
-		return 1;
+		return map_error(-n);
 	}
 
-	return 0;
+	return map_error(0);
 }
 
 static void do_io(struct io_thread_req *req)
@@ -1438,13 +1449,13 @@ static void do_io(struct io_thread_req *req)
 	int n, nsectors, start, end, bit;
 	__u64 off;
 
-	if (req->op == UBD_FLUSH) {
+	if (req_op(req->req) == REQ_OP_FLUSH) {
 		/* fds[0] is always either the rw image or our cow file */
 		n = os_sync_file(req->fds[0]);
 		if (n != 0) {
 			printk("do_io - sync failed err = %d "
 			       "fd = %d\n", -n, req->fds[0]);
-			req->error = 1;
+			req->error = map_error(-n);
 		}
 		return;
 	}
@@ -1464,7 +1475,7 @@ static void do_io(struct io_thread_req *req)
 		len = (end - start) * req->sectorsize;
 		buf = &req->buffer[start * req->sectorsize];
 
-		if(req->op == UBD_READ){
+		if (req_op(req->req) == REQ_OP_READ) {
 			n = 0;
 			do {
 				buf = &buf[n];
@@ -1473,7 +1484,7 @@ static void do_io(struct io_thread_req *req)
 				if (n < 0) {
 					printk("do_io - read failed, err = %d "
 					       "fd = %d\n", -n, req->fds[bit]);
-					req->error = 1;
+					req->error = map_error(-n);
 					return;
 				}
 			} while((n < len) && (n != 0));
@@ -1483,7 +1494,7 @@ static void do_io(struct io_thread_req *req)
 			if(n != len){
 				printk("do_io - write failed err = %d "
 				       "fd = %d\n", -n, req->fds[bit]);
-				req->error = 1;
+				req->error = map_error(-n);
 				return;
 			}
 		}
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

