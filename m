Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 01/11] ubd: don't set the discard_alignment queue limit
Date: Mon, 18 Apr 2022 06:53:04 +0200
Message-Id: <20220418045314.360785-2-hch@lst.de>
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
Setting it to the discard granularity as done by ubd is mostly harmless
but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 085ffdf98e57e..c4344b67628dd 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -799,7 +799,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 	}
 	if (ubd_dev->no_trim == 0) {
 		ubd_dev->queue->limits.discard_granularity = SECTOR_SIZE;
-		ubd_dev->queue->limits.discard_alignment = SECTOR_SIZE;
 		blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 		blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 	}
-- 
2.30.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

