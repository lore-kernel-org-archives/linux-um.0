Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 980BBC7EE37
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=rkwvbHJ+dNSscecxNGkRWgrjYlYtSQZPF5kZBgpzQ8A=; b=gN7sn5za09XDib
	29AQ6Tz+bgKgpVwJn5mcrbhR/bDmotf1yG4/7EqbV7YxR3nuPJuQXZ2lGMMMjHc3FG2U7rvh1HMuA
	UROfKpb+lIpxfwLRDxwUybY6mfr4huE6teWl5hJYrVU/2KX1XEWT3/ElfF7vYjJHEGR+r2ZPjh/gA
	/kdURWwHuoqPStOaN9fhlmZiu7agK9pnbMTTBvcrLfIcs3b5776HQcQXHM21RYe6d2yjlZRPPCDEM
	9xXZ9DYpSzDmpExjU0160ltEpeJlqFUZYgA0msqZi2Ze22UoqkJlBcpyXL75aUEFgBEwsWdfhgFky
	nxz9kXTpyGIC42tZtQMg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXtv-000UAP-S9; Thu, 02 Mar 2023 01:38:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXts-000U7y-2s
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 01:38:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 9DEAA61543;
	Thu,  2 Mar 2023 01:38:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 625B0C433D2;
	Thu,  2 Mar 2023 01:38:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677721107;
	bh=fvPrCAyBkgnxgijN1lTuag/4in6rKiEGnEPO+gbwEs4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=i8zopeNC1in3w5XGUJKY/LXKlzK5BRSdMPry4rWNbnjNE84GWR1xF+RINEeejLejd
	 gKJpd8LdNs0TePE9fGcx70fY9XJ9a1rnTqoXELutE5T7dWUUu0TvXclZsGcJKLA9Ta
	 TnaxwHXeO/1BPtBl6s09cfKsPnLL8/Qxj6LP+ZweOmzZPczLC4+iFKN4d6MB6t2ebM
	 XlyovDX82U6lPSCyKUlkFXAD6OHJcEi7K4N64x81/QZvn8Jn0WIlq4kosMjwoNMe3M
	 OV9ydVXq2h7mGhu/mlZ4GkHAYKEQSp5u/n9pe41izH+Ewj/iiX9TOcCMlYBIWrIxyC
	 X6lYxry87mTrw==
From: Stephen Boyd <sboyd@kernel.org>
To: Michael Turquette <mturquette@baylibre.com>,
	Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	linux-clk@vger.kernel.org,
	patches@lists.linux.dev,
	Brendan Higgins <brendan.higgins@linux.dev>,
	David Gow <davidgow@google.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	"Rafael J . Wysocki" <rafael@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Vincent Whitchurch <vincent.whitchurch@axis.com>,
	Rob Herring <robh+dt@kernel.org>,
	Frank Rowand <frowand.list@gmail.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	linux-kselftest@vger.kernel.org,
	kunit-dev@googlegroups.com
Subject: [PATCH 4/8] clk: Add test managed clk provider/consumer APIs
Date: Wed,  1 Mar 2023 17:38:17 -0800
Message-Id: <20230302013822.1808711-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_173828_222601_BD8A47DF 
X-CRM114-Status: GOOD (  20.53  )
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

Unit tests are more ergonomic and simpler to understand if they don't
have to hoist a bunch of code into the test harness init and exit
functions. Add some test managed wrappers for the clk APIs so that clk
unit tests can write more code in the actual test and less code in the
harness.

Only add APIs that are used for now. More wrappers can be added in the
future as necessary.

Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/Makefile    |   5 +
 drivers/clk/clk-kunit.c | 204 ++++++++++++++++++++++++++++++++++++++++
 drivers/clk/clk-kunit.h |  28 ++++++
 3 files changed, 237 insertions(+)
 create mode 100644 drivers/clk/clk-kunit.c
 create mode 100644 drivers/clk/clk-kunit.h

diff --git a/drivers/clk/Makefile b/drivers/clk/Makefile
index e3ca0d058a25..7efce649b0d3 100644
--- a/drivers/clk/Makefile
+++ b/drivers/clk/Makefile
@@ -17,6 +17,11 @@ ifeq ($(CONFIG_OF), y)
 obj-$(CONFIG_COMMON_CLK)	+= clk-conf.o
 endif
 
+# KUnit specific helpers
+ifeq ($(CONFIG_COMMON_CLK), y)
+obj-$(CONFIG_KUNIT)		+= clk-kunit.o
+endif
+
 # hardware specific clock types
 # please keep this section sorted lexicographically by file path name
 obj-$(CONFIG_COMMON_CLK_APPLE_NCO)  	+= clk-apple-nco.o
diff --git a/drivers/clk/clk-kunit.c b/drivers/clk/clk-kunit.c
new file mode 100644
index 000000000000..78d85b3a7a4a
--- /dev/null
+++ b/drivers/clk/clk-kunit.c
@@ -0,0 +1,204 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * KUnit helpers for clk tests
+ */
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+
+#include <kunit/resource.h>
+
+#include "clk-kunit.h"
+
+static void kunit_clk_disable_unprepare(struct kunit_resource *res)
+{
+	struct clk *clk = res->data;
+
+	clk_disable_unprepare(clk);
+}
+
+/**
+ * kunit_clk_prepare_enable() - Test managed clk_prepare_enable()
+ * @test: The test context
+ * @clk: clk to prepare and enable
+ *
+ * Returns: 0 on success, or negative errno on failure.
+ */
+int kunit_clk_prepare_enable(struct kunit *test, struct clk *clk)
+{
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_disable_unprepare,
+				  GFP_KERNEL, clk))
+		return -EINVAL;
+
+	return clk_prepare_enable(clk);
+}
+EXPORT_SYMBOL_GPL(kunit_clk_prepare_enable);
+
+static void kunit_clk_put(struct kunit_resource *res)
+{
+	struct clk *clk = res->data;
+
+	clk_put(clk);
+}
+
+/**
+ * kunit_clk_get() - Test managed clk_get()
+ * @test: The test context
+ * @dev: device for clock "consumer"
+ * @id: clock consumer ID
+ *
+ * Returns: new clk consumer or ERR_PTR on failure
+ */
+struct clk *
+kunit_clk_get(struct kunit *test, struct device *dev, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_get(dev, con_id);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
+		clk_put(clk);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(kunit_clk_get);
+
+/**
+ * kunit_of_clk_get() - Test managed of_clk_get()
+ * @test: The test context
+ * @np: device_node for clock "consumer"
+ * @index: index in 'clocks' property of @np
+ *
+ * Returns: new clk consumer or ERR_PTR on failure
+ */
+struct clk *
+kunit_of_clk_get(struct kunit *test, struct device_node *np, int index)
+{
+	struct clk *clk;
+
+	clk = of_clk_get(np, index);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
+		clk_put(clk);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(kunit_of_clk_get);
+
+/**
+ * kunit_clk_hw_get_clk() - Test managed clk_hw_get_clk()
+ * @test: The test context
+ * @hw: clk_hw associated with the clk being consumed
+ * @con_id: connection ID string on device
+ *
+ * Returns: new clk consumer or ERR_PTR on failure
+ */
+struct clk *
+kunit_clk_hw_get_clk(struct kunit *test, struct clk_hw *hw, const char *con_id)
+{
+	struct clk *clk;
+
+	clk = clk_hw_get_clk(hw, con_id);
+	if (IS_ERR(clk))
+		return clk;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_put, GFP_KERNEL, clk)) {
+		clk_put(clk);
+		return ERR_PTR(-EINVAL);
+	}
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(kunit_clk_hw_get_clk);
+
+/**
+ * kunit_clk_hw_get_clk_prepared_enabled() - Test managed clk_hw_get_clk() + clk_prepare_enable()
+ * @test: The test context
+ * @hw: clk_hw associated with the clk being consumed
+ * @con_id: connection ID string on device
+ *
+ * Returns: new clk consumer that is prepared and enabled or ERR_PTR on failure
+ */
+struct clk *
+kunit_clk_hw_get_clk_prepared_enabled(struct kunit *test, struct clk_hw *hw,
+				      const char *con_id)
+{
+	int ret;
+	struct clk *clk;
+
+	clk = kunit_clk_hw_get_clk(test, hw, con_id);
+	if (IS_ERR(clk))
+		return clk;
+
+	ret = kunit_clk_prepare_enable(test, clk);
+	if (ret)
+		return ERR_PTR(ret);
+
+	return clk;
+}
+EXPORT_SYMBOL_GPL(kunit_clk_hw_get_clk_prepared_enabled);
+
+static void kunit_clk_hw_unregister(struct kunit_resource *res)
+{
+	struct clk_hw *hw = res->data;
+
+	clk_hw_unregister(hw);
+}
+
+/**
+ * kunit_clk_hw_register() - Test managed clk_hw_register()
+ * @test: The test context
+ * @dev: device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * Returns: 0 on success or a negative errno value on failure
+ */
+int kunit_clk_hw_register(struct kunit *test, struct device *dev, struct clk_hw *hw)
+{
+	int ret;
+
+	ret = clk_hw_register(dev, hw);
+	if (ret)
+		return ret;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_hw_unregister, GFP_KERNEL, hw)) {
+		clk_hw_unregister(hw);
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/**
+ * kunit_of_clk_hw_register() - Test managed of_clk_hw_register()
+ * @test: The test context
+ * @node: device_node of device that is registering this clock
+ * @hw: link to hardware-specific clock data
+ *
+ * Returns: 0 on success or a negative errno value on failure
+ */
+int kunit_of_clk_hw_register(struct kunit *test, struct device_node *node, struct clk_hw *hw)
+{
+	int ret;
+
+	ret = of_clk_hw_register(node, hw);
+	if (ret)
+		return ret;
+
+	if (!kunit_alloc_resource(test, NULL, kunit_clk_hw_unregister, GFP_KERNEL, hw)) {
+		clk_hw_unregister(hw);
+		return -EINVAL;
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/clk-kunit.h b/drivers/clk/clk-kunit.h
new file mode 100644
index 000000000000..153597d69269
--- /dev/null
+++ b/drivers/clk/clk-kunit.h
@@ -0,0 +1,28 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _CLK_KUNIT_H
+#define _CLK_KUNIT_H
+
+struct clk;
+struct clk_hw;
+struct device;
+struct device_node;
+struct kunit;
+
+struct clk *
+kunit_clk_get(struct kunit *test, struct device *dev, const char *con_id);
+struct clk *
+kunit_of_clk_get(struct kunit *test, struct device_node *np, int index);
+
+struct clk *
+kunit_clk_hw_get_clk(struct kunit *test, struct clk_hw *hw, const char *con_id);
+struct clk *
+kunit_clk_hw_get_clk_prepared_enabled(struct kunit *test, struct clk_hw *hw,
+				      const char *con_id);
+
+int kunit_clk_prepare_enable(struct kunit *test, struct clk *clk);
+
+int kunit_clk_hw_register(struct kunit *test, struct device *dev, struct clk_hw *hw);
+int kunit_of_clk_hw_register(struct kunit *test, struct device_node *node,
+			     struct clk_hw *hw);
+
+#endif
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
