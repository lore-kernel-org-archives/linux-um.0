Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21E45C61DA4
	for <linux-um@archiver.kernel.org>; Thu,  9 Feb 2023 09:00:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nF2l7VtLDU4qZ/Cn+XwvSzNDkXM59Fdl3XX0P2YyGX4=; b=sqi9bla88Hna4a
	tvskd3LbcaAIPdVK6cOuPxwc3/uWjdi10uTpASv2Xagighb0EvV3R0jnCBisNBvfIqlqzM0+t/oGA
	BvfztmMwnSgUa3E3WMjbAZ6WhQjDbcTnxyH8lPHXwKghSIb42IXI8M4+Sy1CwSR5DtT1JLdKw2BUd
	E/RA7Mv7LLNqIWIYYkaXcERqqqm2jOCZw7y0tyhyRHuETDW0ajImO5756XBJ3x70z15YqaroWSOXc
	SYzzhtIa8ohv1JwOuvQWzc1OA9Nl0VMstrCv5oLlG8hET9T3WrmmBYO1ynYBVnnUA9yDaP9V3Gx2v
	S1MCAf4XSZiSKMJKCQDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ2nA-000dtW-Fv; Thu, 09 Feb 2023 09:00:32 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ2n6-000doR-19
	for linux-um@lists.infradead.org; Thu, 09 Feb 2023 09:00:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=3sC9+NQKQWVvkQvvt3vI0KRiFPjfu11m4H3DBC4jfcw=;
	t=1675933223; x=1677142823; b=MhLXCTfTkqaWZBAtxCYZl26KZh7RiRIVnB1mAi7KRfb4b5K
	I84HB7jpTxCgt2pB1LLrQ9x0RH2Bkmx2B6IUdv+QTNlcUK33FKP84ocqkRYQGmJHY2AiH9MmWdSGe
	2/ubg16+FOUVKG5lHizJYVo/GN0PxGCyxN4z6cpTGuT5y8EWT6XaDH03VZaHWvdGXhWXBICNfae/C
	9JGgbzB4mB5Q46Ti52WZslXLBCqpby+Qz9WZX/Pfk1lHzgOS6wXFZnLIAFhpK74+J8Sr/7EBEvOdl
	ahh1y8i9g6480zy8C02JWr7MI/QEOu+CRydFUQYVer616zRAMQPq+czUwvUWzTZw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1pQ2my-007K0c-0k;
	Thu, 09 Feb 2023 10:00:20 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 3/4] um: virtio_uml: move device breaking into workqueue
Date: Thu,  9 Feb 2023 10:00:04 +0100
Message-Id: <20230209090005.1559828-3-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209090005.1559828-1-benjamin@sipsolutions.net>
References: <20230209090005.1559828-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_010028_117331_34749F8A 
X-CRM114-Status: GOOD (  12.13  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

From: Benjamin Berg <benjamin.berg@intel.com>

We should not be calling virtio_break_device from an IRQ context.
Move breaking the device into the workqueue so that it is done from
a reasonable context.

Change-Id: I4f5f075d7f40ed050c08a7435c1cf45e2387022c
Fixes: af9fb41ed315 ("um: virtio_uml: Fix broken device handling in time-travel")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/virtio_uml.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index dcfd0ca534ee..ddd080f6dd82 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -170,7 +170,6 @@ static void vhost_user_check_reset(struct virtio_uml_device *vu_dev,
 
 	vu_dev->registered = 0;
 
-	virtio_break_device(&vu_dev->vdev);
 	schedule_work(&pdata->conn_broken_wk);
 }
 
@@ -1138,6 +1137,15 @@ void virtio_uml_set_no_vq_suspend(struct virtio_device *vdev,
 
 static void vu_of_conn_broken(struct work_struct *wk)
 {
+	struct virtio_uml_platform_data *pdata;
+	struct virtio_uml_device *vu_dev;
+
+	pdata = container_of(wk, struct virtio_uml_platform_data, conn_broken_wk);
+
+	vu_dev = platform_get_drvdata(pdata->pdev);
+
+	virtio_break_device(&vu_dev->vdev);
+
 	/*
 	 * We can't remove the device from the devicetree so the only thing we
 	 * can do is warn.
@@ -1268,8 +1276,14 @@ static int vu_unregister_cmdline_device(struct device *dev, void *data)
 static void vu_conn_broken(struct work_struct *wk)
 {
 	struct virtio_uml_platform_data *pdata;
+	struct virtio_uml_device *vu_dev;
 
 	pdata = container_of(wk, struct virtio_uml_platform_data, conn_broken_wk);
+
+	vu_dev = platform_get_drvdata(pdata->pdev);
+
+	virtio_break_device(&vu_dev->vdev);
+
 	vu_unregister_cmdline_device(&pdata->pdev->dev, NULL);
 }
 
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
