Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAFE9C4707C
	for <linux-um@archiver.kernel.org>; Fri, 12 Jan 2024 20:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vYDNvjesHTlIKCLwARGSpPK6wQdhLLHXvDXOfnsqfY4=; b=i9w4Mfr2h1aXGF0eGFDwZSx5qZ
	vJ9qeUsvRGaQCjdt2djw6p1N65/9TONmDs53B1Sn0BqZfcJ7WmVnj3g+vU/bIbOX6L0aK7p4pNiJJ
	4xhPeV2ZxXFsHAJe+DM0pEhJCQBs0QxyRGyl7+nhY4gvPsa/+HdDAJH8bHa73WFW9y3QuzHxJfoO8
	56koDa/ocqCzgzYj/nN3/TtH+gmoP3UHPXcNCTdiAj+Xi8W3GPz7dNcZO08aLPxwyzuFfBR6jVPs7
	KDzGUtw3No8Z+vR4RvinIluX5l+hlWqCeF2DqkhB/6vyivq9EPHnrAxz7LFDzKNGtuELYsmTbWvm9
	X02b2iVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rONox-003tyF-0u;
	Fri, 12 Jan 2024 20:08:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rONop-003trL-0p;
	Fri, 12 Jan 2024 20:07:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id C4C9361E45;
	Fri, 12 Jan 2024 20:07:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38EF9C43330;
	Fri, 12 Jan 2024 20:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705090074;
	bh=MuWj9QthPbddxDViv2xChMAB0LdAS5I6Shz2oVWlz/w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m3UzQdLzZZdjwFvzHAWKEZvD+Cab42B2q+YSDYLoUkgxb/afWAm1K1HVbEB8T4DR2
	 /7dW3Tl6B1DKqIqirS1GFyUUIuXDtHKXx/TdmLut2lEOlHbTKSzOcapo/y+c1CsZBy
	 IBdCFlo+yIHwTyrI9wVqWTw5R1G1R4xxFQzaV5ml53zkC+9RaY/rPhNkq4Bl7lGbF5
	 gNZ0vLdeAxjow231PQuZlOYCrUywTxNNNOCfJm/ecN4cphX4A8tcoREDq0x5sEusaj
	 xTdxP4DC6qiX2VyfFo3NxQs4wULNxInbgVOxKN2vXrjcIqnore+og7lRFLJZWOxc6G
	 AMmuiqio79Q2Q==
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
Subject: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
Date: Fri, 12 Jan 2024 12:07:47 -0800
Message-ID: <20240112200750.4062441-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
In-Reply-To: <20240112200750.4062441-1-sboyd@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240112_120755_379797_B59D68A2 
X-CRM114-Status: GOOD (  25.50  )
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
 drivers/of/Kconfig        |  7 ++++++-
 drivers/of/Makefile       |  2 +-
 drivers/of/empty_root.dts |  6 ++++++
 drivers/of/fdt.c          | 25 +++++++++++++++++++++++++
 drivers/of/platform.c     |  3 ---
 include/linux/of.h        | 17 ++++++++++++-----
 6 files changed, 50 insertions(+), 10 deletions(-)
 create mode 100644 drivers/of/empty_root.dts

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index da9826accb1b..9628e48baa15 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -54,9 +54,14 @@ config OF_FLATTREE
 	select CRC32
 
 config OF_EARLY_FLATTREE
-	bool
+	bool "Functions for accessing Flat Devicetree (FDT) early in boot"
 	select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
 	select OF_FLATTREE
+	help
+	  Normally selected by platforms that process an FDT that has been
+	  passed to the kernel by the bootloader.  If the bootloader does not
+	  pass an FDT to the kernel and you need an empty devicetree that
+	  contains only a root node to exist, then say Y here.
 
 config OF_PROMTREE
 	bool
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
index b488ad86d456..9fc7f8b4f48a 100644
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
@@ -1343,8 +1350,26 @@ static void __init copy_device_tree(void)
  */
 void __init unflatten_device_tree(void)
 {
+	bool firmware_loaded = true;
+
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
+		firmware_loaded = false;
+	}
+
 	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
 				early_init_dt_alloc_memory_arch, false);
+	if (!firmware_loaded)
+		of_node_set_flag(of_root, OF_EMPTY_ROOT);
 
 	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
 	of_alias_scan(early_init_dt_alloc_memory_arch);
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
index 6a9ddf20e79a..390ad961ef01 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -151,6 +151,7 @@ extern struct device_node *of_stdout;
 #define OF_POPULATED_BUS	4 /* platform bus created for children */
 #define OF_OVERLAY		5 /* allocated for an overlay */
 #define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
+#define OF_EMPTY_ROOT		7 /* the builtin empty root node */
 
 #define OF_BAD_ADDR	((u64)-1)
 
@@ -180,11 +181,6 @@ static inline bool is_of_node(const struct fwnode_handle *fwnode)
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
@@ -195,6 +191,17 @@ static inline int of_node_check_flag(const struct device_node *n, unsigned long
 	return test_bit(flag, &n->_flags);
 }
 
+/**
+ * of_have_populated_dt() - Has DT been populated by bootloader
+ *
+ * Return: True if a DTB has been populated by the bootloader and it isn't the
+ * empty builtin one. False otherwise.
+ */
+static inline bool of_have_populated_dt(void)
+{
+	return of_root != NULL && !of_node_check_flag(of_root, OF_EMPTY_ROOT);
+}
+
 static inline int of_node_test_and_set_flag(struct device_node *n,
 					    unsigned long flag)
 {
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


