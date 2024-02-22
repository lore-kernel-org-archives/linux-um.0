Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D96A7C48BEB
	for <linux-um@archiver.kernel.org>; Thu, 22 Feb 2024 07:24:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rSTF8EhkpxTeqhstKIyynLGq4fa8o7QHCgP9WngjV84=; b=W75qPho5vTcUJ6cYD0+vzLUE9w
	JUhv2UA+3SiQoF0fkLbtw48E0ufYhNTA2fvzBJHlNv1yrxuCHRJORco17t0cob6fLE9ne1Dp0PGVB
	qJVd3N0WMq2R+o9Pip2l8Oc8rIqQDhhtHACVoE08+n/wgL0u2hsnOa2p5Zp24PMyG70N0SnO5egcD
	BaGElp+A3aMk2xjYXS4o/9J+tvMtqLF1gVKv9b/BHcXzflkVFo/ZaIbF+0reVmmbYXD29TFQgnvjF
	xhtepUyIH7JGjYRBk0o0mj4XkrKlH7GRRbS+WJYJwcaoOhOS+Rcdv9zhug6a9OoOFwK1VSLGKhb5K
	CGmNO+Kg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3Ra-00000003niC-2KWF;
	Thu, 22 Feb 2024 07:24:34 +0000
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RX-00000003nfv-4465;
	Thu, 22 Feb 2024 07:24:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 5/7] ubd: move set_disk_ro to ubd_add
Date: Thu, 22 Feb 2024 08:24:15 +0100
Message-Id: <20240222072417.3773131-6-hch@lst.de>
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

No need to delay this until open time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 26bc8306356263..c5d32e75426366 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -903,6 +903,7 @@ static int ubd_add(int n, char **error_out)
 	set_capacity(disk, ubd_dev->size / 512);
 	sprintf(disk->disk_name, "ubd%c", 'a' + n);
 	disk->private_data = ubd_dev;
+	set_disk_ro(disk, !ubd_dev->openflags.w);
 
 	ubd_dev->pdev.id = n;
 	ubd_dev->pdev.name = DRIVER_NAME;
@@ -1159,7 +1160,6 @@ static int ubd_open(struct gendisk *disk, blk_mode_t mode)
 		}
 	}
 	ubd_dev->count++;
-	set_disk_ro(disk, !ubd_dev->openflags.w);
 out:
 	mutex_unlock(&ubd_mutex);
 	return err;
-- 
2.39.2


