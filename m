Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58626C27C6E
	for <linux-um@archiver.kernel.org>; Mon, 17 Jun 2024 06:05:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w5I58mRKj5AU6Yqi3NMuzFTOUn3zWDih3UgJBo1+OXs=; b=eWY6hvbdf13RyQn1441xsxqDWe
	scBgh6eLqwHPQAeJ8SENANR7n5+hxGrSNrhhDWxrIvGrxnwn9b6W3AW5hn6LEp9VxdrXUNjBFRJi4
	j6TctThsFWH2Ouwcmtdu0lRVGD+UW1Ic+D5NOhIfF0tU7U9uAqffDmZw+nRPiIqgGF0/SgkqvF6ly
	m2LRVWBWRr13bQIn5YLYB4tzs0z72pzPTGazEEau8HHi9/1b3IOUNDJyK/yCq/P79acMi4UngnpJq
	d7v3Jc1Whglswfi1++vVyOkW7qiKL/obkolEGR4mV2TN05BEYVjmxl9h335nQlbt7/V6yZ6sxLAcT
	xKFW8IqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5Up-00000009ICG-03ME;
	Mon, 17 Jun 2024 06:05:39 +0000
Received: from [91.187.204.140] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sJ5Uk-00000009IBH-3zsu;
	Mon, 17 Jun 2024 06:05:35 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>,
	Richard Weinberger <richard@nod.at>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Ming Lei <ming.lei@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Alasdair Kergon <agk@redhat.com>,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	Song Liu <song@kernel.org>,
	Yu Kuai <yukuai3@huawei.com>,
	Vineeth Vijayan <vneethv@linux.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-m68k@lists.linux-m68k.org,
	linux-um@lists.infradead.org,
	drbd-dev@lists.linbit.com,
	nbd@other.debian.org,
	linuxppc-dev@lists.ozlabs.org,
	ceph-devel@vger.kernel.org,
	virtualization@lists.linux.dev,
	xen-devel@lists.xenproject.org,
	linux-bcache@vger.kernel.org,
	dm-devel@lists.linux.dev,
	linux-raid@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	nvdimm@lists.linux.dev,
	linux-nvme@lists.infradead.org,
	linux-s390@vger.kernel.org,
	linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: move features flags into queue_limits v2
Date: Mon, 17 Jun 2024 08:04:27 +0200
Message-ID: <20240617060532.127975-1-hch@lst.de>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi all,

this is the third and last major series to convert settings to
queue_limits for this merge window.  After a bunch of prep patches to
get various drivers in shape, it moves all the queue_flags that specify
driver controlled features into the queue limits so that they can be
set atomically and are separated from the blk-mq internal flags.

Note that I've only Cc'ed the maintainers for drivers with non-mechanical
changes as the Cc list is already huge.

This series sits on top of the for-6.11/block-limits branch.

A git tree is available here:

    git://git.infradead.org/users/hch/block.git block-limit-flags

Gitweb:

    http://git.infradead.org/?p=users/hch/block.git;a=shortlog;h=refs/heads/block-limit-flags


Changes since v1:
 - fix an inverted condition
 - fix the runtime flush disable in xen-blkfront
 - remove sd_is_zoned entirely
 - use SECTOR_SIZE in a few more places
 - fix REQ_NOWAIT disabling for dm targets that don't support it
 - fix typos
 - reword various commit logs

Diffstat:
 Documentation/block/writeback_cache_control.rst |   67 ++++----
 arch/m68k/emu/nfblock.c                         |    1 
 arch/um/drivers/ubd_kern.c                      |    3 
 arch/xtensa/platforms/iss/simdisk.c             |    5 
 block/blk-core.c                                |    7 
 block/blk-flush.c                               |   36 ++--
 block/blk-mq-debugfs.c                          |   13 -
 block/blk-mq.c                                  |   42 +++--
 block/blk-settings.c                            |   46 ++----
 block/blk-sysfs.c                               |  118 ++++++++-------
 block/blk-wbt.c                                 |    4 
 block/blk.h                                     |    2 
 drivers/block/amiflop.c                         |    5 
 drivers/block/aoe/aoeblk.c                      |    1 
 drivers/block/ataflop.c                         |    5 
 drivers/block/brd.c                             |    6 
 drivers/block/drbd/drbd_main.c                  |    6 
 drivers/block/floppy.c                          |    3 
 drivers/block/loop.c                            |   79 ++++------
 drivers/block/mtip32xx/mtip32xx.c               |    2 
 drivers/block/n64cart.c                         |    2 
 drivers/block/nbd.c                             |   24 +--
 drivers/block/null_blk/main.c                   |   13 -
 drivers/block/null_blk/zoned.c                  |    3 
 drivers/block/pktcdvd.c                         |    1 
 drivers/block/ps3disk.c                         |    8 -
 drivers/block/rbd.c                             |   12 -
 drivers/block/rnbd/rnbd-clt.c                   |   14 -
 drivers/block/sunvdc.c                          |    1 
 drivers/block/swim.c                            |    5 
 drivers/block/swim3.c                           |    5 
 drivers/block/ublk_drv.c                        |   21 +-
 drivers/block/virtio_blk.c                      |   37 ++--
 drivers/block/xen-blkfront.c                    |   53 +++---
 drivers/block/zram/zram_drv.c                   |    6 
 drivers/cdrom/gdrom.c                           |    1 
 drivers/md/bcache/super.c                       |    9 -
 drivers/md/dm-table.c                           |  183 +++++-------------------
 drivers/md/dm-zone.c                            |    2 
 drivers/md/dm-zoned-target.c                    |    2 
 drivers/md/dm.c                                 |   13 -
 drivers/md/md.c                                 |   40 -----
 drivers/md/raid5.c                              |    6 
 drivers/mmc/core/block.c                        |   42 ++---
 drivers/mmc/core/queue.c                        |   20 +-
 drivers/mmc/core/queue.h                        |    3 
 drivers/mtd/mtd_blkdevs.c                       |    9 -
 drivers/nvdimm/btt.c                            |    4 
 drivers/nvdimm/pmem.c                           |   14 -
 drivers/nvme/host/core.c                        |   33 ++--
 drivers/nvme/host/multipath.c                   |   24 ---
 drivers/nvme/host/zns.c                         |    3 
 drivers/s390/block/dasd_genhd.c                 |    1 
 drivers/s390/block/dcssblk.c                    |    2 
 drivers/s390/block/scm_blk.c                    |    5 
 drivers/scsi/iscsi_tcp.c                        |    8 -
 drivers/scsi/scsi_lib.c                         |    5 
 drivers/scsi/sd.c                               |   66 +++-----
 drivers/scsi/sd.h                               |    5 
 drivers/scsi/sd_zbc.c                           |   25 +--
 include/linux/blkdev.h                          |  119 ++++++++++-----
 61 files changed, 572 insertions(+), 728 deletions(-)

