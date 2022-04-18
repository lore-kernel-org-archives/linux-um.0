Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
Subject: fix and cleanup discard_alignment handling
Date: Mon, 18 Apr 2022 06:53:03 +0200
Message-Id: <20220418045314.360785-1-hch@lst.de>
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

Hi all,

the somewhat confusing name of the discard_alignment queue limit, that
really is an offset for the discard granularity mislead a lot of driver
authors to set it to an incorrect value.  This series tries to fix up
all these cases.

Diffstat:
 arch/um/drivers/ubd_kern.c         |    1 -
 drivers/block/loop.c               |    1 -
 drivers/block/nbd.c                |    3 ---
 drivers/block/null_blk/main.c      |    1 -
 drivers/block/rnbd/rnbd-srv-dev.h  |    2 +-
 drivers/block/virtio_blk.c         |    7 ++++---
 drivers/block/xen-blkback/xenbus.c |    4 ++--
 drivers/md/dm-zoned-target.c       |    2 +-
 drivers/md/raid5.c                 |    1 -
 drivers/nvme/host/core.c           |    1 -
 drivers/s390/block/dasd_fba.c      |    1 -
 11 files changed, 8 insertions(+), 16 deletions(-)

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

