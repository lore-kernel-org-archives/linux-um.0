Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2FE9C27C77
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3Jt3G+9U0q6RfDTk1HQe6Yj9ZdV0UvVAc1UYDI9SykA=; b=HGphvXkt+ZgP7cJkYCQie+DHnI
	KHAyIgFQp6JdLlMzP6QyhjQMPlUNYRoohNeWC5R15Q67KkhyMVbU0404FxTxxJfpGf/lmW6TfaLxX
	UbgpdTRiY/kXinpNl6bLqkA8fg3uGfnpwg0RWrOlomdrwFVgxlRgc9lmitsv1I4mFNykABrdvxe7b
	o60PkiaFMAkwn+XGD+zBEt1Tz4Q6lXK3RMKYHr+Cl1A3vxNH5ssykyoW1QqKg5tn+w0rjSzFpxBhS
	n2BEFEzBTCEtfqXTPRCPDcXTZIxfILXAUR+iUvAFSVw8GOwPTQ/ka8oJ/BRAg2L0TNcI3Rhs5LfNt
	1CV7Caqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnI-00000003eDb-174p;
	Fri, 14 Jun 2024 17:32:56 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnD-00000003e8h-3SDm
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:53 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 833BBFF808;
	Fri, 14 Jun 2024 17:32:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386370;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3Jt3G+9U0q6RfDTk1HQe6Yj9ZdV0UvVAc1UYDI9SykA=;
	b=IW4unxYuqtWHfPp6kOACcF+GTsjKd+633XLLo7q/KXWgkKzYwKxUNP7306nv+MKpXCv7ep
	3avTOY9QqnTWu0HfU8z1riCevl523+xTxPphjVWuQmxAhDKN1PksnhyZdK/ycF61le6Cjb
	uL6Ji+ySOoE0R72ETvPWJwyOMwZYqM3dXXrO2lpOzAzeYkCMLdB/lv0vQqOESkRrkAl9tg
	3QdJHvYg3eNUuceduXBoqgOwQKWpU/y98TOk2IP9bhnkFgRXXsoXT5BNwMvUityp7a8TMJ
	AM9AdBgu1DJcC0sCUJ6AUM2216FG+6GQxIF6DSklMjUBlkKr8j/4HnRBhI9ong==
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
Subject: [PATCH 05/23] irqdomain: Use a dedicated function to set the domain name
Date: Fri, 14 Jun 2024 19:32:06 +0200
Message-ID: <20240614173232.1184015-6-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103252_265495_02A1BFBA 
X-CRM114-Status: GOOD (  12.29  )
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

The irq domain name computation and setting is directly done in
__irq_domain_create(). This leads to a quite long __irq_domain_create()
function.

In order to simplify __irq_domain_create() and isolate the domain name
computation and setting, move the related operations to a dedicated
function.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 69 +++++++++++++++++++++++-------------------
 1 file changed, 38 insertions(+), 31 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 31277488ed42..0b152061e63a 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -128,27 +128,11 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 }
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
-static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
-					      unsigned int size,
-					      irq_hw_number_t hwirq_max,
-					      int direct_max,
-					      const struct irq_domain_ops *ops,
-					      void *host_data)
+static int irq_domain_set_name(struct irq_domain *domain,
+			       const struct fwnode_handle *fwnode)
 {
-	struct irqchip_fwid *fwid;
-	struct irq_domain *domain;
-
 	static atomic_t unknown_domains;
-
-	if (WARN_ON((size && direct_max) ||
-		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
-		    (direct_max && (direct_max != hwirq_max))))
-		return NULL;
-
-	domain = kzalloc_node(struct_size(domain, revmap, size),
-			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
-	if (!domain)
-		return NULL;
+	struct irqchip_fwid *fwid;
 
 	if (is_fwnode_irqchip(fwnode)) {
 		fwid = container_of(fwnode, struct irqchip_fwid, fwnode);
@@ -157,10 +141,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
-			if (!domain->name) {
-				kfree(domain);
-				return NULL;
-			}
+			if (!domain->name)
+				return -ENOMEM;
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
@@ -177,10 +159,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		 * the trick and is not as offensive as '\'...
 		 */
 		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
-		if (!name) {
-			kfree(domain);
-			return NULL;
-		}
+		if (!name)
+			return -ENOMEM;
 
 		domain->name = strreplace(name, '/', ':');
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
@@ -191,13 +171,40 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			pr_err("Invalid fwnode type for irqdomain\n");
 		domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
 					 atomic_inc_return(&unknown_domains));
-		if (!domain->name) {
-			kfree(domain);
-			return NULL;
-		}
+		if (!domain->name)
+			return -ENOMEM;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
+	return 0;
+}
+
+static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
+					      unsigned int size,
+					      irq_hw_number_t hwirq_max,
+					      int direct_max,
+					      const struct irq_domain_ops *ops,
+					      void *host_data)
+{
+	struct irq_domain *domain;
+	int err;
+
+	if (WARN_ON((size && direct_max) ||
+		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && direct_max) ||
+		    (direct_max && direct_max != hwirq_max)))
+		return NULL;
+
+	domain = kzalloc_node(struct_size(domain, revmap, size),
+			      GFP_KERNEL, of_node_to_nid(to_of_node(fwnode)));
+	if (!domain)
+		return NULL;
+
+	err = irq_domain_set_name(domain, fwnode);
+	if (err) {
+		kfree(domain);
+		return NULL;
+	}
+
 	domain->fwnode = fwnode_handle_get(fwnode);
 	fwnode_dev_initialized(domain->fwnode, true);
 
-- 
2.45.0


