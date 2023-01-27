Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1769C54EAA
	for <linux-um@archiver.kernel.org>; Fri, 27 Jan 2023 14:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:MIME-Version:Subject:
	Date:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=3raC9BcOaM/d3XpBAspXQYvjYFEHSXApF508qo9k+Hk=; b=Or1hPT2UTN2EtZ
	dxeMXyUrd0xMjIEtynBGv4fW3c2oileujoMwnzIzc0KAt2nBjxJOIP4EvdSjGfI5yTUiBzTPNDwg/
	QndiTemXcD4FRDh4Byvqu7xaxh4UcTpimUtVonrMfQNDM9wkhNRfjkEhmugcRqN1O9XGA084cH5oJ
	J1O8DtTtqB3FIaz1rdW85r52pjzQVu7nP99pFTe05CRDklttpOxJZ+7ke/BhWgWBXmAhsjtDGM1Lh
	efm70c9EC7qynQK4+TVVkGfIdBk8IoLIOUAuEmr7Y1J+OzemCWUDEI8i9QRTJuseSY5+vThVjlgQK
	6J3ZLCWR7CHB7BGoHptQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLPkZ-00FItH-Ox; Fri, 27 Jan 2023 14:30:43 +0000
Received: from smtp1.axis.com ([195.60.68.17])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLPkV-00FIqd-FE
	for linux-um@lists.infradead.org; Fri, 27 Jan 2023 14:30:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1674829839;
  x=1706365839;
  h=from:date:subject:mime-version:content-transfer-encoding:
   message-id:to:cc;
  bh=RL1TVR8JpwDGXzhk2Xp/sjq8b+rwzvFYVEYMjlPcCWk=;
  b=AwW3F+gJKHFGLKmwzmhze+VrT2g+hVpk1MWbbK3FrRUyXvBevgqS3zfI
   XOE1rIu4g83sPmXtmwGINh+CLfYRFrxhzDnPUWvNTUfoLwJmeZ5+uAS09
   GzXGSFNTBnTov66aLbV9Jzifva1Ya9teqlGHovdT8trQ/qUWpn98z49kV
   Avdk0PLD2XjY5Nu8dlNfsyb8yuR/tWasuX1GxJbdzuZkfbIL3xKdYblnA
   bs2TByPlEEMIQa3yCTRarilcq1umM08xevCWsdD4XZUQuQmOiwL6TzW7N
   X4baZXnawUUpnZUOUCgHOOEtKy2gWBX/nS3O1MysKXh+6fqSbu1ZrEOV0
   g==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
Date: Fri, 27 Jan 2023 15:30:27 +0100
Subject: [PATCH] virt-pci: add platform bus support
MIME-Version: 1.0
Message-ID: <20230127-uml-pci-platform-v1-1-ec6b45d2829f@axis.com>
X-B4-Tracking: v=1; b=H4sIAALg02MC/x2NQQqDMBAAvyJ77kKSIkq/UnrYxE1dMDFsbCmIf
 zf2OAPD7FBZhSs8uh2Uv1JlzQ3srYMwU34zytQYnHF3Y92An7RgCYJloS2umpDj2FtPQx9HAy3
 zVBm9Ug7zFW6pXLYoR/n9R8/XcZyN11SoeAAAAA==
To: Richard Weinberger <richard@nod.at>, Anton Ivanov
	<anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>
CC: <robh@kernel.org>, <devicetree@lists.infradead.org>,
	<linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	<kernel@axis.com>, Vincent Whitchurch <vincent.whitchurch@axis.com>
X-Mailer: b4 0.12.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230127_063040_188577_EA7BE0EC 
X-CRM114-Status: GOOD (  17.99  )
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

This driver registers PCI busses, but the underlying virtio protocol
could just as easily be used to provide a platform bus instead.  If the
virtio device node in the devicetree indicates that it's compatible with
simple-bus, register platform devices instead of handling it as a PCI
bus.

Only one platform bus is allowed and the logic MMIO region for the
platform bus is placed at an arbitrarily-chosen address away from the
PCI region.

Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
---
My first approach to getting platform drivers working on UML was by
adding a minimal PCI-to-platform bridge driver, which worked without
modifications to virt-pci, but that got shot down:

 https://lore.kernel.org/lkml/20230120-simple-mfd-pci-v1-1-c46b3d6601ef@axis.com/
---
 arch/um/drivers/virt-pci.c | 91 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 91 insertions(+)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 3ac220dafec4..0ff69d6ad253 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -8,6 +8,7 @@
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/logic_iomem.h>
+#include <linux/of_platform.h>
 #include <linux/irqdomain.h>
 #include <linux/virtio_pcidev.h>
 #include <linux/virtio-uml.h>
@@ -39,6 +40,8 @@ struct um_pci_device {
 	unsigned long status;
 
 	int irq;
+
+	bool platform;
 };
 
 struct um_pci_device_reg {
@@ -48,6 +51,7 @@ struct um_pci_device_reg {
 
 static struct pci_host_bridge *bridge;
 static DEFINE_MUTEX(um_pci_mtx);
+static struct um_pci_device *um_pci_platform_device;
 static struct um_pci_device_reg um_pci_devices[MAX_DEVICES];
 static struct fwnode_handle *um_pci_fwnode;
 static struct irq_domain *um_pci_inner_domain;
@@ -480,6 +484,9 @@ static void um_pci_handle_irq_message(struct virtqueue *vq,
 	struct virtio_device *vdev = vq->vdev;
 	struct um_pci_device *dev = vdev->priv;
 
+	if (!dev->irq)
+		return;
+
 	/* we should properly chain interrupts, but on ARCH=um we don't care */
 
 	switch (msg->op) {
@@ -561,6 +568,55 @@ static int um_pci_init_vqs(struct um_pci_device *dev)
 	return 0;
 }
 
+static void __um_pci_virtio_platform_remove(struct virtio_device *vdev,
+					    struct um_pci_device *dev)
+{
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+
+	mutex_lock(&um_pci_mtx);
+	um_pci_platform_device = NULL;
+	mutex_unlock(&um_pci_mtx);
+
+	kfree(dev);
+}
+
+static int um_pci_virtio_platform_probe(struct virtio_device *vdev,
+					struct um_pci_device *dev)
+{
+	int ret;
+
+	dev->platform = true;
+
+	mutex_lock(&um_pci_mtx);
+
+	if (um_pci_platform_device) {
+		mutex_unlock(&um_pci_mtx);
+		ret = -EBUSY;
+		goto out_free;
+	}
+
+	ret = um_pci_init_vqs(dev);
+	if (ret) {
+		mutex_unlock(&um_pci_mtx);
+		goto out_free;
+	}
+
+	um_pci_platform_device = dev;
+
+	mutex_unlock(&um_pci_mtx);
+
+	ret = of_platform_default_populate(vdev->dev.of_node, NULL, &vdev->dev);
+	if (ret)
+		__um_pci_virtio_platform_remove(vdev, dev);
+
+	return ret;
+
+out_free:
+	kfree(dev);
+	return ret;
+}
+
 static int um_pci_virtio_probe(struct virtio_device *vdev)
 {
 	struct um_pci_device *dev;
@@ -574,6 +630,9 @@ static int um_pci_virtio_probe(struct virtio_device *vdev)
 	dev->vdev = vdev;
 	vdev->priv = dev;
 
+	if (of_device_is_compatible(vdev->dev.of_node, "simple-bus"))
+		return um_pci_virtio_platform_probe(vdev, dev);
+
 	mutex_lock(&um_pci_mtx);
 	for (i = 0; i < MAX_DEVICES; i++) {
 		if (um_pci_devices[i].dev)
@@ -623,6 +682,12 @@ static void um_pci_virtio_remove(struct virtio_device *vdev)
 	struct um_pci_device *dev = vdev->priv;
 	int i;
 
+	if (dev->platform) {
+		of_platform_depopulate(&vdev->dev);
+		__um_pci_virtio_platform_remove(vdev, dev);
+		return;
+	}
+
         /* Stop all virtqueues */
         virtio_reset_device(vdev);
         vdev->config->del_vqs(vdev);
@@ -860,6 +925,30 @@ void *pci_root_bus_fwnode(struct pci_bus *bus)
 	return um_pci_fwnode;
 }
 
+static long um_pci_map_platform(unsigned long offset, size_t size,
+				const struct logic_iomem_ops **ops,
+				void **priv)
+{
+	if (!um_pci_platform_device)
+		return -ENOENT;
+
+	*ops = &um_pci_device_bar_ops;
+	*priv = &um_pci_platform_device->resptr[0];
+
+	return 0;
+}
+
+static const struct logic_iomem_region_ops um_pci_platform_ops = {
+	.map = um_pci_map_platform,
+};
+
+static struct resource virt_platform_resource = {
+	.name = "platform",
+	.start = 0x10000000,
+	.end = 0x1fffffff,
+	.flags = IORESOURCE_MEM,
+};
+
 static int __init um_pci_init(void)
 {
 	int err, i;
@@ -868,6 +957,8 @@ static int __init um_pci_init(void)
 				       &um_pci_cfgspace_ops));
 	WARN_ON(logic_iomem_add_region(&virt_iomem_resource,
 				       &um_pci_iomem_ops));
+	WARN_ON(logic_iomem_add_region(&virt_platform_resource,
+				       &um_pci_platform_ops));
 
 	if (WARN(CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID < 0,
 		 "No virtio device ID configured for PCI - no PCI support\n"))

---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230127-uml-pci-platform-ef851ba75f80

Best regards,
-- 
Vincent Whitchurch <vincent.whitchurch@axis.com>


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
