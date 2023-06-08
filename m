Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1296DC7EE29
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 11:03:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=qgZoc21m64Wv5fGWP0nJ32ic6h59Q5DEJuIfmX3CTmg=; b=RPvtDA8Rm+hqhi
	ogUo4bqim86rFx9sdjywk1gzahKg+3+OjOP2uAV7t+Wh19FRvn3g9KMReMJ5MSXn1nA1JA5d+YpxV
	A4vgyQE5HAuoY5Yh21bCM5kX2ZJR37uUZD1318vU5OezR2na5fL01RRlLg+97Y/raPE3PKQnqW9hp
	r+olcSp5SmjYS6Yl4aIwsQ5FT2FGBMJLkwsQo7ZaPdVrOm/Tk3agRUC0ogxHODzJVufGTDKeRQIAy
	P4JhjfFkauI2Vfp4uRiFyUVoBYBySU3/MXlU5WUMFG7xM4zkmpP64I6ssz/EVDMp8Vn2g9yeq5hUR
	Le4r6rqagWVMzxNplp0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQL-0091uU-0C;
	Thu, 08 Jun 2023 11:03:25 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQD-0091lb-2y;
	Thu, 08 Jun 2023 11:03:18 +0000
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
Subject: [PATCH 06/30] cdrom: remove the unused mode argument to cdrom_release
Date: Thu,  8 Jun 2023 13:02:34 +0200
Message-Id: <20230608110258.189493-7-hch@lst.de>
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

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Phillip Potter <phil@philpotter.co.uk>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 drivers/cdrom/cdrom.c | 2 +-
 drivers/cdrom/gdrom.c | 2 +-
 drivers/scsi/sr.c     | 2 +-
 include/linux/cdrom.h | 2 +-
 4 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/cdrom/cdrom.c b/drivers/cdrom/cdrom.c
index adebac1bd210d9..998b03fe976e22 100644
--- a/drivers/cdrom/cdrom.c
+++ b/drivers/cdrom/cdrom.c
@@ -1250,7 +1250,7 @@ static int check_for_audio_disc(struct cdrom_device_info *cdi,
 	return 0;
 }
 
-void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode)
+void cdrom_release(struct cdrom_device_info *cdi)
 {
 	const struct cdrom_device_ops *cdo = cdi->ops;
 
diff --git a/drivers/cdrom/gdrom.c b/drivers/cdrom/gdrom.c
index 14922403983e9e..a401dc4218a998 100644
--- a/drivers/cdrom/gdrom.c
+++ b/drivers/cdrom/gdrom.c
@@ -481,7 +481,7 @@ static int gdrom_bdops_open(struct block_device *bdev, fmode_t mode)
 	bdev_check_media_change(bdev);
 
 	mutex_lock(&gdrom_mutex);
-	ret = cdrom_open(gd.cd_info, mode);
+	ret = cdrom_open(gd.cd_info);
 	mutex_unlock(&gdrom_mutex);
 	return ret;
 }
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 444c7efc14cba7..6d33120ee5ba85 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -512,7 +512,7 @@ static void sr_block_release(struct gendisk *disk, fmode_t mode)
 	struct scsi_cd *cd = scsi_cd(disk);
 
 	mutex_lock(&cd->lock);
-	cdrom_release(&cd->cdi, mode);
+	cdrom_release(&cd->cdi);
 	mutex_unlock(&cd->lock);
 
 	scsi_device_put(cd->device);
diff --git a/include/linux/cdrom.h b/include/linux/cdrom.h
index adcc9f2beb2653..3c253b29f4aafc 100644
--- a/include/linux/cdrom.h
+++ b/include/linux/cdrom.h
@@ -102,7 +102,7 @@ int cdrom_read_tocentry(struct cdrom_device_info *cdi,
 
 /* the general block_device operations structure: */
 int cdrom_open(struct cdrom_device_info *cdi, fmode_t mode);
-extern void cdrom_release(struct cdrom_device_info *cdi, fmode_t mode);
+void cdrom_release(struct cdrom_device_info *cdi);
 int cdrom_ioctl(struct cdrom_device_info *cdi, struct block_device *bdev,
 		unsigned int cmd, unsigned long arg);
 extern unsigned int cdrom_check_events(struct cdrom_device_info *cdi,
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
