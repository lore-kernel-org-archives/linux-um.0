Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61310C636D4
	for <linux-um@archiver.kernel.org>; Thu,  9 Feb 2023 09:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1kYKhGcS9E4yX+8N05YpBcSyDMbHInAvoWqn+FwzbkI=; b=trvygGU5Z4JIkG
	Q/JK9j4UtD7i6SvkypAMbvCIeMRIy3KuC16YD7ejUJLV+DtNylT4XkTEtyPeVPDB1DJLmT1rrz/41
	uqIf62pczks4RvCWjtuR1G9x5xgHz03Ajicg4PfCrO8Nwex98uKET9LhODrBbpByNqdufG9qj9Bos
	UHs5IeTzZ6gMqd23hZoJnVlkHe1Zg33F48QvV8SmN/RjRCAz6PklcpY6ivuUCl2Jj0g9LqBm/cBLA
	JnsK8pDSKD/F/MeTCKrOnzVYGohYmSsTKrTW3VikYbECIhnz/6Z5TsMGbwEecf7SXF9NH3fwUj0pX
	t+UwhtLVNuMJuCdNp9MQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ2n9-000dt0-6g; Thu, 09 Feb 2023 09:00:31 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQ2n5-000doQ-SF
	for linux-um@lists.infradead.org; Thu, 09 Feb 2023 09:00:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Content-Type:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=OlkM+cxDEcbBY1wbZdA8L8mWTrMwWaj5ECMeEaYL3Rk=;
	t=1675933223; x=1677142823; b=jIJvzriX5n2MMNXirlkAetL68VxoLliu6J6uGcy5clZoEhn
	6vGFEUgKOWiOFU3RH7epDuvP11U2E4oumv1WRJUDQKNOdvttZiTQO23WJdsqAMi7Vq8lVKGsgYxJN
	OkjLhtZ32bOC6TbCGygZiAdyyjVTXas0pq/jQvdeKNS0WlTo+FW9618JCWWNVQp1tzbV2REw7p+FI
	f3kh3GgnZP6GhLjNYzlQduGOjQQrHKoUbNSfmheRkG1MwAY3YKXQ3tKsPcty5PAz4rJtQj5cyWwZr
	l8LAOgZcnOJDxZLn2hO1YFqGO79/5BVdu1SC6J15/nYXQlR+CHBUpkPQr9DxHfnA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1pQ2my-007K0c-1k;
	Thu, 09 Feb 2023 10:00:20 +0100
From: benjamin@sipsolutions.net
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH 4/4] um: virt-pci: properly remove PCI device from bus
Date: Thu,  9 Feb 2023 10:00:05 +0100
Message-Id: <20230209090005.1559828-4-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.39.1
In-Reply-To: <20230209090005.1559828-1-benjamin@sipsolutions.net>
References: <20230209090005.1559828-1-benjamin@sipsolutions.net>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_010027_932633_47B887F0 
X-CRM114-Status: GOOD (  13.13  )
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

Triggering a bus rescan will not cause the PCI device to be removed. It
is required to explicitly stop and remove the device from the bus.

Change-Id: Ie51a08cde45e829fd68fe7d7ebaa0bd9e1c06c6e
Fixes: 68f5d3f3b654 ("um: add PCI over virtio emulation driver")
Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/virt-pci.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3b637ad75ec8..5472b1a0a039 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -626,22 +626,33 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
 	struct um_pci_device *dev = vdev->priv;
 	int i;
 
-        /* Stop all virtqueues */
-        virtio_reset_device(vdev);
-        vdev->config->del_vqs(vdev);
-
 	device_set_wakeup_enable(&vdev->dev, false);
 
 	mutex_lock(&um_pci_mtx);
 	for (i = 0; i < MAX_DEVICES; i++) {
 		if (um_pci_devices[i].dev != dev)
 			continue;
+
 		um_pci_devices[i].dev = NULL;
 		irq_free_desc(dev->irq);
+
+		break;
 	}
 	mutex_unlock(&um_pci_mtx);
 
-	um_pci_rescan();
+	if (i < MAX_DEVICES) {
+		struct pci_dev *pci_dev;
+
+		pci_dev = pci_get_slot(bridge->bus, i);
+		if (pci_dev)
+			pci_stop_and_remove_bus_device_locked(pci_dev);
+	}
+
+	/* Stop all virtqueues */
+	virtio_reset_device(vdev);
+	dev->cmd_vq = NULL;
+	dev->irq_vq = NULL;
+	vdev->config->del_vqs(vdev);
 
 	kfree(dev);
 }
-- 
2.39.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
