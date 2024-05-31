Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 073B3C27C4F
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:48:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rhxveVy4ScfquPw+Ix55dD12V3sv6PgWUOdWXrb/Dgc=; b=y98aQz04kyg+LY7imd810dwtUV
	O6W3jrevO2bMvywCHfSf1ka9hUeACoB+06df++2JWkeT/R/6AA36TyQ9K9OZKPmZT4pqRzo2Bfi23
	P1JXFZKJGJVof0Wi59y+Oq1KPPyRAuvzmCUiexROOjVYihMyhuICcs6v4gbhQGMIODw6Q+F+ra2uu
	rsznN7ZnjXeADoOIok9rXXNhFi8agc4qF3LPHEeGSZy1c80wXPQ71OJAkTce8eh6de6kpnofgBe5G
	XLs14m7z0+hBetF6/BxkwWyPsUnpvnE6dXK8ETYyvvH62tmk9BKhkhnB+AMrGKtSLt1wCaf5mtvY7
	cMBXcPxw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0M-00000009XXY-1AuI;
	Fri, 31 May 2024 07:48:50 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0K-00000009XWY-3uLP;
	Fri, 31 May 2024 07:48:49 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Josef Bacik <josef@toxicpanda.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Dongsheng Yang <dongsheng.yang@easystack.cn>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	linux-um@lists.infradead.org,
	linux-block@vger.kernel.org,
	nbd@other.debian.org,
	ceph-devel@vger.kernel.org,
	xen-devel@lists.xenproject.org,
	linux-scsi@vger.kernel.org,
	Bart Van Assche <bvanassche@acm.org>,
	Damien Le Moal <dlemoal@kernel.org>
Subject: [PATCH 02/14] ubd: untagle discard vs write zeroes not support handling
Date: Fri, 31 May 2024 09:47:57 +0200
Message-ID: <20240531074837.1648501-3-hch@lst.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240531074837.1648501-1-hch@lst.de>
References: <20240531074837.1648501-1-hch@lst.de>
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

Discard and Write Zeroes are different operation and implemented
by different fallocate opcodes for ubd.  If one fails the other one
can work and vice versa.

Split the code to disable the operations in ubd_handler to only
disable the operation that actually failed.

Fixes: 50109b5a03b4 ("um: Add support for DISCARD in the UBD Driver")
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Damien Le Moal <dlemoal@kernel.org>
---
 arch/um/drivers/ubd_kern.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index 0c9542d58c01b7..093c87879d08ba 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -449,10 +449,11 @@ static int bulk_req_safe_read(
 
 static void ubd_end_request(struct io_thread_req *io_req)
 {
-	if (io_req->error == BLK_STS_NOTSUPP &&
-	    req_op(io_req->req) == REQ_OP_DISCARD) {
-		blk_queue_max_discard_sectors(io_req->req->q, 0);
-		blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
+	if (io_req->error == BLK_STS_NOTSUPP) {
+		if (req_op(io_req->req) == REQ_OP_DISCARD)
+			blk_queue_max_discard_sectors(io_req->req->q, 0);
+		else if (req_op(io_req->req) == REQ_OP_WRITE_ZEROES)
+			blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
 	}
 	blk_mq_end_request(io_req->req, io_req->error);
 	kfree(io_req);
-- 
2.43.0


