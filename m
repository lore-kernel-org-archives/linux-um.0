Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0009BC27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bCrIqBOqgd8IhI1XvRqpnH65nvLXt6DnzPIXbQl0ooU=; b=AS1bKCDlglfpqWWfMTeT1TwGQz
	2Xc5Gb7ojdthe5DLmqNYJJJhUZl88anvCJoUCEKyXcQBMph72tZUQJ/JiaorULCqrQqGGXfvrfpts
	cbr+7UyLzlMIdGAzCJnDSLHTljWp3DU3t7NyP0u/SnThatHBqjxO3D2oICEjQKT6ilRI2UM0O0mhU
	JHUUbnI+TxnonudvgxKZ7rJIr4lzAElsTxc+YUrkiqD/tTytYRQau4ApEpj7Zk5qlPEw90Y1JYZOS
	lUK1DCo2pIjMitHgF4MKa8MICqP7GZNhMjrRSc0j22adQj6pR9+dpsnZbNIC/NcEBhKKS+mqbo/Uz
	FKhPrVVg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnZ-00000003eU4-1b4Y;
	Fri, 14 Jun 2024 17:33:13 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnK-00000003eER-0XkG
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:00 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 97823FF805;
	Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386376;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bCrIqBOqgd8IhI1XvRqpnH65nvLXt6DnzPIXbQl0ooU=;
	b=lKjvYVPRbwgWGiXtVyYKgzayJgQnlEq99TCZ2S90A2zRcZKPLUMG57o2C+Bqs3YVLxQ75b
	v+mbvSRxvEw60jOeDANphC7wTr/NggD0ZQaLgOdLB7V2PRg4OoueEPT44gRJ4xpam0WoP6
	BzIuaxb8+IZ0T4rV4St3oiO1tpkW8YbOH+if7Jrj0qK3AgM7PeU76pb9Tz44jySjHBnBbp
	Ew+xB06m7amr/lpmIqo4yWNv/TLS+T4ru/C1bPNW0mEPdslWQFgO1IDzmruDmQ0BeSeu9i
	/a3z35N9d0ECq9wDzBOBAWMtVxq7jI0cx/nLbt9Zd7LBHpejcrS3PdBgZ+4vEA==
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
Subject: [PATCH 12/23] irqdomain: Introduce init() and exit() hooks
Date: Fri, 14 Jun 2024 19:32:13 +0200
Message-ID: <20240614173232.1184015-13-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103258_552711_BED76C1F 
X-CRM114-Status: GOOD (  14.01  )
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

The current API does not allow additional initialization before the
domain is published. This can lead to a race condition between consumers
and supplier as a domain can be available for consumers before being
fully ready.

Introduce the init() hook to allow additional initialization before
plublishing the domain. Also introduce the exit() hook to revert
operations done in init() on domain removal.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  8 ++++++++
 kernel/irq/irqdomain.c    | 15 +++++++++++++++
 2 files changed, 23 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 52bed23e5c61..2c927edc4d43 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -141,6 +141,7 @@ struct irq_domain_chip_generic;
  *		purposes related to the irq domain.
  * @parent:	Pointer to parent irq_domain to support hierarchy irq_domains
  * @msi_parent_ops: Pointer to MSI parent domain methods for per device domain init
+ * @exit:	Function called when the domain is destroyed
  *
  * Revmap data, used internally by the irq domain code:
  * @revmap_size:	Size of the linear map table @revmap[]
@@ -169,6 +170,7 @@ struct irq_domain {
 #ifdef CONFIG_GENERIC_MSI_IRQ
 	const struct msi_parent_ops	*msi_parent_ops;
 #endif
+	void				(*exit)(struct irq_domain *d);
 
 	/* reverse map data. The linear map gets appended to the irq_domain */
 	irq_hw_number_t			hwirq_max;
@@ -268,6 +270,10 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
+ * @init:		Function called when the domain is created.
+ *			Allow to do some additional domain initialisation.
+ * @exit:		Function called when the domain is destroyed.
+ *			Allow to do some additional cleanup operation.
  */
 struct irq_domain_info {
 	struct fwnode_handle			*fwnode;
@@ -284,6 +290,8 @@ struct irq_domain_info {
 	 */
 	struct irq_domain			*parent;
 #endif
+	int					(*init)(struct irq_domain *d);
+	void					(*exit)(struct irq_domain *d);
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index d05aeb9c0a67..9efc9f180308 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -276,12 +276,14 @@ static void irq_domain_free(struct irq_domain *domain)
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 {
 	struct irq_domain *domain;
+	int err;
 
 	domain = __irq_domain_create(info);
 	if (IS_ERR(domain))
 		return ERR_CAST(domain);
 
 	domain->flags |= info->domain_flags;
+	domain->exit = info->exit;
 
 #ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
 	if (info->parent) {
@@ -290,9 +292,19 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	}
 #endif
 
+	if (info->init) {
+		err = info->init(domain);
+		if (err)
+			goto err_domain_free;
+	}
+
 	__irq_domain_publish(domain);
 
 	return domain;
+
+err_domain_free:
+	irq_domain_free(domain);
+	return ERR_PTR(err);
 }
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
@@ -339,6 +351,9 @@ EXPORT_SYMBOL_GPL(__irq_domain_add);
  */
 void irq_domain_remove(struct irq_domain *domain)
 {
+	if (domain->exit)
+		domain->exit(domain);
+
 	mutex_lock(&irq_domain_mutex);
 	debugfs_remove_domain_dir(domain);
 
-- 
2.45.0


