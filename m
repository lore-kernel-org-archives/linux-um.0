Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BECEAC021AD
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 20:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7KQTsFjf2zj1U6tFUpUXJf8xEOKu9oYt8bueTaJ/d9c=; b=4SGcbJsn4Ddkd+Kpa80yWzJn/Q
	qXV+uNeAZw3+ISVj+cMONz9JwhEftc2pvyYKEV3pvRnuS/CFU7MK/s1eXgp1QqMH3KoBL++2l4vcn
	DQYtU2XzzN6V1QQWl6pR0akE8G+FesCkeFyt3u8KjgDIbokJVRl2vH9zuHF2ojy6GZNeiQzURKB+p
	eJqtv7alL/n7qjh6xW7zc/fDX3GQ+LSClP65WedMup4ACmoUmOvujcBzxQXW+Sx0/6ybyKK14tgpT
	vjAbySDS/4+GMWZ7HCwYOLYQycsY4fPiy4tqFBZTa7JCG8H6qp7YsNINW/9J3qCx4d6JAdRmBPaCQ
	yX7x2SNA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkUdx-00000009t5T-20ZX;
	Tue, 18 Feb 2025 20:56:37 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkUA1-00000009ksn-1QGA
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 20:25:42 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 83E4A5C6194;
	Tue, 18 Feb 2025 20:25:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC4BC4CEE4;
	Tue, 18 Feb 2025 20:25:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910340;
	bh=ipAIJe/cD23BYEy/ee0ricZfs49Uy6vVbjyTxyzQdN0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=H2RJjHKtx/YnetTitxmJYu7zy95zKHDHO/tN02HXhBhjS35ilr4uZXQm3wemHqP7M
	 yWF76NUjjTeJCkPd5mVrH33murJjy6qzG33zpimq5bICDatqWNGg1pqQGFoQ5aqBgH
	 BpCR1pOUfp6hYC5/LXQEiung5ZfJ9/GqsbAUqK2AdEu+HqhswECr4gqMQaPWiExRiy
	 EI0Nag1TRQR2Z5mBYHBCmkmp9+qZ9Z3cAy69YqLATFHxgQp3O/2UsRmStayDqst0Jv
	 2CDLLtR4oBAAnBmDl8JGJ0YEqPxpBgcb9OTUyLM7ixlpRBwyI7YuqXGna/MwnQ+YZV
	 DGUbGc/uj3+OA==
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
Subject: [PATCH AUTOSEL 6.13 22/31] um: virtio_uml: use raw spinlock
Date: Tue, 18 Feb 2025 15:24:42 -0500
Message-Id: <20250218202455.3592096-22-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202455.3592096-1-sashal@kernel.org>
References: <20250218202455.3592096-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.13.3
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_122541_432501_B45C83B9 
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
index 65df43fa9be58..ad8d78fb1d9aa 100644
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
2.39.5


