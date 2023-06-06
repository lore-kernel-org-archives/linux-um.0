Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D38C7EE2A
	for <linux-um@archiver.kernel.org>; Tue,  6 Jun 2023 07:41:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=S6MW+RABeP/Bsz0k4bFyjqxyp/Q+05qRu3Tvo1kJQGI=; b=hQ96LfAB2IzVsS
	7pmczGZUGWyRzgIEmM2fbMg7ec9PKSguvoOW7Wxim4tFvbPJCVezQfKltvfll2sfyd191Vsuo68R7
	GSg6Xfv3Zj4ryf+PxLOSznspUC2NefiVEqtgSxxDooL9RrMAtgAzs/nzKSdDgd7/kwscDXIyLJdo1
	L7ImFQT17gO0EtNGjVQQ/AwAKVqtUBIVIQvSmN5ost4LFRgsmqSrqkNz65OErgaadCKKsrfjsHX9t
	4Qaw5v2ZiN3/Yl0WuFblgQ6p6DmmTAcnkfNoWbkRj5yyBGCeBaVCnxHQZUQiO3rLwb0lEUCjSznKW
	+WfWZunr6Pbo5hRl3J4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RJZ-000Zuh-33;
	Tue, 06 Jun 2023 07:41:13 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q6RIt-000Z8r-0R;
	Tue, 06 Jun 2023 07:40:31 +0000
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
	linux-pm@vger.kernel.org
Subject: [PATCH 11/31] block: rename blkdev_close to blkdev_release
Date: Tue,  6 Jun 2023 09:39:30 +0200
Message-Id: <20230606073950.225178-12-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230606073950.225178-1-hch@lst.de>
References: <20230606073950.225178-1-hch@lst.de>
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

Make the function name match the method name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/fops.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 6a3087b750a6cd..26af2b39c758e1 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -500,7 +500,7 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static int blkdev_close(struct inode *inode, struct file *filp)
+static int blkdev_release(struct inode *inode, struct file *filp)
 {
 	struct block_device *bdev = filp->private_data;
 
@@ -677,7 +677,7 @@ static long blkdev_fallocate(struct file *file, int mode, loff_t start,
 
 const struct file_operations def_blk_fops = {
 	.open		= blkdev_open,
-	.release	= blkdev_close,
+	.release	= blkdev_release,
 	.llseek		= blkdev_llseek,
 	.read_iter	= blkdev_read_iter,
 	.write_iter	= blkdev_write_iter,
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
