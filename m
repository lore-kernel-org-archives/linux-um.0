Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58946C25B75
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8qWYYD/WE7sZdc6vKaSwzAcVLajLtvsC2W0WllIXaIM=; b=Jdezm7AeTeIE0N/vLWNM7SXNMu
	0A8girnAEjDBn5/hs8gKacnEZ2kg5nF6zyqiGEIMXltuSjDHtkgJh/Nuz6LyC2d9MUNWZEpN9LIp3
	SMxVDVMDOyLu19Ed2dmQgS5Oh4hStwHzoEcpvjRwdtOcilLU4No20aTqQbmByoGXU8GayL3ri2rn+
	ZAKvja79WGSnmoI9EuMg94j3iy0JzujTcawvjQ11MqdKU8k03zEy4AmDJzGQ581thz+vtO+mD1ymd
	FgRQxs/deuhFduY6pN9fDrsqeu0A9+VNokDKsyEsAqjBbvwYRs2DzQbOLcuBaEQDSqKejZGSuY6AH
	ggUxJCqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0L-00000009XWs-30Hm;
	Fri, 31 May 2024 07:48:49 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0I-00000009XVz-1ERf;
	Fri, 31 May 2024 07:48:46 +0000
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
	linux-scsi@vger.kernel.org
Subject: [PATCH 01/14] ubd: refactor the interrupt handler
Date: Fri, 31 May 2024 09:47:56 +0200
Message-ID: <20240531074837.1648501-2-hch@lst.de>
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

Instead of a separate handler function that leaves no work in the
interrupt hanler itself, split out a per-request end I/O helper and
clean up the coding style and variable naming while we're at it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 49 ++++++++++++++------------------------
 1 file changed, 18 insertions(+), 31 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index ef805eaa9e013d..0c9542d58c01b7 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -447,43 +447,30 @@ static int bulk_req_safe_read(
 	return n;
 }
 
-/* Called without dev->lock held, and only in interrupt context. */
-static void ubd_handler(void)
+static void ubd_end_request(struct io_thread_req *io_req)
 {
-	int n;
-	int count;
-
-	while(1){
-		n = bulk_req_safe_read(
-			thread_fd,
-			irq_req_buffer,
-			&irq_remainder,
-			&irq_remainder_size,
-			UBD_REQ_BUFFER_SIZE
-		);
-		if (n < 0) {
-			if(n == -EAGAIN)
-				break;
-			printk(KERN_ERR "spurious interrupt in ubd_handler, "
-			       "err = %d\n", -n);
-			return;
-		}
-		for (count = 0; count < n/sizeof(struct io_thread_req *); count++) {
-			struct io_thread_req *io_req = (*irq_req_buffer)[count];
-
-			if ((io_req->error == BLK_STS_NOTSUPP) && (req_op(io_req->req) == REQ_OP_DISCARD)) {
-				blk_queue_max_discard_sectors(io_req->req->q, 0);
-				blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
-			}
-			blk_mq_end_request(io_req->req, io_req->error);
-			kfree(io_req);
-		}
+	if (io_req->error == BLK_STS_NOTSUPP &&
+	    req_op(io_req->req) == REQ_OP_DISCARD) {
+		blk_queue_max_discard_sectors(io_req->req->q, 0);
+		blk_queue_max_write_zeroes_sectors(io_req->req->q, 0);
 	}
+	blk_mq_end_request(io_req->req, io_req->error);
+	kfree(io_req);
 }
 
 static irqreturn_t ubd_intr(int irq, void *dev)
 {
-	ubd_handler();
+	int len, i;
+
+	while ((len = bulk_req_safe_read(thread_fd, irq_req_buffer,
+			&irq_remainder, &irq_remainder_size,
+			UBD_REQ_BUFFER_SIZE)) >= 0) {
+		for (i = 0; i < len / sizeof(struct io_thread_req *); i++)
+			ubd_end_request((*irq_req_buffer)[i]);
+	}
+
+	if (len < 0 && len != -EAGAIN)
+		pr_err("spurious interrupt in %s, err = %d\n", __func__, len);
 	return IRQ_HANDLED;
 }
 
-- 
2.43.0


