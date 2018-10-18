Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lilium.sigma-star.at ([109.75.188.150])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gDFKY-0008GE-Ox
 for linux-um@lists.infradead.org; Thu, 18 Oct 2018 20:55:45 +0000
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH v2] ubd: remove use of blk_rq_map_sg
Date: Thu, 18 Oct 2018 22:55:03 +0200
Message-Id: <20181018205503.6206-1-richard@nod.at>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: linux-um@lists.infradead.org
Cc: axboe@kernel.dk, bvanassche@acm.org, Richard Weinberger <richard@nod.at>, jdike@addtoit.com, linux-kernel@vger.kernel.org, hare@suse.de, anton.ivanov@cambridgegreys.com, Christoph Hellwig <hch@lst.de>, keescook@chromium.org

From: Christoph Hellwig <hch@lst.de>

There is no good reason to create a scatterlist in the ubd driver,
it can just iterate the request directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
[rw: Folded in improvements as discussed with hch and jens]
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 arch/um/drivers/ubd_kern.c | 158 +++++++++++++------------------------
 1 file changed, 54 insertions(+), 104 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 9cb0cabb4e02..74c002ddc0ce 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -160,12 +160,6 @@ struct ubd {
 	spinlock_t lock;
 };
 
-struct ubd_pdu {
-	struct scatterlist sg[MAX_SG];
-	int start_sg, end_sg;
-	sector_t rq_pos;
-};
-
 #define DEFAULT_COW { \
 	.file =			NULL, \
 	.fd =			-1,	\
@@ -197,9 +191,6 @@ static struct proc_dir_entry *proc_ide = NULL;
 
 static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 				 const struct blk_mq_queue_data *bd);
-static int ubd_init_request(struct blk_mq_tag_set *set,
-			    struct request *req, unsigned int hctx_idx,
-			    unsigned int numa_node);
 
 static void make_proc_ide(void)
 {
@@ -895,7 +886,6 @@ static int ubd_disk_register(int major, u64 size, int unit,
 
 static const struct blk_mq_ops ubd_mq_ops = {
 	.queue_rq = ubd_queue_rq,
-	.init_request = ubd_init_request,
 };
 
 static int ubd_add(int n, char **error_out)
@@ -918,7 +908,6 @@ static int ubd_add(int n, char **error_out)
 	ubd_dev->tag_set.queue_depth = 64;
 	ubd_dev->tag_set.numa_node = NUMA_NO_NODE;
 	ubd_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
-	ubd_dev->tag_set.cmd_size = sizeof(struct ubd_pdu);
 	ubd_dev->tag_set.driver_data = ubd_dev;
 	ubd_dev->tag_set.nr_hw_queues = 1;
 
@@ -1300,123 +1289,84 @@ static void cowify_req(struct io_thread_req *req, unsigned long *bitmap,
 			   req->bitmap_words, bitmap_len);
 }
 
-/* Called with dev->lock held */
-static void prepare_request(struct request *req, struct io_thread_req *io_req,
-			    unsigned long long offset, int page_offset,
-			    int len, struct page *page)
+static int ubd_queue_one_vec(struct blk_mq_hw_ctx *hctx, struct request *req,
+		u64 off, struct bio_vec *bvec)
 {
-	struct gendisk *disk = req->rq_disk;
-	struct ubd *ubd_dev = disk->private_data;
-
-	io_req->req = req;
-	io_req->fds[0] = (ubd_dev->cow.file != NULL) ? ubd_dev->cow.fd :
-		ubd_dev->fd;
-	io_req->fds[1] = ubd_dev->fd;
-	io_req->cow_offset = -1;
-	io_req->offset = offset;
-	io_req->length = len;
-	io_req->error = 0;
-	io_req->sector_mask = 0;
-
-	io_req->op = (rq_data_dir(req) == READ) ? UBD_READ : UBD_WRITE;
-	io_req->offsets[0] = 0;
-	io_req->offsets[1] = ubd_dev->cow.data_offset;
-	io_req->buffer = page_address(page) + page_offset;
-	io_req->sectorsize = 1 << 9;
-
-	if(ubd_dev->cow.file != NULL)
-		cowify_req(io_req, ubd_dev->cow.bitmap,
-			   ubd_dev->cow.bitmap_offset, ubd_dev->cow.bitmap_len);
-
-}
+	struct ubd *dev = hctx->queue->queuedata;
+	struct io_thread_req *io_req;
+	int ret;
 
-/* Called with dev->lock held */
-static void prepare_flush_request(struct request *req,
-				  struct io_thread_req *io_req)
-{
-	struct gendisk *disk = req->rq_disk;
-	struct ubd *ubd_dev = disk->private_data;
+	io_req = kmalloc(sizeof(struct io_thread_req), GFP_ATOMIC);
+	if (!io_req)
+		return -ENOMEM;
 
 	io_req->req = req;
-	io_req->fds[0] = (ubd_dev->cow.file != NULL) ? ubd_dev->cow.fd :
-		ubd_dev->fd;
-	io_req->op = UBD_FLUSH;
-}
-
-static void submit_request(struct io_thread_req *io_req, struct ubd *dev)
-{
-	int n = os_write_file(thread_fd, &io_req,
-			     sizeof(io_req));
+	if (dev->cow.file)
+		io_req->fds[0] = dev->cow.fd;
+	else
+		io_req->fds[0] = dev->fd;
 
-	if (n != sizeof(io_req)) {
-		if (n != -EAGAIN)
-			pr_err("write to io thread failed: %d\n", -n);
+	if (req_op(req) == REQ_OP_FLUSH) {
+		io_req->op = UBD_FLUSH;
+	} else {
+		io_req->fds[1] = dev->fd;
+		io_req->cow_offset = -1;
+		io_req->offset = off;
+		io_req->length = bvec->bv_len;
+		io_req->error = 0;
+		io_req->sector_mask = 0;
+
+		io_req->op = rq_data_dir(req) == READ ? UBD_READ : UBD_WRITE;
+		io_req->offsets[0] = 0;
+		io_req->offsets[1] = dev->cow.data_offset;
+		io_req->buffer = page_address(bvec->bv_page) + bvec->bv_offset;
+		io_req->sectorsize = 1 << 9;
+
+		if (dev->cow.file) {
+			cowify_req(io_req, dev->cow.bitmap,
+				   dev->cow.bitmap_offset, dev->cow.bitmap_len);
+		}
+	}
 
-		blk_mq_requeue_request(io_req->req, true);
+	ret = os_write_file(thread_fd, &io_req, sizeof(io_req));
+	if (ret != sizeof(io_req)) {
+		if (ret != -EAGAIN)
+			pr_err("write to io thread failed: %d\n", -ret);
 		kfree(io_req);
 	}
+
+	return ret;
 }
 
 static blk_status_t ubd_queue_rq(struct blk_mq_hw_ctx *hctx,
 				 const struct blk_mq_queue_data *bd)
 {
 	struct request *req = bd->rq;
-	struct ubd *dev = hctx->queue->queuedata;
-	struct ubd_pdu *pdu = blk_mq_rq_to_pdu(req);
-	struct io_thread_req *io_req;
+	int ret = 0;
 
 	blk_mq_start_request(req);
 
-	pdu->rq_pos = blk_rq_pos(req);
-	pdu->start_sg = 0;
-	pdu->end_sg = blk_rq_map_sg(req->q, req, pdu->sg);
-
 	if (req_op(req) == REQ_OP_FLUSH) {
-		io_req = kmalloc(sizeof(struct io_thread_req), GFP_ATOMIC);
-		if (io_req == NULL) {
-			blk_mq_requeue_request(req, true);
-			goto done;
+		ret = ubd_queue_one_vec(hctx, req, 0, NULL);
+	} else {
+		struct req_iterator iter;
+		struct bio_vec bvec;
+		u64 off = (u64)blk_rq_pos(req) << 9;
+
+		rq_for_each_segment(bvec, req, iter) {
+			ret = ubd_queue_one_vec(hctx, req, off, &bvec);
+			if (ret < 0)
+				goto out;
+			off += bvec.bv_len;
 		}
-		prepare_flush_request(req, io_req);
-		submit_request(io_req, dev);
-
-		goto done;
 	}
-
-	while (pdu->start_sg < pdu->end_sg) {
-		struct scatterlist *sg = &pdu->sg[pdu->start_sg];
-
-		io_req = kmalloc(sizeof(struct io_thread_req),
-				 GFP_ATOMIC);
-		if (io_req == NULL) {
-			blk_mq_requeue_request(req, true);
-			goto done;
-		}
-		prepare_request(req, io_req,
-				(unsigned long long)pdu->rq_pos << 9,
-				sg->offset, sg->length, sg_page(sg));
-
-		submit_request(io_req, dev);
-
-		pdu->rq_pos += sg->length >> 9;
-		pdu->start_sg++;
+out:
+	if (ret < 0) {
+		blk_mq_requeue_request(req, true);
 	}
-
-done:
 	return BLK_STS_OK;
 }
 
-static int ubd_init_request(struct blk_mq_tag_set *set,
-			    struct request *req, unsigned int hctx_idx,
-			    unsigned int numa_node)
-{
-	struct ubd_pdu *pdu = blk_mq_rq_to_pdu(req);
-
-	sg_init_table(pdu->sg, MAX_SG);
-
-	return 0;
-}
-
 static int ubd_getgeo(struct block_device *bdev, struct hd_geometry *geo)
 {
 	struct ubd *ubd_dev = bdev->bd_disk->private_data;
-- 
2.19.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

