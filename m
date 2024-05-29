Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64AFC25B7C
	for <linux-um@archiver.kernel.org>; Wed, 29 May 2024 05:05:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1JKlKb0rmvW5PqJBHaV8Z8irK92Phe1LJwE6MWVRDfE=; b=LHJBMM7vrqH3gP4CqjvlB34IHq
	/YqsNllLI6Tm+aMNqsycuj7y/IN7dTCizGSlbZUdmlzCeP4sn/pBEh5uHI7C9PxhAt10XF1Q5pS2V
	GFl+kpfWBUfTV/6CE/5ST3Ap9qWvf+wyhl+1jTNHE8Sn8gEYQJbr+HemzXJkwkl9LHWUYjswtPG0u
	k6ir0yKLLlJtiVksoY/FLzVuT/uoBL1IahGRfaF/4BD8VLtdM5qOZR9KruKScszu108KnbXbxbqSp
	qAqGTJcHhaYowpJNkL10UgO+o8jLOuwuj5F18t3c7oPNQy1ylTtD7zMIV14JJnon+aEticWFzmjMf
	UZLI+Dng==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCBV5-00000002pXv-18Tn;
	Wed, 29 May 2024 05:05:23 +0000
Received: from 2a02-8389-2341-5b80-7775-b725-99f7-3344.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:7775:b725:99f7:3344] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCBV3-00000002pVu-0qka;
	Wed, 29 May 2024 05:05:21 +0000
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
Subject: [PATCH 04/12] sd: add a sd_disable_discard helper
Date: Wed, 29 May 2024 07:04:06 +0200
Message-ID: <20240529050507.1392041-5-hch@lst.de>
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

Add helper to disable discard when it is not supported and use it
instead of sd_config_discard in the I/O completion handler.  This avoids
touching more fields than required in the I/O completion handler and
prepares for converting sd to use the atomic queue limits API.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/scsi/sd.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 15d0035048d902..a8838381823254 100644
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


