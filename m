Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03451C48BEB
	for <linux-um@archiver.kernel.org>; Thu, 22 Feb 2024 07:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2BFULQQpf3659ifgG7eJf7nI2YTQWRMkjSUtn4KfBjI=; b=Q9337AgZqjaoUfxlsIO/3zlQJl
	k7auwUANNayo+ITkrXt1G7ytHDxLGmbsJH8nzMybnWX7kE8bveupoJS5q71tzAOKe0PuK/QzKl7p+
	vFWA9pN5QLX0Z1J+ABCevJw0bSLcY0t7jiYVJvU5DKqyi2oUr2PFsQw3HLMjtfjoKW+51eXyKBpn7
	DPTSdW4jSDt8ejQfGWFpUZoBmwpZNLrfbFny8lDmopDVdSlJpTPfv6ttyJxWGOAbHKD36ugvhKqcC
	rBYSang5sAP1tptqRjNTKLW9ktBf7pBKoL/eLg8SClOenO52/oRkNt6CGRLI2R0OZprcCNu4ONmNM
	en0vDs6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RT-00000003nev-2ryt;
	Thu, 22 Feb 2024 07:24:27 +0000
Received: from [2001:4bb8:19a:62b2:c70:4a89:bc61:3] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rd3RS-00000003ndp-3S4s;
	Thu, 22 Feb 2024 07:24:27 +0000
From: Christoph Hellwig <hch@lst.de>
To: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-um@lists.infradead.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/7] ubd: move setting the nonrot flag to ubd_add
Date: Thu, 22 Feb 2024 08:24:13 +0100
Message-Id: <20240222072417.3773131-4-hch@lst.de>
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
 arch/um/drivers/ubd_kern.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index ef05157acd6b02..9dcf41f7d49606 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -799,7 +799,6 @@ static int ubd_open_dev(struct ubd *ubd_dev)
 		blk_queue_max_discard_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 		blk_queue_max_write_zeroes_sectors(ubd_dev->queue, UBD_MAX_REQUEST);
 	}
-	blk_queue_flag_set(QUEUE_FLAG_NONROT, ubd_dev->queue);
 	return 0;
  error:
 	os_close_file(ubd_dev->fd);
@@ -894,6 +893,7 @@ static int ubd_add(int n, char **error_out)
 	}
 	ubd_dev->queue = disk->queue;
 
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
 	blk_queue_write_cache(ubd_dev->queue, true, false);
 	disk->major = UBD_MAJOR;
 	disk->first_minor = n << UBD_SHIFT;
-- 
2.39.2


