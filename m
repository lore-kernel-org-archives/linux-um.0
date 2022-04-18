Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 04/11] virtio_blk: fix the discard_granularity and
 discard_alignment queue limits
Date: Mon, 18 Apr 2022 06:53:07 +0200
Message-Id: <20220418045314.360785-5-hch@lst.de>
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
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
Cc: Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>, Josef Bacik <josef@toxicpanda.com>, "Md. Haris Iqbal" <haris.iqbal@ionos.com>, Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>, Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>, Stefan Haberland <sth@linux.ibm.com>, Jan Hoeppner <hoeppner@linux.ibm.com>, "Martin K. Petersen" <martin.petersen@oracle.com>, linux-um@lists.infradead.org, linux-block@vger.kernel.org, nbd@other.debian.org, virtualization@lists.linux-foundation.org, xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org, dm-devel@redhat.com

The discard_alignment queue limit is named a bit misleading means the
offset into the block device at which the discard granularity starts.

On the other hand the discard_sector_alignment from the virtio 1.1 looks
similar to what Linux uses as discard granularity (even if not very well
described):

  "discard_sector_alignment can be used by OS when splitting a request
   based on alignment. "

And at least qemu does set it to the discard granularity.

So stop setting the discard_alignment and use the virtio
discard_sector_alignment to set the discard granularity.

Fixes: 1f23816b8eb8 ("virtio_blk: add discard and write zeroes support")
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6ccf15253dee1..d624cc8eddc3c 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -867,11 +867,12 @@ static int virtblk_probe(struct virtio_device *vdev)
 		blk_queue_io_opt(q, blk_size * opt_io_size);
 
 	if (virtio_has_feature(vdev, VIRTIO_BLK_F_DISCARD)) {
-		q->limits.discard_granularity = blk_size;
-
 		virtio_cread(vdev, struct virtio_blk_config,
 			     discard_sector_alignment, &v);
-		q->limits.discard_alignment = v ? v << SECTOR_SHIFT : 0;
+		if (v)
+			q->limits.discard_granularity = v << SECTOR_SHIFT;
+		else
+			q->limits.discard_granularity = blk_size;
 
 		virtio_cread(vdev, struct virtio_blk_config,
 			     max_discard_sectors, &v);
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

