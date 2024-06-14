Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39F39C27C7B
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lrO21D/F1M18TMwOh5nDZl9q9v++C9Qwkdmyr7nENho=; b=EhXkDKZrHpuXeUaQSJfCIWeYTM
	MoToHXr49JSvuyykE1GzCnIytOAfsaS0j/ito19HFK5i6G9d2atQn/oLRV4Gn9ZAoFwSPh5UCSCvD
	pyTok8iSyTyaC8ygPgWg+D5LnLV4/PjywHY5p2m+WmZ7ysJq4797VPAkKYBelf3hLwyVW/8AoJKtc
	jPsreu+LWA6qOgp9Yq1R6Zhg5ybrh+KvImW1EObp6yIqVuHa9lUaTx8bDy5my4uNdaMPeKpZNRC1X
	XZbmig12Yd+YaCy7HsueGPeCXK8Z/4K/639nXs27SVXinjMuRNlENyYYZag9qsxyfnKOx5UUNI0eq
	AzaPYbmA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnd-00000003eY5-3Dfr;
	Fri, 14 Jun 2024 17:33:17 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnO-00000003eIc-1LrT
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:06 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id DA020FF807;
	Fri, 14 Jun 2024 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386380;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lrO21D/F1M18TMwOh5nDZl9q9v++C9Qwkdmyr7nENho=;
	b=aP3N0jiRHNCo/PI9Tmqi+m5BiLjCBPomS0d3Lp7pX3CPht3E5bXpuBNeafgNXjcQLIIejB
	x6LmGLn8nncQ6TZnXR42IpSud3pbCGNMnyrm6XUayFplZ3syjkO6Lfu9VfxpcE2ZZcp1L9
	RkeQ+nFgaN3u6Ev22GPXJpznyhr7TTsaDTSAG8ZOeIn7owqypv+Y0fhHuXbKFoxlia3Hag
	JmBynUt4HWat6VA6ZRUZjcELmcRxX1in1l9+XaLY7C6PFRSMdkEuVH+J4pJRkwjoF+exb8
	vpa0LYbN1O3E9GQvGkQHhJM0mTyTIZOf7MUQYnFlBOPkCN5t1koRO/SSX17FnA==
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
Subject: [PATCH 17/23] irqdomain: Convert __irq_domain_add() wrappers to irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:18 +0200
Message-ID: <20240614173232.1184015-18-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103302_906164_86F34AEE 
X-CRM114-Status: UNSURE (   9.10  )
X-CRM114-Notice: Please train this message.
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

__irq_domain_add() wrappers use directly __irq_domain_add(). With the
introduction of irq_domain_instantiate(), __irq_domain_add() becomes
obsolete.

In order to fully remove __irq_domain_add(), convert wrappers to
irq_domain_instantiate()

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 58 +++++++++++++++++++++++++++++++++++----
 1 file changed, 53 insertions(+), 5 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 8820317582c4..1cd1cbf57736 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -400,7 +400,17 @@ static inline struct irq_domain *irq_domain_add_linear(struct device_node *of_no
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), size, size, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = of_node_to_fwnode(of_node),
+		.size = size,
+		.hwirq_max = size,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 #ifdef CONFIG_IRQ_DOMAIN_NOMAP
@@ -409,7 +419,17 @@ static inline struct irq_domain *irq_domain_add_nomap(struct device_node *of_nod
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, max_irq, max_irq, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = of_node_to_fwnode(of_node),
+		.hwirq_max = max_irq,
+		.direct_max = max_irq,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 extern unsigned int irq_create_direct_mapping(struct irq_domain *host);
@@ -419,7 +439,16 @@ static inline struct irq_domain *irq_domain_add_tree(struct device_node *of_node
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(of_node_to_fwnode(of_node), 0, ~0, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = of_node_to_fwnode(of_node),
+		.hwirq_max = ~0U,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *fwnode,
@@ -427,14 +456,33 @@ static inline struct irq_domain *irq_domain_create_linear(struct fwnode_handle *
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, size, size, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = size,
+		.hwirq_max = size,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 static inline struct irq_domain *irq_domain_create_tree(struct fwnode_handle *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
-	return __irq_domain_add(fwnode, 0, ~0, 0, ops, host_data);
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.hwirq_max = ~0,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
+
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 
 extern void irq_domain_remove(struct irq_domain *host);
-- 
2.45.0


