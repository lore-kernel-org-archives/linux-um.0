Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 02/15] block: use bvec_virt in bio_integrity_{process,free}
Date: Wed,  4 Aug 2021 11:56:21 +0200
Message-Id: <20210804095634.460779-3-hch@lst.de>
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

Use the bvec_virt helper to clean up the bio integrity processing a
little bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/bio-integrity.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/block/bio-integrity.c b/block/bio-integrity.c
index 8f54d49dc500..6b47cddbbca1 100644
--- a/block/bio-integrity.c
+++ b/block/bio-integrity.c
@@ -104,8 +104,7 @@ void bio_integrity_free(struct bio *bio)
 	struct bio_set *bs = bio->bi_pool;
 
 	if (bip->bip_flags & BIP_BLOCK_INTEGRITY)
-		kfree(page_address(bip->bip_vec->bv_page) +
-		      bip->bip_vec->bv_offset);
+		kfree(bvec_virt(bip->bip_vec));
 
 	__bio_integrity_free(bs, bip);
 	bio->bi_integrity = NULL;
@@ -163,13 +162,11 @@ static blk_status_t bio_integrity_process(struct bio *bio,
 	struct bio_vec bv;
 	struct bio_integrity_payload *bip = bio_integrity(bio);
 	blk_status_t ret = BLK_STS_OK;
-	void *prot_buf = page_address(bip->bip_vec->bv_page) +
-		bip->bip_vec->bv_offset;
 
 	iter.disk_name = bio->bi_bdev->bd_disk->disk_name;
 	iter.interval = 1 << bi->interval_exp;
 	iter.seed = proc_iter->bi_sector;
-	iter.prot_buf = prot_buf;
+	iter.prot_buf = bvec_virt(bip->bip_vec);
 
 	__bio_for_each_segment(bv, bio, bviter, *proc_iter) {
 		void *kaddr = bvec_kmap_local(&bv);
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

