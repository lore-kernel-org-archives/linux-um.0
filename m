Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36775C27C4F
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=G254IYRsUd/F6t4PlJahixfTtyWkS+KjkuNozPFW2uM=; b=UP42Ra2COZJiL+r0kv0ZEK+FJF
	IAcO6BWe7iz3KgYu3cv/p67zvJjyCj+smQm5Gk+6MpS8+OIgd9I2KX8OHRwrrfX0XmxFwgg5mT5DK
	IjtX7HEGnhYAULIVd5jHo0jDZpEMaRWxqIvQsVnGLxxB0E6PKVHmmJtbdMHrICrrAbZ4C1FIj+NX8
	qsASA/P53TXtOA1qY8fKVZ1lg5036LgmgQ0OlA4oBq5+OvqF/225KNUZm+yw1Hs1dP1AI80/66VYO
	sxdPnfr2dHLh/22uxPdOuNzZ8JUFjp156XbYjSwPOUMfKN8aEIFL23H1B5aL6Pudi13a/ZA2yOj+8
	YIoQ3ocg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0X-00000009Xeh-3O4w;
	Fri, 31 May 2024 07:49:01 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0V-00000009Xcv-0vGx;
	Fri, 31 May 2024 07:48:59 +0000
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
	linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 06/14] sd: add a sd_disable_discard helper
Date: Fri, 31 May 2024 09:48:01 +0200
Message-ID: <20240531074837.1648501-7-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531074837.1648501-1-hch@lst.de>
References: <20240531074837.1648501-1-hch@lst.de>
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

Add helper to disable discard when it is not supported and use it
instead of sd_config_discard in the I/O completion handler.  This avoids
touching more fields than required in the I/O completion handler and
prepares for converting sd to use the atomic queue limits API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 83aa17fea39d39..f07d90474e682b 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -821,6 +821,12 @@ static unsigned char sd_setup_protect_cmnd(struct scsi_cmnd *scmd,
 	return protect;
 }
 
+static void sd_disable_discard(struct scsi_disk *sdkp)
+{
+	sdkp->provisioning_mode = SD_LBP_DISABLE;
+	blk_queue_max_discard_sectors(sdkp->disk->queue, 0);
+}
+
 static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 {
 	struct request_queue *q = sdkp->disk->queue;
@@ -2245,12 +2251,12 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 		case 0x24:	/* INVALID FIELD IN CDB */
 			switch (SCpnt->cmnd[0]) {
 			case UNMAP:
-				sd_config_discard(sdkp, SD_LBP_DISABLE);
+				sd_disable_discard(sdkp);
 				break;
 			case WRITE_SAME_16:
 			case WRITE_SAME:
 				if (SCpnt->cmnd[1] & 8) { /* UNMAP */
-					sd_config_discard(sdkp, SD_LBP_DISABLE);
+					sd_disable_discard(sdkp);
 				} else {
 					sdkp->device->no_write_same = 1;
 					sd_config_write_same(sdkp);
-- 
2.43.0


