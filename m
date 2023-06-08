Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92290C7EE23
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 11:05:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=vRUadvYCMTtoe5qc/k9NbdT6mk5O7gaVzjXlgdBca1Y=; b=MOL4g1R/P3ZAgl
	SEA0g8evdactyYWWu52ARFTwWrqBORlMGT04uptlbC4a25MC3LnwWo0DiJ1JuGYkenBfQQcgX0BsI
	DddsQTmPm8pB4umj1R8SlLjNq9WKYu2Ann6mge0Z/M8vLztL83o+hW+RL7oJQgbxnab2ufbGqs/Yh
	sw3kf0zVCSskj63mOdEiW6eeXwRjrCw+nmj5XwliPnH4juNLxJzSboAiUa0NuqW6JxDzT8IvC7z8d
	RGBoDXJpeiDT2HWakm2cRJjoZHOL7WgPHUwBNSvbhW14HHWupnzWguxSFPFCukyjnFArvvJqc4lx3
	wGxzqRhCigDF0a6DAB3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DSY-0094Ji-0U;
	Thu, 08 Jun 2023 11:05:42 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DR0-0092dV-19;
	Thu, 08 Jun 2023 11:04:06 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 22/30] mtd: block: use a simple bool to track open for write
Date: Thu,  8 Jun 2023 13:02:50 +0200
Message-Id: <20230608110258.189493-23-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Instead of propagating the fmode_t, just use a bool to track if a mtd
block device was opened for writing.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
Acked-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/mtd_blkdevs.c    | 2 +-
 drivers/mtd/mtdblock.c       | 2 +-
 include/linux/mtd/blktrans.h | 2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index f0bb09fde95e3a..bd0b7545364349 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -208,7 +208,7 @@ static int blktrans_open(struct gendisk *disk, fmode_t mode)
 	ret = __get_mtd_device(dev->mtd);
 	if (ret)
 		goto error_release;
-	dev->file_mode = mode;
+	dev->writable = mode & FMODE_WRITE;
 
 unlock:
 	dev->open++;
diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index a0a1194dc1d902..fa476fb4dffb6c 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -294,7 +294,7 @@ static void mtdblock_release(struct mtd_blktrans_dev *mbd)
 		 * It was the last usage. Free the cache, but only sync if
 		 * opened for writing.
 		 */
-		if (mbd->file_mode & FMODE_WRITE)
+		if (mbd->writable)
 			mtd_sync(mbd->mtd);
 		vfree(mtdblk->cache_data);
 	}
diff --git a/include/linux/mtd/blktrans.h b/include/linux/mtd/blktrans.h
index 15cc9b95e32b52..6e471436bba556 100644
--- a/include/linux/mtd/blktrans.h
+++ b/include/linux/mtd/blktrans.h
@@ -34,7 +34,7 @@ struct mtd_blktrans_dev {
 	struct blk_mq_tag_set *tag_set;
 	spinlock_t queue_lock;
 	void *priv;
-	fmode_t file_mode;
+	bool writable;
 };
 
 struct mtd_blktrans_ops {
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
