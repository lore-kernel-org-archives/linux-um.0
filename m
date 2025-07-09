Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99DEEC8303C
	for <linux-um@archiver.kernel.org>; Wed,  9 Jul 2025 01:03:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=KUes+pvnOUBSbxy5FPhcBKPRHsW9eKlDNNaghADkyt4=; b=vUu922Idigr9gWrduYhtFkW1j7
	oqtDLTPhIEmYBgGEw9M8lz8CHnnuczZy4D1hZGcmOON97qv15DxkXvz4t3w4jYCmzPj2nBgBDvjgP
	uXx6QongaeREsYnHYrI0XoIU5zOoV9/pQR2B9TXvxZAD88Aw9nN1aZQlBAIHceqtuIG9ikRT3MFXC
	dcKSws/gxFEZ0Xq7pj5hXUmWiE1qo4CafN5zFRn0kMbLbuTayYoE/fmSnQ0sAM6wu1xd4Tp7fJJTN
	Z8T13R3ECRhHrXEctx0oWmrjw1jWQmas4W5CnoJLUP1YToHor6QXLzJdqRz+TMh87Q24W1W11ogAV
	h9bVSMSg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZJDm-0000000746x-0skO;
	Wed, 09 Jul 2025 01:03:38 +0000
Received: from out-172.mta1.migadu.com ([2001:41d0:203:375::ac])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uZJBN-000000073Tg-2ElT
	for linux-um@lists.infradead.org;
	Wed, 09 Jul 2025 01:01:13 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1752022864;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KUes+pvnOUBSbxy5FPhcBKPRHsW9eKlDNNaghADkyt4=;
	b=RqNINch1hFrDCLz8Ta9JQ229t8mpxqyiRrj3cd2jewdeFsXjAkkf9OK2R64x1KFL2wG6x7
	0uG0A0POcuDQhc9aqOW5IRnc2ly9MjDtHgYVBUXwGP0WMJ1gD3w7G2jVFXvKlqm14skOY9
	s+Mfdj1J0lHMMTktCG4CzeSq57Lgcxc=
From: Tiwei Bie <tiwei.bie@linux.dev>
To: richard@nod.at,
	anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net
Cc: linux-um@lists.infradead.org,
	tiwei.btw@antgroup.com,
	tiwei.bie@linux.dev
Subject: [PATCH] um: vfio: Support adding devices via mconsole
Date: Wed,  9 Jul 2025 09:00:21 +0800
Message-Id: <20250709010021.1076902-1-tiwei.bie@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250708_180109_865889_BFCE9020 
X-CRM114-Status: GOOD (  13.43  )
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

From: Tiwei Bie <tiwei.btw@antgroup.com>

It can be used when we want to pass through PCI devices to UML
while it's up and running. PCI devices can be passed through to
UML using the same syntax as the command line option:

(mconsole) config vfio_uml.device=<domain:bus:slot.function>

Signed-off-by: Tiwei Bie <tiwei.btw@antgroup.com>
---
 arch/um/drivers/vfio_kern.c | 62 ++++++++++++++++++++++++++++++++++---
 1 file changed, 57 insertions(+), 5 deletions(-)

diff --git a/arch/um/drivers/vfio_kern.c b/arch/um/drivers/vfio_kern.c
index 13b971a2bd43..915812a79bfc 100644
--- a/arch/um/drivers/vfio_kern.c
+++ b/arch/um/drivers/vfio_kern.c
@@ -16,6 +16,7 @@
 #include <init.h>
 #include <os.h>
 
+#include "mconsole_kern.h"
 #include "virt-pci.h"
 #include "vfio_user.h"
 
@@ -60,6 +61,7 @@ static LIST_HEAD(uml_vfio_groups);
 static DEFINE_MUTEX(uml_vfio_groups_mtx);
 
 static LIST_HEAD(uml_vfio_devices);
+static DEFINE_MUTEX(uml_vfio_devices_mtx);
 
 static int uml_vfio_set_container(int group_fd)
 {
@@ -581,32 +583,44 @@ static struct uml_vfio_device *uml_vfio_find_device(const char *device)
 	return NULL;
 }
 
-static int uml_vfio_cmdline_set(const char *device, const struct kernel_param *kp)
+static struct uml_vfio_device *uml_vfio_add_device(const char *device)
 {
 	struct uml_vfio_device *dev;
 	int fd;
 
+	guard(mutex)(&uml_vfio_devices_mtx);
+
 	if (uml_vfio_container.fd < 0) {
 		fd = uml_vfio_user_open_container();
 		if (fd < 0)
-			return fd;
+			return ERR_PTR(fd);
 		uml_vfio_container.fd = fd;
 	}
 
 	if (uml_vfio_find_device(device))
-		return -EEXIST;
+		return ERR_PTR(-EEXIST);
 
 	dev = kzalloc(sizeof(*dev), GFP_KERNEL);
 	if (!dev)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	dev->name = kstrdup(device, GFP_KERNEL);
 	if (!dev->name) {
 		kfree(dev);
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 	}
 
 	list_add_tail(&dev->list, &uml_vfio_devices);
+	return dev;
+}
+
+static int uml_vfio_cmdline_set(const char *device, const struct kernel_param *kp)
+{
+	struct uml_vfio_device *dev;
+
+	dev = uml_vfio_add_device(device);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
 	return 0;
 }
 
@@ -629,6 +643,42 @@ __uml_help(uml_vfio_cmdline_param_ops,
 "    through multiple PCI devices to UML.\n\n"
 );
 
+static int uml_vfio_mc_config(char *str, char **error_out)
+{
+	struct uml_vfio_device *dev;
+
+	if (*str != '=') {
+		*error_out = "Invalid config";
+		return -EINVAL;
+	}
+	str += 1;
+
+	dev = uml_vfio_add_device(str);
+	if (IS_ERR(dev))
+		return PTR_ERR(dev);
+	uml_vfio_open_device(dev);
+	return 0;
+}
+
+static int uml_vfio_mc_id(char **str, int *start_out, int *end_out)
+{
+	return -EOPNOTSUPP;
+}
+
+static int uml_vfio_mc_remove(int n, char **error_out)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct mc_device uml_vfio_mc = {
+	.list           = LIST_HEAD_INIT(uml_vfio_mc.list),
+	.name           = "vfio_uml.device",
+	.config         = uml_vfio_mc_config,
+	.get_config     = NULL,
+	.id             = uml_vfio_mc_id,
+	.remove         = uml_vfio_mc_remove,
+};
+
 static int __init uml_vfio_init(void)
 {
 	struct uml_vfio_device *dev, *n;
@@ -639,6 +689,8 @@ static int __init uml_vfio_init(void)
 	list_for_each_entry_safe(dev, n, &uml_vfio_devices, list)
 		uml_vfio_open_device(dev);
 
+	mconsole_register_dev(&uml_vfio_mc);
+
 	return 0;
 }
 late_initcall(uml_vfio_init);
-- 
2.34.1


