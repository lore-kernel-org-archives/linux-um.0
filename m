Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by casper.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMGE6-0000Tp-Ui
 for linux-um@lists.infradead.org; Mon, 12 Nov 2018 17:42:20 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 3/3] um: Add support for DISCARD in the UBD Driver
Date: Mon, 12 Nov 2018 17:42:01 +0000
Message-Id: <20181112174201.12290-4-anton.ivanov@cambridgegreys.com>
In-Reply-To: <20181112174201.12290-1-anton.ivanov@cambridgegreys.com>
References: <20181112174201.12290-1-anton.ivanov@cambridgegreys.com>
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

Support DISCARD and WRITE_ZEROES in the ubd driver using
fallocate.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/Kconfig     | 22 ++++++++++++++
 arch/um/drivers/ubd_kern.c  | 71 +++++++++++++++++++++++++++++++++++++++------
 arch/um/include/shared/os.h |  2 ++
 arch/um/os-Linux/file.c     |  8 +++++
 4 files changed, 94 insertions(+), 9 deletions(-)

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 2b1aaf7755aa..a3407cca6bf9 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -1,5 +1,27 @@
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
+
 menu "UML Character Devices"
 
 config STDERR_CONSOLE
diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 08b5ba9a5340..791d637ad4ef 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -514,9 +514,13 @@ static void ubd_handler(void)
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
@@ -1429,6 +1457,7 @@ static int map_error(int error_code)
 	switch (error_code) {
 	case 0:
 		return BLK_STS_OK;
+	case ENOSYS:
 	case EOPNOTSUPP:
 		return BLK_STS_NOTSUPP;
 	case EPERM:
@@ -1459,11 +1488,13 @@ static int update_bitmap(struct io_thread_req *req)
 
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
 		n = os_sync_file(req->fds[0]);
@@ -1477,6 +1508,7 @@ static void do_io(struct io_thread_req *req)
 
 	nsectors = req->length / req->sectorsize;
 	start = 0;
+
 	do {
 		bit = ubd_test_bit(start, (unsigned char *) &req->sector_mask);
 		end = start;
@@ -1488,9 +1520,11 @@ static void do_io(struct io_thread_req *req)
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
@@ -1504,7 +1538,8 @@ static void do_io(struct io_thread_req *req)
 				}
 			} while((n < len) && (n != 0));
 			if (n < len) memset(&buf[n], 0, len - n);
-		} else {
+			break;
+		case REQ_OP_WRITE:
 			n = os_pwrite_file(req->fds[bit], buf, len, off);
 			if(n != len){
 				printk("do_io - write failed err = %d "
@@ -1512,12 +1547,30 @@ static void do_io(struct io_thread_req *req)
 				req->error = map_error(-n);
 				return;
 			}
+			break;
+#ifdef CONFIG_BLK_DEV_UBD_DISCARD
+		case REQ_OP_DISCARD:
+		case REQ_OP_WRITE_ZEROES:
+			n = os_falloc_punch(req->fds[bit], off, len);
+			if (n) {
+				printk("do_io - discard failed err = %d "
+				       "fd = %d\n", -n, req->fds[bit]);
+				if (n == -EOPNOTSUPP)
+					req->error = map_error(-n);
+				return;
+			}
+			break;
+#endif
+		default:
+			WARN_ON_ONCE(1);
+			req->error = BLK_STS_NOTSUPP;
+			return;
 		}
-
 		start = end;
 	} while(start < nsectors);
 
-	req->error = update_bitmap(req);
+	if (req_op(req->req) != REQ_OP_READ)
+		req->error = update_bitmap(req);
 }
 
 /* Changed in start_io_thread, which is serialized by being called only
diff --git a/arch/um/include/shared/os.h b/arch/um/include/shared/os.h
index 048ae37eb5aa..9aa4b150e0a9 100644
--- a/arch/um/include/shared/os.h
+++ b/arch/um/include/shared/os.h
@@ -175,6 +175,8 @@ extern int os_fchange_dir(int fd);
 extern unsigned os_major(unsigned long long dev);
 extern unsigned os_minor(unsigned long long dev);
 extern unsigned long long os_makedev(unsigned major, unsigned minor);
+extern int os_falloc_punch(int fd, unsigned long long offset, int count);
+
 
 /* start_up.c */
 extern void os_early_checks(void);
diff --git a/arch/um/os-Linux/file.c b/arch/um/os-Linux/file.c
index c0197097c86e..56e921ff3ff3 100644
--- a/arch/um/os-Linux/file.c
+++ b/arch/um/os-Linux/file.c
@@ -301,6 +301,14 @@ int os_pwrite_file(int fd, const void *buf, int len, unsigned long long offset)
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

