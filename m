Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72DF0C47072
	for <linux-um@archiver.kernel.org>; Thu, 28 Dec 2023 07:56:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wsinjDSCV+Rjfc71EDyifigolrdpbzFtrjrUVZw9+FQ=; b=JI0mUd5qh5x1kVFFjE2XHvdcCo
	y6T9b8yTmCKWNfiWz+Kl7Nj1sWi5ScwA0cQHFvCilyzKkyDEq/Fr5DlUnHIa22bNOTMfG+sjqWrzI
	buHPUvVdDy7b+VQPXsOtn7c4M3bDacVylYLMswAbJn3KpQ6WRlZBZ3IXxQk4HtHaxpfR9wW7yGVsE
	nX4zJ0vRU6EcgyrHHFzFb8xDl8NcpXAARA/EKgln2thWanh+tZuLcPnzOWBAweMmYiANL5v5K57ZB
	P1IIMNVFakskwAPtDzb1h+GSoFtBdiGhDT3NNxjHIt18FX07bBE6Qq4F/TdNGxa/XbSjcdV9SXKKh
	6bMQbdpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlFF-00GMqi-2o;
	Thu, 28 Dec 2023 07:55:57 +0000
Received: from 213-147-167-209.nat.highway.webapn.at ([213.147.167.209] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1rIlF9-00GMqU-1S;
	Thu, 28 Dec 2023 07:55:52 +0000
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
Subject: provide a sane discard_granularity default
Date: Thu, 28 Dec 2023 07:55:36 +0000
Message-Id: <20231228075545.362768-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

Hi Jens,

this series defaults the discard_granularity to the sector size as
that is a very logical default for devices that have no further
restrictions.  This removes the need for trivial drivers to set
a discard granularity and cleans up the interface.

Diffstat:
 arch/um/drivers/ubd_kern.c    |    1 -
 block/blk-merge.c             |    6 +-----
 block/blk-settings.c          |    5 ++++-
 drivers/block/nbd.c           |    6 +-----
 drivers/block/null_blk/main.c |    1 -
 drivers/block/zram/zram_drv.c |    1 -
 drivers/md/bcache/super.c     |    1 -
 drivers/mtd/mtd_blkdevs.c     |    4 +---
 8 files changed, 7 insertions(+), 18 deletions(-)

