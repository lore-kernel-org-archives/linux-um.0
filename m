Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gL2xP-0002DD-5d
 for linux-um@lists.infradead.org; Fri, 09 Nov 2018 09:20:04 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH] Add DISCARD support to UML udb driver
Date: Fri,  9 Nov 2018 09:19:37 +0000
Message-Id: <20181109091937.25470-1-anton.ivanov@cambridgegreys.com>
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

1. Remove UBD specific opcode definitions and reuse the block-mq
ones
2. Add DISCARD and ZERO fill support (tested with ext4).
3. Further cleanup on the request forming, request checking and
handling of unexpected command codes.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c  | 69 ++++++++++++++++++++++++++++++---------------
 arch/um/include/shared/os.h |  1 +
 arch/um/os-Linux/file.c     | 12 +++++++-
 3 files changed, 58 insertions(+), 24 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 28c40624bcb6..503c1520ed8f 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -43,11 +43,9 @@
 #include <os.h>
 #include "cow.h"
 
-enum ubd_req { UBD_READ, UBD_WRITE, UBD_FLUSH };
-
 struct io_thread_req {
 	struct request *req;
-	enum ubd_req op;
+	int op;
 	int fds[2];
 	unsigned long offsets[2];
 	unsigned long long offset;
@@ -830,6 +828,10 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
+	ubd_dev->queue->limits.discard_granularity = 1 << 9;
+	ubd_dev->queue->limits.discard_alignment = 1 << 9;
+	blk_queue_max_discard_sectors(ubd_dev->queue, 8 * sizeof(long));
+	blk_queue_flag_set(QUEUE_FLAG_DISCARD|QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
  error:
 	os_close_file(ubd_dev->fd);
@@ -1277,7 +1279,7 @@ static void cowify_req(struct io_thread_req *req, unsigned long *bitmap,
 	if(req->length > (sizeof(req->sector_mask) * 8) << 9)
 		panic("Operation too long");
 
-	if(req->op == UBD_READ) {
+	if (req->op == REQ_OP_READ) {
 		for(i = 0; i < req->length >> 9; i++){
 			if(ubd_test_bit(sector + i, (unsigned char *) bitmap))
 				ubd_set_bit(i, (unsigned char *)
@@ -1307,20 +1309,21 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
 		io_req->fds[0] = dev->fd;
 	io_req->error = 0;
 
-	if (req_op(req) == REQ_OP_FLUSH) {
-		io_req->op = UBD_FLUSH;
-	} else {
+	io_req->op = req_op(req);
+
+	if (io_req->op != REQ_OP_FLUSH) {
 		io_req->fds[1] = dev->fd;
 		io_req->cow_offset = -1;
 		io_req->offset = off;
-		io_req->length = bvec->bv_len;
+		if ((io_req->op == REQ_OP_READ) || (io_req->op == REQ_OP_WRITE)) {
+			io_req->length = bvec->bv_len;
+			io_req->buffer = page_address(bvec->bv_page) + bvec->bv_offset;
+		} else
+			io_req->length = blk_rq_bytes(req);
 		io_req->sector_mask = 0;
-		io_req->op = rq_data_dir(req) == READ ? UBD_READ : UBD_WRITE;
 		io_req->offsets[0] = 0;
 		io_req->offsets[1] = dev->cow.data_offset;
-		io_req->buffer = page_address(bvec->bv_page) + bvec->bv_offset;
 		io_req->sectorsize = 1 << 9;
-
 		if (dev->cow.file) {
 			cowify_req(io_req, dev->cow.bitmap,
 				   dev->cow.bitmap_offset, dev->cow.bitmap_len);
@@ -1351,15 +1354,19 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (req_op(req) == REQ_OP_FLUSH) {
 		ret = ubd_queue_one_vec(hctx, req, 0, NULL);
 	} else {
-		struct req_iterator iter;
-		struct bio_vec bvec;
 		u64 off = (u64)blk_rq_pos(req) << 9;
 
-		rq_for_each_segment(bvec, req, iter) {
-			ret = ubd_queue_one_vec(hctx, req, off, &bvec);
-			if (ret < 0)
-				goto out;
-			off += bvec.bv_len;
+		if ((req_op(req) == REQ_OP_READ) || (req_op(req) == REQ_OP_WRITE)) {
+			struct req_iterator iter;
+			struct bio_vec bvec;
+			rq_for_each_segment(bvec, req, iter) {
+				ret = ubd_queue_one_vec(hctx, req, off, &bvec);
+				if (ret < 0)
+					goto out;
+				off += bvec.bv_len;
+			}
+		} else {
+			ret = ubd_queue_one_vec(hctx, req, off, NULL);
 		}
 	}
 out:
@@ -1438,7 +1445,7 @@ static void do_io(struct io_thread_req *req)
 	int n, nsectors, start, end, bit;
 	__u64 off;
 
-	if (req->op == UBD_FLUSH) {
+	if (req->op == REQ_OP_FLUSH) {
 		/* fds[0] is always either the rw image or our cow file */
 		n = os_sync_file(req->fds[0]);
 		if (n != 0) {
@@ -1462,9 +1469,9 @@ static void do_io(struct io_thread_req *req)
 		off = req->offset + req->offsets[bit] +
 			start * req->sectorsize;
 		len = (end - start) * req->sectorsize;
-		buf = &req->buffer[start * req->sectorsize];
-
-		if(req->op == UBD_READ){
+		switch (req->op) {
+		case REQ_OP_READ:
+			buf = &req->buffer[start * req->sectorsize];
 			n = 0;
 			do {
 				buf = &buf[n];
@@ -1478,7 +1485,9 @@ static void do_io(struct io_thread_req *req)
 				}
 			} while((n < len) && (n != 0));
 			if (n < len) memset(&buf[n], 0, len - n);
-		} else {
+			break;
+		case REQ_OP_WRITE:
+			buf = &req->buffer[start * req->sectorsize];
 			n = os_pwrite_file(req->fds[bit], buf, len, off);
 			if(n != len){
 				printk("do_io - write failed err = %d "
@@ -1486,6 +1495,20 @@ static void do_io(struct io_thread_req *req)
 				req->error = 1;
 				return;
 			}
+			break;
+		case REQ_OP_DISCARD:
+		case REQ_OP_WRITE_ZEROES:
+			n = os_falloc_punch(req->fds[bit], off, len);
+			if (n) {
+				printk("do_io - discard failed err = %d "
+				       "fd = %d\n", -n, req->fds[bit]);
+				req->error = 1;
+				return;
+			}
+			break;
+		default:
+			req->error = 1;
+			return;
 		}
 
 		start = end;
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 048ae37eb5aa..ebf23012a59b 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -175,6 +175,7 @@ extern int os_fchange_dir(int fd);
 extern unsigned os_major(unsigned long long dev);
 extern unsigned os_minor(unsigned long long dev);
 extern unsigned long long os_makedev(unsigned major, unsigned minor);
+extern int os_falloc_punch(int fd, unsigned long long offset, int count);
 
 /* start_up.c */
 extern void os_early_checks(void);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index c0197097c86e..d110cd7adca7 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -2,7 +2,9 @@
  * Copyright (C) 2002 - 2007 Jeff Dike (jdike@{addtoit,linux.intel}.com)
  * Licensed under the GPL
  */
-
+#ifndef _GNU_SOURCE
+#define _GNU_SOURCE
+#endif
 #include <stdio.h>
 #include <unistd.h>
 #include <errno.h>
@@ -301,6 +303,14 @@ int os_pwrite_file(int fd, const void *buf, int len, unsigned long long offset)
 	return n;
 }
 
+int os_falloc_punch(int fd, unsigned long long offset, int len)
+{
+	int n = fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset, len);
+
+	if (n < 0)
+		return -errno;
+	return n;
+}
 
 int os_file_size(const char *file, unsigned long long *size_out)
 {
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

