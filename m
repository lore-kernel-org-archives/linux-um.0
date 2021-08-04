Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 13/15] dasd: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:32 +0200
Message-Id: <20210804095634.460779-14-hch@lst.de>
In-Reply-To: <20210804095634.460779-1-hch@lst.de>
References: <20210804095634.460779-1-hch@lst.de>
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
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Geoff Levand <geoff@infradead.org>, Ilya Dryomov <idryomov@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, Song Liu <song@kernel.org>, Mike Snitzer <snitzer@redhat.com>, Coly Li <colyli@suse.de>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, Phillip Lougher <phillip@squashfs.org.uk>, linux-block@vger.kernel.org, dm-devel@redhat.com, linux-um@lists.infradead.org, ceph-devel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-raid@vger.kernel.org, linux-bcache@vger.kernel.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, linux-scsi@vger.kernel.org

Use bvec_virt instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd_diag.c |  2 +-
 drivers/s390/block/dasd_eckd.c | 14 +++++++-------
 drivers/s390/block/dasd_fba.c  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/s390/block/dasd_diag.c b/drivers/s390/block/dasd_diag.c
index 6bb775236c16..db5987281010 100644
--- a/drivers/s390/block/dasd_diag.c
+++ b/drivers/s390/block/dasd_diag.c
@@ -552,7 +552,7 @@ static struct dasd_ccw_req *dasd_diag_build_cp(struct dasd_device *memdev,
 	dbio = dreq->bio;
 	recid = first_rec;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		for (off = 0; off < bv.bv_len; off += blksize) {
 			memset(dbio, 0, sizeof (struct dasd_diag_bio));
 			dbio->type = rw_cmd;
diff --git a/drivers/s390/block/dasd_eckd.c b/drivers/s390/block/dasd_eckd.c
index 0de1a463c509..8610ea414322 100644
--- a/drivers/s390/block/dasd_eckd.c
+++ b/drivers/s390/block/dasd_eckd.c
@@ -3267,7 +3267,7 @@ static int dasd_eckd_ese_read(struct dasd_ccw_req *cqr, struct irb *irb)
 	end_blk = (curr_trk + 1) * recs_per_trk;
 
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		for (off = 0; off < bv.bv_len; off += blksize) {
 			if (first_blk + blk_count >= end_blk) {
 				cqr->proc_bytes = blk_count * blksize;
@@ -3999,7 +3999,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_single(
 			      last_rec - recid + 1, cmd, basedev, blksize);
 	}
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		if (dasd_page_cache) {
 			char *copy = kmem_cache_alloc(dasd_page_cache,
 						      GFP_DMA | __GFP_NOWARN);
@@ -4166,7 +4166,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_cmd_track(
 	idaw_dst = NULL;
 	idaw_len = 0;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		seg_len = bv.bv_len;
 		while (seg_len) {
 			if (new_track) {
@@ -4509,7 +4509,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 		new_track = 1;
 		recid = first_rec;
 		rq_for_each_segment(bv, req, iter) {
-			dst = page_address(bv.bv_page) + bv.bv_offset;
+			dst = bvec_virt(&bv);
 			seg_len = bv.bv_len;
 			while (seg_len) {
 				if (new_track) {
@@ -4542,7 +4542,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_tpm_track(
 		}
 	} else {
 		rq_for_each_segment(bv, req, iter) {
-			dst = page_address(bv.bv_page) + bv.bv_offset;
+			dst = bvec_virt(&bv);
 			last_tidaw = itcw_add_tidaw(itcw, 0x00,
 						    dst, bv.bv_len);
 			if (IS_ERR(last_tidaw)) {
@@ -4778,7 +4778,7 @@ static struct dasd_ccw_req *dasd_eckd_build_cp_raw(struct dasd_device *startdev,
 			idaws = idal_create_words(idaws, rawpadpage, PAGE_SIZE);
 	}
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		seg_len = bv.bv_len;
 		if (cmd == DASD_ECKD_CCW_READ_TRACK)
 			memset(dst, 0, seg_len);
@@ -4839,7 +4839,7 @@ dasd_eckd_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 	if (private->uses_cdl == 0 || recid > 2*blk_per_trk)
 		ccw++;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		for (off = 0; off < bv.bv_len; off += blksize) {
 			/* Skip locate record. */
 			if (private->uses_cdl && recid <= 2*blk_per_trk)
diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 3ad319aee51e..e084f4dedddd 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -501,7 +501,7 @@ static struct dasd_ccw_req *dasd_fba_build_cp_regular(
 	}
 	recid = first_rec;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		if (dasd_page_cache) {
 			char *copy = kmem_cache_alloc(dasd_page_cache,
 						      GFP_DMA | __GFP_NOWARN);
@@ -583,7 +583,7 @@ dasd_fba_free_cp(struct dasd_ccw_req *cqr, struct request *req)
 	if (private->rdc_data.mode.bits.data_chain != 0)
 		ccw++;
 	rq_for_each_segment(bv, req, iter) {
-		dst = page_address(bv.bv_page) + bv.bv_offset;
+		dst = bvec_virt(&bv);
 		for (off = 0; off < bv.bv_len; off += blksize) {
 			/* Skip locate record. */
 			if (private->rdc_data.mode.bits.data_chain == 0)
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

