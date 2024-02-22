Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5787C54791
	for <linux-um@archiver.kernel.org>; Thu, 22 Feb 2024 07:24:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cTy5ByRm6yl9copb54tFACKFS8S5cRwyQfPP7IgncdE=; b=RF+jr7qn2ojVk9dor1xu2S6gbP
	rGbs8u9dRqBHe8z4P65jKN/3EfSuDmPNZm3x9Da20UNnLGotZm0viYLSm/pLsuirYqRoioNPtkgbk
	ehWs+m8mfQIoK35MXhB5ndbX1VOv82ID5DPChlxEAc9N0qsmwhTfdIooGeT1cKWXm5/KBRjYKXp/S
	59mxuaz+dFHa2FLmg2yGAQJ+6AWwpBd715xKD79jhX0huupJjNnebVwHnvXQhYdEyvDwFnIcU3KqW
	4Dyw1NQSabCMmMXoTFbDPdb3X1N/J6kP/1swgvDiGkFk0GMiIqcxg0gOH1TR5wvts0sWAZ0S1A3GM
	J2uEwKWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RS-00000003ne8-1Ja3;
	Thu, 22 Feb 2024 07:24:26 +0000
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RQ-00000003nd1-0gxi;
	Thu, 22 Feb 2024 07:24:24 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 2/7] ubd: remove ubd_disk_register
Date: Thu, 22 Feb 2024 08:24:12 +0100
Message-Id: <20240222072417.3773131-3-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20240222072417.3773131-1-hch@lst.de>
References: <20240222072417.3773131-1-hch@lst.de>
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

Fold it into the only caller to remove lots of references to the
global ubd_devs array.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index b203ebb1785125..ef05157acd6b02 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -849,27 +849,6 @@ static const struct attribute_group *ubd_attr_groups[] = {
 	NULL,
 };
 
-static int ubd_disk_register(int major, u64 size, int unit,
-			     struct gendisk *disk)
-{
-	disk->major = major;
-	disk->first_minor = unit << UBD_SHIFT;
-	disk->minors = 1 << UBD_SHIFT;
-	disk->fops = &ubd_blops;
-	set_capacity(disk, size / 512);
-	sprintf(disk->disk_name, "ubd%c", 'a' + unit);
-
-	ubd_devs[unit].pdev.id   = unit;
-	ubd_devs[unit].pdev.name = DRIVER_NAME;
-	ubd_devs[unit].pdev.dev.release = ubd_device_release;
-	dev_set_drvdata(&ubd_devs[unit].pdev.dev, &ubd_devs[unit]);
-	platform_device_register(&ubd_devs[unit].pdev);
-
-	disk->private_data = &ubd_devs[unit];
-	disk->queue = ubd_devs[unit].queue;
-	return device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
-}
-
 #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
 
 static const struct blk_mq_ops ubd_mq_ops = {
@@ -916,7 +895,21 @@ static int ubd_add(int n, char **error_out)
 	ubd_dev->queue = disk->queue;
 
 	blk_queue_write_cache(ubd_dev->queue, true, false);
-	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
+	disk->major = UBD_MAJOR;
+	disk->first_minor = n << UBD_SHIFT;
+	disk->minors = 1 << UBD_SHIFT;
+	disk->fops = &ubd_blops;
+	set_capacity(disk, ubd_dev->size / 512);
+	sprintf(disk->disk_name, "ubd%c", 'a' + n);
+	disk->private_data = ubd_dev;
+
+	ubd_dev->pdev.id = n;
+	ubd_dev->pdev.name = DRIVER_NAME;
+	ubd_dev->pdev.dev.release = ubd_device_release;
+	dev_set_drvdata(&ubd_dev->pdev.dev, ubd_dev);
+	platform_device_register(&ubd_dev->pdev);
+
+	err = device_add_disk(&ubd_dev->pdev.dev, disk, ubd_attr_groups);
 	if (err)
 		goto out_cleanup_disk;
 
-- 
2.39.2


