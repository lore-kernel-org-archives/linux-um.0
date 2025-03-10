Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C699DC2BA1B
	for <linux-um@archiver.kernel.org>; Mon, 10 Mar 2025 07:43:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xL96vBX1FAZ486BADfZdwybMpXTOWKB1EeLr7E6bT6o=; b=S4DiAuYlJLb6uSHAhjleuRAdWj
	FwqduIapUYSVR23G6IMmNW7TP95Z/rJM9efPMgT0IPqOkDlXFkEvTXPsmj3Tqf5JewH2bn8W2YBA2
	LhkgeyoQmdrV56I5C1D2I6HCCZAo7A8RDVaKcwpMALGobe6YpYp803D0XUKwnqFcMUxMWVWmDIk07
	mT4upQZ8CsjvWBXl1kKmc0+47YrHuyaVf1RSfbF+8yBDTS5xFYZfVKckFmizUI1VptYoWM/tKHfIo
	NUxMkaLBnimetT+RYVrtL2mzmgoxVZycC/0KDrRbixYISnrDbGCNm7OkjL4Zd1+rWL30aMiJ4F+SB
	crjUNKNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trXnk-00000001mwp-2A6n;
	Mon, 10 Mar 2025 07:43:52 +0000
Received: from out0-202.mail.aliyun.com ([140.205.0.202])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trXlC-00000001mXI-2aDR
	for linux-um@lists.infradead.org;
	Mon, 10 Mar 2025 07:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1741592468; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xL96vBX1FAZ486BADfZdwybMpXTOWKB1EeLr7E6bT6o=;
	b=2R6S1oQLjwUA96DX2ZbqDtb+3tChSZcQkN+yTgZp3CBkTBpdkYEc4qFHE0LMq50wrMjzRDozY2nrAjE3tSJwJo4hBYlA+AniSGQkrtI/XsxCIQlajzTLKv6XgjxZ+RTfgVUpXNdjTe4fvLt1t4A7/7iBflabew6qgUD9XI/kuds=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.bp9kbgU_1741592466 cluster:ay29)
          by smtp.aliyun-inc.com;
          Mon, 10 Mar 2025 15:41:06 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [RFC PATCH 2/3] um: virt-pci: Refactor virtio_pcidev into its own module
Date: Mon, 10 Mar 2025 15:40:56 +0800
Message-Id: <20250310074057.3977758-3-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310074057.3977758-1-tiwei.btw@antgroup.com>
References: <20250310074057.3977758-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_004115_285411_393044F5 
X-CRM114-Status: GOOD (  26.10  )
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

Decouple virt-pci and virtio_pcidev, refactoring virtio_pcidev into
its own module. Define a set of APIs for virt-pci. This allows for
future addition of more PCI emulation implementations.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/Kconfig         |  12 +-
 arch/um/drivers/Makefile        |   3 +-
 arch/um/drivers/virt-pci.c      | 699 ++++++--------------------------
 arch/um/drivers/virt-pci.h      |  41 ++
 arch/um/drivers/virtio_pcidev.c | 628 ++++++++++++++++++++++++++++
 5 files changed, 794 insertions(+), 589 deletions(-)
 create mode 100644 arch/um/drivers/virt-pci.h
 create mode 100644 arch/um/drivers/virtio_pcidev.c

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index ede40a160c5e..9cb196070614 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -345,16 +345,20 @@ config UML_RTC
 	  by providing a fake RTC clock that causes a wakeup at the right
 	  time.
 
-config UML_PCI_OVER_VIRTIO
-	bool "Enable PCI over VIRTIO device simulation"
-	# in theory, just VIRTIO is enough, but that causes recursion
-	depends on VIRTIO_UML
+config UML_PCI
+	bool
 	select FORCE_PCI
 	select UML_IOMEM_EMULATION
 	select UML_DMA_EMULATION
 	select PCI_MSI
 	select PCI_LOCKLESS_CONFIG
 
+config UML_PCI_OVER_VIRTIO
+	bool "Enable PCI over VIRTIO device simulation"
+	# in theory, just VIRTIO is enough, but that causes recursion
+	depends on VIRTIO_UML
+	select UML_PCI
+
 config UML_PCI_OVER_VIRTIO_DEVICE_ID
 	int "set the virtio device ID for PCI emulation"
 	default -1
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 57882e6bc215..0a5820343ad3 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -60,7 +60,8 @@ obj-$(CONFIG_BLK_DEV_COW_COMMON) += cow_user.o
 obj-$(CONFIG_UML_RANDOM) += random.o
 obj-$(CONFIG_VIRTIO_UML) += virtio_uml.o
 obj-$(CONFIG_UML_RTC) += rtc.o
-obj-$(CONFIG_UML_PCI_OVER_VIRTIO) += virt-pci.o
+obj-$(CONFIG_UML_PCI) += virt-pci.o
+obj-$(CONFIG_UML_PCI_OVER_VIRTIO) += virtio_pcidev.o
 
 # pcap_user.o must be added explicitly.
 USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o vde_user.o vector_user.o
diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index dd5580f975cc..b83b5a765d4e 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -5,52 +5,19 @@
  */
 #include <linux/module.h>
 #include <linux/pci.h>
-#include <linux/virtio.h>
-#include <linux/virtio_config.h>
 #include <linux/logic_iomem.h>
 #include <linux/of_platform.h>
 #include <linux/irqdomain.h>
-#include <linux/virtio_pcidev.h>
-#include <linux/virtio-uml.h>
-#include <linux/delay.h>
 #include <linux/msi.h>
 #include <linux/unaligned.h>
 #include <irq_kern.h>
 
+#include "virt-pci.h"
+
 #define MAX_DEVICES 8
 #define MAX_MSI_VECTORS 32
 #define CFG_SPACE_SIZE 4096
 
-/* for MSI-X we have a 32-bit payload */
-#define MAX_IRQ_MSG_SIZE (sizeof(struct virtio_pcidev_msg) + sizeof(u32))
-#define NUM_IRQ_MSGS	10
-
-struct um_pci_message_buffer {
-	struct virtio_pcidev_msg hdr;
-	u8 data[8];
-};
-
-struct um_pci_device {
-	struct virtio_device *vdev;
-
-	/* for now just standard BARs */
-	u8 resptr[PCI_STD_NUM_BARS];
-
-	struct virtqueue *cmd_vq, *irq_vq;
-
-#define UM_PCI_WRITE_BUFS	20
-	struct um_pci_message_buffer bufs[UM_PCI_WRITE_BUFS + 1];
-	void *extra_ptrs[UM_PCI_WRITE_BUFS + 1];
-	DECLARE_BITMAP(used_bufs, UM_PCI_WRITE_BUFS);
-
-#define UM_PCI_STAT_WAITING	0
-	unsigned long status;
-
-	int irq;
-
-	bool platform;
-};
-
 struct um_pci_device_reg {
 	struct um_pci_device *dev;
 	void __iomem *iomem;
@@ -65,179 +32,15 @@ static struct irq_domain *um_pci_inner_domain;
 static struct irq_domain *um_pci_msi_domain;
 static unsigned long um_pci_msi_used[BITS_TO_LONGS(MAX_MSI_VECTORS)];
 
-static unsigned int um_pci_max_delay_us = 40000;
-module_param_named(max_delay_us, um_pci_max_delay_us, uint, 0644);
-
-static int um_pci_get_buf(struct um_pci_device *dev, bool *posted)
-{
-	int i;
-
-	for (i = 0; i < UM_PCI_WRITE_BUFS; i++) {
-		if (!test_and_set_bit(i, dev->used_bufs))
-			return i;
-	}
-
-	*posted = false;
-	return UM_PCI_WRITE_BUFS;
-}
-
-static void um_pci_free_buf(struct um_pci_device *dev, void *buf)
-{
-	int i;
-
-	if (buf == &dev->bufs[UM_PCI_WRITE_BUFS]) {
-		kfree(dev->extra_ptrs[UM_PCI_WRITE_BUFS]);
-		dev->extra_ptrs[UM_PCI_WRITE_BUFS] = NULL;
-		return;
-	}
-
-	for (i = 0; i < UM_PCI_WRITE_BUFS; i++) {
-		if (buf == &dev->bufs[i]) {
-			kfree(dev->extra_ptrs[i]);
-			dev->extra_ptrs[i] = NULL;
-			WARN_ON(!test_and_clear_bit(i, dev->used_bufs));
-			return;
-		}
-	}
-
-	WARN_ON(1);
-}
-
-static int um_pci_send_cmd(struct um_pci_device *dev,
-			   struct virtio_pcidev_msg *cmd,
-			   unsigned int cmd_size,
-			   const void *extra, unsigned int extra_size,
-			   void *out, unsigned int out_size)
-{
-	struct scatterlist out_sg, extra_sg, in_sg;
-	struct scatterlist *sgs_list[] = {
-		[0] = &out_sg,
-		[1] = extra ? &extra_sg : &in_sg,
-		[2] = extra ? &in_sg : NULL,
-	};
-	struct um_pci_message_buffer *buf;
-	int delay_count = 0;
-	bool bounce_out;
-	int ret, len;
-	int buf_idx;
-	bool posted;
-
-	if (WARN_ON(cmd_size < sizeof(*cmd) || cmd_size > sizeof(*buf)))
-		return -EINVAL;
-
-	switch (cmd->op) {
-	case VIRTIO_PCIDEV_OP_CFG_WRITE:
-	case VIRTIO_PCIDEV_OP_MMIO_WRITE:
-	case VIRTIO_PCIDEV_OP_MMIO_MEMSET:
-		/* in PCI, writes are posted, so don't wait */
-		posted = !out;
-		WARN_ON(!posted);
-		break;
-	default:
-		posted = false;
-		break;
-	}
-
-	bounce_out = !posted && cmd_size <= sizeof(*cmd) &&
-		     out && out_size <= sizeof(buf->data);
-
-	buf_idx = um_pci_get_buf(dev, &posted);
-	buf = &dev->bufs[buf_idx];
-	memcpy(buf, cmd, cmd_size);
-
-	if (posted && extra && extra_size > sizeof(buf) - cmd_size) {
-		dev->extra_ptrs[buf_idx] = kmemdup(extra, extra_size,
-						   GFP_ATOMIC);
-
-		if (!dev->extra_ptrs[buf_idx]) {
-			um_pci_free_buf(dev, buf);
-			return -ENOMEM;
-		}
-		extra = dev->extra_ptrs[buf_idx];
-	} else if (extra && extra_size <= sizeof(buf) - cmd_size) {
-		memcpy((u8 *)buf + cmd_size, extra, extra_size);
-		cmd_size += extra_size;
-		extra_size = 0;
-		extra = NULL;
-		cmd = (void *)buf;
-	} else {
-		cmd = (void *)buf;
-	}
-
-	sg_init_one(&out_sg, cmd, cmd_size);
-	if (extra)
-		sg_init_one(&extra_sg, extra, extra_size);
-	/* allow stack for small buffers */
-	if (bounce_out)
-		sg_init_one(&in_sg, buf->data, out_size);
-	else if (out)
-		sg_init_one(&in_sg, out, out_size);
-
-	/* add to internal virtio queue */
-	ret = virtqueue_add_sgs(dev->cmd_vq, sgs_list,
-				extra ? 2 : 1,
-				out ? 1 : 0,
-				cmd, GFP_ATOMIC);
-	if (ret) {
-		um_pci_free_buf(dev, buf);
-		return ret;
-	}
-
-	if (posted) {
-		virtqueue_kick(dev->cmd_vq);
-		return 0;
-	}
-
-	/* kick and poll for getting a response on the queue */
-	set_bit(UM_PCI_STAT_WAITING, &dev->status);
-	virtqueue_kick(dev->cmd_vq);
-	ret = 0;
-
-	while (1) {
-		void *completed = virtqueue_get_buf(dev->cmd_vq, &len);
-
-		if (completed == buf)
-			break;
-
-		if (completed)
-			um_pci_free_buf(dev, completed);
-
-		if (WARN_ONCE(virtqueue_is_broken(dev->cmd_vq) ||
-			      ++delay_count > um_pci_max_delay_us,
-			      "um virt-pci delay: %d", delay_count)) {
-			ret = -EIO;
-			break;
-		}
-		udelay(1);
-	}
-	clear_bit(UM_PCI_STAT_WAITING, &dev->status);
-
-	if (bounce_out)
-		memcpy(out, buf->data, out_size);
-
-	um_pci_free_buf(dev, buf);
-
-	return ret;
-}
-
 static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 					  int size)
 {
 	struct um_pci_device_reg *reg = priv;
 	struct um_pci_device *dev = reg->dev;
-	struct virtio_pcidev_msg hdr = {
-		.op = VIRTIO_PCIDEV_OP_CFG_READ,
-		.size = size,
-		.addr = offset,
-	};
-	/* max 8, we might not use it all */
-	u8 data[8];
 
 	if (!dev)
 		return ULONG_MAX;
 
-	memset(data, 0xff, sizeof(data));
-
 	switch (size) {
 	case 1:
 	case 2:
@@ -251,23 +54,7 @@ static unsigned long um_pci_cfgspace_read(void *priv, unsigned int offset,
 		return ULONG_MAX;
 	}
 
-	if (um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, size))
-		return ULONG_MAX;
-
-	switch (size) {
-	case 1:
-		return data[0];
-	case 2:
-		return le16_to_cpup((void *)data);
-	case 4:
-		return le32_to_cpup((void *)data);
-#ifdef CONFIG_64BIT
-	case 8:
-		return le64_to_cpup((void *)data);
-#endif
-	default:
-		return ULONG_MAX;
-	}
+	return dev->ops->cfgspace_read(dev, offset, size);
 }
 
 static void um_pci_cfgspace_write(void *priv, unsigned int offset, int size,
@@ -275,42 +62,24 @@ static void um_pci_cfgspace_write(void *priv, unsigned int offset, int size,
 {
 	struct um_pci_device_reg *reg = priv;
 	struct um_pci_device *dev = reg->dev;
-	struct {
-		struct virtio_pcidev_msg hdr;
-		/* maximum size - we may only use parts of it */
-		u8 data[8];
-	} msg = {
-		.hdr = {
-			.op = VIRTIO_PCIDEV_OP_CFG_WRITE,
-			.size = size,
-			.addr = offset,
-		},
-	};
 
 	if (!dev)
 		return;
 
 	switch (size) {
 	case 1:
-		msg.data[0] = (u8)val;
-		break;
 	case 2:
-		put_unaligned_le16(val, (void *)msg.data);
-		break;
 	case 4:
-		put_unaligned_le32(val, (void *)msg.data);
-		break;
 #ifdef CONFIG_64BIT
 	case 8:
-		put_unaligned_le64(val, (void *)msg.data);
-		break;
 #endif
+		break;
 	default:
 		WARN(1, "invalid config space write size %d\n", size);
 		return;
 	}
 
-	WARN_ON(um_pci_send_cmd(dev, &msg.hdr, sizeof(msg), NULL, 0, NULL, 0));
+	dev->ops->cfgspace_write(dev, offset, size, val);
 }
 
 static const struct logic_iomem_ops um_pci_device_cfgspace_ops = {
@@ -318,30 +87,14 @@ static const struct logic_iomem_ops um_pci_device_cfgspace_ops = {
 	.write = um_pci_cfgspace_write,
 };
 
-static void um_pci_bar_copy_from(void *priv, void *buffer,
-				 unsigned int offset, int size)
+static unsigned long um_pci_bar_read(void *priv, unsigned int offset,
+				     int size)
 {
 	u8 *resptr = priv;
 	struct um_pci_device *dev = container_of(resptr - *resptr,
 						 struct um_pci_device,
 						 resptr[0]);
-	struct virtio_pcidev_msg hdr = {
-		.op = VIRTIO_PCIDEV_OP_MMIO_READ,
-		.bar = *resptr,
-		.size = size,
-		.addr = offset,
-	};
-
-	memset(buffer, 0xff, size);
-
-	um_pci_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buffer, size);
-}
-
-static unsigned long um_pci_bar_read(void *priv, unsigned int offset,
-				     int size)
-{
-	/* 8 is maximum size - we may only use parts of it */
-	u8 data[8];
+	u8 bar = *resptr;
 
 	switch (size) {
 	case 1:
@@ -352,72 +105,60 @@ static unsigned long um_pci_bar_read(void *priv, unsigned int offset,
 #endif
 		break;
 	default:
-		WARN(1, "invalid config space read size %d\n", size);
+		WARN(1, "invalid bar read size %d\n", size);
 		return ULONG_MAX;
 	}
 
-	um_pci_bar_copy_from(priv, data, offset, size);
+	return dev->ops->bar_read(dev, bar, offset, size);
+}
+
+static void um_pci_bar_write(void *priv, unsigned int offset, int size,
+			     unsigned long val)
+{
+	u8 *resptr = priv;
+	struct um_pci_device *dev = container_of(resptr - *resptr,
+						 struct um_pci_device,
+						 resptr[0]);
+	u8 bar = *resptr;
 
 	switch (size) {
 	case 1:
-		return data[0];
 	case 2:
-		return le16_to_cpup((void *)data);
 	case 4:
-		return le32_to_cpup((void *)data);
 #ifdef CONFIG_64BIT
 	case 8:
-		return le64_to_cpup((void *)data);
 #endif
+		break;
 	default:
-		return ULONG_MAX;
+		WARN(1, "invalid bar write size %d\n", size);
+		return;
 	}
+
+	dev->ops->bar_write(dev, bar, offset, size, val);
 }
 
-static void um_pci_bar_copy_to(void *priv, unsigned int offset,
-			       const void *buffer, int size)
+static void um_pci_bar_copy_from(void *priv, void *buffer,
+				 unsigned int offset, int size)
 {
 	u8 *resptr = priv;
 	struct um_pci_device *dev = container_of(resptr - *resptr,
 						 struct um_pci_device,
 						 resptr[0]);
-	struct virtio_pcidev_msg hdr = {
-		.op = VIRTIO_PCIDEV_OP_MMIO_WRITE,
-		.bar = *resptr,
-		.size = size,
-		.addr = offset,
-	};
+	u8 bar = *resptr;
 
-	um_pci_send_cmd(dev, &hdr, sizeof(hdr), buffer, size, NULL, 0);
+	dev->ops->bar_copy_from(dev, bar, buffer, offset, size);
 }
 
-static void um_pci_bar_write(void *priv, unsigned int offset, int size,
-			     unsigned long val)
+static void um_pci_bar_copy_to(void *priv, unsigned int offset,
+			       const void *buffer, int size)
 {
-	/* maximum size - we may only use parts of it */
-	u8 data[8];
-
-	switch (size) {
-	case 1:
-		data[0] = (u8)val;
-		break;
-	case 2:
-		put_unaligned_le16(val, (void *)data);
-		break;
-	case 4:
-		put_unaligned_le32(val, (void *)data);
-		break;
-#ifdef CONFIG_64BIT
-	case 8:
-		put_unaligned_le64(val, (void *)data);
-		break;
-#endif
-	default:
-		WARN(1, "invalid config space write size %d\n", size);
-		return;
-	}
+	u8 *resptr = priv;
+	struct um_pci_device *dev = container_of(resptr - *resptr,
+						 struct um_pci_device,
+						 resptr[0]);
+	u8 bar = *resptr;
 
-	um_pci_bar_copy_to(priv, offset, data, size);
+	dev->ops->bar_copy_to(dev, bar, offset, buffer, size);
 }
 
 static void um_pci_bar_set(void *priv, unsigned int offset, u8 value, int size)
@@ -426,20 +167,9 @@ static void um_pci_bar_set(void *priv, unsigned int offset, u8 value, int size)
 	struct um_pci_device *dev = container_of(resptr - *resptr,
 						 struct um_pci_device,
 						 resptr[0]);
-	struct {
-		struct virtio_pcidev_msg hdr;
-		u8 data;
-	} msg = {
-		.hdr = {
-			.op = VIRTIO_PCIDEV_OP_CFG_WRITE,
-			.bar = *resptr,
-			.size = size,
-			.addr = offset,
-		},
-		.data = value,
-	};
+	u8 bar = *resptr;
 
-	um_pci_send_cmd(dev, &msg.hdr, sizeof(msg), NULL, 0, NULL, 0);
+	dev->ops->bar_set(dev, bar, offset, value, size);
 }
 
 static const struct logic_iomem_ops um_pci_device_bar_ops = {
@@ -486,76 +216,6 @@ static void um_pci_rescan(void)
 	pci_unlock_rescan_remove();
 }
 
-static void um_pci_irq_vq_addbuf(struct virtqueue *vq, void *buf, bool kick)
-{
-	struct scatterlist sg[1];
-
-	sg_init_one(sg, buf, MAX_IRQ_MSG_SIZE);
-	if (virtqueue_add_inbuf(vq, sg, 1, buf, GFP_ATOMIC))
-		kfree(buf);
-	else if (kick)
-		virtqueue_kick(vq);
-}
-
-static void um_pci_handle_irq_message(struct virtqueue *vq,
-				      struct virtio_pcidev_msg *msg)
-{
-	struct virtio_device *vdev = vq->vdev;
-	struct um_pci_device *dev = vdev->priv;
-
-	if (!dev->irq)
-		return;
-
-	/* we should properly chain interrupts, but on ARCH=um we don't care */
-
-	switch (msg->op) {
-	case VIRTIO_PCIDEV_OP_INT:
-		generic_handle_irq(dev->irq);
-		break;
-	case VIRTIO_PCIDEV_OP_MSI:
-		/* our MSI message is just the interrupt number */
-		if (msg->size == sizeof(u32))
-			generic_handle_irq(le32_to_cpup((void *)msg->data));
-		else
-			generic_handle_irq(le16_to_cpup((void *)msg->data));
-		break;
-	case VIRTIO_PCIDEV_OP_PME:
-		/* nothing to do - we already woke up due to the message */
-		break;
-	default:
-		dev_err(&vdev->dev, "unexpected virt-pci message %d\n", msg->op);
-		break;
-	}
-}
-
-static void um_pci_cmd_vq_cb(struct virtqueue *vq)
-{
-	struct virtio_device *vdev = vq->vdev;
-	struct um_pci_device *dev = vdev->priv;
-	void *cmd;
-	int len;
-
-	if (test_bit(UM_PCI_STAT_WAITING, &dev->status))
-		return;
-
-	while ((cmd = virtqueue_get_buf(vq, &len)))
-		um_pci_free_buf(dev, cmd);
-}
-
-static void um_pci_irq_vq_cb(struct virtqueue *vq)
-{
-	struct virtio_pcidev_msg *msg;
-	int len;
-
-	while ((msg = virtqueue_get_buf(vq, &len))) {
-		if (len >= sizeof(*msg))
-			um_pci_handle_irq_message(vq, msg);
-
-		/* recycle the message buffer */
-		um_pci_irq_vq_addbuf(vq, msg, true);
-	}
-}
-
 #ifdef CONFIG_OF
 /* Copied from arch/x86/kernel/devicetree.c */
 struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
@@ -577,200 +237,6 @@ struct device_node *pcibios_get_phb_of_node(struct pci_bus *bus)
 }
 #endif
 
-static int um_pci_init_vqs(struct um_pci_device *dev)
-{
-	struct virtqueue_info vqs_info[] = {
-		{ "cmd", um_pci_cmd_vq_cb },
-		{ "irq", um_pci_irq_vq_cb },
-	};
-	struct virtqueue *vqs[2];
-	int err, i;
-
-	err = virtio_find_vqs(dev->vdev, 2, vqs, vqs_info, NULL);
-	if (err)
-		return err;
-
-	dev->cmd_vq = vqs[0];
-	dev->irq_vq = vqs[1];
-
-	virtio_device_ready(dev->vdev);
-
-	for (i = 0; i < NUM_IRQ_MSGS; i++) {
-		void *msg = kzalloc(MAX_IRQ_MSG_SIZE, GFP_KERNEL);
-
-		if (msg)
-			um_pci_irq_vq_addbuf(dev->irq_vq, msg, false);
-	}
-
-	virtqueue_kick(dev->irq_vq);
-
-	return 0;
-}
-
-static void __um_pci_virtio_platform_remove(struct virtio_device *vdev,
-					    struct um_pci_device *dev)
-{
-	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
-
-	mutex_lock(&um_pci_mtx);
-	um_pci_platform_device = NULL;
-	mutex_unlock(&um_pci_mtx);
-
-	kfree(dev);
-}
-
-static int um_pci_virtio_platform_probe(struct virtio_device *vdev,
-					struct um_pci_device *dev)
-{
-	int ret;
-
-	dev->platform = true;
-
-	mutex_lock(&um_pci_mtx);
-
-	if (um_pci_platform_device) {
-		mutex_unlock(&um_pci_mtx);
-		ret = -EBUSY;
-		goto out_free;
-	}
-
-	ret = um_pci_init_vqs(dev);
-	if (ret) {
-		mutex_unlock(&um_pci_mtx);
-		goto out_free;
-	}
-
-	um_pci_platform_device = dev;
-
-	mutex_unlock(&um_pci_mtx);
-
-	ret = of_platform_default_populate(vdev->dev.of_node, NULL, &vdev->dev);
-	if (ret)
-		__um_pci_virtio_platform_remove(vdev, dev);
-
-	return ret;
-
-out_free:
-	kfree(dev);
-	return ret;
-}
-
-static int um_pci_virtio_probe(struct virtio_device *vdev)
-{
-	struct um_pci_device *dev;
-	int i, free = -1;
-	int err = -ENOSPC;
-
-	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
-	if (!dev)
-		return -ENOMEM;
-
-	dev->vdev = vdev;
-	vdev->priv = dev;
-
-	if (of_device_is_compatible(vdev->dev.of_node, "simple-bus"))
-		return um_pci_virtio_platform_probe(vdev, dev);
-
-	mutex_lock(&um_pci_mtx);
-	for (i = 0; i < MAX_DEVICES; i++) {
-		if (um_pci_devices[i].dev)
-			continue;
-		free = i;
-		break;
-	}
-
-	if (free < 0)
-		goto error;
-
-	err = um_pci_init_vqs(dev);
-	if (err)
-		goto error;
-
-	dev->irq = irq_alloc_desc(numa_node_id());
-	if (dev->irq < 0) {
-		err = dev->irq;
-		goto err_reset;
-	}
-	um_pci_devices[free].dev = dev;
-	vdev->priv = dev;
-
-	mutex_unlock(&um_pci_mtx);
-
-	device_set_wakeup_enable(&vdev->dev, true);
-
-	/*
-	 * In order to do suspend-resume properly, don't allow VQs
-	 * to be suspended.
-	 */
-	virtio_uml_set_no_vq_suspend(vdev, true);
-
-	um_pci_rescan();
-	return 0;
-err_reset:
-	virtio_reset_device(vdev);
-	vdev->config->del_vqs(vdev);
-error:
-	mutex_unlock(&um_pci_mtx);
-	kfree(dev);
-	return err;
-}
-
-static void um_pci_virtio_remove(struct virtio_device *vdev)
-{
-	struct um_pci_device *dev = vdev->priv;
-	int i;
-
-	if (dev->platform) {
-		of_platform_depopulate(&vdev->dev);
-		__um_pci_virtio_platform_remove(vdev, dev);
-		return;
-	}
-
-	device_set_wakeup_enable(&vdev->dev, false);
-
-	mutex_lock(&um_pci_mtx);
-	for (i = 0; i < MAX_DEVICES; i++) {
-		if (um_pci_devices[i].dev != dev)
-			continue;
-
-		um_pci_devices[i].dev = NULL;
-		irq_free_desc(dev->irq);
-
-		break;
-	}
-	mutex_unlock(&um_pci_mtx);
-
-	if (i < MAX_DEVICES) {
-		struct pci_dev *pci_dev;
-
-		pci_dev = pci_get_slot(bridge->bus, i);
-		if (pci_dev)
-			pci_stop_and_remove_bus_device_locked(pci_dev);
-	}
-
-	/* Stop all virtqueues */
-	virtio_reset_device(vdev);
-	dev->cmd_vq = NULL;
-	dev->irq_vq = NULL;
-	vdev->config->del_vqs(vdev);
-
-	kfree(dev);
-}
-
-static struct virtio_device_id id_table[] = {
-	{ CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID, VIRTIO_DEV_ANY_ID },
-	{ 0 },
-};
-MODULE_DEVICE_TABLE(virtio, id_table);
-
-static struct virtio_driver um_pci_virtio_driver = {
-	.driver.name = "virtio-pci",
-	.id_table = id_table,
-	.probe = um_pci_virtio_probe,
-	.remove = um_pci_virtio_remove,
-};
-
 static struct resource virt_cfgspace_resource = {
 	.name = "PCI config space",
 	.start = 0xf0000000 - MAX_DEVICES * CFG_SPACE_SIZE,
@@ -889,7 +355,7 @@ static void um_pci_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 }
 
 static struct irq_chip um_pci_msi_bottom_irq_chip = {
-	.name = "UM virtio MSI",
+	.name = "UM virtual MSI",
 	.irq_compose_msi_msg = um_pci_compose_msi_msg,
 };
 
@@ -939,7 +405,7 @@ static const struct irq_domain_ops um_pci_inner_domain_ops = {
 };
 
 static struct irq_chip um_pci_msi_irq_chip = {
-	.name = "UM virtio PCIe MSI",
+	.name = "UM virtual PCIe MSI",
 	.irq_mask = pci_msi_mask_irq,
 	.irq_unmask = pci_msi_unmask_irq,
 };
@@ -998,6 +464,78 @@ static struct resource virt_platform_resource = {
 	.flags = IORESOURCE_MEM,
 };
 
+int um_pci_device_register(struct um_pci_device *dev)
+{
+	int i, free = -1;
+	int err = 0;
+
+	mutex_lock(&um_pci_mtx);
+	for (i = 0; i < MAX_DEVICES; i++) {
+		if (um_pci_devices[i].dev)
+			continue;
+		free = i;
+		break;
+	}
+
+	if (free < 0) {
+		err = -ENOSPC;
+		goto out;
+	}
+
+	dev->irq = irq_alloc_desc(numa_node_id());
+	if (dev->irq < 0) {
+		err = dev->irq;
+		goto out;
+	}
+
+	um_pci_devices[free].dev = dev;
+
+out:
+	mutex_unlock(&um_pci_mtx);
+	if (!err)
+		um_pci_rescan();
+	return err;
+}
+
+void um_pci_device_unregister(struct um_pci_device *dev)
+{
+	int i;
+
+	mutex_lock(&um_pci_mtx);
+	for (i = 0; i < MAX_DEVICES; i++) {
+		if (um_pci_devices[i].dev != dev)
+			continue;
+		um_pci_devices[i].dev = NULL;
+		irq_free_desc(dev->irq);
+		break;
+	}
+	mutex_unlock(&um_pci_mtx);
+
+	if (i < MAX_DEVICES) {
+		struct pci_dev *pci_dev;
+
+		pci_dev = pci_get_slot(bridge->bus, i);
+		if (pci_dev)
+			pci_stop_and_remove_bus_device_locked(pci_dev);
+	}
+}
+
+int um_pci_platform_device_register(struct um_pci_device *dev)
+{
+	guard(mutex)(&um_pci_mtx);
+	if (um_pci_platform_device)
+		return -EBUSY;
+	um_pci_platform_device = dev;
+	return 0;
+}
+
+void um_pci_platform_device_unregister(struct um_pci_device *dev)
+{
+	guard(mutex)(&um_pci_mtx);
+	if (um_pci_platform_device == dev)
+		um_pci_platform_device = NULL;
+}
+
 static int __init um_pci_init(void)
 {
 	struct irq_domain_info inner_domain_info = {
@@ -1014,10 +552,6 @@ static int __init um_pci_init(void)
 	WARN_ON(logic_iomem_add_region(&virt_platform_resource,
 				       &um_pci_platform_ops));
 
-	if (WARN(CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID < 0,
-		 "No virtio device ID configured for PCI - no PCI support\n"))
-		return 0;
-
 	bridge = pci_alloc_host_bridge(0);
 	if (!bridge) {
 		err = -ENOMEM;
@@ -1065,10 +599,8 @@ static int __init um_pci_init(void)
 	if (err)
 		goto free;
 
-	err = register_virtio_driver(&um_pci_virtio_driver);
-	if (err)
-		goto free;
 	return 0;
+
 free:
 	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
 		irq_domain_remove(um_pci_inner_domain);
@@ -1080,11 +612,10 @@ static int __init um_pci_init(void)
 	}
 	return err;
 }
-module_init(um_pci_init);
+device_initcall(um_pci_init);
 
 static void __exit um_pci_exit(void)
 {
-	unregister_virtio_driver(&um_pci_virtio_driver);
 	irq_domain_remove(um_pci_msi_domain);
 	irq_domain_remove(um_pci_inner_domain);
 	pci_free_resource_list(&bridge->windows);
diff --git a/arch/um/drivers/virt-pci.h b/arch/um/drivers/virt-pci.h
new file mode 100644
index 000000000000..b20d1475d1eb
--- /dev/null
+++ b/arch/um/drivers/virt-pci.h
@@ -0,0 +1,41 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_VIRT_PCI_H
+#define __UM_VIRT_PCI_H
+
+#include <linux/pci.h>
+
+struct um_pci_device {
+	const struct um_pci_ops *ops;
+
+	/* for now just standard BARs */
+	u8 resptr[PCI_STD_NUM_BARS];
+
+	int irq;
+};
+
+struct um_pci_ops {
+	unsigned long (*cfgspace_read)(struct um_pci_device *dev,
+				       unsigned int offset, int size);
+	void (*cfgspace_write)(struct um_pci_device *dev, unsigned int offset,
+			       int size, unsigned long val);
+
+	unsigned long (*bar_read)(struct um_pci_device *dev, int bar,
+				  unsigned int offset, int size);
+	void (*bar_write)(struct um_pci_device *dev, int bar,
+			  unsigned int offset, int size, unsigned long val);
+
+	void (*bar_copy_from)(struct um_pci_device *dev, int bar, void *buffer,
+			      unsigned int offset, int size);
+	void (*bar_copy_to)(struct um_pci_device *dev, int bar,
+			    unsigned int offset, const void *buffer, int size);
+	void (*bar_set)(struct um_pci_device *dev, int bar,
+			unsigned int offset, u8 value, int size);
+};
+
+int um_pci_device_register(struct um_pci_device *dev);
+void um_pci_device_unregister(struct um_pci_device *dev);
+
+int um_pci_platform_device_register(struct um_pci_device *dev);
+void um_pci_platform_device_unregister(struct um_pci_device *dev);
+
+#endif /* __UM_VIRT_PCI_H */
diff --git a/arch/um/drivers/virtio_pcidev.c b/arch/um/drivers/virtio_pcidev.c
new file mode 100644
index 000000000000..3c4c4c928fdd
--- /dev/null
+++ b/arch/um/drivers/virtio_pcidev.c
@@ -0,0 +1,628 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2020 Intel Corporation
+ * Author: Johannes Berg <johannes@sipsolutions.net>
+ */
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/logic_iomem.h>
+#include <linux/of_platform.h>
+#include <linux/irqdomain.h>
+#include <linux/virtio_pcidev.h>
+#include <linux/virtio-uml.h>
+#include <linux/delay.h>
+#include <linux/msi.h>
+#include <linux/unaligned.h>
+#include <irq_kern.h>
+
+#include "virt-pci.h"
+
+#define to_virtio_pcidev(_pdev) \
+	container_of(_pdev, struct virtio_pcidev_device, pdev)
+
+/* for MSI-X we have a 32-bit payload */
+#define MAX_IRQ_MSG_SIZE (sizeof(struct virtio_pcidev_msg) + sizeof(u32))
+#define NUM_IRQ_MSGS	10
+
+struct virtio_pcidev_message_buffer {
+	struct virtio_pcidev_msg hdr;
+	u8 data[8];
+};
+
+struct virtio_pcidev_device {
+	struct um_pci_device pdev;
+	struct virtio_device *vdev;
+
+	struct virtqueue *cmd_vq, *irq_vq;
+
+#define VIRTIO_PCIDEV_WRITE_BUFS	20
+	struct virtio_pcidev_message_buffer bufs[VIRTIO_PCIDEV_WRITE_BUFS + 1];
+	void *extra_ptrs[VIRTIO_PCIDEV_WRITE_BUFS + 1];
+	DECLARE_BITMAP(used_bufs, VIRTIO_PCIDEV_WRITE_BUFS);
+
+#define UM_PCI_STAT_WAITING	0
+	unsigned long status;
+
+	bool platform;
+};
+
+static unsigned int virtio_pcidev_max_delay_us = 40000;
+module_param_named(max_delay_us, virtio_pcidev_max_delay_us, uint, 0644);
+
+static int virtio_pcidev_get_buf(struct virtio_pcidev_device *dev, bool *posted)
+{
+	int i;
+
+	for (i = 0; i < VIRTIO_PCIDEV_WRITE_BUFS; i++) {
+		if (!test_and_set_bit(i, dev->used_bufs))
+			return i;
+	}
+
+	*posted = false;
+	return VIRTIO_PCIDEV_WRITE_BUFS;
+}
+
+static void virtio_pcidev_free_buf(struct virtio_pcidev_device *dev, void *buf)
+{
+	int i;
+
+	if (buf == &dev->bufs[VIRTIO_PCIDEV_WRITE_BUFS]) {
+		kfree(dev->extra_ptrs[VIRTIO_PCIDEV_WRITE_BUFS]);
+		dev->extra_ptrs[VIRTIO_PCIDEV_WRITE_BUFS] = NULL;
+		return;
+	}
+
+	for (i = 0; i < VIRTIO_PCIDEV_WRITE_BUFS; i++) {
+		if (buf == &dev->bufs[i]) {
+			kfree(dev->extra_ptrs[i]);
+			dev->extra_ptrs[i] = NULL;
+			WARN_ON(!test_and_clear_bit(i, dev->used_bufs));
+			return;
+		}
+	}
+
+	WARN_ON(1);
+}
+
+static int virtio_pcidev_send_cmd(struct virtio_pcidev_device *dev,
+				  struct virtio_pcidev_msg *cmd,
+				  unsigned int cmd_size,
+				  const void *extra, unsigned int extra_size,
+				  void *out, unsigned int out_size)
+{
+	struct scatterlist out_sg, extra_sg, in_sg;
+	struct scatterlist *sgs_list[] = {
+		[0] = &out_sg,
+		[1] = extra ? &extra_sg : &in_sg,
+		[2] = extra ? &in_sg : NULL,
+	};
+	struct virtio_pcidev_message_buffer *buf;
+	int delay_count = 0;
+	bool bounce_out;
+	int ret, len;
+	int buf_idx;
+	bool posted;
+
+	if (WARN_ON(cmd_size < sizeof(*cmd) || cmd_size > sizeof(*buf)))
+		return -EINVAL;
+
+	switch (cmd->op) {
+	case VIRTIO_PCIDEV_OP_CFG_WRITE:
+	case VIRTIO_PCIDEV_OP_MMIO_WRITE:
+	case VIRTIO_PCIDEV_OP_MMIO_MEMSET:
+		/* in PCI, writes are posted, so don't wait */
+		posted = !out;
+		WARN_ON(!posted);
+		break;
+	default:
+		posted = false;
+		break;
+	}
+
+	bounce_out = !posted && cmd_size <= sizeof(*cmd) &&
+		     out && out_size <= sizeof(buf->data);
+
+	buf_idx = virtio_pcidev_get_buf(dev, &posted);
+	buf = &dev->bufs[buf_idx];
+	memcpy(buf, cmd, cmd_size);
+
+	if (posted && extra && extra_size > sizeof(buf) - cmd_size) {
+		dev->extra_ptrs[buf_idx] = kmemdup(extra, extra_size,
+						   GFP_ATOMIC);
+
+		if (!dev->extra_ptrs[buf_idx]) {
+			virtio_pcidev_free_buf(dev, buf);
+			return -ENOMEM;
+		}
+		extra = dev->extra_ptrs[buf_idx];
+	} else if (extra && extra_size <= sizeof(buf) - cmd_size) {
+		memcpy((u8 *)buf + cmd_size, extra, extra_size);
+		cmd_size += extra_size;
+		extra_size = 0;
+		extra = NULL;
+		cmd = (void *)buf;
+	} else {
+		cmd = (void *)buf;
+	}
+
+	sg_init_one(&out_sg, cmd, cmd_size);
+	if (extra)
+		sg_init_one(&extra_sg, extra, extra_size);
+	/* allow stack for small buffers */
+	if (bounce_out)
+		sg_init_one(&in_sg, buf->data, out_size);
+	else if (out)
+		sg_init_one(&in_sg, out, out_size);
+
+	/* add to internal virtio queue */
+	ret = virtqueue_add_sgs(dev->cmd_vq, sgs_list,
+				extra ? 2 : 1,
+				out ? 1 : 0,
+				cmd, GFP_ATOMIC);
+	if (ret) {
+		virtio_pcidev_free_buf(dev, buf);
+		return ret;
+	}
+
+	if (posted) {
+		virtqueue_kick(dev->cmd_vq);
+		return 0;
+	}
+
+	/* kick and poll for getting a response on the queue */
+	set_bit(UM_PCI_STAT_WAITING, &dev->status);
+	virtqueue_kick(dev->cmd_vq);
+	ret = 0;
+
+	while (1) {
+		void *completed = virtqueue_get_buf(dev->cmd_vq, &len);
+
+		if (completed == buf)
+			break;
+
+		if (completed)
+			virtio_pcidev_free_buf(dev, completed);
+
+		if (WARN_ONCE(virtqueue_is_broken(dev->cmd_vq) ||
+			      ++delay_count > virtio_pcidev_max_delay_us,
+			      "um virt-pci delay: %d", delay_count)) {
+			ret = -EIO;
+			break;
+		}
+		udelay(1);
+	}
+	clear_bit(UM_PCI_STAT_WAITING, &dev->status);
+
+	if (bounce_out)
+		memcpy(out, buf->data, out_size);
+
+	virtio_pcidev_free_buf(dev, buf);
+
+	return ret;
+}
+
+static unsigned long virtio_pcidev_cfgspace_read(struct um_pci_device *pdev,
+						 unsigned int offset, int size)
+{
+	struct virtio_pcidev_device *dev = to_virtio_pcidev(pdev);
+	struct virtio_pcidev_msg hdr = {
+		.op = VIRTIO_PCIDEV_OP_CFG_READ,
+		.size = size,
+		.addr = offset,
+	};
+	/* max 8, we might not use it all */
+	u8 data[8];
+
+	memset(data, 0xff, sizeof(data));
+
+	/* size has been checked in um_pci_cfgspace_read() */
+	if (virtio_pcidev_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, data, size))
+		return ULONG_MAX;
+
+	switch (size) {
+	case 1:
+		return data[0];
+	case 2:
+		return le16_to_cpup((void *)data);
+	case 4:
+		return le32_to_cpup((void *)data);
+#ifdef CONFIG_64BIT
+	case 8:
+		return le64_to_cpup((void *)data);
+#endif
+	default:
+		return ULONG_MAX;
+	}
+}
+
+static void virtio_pcidev_cfgspace_write(struct um_pci_device *pdev,
+					 unsigned int offset, int size,
+					 unsigned long val)
+{
+	struct virtio_pcidev_device *dev = to_virtio_pcidev(pdev);
+	struct {
+		struct virtio_pcidev_msg hdr;
+		/* maximum size - we may only use parts of it */
+		u8 data[8];
+	} msg = {
+		.hdr = {
+			.op = VIRTIO_PCIDEV_OP_CFG_WRITE,
+			.size = size,
+			.addr = offset,
+		},
+	};
+
+	/* size has been checked in um_pci_cfgspace_write() */
+	switch (size) {
+	case 1:
+		msg.data[0] = (u8)val;
+		break;
+	case 2:
+		put_unaligned_le16(val, (void *)msg.data);
+		break;
+	case 4:
+		put_unaligned_le32(val, (void *)msg.data);
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		put_unaligned_le64(val, (void *)msg.data);
+		break;
+#endif
+	}
+
+	WARN_ON(virtio_pcidev_send_cmd(dev, &msg.hdr, sizeof(msg), NULL, 0, NULL, 0));
+}
+
+static void virtio_pcidev_bar_copy_from(struct um_pci_device *pdev,
+					int bar, void *buffer,
+					unsigned int offset, int size)
+{
+	struct virtio_pcidev_device *dev = to_virtio_pcidev(pdev);
+	struct virtio_pcidev_msg hdr = {
+		.op = VIRTIO_PCIDEV_OP_MMIO_READ,
+		.bar = bar,
+		.size = size,
+		.addr = offset,
+	};
+
+	memset(buffer, 0xff, size);
+
+	virtio_pcidev_send_cmd(dev, &hdr, sizeof(hdr), NULL, 0, buffer, size);
+}
+
+static unsigned long virtio_pcidev_bar_read(struct um_pci_device *pdev, int bar,
+					    unsigned int offset, int size)
+{
+	/* 8 is maximum size - we may only use parts of it */
+	u8 data[8];
+
+	/* size has been checked in um_pci_bar_read() */
+	virtio_pcidev_bar_copy_from(pdev, bar, data, offset, size);
+
+	switch (size) {
+	case 1:
+		return data[0];
+	case 2:
+		return le16_to_cpup((void *)data);
+	case 4:
+		return le32_to_cpup((void *)data);
+#ifdef CONFIG_64BIT
+	case 8:
+		return le64_to_cpup((void *)data);
+#endif
+	default:
+		return ULONG_MAX;
+	}
+}
+
+static void virtio_pcidev_bar_copy_to(struct um_pci_device *pdev,
+				      int bar, unsigned int offset,
+				      const void *buffer, int size)
+{
+	struct virtio_pcidev_device *dev = to_virtio_pcidev(pdev);
+	struct virtio_pcidev_msg hdr = {
+		.op = VIRTIO_PCIDEV_OP_MMIO_WRITE,
+		.bar = bar,
+		.size = size,
+		.addr = offset,
+	};
+
+	virtio_pcidev_send_cmd(dev, &hdr, sizeof(hdr), buffer, size, NULL, 0);
+}
+
+static void virtio_pcidev_bar_write(struct um_pci_device *pdev, int bar,
+				    unsigned int offset, int size,
+				    unsigned long val)
+{
+	/* maximum size - we may only use parts of it */
+	u8 data[8];
+
+	/* size has been checked in um_pci_bar_write() */
+	switch (size) {
+	case 1:
+		data[0] = (u8)val;
+		break;
+	case 2:
+		put_unaligned_le16(val, (void *)data);
+		break;
+	case 4:
+		put_unaligned_le32(val, (void *)data);
+		break;
+#ifdef CONFIG_64BIT
+	case 8:
+		put_unaligned_le64(val, (void *)data);
+		break;
+#endif
+	}
+
+	virtio_pcidev_bar_copy_to(pdev, bar, offset, data, size);
+}
+
+static void virtio_pcidev_bar_set(struct um_pci_device *pdev, int bar,
+				  unsigned int offset, u8 value, int size)
+{
+	struct virtio_pcidev_device *dev = to_virtio_pcidev(pdev);
+	struct {
+		struct virtio_pcidev_msg hdr;
+		u8 data;
+	} msg = {
+		.hdr = {
+			.op = VIRTIO_PCIDEV_OP_CFG_WRITE,
+			.bar = bar,
+			.size = size,
+			.addr = offset,
+		},
+		.data = value,
+	};
+
+	virtio_pcidev_send_cmd(dev, &msg.hdr, sizeof(msg), NULL, 0, NULL, 0);
+}
+
+static const struct um_pci_ops virtio_pcidev_um_pci_ops = {
+	.cfgspace_read	= virtio_pcidev_cfgspace_read,
+	.cfgspace_write	= virtio_pcidev_cfgspace_write,
+	.bar_read	= virtio_pcidev_bar_read,
+	.bar_write	= virtio_pcidev_bar_write,
+	.bar_copy_from	= virtio_pcidev_bar_copy_from,
+	.bar_copy_to	= virtio_pcidev_bar_copy_to,
+	.bar_set	= virtio_pcidev_bar_set,
+};
+
+static void virtio_pcidev_irq_vq_addbuf(struct virtqueue *vq, void *buf, bool kick)
+{
+	struct scatterlist sg[1];
+
+	sg_init_one(sg, buf, MAX_IRQ_MSG_SIZE);
+	if (virtqueue_add_inbuf(vq, sg, 1, buf, GFP_ATOMIC))
+		kfree(buf);
+	else if (kick)
+		virtqueue_kick(vq);
+}
+
+static void virtio_pcidev_handle_irq_message(struct virtqueue *vq,
+					     struct virtio_pcidev_msg *msg)
+{
+	struct virtio_device *vdev = vq->vdev;
+	struct virtio_pcidev_device *dev = vdev->priv;
+
+	if (!dev->pdev.irq)
+		return;
+
+	/* we should properly chain interrupts, but on ARCH=um we don't care */
+
+	switch (msg->op) {
+	case VIRTIO_PCIDEV_OP_INT:
+		generic_handle_irq(dev->pdev.irq);
+		break;
+	case VIRTIO_PCIDEV_OP_MSI:
+		/* our MSI message is just the interrupt number */
+		if (msg->size == sizeof(u32))
+			generic_handle_irq(le32_to_cpup((void *)msg->data));
+		else
+			generic_handle_irq(le16_to_cpup((void *)msg->data));
+		break;
+	case VIRTIO_PCIDEV_OP_PME:
+		/* nothing to do - we already woke up due to the message */
+		break;
+	default:
+		dev_err(&vdev->dev, "unexpected virt-pci message %d\n", msg->op);
+		break;
+	}
+}
+
+static void virtio_pcidev_cmd_vq_cb(struct virtqueue *vq)
+{
+	struct virtio_device *vdev = vq->vdev;
+	struct virtio_pcidev_device *dev = vdev->priv;
+	void *cmd;
+	int len;
+
+	if (test_bit(UM_PCI_STAT_WAITING, &dev->status))
+		return;
+
+	while ((cmd = virtqueue_get_buf(vq, &len)))
+		virtio_pcidev_free_buf(dev, cmd);
+}
+
+static void virtio_pcidev_irq_vq_cb(struct virtqueue *vq)
+{
+	struct virtio_pcidev_msg *msg;
+	int len;
+
+	while ((msg = virtqueue_get_buf(vq, &len))) {
+		if (len >= sizeof(*msg))
+			virtio_pcidev_handle_irq_message(vq, msg);
+
+		/* recycle the message buffer */
+		virtio_pcidev_irq_vq_addbuf(vq, msg, true);
+	}
+}
+
+static int virtio_pcidev_init_vqs(struct virtio_pcidev_device *dev)
+{
+	struct virtqueue_info vqs_info[] = {
+		{ "cmd", virtio_pcidev_cmd_vq_cb },
+		{ "irq", virtio_pcidev_irq_vq_cb },
+	};
+	struct virtqueue *vqs[2];
+	int err, i;
+
+	err = virtio_find_vqs(dev->vdev, 2, vqs, vqs_info, NULL);
+	if (err)
+		return err;
+
+	dev->cmd_vq = vqs[0];
+	dev->irq_vq = vqs[1];
+
+	virtio_device_ready(dev->vdev);
+
+	for (i = 0; i < NUM_IRQ_MSGS; i++) {
+		void *msg = kzalloc(MAX_IRQ_MSG_SIZE, GFP_KERNEL);
+
+		if (msg)
+			virtio_pcidev_irq_vq_addbuf(dev->irq_vq, msg, false);
+	}
+
+	virtqueue_kick(dev->irq_vq);
+
+	return 0;
+}
+
+static void __virtio_pcidev_virtio_platform_remove(struct virtio_device *vdev,
+						   struct virtio_pcidev_device *dev)
+{
+	um_pci_platform_device_unregister(&dev->pdev);
+
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+
+	kfree(dev);
+}
+
+static int virtio_pcidev_virtio_platform_probe(struct virtio_device *vdev,
+					       struct virtio_pcidev_device *dev)
+{
+	int err;
+
+	dev->platform = true;
+
+	err = virtio_pcidev_init_vqs(dev);
+	if (err)
+		goto err_free;
+
+	err = um_pci_platform_device_register(&dev->pdev);
+	if (err)
+		goto err_reset;
+
+	err = of_platform_default_populate(vdev->dev.of_node, NULL, &vdev->dev);
+	if (err)
+		goto err_unregister;
+
+	return 0;
+
+err_unregister:
+	um_pci_platform_device_unregister(&dev->pdev);
+err_reset:
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+err_free:
+	kfree(dev);
+	return err;
+}
+
+static int virtio_pcidev_virtio_probe(struct virtio_device *vdev)
+{
+	struct virtio_pcidev_device *dev;
+	int err;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->vdev = vdev;
+	vdev->priv = dev;
+
+	dev->pdev.ops = &virtio_pcidev_um_pci_ops;
+
+	if (of_device_is_compatible(vdev->dev.of_node, "simple-bus"))
+		return virtio_pcidev_virtio_platform_probe(vdev, dev);
+
+	err = virtio_pcidev_init_vqs(dev);
+	if (err)
+		goto err_free;
+
+	err = um_pci_device_register(&dev->pdev);
+	if (err)
+		goto err_reset;
+
+	device_set_wakeup_enable(&vdev->dev, true);
+
+	/*
+	 * In order to do suspend-resume properly, don't allow VQs
+	 * to be suspended.
+	 */
+	virtio_uml_set_no_vq_suspend(vdev, true);
+
+	return 0;
+
+err_reset:
+	virtio_reset_device(vdev);
+	vdev->config->del_vqs(vdev);
+err_free:
+	kfree(dev);
+	return err;
+}
+
+static void virtio_pcidev_virtio_remove(struct virtio_device *vdev)
+{
+	struct virtio_pcidev_device *dev = vdev->priv;
+
+	if (dev->platform) {
+		of_platform_depopulate(&vdev->dev);
+		__virtio_pcidev_virtio_platform_remove(vdev, dev);
+		return;
+	}
+
+	device_set_wakeup_enable(&vdev->dev, false);
+
+	um_pci_device_unregister(&dev->pdev);
+
+	/* Stop all virtqueues */
+	virtio_reset_device(vdev);
+	dev->cmd_vq = NULL;
+	dev->irq_vq = NULL;
+	vdev->config->del_vqs(vdev);
+
+	kfree(dev);
+}
+
+static struct virtio_device_id id_table[] = {
+	{ CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID, VIRTIO_DEV_ANY_ID },
+	{ 0 },
+};
+MODULE_DEVICE_TABLE(virtio, id_table);
+
+static struct virtio_driver virtio_pcidev_virtio_driver = {
+	.driver.name = "virtio-pci",
+	.id_table = id_table,
+	.probe = virtio_pcidev_virtio_probe,
+	.remove = virtio_pcidev_virtio_remove,
+};
+
+static int __init virtio_pcidev_init(void)
+{
+	if (WARN(CONFIG_UML_PCI_OVER_VIRTIO_DEVICE_ID < 0,
+		 "No virtio device ID configured for PCI - no PCI support\n"))
+		return 0;
+
+	return register_virtio_driver(&virtio_pcidev_virtio_driver);
+}
+late_initcall(virtio_pcidev_init);
+
+static void __exit virtio_pcidev_exit(void)
+{
+	unregister_virtio_driver(&virtio_pcidev_virtio_driver);
+}
+module_exit(virtio_pcidev_exit);
-- 
2.34.1


