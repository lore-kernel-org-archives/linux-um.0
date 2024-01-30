Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DC63C47DB3
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 00:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TIBqd30J1uhjGz5knNS/C4pTyLqd1imCwWPxTABhylI=; b=1S/bj8V0VSDN3ji/XUDtQWZMYt
	t3KC2rAOpHsjMDoNHK/a2tUuw6uViTFXm7kBaxm7MV0qrXivppjDtbWNnDwQJ70GeNq4N6cuhn8Pi
	yuJASqaXOh2i9rLfb6S19dIhsqlWyQaqeD5U5ImhRriZvW6HbeWV+Ud9zVEuLs7sKq0f9/8dppG4n
	njLd0auZWI9t3WeFvXH3EptFFyUeilJw2tu94jEbkNTTca+Q1dHAxDCUmGj08RX+TfXJL9xcB43L6
	htBIm5JeaanrVEYxPCAEjq6WJjwmzw4Psm/EkFibcWON4TM3Vf2tgsO171kZtn5OtcuPw/kgV7BOG
	bVnrxW6A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcG2-0000000Ejjl-2xWs;
	Tue, 30 Jan 2024 00:45:46 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUcFW-0000000EjPS-3OS5;
	Tue, 30 Jan 2024 00:45:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4FB41625A8;
	Tue, 30 Jan 2024 00:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1F29C433C7;
	Tue, 30 Jan 2024 00:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706575514;
	bh=hmcfZcHfNINwBnAg8u+eyBX+W/WQoRq0BbThFhRJmxg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A6YZnVONJIKoy/aVneDUKE/lqzWcU2BV1YPk4r+b+C9I38byOmV9GCQn+hoctkyW6
	 LYVIFGJRtQujgpvrTeirMXRuUVx8a/ulHPU4mxeeBAj9AEGfvZr/OUUT42u225TeR8
	 t7I4K6v3OxP/6nVIFrzs6cPOi9ubK8zGJvYCVML1PTxYkbzxt0Uf2KLIFfjRmNL5sZ
	 2RdWip4f+M5eU03Xl9IIoLxvUuAnaPmI5xkWjTnOB3afu9RPVJtf6LBbz+sqKGjmUV
	 PmK049tUWVQqQzN3yLMG0xH47ynpdvOZiG8w+XqOUgTh3cNuSIwHZqX85wB8g+oUkG
	 eW/9F4M5gh2KA==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>,
	linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: [PATCH v2 5/7] of: Create of_root if no dtb provided by firmware
Date: Mon, 29 Jan 2024 16:45:04 -0800
Message-ID: <20240130004508.1700335-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.429.g432eaa2c6b-goog
In-Reply-To: <20240130004508.1700335-1-sboyd@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240129_164514_981628_7FC70B16 
X-CRM114-Status: GOOD (  21.97  )
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

From: Frank Rowand <frowand.list@gmail.com>

When enabling CONFIG_OF on a platform where 'of_root' is not populated
by firmware, we end up without a root node. In order to apply overlays
and create subnodes of the root node, we need one. Create this root node
by unflattening an empty builtin dtb.

If firmware provides a flattened device tree (FDT) then the FDT is
unflattened via setup_arch(). Otherwise, the call to
unflatten(_and_copy)?_device_tree() will create an empty root node.

We make of_have_populated_dt() return true only if the DTB was loaded by
firmware so that existing callers don't change behavior after this
patch. The call in the of platform code is removed because it prevents
overlays from creating platform devices when the platform bus isn't
fully initialized.

Signed-off-by: Frank Rowand <frowand.list@gmail.com>
Link: https://lore.kernel.org/r/20230317053415.2254616-2-frowand.list@gmail.com
Cc: Rob Herring <robh+dt@kernel.org>
[sboyd@kernel.org: Update of_have_populated_dt() to treat this empty dtb
as not populated. Drop setup_of() initcall]
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/Kconfig        |  2 +-
 drivers/of/Makefile       |  2 +-
 drivers/of/empty_root.dts |  6 ++++++
 drivers/of/fdt.c          | 20 ++++++++++++++++++++
 drivers/of/platform.c     |  3 ---
 include/linux/of.h        | 25 +++++++++++++++----------
 6 files changed, 43 insertions(+), 15 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index da9826accb1b..17733285b415 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -54,7 +54,7 @@ config OF_FLATTREE
 	select CRC32
 
 config OF_EARLY_FLATTREE
-	bool
+	def_bool OF && !SPARC
 	select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
 	select OF_FLATTREE
 
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index eff624854575..df305348d1cb 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -2,7 +2,7 @@
 obj-y = base.o cpu.o device.o module.o platform.o property.o
 obj-$(CONFIG_OF_KOBJ) += kobj.o
 obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
-obj-$(CONFIG_OF_FLATTREE) += fdt.o
+obj-$(CONFIG_OF_FLATTREE) += fdt.o empty_root.dtb.o
 obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
 obj-$(CONFIG_OF_PROMTREE) += pdt.o
 obj-$(CONFIG_OF_ADDRESS)  += address.o
diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
new file mode 100644
index 000000000000..cf9e97a60f48
--- /dev/null
+++ b/drivers/of/empty_root.dts
@@ -0,0 +1,6 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/dts-v1/;
+
+/ {
+
+};
diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
index b488ad86d456..f7dd7fd68d4d 100644
--- a/drivers/of/fdt.c
+++ b/drivers/of/fdt.c
@@ -32,6 +32,13 @@
 
 #include "of_private.h"
 
+/*
+ * __dtb_empty_root_begin[] and __dtb_empty_root_end[] magically created by
+ * cmd_dt_S_dtb in scripts/Makefile.lib
+ */
+extern uint8_t __dtb_empty_root_begin[];
+extern uint8_t __dtb_empty_root_end[];
+
 /*
  * of_fdt_limit_memory - limit the number of regions in the /memory node
  * @limit: maximum entries
@@ -1343,6 +1350,19 @@ static void __init copy_device_tree(void)
  */
 void __init unflatten_device_tree(void)
 {
+	if (!initial_boot_params) {
+		initial_boot_params = (void *) __dtb_empty_root_begin;
+		/* fdt_totalsize() will be used for copy size */
+		if (fdt_totalsize(initial_boot_params) >
+		    __dtb_empty_root_end - __dtb_empty_root_begin) {
+			pr_err("invalid size in dtb_empty_root\n");
+			return;
+		}
+		of_fdt_crc32 = crc32_be(~0, initial_boot_params,
+					fdt_totalsize(initial_boot_params));
+		copy_device_tree();
+	}
+
 	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch, false);
 
diff --git a/drivers/of/platform.c b/drivers/of/platform.c
index 126d265aa7d8..20087bb8a46b 100644
--- a/drivers/of/platform.c
+++ b/drivers/of/platform.c
@@ -549,9 +549,6 @@ static int __init of_platform_default_populate_init(void)
 
 	device_links_supplier_sync_state_pause();
 
-	if (!of_have_populated_dt())
-		return -ENODEV;
-
 	if (IS_ENABLED(CONFIG_PPC)) {
 		struct device_node *boot_display = NULL;
 		struct platform_device *dev;
diff --git a/include/linux/of.h b/include/linux/of.h
index 6a9ddf20e79a..52f6ad6a1c8c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -180,11 +180,6 @@ static inline bool is_of_node(const struct fwnode_handle *fwnode)
 			&__of_fwnode_handle_node->fwnode : NULL;	\
 	})
 
-static inline bool of_have_populated_dt(void)
-{
-	return of_root != NULL;
-}
-
 static inline bool of_node_is_root(const struct device_node *node)
 {
 	return node && (node->parent == NULL);
@@ -549,11 +544,6 @@ static inline struct device_node *of_find_node_with_property(
 
 #define of_fwnode_handle(node) NULL
 
-static inline bool of_have_populated_dt(void)
-{
-	return false;
-}
-
 static inline struct device_node *of_get_compatible_child(const struct device_node *parent,
 					const char *compatible)
 {
@@ -1634,6 +1624,21 @@ static inline bool of_device_is_system_power_controller(const struct device_node
 	return of_property_read_bool(np, "system-power-controller");
 }
 
+/**
+ * of_have_populated_dt() - Has DT been populated by bootloader
+ *
+ * Return: True if a DTB has been populated by the bootloader and it isn't the
+ * empty builtin one. False otherwise.
+ */
+static inline bool of_have_populated_dt(void)
+{
+#ifdef CONFIG_OF
+	return of_property_present(of_root, "compatible");
+#else
+	return false;
+#endif
+}
+
 /*
  * Overlay support
  */
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


