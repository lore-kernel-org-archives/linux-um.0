Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC990FF885A
	for <linux-um@archiver.kernel.org>; Tue,  5 May 2026 12:44:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2lJxaTnlwk5mlkbPhYJenySUrcGDTpVi4R6jywH/g8c=; b=VUHkh2tNmTJOdyFcF6L7UPADDm
	ofT6PHjmkvrf0SnSSYgBZTKsBOb0PuFTINohOQsWcN6jdN9h8XvjsSrv3dd6Dolb4qg5SeOiqDVMT
	DSeCOn6ppgZktzKlDqPyhZlk16IJW7K7n6Wrt0OyvjrPLFELwA34dnoQM+6sjHmnLHOzbxWbe+w7Q
	TG6CFoYDcdoxR1gtT94Tk1+3Ju0KZwm7RfLdb8VUFcHaproTLqfXRPsqu0pOdvAJspcnV7g8S8um/
	88uhXRsun29Wno4lsVkCcWWUR8AhAVDtSE1qxF3jriaHBLwXPUW7cb37cPpqyN1jgch1Vc+jqh4Wp
	zwn7QWRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKF8D-0000000GDLo-3rJE;
	Tue, 05 May 2026 12:44:09 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wKF8B-0000000GDKk-0xRw
	for linux-um@lists.infradead.org;
	Tue, 05 May 2026 12:44:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=Content-Transfer-Encoding:MIME-Version:
	Message-ID:Date:Subject:Cc:To:From:Content-Type:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-To:Resent-Cc:
	Resent-Message-ID:In-Reply-To:References;
	bh=2lJxaTnlwk5mlkbPhYJenySUrcGDTpVi4R6jywH/g8c=; t=1777985047; x=1779194647; 
	b=sfNjGK6z0PXetp0Ygj2GZa3wkWd62TCduRuaXvYCeS3VM6SFGlE1J1OFhXA3wRxXeTAWXf9Y8Mx
	VQnsfbdljy/2+juQYzTH2PMtNTb1Brc8UK9HnYmW7+W8/6HL/gOSrSlakuzL+GGIRhRV6i04riWEb
	mC/2XeGzfB/wjLL2841qIjpFLzujM0RQDHAfkYF2tMfksOoWXXstzggV1ECHfaWHCJ/3ZHTqcvalz
	dTmJoPYal1C15AoCSREwZMeF6TKclIlMqxtLzpLXp+MkX0JQbQNr0pqBsjgK8/WDeG88a1eHNeFYg
	mr6xHpZL+DzJ7/cK8P8dnqQNredBJFJkeb7w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1wKF84-0000000GBlx-3te9;
	Tue, 05 May 2026 14:44:01 +0200
From: Benjamin Berg <benjamin@sipsolutions.net>
To: linux-um@lists.infradead.org
Cc: Benjamin Berg <benjamin.berg@intel.com>
Subject: [PATCH] um: virtio-pci: free the IRQ message buffers
Date: Tue,  5 May 2026 14:43:18 +0200
Message-ID: <20260505124317.2330700-2-benjamin@sipsolutions.net>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260505_054407_289454_C909C7B5 
X-CRM114-Status: UNSURE (   8.45  )
X-CRM114-Notice: Please train this message.
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

These buffers are allocated when initializing the virtual queues, but
were not freed again. Wrap all of the del_vqs calls to detach and free
the unused buffers before deleting the IRQ VQ.

Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
---
 arch/um/drivers/virtio_pcidev.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/arch/um/drivers/virtio_pcidev.c b/arch/um/drivers/virtio_pcidev.c
index 2bf5a645db45..53cffd373890 100644
--- a/arch/um/drivers/virtio_pcidev.c
+++ b/arch/um/drivers/virtio_pcidev.c
@@ -490,13 +490,24 @@ static int virtio_pcidev_init_vqs(struct virtio_pcidev_device *dev)
 	return 0;
 }
 
+static void virtio_pcidev_del_vqs(struct virtio_device *vdev,
+				  struct virtio_pcidev_device *dev)
+{
+	void *msg;
+
+	while ((msg = virtqueue_detach_unused_buf(dev->irq_vq)))
+		kfree(msg);
+
+	vdev->config->del_vqs(vdev);
+}
+
 static void __virtio_pcidev_virtio_platform_remove(struct virtio_device *vdev,
 						   struct virtio_pcidev_device *dev)
 {
 	um_pci_platform_device_unregister(&dev->pdev);
 
 	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	virtio_pcidev_del_vqs(vdev, dev);
 
 	kfree(dev);
 }
@@ -526,7 +537,7 @@ static int virtio_pcidev_virtio_platform_probe(struct virtio_device *vdev,
 	um_pci_platform_device_unregister(&dev->pdev);
 err_reset:
 	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	virtio_pcidev_del_vqs(vdev, dev);
 err_free:
 	kfree(dev);
 	return err;
@@ -569,7 +580,7 @@ static int virtio_pcidev_virtio_probe(struct virtio_device *vdev)
 
 err_reset:
 	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
+	virtio_pcidev_del_vqs(vdev, dev);
 err_free:
 	kfree(dev);
 	return err;
@@ -591,9 +602,9 @@ static void virtio_pcidev_virtio_remove(struct virtio_device *vdev)
 
 	/* Stop all virtqueues */
 	virtio_reset_device(vdev);
+	virtio_pcidev_del_vqs(vdev, dev);
 	dev->cmd_vq = NULL;
 	dev->irq_vq = NULL;
-	vdev->config->del_vqs(vdev);
 
 	kfree(dev);
 }
-- 
2.54.0


