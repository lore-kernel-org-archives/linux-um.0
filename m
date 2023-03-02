Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 810F5C87FE1
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 01:38:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=d7xUkqLkplpJIdNyCGUecOWu5yYkOpkpeTuXl6Y6GwI=; b=jTeR/YTPqIAXuJ
	JZzWdjTNdiHBe93xGa7Wkla6V7hn4spYNsh3rzLhIwUoIY9reOD3nWjLKYYYOav2qO+VyQyTQhEFv
	xYtRx0/9N+rLhCzCdkJ7GHnauXmKwNn9TUVovR3uapuFPNnJyeg2RJsAT1uk5ricqxNEhe7doQJMv
	KReugI4klS/bbE88sg/0m2eI0v7V9BlWo6PWDhybVR+ZTc/C/Mx4BTcSQ3/SBZ3WN2M8iCfe+8w/+
	OHrBE887ADRgmIWLXDCwja4byCovqr1ubt4SWwU2pMuwHc/rhA0HuWPG9746llKeNBLW87pkSd3Vd
	E096kL26vTf+yGZWBSIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXty-000UDK-UH; Thu, 02 Mar 2023 01:38:34 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXtw-000UA0-9O
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 01:38:34 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id D5396B811E1;
	Thu,  2 Mar 2023 01:38:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D25C5C433D2;
	Thu,  2 Mar 2023 01:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677721109;
	bh=/l+SZdmlEj6k/2KkGkyZGLbEgxbQ4jmIkEvZrUe5VZs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m6Rk22s1o6bU0lm2Ynjuyb6MIDTN+qyyMJiFSr1BXExoXWkZqzXLDKkf3hBns0OQD
	 Fu4gxDGugxNn39ZJXiGN7GkSXKt1MXixXjLBeHmxivEWKLYO0ah4cVvjRUfCjitHEW
	 SoDckBVLBvh9sQ/m/4Ge6IM8Q2lmBIP05Fnmx8dPmB/FPFYgaY6Ms85AcXzLcaoRHm
	 9GcPolkHoK8M0Nva04vWUO28cKR4sK6L2xGZpGvvWmouuf965qHjBXYXeVn2xFFHLo
	 67whL7JZkCIevfHzUd7nHEJqYyhLjmMB2N5Nuw4ZzC0tgLGjFqEYRVAYNK+kesBJje
	 QOI7UAvT1e9LA==
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
Subject: [PATCH 7/8] dt-bindings: clk: Add KUnit clk_parent_data test
Date: Wed,  1 Mar 2023 17:38:20 -0800
Message-Id: <20230302013822.1808711-8-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_173832_655840_DE1414CA 
X-CRM114-Status: GOOD (  15.19  )
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

Describe a binding for a device that provides and consumes clks in DT so
that a KUnit test can register clks based on the device node and test
clk_hw_register() with clk_parent_data.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../clock/linux,clk-kunit-parent-data.yaml    | 47 +++++++++++++++++++
 1 file changed, 47 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/linux,clk-kunit-parent-data.yaml

diff --git a/Documentation/devicetree/bindings/clock/linux,clk-kunit-parent-data.yaml b/Documentation/devicetree/bindings/clock/linux,clk-kunit-parent-data.yaml
new file mode 100644
index 000000000000..29609e07c115
--- /dev/null
+++ b/Documentation/devicetree/bindings/clock/linux,clk-kunit-parent-data.yaml
@@ -0,0 +1,47 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/clock/linux,clk-kunit-parent-data.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: KUnit clk provider for clk_parent_data unit tests
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  A clk provider to test the struct clk_parent_data implementation in the Linux
+  kernel.
+
+properties:
+  compatible:
+    const: linux,clk-kunit-parent-data
+
+  clocks:
+    items:
+      - description: Fixed parent
+      - description: 50 MHz fixed parent
+
+  clock-names:
+    items:
+      - const: parent_fwname
+      - const: "50"
+
+  "#clock-cells":
+    const: 1
+
+required:
+  - compatible
+  - "#clock-cells"
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-controller {
+      compatible = "linux,clk-kunit-parent-data";
+      #clock-cells = <1>;
+      clocks = <&fixed_parent>, <&fixed_50MHz>;
+      clock-names = "parent_fwname", "50";
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
