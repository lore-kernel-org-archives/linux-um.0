Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gN06T-00018E-AA
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 18:41:31 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH v2 1/4] um: Switch to block-mq constants in the UML UBD driver
Date: Wed, 14 Nov 2018 18:41:06 +0000
Message-Id: <20181114184109.19600-1-anton.ivanov@cambridgegreys.com>
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

Switch to block mq-constants for both commands, error codes and
various computations.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c | 66 ++++++++++++++++++++++++++--------------------
 1 file changed, 38 insertions(+), 28 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 28c40624bcb6..3a8a3d403ef8 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -43,11 +43,11 @@
 #include <os.h>
 #include "cow.h"
 
-enum ubd_req { UBD_READ, UBD_WRITE, UBD_FLUSH };
+/* Max request size is determined by sector mask - 32K */
+#define UBD_MAX_REQUEST (8 * sizeof(long))
 
 struct io_thread_req {
 	struct request *req;
-	enum ubd_req op;
 	int fds[2];
 	unsigned long offsets[2];
 	unsigned long long offset;
@@ -511,15 +511,13 @@ static void ubd_handler(void)
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
 
@@ -789,7 +787,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 
 	if((fd == -ENOENT) && create_cow){
 		fd = create_cow_file(ubd_dev->file, ubd_dev->cow.file,
-					  ubd_dev->openflags, 1 << 9, PAGE_SIZE,
+					  ubd_dev->openflags, SECTOR_SIZE, PAGE_SIZE,
 					  &ubd_dev->cow.bitmap_offset,
 					  &ubd_dev->cow.bitmap_len,
 					  &ubd_dev->cow.data_offset);
@@ -830,6 +828,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
  error:
 	os_close_file(ubd_dev->fd);
@@ -882,7 +881,7 @@ static int ubd_disk_register(int major, u64 size, int unit,
 	return 0;
 }
 
-#define ROUND_BLOCK(n) ((n + ((1 << 9) - 1)) & (-1 << 9))
+#define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
 
 static const struct blk_mq_ops ubd_mq_ops = {
 	.queue_rq = ubd_queue_rq,
@@ -1234,10 +1233,10 @@ static void cowify_bitmap(__u64 io_offset, int length, unsigned long *cow_mask,
 			  __u64 bitmap_offset, unsigned long *bitmap_words,
 			  __u64 bitmap_len)
 {
-	__u64 sector = io_offset >> 9;
+	__u64 sector = io_offset >> SECTOR_SHIFT;
 	int i, update_bitmap = 0;
 
-	for(i = 0; i < length >> 9; i++){
+	for (i = 0; i < length >> SECTOR_SHIFT; i++) {
 		if(cow_mask != NULL)
 			ubd_set_bit(i, (unsigned char *) cow_mask);
 		if(ubd_test_bit(sector + i, (unsigned char *) bitmap))
@@ -1271,14 +1270,14 @@ static void cowify_bitmap(__u64 io_offset, int length, unsigned long *cow_mask,
 static void cowify_req(struct io_thread_req *req, unsigned long *bitmap,
 		       __u64 bitmap_offset, __u64 bitmap_len)
 {
-	__u64 sector = req->offset >> 9;
+	__u64 sector = req->offset >> SECTOR_SHIFT;
 	int i;
 
-	if(req->length > (sizeof(req->sector_mask) * 8) << 9)
+	if (req->length > (sizeof(req->sector_mask) * 8) << SECTOR_SHIFT)
 		panic("Operation too long");
 
-	if(req->op == UBD_READ) {
-		for(i = 0; i < req->length >> 9; i++){
+	if (req_op(req->req) == REQ_OP_READ) {
+		for (i = 0; i < req->length >> SECTOR_SHIFT; i++) {
 			if(ubd_test_bit(sector + i, (unsigned char *) bitmap))
 				ubd_set_bit(i, (unsigned char *)
 					    &req->sector_mask);
@@ -1307,19 +1306,16 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
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
-		io_req->sectorsize = 1 << 9;
+		io_req->sectorsize = SECTOR_SIZE;
 
 		if (dev->cow.file) {
 			cowify_req(io_req, dev->cow.bitmap,
@@ -1353,7 +1349,7 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	} else {
 		struct req_iterator iter;
 		struct bio_vec bvec;
-		u64 off = (u64)blk_rq_pos(req) << 9;
+		u64 off = (u64)blk_rq_pos(req) << SECTOR_SHIFT;
 
 		rq_for_each_segment(bvec, req, iter) {
 			ret = ubd_queue_one_vec(hctx, req, off, &bvec);
@@ -1413,22 +1409,36 @@ static int ubd_ioctl(struct block_device *bdev, fmode_t mode,
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
@@ -1438,13 +1448,13 @@ static void do_io(struct io_thread_req *req)
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
@@ -1464,7 +1474,7 @@ static void do_io(struct io_thread_req *req)
 		len = (end - start) * req->sectorsize;
 		buf = &req->buffer[start * req->sectorsize];
 
-		if(req->op == UBD_READ){
+		if (req_op(req->req) == REQ_OP_READ) {
 			n = 0;
 			do {
 				buf = &buf[n];
@@ -1473,7 +1483,7 @@ static void do_io(struct io_thread_req *req)
 				if (n < 0) {
 					printk("do_io - read failed, err = %d "
 					       "fd = %d\n", -n, req->fds[bit]);
-					req->error = 1;
+					req->error = map_error(-n);
 					return;
 				}
 			} while((n < len) && (n != 0));
@@ -1483,7 +1493,7 @@ static void do_io(struct io_thread_req *req)
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

