Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F6B8C25B75
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:48:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FAwSfn6ckfnQfuPEUHGpbbgoT8gFgpbbTIk4PRDlm6U=; b=xkviZ3mPH5R6MG4m+fml9+kfUA
	MltqrGePpu5UpVOlNEOPeBy3AGF/6zX4e7nNZ0P0vMrhuWhG7ZmMqLKsXS9KGDCvZt5B6M5ynAQy2
	cUr1q3uo0O4OE7T2Vr6LrSGYcJM6872uhxAUVxotewlobQf+TQqmiFPcn8ehF/fl+3Q+SQajnK4W3
	DCyyvwztmfvzHV89ygiyqoTD8Rvdy379FBuUWa0VWt9EBQI255AbojlW0nCbdSOzDeXhQd/C4gsmW
	B/C3qgMmDU1MicTdDIulpivz4PvMA0E17/pj2b181jtihPWKqt1Jn6GmmO4cqaUfufji9QXEHmfQI
	Ca5yp2Og==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0V-00000009XdH-0JGA;
	Fri, 31 May 2024 07:48:59 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0S-00000009XbL-2AyO;
	Fri, 31 May 2024 07:48:57 +0000
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
Subject: [PATCH 05/14] sd: simplify the ZBC case in provisioning_mode_store
Date: Fri, 31 May 2024 09:48:00 +0200
Message-ID: <20240531074837.1648501-6-hch@lst.de>
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

Don't reset the discard settings to no-op over and over when a user
writes to the provisioning attribute as that is already the default
mode for ZBC devices.  In hindsight we should have made writing to
the attribute fail for ZBC devices, but the code has probably been
around for far too long to change this now.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/sd.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 3dff9150ce11e2..83aa17fea39d39 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -461,14 +461,13 @@ provisioning_mode_store(struct device *dev, struct device_attribute *attr,
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	if (sd_is_zoned(sdkp)) {
-		sd_config_discard(sdkp, SD_LBP_DISABLE);
-		return count;
-	}
-
 	if (sdp->type != TYPE_DISK)
 		return -EINVAL;
 
+	/* ignore the provisioning mode for ZBC devices */
+	if (sd_is_zoned(sdkp))
+		return count;
+
 	mode = sysfs_match_string(lbp_mode, buf);
 	if (mode < 0)
 		return -EINVAL;
-- 
2.43.0


