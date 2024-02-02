Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85B3BC4828F
	for <linux-um@archiver.kernel.org>; Fri,  2 Feb 2024 20:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9nr8KgIXSlmrBRc5eTEs4Ft1WJ6sE76s1g3Xw61O8GM=; b=ZO6qhK4tyVDuX76X0T9W99e7DN
	nD0/2mmuhWQcL/x2iZ8sXvT/Ji8Iuzr5/AdkmG3VuN4qKd1biGOQRIPbAAz3y64D7g4m57zVE1IWK
	OXzO22X0/mdnUQNKCHRDy4EUQqe2ojqtCpUO/QmHAWwyqFsfqR2StHmkzuT7nzz1Tv+JiNA/VXTuZ
	BAlqVA6Y4oPWOCR+MDG1XXaJDp9Mhlol2kLEIvlh3zO+32IiwvdYIOHvQZOeCOoevjMT532QzS9Hl
	/QmRC5HaP34sr/h8YQGzn6C6iZKHrIU8wQoOMgqcnmz35dxbyQudqoLzXmpSpHSi4YwfF9LdFDIrS
	bkw2FBVA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVziQ-0000000DInK-0oWp;
	Fri, 02 Feb 2024 20:00:46 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVzh0-0000000DI5l-1lmF;
	Fri, 02 Feb 2024 19:59:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id D03C5CE2E3F;
	Fri,  2 Feb 2024 19:59:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F0422C43390;
	Fri,  2 Feb 2024 19:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706903956;
	bh=PiweXFroDHF7yXaa82SMFRXH/FDbm1RzgiHTih6bLA8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LUsABn4BtEE+3rLzRs0MQ2C02aC4eRavx+NnUEigQIDN5hEhEZNBOQJZPL8COpFiE
	 lorefdZOxB8OV+F2B33bLbZYuCDULzTivEsiui+momrj0H+Q4M8bILqL6UXIb2VZG8
	 2a4s2d8yNcFame9bG1gYjm7fRnJ0b1loqO9DK41wYC40o8K8MLf+BOFe1Y+PHMhias
	 njRXktKCexQ9Yv8x4+YTqiHhB31aR091ZwIt79dQ9s29u1QvLULGcboC0mabkoiOis
	 bdoKOrdCx2OSnf4HWEb5yIMklX06Ug8ejLsbsHsTP/c7+WG2Qd9+ZAF9Hq4PyzUetv
	 l0y+61kYAJv5Q==
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
Subject: [PATCH v3 7/7] of: Add KUnit test to confirm DTB is loaded
Date: Fri,  2 Feb 2024 11:59:08 -0800
Message-ID: <20240202195909.3458162-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
In-Reply-To: <20240202195909.3458162-1-sboyd@kernel.org>
References: <20240202195909.3458162-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240202_115920_360723_DFBFCC56 
X-CRM114-Status: GOOD (  18.15  )
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
root node, and that the of_have_populated_dt() API works properly.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>
Cc: David Gow <davidgow@google.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/of/.kunitconfig |  3 +++
 drivers/of/Kconfig      |  9 ++++++++
 drivers/of/Makefile     |  2 ++
 drivers/of/of_test.c    | 48 +++++++++++++++++++++++++++++++++++++++++
 4 files changed, 62 insertions(+)
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
index 17733285b415..53d1b5dd89e8 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -37,6 +37,15 @@ config OF_UNITTEST
 
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
index 000000000000..71a767b42b43
--- /dev/null
+++ b/drivers/of/of_test.c
@@ -0,0 +1,48 @@
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
+static void dtb_root_node_found_by_path(struct kunit *test)
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
+ * enabled.
+ */
+static void dtb_root_node_populates_of_root(struct kunit *test)
+{
+	KUNIT_EXPECT_NOT_ERR_OR_NULL(test, of_root);
+}
+
+static struct kunit_case dtb_test_cases[] = {
+	KUNIT_CASE(dtb_root_node_found_by_path),
+	KUNIT_CASE(dtb_root_node_populates_of_root),
+	{}
+};
+
+/*
+ * Test suite to confirm a DTB is loaded.
+ */
+static struct kunit_suite dtb_suite = {
+	.name = "dtb",
+	.test_cases = dtb_test_cases,
+};
+
+kunit_test_suites(
+	&dtb_suite,
+);
+MODULE_LICENSE("GPL");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


