Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A01C7EE25
	for <linux-um@archiver.kernel.org>; Thu,  8 Jun 2023 12:15:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=gC6ksN1bGFVsdGxU9mQTR/wQdP3zM6qlUfm+mqMb59M=; b=Jtqw5Y/6UA7CtS
	hzYG0bK7IrW+0/L8KnkMWr1XcT/pjVZ8Wq+jJttSVgFtaT129IzWfVg/y+6GjKPKYpl4E6ky+nFrn
	3KUGqfeZ8/VVEKUI+LOYG8H2EJ/5bI+Tzsv50GE1W1EdnQpY0fr98CXwj4HJ2fIAE36sxr51QlyMY
	+xg+448f67h/wKnSxxuO2erPYOBTJsu6cKrOkZjoptykSr6cZTTNgzAGuvn0nAu8GxyE+WxgezgOk
	S9ap0Lr81AD4OULrjP7WUu/l5ac2dnbK6hn3qp6RhO8V+0b1HVkqPKrBjevV1trxXE9+Lcml48AWL
	CS1jPswCVjMupByIym+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q7EYZ-009HWr-0X;
	Thu, 08 Jun 2023 12:15:59 +0000
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1q7DRF-0092vE-2z;
	Thu, 08 Jun 2023 11:04:22 +0000
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
Subject: [PATCH 28/30] block: always use I_BDEV on file->f_mapping->host to find the bdev
Date: Thu,  8 Jun 2023 13:02:56 +0200
Message-Id: <20230608110258.189493-29-hch@lst.de>
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

Always use I_BDEV(file->f_mapping->host) to find the bdev for a file to
free up file->private_data for other uses.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Christian Brauner <brauner@kernel.org>
---
 block/fops.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/block/fops.c b/block/fops.c
index 086612103b9dd9..0d714d050a462c 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -54,7 +54,7 @@ static bool blkdev_dio_unaligned(struct block_device *bdev, loff_t pos,
 static ssize_t __blkdev_direct_IO_simple(struct kiocb *iocb,
 		struct iov_iter *iter, unsigned int nr_pages)
 {
-	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	struct bio_vec inline_vecs[DIO_INLINE_BIO_VECS], *vecs;
 	loff_t pos = iocb->ki_pos;
 	bool should_dirty = false;
@@ -170,7 +170,7 @@ static void blkdev_bio_end_io(struct bio *bio)
 static ssize_t __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter,
 		unsigned int nr_pages)
 {
-	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	struct blk_plug plug;
 	struct blkdev_dio *dio;
 	struct bio *bio;
@@ -310,7 +310,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 					struct iov_iter *iter,
 					unsigned int nr_pages)
 {
-	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	bool is_read = iov_iter_rw(iter) == READ;
 	blk_opf_t opf = is_read ? REQ_OP_READ : dio_bio_write_op(iocb);
 	struct blkdev_dio *dio;
@@ -451,7 +451,7 @@ static loff_t blkdev_llseek(struct file *file, loff_t offset, int whence)
 static int blkdev_fsync(struct file *filp, loff_t start, loff_t end,
 		int datasync)
 {
-	struct block_device *bdev = filp->private_data;
+	struct block_device *bdev = I_BDEV(filp->f_mapping->host);
 	int error;
 
 	error = file_write_and_wait_range(filp, start, end);
@@ -516,7 +516,6 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	filp->private_data = bdev;
 	filp->f_mapping = bdev->bd_inode->i_mapping;
 	filp->f_wb_err = filemap_sample_wb_err(filp->f_mapping);
 	return 0;
@@ -524,9 +523,8 @@ static int blkdev_open(struct inode *inode, struct file *filp)
 
 static int blkdev_release(struct inode *inode, struct file *filp)
 {
-	struct block_device *bdev = filp->private_data;
-
-	blkdev_put(bdev, (filp->f_mode & FMODE_EXCL) ? filp : NULL);
+	blkdev_put(I_BDEV(filp->f_mapping->host),
+		   (filp->f_mode & FMODE_EXCL) ? filp : NULL);
 	return 0;
 }
 
@@ -539,7 +537,7 @@ static int blkdev_release(struct inode *inode, struct file *filp)
  */
 static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 {
-	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	struct inode *bd_inode = bdev->bd_inode;
 	loff_t size = bdev_nr_bytes(bdev);
 	size_t shorted = 0;
@@ -575,7 +573,7 @@ static ssize_t blkdev_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static ssize_t blkdev_read_iter(struct kiocb *iocb, struct iov_iter *to)
 {
-	struct block_device *bdev = iocb->ki_filp->private_data;
+	struct block_device *bdev = I_BDEV(iocb->ki_filp->f_mapping->host);
 	loff_t size = bdev_nr_bytes(bdev);
 	loff_t pos = iocb->ki_pos;
 	size_t shorted = 0;
-- 
2.39.2


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
