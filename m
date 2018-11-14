Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMqG5-0003EA-6w
 for linux-um@lists.infradead.org; Wed, 14 Nov 2018 08:10:46 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 4/4] um: Add support for DISCARD in the UBD Driver
Date: Wed, 14 Nov 2018 08:10:17 +0000
Message-Id: <20181114081017.10508-4-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181114081017.10508-1-anton.ivanov@cambridgegreys.com>
References: <20181114081017.10508-1-anton.ivanov@cambridgegreys.com>
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

Support for DISCARD and WRITE_ZEROES in the ubd driver using
fallocate.

DISCARD is enabled by default and can be disabled using a new
UBD command line flag.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c  | 59 ++++++++++++++++++++++++++++++++++++---------
 arch/um/include/shared/os.h |  1 +
 arch/um/os-Linux/file.c     | 10 ++++++++
 3 files changed, 59 insertions(+), 11 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index c08d162f5dc9..8e1179143df6 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -155,6 +155,7 @@ struct ubd {
 	struct openflags openflags;
 	unsigned shared:1;
 	unsigned no_cow:1;
+	unsigned no_trim:1;
 	struct cow cow;
 	struct platform_device pdev;
 	struct request_queue *queue;
@@ -178,6 +179,7 @@ struct ubd {
 	.boot_openflags =	OPEN_FLAGS, \
 	.openflags =		OPEN_FLAGS, \
 	.no_cow =               0, \
+	.no_trim =		0, \
 	.shared =		0, \
 	.cow =			DEFAULT_COW, \
 	.lock =			__SPIN_LOCK_UNLOCKED(ubd_devs.lock), \
@@ -324,7 +326,7 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 		*index_out = n;
 
 	err = -EINVAL;
-	for (i = 0; i < sizeof("rscd="); i++) {
+	for (i = 0; i < sizeof("rscdt="); i++) {
 		switch (*str) {
 		case 'r':
 			flags.w = 0;
@@ -338,12 +340,15 @@ static int ubd_setup_common(char *str, int *index_out, char **error_out)
 		case 'c':
 			ubd_dev->shared = 1;
 			break;
+		case 't':
+			ubd_dev->no_trim = 1;
+			break;
 		case '=':
 			str++;
 			goto break_loop;
 		default:
 			*error_out = "Expected '=' or flag letter "
-				"(r, s, c, or d)";
+				"(r, s, c, t or d)";
 			goto out;
 		}
 		str++;
@@ -416,6 +421,7 @@ __uml_help(ubd_setup,
 "    'c' will cause the device to be treated as being shared between multiple\n"
 "    UMLs and file locking will be turned off - this is appropriate for a\n"
 "    cluster filesystem and inappropriate at almost all other times.\n\n"
+"    't' will disable trim/discard support on the device (enabled by default).\n\n"
 );
 
 static int udb_setup(char *str)
@@ -514,9 +520,12 @@ static void ubd_handler(void)
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
 			struct io_thread_req *io_req = (*irq_req_buffer)[count];
 
-			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
-				__blk_mq_end_request(io_req->req, io_req->error);
-
+			if ((io_req->error) || (io_req->buffer == NULL))
+				blk_mq_end_request(io_req->req, io_req->error);
+			else {
+				if (!blk_update_request(io_req->req, io_req->error, io_req->length))
+					__blk_mq_end_request(io_req->req, io_req->error);
+			}
 			kfree(io_req);
 		}
 	}
@@ -830,6 +839,12 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
+	if (ubd_dev->no_trim == 0) {
+		ubd_dev->queue->limits.discard_granularity = UBD_SECTOR_SIZE;
+		ubd_dev->queue->limits.discard_alignment = UBD_SECTOR_SIZE;
+		blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
+		blk_queue_flag_set(QUEUE_FLAG_DISCARD, ubd_dev->queue);
+	}
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
  error:
@@ -1369,6 +1384,10 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 			}
 		}
 		break;
+	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
+		ret = ubd_queue_one_vec(hctx, req, (u64)blk_rq_pos(req) << 9, NULL);
+		break;
 	default:
 		WARN_ON_ONCE(1);
 		spin_unlock_irq(&ubd_dev->lock);
@@ -1461,7 +1480,7 @@ static int update_bitmap(struct io_thread_req *req)
 
 	n = os_pwrite_file(req->fds[1], &req->bitmap_words,
 			  sizeof(req->bitmap_words), req->cow_offset);
-	if(n != sizeof(req->bitmap_words))
+	if (n != sizeof(req->bitmap_words))
 		return map_error(-n);
 
 	return map_error(0);
@@ -1469,11 +1488,13 @@ static int update_bitmap(struct io_thread_req *req)
 
 static void do_io(struct io_thread_req *req)
 {
-	char *buf;
+	char *buf = NULL;
 	unsigned long len;
 	int n, nsectors, start, end, bit;
 	__u64 off;
 
+	/* FLUSH is really a special case, we cannot "case" it with others */
+
 	if (req_op(req->req) == REQ_OP_FLUSH) {
 		/* fds[0] is always either the rw image or our cow file */
 		req->error = map_error(-os_sync_file(req->fds[0]));
@@ -1493,26 +1514,42 @@ static void do_io(struct io_thread_req *req)
 		off = req->offset + req->offsets[bit] +
 			start * req->sectorsize;
 		len = (end - start) * req->sectorsize;
-		buf = &req->buffer[start * req->sectorsize];
+		if (req->buffer != NULL)
+			buf = &req->buffer[start * req->sectorsize];
 
-		if (req_op(req->req) == REQ_OP_READ) {
+		switch (req_op(req->req)) {
+		case REQ_OP_READ:
 			n = 0;
 			do {
 				buf = &buf[n];
 				len -= n;
 				n = os_pread_file(req->fds[bit], buf, len, off);
-				if(n < 0){
+				if (n < 0) {
 					req->error = map_error(-n);
 					return;
 				}
 			} while((n < len) && (n != 0));
 			if (n < len) memset(&buf[n], 0, len - n);
-		} else {
+			break;
+		case REQ_OP_WRITE:
 			n = os_pwrite_file(req->fds[bit], buf, len, off);
 			if(n != len){
 				req->error = map_error(-n);
 				return;
 			}
+			break;
+		case REQ_OP_DISCARD:
+		case REQ_OP_WRITE_ZEROES:
+			n = os_falloc_punch(req->fds[bit], off, len);
+			if (n) {
+				req->error = map_error(-n);
+				return;
+			}
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			req->error = BLK_STS_NOTSUPP;
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
index c0197097c86e..f25b110d4e70 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -610,3 +610,13 @@ unsigned long long os_makedev(unsigned major, unsigned minor)
 {
 	return makedev(major, minor);
 }
+
+int os_falloc_punch(int fd, unsigned long long offset, int len)
+{
+	int n = fallocate(fd, FALLOC_FL_PUNCH_HOLE|FALLOC_FL_KEEP_SIZE, offset, len);
+
+	if (n < 0)
+		return -errno;
+	return n;
+}
+
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

