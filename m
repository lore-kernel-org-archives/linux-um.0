Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FDD9C7EE32
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 01:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=91qs3VUn+YFo5iiFOxpifWTMrGpvVvSmncdo3TkNqPU=; b=Z9qu+mw5Z9Gw3b
	7/ymTDAfXcK12tboNvjlnEOwdPfvTouh8Yzo68/L84qwHaqWvGVrGfQ00UlShqjKPV1BdK7ZTugHl
	2q1dUmWFLjhW3TYl1CrL16FpLf/mWIA5XNfkb7sBoxRIN1kdAIrblKNLM9ZVTrj6SmUqNqAV705cP
	eqz81bhiqAUg4uPzU64WnEn2mr5gvRXaJQ4AJEnjqYUxremS5k4JEDwgC4bccQ1uwz2M3ncsKIWzo
	xAcVESiNnEskxR5aL0rQTRipcXVGRAjimw4w3SDQJ0okSxHNdw1zVkEMW0fR+9fsJ0gNo2NcN8Nn/
	Z6be3gBvc0OOyjQcm5rg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXty-000UD2-N2; Thu, 02 Mar 2023 01:38:34 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXtu-000U7N-Mq
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 01:38:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 80FB261540;
	Thu,  2 Mar 2023 01:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A53C4C4339B;
	Thu,  2 Mar 2023 01:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677721110;
	bh=8V/QzCKxoD3493UXD/fF79fcE0FqXapWjtJR7YpxH1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oQSOuVS5Mo1uHlylczcUBWIFIj3dtpl6ppG3ilqpFnPZgekhqFNCX0Dkl/P5GQUSO
	 ZYOkUN+WfAijW/KzyfW+fOcyYhvWoTxWMd6wcHLj48Jw5LUdNDmYrpCOXAJcqhzONu
	 j3t5S85JnvwSQQE+Ua3OALKQci40SB7Vi68jgkTrYsV+Yz/PMjHGM3WyboWZvnhZPx
	 HpB9hTg8ht5Z/U9IEAP7gVSc3O1Y5bCJ8vtkpAucL+MzizProarnnhDXlNBPqaDaEw
	 Luwlu47wgwLL2fuS0C2JcYJ1R2/zf+Xy+tc9DAT8lv65DDKsCCpeqQs7HRRMimkGh2
	 aPeeUN/lMwOrQ==
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
Subject: [PATCH 8/8] clk: Add KUnit tests for clks registered with struct clk_parent_data
Date: Wed,  1 Mar 2023 17:38:21 -0800
Message-Id: <20230302013822.1808711-9-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_173830_851038_95E8E35E 
X-CRM114-Status: GOOD (  21.96  )
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

Test that clks registered with 'struct clk_parent_data' work as
intended and can find their parents.

Cc: Christian Marangi <ansuelsmth@gmail.com>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/clk/clk_test.c    | 456 +++++++++++++++++++++++++++++++++++++-
 drivers/of/kunit/clk.dtsi |  15 ++
 2 files changed, 470 insertions(+), 1 deletion(-)

diff --git a/drivers/clk/clk_test.c b/drivers/clk/clk_test.c
index f9a5c2964c65..ad63958b809d 100644
--- a/drivers/clk/clk_test.c
+++ b/drivers/clk/clk_test.c
@@ -4,10 +4,14 @@
  */
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
 
 /* Needed for clk_hw_get_clk() */
 #include "clk.h"
+#include "clk-kunit.h"
 
+#include <kunit/platform_driver.h>
 #include <kunit/test.h>
 
 #define DUMMY_CLOCK_INIT_RATE	(42 * 1000 * 1000)
@@ -2394,6 +2398,454 @@ static struct kunit_suite clk_mux_notifier_test_suite = {
 	.test_cases = clk_mux_notifier_test_cases,
 };
 
+struct clk_register_clk_parent_data_test_case {
+	const char *desc;
+	struct clk_parent_data pdata;
+};
+
+static void
+clk_register_clk_parent_data_test_case_to_desc(
+		const struct clk_register_clk_parent_data_test_case *t, char *desc)
+{
+	strcpy(desc, t->desc);
+}
+
+static const struct clk_register_clk_parent_data_test_case
+clk_register_clk_parent_data_of_cases[] = {
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct clk_parent_data::index.
+		 */
+		.desc = "clk_parent_data_of_index_test",
+		.pdata.index = 0,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct clk_parent_data::fwname.
+		 */
+		.desc = "clk_parent_data_of_fwname_test",
+		.pdata.fw_name = "parent_fwname",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct clk_parent_data::name.
+		 */
+		.desc = "clk_parent_data_of_name_test",
+		/* The index must be negative to indicate firmware not used */
+		.pdata.index = -1,
+		.pdata.name = "1mhz_fixed_legacy",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct
+		 * clk_parent_data::{fw_name,name}.
+		 */
+		.desc = "clk_parent_data_of_fwname_name_test",
+		.pdata.fw_name = "parent_fwname",
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct clk_parent_data::{index,name}.
+		 * Index takes priority.
+		 */
+		.desc = "clk_parent_data_of_index_name_priority_test",
+		.pdata.index = 0,
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device_node can
+		 * find a parent based on struct
+		 * clk_parent_data::{index,fwname,name}. The fw_name takes
+		 * priority over index and name.
+		 */
+		.desc = "clk_parent_data_of_index_fwname_name_priority_test",
+		.pdata.index = 1,
+		.pdata.fw_name = "parent_fwname",
+		.pdata.name = "not_matching",
+	},
+};
+
+KUNIT_ARRAY_PARAM(clk_register_clk_parent_data_of_test, clk_register_clk_parent_data_of_cases,
+		  clk_register_clk_parent_data_test_case_to_desc)
+
+/**
+ * struct clk_register_clk_parent_data_of_ctx - Context for clk_parent_data OF tests
+ * @np: device node of clk under test
+ * @hw: clk_hw for clk under test
+ */
+struct clk_register_clk_parent_data_of_ctx {
+	struct device_node *np;
+	struct clk_hw hw;
+};
+
+static int clk_register_clk_parent_data_of_test_init(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_of_ctx *ctx;
+
+	if (!IS_ENABLED(CONFIG_OF_KUNIT))
+		kunit_skip(test, "requires CONFIG_OF_KUNIT");
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return -ENOMEM;
+	test->priv = ctx;
+
+	ctx->np = of_find_compatible_node(NULL, NULL, "linux,clk-kunit-parent-data");
+	if (!ctx->np)
+		return -ENODEV;
+
+	return 0;
+}
+
+static void clk_register_clk_parent_data_of_test_exit(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_of_ctx *ctx = test->priv;
+
+	of_node_put(ctx->np);
+}
+
+/*
+ * Test that a clk registered with a struct device_node can find a parent based on
+ * struct clk_parent_data when the hw member isn't set.
+ */
+static void clk_register_clk_parent_data_of_test(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_of_ctx *ctx = test->priv;
+	struct clk_hw *parent_hw;
+	const struct clk_register_clk_parent_data_test_case *test_param;
+	struct clk_init_data init = { };
+	struct clk *expected_parent, *actual_parent;
+
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->np);
+
+	expected_parent = kunit_of_clk_get(test, ctx->np, 0);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_parent);
+
+	test_param = test->param_value;
+	init.parent_data = &test_param->pdata;
+	init.num_parents = 1;
+	init.name = "parent_data_of_test_clk";
+	init.ops = &clk_dummy_single_parent_ops;
+	ctx->hw.init = &init;
+	KUNIT_ASSERT_EQ(test, 0, kunit_of_clk_hw_register(test, ctx->np, &ctx->hw));
+
+	parent_hw = clk_hw_get_parent(&ctx->hw);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+
+	actual_parent = kunit_clk_hw_get_clk(test, parent_hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, actual_parent);
+
+	KUNIT_EXPECT_TRUE(test, clk_is_match(expected_parent, actual_parent));
+}
+
+static struct kunit_case clk_register_clk_parent_data_of_test_cases[] = {
+	KUNIT_CASE_PARAM(clk_register_clk_parent_data_of_test,
+			 clk_register_clk_parent_data_of_test_gen_params),
+	{}
+};
+
+/*
+ * Test suite for registering clks with struct clk_parent_data and a struct
+ * device_node.
+ */
+static struct kunit_suite clk_register_clk_parent_data_of_suite = {
+	.name = "clk_register_clk_parent_data_of",
+	.init = clk_register_clk_parent_data_of_test_init,
+	.exit = clk_register_clk_parent_data_of_test_exit,
+	.test_cases = clk_register_clk_parent_data_of_test_cases,
+};
+
+/**
+ * struct clk_register_clk_parent_data_device_ctx - Context for clk_parent_data device tests
+ * @dev: device of clk under test
+ * @hw: clk_hw for clk under test
+ * @pdrv: driver to attach to find @dev
+ */
+struct clk_register_clk_parent_data_device_ctx {
+	struct device *dev;
+	struct clk_hw hw;
+	struct platform_driver pdrv;
+};
+
+static inline struct clk_register_clk_parent_data_device_ctx *
+clk_register_clk_parent_data_driver_to_test_context(struct platform_device *pdev)
+{
+	return container_of(to_platform_driver(pdev->dev.driver),
+			    struct clk_register_clk_parent_data_device_ctx, pdrv);
+}
+
+static int clk_register_clk_parent_data_device_probe(struct platform_device *pdev)
+{
+	struct clk_register_clk_parent_data_device_ctx *ctx;
+
+	ctx = clk_register_clk_parent_data_driver_to_test_context(pdev);
+	ctx->dev = &pdev->dev;
+
+	return 0;
+}
+
+static void clk_register_clk_parent_data_device_driver(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_device_ctx *ctx = test->priv;
+	static const struct of_device_id match_table[] = {
+		{ .compatible = "linux,clk-kunit-parent-data" },
+		{ }
+	};
+
+	ctx->pdrv.probe = clk_register_clk_parent_data_device_probe;
+	ctx->pdrv.driver.of_match_table = match_table;
+	ctx->pdrv.driver.name = __func__;
+	ctx->pdrv.driver.owner = THIS_MODULE;
+
+	KUNIT_ASSERT_EQ(test, 0, kunit_platform_driver_register(test, &ctx->pdrv));
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx->dev);
+}
+
+static const struct clk_register_clk_parent_data_test_case
+clk_register_clk_parent_data_device_cases[] = {
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::index.
+		 */
+		.desc = "clk_parent_data_device_index_test",
+		.pdata.index = 1,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::fwname.
+		 */
+		.desc = "clk_parent_data_device_fwname_test",
+		.pdata.fw_name = "50",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::name.
+		 */
+		.desc = "clk_parent_data_device_name_test",
+		/* The index must be negative to indicate firmware not used */
+		.pdata.index = -1,
+		.pdata.name = "50_clk",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::{fw_name,name}.
+		 */
+		.desc = "clk_parent_data_device_fwname_name_test",
+		.pdata.fw_name = "50",
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::{index,name}. Index
+		 * takes priority.
+		 */
+		.desc = "clk_parent_data_device_index_name_priority_test",
+		.pdata.index = 1,
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::{index,fwname,name}.
+		 * The fw_name takes priority over index and name.
+		 */
+		.desc = "clk_parent_data_device_index_fwname_name_priority_test",
+		.pdata.index = 0,
+		.pdata.fw_name = "50",
+		.pdata.name = "not_matching",
+	},
+};
+
+KUNIT_ARRAY_PARAM(clk_register_clk_parent_data_device_test,
+		  clk_register_clk_parent_data_device_cases,
+		  clk_register_clk_parent_data_test_case_to_desc)
+
+/*
+ * Test that a clk registered with a struct device can find a parent based on
+ * struct clk_parent_data when the hw member isn't set.
+ */
+static void clk_register_clk_parent_data_device_test(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_device_ctx *ctx;
+	const struct clk_register_clk_parent_data_test_case *test_param;
+	struct clk_hw *parent_hw;
+	struct clk_init_data init = { };
+	struct clk *expected_parent, *actual_parent;
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	test->priv = ctx;
+
+	clk_register_clk_parent_data_device_driver(test);
+
+	expected_parent = kunit_clk_get(test, ctx->dev, "50");
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, expected_parent);
+
+	test_param = test->param_value;
+	init.parent_data = &test_param->pdata;
+	init.num_parents = 1;
+	init.name = "parent_data_device_test_clk";
+	init.ops = &clk_dummy_single_parent_ops;
+	ctx->hw.init = &init;
+	KUNIT_ASSERT_EQ(test, 0, kunit_clk_hw_register(test, ctx->dev, &ctx->hw));
+
+	parent_hw = clk_hw_get_parent(&ctx->hw);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent_hw);
+
+	actual_parent = kunit_clk_hw_get_clk(test, parent_hw, __func__);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, actual_parent);
+
+	KUNIT_EXPECT_TRUE(test, clk_is_match(expected_parent, actual_parent));
+}
+
+static const struct clk_register_clk_parent_data_test_case
+clk_register_clk_parent_data_device_hw_cases[] = {
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw.
+		 */
+		.desc = "clk_parent_data_device_hw_index_test",
+		/* The index must be negative to indicate firmware not used */
+		.pdata.index = -1,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when
+		 * struct clk_parent_data::fw_name is set.
+		 */
+		.desc = "clk_parent_data_device_hw_fwname_test",
+		.pdata.fw_name = "50",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when struct
+		 * clk_parent_data::name is set.
+		 */
+		.desc = "clk_parent_data_device_hw_name_test",
+		/* The index must be negative to indicate firmware not used */
+		.pdata.index = -1,
+		.pdata.name = "50_clk",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when struct
+		 * clk_parent_data::{fw_name,name} are set.
+		 */
+		.desc = "clk_parent_data_device_hw_fwname_name_test",
+		.pdata.fw_name = "50",
+		.pdata.name = "not_matching",
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when struct
+		 * clk_parent_data::index is set. The hw pointer takes
+		 * priority.
+		 */
+		.desc = "clk_parent_data_device_hw_index_priority_test",
+		.pdata.index = 0,
+	},
+	{
+		/*
+		 * Test that a clk registered with a struct device can find a
+		 * parent based on struct clk_parent_data::hw when
+		 * struct clk_parent_data::{index,fwname,name} are set.
+		 * The hw pointer takes priority over everything else.
+		 */
+		.desc = "clk_parent_data_device_hw_index_fwname_name_priority_test",
+		.pdata.index = 0,
+		.pdata.fw_name = "50",
+		.pdata.name = "not_matching",
+	},
+};
+
+KUNIT_ARRAY_PARAM(clk_register_clk_parent_data_device_hw_test,
+		  clk_register_clk_parent_data_device_hw_cases,
+		  clk_register_clk_parent_data_test_case_to_desc)
+
+/*
+ * Test that a clk registered with a struct device can find a
+ * parent based on struct clk_parent_data::hw.
+ */
+static void clk_register_clk_parent_data_device_hw_test(struct kunit *test)
+{
+	struct clk_register_clk_parent_data_device_ctx *ctx;
+	const struct clk_register_clk_parent_data_test_case *test_param;
+	struct clk_dummy_context *parent;
+	struct clk_hw *parent_hw;
+	struct clk_parent_data pdata = { };
+	struct clk_init_data init = { };
+
+	ctx = kunit_kzalloc(test, sizeof(*ctx), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, ctx);
+	test->priv = ctx;
+
+	clk_register_clk_parent_data_device_driver(test);
+
+	parent = kunit_kzalloc(test, sizeof(*parent), GFP_KERNEL);
+	KUNIT_ASSERT_NOT_ERR_OR_NULL(test, parent);
+
+	parent_hw = &parent->hw;
+	parent_hw->init = CLK_HW_INIT_NO_PARENT("parent-clk",
+						&clk_dummy_rate_ops, 0);
+
+	KUNIT_ASSERT_EQ(test, 0, kunit_clk_hw_register(test, ctx->dev, parent_hw));
+
+	test_param = test->param_value;
+	memcpy(&pdata, &test_param->pdata, sizeof(pdata));
+	pdata.hw = parent_hw;
+	init.parent_data = &pdata;
+	init.num_parents = 1;
+	init.ops = &clk_dummy_single_parent_ops;
+	init.name = "parent_data_device_hw_test_clk";
+	ctx->hw.init = &init;
+	KUNIT_ASSERT_EQ(test, 0, kunit_clk_hw_register(test, ctx->dev, &ctx->hw));
+
+	KUNIT_EXPECT_PTR_EQ(test, parent_hw, clk_hw_get_parent(&ctx->hw));
+}
+
+static struct kunit_case clk_register_clk_parent_data_device_test_cases[] = {
+	KUNIT_CASE_PARAM(clk_register_clk_parent_data_device_test,
+			 clk_register_clk_parent_data_device_test_gen_params),
+	KUNIT_CASE_PARAM(clk_register_clk_parent_data_device_hw_test,
+			 clk_register_clk_parent_data_device_hw_test_gen_params),
+	{}
+};
+
+static int clk_register_clk_parent_data_device_init(struct kunit *test)
+{
+	if (!IS_ENABLED(CONFIG_OF_KUNIT))
+		kunit_skip(test, "requires CONFIG_OF_KUNIT");
+
+	return 0;
+}
+
+/*
+ * Test suite for registering clks with struct clk_parent_data and a struct
+ * device.
+ */
+static struct kunit_suite clk_register_clk_parent_data_device_suite = {
+	.name = "clk_register_clk_parent_data_device",
+	.init = clk_register_clk_parent_data_device_init,
+	.test_cases = clk_register_clk_parent_data_device_test_cases,
+};
+
 kunit_test_suites(
 	&clk_leaf_mux_set_rate_parent_test_suite,
 	&clk_test_suite,
@@ -2405,7 +2857,9 @@ kunit_test_suites(
 	&clk_range_test_suite,
 	&clk_range_maximize_test_suite,
 	&clk_range_minimize_test_suite,
+	&clk_register_clk_parent_data_of_suite,
+	&clk_register_clk_parent_data_device_suite,
 	&clk_single_parent_mux_test_suite,
-	&clk_uncached_test_suite
+	&clk_uncached_test_suite,
 );
 MODULE_LICENSE("GPL v2");
diff --git a/drivers/of/kunit/clk.dtsi b/drivers/of/kunit/clk.dtsi
index e3466bcfeb4b..4ac14dd78063 100644
--- a/drivers/of/kunit/clk.dtsi
+++ b/drivers/of/kunit/clk.dtsi
@@ -6,10 +6,25 @@ fixed_50MHz: clock-50MHz {
 		#clock-cells = <0>;
 		clock-frequency = <50000000>;
 		clock-accuracy = <300>;
+		clock-output-names = "50_clk";
 	};
 
 	clock-consumer-fixed-50 {
 		compatible = "linux,clk-kunit-fixed-rate";
 		clocks = <&fixed_50MHz>;
 	};
+
+	fixed_parent: clock-1MHz {
+		compatible = "fixed-clock";
+		#clock-cells = <0>;
+		clock-frequency = <1000000>;
+		clock-output-names = "1mhz_fixed_legacy";
+	};
+
+	clock-provider-of {
+		compatible = "linux,clk-kunit-parent-data";
+		clocks = <&fixed_parent>, <&fixed_50MHz>;
+		clock-names = "parent_fwname", "50";
+		#clock-cells = <1>;
+	};
 };
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
