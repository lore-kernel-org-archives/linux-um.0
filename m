Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52EDCC25B7C
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 05:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/Z/UqEGIRF/2yhrzEkv4fi5cgTRBRNNGaBlYe7kzoKc=; b=pMI2s1Ru4T5labx8ChxOar5Pps
	wS+kk8adxrWp9Yy0W4HDzKjsoq1liGqH6oUb/v2vt6sf9KK8tjlyTpxw2RGFtMWID7Lb4E9QAbKwd
	bKVLcIkzuYh0HdnleFG3GFQUSK4mfJPNeUX7pREswa43l+cU2yRcb+GpDZVoWeQl5Hq+iYRvO8TEe
	f2EQJrpS/BwZOwSpH7IzhHYnm61wtTB0FG4A7vHs9kPmkLWSXDAmNTEavXcwfpl/5UaBuRKuXkMN3
	RxxVeigRMRcRCx540UHX/IxnWNmiJqNI2wVT7mBFheUdIbq5bI1kWjx1wrXKtYAnNbCqRggUwCHp9
	8nf/h8vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCBVL-00000002pj4-3uXG;
	Wed, 29 May 2024 05:05:39 +0000
Received: from 2a02-8389-2341-5b80-7775-b725-99f7-3344.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7775:b725:99f7:3344] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCBVJ-00000002pg5-2kL2;
	Wed, 29 May 2024 05:05:38 +0000
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
Subject: [PATCH 10/12] sr: convert to the atomic queue limits API
Date: Wed, 29 May 2024 07:04:12 +0200
Message-ID: <20240529050507.1392041-11-hch@lst.de>
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

Assign all queue limits through a local queue_limits variable and
queue_limits_commit_update so that we can't race updating them from
multiple places, and free the queue when updating them so that
in-progress I/O submissions don't see half-updated limits.

Also use the chance to clean up variable names to standard ones.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sr.c | 42 +++++++++++++++++++++++++-----------------
 1 file changed, 25 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 7ab000942b97fc..3f491019103e0c 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -111,7 +111,7 @@ static struct lock_class_key sr_bio_compl_lkclass;
 static int sr_open(struct cdrom_device_info *, int);
 static void sr_release(struct cdrom_device_info *);
 
-static void get_sectorsize(struct scsi_cd *);
+static int get_sectorsize(struct scsi_cd *);
 static int get_capabilities(struct scsi_cd *);
 
 static unsigned int sr_check_events(struct cdrom_device_info *cdi,
@@ -473,15 +473,15 @@ static blk_status_t sr_init_command(struct scsi_cmnd *SCpnt)
 	return BLK_STS_IOERR;
 }
 
-static void sr_revalidate_disk(struct scsi_cd *cd)
+static int sr_revalidate_disk(struct scsi_cd *cd)
 {
 	struct scsi_sense_hdr sshdr;
 
 	/* if the unit is not ready, nothing more to do */
 	if (scsi_test_unit_ready(cd->device, SR_TIMEOUT, MAX_RETRIES, &sshdr))
-		return;
+		return 0;
 	sr_cd_check(&cd->cdi);
-	get_sectorsize(cd);
+	return get_sectorsize(cd);
 }
 
 static int sr_block_open(struct gendisk *disk, blk_mode_t mode)
@@ -494,13 +494,16 @@ static int sr_block_open(struct gendisk *disk, blk_mode_t mode)
 		return -ENXIO;
 
 	scsi_autopm_get_device(sdev);
-	if (disk_check_media_change(disk))
-		sr_revalidate_disk(cd);
+	if (disk_check_media_change(disk)) {
+		ret = sr_revalidate_disk(cd);
+		if (ret)
+			goto out;
+	}
 
 	mutex_lock(&cd->lock);
 	ret = cdrom_open(&cd->cdi, mode);
 	mutex_unlock(&cd->lock);
-
+out:
 	scsi_autopm_put_device(sdev);
 	if (ret)
 		scsi_device_put(cd->device);
@@ -685,7 +688,9 @@ static int sr_probe(struct device *dev)
 	blk_pm_runtime_init(sdev->request_queue, dev);
 
 	dev_set_drvdata(dev, cd);
-	sr_revalidate_disk(cd);
+	error = sr_revalidate_disk(cd);
+	if (error)
+		goto unregister_cdrom;
 
 	error = device_add_disk(&sdev->sdev_gendev, disk, NULL);
 	if (error)
@@ -714,13 +719,14 @@ static int sr_probe(struct device *dev)
 }
 
 
-static void get_sectorsize(struct scsi_cd *cd)
+static int get_sectorsize(struct scsi_cd *cd)
 {
+	struct request_queue *q = cd->device->request_queue;
 	static const u8 cmd[10] = { READ_CAPACITY };
 	unsigned char buffer[8] = { };
-	int the_result;
+	struct queue_limits lim;
+	int err;
 	int sector_size;
-	struct request_queue *queue;
 	struct scsi_failure failure_defs[] = {
 		{
 			.result = SCMD_FAILURE_RESULT_ANY,
@@ -736,10 +742,10 @@ static void get_sectorsize(struct scsi_cd *cd)
 	};
 
 	/* Do the command and wait.. */
-	the_result = scsi_execute_cmd(cd->device, cmd, REQ_OP_DRV_IN, buffer,
+	err = scsi_execute_cmd(cd->device, cmd, REQ_OP_DRV_IN, buffer,
 				      sizeof(buffer), SR_TIMEOUT, MAX_RETRIES,
 				      &exec_args);
-	if (the_result) {
+	if (err) {
 		cd->capacity = 0x1fffff;
 		sector_size = 2048;	/* A guess, just in case */
 	} else {
@@ -789,10 +795,12 @@ static void get_sectorsize(struct scsi_cd *cd)
 		set_capacity(cd->disk, cd->capacity);
 	}
 
-	queue = cd->device->request_queue;
-	blk_queue_logical_block_size(queue, sector_size);
-
-	return;
+	lim = queue_limits_start_update(q);
+	lim.logical_block_size = sector_size;
+	blk_mq_freeze_queue(q);
+	err = queue_limits_commit_update(q, &lim);
+	blk_mq_unfreeze_queue(q);
+	return err;
 }
 
 static int get_capabilities(struct scsi_cd *cd)
-- 
2.43.0


