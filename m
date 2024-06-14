Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCB1C27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zDaB47WOjYw+Y1hfwmwgGI9KoC30S0XrnbD9FfSrUiI=; b=IBE+nKX8WU0wj+6y1SgSwg6xeh
	rBOET8Nm7AIrzR2I7MwjzlB8Bz610J+ad3J9B3Z7Yxepkro4H7SEPW5030nOg7M1kZB1drvkmzulT
	R5EDz1XU4Lb2po3zkei2rcF+aiz9DtIbAA3zCz+PjYGoVg+BUh8GZay1bjVnzdPkY5urDZyyHzcGe
	FhxARQvLn3aCXwM2AcdvDx8PKm1wEDYJTm/Z6RJB/WJ8jiBHIlbDSW+Ia+msQFrmAtZx1K92THFhr
	BiueptMXvpDg6QNznEox72xXxJtQJ5DB/uayQXAZnsNsERS2rGvM8itrgjQwzvZxJut4ptldScBHF
	YavadXpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnN-00000003eIp-2rWg;
	Fri, 14 Jun 2024 17:33:01 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnE-00000003e96-3GSw
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:54 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 683FFFF80A;
	Fri, 14 Jun 2024 17:32:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386371;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zDaB47WOjYw+Y1hfwmwgGI9KoC30S0XrnbD9FfSrUiI=;
	b=QOXUQncZrkWjeNSF9gf5Fnuw/j8AWhnmkrsiFgkvnP7X3OzKRFVvwohRTG8VQbtlTTyHLP
	gqWrZsvRkJsbmQ9krt7jebcRv7rCIOkQGRlAKUUMqft2AfTdBNrEb/8hvxhHNErdPT5uyY
	V0fqpn8SyxlUtx+U8hNftQ+GYxD8HQY6r44o2eHwDBRDvEZG2UXD9ky3mwpxkC9GpKuJ2E
	ytoXUH8DPFBPuWz081iPhs7oFYzIVYe60z2UA+4LKnSHzTeSXVBCds9LznQWFFp5JRyPnE
	8fejBsGIUB9lVcmXwNzpp+ugxNR+CRNLSevuRTsh3eSoTG3i1NK0452fTBpUpA==
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
Subject: [PATCH 06/23] irqdomain: Convert __irq_domain_create() to use struct irq_domain_info
Date: Fri, 14 Jun 2024 19:32:07 +0200
Message-ID: <20240614173232.1184015-7-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103253_205763_CEE4D688 
X-CRM114-Status: GOOD (  14.95  )
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

The existing __irq_domain_create() use a bunch of parameters to create
an irq domain.

With the introduction of irq_domain_info structure, these parameters are
available in the information structure itself.
Using directly this information structure allows future flexibility to
add other parameters in a simple way without the need to change the
__irq_domain_create() prototype.

Convert __irq_domain_create() to use the information structure.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 48 +++++++++++++++++++++---------------------
 1 file changed, 24 insertions(+), 24 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 0b152061e63a..28a463e25d99 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -179,45 +179,40 @@ static int irq_domain_set_name(struct irq_domain *domain,
 	return 0;
 }
 
-static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
-					      unsigned int size,
-					      irq_hw_number_t hwirq_max,
-					      int direct_max,
-					      const struct irq_domain_ops *ops,
-					      void *host_data)
+static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info)
 {
 	struct irq_domain *domain;
 	int err;
 
-	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
-		    (direct_max && direct_max != hwirq_max)))
+	if (WARN_ON((info->size && info->direct_max) ||
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && info->direct_max) ||
+		    (info->direct_max && info->direct_max != info->hwirq_max)))
 		return NULL;
 
-	domain = kzalloc_node(struct_size(domain, revmap, size),
-			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
+	domain = kzalloc_node(struct_size(domain, revmap, info->size),
+			      GFP_KERNEL, of_node_to_nid(to_of_node(info->fwnode)));
 	if (!domain)
 		return NULL;
 
-	err = irq_domain_set_name(domain, fwnode);
+	err = irq_domain_set_name(domain, info->fwnode);
 	if (err) {
 		kfree(domain);
 		return NULL;
 	}
 
-	domain->fwnode = fwnode_handle_get(fwnode);
+	domain->fwnode = fwnode_handle_get(info->fwnode);
 	fwnode_dev_initialized(domain->fwnode, true);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-	domain->ops = ops;
-	domain->host_data = host_data;
-	domain->hwirq_max = hwirq_max;
+	domain->ops = info->ops;
+	domain->host_data = info->host_data;
+	domain->hwirq_max = info->hwirq_max;
 
-	if (direct_max)
+	if (info->direct_max)
 		domain->flags |= IRQ_DOMAIN_FLAG_NO_MAP;
 
-	domain->revmap_size = size;
+	domain->revmap_size = info->size;
 
 	/*
 	 * Hierarchical domains use the domain lock of the root domain
@@ -264,8 +259,7 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 {
 	struct irq_domain *domain;
 
-	domain = __irq_domain_create(info->fwnode, info->size, info->hwirq_max,
-				     info->direct_max, info->ops, info->host_data);
+	domain = __irq_domain_create(info);
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
@@ -1204,13 +1198,19 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
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
 
-	if (size)
-		domain = __irq_domain_create(fwnode, size, size, 0, ops, host_data);
-	else
-		domain = __irq_domain_create(fwnode, 0, ~0, 0, ops, host_data);
+	if (!info.size)
+		info.hwirq_max = ~0U;
 
+	domain = __irq_domain_create(&info);
 	if (domain) {
 		if (parent)
 			domain->root = parent->root;
-- 
2.45.0


