Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0EA8C2BA18
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dbIYhZvFBgQOKeNKrpgIrZWNtdywW0MRjqSAyjPi9WI=; b=NJ4np2HqJ/lsQNz7xWuNKJYDW9
	RW5DMW0+WZ8esunEQfxQxOsLzkV63hPqR2qsm/sYYVRl67ixL1l0BasNRCKPP/q/e1tRFhBCjwBfe
	l8cAXmrXbs2xWCwUyPYw/SmzWTG1lbnBO3HEjZ/qNS5ZQINEHK/MbMwwvdFpmOMqqLMICVF9ecpJr
	kIhI1b/+1OaCYQBOY9G9OraWKFLTCsptFLdVH6N9joMxCXQoF1W3MlkpNlQU2ni8wqcPlKd1iCHVE
	X9WEExG3leYMQr1smnXZxpXyv3MhY+bwdaIWD2/D/boZ7APtsAfNp5/GFusH++fW4f9qzHXkZWqx8
	cDQgSxcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAne-00000003eYZ-15c3;
	Fri, 14 Jun 2024 17:33:18 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnP-00000003eJ4-07Nv
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:06 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id B2696FF80F;
	Fri, 14 Jun 2024 17:33:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386381;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dbIYhZvFBgQOKeNKrpgIrZWNtdywW0MRjqSAyjPi9WI=;
	b=MDhfD84tbcqH2jCAZhK+8zTopQ3GfaxIIc+xxRspwt+V7Ji3j/iIKAmRBtBEVGMoRnIqM0
	35484UZe/JbAeyUMasGttWPxGYJIuEf7o9ZKWcgc0F02eCg+4dPXdNLK1Ls6JnIV+hSgce
	F4JGAcqKM7VOokHakL378HSV1iS8UiXvnP2RelD9RFa+5p+Y70EPC2RUW/hm3OBckzI1YV
	q1rg2D8FAvkhUE+Wyo9fEpeNaURtkhijmx68hY7swnNb0CVcevz5KXOzmMypIErviogyBB
	Or1AYN5R952kVlrinv4d/grvaQ0/2KeeCRgWCLIdrnlHzJWk3FslKYYHbQVG2Q==
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
Subject: [PATCH 18/23] irqdomain: Convert domain creation functions to irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:19 +0200
Message-ID: <20240614173232.1184015-19-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103303_363160_0EB34657 
X-CRM114-Status: GOOD (  10.28  )
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

Domain creation functions use __irq_domain_add(). With the introduction
of irq_domain_instantiate(), __irq_domain_add() becomes obsolete.

In order to fully remove __irq_domain_add(), convert domain
creation function to irq_domain_instantiate()

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 26 +++++++++++++++++++++-----
 1 file changed, 21 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d95ca575a108..e1ceb2ba2699 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -442,10 +442,17 @@ struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    const struct irq_domain_ops *ops,
 					    void *host_data)
 {
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = size,
+		.hwirq_max = size,
+		.ops = ops,
+		.host_data = host_data,
+	};
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(fwnode, size, size, 0, ops, host_data);
-	if (!domain)
+	domain = irq_domain_instantiate(&info);
+	if (IS_ERR(domain))
 		return NULL;
 
 	if (first_irq > 0) {
@@ -498,11 +505,20 @@ struct irq_domain *irq_domain_create_legacy(struct fwnode_handle *fwnode,
 					 const struct irq_domain_ops *ops,
 					 void *host_data)
 {
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = first_hwirq + size,
+		.hwirq_max = first_hwirq + size,
+		.ops = ops,
+		.host_data = host_data,
+	};
 	struct irq_domain *domain;
 
-	domain = __irq_domain_add(fwnode, first_hwirq + size, first_hwirq + size, 0, ops, host_data);
-	if (domain)
-		irq_domain_associate_many(domain, first_irq, first_hwirq, size);
+	domain = irq_domain_instantiate(&info);
+	if (IS_ERR(domain))
+		return NULL;
+
+	irq_domain_associate_many(domain, first_irq, first_hwirq, size);
 
 	return domain;
 }
-- 
2.45.0


