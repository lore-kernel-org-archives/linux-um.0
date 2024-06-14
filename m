Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A1ABC27C77
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1poOcFigCzvNGw/WIJa8uOgiTHrPvQYSCIrCvjonocA=; b=y0zyrfrNy29D4TlQKXccvoaubJ
	3QRYpcrTmFKfMretJlWuCXxxVf7fSD4FJnGg/6XgJlxZnV1K+Hq/d5lqI4Fy99b9SF3NPdq/u1Bw4
	zdIsbpb9bQk1v70yZbpVjG5QJcvdEuusfzmAB5aTfTVs8tJV/XxL0ai9yODbpg6C2Lddo647ZsoH+
	LJsb8TiHYL8IFrSmZUr8lSMJdoyVymm+pD4oWxWHUW7hyce7szy/jJ7py4NvX1RL0ARDnjw3wW652
	z/aOQeBwui0T/fgU29+EBTnsHT8At2GDITYYBfKqA2x99BddfQlgVA8yNjsVzJcZbQNwavdP+8oh5
	fKH86qdA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAng-00000003eaa-1obQ;
	Fri, 14 Jun 2024 17:33:20 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnS-00000003eMx-0E3t
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:10 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 69CB4FF814;
	Fri, 14 Jun 2024 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386384;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1poOcFigCzvNGw/WIJa8uOgiTHrPvQYSCIrCvjonocA=;
	b=mu2HR3Dw1aITM193U1cexzdtb8QKZ1a9PXL2MG0TOKyhwi6f3LpCeGx4rLg+ikykvEZ4ZL
	Ai+WTcy1wgQ/ZjwhBbRR8Qt3773gme4HCDzrlLejQDXlZ68xQzYN271k4qXHAfVfGn//ub
	ToNiozd/fv3C04ZAsWOXK4JYqDOqLkkLAur7fAZ1+rDqLVem3bRtxw3tfbJddf1PoIIm4Z
	mJDVmK1rlTjkdn3x7lxT2Ku72BcXS1ReAh0cyH5dQjOA0N/gar2lXB05dffSvLPnpLrRoS
	FyGIZGylTrDGDa6hMQfj1pQR847YhNRmdacYBGpihMiqmFngY2he87fXGncYhQ==
From: Herve Codina <herve.codina@bootlin.com>
To: Matti Vaittinen <mazziesaccount@gmail.com>,
	Herve Codina <herve.codina@bootlin.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Marc Zyngier <maz@kernel.org>
Cc: linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-um@lists.infradead.org,
	Allan Nielsen <allan.nielsen@microchip.com>,
	Horatiu Vultur <horatiu.vultur@microchip.com>,
	Steen Hegelund <steen.hegelund@microchip.com>,
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: [PATCH 21/23] dt-bindings: interrupt-controller: Add support for Microchip LAN966x OIC
Date: Fri, 14 Jun 2024 19:32:22 +0200
Message-ID: <20240614173232.1184015-22-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103306_985849_61FAADD1 
X-CRM114-Status: GOOD (  12.44  )
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

The Microchip LAN966x outband interrupt controller (OIC) maps the
internal interrupt sources of the LAN966x device to an external
interrupt.
When the LAN966x device is used as a PCI device, the external interrupt
is routed to the PCI interrupt.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../microchip,lan966x-oic.yaml                | 55 +++++++++++++++++++
 1 file changed, 55 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml

diff --git a/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
new file mode 100644
index 000000000000..b2adc7174177
--- /dev/null
+++ b/Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
@@ -0,0 +1,55 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/interrupt-controller/microchip,lan966x-oic.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Microchip LAN966x outband interrupt controller
+
+maintainers:
+  - Herve Codina <herve.codina@bootlin.com>
+
+allOf:
+  - $ref: /schemas/interrupt-controller.yaml#
+
+description: |
+  The Microchip LAN966x outband interrupt controller (OIC) maps the internal
+  interrupt sources of the LAN966x device to an external interrupt.
+  When the LAN966x device is used as a PCI device, the external interrupt is
+  routed to the PCI interrupt.
+
+properties:
+  compatible:
+    const: microchip,lan966x-oic
+
+  '#interrupt-cells':
+    const: 2
+
+  interrupt-controller: true
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    maxItems: 1
+
+required:
+  - compatible
+  - '#interrupt-cells'
+  - interrupt-controller
+  - interrupts
+  - reg
+
+additionalProperties: false
+
+examples:
+  - |
+    interrupt-controller@e00c0120 {
+        compatible = "microchip,lan966x-oic";
+        reg = <0xe00c0120 0x190>;
+        #interrupt-cells = <2>;
+        interrupt-controller;
+        interrupts = <0>;
+        interrupt-parent = <&intc>;
+    };
+...
-- 
2.45.0


