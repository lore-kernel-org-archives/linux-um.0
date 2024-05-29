Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA070C25B75
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 05:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FxMZ/TuFQWi8ppJCXfgMd7wJRUIIOyQbd6+WyEUQ+N4=; b=hdLrODRZnLVd+5dsHTi80/zZL3
	bYyrTJr9RoaXt1zA9dGOwGNlrYx27cJMg0M/LTfsgVIQE7unmW9n618FcHqxWNu8wAX16gr57yDC7
	djor21XAwx2IDGbecjLVnyYdHt6dUF1yX9wZZM7YhwxUorFjUUFTjJQLaNo2Jy5OzbCX1ewg9WyLR
	JdkUO+IB+mjdgqd8L2M1qr4OjOzHIXG1/UqcJ3hu3efWZ5cBXlo11foD07AH9ixWd/drkqGnDDA9V
	UcC1Pb5IEwB+2p2l6cqKMuMakm00lvkzgPGW1TpoXBG5KuSOVIxoM0RSfSoUach+1zu8taLaJaSti
	ysc/8yUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCBVG-00000002pec-2Bd5;
	Wed, 29 May 2024 05:05:34 +0000
Received: from 2a02-8389-2341-5b80-7775-b725-99f7-3344.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7775:b725:99f7:3344] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCBVE-00000002pch-0ecf;
	Wed, 29 May 2024 05:05:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	linux-um@lists.infradead.org,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	ceph-devel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 08/12] sd: cleanup zoned queue limits initialization
Date: Wed, 29 May 2024 07:04:10 +0200
Message-ID: <20240529050507.1392041-9-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240529050507.1392041-1-hch@lst.de>
References: <20240529050507.1392041-1-hch@lst.de>
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

Consolidate setting zone-related queue limits in sd_zbc_read_zones
instead of splitting them between sd_zbc_revalidate_zones and
sd_zbc_read_zones, and move the early_zone_information initialization
in sd_zbc_read_zones above setting up the queue limits.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd_zbc.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/scsi/sd_zbc.c b/drivers/scsi/sd_zbc.c
index 806036e48abeda..1c24c844e8d178 100644
--- a/drivers/scsi/sd_zbc.c
+++ b/drivers/scsi/sd_zbc.c
@@ -565,12 +565,6 @@ int sd_zbc_revalidate_zones(struct scsi_disk *sdkp)
 	sdkp->zone_info.zone_blocks = zone_blocks;
 	sdkp->zone_info.nr_zones = nr_zones;
 
-	blk_queue_chunk_sectors(q,
-			logical_to_sectors(sdkp->device, zone_blocks));
-
-	/* Enable block layer zone append emulation */
-	blk_queue_max_zone_append_sectors(q, 0);
-
 	flags = memalloc_noio_save();
 	ret = blk_revalidate_disk_zones(disk);
 	memalloc_noio_restore(flags);
@@ -625,6 +619,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 	if (ret != 0)
 		goto err;
 
+	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
+	sdkp->early_zone_info.nr_zones = nr_zones;
+	sdkp->early_zone_info.zone_blocks = zone_blocks;
+
 	/* The drive satisfies the kernel restrictions: set it up */
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 	if (sdkp->zones_max_open == U32_MAX)
@@ -632,10 +630,10 @@ int sd_zbc_read_zones(struct scsi_disk *sdkp, u8 buf[SD_BUF_SIZE])
 	else
 		disk_set_max_open_zones(disk, sdkp->zones_max_open);
 	disk_set_max_active_zones(disk, 0);
-	nr_zones = round_up(sdkp->capacity, zone_blocks) >> ilog2(zone_blocks);
-
-	sdkp->early_zone_info.nr_zones = nr_zones;
-	sdkp->early_zone_info.zone_blocks = zone_blocks;
+	blk_queue_chunk_sectors(q,
+			logical_to_sectors(sdkp->device, zone_blocks));
+	/* Enable block layer zone append emulation */
+	blk_queue_max_zone_append_sectors(q, 0);
 
 	return 0;
 
-- 
2.43.0


