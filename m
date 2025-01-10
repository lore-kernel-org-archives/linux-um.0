Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F4CC02184
	for <linux-um@archiver.kernel.org>; Fri, 10 Jan 2025 13:13:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S56GsRBFDZ2Dv0NEvtWPZ2gxzfO06DPYc7OAVheL4W0=; b=WY7E8qwfQB22rVpIOg7s5vWCbR
	OxhhZaGw4Rr22VHejgJ+JafDVARnpx1MCtrSEf3m+bh718IzGEI/DCyM7yFaeD13KDCD3XjP73A/3
	BU1NJIiWKptaN/SEiLgTq0+8UTOPNgqHZ+d/LRYDxzLMnsONFpmGm8ZeM/C6upVAZ8Cr6Q63rKcTb
	Ir8xHqt4m1hpDp2u5u2RB0dOJNYpjg4/hBWH/K7N65b4sYDiNSiaz1fxTKfXaCIjuUOq+1Qb+eaQu
	Dx4E0txBJD+mD2C4KWFFviGw1dh7npK+JdOxOi3jD4BKvblNvcN0edSg8cBbFy1ozWkrWLLSfOsbV
	aKKaijvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWEpn-0000000FQhC-2mTQ;
	Fri, 10 Jan 2025 13:13:55 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWEYQ-0000000FMj2-3Q6q
	for linux-um@lists.infradead.org;
	Fri, 10 Jan 2025 12:56:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=S56GsRBFDZ2Dv0NEvtWPZ2gxzfO06DPYc7OAVheL4W0=;
	t=1736513757; x=1737723357; b=nxU0OLhuz5EsvekT+OhdYusx7bggQvNNhu7rg2M63mpdbk4
	9/9LZvnrlzIbS+51ROzOWvFHs9igGWhuAAES46eLKrUyblHmtv5wgdOW+yUxoNngfF4F8h/UuzdyK
	nDOCQH0041n9Rfw3Y9JFKHAwoAR0gM0ymc/VyAhhNW9zczUrwltECNWHlBGP9Uuik7Niorti+8dxQ
	p+/c6eAQCUty0PKDST+CL73JTP+Zl3wo7IS8dQvciII9z/Ot5wn1ldblyZx7xiVpkJTwTV0Z9Qeib
	+K0HnukqtdTHX+vNvLUj+/JiT7RL45QXw7tELGZzDojdS9SYHQTvdJtrFqL4CSYg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tWEYM-0000000Aaru-2sqh;
	Fri, 10 Jan 2025 13:55:54 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 2/3] um: virtio_uml: use raw spinlock
Date: Fri, 10 Jan 2025 13:54:05 +0100
Message-ID: <20250110125550.32479-7-johannes@sipsolutions.net>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250110125550.32479-5-johannes@sipsolutions.net>
References: <20250110125550.32479-5-johannes@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_045558_863352_7D4D542D 
X-CRM114-Status: GOOD (  11.08  )
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

This is needed because at least in time-travel the code
can be called directly from the deep architecture and
IRQ handling code.

Signed-off-by: Johannes Berg <johannes.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 65df43fa9be5..ad8d78fb1d9a 100644
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
@@ -246,7 +246,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	if (request_ack)
 		msg->header.flags |= VHOST_USER_FLAG_NEED_REPLY;
 
-	spin_lock_irqsave(&vu_dev->sock_lock, flags);
+	raw_spin_lock_irqsave(&vu_dev->sock_lock, flags);
 	rc = full_sendmsg_fds(vu_dev->sock, msg, size, fds, num_fds);
 	if (rc < 0)
 		goto out;
@@ -266,7 +266,7 @@ static int vhost_user_send(struct virtio_uml_device *vu_dev,
 	}
 
 out:
-	spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
+	raw_spin_unlock_irqrestore(&vu_dev->sock_lock, flags);
 	return rc;
 }
 
@@ -1239,7 +1239,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 		goto error_free;
 	vu_dev->sock = rc;
 
-	spin_lock_init(&vu_dev->sock_lock);
+	raw_spin_lock_init(&vu_dev->sock_lock);
 
 	rc = vhost_user_init(vu_dev);
 	if (rc)
-- 
2.47.1


