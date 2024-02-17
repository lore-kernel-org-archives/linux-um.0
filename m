Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A81BC48260
	for <linux-um@archiver.kernel.org>; Sat, 17 Feb 2024 01:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OTFQw0Hn2uCZGL+HqUSSxUyu22cZBVpRF4Ub3VDWb2Y=; b=Y6Njb6y9krPFWzewCD5QEJj5FM
	FthykoW/ByptfvjGSoyOrM+SfR/xWIUkJFKnJKea4CYpYbjIKxsxTQmAhuUk14gixftxkKg7O25md
	eujrX/nzsQCAGxHHDblAc0soMTgxb1oX/tZLeBh/7hAAieD4OjL341ahXSbld7tg06WTrTDwCgVLe
	sHNRpAGAZDIrFyXF7vD+P0GgALpwcZo1Uh7EHfAGIJqgK4pG24k4K8nDhlZYe3A8HidqRZNooIJOV
	1F5XvOay4tsPtu0YwprGUEcdnwV2SHolUExXhRSAiJ1Y9OYsKMWkrjRQ+SKVGJF5IASOsspYHRCc6
	DIj6gUCg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb9A7-00000004MCR-2nZv;
	Sat, 17 Feb 2024 01:06:39 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rb99a-00000004Lk9-0Eja;
	Sat, 17 Feb 2024 01:06:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0669BCE2DA2;
	Sat, 17 Feb 2024 01:06:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDE8DC433A6;
	Sat, 17 Feb 2024 01:06:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708131963;
	bh=J3WMalAjgz0rnHbmeT8QD4FpP4dD0hu4Yj+NzkEppQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAOa4fi46Q5W6L0e8l/qgg64ROvD783Ms6lXCLYZpxVg35KK7iz4ZOPqJG55vnPGq
	 3UeRnJKaA3I3cKg6k8nOeUWz9METclLEOdD2v/vwKpzE0krhoMDcnzcf32fLp60VJM
	 TsuqeU8cRg0jhmjmGbtWhR66ChQwQ7qIhwKmEc6mNkXVzW0mVxPXvpIFCOvDJP4Ug0
	 5GQ1D1ccdPvjJlEHgSowFvSe0mQgCZKbefm6SWMC5Ip+4IplYU/9M+WdLtT1NdVNNg
	 COT3rSgSj0bQbQPCU6igti603mJcNcGUWeyv11PFrXku2BBWdb9jKivpvYiB0ZyZVU
	 Kkj8/nueN6ZGw==
From: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	patches@lists.linux.dev,
	linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	David Gow <davidgow@google.com>,
	Brendan Higgins <brendan.higgins@linux.dev>
Subject: [PATCH v4 7/7] of: Add KUnit test to confirm DTB is loaded
Date: Fri, 16 Feb 2024 17:05:56 -0800
Message-ID: <20240217010557.2381548-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
In-Reply-To: <20240217010557.2381548-1-sboyd@kernel.org>
References: <20240217010557.2381548-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_170606_594038_DB9E8394 
X-CRM114-Status: GOOD (  18.31  )
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

Add a KUnit test that confirms a DTB has been loaded, i.e. there is a
root node, and that the of_have_populated_dt() API works properly. We
skip the test when CONFIG_OF_EARLY_FLATREE=n because in that case we
know architecture code hasn't called unflatten_(and_copy_)?device_tree()
which would populate some sort of root node.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Reviewed-by: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/.kunitconfig |  3 +++
 drivers/of/Kconfig      |  9 +++++++
 drivers/of/Makefile     |  2 ++
 drivers/of/of_test.c    | 57 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 drivers/of/.kunitconfig
 create mode 100644 drivers/of/of_test.c

diff --git a/drivers/of/.kunitconfig b/drivers/of/.kunitconfig
new file mode 100644
index 000000000000..5a8fee11978c
--- /dev/null
+++ b/drivers/of/.kunitconfig
@@ -0,0 +1,3 @@
+CONFIG_KUNIT=y
+CONFIG_OF=y
+CONFIG_OF_KUNIT_TEST=y
diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index d738fbad9c36..dd726c7056bf 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -36,6 +36,15 @@ config OF_UNITTEST
 
 	  If unsure, say N here. This option is not safe to enable.
 
+config OF_KUNIT_TEST
+	tristate "Devicetree KUnit Test" if !KUNIT_ALL_TESTS
+	depends on KUNIT
+	default KUNIT_ALL_TESTS
+	help
+	  This option builds KUnit unit tests for device tree infrastructure.
+
+	  If unsure, say N here, but this option is safe to enable.
+
 config OF_ALL_DTBS
 	bool "Build all Device Tree Blobs"
 	depends on COMPILE_TEST
diff --git a/drivers/of/Makefile b/drivers/of/Makefile
index df305348d1cb..251d33532148 100644
--- a/drivers/of/Makefile
+++ b/drivers/of/Makefile
@@ -19,4 +19,6 @@ obj-y	+= kexec.o
 endif
 endif
 
+obj-$(CONFIG_OF_KUNIT_TEST) += of_test.o
+
 obj-$(CONFIG_OF_UNITTEST) += unittest-data/
diff --git a/drivers/of/of_test.c b/drivers/of/of_test.c
new file mode 100644
index 000000000000..a9301d293f01
--- /dev/null
+++ b/drivers/of/of_test.c
@@ -0,0 +1,57 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit tests for OF APIs
+ */
+#include <linux/module.h>
+#include <linux/of.h>
+
+#include <kunit/test.h>
+
+/*
+ * Test that the root node "/" can be found by path.
+ */
+static void of_dtb_root_node_found_by_path(struct kunit *test)
+{
+	struct device_node *np;
+
+	np = of_find_node_by_path("/");
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, np);
+	of_node_put(np);
+}
+
+/*
+ * Test that the 'of_root' global variable is always populated when DT code is
+ * enabled. Remove this test once of_root is removed from global access.
+ */
+static void of_dtb_root_node_populates_of_root(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_root);
+}
+
+static struct kunit_case of_dtb_test_cases[] = {
+	KUNIT_CASE(of_dtb_root_node_found_by_path),
+	KUNIT_CASE(of_dtb_root_node_populates_of_root),
+	{}
+};
+
+static int of_dtb_test_init(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_OF_EARLY_FLATTREE))
+		kunit_skip(test, "requires CONFIG_OF_EARLY_FLATTREE");
+
+	return 0;
+}
+
+/*
+ * Test suite to confirm a DTB is loaded.
+ */
+static struct kunit_suite of_dtb_suite = {
+	.name = "of_dtb",
+	.test_cases = of_dtb_test_cases,
+	.init = of_dtb_test_init,
+};
+
+kunit_test_suites(
+	&of_dtb_suite,
+);
+MODULE_LICENSE("GPL");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


