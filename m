Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99360C28B30
	for <linux-um@archiver.kernel.org>; Sat, 15 Mar 2025 16:19:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6EkYnTXnDJ3GyeRvyb1ldCLjh3rBagK7bvIzRDUW4zI=; b=dQa4Xn9f/QaM7SC5BhpbM7gEtr
	uZMSYrCpCzmNi1ROmhZh/wrstmucmOrqz6ROeXoffiqonbo2u6/kLY7apDQIiD/7RLN9GvDS+VH8A
	Rr5OaIvq3kPSONDdxAALwd4mZCkafX6JWXLt1KYQGQFSA/Y9NEnNgyw13UJ2lz5BAWXsRSQLNwT9L
	QDrS793Ldrz6zmtO+syQdC+zNGxZfifoCDHwec0ph5jJlVB55EjsXTPi99dD845PnyMi3WyWBKDQa
	u+pZv41/mgmUE5IXcRSPg0oG60WHi+w2Sv/XSRO8KdSYq9GTTSwRdIc+HIhMewDgD6FtUCn52UUCg
	HESAZO9g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1ttUEd-0000000Gay2-1igN;
	Sat, 15 Mar 2025 16:19:39 +0000
Received: from out0-217.mail.aliyun.com ([140.205.0.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1ttUEa-0000000GawQ-05LF
	for linux-um@lists.infradead.org;
	Sat, 15 Mar 2025 16:19:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=antgroup.com; s=default;
	t=1742055567; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=6EkYnTXnDJ3GyeRvyb1ldCLjh3rBagK7bvIzRDUW4zI=;
	b=lB0n2xvxbwwlkos28yVqnBvcM6vMN7zZ3KgYFnLl0PFgWB/4v5VSz+CYk8IyhV5dA1I8Q/Gs5Td0yUtzXuXwIbS8Xx7zG+CC8Elx2MMyct6LMoEx2L4RVLPSU9jolNKUu7TXlJ1qQ6zJhX8MQJZ7fGgHGTTOXhHGrT5TPkEU+HE=
Received: from ubuntu..(mailfrom:tiwei.btw@antgroup.com fp:SMTPD_---.buVCVMR_1742055566 cluster:ay29)
          by smtp.aliyun-inc.com;
          Sun, 16 Mar 2025 00:19:26 +0800
From: "Tiwei Bie" <tiwei.btw@antgroup.com>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: <linux-um@lists.infradead.org>,
  "Tiwei Bie" <tiwei.btw@antgroup.com>
Subject: [PATCH 3/3] um: Add VFIO-based virtual PCI driver
Date: Sun, 16 Mar 2025 00:19:10 +0800
Message-Id: <20250315161910.4082396-4-tiwei.btw@antgroup.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250315161910.4082396-1-tiwei.btw@antgroup.com>
References: <20250315161910.4082396-1-tiwei.btw@antgroup.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250315_091936_530394_78527D10 
X-CRM114-Status: GOOD (  23.81  )
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

Implement a new virtual PCI driver based on the VFIO framework.
This driver allows users to pass through PCI devices to UML via
VFIO. Currently, only MSI-X capable devices are supported, and
it is assumed that drivers will use MSI-X.

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/Kconfig     |   8 +
 arch/um/drivers/Makefile    |   2 +
 arch/um/drivers/vfio_kern.c | 648 ++++++++++++++++++++++++++++++++++++
 arch/um/drivers/vfio_user.c | 323 ++++++++++++++++++
 arch/um/drivers/vfio_user.h |  44 +++
 5 files changed, 1025 insertions(+)
 create mode 100644 arch/um/drivers/vfio_kern.c
 create mode 100644 arch/um/drivers/vfio_user.c
 create mode 100644 arch/um/drivers/vfio_user.h

diff --git a/arch/um/drivers/Kconfig b/arch/um/drivers/Kconfig
index 9cb196070614..d7bb447ff958 100644
--- a/arch/um/drivers/Kconfig
+++ b/arch/um/drivers/Kconfig
@@ -367,3 +367,11 @@ config UML_PCI_OVER_VIRTIO_DEVICE_ID
 	  There's no official device ID assigned (yet), set the one you
 	  wish to use for experimentation here. The default of -1 is
 	  not valid and will cause the driver to fail at probe.
+
+config UML_PCI_OVER_VFIO
+	bool "Enable VFIO-based PCI passthrough"
+	select UML_PCI
+	help
+	  This driver provides support for VFIO-based PCI passthrough.
+	  Currently, only MSI-X capable devices are supported, and it
+	  is assumed that drivers will use MSI-X.
diff --git a/arch/um/drivers/Makefile b/arch/um/drivers/Makefile
index 0a5820343ad3..336be56b8975 100644
--- a/arch/um/drivers/Makefile
+++ b/arch/um/drivers/Makefile
@@ -19,6 +19,7 @@ port-objs := port_kern.o port_user.o
 harddog-objs := harddog_kern.o
 harddog-builtin-$(CONFIG_UML_WATCHDOG) := harddog_user.o harddog_user_exp.o
 rtc-objs := rtc_kern.o rtc_user.o
+vfio_uml-objs := vfio_kern.o vfio_user.o
 
 LDFLAGS_vde.o = $(shell $(CC) $(CFLAGS) -print-file-name=libvdeplug.a)
 
@@ -62,6 +63,7 @@ obj-$(CONFIG_VIRTIO_UML) += virtio_uml.o
 obj-$(CONFIG_UML_RTC) += rtc.o
 obj-$(CONFIG_UML_PCI) += virt-pci.o
 obj-$(CONFIG_UML_PCI_OVER_VIRTIO) += virtio_pcidev.o
+obj-$(CONFIG_UML_PCI_OVER_VFIO) += vfio_uml.o
 
 # pcap_user.o must be added explicitly.
 USER_OBJS := fd.o null.o pty.o tty.o xterm.o slip_common.o vde_user.o vector_user.o
diff --git a/arch/um/drivers/vfio_kern.c b/arch/um/drivers/vfio_kern.c
new file mode 100644
index 000000000000..805f589a568d
--- /dev/null
+++ b/arch/um/drivers/vfio_kern.c
@@ -0,0 +1,648 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Ant Group
+ * Author: Tiwei Bie <tiwei.btw@antgroup.com>
+ */
+#include <linux/module.h>
+#include <linux/logic_iomem.h>
+#include <linux/mutex.h>
+#include <linux/string.h>
+#include <linux/unaligned.h>
+#include <irq_kern.h>
+#include <init.h>
+#include <os.h>
+
+#include "virt-pci.h"
+#include "vfio_user.h"
+
+#define MAX_GROUPS	8
+#define MAX_DEVICES	8
+
+#define to_vdev(_pdev) container_of(_pdev, struct uml_vfio_device, pdev)
+
+struct uml_vfio_intr_ctx {
+	struct uml_vfio_device *dev;
+	int irq;
+};
+
+struct uml_vfio_device {
+	const char *name;
+	int group;
+
+	struct um_pci_device pdev;
+	struct uml_vfio_user_device udev;
+	struct uml_vfio_intr_ctx *intr_ctx;
+
+	int msix_cap;
+	int msix_bar;
+	int msix_offset;
+	int msix_size;
+	u32 *msix_data;
+};
+
+static struct {
+	int fd;
+	int users;
+} uml_vfio_container;
+static DEFINE_MUTEX(uml_vfio_container_mtx);
+
+static struct {
+	int id;
+	int fd;
+	int users;
+} uml_vfio_groups[MAX_GROUPS];
+static DEFINE_MUTEX(uml_vfio_groups_mtx);
+
+static struct uml_vfio_device *uml_vfio_devices[MAX_DEVICES];
+
+static int uml_vfio_open_container(void)
+{
+	int fd;
+
+	fd = uml_vfio_user_open_container();
+	if (fd < 0)
+		return fd;
+
+	uml_vfio_container.fd = fd;
+	return 0;
+}
+
+static void uml_vfio_release_container(void)
+{
+	os_close_file(uml_vfio_container.fd);
+}
+
+static int uml_vfio_set_container(int group_fd)
+{
+	int err;
+
+	guard(mutex)(&uml_vfio_container_mtx);
+
+	err = uml_vfio_user_set_container(uml_vfio_container.fd, group_fd);
+	if (err)
+		return err;
+
+	uml_vfio_container.users++;
+	if (uml_vfio_container.users > 1)
+		return 0;
+
+	err = uml_vfio_user_setup_iommu(uml_vfio_container.fd);
+	if (err) {
+		uml_vfio_user_unset_container(uml_vfio_container.fd, group_fd);
+		uml_vfio_container.users--;
+	}
+	return err;
+}
+
+static void uml_vfio_unset_container(int group_fd)
+{
+	guard(mutex)(&uml_vfio_container_mtx);
+
+	uml_vfio_user_unset_container(uml_vfio_container.fd, group_fd);
+	uml_vfio_container.users--;
+}
+
+static int uml_vfio_open_group(int group_id)
+{
+	int free = -1, err, fd, i;
+
+	guard(mutex)(&uml_vfio_groups_mtx);
+
+	for (i = 0; i < MAX_GROUPS; i++) {
+		if (uml_vfio_groups[i].users > 0 &&
+				uml_vfio_groups[i].id == group_id) {
+			uml_vfio_groups[i].users++;
+			return uml_vfio_groups[i].fd;
+		}
+	}
+
+	for (i = 0; i < MAX_GROUPS; i++) {
+		if (uml_vfio_groups[i].users == 0) {
+			free = i;
+			break;
+		}
+	}
+
+	if (free < 0)
+		return -ENOSPC;
+
+	fd = uml_vfio_user_open_group(group_id);
+	if (fd < 0)
+		return fd;
+
+	err = uml_vfio_set_container(fd);
+	if (err) {
+		os_close_file(fd);
+		return err;
+	}
+
+	uml_vfio_groups[free].id = group_id;
+	uml_vfio_groups[free].fd = fd;
+	uml_vfio_groups[free].users = 1;
+
+	return fd;
+}
+
+static int uml_vfio_release_group(int group_fd)
+{
+	int i;
+
+	guard(mutex)(&uml_vfio_groups_mtx);
+
+	for (i = 0; i < MAX_GROUPS; i++) {
+		if (uml_vfio_groups[i].users > 0 &&
+				uml_vfio_groups[i].fd == group_fd)
+			break;
+	}
+
+	if (i == MAX_GROUPS)
+		return -ENOENT;
+
+	uml_vfio_groups[i].users--;
+	if (uml_vfio_groups[i].users > 0)
+		return 0;
+
+	uml_vfio_unset_container(group_fd);
+	os_close_file(group_fd);
+	return 0;
+}
+
+static irqreturn_t uml_vfio_interrupt(int unused, void *opaque)
+{
+	struct uml_vfio_intr_ctx *ctx = opaque;
+	struct uml_vfio_device *dev = ctx->dev;
+	int index = ctx - dev->intr_ctx;
+	int irqfd = dev->udev.irqfd[index];
+	int irq = dev->msix_data[index];
+	uint64_t v;
+	int r;
+
+	do {
+		r = os_read_file(irqfd, &v, sizeof(v));
+		if (r == sizeof(v))
+			generic_handle_irq(irq);
+	} while (r == sizeof(v) || r == -EINTR);
+	WARN(r != -EAGAIN, "read returned %d\n", r);
+
+	return IRQ_HANDLED;
+}
+
+static int uml_vfio_activate_irq(struct uml_vfio_device *dev, int index)
+{
+	struct uml_vfio_intr_ctx *ctx = &dev->intr_ctx[index];
+	int err, irqfd;
+
+	if (ctx->irq >= 0)
+		return 0;
+
+	irqfd = uml_vfio_user_activate_irq(&dev->udev, index);
+	if (irqfd < 0)
+		return irqfd;
+
+	ctx->irq = um_request_irq(UM_IRQ_ALLOC, irqfd, IRQ_READ,
+				  uml_vfio_interrupt, IRQF_SHARED,
+				  "vfio-uml", ctx);
+	if (ctx->irq < 0) {
+		err = ctx->irq;
+		goto deactivate;
+	}
+
+	err = add_sigio_fd(irqfd);
+	if (err)
+		goto free_irq;
+
+	return 0;
+
+free_irq:
+	um_free_irq(ctx->irq, ctx);
+	ctx->irq = -1;
+deactivate:
+	uml_vfio_user_deactivate_irq(&dev->udev, index);
+	return err;
+}
+
+static int uml_vfio_deactivate_irq(struct uml_vfio_device *dev, int index)
+{
+	struct uml_vfio_intr_ctx *ctx = &dev->intr_ctx[index];
+
+	if (ctx->irq >= 0) {
+		ignore_sigio_fd(dev->udev.irqfd[index]);
+		um_free_irq(ctx->irq, ctx);
+		uml_vfio_user_deactivate_irq(&dev->udev, index);
+		ctx->irq = -1;
+	}
+	return 0;
+}
+
+static int uml_vfio_update_msix_cap(struct uml_vfio_device *dev,
+				    unsigned int offset, int size,
+				    unsigned long val)
+{
+	int err = 0;
+
+	if (size == 2 && offset == dev->msix_cap + PCI_MSIX_FLAGS) {
+		switch (val & ~PCI_MSIX_FLAGS_QSIZE) {
+		case PCI_MSIX_FLAGS_ENABLE:
+		case 0:
+			err = uml_vfio_user_update_irqs(&dev->udev);
+			break;
+		}
+	}
+
+	return err;
+}
+
+static int uml_vfio_update_msix_table(struct uml_vfio_device *dev,
+				      unsigned int offset, int size,
+				      unsigned long val)
+{
+	int index;
+
+	offset -= dev->msix_offset + PCI_MSIX_ENTRY_DATA;
+
+	if (size != 4 || offset % PCI_MSIX_ENTRY_SIZE != 0)
+		return 0;
+
+	index = offset / PCI_MSIX_ENTRY_SIZE;
+	if (index >= dev->udev.irq_count)
+		return -EINVAL;
+
+	dev->msix_data[index] = val;
+
+	return val ? uml_vfio_activate_irq(dev, index) :
+		uml_vfio_deactivate_irq(dev, index);
+}
+
+static unsigned long __uml_vfio_cfgspace_read(struct uml_vfio_device *dev,
+					      unsigned int offset, int size)
+{
+	u8 data[8];
+
+	memset(data, 0xff, sizeof(data));
+
+	if (uml_vfio_user_cfgspace_read(&dev->udev, offset, data, size))
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
+static unsigned long uml_vfio_cfgspace_read(struct um_pci_device *pdev,
+					    unsigned int offset, int size)
+{
+	struct uml_vfio_device *dev = to_vdev(pdev);
+
+	return __uml_vfio_cfgspace_read(dev, offset, size);
+}
+
+static void __uml_vfio_cfgspace_write(struct uml_vfio_device *dev,
+				      unsigned int offset, int size,
+				      unsigned long val)
+{
+	u8 data[8];
+
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
+	WARN_ON(uml_vfio_user_cfgspace_write(&dev->udev, offset, data, size));
+}
+
+static void uml_vfio_cfgspace_write(struct um_pci_device *pdev,
+				    unsigned int offset, int size,
+				    unsigned long val)
+{
+	struct uml_vfio_device *dev = to_vdev(pdev);
+
+	if (offset < dev->msix_cap + PCI_CAP_MSIX_SIZEOF &&
+			offset + size > dev->msix_cap)
+		WARN_ON(uml_vfio_update_msix_cap(dev, offset, size, val));
+
+	__uml_vfio_cfgspace_write(dev, offset, size, val);
+}
+
+static void uml_vfio_bar_copy_from(struct um_pci_device *pdev, int bar,
+				   void *buffer, unsigned int offset, int size)
+{
+	struct uml_vfio_device *dev = to_vdev(pdev);
+
+	memset(buffer, 0xff, size);
+	uml_vfio_user_bar_read(&dev->udev, bar, offset, buffer, size);
+}
+
+static unsigned long uml_vfio_bar_read(struct um_pci_device *pdev, int bar,
+				       unsigned int offset, int size)
+{
+	u8 data[8];
+
+	uml_vfio_bar_copy_from(pdev, bar, data, offset, size);
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
+static void uml_vfio_bar_copy_to(struct um_pci_device *pdev, int bar,
+				 unsigned int offset, const void *buffer,
+				 int size)
+{
+	struct uml_vfio_device *dev = to_vdev(pdev);
+
+	uml_vfio_user_bar_write(&dev->udev, bar, offset, buffer, size);
+}
+
+static void uml_vfio_bar_write(struct um_pci_device *pdev, int bar,
+			       unsigned int offset, int size,
+			       unsigned long val)
+{
+	struct uml_vfio_device *dev = to_vdev(pdev);
+	u8 data[8];
+
+	if (bar == dev->msix_bar && offset + size > dev->msix_offset &&
+			offset < dev->msix_offset + dev->msix_size)
+		WARN_ON(uml_vfio_update_msix_table(dev, offset, size, val));
+
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
+	uml_vfio_bar_copy_to(pdev, bar, offset, data, size);
+}
+
+static void uml_vfio_bar_set(struct um_pci_device *pdev, int bar,
+			     unsigned int offset, u8 value, int size)
+{
+	struct uml_vfio_device *dev = to_vdev(pdev);
+	int i;
+
+	for (i = 0; i < size; i++)
+		uml_vfio_user_bar_write(&dev->udev, bar, offset + i, &value, 1);
+}
+
+static const struct um_pci_ops uml_vfio_um_pci_ops = {
+	.cfgspace_read	= uml_vfio_cfgspace_read,
+	.cfgspace_write	= uml_vfio_cfgspace_write,
+	.bar_read	= uml_vfio_bar_read,
+	.bar_write	= uml_vfio_bar_write,
+	.bar_copy_from	= uml_vfio_bar_copy_from,
+	.bar_copy_to	= uml_vfio_bar_copy_to,
+	.bar_set	= uml_vfio_bar_set,
+};
+
+static u8 uml_vfio_find_capability(struct uml_vfio_device *dev, u8 cap)
+{
+	u8 id, pos;
+	u16 ent;
+	int ttl = 48;
+
+	pos = __uml_vfio_cfgspace_read(dev, PCI_CAPABILITY_LIST, sizeof(pos));
+
+	while (pos && ttl--) {
+		ent = __uml_vfio_cfgspace_read(dev, pos, sizeof(ent));
+
+		id = ent & 0xff;
+		if (id == 0xff)
+			break;
+		if (id == cap)
+			return pos;
+
+		pos = ent >> 8;
+	}
+
+	return 0;
+}
+
+static int uml_vfio_read_msix_table(struct uml_vfio_device *dev)
+{
+	unsigned int off;
+	u16 flags;
+	u32 tbl;
+
+	off = uml_vfio_find_capability(dev, PCI_CAP_ID_MSIX);
+	if (!off)
+		return -ENOTSUPP;
+
+	dev->msix_cap = off;
+
+	tbl = __uml_vfio_cfgspace_read(dev, off + PCI_MSIX_TABLE, sizeof(tbl));
+	flags = __uml_vfio_cfgspace_read(dev, off + PCI_MSIX_FLAGS, sizeof(flags));
+
+	dev->msix_bar = tbl & PCI_MSIX_TABLE_BIR;
+	dev->msix_offset = tbl & PCI_MSIX_TABLE_OFFSET;
+	dev->msix_size = ((flags & PCI_MSIX_FLAGS_QSIZE) + 1) * PCI_MSIX_ENTRY_SIZE;
+
+	dev->msix_data = kzalloc(dev->msix_size, GFP_KERNEL);
+	if (!dev->msix_data)
+		return -ENOMEM;
+
+	return 0;
+}
+
+static int uml_vfio_open_device(struct uml_vfio_device *dev)
+{
+	struct uml_vfio_intr_ctx *ctx;
+	int err, group_id, i;
+
+	group_id = uml_vfio_user_get_group_id(dev->name);
+	if (group_id < 0)
+		return group_id;
+
+	dev->group = uml_vfio_open_group(group_id);
+	if (dev->group < 0)
+		return dev->group;
+
+	err = uml_vfio_user_setup_device(&dev->udev, dev->group, dev->name);
+	if (err)
+		goto release_group;
+
+	err = uml_vfio_read_msix_table(dev);
+	if (err)
+		goto teardown_udev;
+
+	dev->intr_ctx = kmalloc_array(dev->udev.irq_count,
+				      sizeof(struct uml_vfio_intr_ctx),
+				      GFP_KERNEL);
+	if (!dev->intr_ctx) {
+		err = -ENOMEM;
+		goto free_msix;
+	}
+
+	for (i = 0; i < dev->udev.irq_count; i++) {
+		ctx = &dev->intr_ctx[i];
+		ctx->dev = dev;
+		ctx->irq = -1;
+	}
+
+	dev->pdev.ops = &uml_vfio_um_pci_ops;
+
+	err = um_pci_device_register(&dev->pdev);
+	if (err)
+		goto free_intr_ctx;
+
+	return 0;
+
+free_intr_ctx:
+	kfree(dev->intr_ctx);
+free_msix:
+	kfree(dev->msix_data);
+teardown_udev:
+	uml_vfio_user_teardown_device(&dev->udev);
+release_group:
+	uml_vfio_release_group(dev->group);
+	return err;
+}
+
+static void uml_vfio_release_device(struct uml_vfio_device *dev)
+{
+	int i;
+
+	for (i = 0; i < dev->udev.irq_count; i++)
+		uml_vfio_deactivate_irq(dev, i);
+
+	uml_vfio_user_update_irqs(&dev->udev);
+	um_pci_device_unregister(&dev->pdev);
+	kfree(dev->intr_ctx);
+	kfree(dev->msix_data);
+	uml_vfio_user_teardown_device(&dev->udev);
+	uml_vfio_release_group(dev->group);
+	kfree(dev->name);
+	kfree(dev);
+}
+
+static int uml_vfio_cmdline_set(const char *device, const struct kernel_param *kp)
+{
+	struct uml_vfio_device *dev;
+	int free = -1, i;
+
+	for (i = 0; i < MAX_DEVICES; i++) {
+		if (uml_vfio_devices[i])
+			continue;
+		free = i;
+		break;
+	}
+
+	if (free < 0)
+		return -ENOSPC;
+
+	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
+	if (!dev)
+		return -ENOMEM;
+
+	dev->name = kstrdup(device, GFP_KERNEL);
+	if (!dev->name) {
+		kfree(dev);
+		return -ENOMEM;
+	}
+
+	uml_vfio_devices[free] = dev;
+	return 0;
+}
+
+static int uml_vfio_cmdline_get(char *buffer, const struct kernel_param *kp)
+{
+	return 0;
+}
+
+static const struct kernel_param_ops uml_vfio_cmdline_param_ops = {
+	.set = uml_vfio_cmdline_set,
+	.get = uml_vfio_cmdline_get,
+};
+
+device_param_cb(device, &uml_vfio_cmdline_param_ops, NULL, 0400);
+__uml_help(uml_vfio_cmdline_param_ops,
+"vfio_uml.device=<domain:bus:slot.function>\n"
+"    Pass through a PCI device to UML via VFIO. Currently, only MSI-X\n"
+"    capable devices are supported, and it is assumed that drivers will\n"
+"    use MSI-X. This parameter can be specified multiple times to pass\n"
+"    through multiple PCI devices to UML.\n\n"
+);
+
+static int __init uml_vfio_init(void)
+{
+	struct uml_vfio_device *dev;
+	int err, i;
+
+	sigio_broken();
+
+	err = uml_vfio_open_container();
+	if (err)
+		return err;
+
+	for (i = 0; i < MAX_DEVICES; i++) {
+		dev = uml_vfio_devices[i];
+		if (!dev)
+			break;
+		err = uml_vfio_open_device(dev);
+		if (err)
+			printk(KERN_ERR "uml_vfio open device (%s) failed, error %d\n",
+			       dev->name, err);
+	}
+
+	return 0;
+}
+late_initcall(uml_vfio_init);
+
+static void __exit uml_vfio_exit(void)
+{
+	struct uml_vfio_device *dev;
+	int i;
+
+	for (i = 0; i < MAX_DEVICES; i++) {
+		dev = uml_vfio_devices[i];
+		if (!dev)
+			break;
+		uml_vfio_release_device(dev);
+	}
+
+	uml_vfio_release_container();
+}
+module_exit(uml_vfio_exit);
diff --git a/arch/um/drivers/vfio_user.c b/arch/um/drivers/vfio_user.c
new file mode 100644
index 000000000000..0a97e367fc59
--- /dev/null
+++ b/arch/um/drivers/vfio_user.c
@@ -0,0 +1,323 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2025 Ant Group
+ * Author: Tiwei Bie <tiwei.btw@antgroup.com>
+ */
+#include <errno.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdlib.h>
+#include <string.h>
+#include <sys/ioctl.h>
+#include <sys/eventfd.h>
+#include <linux/limits.h>
+#include <linux/vfio.h>
+#include <linux/pci_regs.h>
+#include <as-layout.h>
+#include <um_malloc.h>
+
+#include "vfio_user.h"
+
+int uml_vfio_user_open_container(void)
+{
+	int r, fd;
+
+	fd = open("/dev/vfio/vfio", O_RDWR);
+	if (fd < 0)
+		return -errno;
+
+	r = ioctl(fd, VFIO_GET_API_VERSION);
+	if (r != VFIO_API_VERSION) {
+		r = r < 0 ? -errno : -EINVAL;
+		goto error;
+	}
+
+	r = ioctl(fd, VFIO_CHECK_EXTENSION, VFIO_TYPE1_IOMMU);
+	if (r <= 0) {
+		r = r < 0 ? -errno : -EINVAL;
+		goto error;
+	}
+
+	return fd;
+
+error:
+	close(fd);
+	return r;
+}
+
+int uml_vfio_user_setup_iommu(int container)
+{
+	unsigned long reserved = uml_reserved - uml_physmem;
+	struct vfio_iommu_type1_dma_map dma_map = {
+		.argsz = sizeof(dma_map),
+		.flags = VFIO_DMA_MAP_FLAG_READ | VFIO_DMA_MAP_FLAG_WRITE,
+		.vaddr = uml_reserved,
+		.iova = reserved,
+		.size = physmem_size - reserved,
+	};
+
+	if (ioctl(container, VFIO_SET_IOMMU, VFIO_TYPE1_IOMMU) < 0)
+		return -errno;
+
+	if (ioctl(container, VFIO_IOMMU_MAP_DMA, &dma_map) < 0)
+		return -errno;
+
+	return 0;
+}
+
+int uml_vfio_user_get_group_id(const char *device)
+{
+	char *path, *buf, *end;
+	const char *name;
+	int r;
+
+	path = uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
+	if (!path)
+		return -ENOMEM;
+
+	sprintf(path, "/sys/bus/pci/devices/%s/iommu_group", device);
+
+	buf = uml_kmalloc(PATH_MAX + 1, UM_GFP_KERNEL);
+	if (!buf) {
+		r = -ENOMEM;
+		goto free_path;
+	}
+
+	r = readlink(path, buf, PATH_MAX);
+	if (r < 0) {
+		r = -errno;
+		goto free_buf;
+	}
+	buf[r] = '\0';
+
+	name = basename(buf);
+
+	r = strtoul(name, &end, 10);
+	if (*end != '\0' || end == name) {
+		r = -EINVAL;
+		goto free_buf;
+	}
+
+free_buf:
+	kfree(buf);
+free_path:
+	kfree(path);
+	return r;
+}
+
+int uml_vfio_user_open_group(int group_id)
+{
+	char *path;
+	int fd;
+
+	path = uml_kmalloc(PATH_MAX, UM_GFP_KERNEL);
+	if (!path)
+		return -ENOMEM;
+
+	sprintf(path, "/dev/vfio/%d", group_id);
+
+	fd = open(path, O_RDWR);
+	if (fd < 0) {
+		fd = -errno;
+		goto out;
+	}
+
+out:
+	kfree(path);
+	return fd;
+}
+
+int uml_vfio_user_set_container(int container, int group)
+{
+	if (ioctl(group, VFIO_GROUP_SET_CONTAINER, &container) < 0)
+		return -errno;
+	return 0;
+}
+
+int uml_vfio_user_unset_container(int container, int group)
+{
+	if (ioctl(group, VFIO_GROUP_UNSET_CONTAINER, &container) < 0)
+		return -errno;
+	return 0;
+}
+
+static int vfio_set_irqs(int device, int start, int count, int *irqfd)
+{
+	struct vfio_irq_set *irq_set;
+	int argsz = sizeof(*irq_set) + sizeof(*irqfd) * count;
+	int err = 0;
+
+	irq_set = uml_kmalloc(argsz, UM_GFP_KERNEL);
+	if (!irq_set)
+		return -ENOMEM;
+
+	irq_set->argsz = argsz;
+	irq_set->flags = VFIO_IRQ_SET_DATA_EVENTFD | VFIO_IRQ_SET_ACTION_TRIGGER;
+	irq_set->index = VFIO_PCI_MSIX_IRQ_INDEX;
+	irq_set->start = start;
+	irq_set->count = count;
+	memcpy(irq_set->data, irqfd, sizeof(*irqfd) * count);
+
+	if (ioctl(device, VFIO_DEVICE_SET_IRQS, irq_set) < 0) {
+		err = -errno;
+		goto out;
+	}
+
+out:
+	kfree(irq_set);
+	return err;
+}
+
+int uml_vfio_user_setup_device(struct uml_vfio_user_device *dev,
+			       int group, const char *device)
+{
+	struct vfio_device_info device_info = { .argsz = sizeof(device_info) };
+	struct vfio_irq_info irq_info = { .argsz = sizeof(irq_info) };
+	int err, i;
+
+	dev->device = ioctl(group, VFIO_GROUP_GET_DEVICE_FD, device);
+	if (dev->device < 0)
+		return -errno;
+
+	if (ioctl(dev->device, VFIO_DEVICE_GET_INFO, &device_info) < 0) {
+		err = -errno;
+		goto close_device;
+	}
+
+	dev->num_regions = device_info.num_regions;
+	if (dev->num_regions > VFIO_PCI_CONFIG_REGION_INDEX + 1)
+		dev->num_regions = VFIO_PCI_CONFIG_REGION_INDEX + 1;
+
+	dev->region = uml_kmalloc(sizeof(*dev->region) * dev->num_regions,
+				  UM_GFP_KERNEL);
+	if (!dev->region) {
+		err = -ENOMEM;
+		goto close_device;
+	}
+
+	for (i = 0; i < dev->num_regions; i++) {
+		struct vfio_region_info region = {
+			.argsz = sizeof(region),
+			.index = i,
+		};
+		if (ioctl(dev->device, VFIO_DEVICE_GET_REGION_INFO, &region) < 0) {
+			err = -errno;
+			goto free_region;
+		}
+		dev->region[i].size = region.size;
+		dev->region[i].offset = region.offset;
+	}
+
+	/* Only MSI-X is supported currently. */
+	irq_info.index = VFIO_PCI_MSIX_IRQ_INDEX;
+	if (ioctl(dev->device, VFIO_DEVICE_GET_IRQ_INFO, &irq_info) < 0) {
+		err = -errno;
+		goto free_region;
+	}
+
+	dev->irq_count = irq_info.count;
+
+	dev->irqfd = uml_kmalloc(sizeof(int) * dev->irq_count, UM_GFP_KERNEL);
+	if (!dev->irqfd) {
+		err = -ENOMEM;
+		goto free_region;
+	}
+
+	memset(dev->irqfd, -1, sizeof(int) * dev->irq_count);
+
+	err = vfio_set_irqs(dev->device, 0, dev->irq_count, dev->irqfd);
+	if (err)
+		goto free_irqfd;
+
+	return 0;
+
+free_irqfd:
+	kfree(dev->irqfd);
+free_region:
+	kfree(dev->region);
+close_device:
+	close(dev->device);
+	return err;
+}
+
+void uml_vfio_user_teardown_device(struct uml_vfio_user_device *dev)
+{
+	kfree(dev->irqfd);
+	kfree(dev->region);
+	close(dev->device);
+}
+
+int uml_vfio_user_activate_irq(struct uml_vfio_user_device *dev, int index)
+{
+	int irqfd;
+
+	irqfd = eventfd(0, EFD_NONBLOCK | EFD_CLOEXEC);
+	if (irqfd < 0)
+		return -errno;
+
+	dev->irqfd[index] = irqfd;
+	return irqfd;
+}
+
+void uml_vfio_user_deactivate_irq(struct uml_vfio_user_device *dev, int index)
+{
+	close(dev->irqfd[index]);
+	dev->irqfd[index] = -1;
+}
+
+int uml_vfio_user_update_irqs(struct uml_vfio_user_device *dev)
+{
+	return vfio_set_irqs(dev->device, 0, dev->irq_count, dev->irqfd);
+}
+
+static int vfio_region_read(struct uml_vfio_user_device *dev, unsigned int index,
+			    uint64_t offset, void *buf, uint64_t size)
+{
+	if (index >= dev->num_regions || offset + size > dev->region[index].size)
+		return -EINVAL;
+
+	if (pread(dev->device, buf, size, dev->region[index].offset + offset) < 0)
+		return -errno;
+
+	return 0;
+}
+
+static int vfio_region_write(struct uml_vfio_user_device *dev, unsigned int index,
+			     uint64_t offset, const void *buf, uint64_t size)
+{
+	if (index >= dev->num_regions || offset + size > dev->region[index].size)
+		return -EINVAL;
+
+	if (pwrite(dev->device, buf, size, dev->region[index].offset + offset) < 0)
+		return -errno;
+
+	return 0;
+}
+
+int uml_vfio_user_cfgspace_read(struct uml_vfio_user_device *dev,
+				unsigned int offset, void *buf, int size)
+{
+	return vfio_region_read(dev, VFIO_PCI_CONFIG_REGION_INDEX,
+				offset, buf, size);
+}
+
+int uml_vfio_user_cfgspace_write(struct uml_vfio_user_device *dev,
+				 unsigned int offset, const void *buf, int size)
+{
+	return vfio_region_write(dev, VFIO_PCI_CONFIG_REGION_INDEX,
+				 offset, buf, size);
+}
+
+int uml_vfio_user_bar_read(struct uml_vfio_user_device *dev, int bar,
+			   unsigned int offset, void *buf, int size)
+{
+	return vfio_region_read(dev, bar, offset, buf, size);
+}
+
+int uml_vfio_user_bar_write(struct uml_vfio_user_device *dev, int bar,
+			    unsigned int offset, const void *buf, int size)
+{
+	return vfio_region_write(dev, bar, offset, buf, size);
+}
diff --git a/arch/um/drivers/vfio_user.h b/arch/um/drivers/vfio_user.h
new file mode 100644
index 000000000000..75535e05059b
--- /dev/null
+++ b/arch/um/drivers/vfio_user.h
@@ -0,0 +1,44 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __UM_VFIO_USER_H
+#define __UM_VFIO_USER_H
+
+struct uml_vfio_user_device {
+	int device;
+
+	struct {
+		uint64_t size;
+		uint64_t offset;
+	} *region;
+	int num_regions;
+
+	int32_t *irqfd;
+	int irq_count;
+};
+
+int uml_vfio_user_open_container(void);
+int uml_vfio_user_setup_iommu(int container);
+
+int uml_vfio_user_get_group_id(const char *device);
+int uml_vfio_user_open_group(int group_id);
+int uml_vfio_user_set_container(int container, int group);
+int uml_vfio_user_unset_container(int container, int group);
+
+int uml_vfio_user_setup_device(struct uml_vfio_user_device *dev,
+			       int group, const char *device);
+void uml_vfio_user_teardown_device(struct uml_vfio_user_device *dev);
+
+int uml_vfio_user_activate_irq(struct uml_vfio_user_device *dev, int index);
+void uml_vfio_user_deactivate_irq(struct uml_vfio_user_device *dev, int index);
+int uml_vfio_user_update_irqs(struct uml_vfio_user_device *dev);
+
+int uml_vfio_user_cfgspace_read(struct uml_vfio_user_device *dev,
+				unsigned int offset, void *buf, int size);
+int uml_vfio_user_cfgspace_write(struct uml_vfio_user_device *dev,
+				 unsigned int offset, const void *buf, int size);
+
+int uml_vfio_user_bar_read(struct uml_vfio_user_device *dev, int bar,
+			   unsigned int offset, void *buf, int size);
+int uml_vfio_user_bar_write(struct uml_vfio_user_device *dev, int bar,
+			    unsigned int offset, const void *buf, int size);
+
+#endif /* __UM_VFIO_USER_H */
-- 
2.34.1


