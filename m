Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 469F5C27C7B
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:32:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ca0pykPy27OXtm3bTG0aktosDK2ivFUX0Gy7JXRbMjQ=; b=EDjaB6w0HRjO6IAgQp72tCtURi
	RrxucZMCFgERHIslV03RAkMfbGxWumFLxxmwZqrjJuZ43XCUzwSyd8uZM+xNbKCnsJL//lmTiprqW
	KE52b8y2P9m9anBleYIE5Z4vbrnQ+BfhGz+4soBZ7kh7tUJit5S+K8rzKfThEGNqgKBdvuRUVhQRf
	1jmWWP0dOIZnWH1So+XIeQ/zmadzm4b6vwc5nJ3dXNu2YRdQMj/Ok4MPp9x3z39IMj3DnYLfcB0Gz
	2r+qOUfW3MdXpga54vAvCFVGkLzAk8c9kfJ32ksU5IF7Q2x+ErEOXuBDE8z1lHG3NHOLIaevUGsv6
	8UITH8Zw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnH-00000003eCP-2K3O;
	Fri, 14 Jun 2024 17:32:55 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnC-00000003e7c-2tIp
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:53 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 9BC49FF804;
	Fri, 14 Jun 2024 17:32:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386367;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ca0pykPy27OXtm3bTG0aktosDK2ivFUX0Gy7JXRbMjQ=;
	b=cRIZAOXg+a9QOqYi/VkNDf12QOxTHNPKQl2zgBXY2dknlLg+ibAI5834xtU9Ypmi7kPyyc
	2XcfKB5c+IT1gz/ZF6vsZh2IMwyk8YTJhC79FMG6wVh6/AVFC8nsWqlbB7pZhcAgvIH/cY
	+4DZvDgoFN5qI7eHFqIHWoDgwjkiegBCYaM6kasGVP5nI/HmKvJklqn6EoZxzZCUQb42gB
	c8PJNtw4RZ64ff0j/x42FguU7YEEBOcG2I4jzjavfC/hrSzK2oxwmbCUM2dvAkkZjHniNw
	8q9tYcirf0px5FiQWUpnvJ2CA8GEj+A24yzvLI01OXJG+RWxRdSRJ0UvDvb5Ng==
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
Subject: [PATCH 02/23] irqdomain: Introduce irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:03 +0200
Message-ID: <20240614173232.1184015-3-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103251_119240_5E23A892 
X-CRM114-Status: GOOD (  15.20  )
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

The existing irq_domain_add_*() functions used to instantiate an IRQ
domain are wrappers built on top of __irq_domain_add() and describes the
domain properties using a bunch of parameters.

Adding more parameters and wrappers to hide new parameters in the
existing code lead to more and more code without any relevant values and
without any flexibility.

Introduce irq_domain_instantiate() where the IRQ domain properties are
given using the irq_domain_info structure instead of the bunch of
parameters to allow flexibility and easy evolution.

This new irq_domain_instantiate() perform the same operation as the one
done by __irq_domain_add(). For compatibility reason with existing code,
keep __irq_domain_add() but convert it to irq_domain_instantiate().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 21 +++++++++++++++++++++
 kernel/irq/irqdomain.c    | 39 ++++++++++++++++++++++++++++++++-------
 2 files changed, 53 insertions(+), 7 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 21ecf582a0fe..ab8939c8724d 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -257,6 +257,27 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+/**
+ * struct irq_domain_info - Domain information structure
+ * @fwnode:		firmware node for the interrupt controller
+ * @size:		Size of linear map; 0 for radix mapping only
+ * @hwirq_max:		Maximum number of interrupts supported by controller
+ * @direct_max:		Maximum value of direct maps;
+ *			Use ~0 for no limit; 0 for no direct mapping
+ * @ops:		Domain operation callbacks
+ * @host_data:		Controller private data pointer
+ */
+struct irq_domain_info {
+	struct fwnode_handle			*fwnode;
+	unsigned int				size;
+	irq_hw_number_t				hwirq_max;
+	int					direct_max;
+	const struct irq_domain_ops		*ops;
+	void					*host_data;
+};
+
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
+
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
 				    const struct irq_domain_ops *ops,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 95eda206367f..012ada09b419 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -250,6 +250,27 @@ static void irq_domain_free(struct irq_domain *domain)
 	kfree(domain);
 }
 
+/**
+ * irq_domain_instantiate() - Instantiate a new irq domain data structure
+ * @info: Domain information pointer pointing to the information for this domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
+{
+	struct irq_domain *domain;
+
+	domain = __irq_domain_create(info->fwnode, info->size, info->hwirq_max,
+				     info->direct_max, info->ops, info->host_data);
+	if (!domain)
+		return ERR_PTR(-ENOMEM);
+
+	__irq_domain_publish(domain);
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(irq_domain_instantiate);
+
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @fwnode: firmware node for the interrupt controller
@@ -268,14 +289,18 @@ struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int s
 				    const struct irq_domain_ops *ops,
 				    void *host_data)
 {
-	struct irq_domain *domain;
-
-	domain = __irq_domain_create(fwnode, size, hwirq_max, direct_max,
-				     ops, host_data);
-	if (domain)
-		__irq_domain_publish(domain);
+	struct irq_domain_info info = {
+		.fwnode = fwnode,
+		.size = size,
+		.hwirq_max = hwirq_max,
+		.direct_max = direct_max,
+		.ops = ops,
+		.host_data = host_data,
+	};
+	struct irq_domain *d;
 
-	return domain;
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 EXPORT_SYMBOL_GPL(__irq_domain_add);
 
-- 
2.45.0


