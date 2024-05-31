Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AFE1C25B75
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:49:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NIYU24POaVEtCWxh2Uz76sasJLK5fExY/uxdAFrpLn0=; b=g/EkX16jvHi1rMo1FhwCE/PBSJ
	FXhr7OPu2RdIt1PD0KgEOebPajr+d+bhUYwcbvF27ceaZnJEXmtXI9NMqpp6iXFsPwRhidRmZ2bBt
	+lTk+QQd+zzE3Fz8ZGBVsQLrOaoDfTL0548L/3lQFT/K1RGSudA0VPTMK2gnrhvLobasLBrnFDLre
	zwwP0NqrruJ326R7LLIJCCEHJe8AUi239SsyvSaFJi0VJRipGp25+eUGDhZEdFU154QyCLOv4i2Kt
	STiWQYCuH7YNqszW2mhYG2vDksVA6u5zqSWDAdkcH63AsceJwX3S05nOdPvjBZ1Qy8FmmyZZlkV/H
	kXLvWWWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0a-00000009XgH-2Vn4;
	Fri, 31 May 2024 07:49:04 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0X-00000009XeI-2flr;
	Fri, 31 May 2024 07:49:02 +0000
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
Subject: [PATCH 07/14] sd: add a sd_disable_write_same helper
Date: Fri, 31 May 2024 09:48:02 +0200
Message-ID: <20240531074837.1648501-8-hch@lst.de>
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

Add helper to disable WRITE SAME when it is not supported and use it
instead of sd_config_write_same in the I/O completion handler.  This
avoids touching more fields than required in the I/O completion handler
and  prepares for converting sd to use the atomic queue limits API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index f07d90474e682b..70211d0b187652 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -1004,6 +1004,13 @@ static blk_status_t sd_setup_write_zeroes_cmnd(struct scsi_cmnd *cmd)
 	return sd_setup_write_same10_cmnd(cmd, false);
 }
 
+static void sd_disable_write_same(struct scsi_disk *sdkp)
+{
+	sdkp->device->no_write_same = 1;
+	sdkp->max_ws_blocks = 0;
+	blk_queue_max_write_zeroes_sectors(sdkp->disk->queue, 0);
+}
+
 static void sd_config_write_same(struct scsi_disk *sdkp)
 {
 	struct request_queue *q = sdkp->disk->queue;
@@ -2258,8 +2265,7 @@ static int sd_done(struct scsi_cmnd *SCpnt)
 				if (SCpnt->cmnd[1] & 8) { /* UNMAP */
 					sd_disable_discard(sdkp);
 				} else {
-					sdkp->device->no_write_same = 1;
-					sd_config_write_same(sdkp);
+					sd_disable_write_same(sdkp);
 					req->rq_flags |= RQF_QUIET;
 				}
 				break;
-- 
2.43.0


