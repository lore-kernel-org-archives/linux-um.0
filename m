Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E10F6C7EE23
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 11:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=8rtOkidDrRU8JTgkWqxEaCX4Ql4/kwDX2jL02WAhw5U=; b=v5HlnN0hwYz860
	UDGWGlumJoIvnNLb1bca0JT4IhBaf4lqAUrKkfiPNgLu2HbfbO2QNpAh6uP8OJQ8ebuMR4d0nYMwp
	GGj9cZSxqW3U8AQ3TsVRQzVXdGwC0Gee4b2V1PMxskuZCYU+Ez1d+8FSgAKV5Q57eViP0NRrypyUX
	rIWB1/Zo0JwSysYZqi5+zmFIqmBs2u2ILDJqVEiU5Y2e52bbP1D5dBRqTZqyQEWUIwJoN3ilcOWUA
	+Az0AEedqdKno/pG+HCfnpfPRmdMWbSdiA3NYuY+aUKACDFOJo7Y+gnf12r14H694e4fzYBbXkS0Y
	HYJrYlIR9cHbdA+jcK2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DRC-0092tN-2o;
	Thu, 08 Jun 2023 11:04:18 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DQR-00921s-1m;
	Thu, 08 Jun 2023 11:03:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
	Josef Bacik <josef@toxicpanda.com>,
	"Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Phillip Potter <phil@philpotter.co.uk>,
	Coly Li <colyli@suse.de>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	"Rafael J. Wysocki" <rafael@kernel.org>,
	Pavel Machek <pavel@ucw.cz>,
	dm-devel@redhat.com,
	linux-block@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	linux-bcache@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	linux-nvme@lists.infradead.org,
	linux-btrfs@vger.kernel.org,
	linux-f2fs-devel@lists.sourceforge.net,
	linux-nilfs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-pm@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 11/30] swsusp: don't pass a stack address to blkdev_get_by_path
Date: Thu,  8 Jun 2023 13:02:39 +0200
Message-Id: <20230608110258.189493-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230608110258.189493-1-hch@lst.de>
References: <20230608110258.189493-1-hch@lst.de>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

holder is just an on-stack pointer that can easily be reused by other calls,
replace it with a static variable that doesn't change.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 kernel/power/swap.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/kernel/power/swap.c b/kernel/power/swap.c
index 81aec3b2c60510..b03ff1a33c7f68 100644
--- a/kernel/power/swap.c
+++ b/kernel/power/swap.c
@@ -1510,6 +1510,8 @@ int swsusp_read(unsigned int *flags_p)
 	return error;
 }
 
+static void *swsusp_holder;
+
 /**
  *      swsusp_check - Check for swsusp signature in the resume device
  */
@@ -1517,14 +1519,13 @@ int swsusp_read(unsigned int *flags_p)
 int swsusp_check(bool snapshot_test)
 {
 	int error;
-	void *holder;
 	fmode_t mode = FMODE_READ;
 
 	if (snapshot_test)
 		mode |= FMODE_EXCL;
 
 	hib_resume_bdev = blkdev_get_by_dev(swsusp_resume_device,
-					    mode, &holder, NULL);
+					    mode, &swsusp_holder, NULL);
 	if (!IS_ERR(hib_resume_bdev)) {
 		set_blocksize(hib_resume_bdev, PAGE_SIZE);
 		clear_page(swsusp_header);
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
