Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab6.miniserver.com ([5.153.251.140]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gMXMY-0004A2-DZ
 for linux-um@lists.infradead.org; Tue, 13 Nov 2018 12:00:11 +0000
From: anton.ivanov@cambridgegreys.com
Subject: [PATCH 2/4] um: Clean-up command processing in UML UBD driver
Date: Tue, 13 Nov 2018 11:59:45 +0000
Message-Id: <20181113115947.19290-3-anton.ivanov@cambridgegreys.com>
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

Clean-up command processing and return BLK_STS_NOTSUP for
uknown commands.

Signed-off-by: Anton Ivanov <anton.ivanov@cambridgegreys.com>
---
 arch/um/drivers/ubd_kern.c | 64 ++++++++++++++++++++++++++++------------------
 1 file changed, 39 insertions(+), 25 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 331837f1f632..0f02373ef632 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -1307,21 +1307,25 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
 		io_req->fds[0] = dev->fd;
 	io_req->error = 0;
 
-	if (req_op(req) != REQ_OP_FLUSH) {
-		io_req->fds[1] = dev->fd;
-		io_req->cow_offset = -1;
-		io_req->offset = off;
+	if (bvec != NULL) {
 		io_req->length = bvec->bv_len;
-		io_req->sector_mask = 0;
-		io_req->offsets[0] = 0;
-		io_req->offsets[1] = dev->cow.data_offset;
 		io_req->buffer = page_address(bvec->bv_page) + bvec->bv_offset;
-		io_req->sectorsize = 1 << 9;
+	} else {
+		io_req->buffer = NULL;
+		io_req->length = blk_rq_bytes(req);
+	}
 
-		if (dev->cow.file) {
-			cowify_req(io_req, dev->cow.bitmap,
-				   dev->cow.bitmap_offset, dev->cow.bitmap_len);
-		}
+	io_req->sectorsize = UBD_SECTOR_SIZE;
+	io_req->fds[1] = dev->fd;
+	io_req->cow_offset = -1;
+	io_req->offset = off;
+	io_req->sector_mask = 0;
+	io_req->offsets[0] = 0;
+	io_req->offsets[1] = dev->cow.data_offset;
+
+	if (dev->cow.file) {
+		cowify_req(io_req, dev->cow.bitmap,
+			   dev->cow.bitmap_offset, dev->cow.bitmap_len);
 	}
 
 	ret = os_write_file(thread_fd, &io_req, sizeof(io_req));
@@ -1330,7 +1334,6 @@ static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
 			pr_err("write to io thread failed: %d\n", -ret);
 		kfree(io_req);
 	}
-
 	return ret;
 }
 
@@ -1344,20 +1347,31 @@ static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 	blk_mq_start_request(req);
 
 	spin_lock_irq(&ubd_dev->lock);
-
-	if (req_op(req) == REQ_OP_FLUSH) {
+	switch (req_op(req)) {
+	/* operations with no lentgth/offset arguments */
+	case REQ_OP_FLUSH:
 		ret = ubd_queue_one_vec(hctx, req, 0, NULL);
-	} else {
-		struct req_iterator iter;
-		struct bio_vec bvec;
-		u64 off = (u64)blk_rq_pos(req) << 9;
-
-		rq_for_each_segment(bvec, req, iter) {
-			ret = ubd_queue_one_vec(hctx, req, off, &bvec);
-			if (ret < 0)
-				goto out;
-			off += bvec.bv_len;
+		break;
+	/* operations with bio_vec arguments */
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+		{
+			struct req_iterator iter;
+			struct bio_vec bvec;
+			u64 off = (u64)blk_rq_pos(req) << 9;
+
+			rq_for_each_segment(bvec, req, iter) {
+				ret = ubd_queue_one_vec(hctx, req, off, &bvec);
+				if (ret < 0)
+					goto out;
+				off += bvec.bv_len;
+			}
 		}
+		break;
+	default:
+		WARN_ON_ONCE(1);
+		spin_unlock_irq(&ubd_dev->lock);
+		return BLK_STS_NOTSUPP;
 	}
 out:
 	spin_unlock_irq(&ubd_dev->lock);
-- 
2.11.0


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

