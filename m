Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 500A6C021AF
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w7Iuwqlzn/2Em3pIlVjWMLbVU7KKowHlqCMiMxEZjcI=; b=NFGNLnsbDqokyCYYZsvjoxeiTW
	ycy1/I2BkJVCkI2rSUmLRMcaaiV535CbZ0Mh5BqXBiIDozx5FInEkR/FHxD5DAtgjbhutzAxRLd62
	bgVJfuOFAnLiJbOkL2fWC6hmZrYg6thKgZy4GLuQy6xShoyUk7O63d/WETXfW5jl7h0ycjBmU0uXU
	MrIxk2Gjg4Nq5JocX6bDPBrRSHf7zBTyUljG7w4jIEZn6R2s9dAX5ewrkO5lMoAusmrVvuZ0Pqh3S
	Ifji2GuOF84lnPe9GJk7tVuMMa25uBe+xrfMK7diTdVFyJ7+YZj++NrrH/4bdP8yHIP1HFHg5g1DO
	99G3/kpw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkVo4-0000000A6dJ-3EeM;
	Tue, 18 Feb 2025 22:11:08 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkUDG-00000009lw1-2csW
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 20:29:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1997DA41B00;
	Tue, 18 Feb 2025 20:27:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D69AC4CEE2;
	Tue, 18 Feb 2025 20:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910541;
	bh=+MCfZ3PiDMVDawojJv/00MM2ynUpq/aZUXJ5oFf0hjA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cn2Z3Rz7G6VRtNkX5E7uHB+MHQZ/eOVcZbsOH7xYJ4dhUvoTVARYw6X1HlcVDYbLK
	 Rrxp59OYk8DjkiNv8oztr+XXRACMb+2+okIXUwEE5Ys3zPJgdwHZgI/QmOc3t2NyrM
	 n1LvRgNKLQIh9AQlHcD3nTiVT6Lkqx36E2SvxK1FBFcwlI8S9xFRG4BpTjN9Hj5Byz
	 AGd97Jph6NeuYvr37dK4PTxf7eG+HYdgc2cZve6uJc4tzIsCMGPqOSqJwa9sV2AO5x
	 M2vRIkjHXJoXCUfPXQXa3soktoThnKPWMWMZP02aFFdbugemKe2nEHKGO2V5nUCrQC
	 GVDQ1FOrhgWJA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Johannes Berg <johannes.berg@intel.com>,
	Richard Weinberger <richard@nod.at>,
	Sasha Levin <sashal@kernel.org>,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net,
	benjamin.berg@intel.com,
	mst@redhat.com,
	tiwei.btw@antgroup.com,
	jiri@resnulli.us,
	u.kleine-koenig@pengutronix.de,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 6/6] um: virtio_uml: use raw spinlock
Date: Tue, 18 Feb 2025 15:28:47 -0500
Message-Id: <20250218202848.3593863-6-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202848.3593863-1-sashal@kernel.org>
References: <20250218202848.3593863-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.178
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_122902_728707_516DC5E9 
X-CRM114-Status: GOOD (  10.67  )
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
index 204e9dfbff1a0..19fe003932f71 100644
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
 
@@ -1214,7 +1214,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 		goto error_free;
 	vu_dev->sock = rc;
 
-	spin_lock_init(&vu_dev->sock_lock);
+	raw_spin_lock_init(&vu_dev->sock_lock);
 
 	rc = vhost_user_init(vu_dev);
 	if (rc)
-- 
2.39.5


