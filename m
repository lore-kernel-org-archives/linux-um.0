Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A830C021AD
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 22:11:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lKUUc5XrJmahddA421iPxbE7JK1Oq9aYb9aZvyO+kwc=; b=zSWtlCeVNoHkVHnFSPyxLpxjSa
	zdHhLWTW60gt7KIt4WVgxZKMPNzcIwiy5t89umirOlB93ognR8E/L3gx3iAxO8z0fRzYw9BmcVxFv
	5opSbv36CxGcNElg/dX+nOarTWD0bzyz5ThR5H4WhC+eHun+GmC9F9h+LZYFI4PWWI/Z9/WOrrotO
	j8wJxbK5RB36lJ+RkTJuEV7NankJyBTAf01vOXQNb9eLMOQRqAO061fIk1P+uinNazms4ma6U3rZA
	hXJUTIG3/qw6jGIjqGaIGC3iYAcGDUexYnIlDGOx2EkbBDnFrPDCaNSX/qgY7CjX6CLuGgkgnfdZ2
	Y3MqbxSA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkVo4-0000000A6d6-1wqz;
	Tue, 18 Feb 2025 22:11:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkUD0-00000009lss-0Z4T
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 20:28:47 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4DE865C065B;
	Tue, 18 Feb 2025 20:28:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD16C4CEE2;
	Tue, 18 Feb 2025 20:28:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739910525;
	bh=sYERlul87AXhhSQUHbZpMDP0T12IZn5GGQDnr+ED6cU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DoF8Y1MAR39I9V6124/vkaOUXVJHls8JZtJyCOyezRSCNXkrXR/644cpOk72X2xIr
	 1zeXafp6uZ0aLm4+830RGIfVvsHPX/SKx7jhVACCXXR7AR62ajwLksx7ueYP5gxhUf
	 UBXnb7HqNDriLJXylxWzCj6+LWbzkNHhl+8e1Bp6T7Ycv+DF5BgTuo4YI2eijMOfRL
	 tOeJp3wra+/GsZFf6kcYnyqHpIyEUGOQCVQ7FwPITDpF2+3fkvgs6s2oafpDNU8xNU
	 Zb0oe8wALh0Augan2sykYaSD5Fdx0gdRXW6MFbMpdXaacWxNyQzWgeaE+YmvA8YNkE
	 6Y/KvnijCDl1Q==
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
	jiri@resnulli.us,
	tiwei.btw@antgroup.com,
	u.kleine-koenig@pengutronix.de,
	linux-um@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 12/13] um: virtio_uml: use raw spinlock
Date: Tue, 18 Feb 2025 15:28:16 -0500
Message-Id: <20250218202819.3593598-12-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250218202819.3593598-1-sashal@kernel.org>
References: <20250218202819.3593598-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.128
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_122846_232115_A65B2FDD 
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
index ddd080f6dd82e..64e8cd59014fb 100644
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


