Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F5EC27C44
	for <linux-um@archiver.kernel.org>; Fri, 31 May 2024 07:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0q2p+u53R9YY1ujQIkkIYHdGljvaoYfmRjVYZa1pGUw=; b=y6zwvi6TcAs0A4WkZ/c4TVoR/T
	eJ9vEGrFFHn6pVoODyYX3qbAaIv/1ajR/DABF+L9xjBnXYK5Hi5y7R/81yplhrjqynmvULrBFBSh3
	/s+ONzeHdDgwy/cbFzBFBQ31nHTkq08BDzxVR1Zz1In1kOWimhmyLwElDVmxEYG1NXltG/bbQbVhm
	iD/ks56UZbA92rxOC2FbfiyHD7aDG/6oa2acBR/XlTGqUDLCY2R+u3oba23h3zP0eRvTPjX5ccNEO
	v2/iMUJy6lGNfJm1TcjfnEVR9BdB00QqitnvqMb/1xVKE9rGgnL0mtCWI56WqGDpxeIkpEEso8CpA
	M8bVUgcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0P-00000009XaI-3Eai;
	Fri, 31 May 2024 07:48:53 +0000
Received: from 2a02-8389-2341-5b80-5ba9-f4da-76fa-44a9.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:5ba9:f4da:76fa:44a9] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sCx0N-00000009XXW-22Ka;
	Fri, 31 May 2024 07:48:52 +0000
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
Subject: [PATCH 03/14] rbd: increase io_opt again
Date: Fri, 31 May 2024 09:47:58 +0200
Message-ID: <20240531074837.1648501-4-hch@lst.de>
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

Commit 16d80c54ad42 ("rbd: set io_min, io_opt and discard_granularity to
alloc_size") lowered the io_opt size for rbd from objset_bytes which is
4MB for typical setup to alloc_size which is typically 64KB.

The commit mostly talks about discard behavior and does mention io_min
in passing.  Reducing io_opt means reducing the readahead size, which
seems counter-intuitive given that rbd currently abuses the user
max_sectors setting to actually increase the I/O size.  Switch back
to the old setting to allow larger reads (the readahead size despite it's
name actually limits the size of any buffered read) and to prepare
for using io_opt in the max_sectors calculation and getting drivers out
of the business of overriding the max_user_sectors value.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/rbd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 26ff5cd2bf0abc..46dc487ccc17eb 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -4955,8 +4955,8 @@ static int rbd_init_disk(struct rbd_device *rbd_dev)
 	struct queue_limits lim = {
 		.max_hw_sectors		= objset_bytes >> SECTOR_SHIFT,
 		.max_user_sectors	= objset_bytes >> SECTOR_SHIFT,
+		.io_opt			= objset_bytes,
 		.io_min			= rbd_dev->opts->alloc_size,
-		.io_opt			= rbd_dev->opts->alloc_size,
 		.max_segments		= USHRT_MAX,
 		.max_segment_size	= UINT_MAX,
 	};
-- 
2.43.0


