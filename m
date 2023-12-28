Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB3F3C47072
	for <linux-um@archiver.kernel.org>; Thu, 28 Dec 2023 07:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=HkpcWKQTIPI7GkyZeehGy5v+hhspknRU+JppGoiJJYA=; b=s2EORhHE4a2scJSGHOj8qmnPU+
	5hbRIJbkvmbaR1+XLqDIl4b62zXtdgj5PeGhj5lDHdG1zJyvJwankRlqVedUGwmTrs5un/tyYS9jc
	QnewS+FlYddlEC4D1PJ2hX/J5XzriNRF/U9ULhj6vswvbU9z8cIfv2y5GOm2fxhOB7eWBt7W+gmUu
	SyLRkQFlmHtYi4akGgiGbRoshWM1ATohQU5M4RtdXMEZVltml2f66WkcybCkm7w3V2aQ5KTWFtOok
	EvImjNBKOwlRWJGqtzkdfzoeCK/KKj4hsakmvegjM51y9f/Cskqr0xFj4f405QEq4qDIVHE2L+PJK
	0n3xWJ0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlFq-00GN9A-0t;
	Thu, 28 Dec 2023 07:56:34 +0000
Received: from 213-147-167-209.nat.highway.webapn.at ([213.147.167.209] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlFo-00GN5Y-2d;
	Thu, 28 Dec 2023 07:56:33 +0000
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
Subject: [PATCH 8/9] bcache: use the default discard granularity
Date: Thu, 28 Dec 2023 07:55:44 +0000
Message-Id: <20231228075545.362768-9-hch@lst.de>
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

The discard granularity now defaults to a single sector, so don't set
that value explicitly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/bcache/super.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index ecc1447f202a42..39ec95b8613f1f 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -954,7 +954,6 @@ static int bcache_device_init(struct bcache_device *d, unsigned int block_size,
 	q->limits.max_segment_size	= UINT_MAX;
 	q->limits.max_segments		= BIO_MAX_VECS;
 	blk_queue_max_discard_sectors(q, UINT_MAX);
-	q->limits.discard_granularity	= block_size;
 	q->limits.io_min		= block_size;
 	q->limits.logical_block_size	= block_size;
 	q->limits.physical_block_size	= block_size;
-- 
2.39.2


