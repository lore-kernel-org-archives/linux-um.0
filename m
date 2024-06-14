Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72E64C27C7B
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uMFasbEf4choChQbQW4o5B2GzIDXCZom8Jh+XZJZcAQ=; b=rFUiy7ZxOm5I1KHDNiVGWZ+zM/
	IPNbOUwbDmNIOzVPQbrHz/Rz9xC6dzgl/2DpTplWLOut4c26FWMKqFSGa1jMqFYN/+DeLE4sIqqkT
	ik7otTTZfYlYKkTwSJ+0sGSIAqwrNpgvHo1dfLyNr5+qxPo+cCC0DTpDL2fJODcbF2V5/3HfdPB4R
	DMp1FyHAdGRTP8TP20rgkHIKRGz76BLPNU1AXuOU0r48SqQoUYHt+1H3Z1fOKtCor4jBkEQ4Fpy9S
	6f0TdOYUfT79Z3WToxb/QsdqeWhQOIU1wrYxUGJ58HvpIWBFYsSltt35Vt7OMHctyhMn3jT5sqcSg
	HXNA8pfA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnT-00000003ePF-1BnY;
	Fri, 14 Jun 2024 17:33:07 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnJ-00000003eDG-0rRQ
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:59 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id BD2CFFF810;
	Fri, 14 Jun 2024 17:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386375;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uMFasbEf4choChQbQW4o5B2GzIDXCZom8Jh+XZJZcAQ=;
	b=L3yUXNMmtoZUUu0QU2ABzSlGH7KCqmQtblTAJMJ0qkuOSvfL6rmG1OI01zFrciWoPYQ26L
	MDEn87KyfQjaZCbqijbzCUElhO9yOpKhj/OAqXNUdpKufLurMnI6PgA/Ly3Zq9dkDbUKSM
	PjGgfE+KxJEmXSVzW8Q4OXKMp8huOvWSGWwyF0c1V2HAM/OA3657yRUE0pcIvEuV1O4T/Z
	Pg/0aq3G8lKpkKqkJSQVNEeBMLUsK0hWxUQWXJBO6MS2xXsI0KuVcIYCgayWU+pSH8siUn
	bXBigm/JwElpb9az7tADwJ/JGu6d4j6oi5Y3UGhVtPbOabRoJ2uAe6WcGMutYw==
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
Subject: [PATCH 11/23] irqdomain: Handle domain bus token in irq_domain_create()
Date: Fri, 14 Jun 2024 19:32:12 +0200
Message-ID: <20240614173232.1184015-12-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103257_896486_A00E139A 
X-CRM114-Status: GOOD (  17.02  )
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

irq_domain_update_bus_token() is the only way to set the domain bus
token. This is sub-optimal as irq_domain_update_bus_token() can be
called only once the domain is created and needs to revert some
operations, change the domain name and redo the operations.

In order to avoid this revert/change/redo sequence, take into account
the domain bus token during the domain creation.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/irqdomain.c    | 30 ++++++++++++++++++++++++------
 2 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index e52fd5e5494c..52bed23e5c61 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -265,6 +265,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
  *			Use ~0 for no limit; 0 for no direct mapping
+ * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
  */
@@ -274,6 +275,7 @@ struct irq_domain_info {
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
+	enum irq_domain_bus_token		bus_token;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 5090b1c572c6..d05aeb9c0a67 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -129,7 +129,8 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode)
 EXPORT_SYMBOL_GPL(irq_domain_free_fwnode);
 
 static int irq_domain_set_name(struct irq_domain *domain,
-			       const struct fwnode_handle *fwnode)
+			       const struct fwnode_handle *fwnode,
+			       enum irq_domain_bus_token bus_token)
 {
 	static atomic_t unknown_domains;
 	struct irqchip_fwid *fwid;
@@ -140,13 +141,23 @@ static int irq_domain_set_name(struct irq_domain *domain,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->name = kstrdup(fwid->name, GFP_KERNEL);
+			domain->name = bus_token ?
+					kasprintf(GFP_KERNEL, "%s-%d",
+						  fwid->name, bus_token) :
+					kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name)
 				return -ENOMEM;
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
 			domain->name = fwid->name;
+			if (bus_token) {
+				domain->name = kasprintf(GFP_KERNEL, "%s-%d",
+							 fwid->name, bus_token);
+				if (!domain->name)
+					return -ENOMEM;
+				domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
+			}
 			break;
 		}
 	} else if (is_of_node(fwnode) || is_acpi_device_node(fwnode) ||
@@ -158,7 +169,9 @@ static int irq_domain_set_name(struct irq_domain *domain,
 		 * unhappy about. Replace them with ':', which does
 		 * the trick and is not as offensive as '\'...
 		 */
-		name = kasprintf(GFP_KERNEL, "%pfw", fwnode);
+		name = bus_token ?
+			kasprintf(GFP_KERNEL, "%pfw-%d", fwnode, bus_token) :
+			kasprintf(GFP_KERNEL, "%pfw", fwnode);
 		if (!name)
 			return -ENOMEM;
 
@@ -169,8 +182,12 @@ static int irq_domain_set_name(struct irq_domain *domain,
 	if (!domain->name) {
 		if (fwnode)
 			pr_err("Invalid fwnode type for irqdomain\n");
-		domain->name = kasprintf(GFP_KERNEL, "unknown-%d",
-					 atomic_inc_return(&unknown_domains));
+		domain->name = bus_token ?
+				kasprintf(GFP_KERNEL, "unknown-%d-%d",
+					  atomic_inc_return(&unknown_domains),
+					  bus_token) :
+				kasprintf(GFP_KERNEL, "unknown-%d",
+					  atomic_inc_return(&unknown_domains));
 		if (!domain->name)
 			return -ENOMEM;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
@@ -194,7 +211,7 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
-	err = irq_domain_set_name(domain, info->fwnode);
+	err = irq_domain_set_name(domain, info->fwnode, info->bus_token);
 	if (err) {
 		kfree(domain);
 		return ERR_PTR(err);
@@ -207,6 +224,7 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
 	domain->ops = info->ops;
 	domain->host_data = info->host_data;
+	domain->bus_token = info->bus_token;
 	domain->hwirq_max = info->hwirq_max;
 
 	if (info->direct_max)
-- 
2.45.0


