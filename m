Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B31EC48BF8
	for <linux-um@archiver.kernel.org>; Thu, 22 Feb 2024 07:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XOrf8aRVfOLyUlEU9mfD8SHhHCuj9KCbbzXY0gtM8to=; b=O83TX92hnltcoZ7dRsz8ZYx5hu
	JKSHVRsIsf8FpsZOefQuxOHYI6AYcbsfdmYc3P3jYDoIOHxSH0QBmegEZKzQ+pfTMNH/NN77VXIgV
	BjnAZlWZEiSu5a6P04QY5X3E81MOUcrYo700QXe4DMUY5LzKdFJswQGzXKhRnnIpZyJLzRKpG6eaK
	PoRhlyhjJSB++zVu9TF4+MXV7Nn59XSqPevtCFn+KKJlrRXX6LX+Yw6U4j9QU9bfo3ALALvuLOyuY
	mgU8x37N59Cm0ZxDuRCopiVPON8Uf72C7SR/MdFesJKx4PU4Gj4GRg9pMBXzP9ZEgnXdpwawbt1mv
	68o5fOJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RX-00000003ngE-0Pwh;
	Thu, 22 Feb 2024 07:24:31 +0000
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RV-00000003nfE-1eoJ;
	Thu, 22 Feb 2024 07:24:29 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 4/7] ubd: move setting the variable queue limits to ubd_add
Date: Thu, 22 Feb 2024 08:24:14 +0100
Message-Id: <20240222072417.3773131-5-hch@lst.de>
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

No reason to delay this until open time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 9dcf41f7d49606..26bc8306356263 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -772,8 +772,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 	ubd_dev->fd = fd;
 
 	if(ubd_dev->cow.file != NULL){
-		blk_queue_max_hw_sectors(ubd_dev->queue, 8 * sizeof(long));
-
 		err = -ENOMEM;
 		ubd_dev->cow.bitmap = vmalloc(ubd_dev->cow.bitmap_len);
 		if(ubd_dev->cow.bitmap == NULL){
@@ -795,10 +793,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		if(err < 0) goto error;
 		ubd_dev->cow.fd = err;
 	}
-	if (ubd_dev->no_trim == 0) {
-		blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
-		blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
-	}
 	return 0;
  error:
 	os_close_file(ubd_dev->fd);
@@ -867,6 +861,13 @@ static int ubd_add(int n, char **error_out)
 	if(ubd_dev->file == NULL)
 		goto out;
 
+	if (ubd_dev->cow.file)
+		lim.max_hw_sectors = 8 * sizeof(long);
+	if (!ubd_dev->no_trim) {
+		lim.max_hw_discard_sectors = UBD_MAX_REQUEST;
+		lim.max_write_zeroes_sectors = UBD_MAX_REQUEST;
+	}
+
 	err = ubd_file_size(ubd_dev, &ubd_dev->size);
 	if(err < 0){
 		*error_out = "Couldn't determine size of device's file";
-- 
2.39.2


