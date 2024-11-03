Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD2D8D11195
	for <linux-um@archiver.kernel.org>; Sun,  3 Nov 2024 21:30:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MSQlRS+hlcO6bpIgniQJfT4E8HtRjUrSWtJn8gOMItQ=; b=LKXAFg0wdCzCiWbuvlc7xY50XI
	9TxOzfMpgsm4fyrblRSE7mV18EF+bhPn6Ku7QQP+FM6obdfd1gJYbM1X9IZCwoFT+sgOHxQtEoFJ+
	yUx+uhU/K3ZPpsI5IH8KspotUQ5UAUnSPVxauNR0yjBOpKieYu7KPzzHNwnkTMMlHNZ1NkP0Yt/8Y
	lfdpnTatgcuKbHl7sJCSfTvg4FdqgWttesfxfmCbwlejrH7kU6/X4mW0ypsiysrDHc96G0OajkGiS
	ldcv+0B5L5v8sKpkqn4rEnoo9VuRLPkNbkfwKNpgiekSd50ApWEwMCPhW+ODJnzSAFdqIj3SBJPWm
	0WXzneEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBN-0000000C4St-2DjU;
	Sun, 03 Nov 2024 21:30:49 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t7iBK-0000000C4R2-0uMO
	for linux-um@lists.infradead.org;
	Sun, 03 Nov 2024 21:30:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=MSQlRS+hlcO6bpIgniQJfT4E8HtRjUrSWtJn8gOMItQ=;
	t=1730669446; x=1731879046; b=dxoNlmcG+lvPs0oBeWrfRlYkgMZ8ODBYCRy95trkl3jiPgN
	+v+RGFQt1Xr9Ix9dTBNazeZgaXPlIaPGWT5j7wgRQAlW7bAyWDDAPRnFghUrK4pgLM5OHRNKlWOEU
	w/MtcnkTgiYM/btsypR6aQFNSmFdewBlJjVkpk2tLAtfulFTZDvVVladJN+SZGGDCR+x4nTv/RhXB
	dPQVr1UlAdu00WDKIf4wpbhE2AKx9eNDqE6Ahcafitb6Jfs6T/UU99nr4L3EiYukNQvrOuObGNGzX
	ahbcR3vAg1fUfHxjeAt0Xmqq6xiKafL5wuy6jjhuvCKYIBIzdZ88ryKA7jMUVBew==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1t7iBH-0000000DCdx-42mg;
	Sun, 03 Nov 2024 22:30:44 +0100
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/4] um: virtio_uml: fix call_fd IRQ allocation
Date: Sun,  3 Nov 2024 22:28:53 +0100
Message-ID: <20241103212854.1436046-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241103212854.1436046-1-benjamin@sipsolutions.net>
References: <20241103212854.1436046-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241103_133046_283824_33CB84B8 
X-CRM114-Status: GOOD (  13.40  )
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

From: Benjamin Berg <benjamin.berg@intel.com>

If the device does not support slave requests, then the IRQ will not yet
be allocated. So initialize the IRQ to UM_IRQ_ALLOC so that it will be
allocated if none has been assigned yet and store it slightly later when
we know that it will not be immediately unregistered again.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index 2e4b4eadd553..5b19e9a3447a 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -889,7 +889,7 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 {
 	struct virtio_uml_vq_info *info = vq->priv;
 	int call_fds[2];
-	int rc;
+	int rc, irq;
 
 	/* no call FD needed/desired in this case */
 	if (vu_dev->protocol_features &
@@ -906,19 +906,23 @@ static int vu_setup_vq_call_fd(struct virtio_uml_device *vu_dev,
 		return rc;
 
 	info->call_fd = call_fds[0];
-	rc = um_request_irq(vu_dev->irq, info->call_fd, IRQ_READ,
-			    vu_interrupt, IRQF_SHARED, info->name, vq);
-	if (rc < 0)
+	irq = um_request_irq(vu_dev->irq, info->call_fd, IRQ_READ,
+			     vu_interrupt, IRQF_SHARED, info->name, vq);
+	if (irq < 0) {
+		rc = irq;
 		goto close_both;
+	}
 
 	rc = vhost_user_set_vring_call(vu_dev, vq->index, call_fds[1]);
 	if (rc)
 		goto release_irq;
 
+	vu_dev->irq = irq;
+
 	goto out;
 
 release_irq:
-	um_free_irq(vu_dev->irq, vq);
+	um_free_irq(irq, vq);
 close_both:
 	os_close_file(call_fds[0]);
 out:
@@ -1212,6 +1216,7 @@ static int virtio_uml_probe(struct platform_device *pdev)
 	vu_dev->vdev.id.vendor = VIRTIO_DEV_ANY_ID;
 	vu_dev->pdev = pdev;
 	vu_dev->req_fd = -1;
+	vu_dev->irq = UM_IRQ_ALLOC;
 
 	time_travel_propagate_time();
 
-- 
2.47.0


