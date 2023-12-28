Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DA39C3DA6E
	for <linux-um@archiver.kernel.org>; Thu, 28 Dec 2023 07:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q/HlW27opIlbbmmp83fWxmA7/2zguajj/Xv/HUI85Ao=; b=eWCBh2HZl/dyZb2urcQbOdpKHb
	EGDrrdUY5wryVLFdJWw8E+cz9JFovPaooSrtRHUwS0qwMK9730h567XBa2nNCw9e6XlsuA67WMaxZ
	/cBD2H+e1uY5snY/IrnGzB11ZslWj/3nRBnMCvD0QTYBT1r8LeDLgEHtMJo1qyRBG4xuDO+Vk0f4f
	H7lRVHBcpHzEohLOVivi/H2jE+OcSFcDfJ1FfJ2viE0EBg2qZXTgqlbG8+lZLZ29iBub90zVuiL93
	KpcFm/MQsSEDeY3fGtzreJBLWioCp1H/1uG+bKfCKS51ewcMt6MeCkeslnBx2GajHJPPuucNM0hVQ
	ueTCkSDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlFR-00GMti-2O;
	Thu, 28 Dec 2023 07:56:09 +0000
Received: from 213-147-167-209.nat.highway.webapn.at ([213.147.167.209] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlFP-00GMsI-1M;
	Thu, 28 Dec 2023 07:56:08 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Minchan Kim <minchan@kernel.org>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	linux-um@lists.infradead.org,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org
Subject: [PATCH 3/9] block: default the discard granularity to sector size
Date: Thu, 28 Dec 2023 07:55:39 +0000
Message-Id: <20231228075545.362768-4-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231228075545.362768-1-hch@lst.de>
References: <20231228075545.362768-1-hch@lst.de>
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

Current the discard granularity defaults to 0 and must be initialized by
any driver that wants to support discard.  Default to the sector size
instead, which is the smallest possible value, and a very useful default.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index ba6e0e97118c08..d993d20dab3c6d 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -48,7 +48,7 @@ void blk_set_default_limits(struct queue_limits *lim)
 	lim->max_discard_sectors = 0;
 	lim->max_hw_discard_sectors = 0;
 	lim->max_secure_erase_sectors = 0;
-	lim->discard_granularity = 0;
+	lim->discard_granularity = 512;
 	lim->discard_alignment = 0;
 	lim->discard_misaligned = 0;
 	lim->logical_block_size = lim->physical_block_size = lim->io_min = 512;
@@ -309,6 +309,9 @@ void blk_queue_logical_block_size(struct request_queue *q, unsigned int size)
 
 	limits->logical_block_size = size;
 
+	if (limits->discard_granularity < limits->logical_block_size)
+		limits->discard_granularity = limits->logical_block_size;
+
 	if (limits->physical_block_size < size)
 		limits->physical_block_size = size;
 
-- 
2.39.2


