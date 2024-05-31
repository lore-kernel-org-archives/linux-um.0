Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62A73C25B75
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rb1OF73CoqNaiVO8CqTHVc8xH4T7Xk6a2c9CxacCVxo=; b=wjBCIJ1S/R0/0Ml8zHjJ1aDRzA
	QJ7YDtiwtUZleMV8tOAecVHFNX/telwbWUbZ5sFxXcy9sXkkOrlCV07q+qmGkP+ABYjtqxHlM5YmK
	6XZgxsPsxrSODttiFUiWPjCstxXrj1T0F1U1Te0nk8Kax7QnwX7AyRAMfRYEKGJMbBbYWDJtXOU8Y
	R6FaVSntP6AUSwZGmIEt+ZobRek3qPZpwfOR4Z+Ez1YNvPbMcQ3oS81mXoT5Z89kDyZgdPpZAH43e
	EZ6UCRdJw4RRjqiQMX9pRQUGPvu3TIfdUvXvZiBgiQkZj3yrZG/gCeSWxez8qo2+GsN5BaAmLMDe+
	eqppWQxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0f-00000009XjV-3Ir5;
	Fri, 31 May 2024 07:49:09 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0c-00000009Xgz-3ZvO;
	Fri, 31 May 2024 07:49:08 +0000
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
Subject: [PATCH 09/14] sd: factor out a sd_discard_mode helper
Date: Fri, 31 May 2024 09:48:04 +0200
Message-ID: <20240531074837.1648501-10-hch@lst.de>
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

Split the logic to pick the right discard mode into a little helper
to prepare for further changes.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/sd.c | 37 ++++++++++++++++++++-----------------
 1 file changed, 20 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 0dbc6eb7a7cac3..39eddfac09ef8f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3201,6 +3201,25 @@ static void sd_read_app_tag_own(struct scsi_disk *sdkp, unsigned char *buffer)
 	return;
 }
 
+static unsigned int sd_discard_mode(struct scsi_disk *sdkp)
+{
+	if (!sdkp->lbpvpd) {
+		/* LBP VPD page not provided */
+		if (sdkp->max_unmap_blocks)
+			return SD_LBP_UNMAP;
+		return SD_LBP_WS16;
+	}
+
+	/* LBP VPD page tells us what to use */
+	if (sdkp->lbpu && sdkp->max_unmap_blocks)
+		return SD_LBP_UNMAP;
+	if (sdkp->lbpws)
+		return SD_LBP_WS16;
+	if (sdkp->lbpws10)
+		return SD_LBP_WS10;
+	return SD_LBP_DISABLE;
+}
+
 /**
  * sd_read_block_limits - Query disk device for preferred I/O sizes.
  * @sdkp: disk to query
@@ -3239,23 +3258,7 @@ static void sd_read_block_limits(struct scsi_disk *sdkp)
 			sdkp->unmap_alignment =
 				get_unaligned_be32(&vpd->data[32]) & ~(1 << 31);
 
-		if (!sdkp->lbpvpd) { /* LBP VPD page not provided */
-
-			if (sdkp->max_unmap_blocks)
-				sd_config_discard(sdkp, SD_LBP_UNMAP);
-			else
-				sd_config_discard(sdkp, SD_LBP_WS16);
-
-		} else {	/* LBP VPD page tells us what to use */
-			if (sdkp->lbpu && sdkp->max_unmap_blocks)
-				sd_config_discard(sdkp, SD_LBP_UNMAP);
-			else if (sdkp->lbpws)
-				sd_config_discard(sdkp, SD_LBP_WS16);
-			else if (sdkp->lbpws10)
-				sd_config_discard(sdkp, SD_LBP_WS10);
-			else
-				sd_config_discard(sdkp, SD_LBP_DISABLE);
-		}
+		sd_config_discard(sdkp, sd_discard_mode(sdkp));
 	}
 
  out:
-- 
2.43.0


