Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 12/15] ps3vram: use bvec_virt
Date: Wed,  4 Aug 2021 11:56:31 +0200
Message-Id: <20210804095634.460779-13-hch@lst.de>
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
 drivers/block/ps3vram.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/ps3vram.c b/drivers/block/ps3vram.c
index 7fbf469651c4..c7b19e128b03 100644
--- a/drivers/block/ps3vram.c
+++ b/drivers/block/ps3vram.c
@@ -541,7 +541,7 @@ static struct bio *ps3vram_do_bio(struct ps3_system_bus_device *dev,
 
 	bio_for_each_segment(bvec, bio, iter) {
 		/* PS3 is ppc64, so we don't handle highmem */
-		char *ptr = page_address(bvec.bv_page) + bvec.bv_offset;
+		char *ptr = bvec_virt(&bvec);
 		size_t len = bvec.bv_len, retlen;
 
 		dev_dbg(&dev->core, "    %s %zu bytes at offset %llu\n", op,
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

