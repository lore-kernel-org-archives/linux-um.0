Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75895C27C44
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HN2Hktsuqrp8T8GVou6AHcXHJfFLm1CDuoHLTArZtbQ=; b=2xywWSOmxfIGzUZN11Lma49kZr
	PgoTWzM8OgIujUV6OI5ud3nGybdK1DHUnR+E9VH7hD8mvD0lc3zofUWYB8/N7ZZz8+yorh05YbzOU
	V7QW4lN6hV6VwR5OLVAFODOk7NwCfdGzieQkvljNhswokeBgjDcNl3f2QPxUDvWkTB67E8lAgfjaZ
	WYavhm2ORClLPj+P7WD4Ea4dLeZ00HqdMrFJY3Ke9CtZQ8IePWmenskNQJqGUPp1Abq+DcC9R93c8
	FW07B5fBz1LwOkMJTnPujQ8tAW+YS9znwRoTVAmfp/lCcSuwTyy2T9PnwdBN3HHAViyXxoRk4dVWg
	ACzXLXaA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0c-00000009Xh6-3dhK;
	Fri, 31 May 2024 07:49:06 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0a-00000009Xfo-0bb2;
	Fri, 31 May 2024 07:49:04 +0000
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
Subject: [PATCH 08/14] sd: simplify the disable case in sd_config_discard
Date: Fri, 31 May 2024 09:48:03 +0200
Message-ID: <20240531074837.1648501-9-hch@lst.de>
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

Fall through to the main call to blk_queue_max_discard_sectors given that
max_blocks has been initialized to zero above instead of duplicating the
call.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 drivers/scsi/sd.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 70211d0b187652..0dbc6eb7a7cac3 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -844,8 +844,7 @@ static void sd_config_discard(struct scsi_disk *sdkp, unsigned int mode)
 
 	case SD_LBP_FULL:
 	case SD_LBP_DISABLE:
-		blk_queue_max_discard_sectors(q, 0);
-		return;
+		break;
 
 	case SD_LBP_UNMAP:
 		max_blocks = min_not_zero(sdkp->max_unmap_blocks,
-- 
2.43.0


