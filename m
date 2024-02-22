Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 592D3C5478C
	for <linux-um@archiver.kernel.org>; Thu, 22 Feb 2024 07:24:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=g/2GmS4AXLXXjlfuzEY4M+H/g1Vi8otqWk2R/DkaXmE=; b=udyNuwU6P9c/K7zGtOoUXUyuyF
	0/awGK5Pn6MUy0XSV5QWA0V3oaDriZWThyFILcFqNXgOQGOnE56heYPv6BoYr2+ICC+Oq1z2Bo3PO
	nvghpS9c3FlylC7Yyl+MLjbVV8ViDpkOfjM6FOOZVZ4tcsEh01CA7HeF31FfSAQNF5RSYJIo7sUsJ
	+LUFF1qTsZQbdczsjzr7Kd73Y+Z352vcm2p5WcFUwgqWgGh7ZnB9eeRYy6/um1oBpRsRwt/VnISGa
	A238XgbLXJ0yjSnpyfrR/ay5T0v6Us99dyZWCkm+fzOOft43FwQ0Qi0uLXH12M0x4d/wRvbxYOzSH
	0fZDJbSQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3Rb-00000003njR-47Rl;
	Thu, 22 Feb 2024 07:24:35 +0000
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3Ra-00000003nhe-2Cdb;
	Thu, 22 Feb 2024 07:24:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 6/7] ubd: remove the queue pointer in struct ubd
Date: Thu, 22 Feb 2024 08:24:16 +0100
Message-Id: <20240222072417.3773131-7-hch@lst.de>
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

No need for it now, everything goes through the gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index c5d32e75426366..9bf1d6a88bae59 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -163,7 +163,6 @@ struct ubd {
 	struct cow cow;
 	struct platform_device pdev;
 	struct gendisk *disk;
-	struct request_queue *queue;
 	struct blk_mq_tag_set tag_set;
 	spinlock_t lock;
 };
@@ -892,10 +891,9 @@ static int ubd_add(int n, char **error_out)
 		err = PTR_ERR(disk);
 		goto out_cleanup_tags;
 	}
-	ubd_dev->queue = disk->queue;
 
 	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
-	blk_queue_write_cache(ubd_dev->queue, true, false);
+	blk_queue_write_cache(disk->queue, true, false);
 	disk->major = UBD_MAJOR;
 	disk->first_minor = n << UBD_SHIFT;
 	disk->minors = 1 << UBD_SHIFT;
-- 
2.39.2


