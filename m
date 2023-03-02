Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BEA4C7EE39
	for <linux-um@archiver.kernel.org>; Thu,  2 Mar 2023 01:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pQvq+dtsuflmM8P3nIX7UcFNiD5R1sdmDRJ76db0RsU=; b=XC6kPSQ8xLZH0q
	tKbIGuhmaF8wqWPxv+hY/dy20jkwsDiSICqoD+M7VpVwDUnT9tvGi0T6W99djZiOfWAEudIVNZtSW
	Xs6FUZMpDMLb64CzVes43gU5WrjqBpHN/1R6QEtlGbepckB3DvF3/KREGcXggfWrk7olrZqI+UwVX
	4AsQDhyEWN9C59kASMRQMuEWMl35KzHTF42DCoRxboHXoGkKCr+k0iVWL2dqlJ/OpZ2jH6/qH+biX
	oHHV3hyWdvlFnfyuDjQJqsbqQi/8t27yn/W+oVHjpbBDXDBzfeW/RnrjgsAStdHvZ35P4NgvgySVj
	/j9PjGYV5LbWkI14mpFQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXtw-000UAk-1Q; Thu, 02 Mar 2023 01:38:32 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pXXts-000U8T-S8
	for linux-um@lists.infradead.org; Thu, 02 Mar 2023 01:38:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6DF9E61548;
	Thu,  2 Mar 2023 01:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35F3AC4339E;
	Thu,  2 Mar 2023 01:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1677721107;
	bh=82/H9NmKlkCam/MX1SwZss+jj5L2cQaZPxt44VOdqIg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ClHeefyhLi2pHzIqItEz1Cg9pvG7jsw+TRCffg92mo+4as42h7NjVcqQ7aGpMUsMJ
	 H4i3LOWqFKT3uUz0G8xcvn34yv/fG8Q8X4Jm4hthRYmdwASJfkhEcMcF2+8jzwmW+T
	 j2XDFHyDgnakpgulnJIayrJWFvwZJCVrGjPlqgmvpmoJsb1GKMUEX7LDE+Ny6H5nst
	 gskRJ11qaHSG5Z3sizLM8C3Kwb4VR8BkrZH6tCHZnEeXL5rSAFKHvfIpmrKL7b5oQj
	 97PatdddLBVHL7TbM8MwEh1CtRC4G9PEbcdywmhmgpd8lk4MOBpZp6MPhXHZr0CeKy
	 X2IjycdnIH8yQ==
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
Subject: [PATCH 5/8] dt-bindings: kunit: Add fixed rate clk consumer test
Date: Wed,  1 Mar 2023 17:38:18 -0800
Message-Id: <20230302013822.1808711-6-sboyd@kernel.org>
X-Mailer: git-send-email 2.39.2.722.g9855ee24e9-goog
In-Reply-To: <20230302013822.1808711-1-sboyd@kernel.org>
References: <20230302013822.1808711-1-sboyd@kernel.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230301_173829_039113_980F0755 
X-CRM114-Status: GOOD (  15.62  )
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

Describe a binding for a device that consumes a fixed rate clk in DT so
that a KUnit test can get the clk registered by of_fixed_clk_setup() and
test that it is setup properly.

Cc: Rob Herring <robh+dt@kernel.org>
Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: Brendan Higgins <brendan.higgins@linux.dev>
Cc: David Gow <davidgow@google.com>
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 .../kunit/linux,clk-kunit-fixed-rate.yaml     | 35 +++++++++++++++++++
 1 file changed, 35 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml

diff --git a/Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml b/Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml
new file mode 100644
index 000000000000..2d46eb7a6273
--- /dev/null
+++ b/Documentation/devicetree/bindings/kunit/linux,clk-kunit-fixed-rate.yaml
@@ -0,0 +1,35 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/kunit/linux,clk-kunit-fixed-rate.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: KUnit clk fixed rate test clk consumer
+
+maintainers:
+  - Stephen Boyd <sboyd@kernel.org>
+
+description: |
+  A clk consumer of a fixed rate clk used to test the fixed rate clk
+  implementation in the Linux kernel.
+
+properties:
+  compatible:
+    const: linux,clk-kunit-fixed-rate
+
+  clocks:
+    maxItems: 1
+
+required:
+  - compatible
+  - clocks
+
+additionalProperties: false
+
+examples:
+  - |
+    clock-consumer {
+      compatible = "linux,clk-kunit-fixed-rate";
+      clocks = <&fixed_clk>;
+    };
+...
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
