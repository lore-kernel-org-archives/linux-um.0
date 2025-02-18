Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 423B4C021B1
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tWZCxdS10lFqC5XMH9hiXu0Z3/LKsVH7k4SX8xwnoMo=; b=XbSvbeeH9ytiFGMZTAO5VAhZoQ
	vjKCaiZuKuB+62Dq9HUn0AZQSuB9PJ5teRy2Ewpxs75Dg5Ioy2xYBecFfUFEkIfPwde6w1lnApW0X
	/xrdmK2Q21fsl9kLEQJcsGhO4rKV9AgQ28+TiV81lLqJeOG7Ow1koL9pNFYF4+oJXjtXAlwl4VL1F
	OP5h9EUd/mCUqtETontU/HjtEYppTCaXuD6a4/0yPIYCcSN7MPmKeK3gABuO+Z07682cGkllelnNK
	ofzdW9jPwBjlyZpk0zh56Zf9PjVlKAESQiB2wvQxqDnQgRax/ViDpV9Ro+LUI8RFMxJlF/bjSR/QV
	AX1O09zQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkVo3-0000000A6cn-3gPN;
	Tue, 18 Feb 2025 22:11:07 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkUCV-00000009lgO-2KLU
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 20:28:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 084E1A41B7D;
	Tue, 18 Feb 2025 20:26:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52793C4CEE2;
	Tue, 18 Feb 2025 20:28:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910494;
	bh=VAaHtQogXFI6AWVVI5hzOC+YB4VvcvUJ/rY8FZFCQbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FRm/5Je5TmibJ+UrPEeJ3SDefLdOdO00LbCVTlI2jMpLRwhdOtj4CWC5RlFWNXA6U
	 omp+CcX4NpKDffuFTbj/QFzq9NrXzTqGguXUiBxObWN6i1ThlI0wqDlvT2NRKmgmgE
	 8E2t5hivfb1gtvvlf7NsDX//pPYbUIkxp8GNHCTiAu0N025qsAb7xBczI0Mvenwk7i
	 rcRZJA2VSI/ADqT0AAF5ap+s6nt3tViF6PtQ+UUFMnvKwY4r++UH7TsgtPbz2BRI6a
	 duwxYptEYTdoZKxwA/nZ/AwNGTThXsu0UgHo05nLqNL6FLkThDASXyrt4ODxt/GEU4
	 QRSIMKpj/xdlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	jiri@resnulli.us,
	tiwei.btw@antgroup.com,
	u.kleine-koenig@pengutronix.de,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/17] um: virtio_uml: use raw spinlock
Date: Tue, 18 Feb 2025 15:27:39 -0500
Message-Id: <20250218202743.3593296-15-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202743.3593296-1-sashal@kernel.org>
References: <20250218202743.3593296-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.78
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_122815_666334_D7DB2B4D 
X-CRM114-Status: GOOD (  10.77  )
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

From: Johannes Berg <johannes.berg@intel.com>

[ Upstream commit daa1a05ba431540097ec925d4e01d53ef29a98f1 ]

This is needed because at least in time-travel the code
can be called directly from the deep architecture and
IRQ handling code.

Link: https://patch.msgid.link/20250110125550.32479-7-johannes@sipsolutions.net
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Richard Weinberger <richard@nod.at>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/um/drivers/virtio_uml.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 8adca2000e519..7e46c6abbc3fb 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -52,7 +52,7 @@ struct virtio_uml_device {
 	struct platform_device *pdev;
 	struct virtio_uml_platform_data *pdata;
 
-	spinlock_t sock_lock;
+	raw_spinlock_t sock_lock;
 	int sock, req_fd, irq;
 	u64 features;
 	u64 protocol_features;
@@ -247,7 +247,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	if (request_ack)
 		msg->header.flags |= VHOST_USER_FLAG_NEED_REPLY;
 
-	spin_lock_irqsave(&vu_dev->sock_lock, flags);
+	raw_spin_lock_irqsave(&vu_dev->sock_lock, flags);
 	rc = full_sendmsg_fds(vu_dev->sock, msg, size, fds, num_fds);
 	if (rc < 0)
 		goto out;
@@ -267,7 +267,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	}
 
 out:
-	spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
+	raw_spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
 	return rc;
 }
 
@@ -1218,7 +1218,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 		goto error_free;
 	vu_dev->sock = rc;
 
-	spin_lock_init(&vu_dev->sock_lock);
+	raw_spin_lock_init(&vu_dev->sock_lock);
 
 	rc = vhost_user_init(vu_dev);
 	if (rc)
-- 
2.39.5


