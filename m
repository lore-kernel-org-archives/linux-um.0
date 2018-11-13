Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMXMb-0001p1-R2
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 12:00:20 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 4/4] um: Add support for DISCARD in the UBD Driver
Date: Tue, 13 Nov 2018 11:59:47 +0000
Message-Id: <20181113115947.19290-5-anton.ivanov@cambridgegreys.com>
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

Support for DISCARD and WRITE_ZEROES in the ubd driver using
fallocate. DISCARD capable devices are autodetected at open
time.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/Kconfig     | 21 +++++++++++++++
 arch/um/drivers/ubd_kern.c  | 66 ++++++++++++++++++++++++++++++++++++++-------
 arch/um/include/shared/os.h |  1 +
 arch/um/os-Linux/file.c     | 10 +++++++
 4 files changed, 89 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 2b1aaf7755aa..e817fd4a4c30 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -1,4 +1,25 @@
 # SPDX-License-Identifier: GPL-2.0
+menu "UML Block Devices"
+
+config BLK_DEV_UBD
+	bool "UBD Block Device"
+	default y
+	help
+          User Mode Linux virtual block device driver
+
+config BLK_DEV_UBD_SYNC
+	bool "Use Synchronous mode for UBD"
+	default n
+	help
+          Perform all disk operations synchronously (extremely slow).
+
+config BLK_DEV_UBD_DISCARD
+	bool "Enable DISCARD/TRIM support in UBD"
+	default y
+	help
+          Enable discard/trim support. Requires host kernel 3.x or above and
+	  may not be supported on all host filesystems.
+endmenu
 
 menu "UML Character Devices"
 
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index e78f27f5ce88..4fd4cb68f033 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -513,9 +513,13 @@ static void ubd_handler(void)
 		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
 			struct io_thread_req *io_req = (*irq_req_buffer)[count];
 
-			if (!blk_update_request(io_req->req, io_req->error, io_req->length))
-				__blk_mq_end_request(io_req->req, io_req->error);
-
+			if ((io_req->error) || (io_req->buffer == NULL)) {
+				blk_mq_end_request(io_req->req, io_req->error);
+			} else {
+				if (!blk_update_request(io_req->req, io_req->error, io_req->length)) {
+					__blk_mq_end_request(io_req->req, io_req->error);
+				}
+			}
 			kfree(io_req);
 		}
 	}
@@ -775,6 +779,7 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 	char **back_ptr;
 	int err, create_cow, *create_ptr;
 	int fd;
+	int data;
 
 	ubd_dev->openflags = ubd_dev->boot_openflags;
 	create_cow = 0;
@@ -829,6 +834,23 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
+#ifdef CONFIG_BLK_DEV_UBD_DISCARD
+	if (ubd_dev->cow.file != NULL)
+		fd = ubd_dev->cow.fd;
+	else
+		fd = ubd_dev->fd;
+	err = os_pread_file(fd, &data, sizeof(int), 0);
+	if (err == sizeof(int)) {
+		err = os_falloc_punch(fd, 0, sizeof(int));
+		if (err == 0) {
+			ubd_dev->queue->limits.discard_granularity = UBD_SECTOR_SIZE;
+			ubd_dev->queue->limits.discard_alignment = UBD_SECTOR_SIZE;
+			blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
+			blk_queue_flag_set(QUEUE_FLAG_DISCARD, ubd_dev->queue);
+			os_pwrite_file(fd, &data, sizeof(int), 0);
+		}
+	}
+#endif
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
  error:
@@ -1368,6 +1390,12 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 			}
 		}
 		break;
+#ifdef CONFIG_BLK_DEV_UBD_DISCARD
+	case REQ_OP_DISCARD:
+	case REQ_OP_WRITE_ZEROES:
+		ret = ubd_queue_one_vec(hctx, req, (u64)blk_rq_pos(req) << 9, NULL);
+		break;
+#endif
 	default:
 		WARN_ON_ONCE(1);
 		spin_unlock_irq(&ubd_dev->lock);
@@ -1447,7 +1475,7 @@ static int update_bitmap(struct io_thread_req *req)
 
 	n = os_pwrite_file(req->fds[1], &req->bitmap_words,
 			  sizeof(req->bitmap_words), req->cow_offset);
-	if(n != sizeof(req->bitmap_words))
+	if (n != sizeof(req->bitmap_words))
 		return map_error(-n);
 
 	return map_error(0);
@@ -1455,11 +1483,13 @@ static int update_bitmap(struct io_thread_req *req)
 
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
@@ -1479,26 +1509,44 @@ static void do_io(struct io_thread_req *req)
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
+#ifdef CONFIG_BLK_DEV_UBD_DISCARD
+		case REQ_OP_DISCARD:
+		case REQ_OP_WRITE_ZEROES:
+			n = os_falloc_punch(req->fds[bit], off, len);
+			if (n) {
+				req->error = map_error(-n);
+				return;
+			}
+			break;
+#endif
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

