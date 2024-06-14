Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF8E8C27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jYNoEWBZlzduIVJgCOvsuNgUKgrmtRin0j3Jv9ZGB0c=; b=XcHoidX1LYqmnCCRalosFMarjI
	GUmQTh4derG+sWbQCi7BAQQz7WTvY46Zqjr+sXLFmNVQ325G3cGbY/TtQMv4SYlr00E/PwwuTfRdT
	VsTF1pwf7FTfDsu5gNojqnasgEbiZ4PNvNblImbctKZRCILTeMlvwBThVtxBPNWREQluuTz0LMoLg
	rO7J9lZ1XRTJ6N0IB+ESpibdjIGC7EcdjiHGRMX+0NSudQ4Sorm+iQHS4wUH8+wdz1uG1xwIKBtjk
	3hFHl7Q6sD5JETg8rSb69IuIvdA0WPGGjuH0rVxqSN10T5OD1q4x6TTy5QXxmFk6hjF+QkIfVTMCe
	8471xS3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnb-00000003eWJ-1nOo;
	Fri, 14 Jun 2024 17:33:15 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnN-00000003eHA-2RUa
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:03 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 4869DFF803;
	Fri, 14 Jun 2024 17:32:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jYNoEWBZlzduIVJgCOvsuNgUKgrmtRin0j3Jv9ZGB0c=;
	b=ez3HgDN5+vlxZQZG+rEbv4mPtd20Jh6XPRZ9uxw3I8+BErytIt+OAYVo4zhZLQ0vAfKpUO
	b0Xlm6nC17l5QUZMzNACZuWBjiaK26labQ9G7oornNfGsCCHESnlxBH7Z9AfcBDzI1AzeF
	xQTdnTGeLhJYqUFpmInrsyvocUdKtPnWoyN8ddQiM4jn+xh/+ob1D3vHJQQTM9Va8v/VsG
	HNLZ3o4f8kuYi5+ZIYEMDBIlH0IQUjM/Scvuzz1mFOdWWQ9oLCHSH8dxIoBBJ9tv5bFs1u
	Iiu5rzH9AWc35IVwQj19e+3qWiMS9j+lx3rMhfwQODHD4PdR9DLVA3PEdypJGw==
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
Subject: [PATCH 15/23] irqdomain: Add support for generic irq chips creation before publishing a domain
Date: Fri, 14 Jun 2024 19:32:16 +0200
Message-ID: <20240614173232.1184015-16-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103302_102885_60741867 
X-CRM114-Status: GOOD (  19.17  )
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

The current API functions create an irq_domain and also publish this
newly created to domain. Once an irq_domain is published, consumers can
request IRQ in order to use them.

Some interrupt controller drivers have to perform some more operations
with the created irq_domain in order to have it ready to be used.
For instance:
   - Allocate generic irq chips with irq_alloc_domain_generic_chips()
   - Retrieve the generic irq chips with irq_get_domain_generic_chip()
   - Initialize retrieved chips: set register base address and offsets,
     set several hooks such as irq_mask, irq_unmask, ...

With the newly introduced irq_domain_alloc_generic_chips(), an interrupt
controller driver can use the irq_domain_chip_generic_info structure and
set the init() hook to perform its generic chips initialization.

In order to avoid a window where the domain is published but not yet
ready to be used, handle the generic chip creation (i.e the
irq_domain_alloc_generic_chips() call) before the domain is published.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  9 +++++++++
 kernel/irq/irqdomain.c    | 14 +++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 2c927edc4d43..5540b22a755c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -210,6 +210,9 @@ enum {
 	/* Irq domain is a MSI device domain */
 	IRQ_DOMAIN_FLAG_MSI_DEVICE	= (1 << 9),
 
+	/* Irq domain must destroy generic chips when removed */
+	IRQ_DOMAIN_FLAG_DESTROY_GC	= (1 << 10),
+
 	/*
 	 * Flags starting from IRQ_DOMAIN_FLAG_NONCORE are reserved
 	 * for implementation specific purposes and ignored by the
@@ -259,6 +262,9 @@ static inline struct fwnode_handle *irq_domain_alloc_fwnode(phys_addr_t *pa)
 }
 
 void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
+
+struct irq_domain_chip_generic_info;
+
 /**
  * struct irq_domain_info - Domain information structure
  * @fwnode:		firmware node for the interrupt controller
@@ -270,6 +276,8 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  * @bus_token:		Domain bus token
  * @ops:		Domain operation callbacks
  * @host_data:		Controller private data pointer
+ * @dgc_info:		Geneneric chip information structure pointer used to
+ *			create generic chips for the domain if not NULL.
  * @init:		Function called when the domain is created.
  *			Allow to do some additional domain initialisation.
  * @exit:		Function called when the domain is destroyed.
@@ -290,6 +298,7 @@ struct irq_domain_info {
 	 */
 	struct irq_domain			*parent;
 #endif
+	struct irq_domain_chip_generic_info	*dgc_info;
 	int					(*init)(struct irq_domain *d);
 	void					(*exit)(struct irq_domain *d);
 };
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 9efc9f180308..d95ca575a108 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -292,16 +292,25 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	}
 #endif
 
+	if (info->dgc_info) {
+		err = irq_domain_alloc_generic_chips(domain, info->dgc_info);
+		if (err)
+			goto err_domain_free;
+	}
+
 	if (info->init) {
 		err = info->init(domain);
 		if (err)
-			goto err_domain_free;
+			goto err_domain_gc_remove;
 	}
 
 	__irq_domain_publish(domain);
 
 	return domain;
 
+err_domain_gc_remove:
+	if (info->dgc_info)
+		irq_domain_remove_generic_chips(domain);
 err_domain_free:
 	irq_domain_free(domain);
 	return ERR_PTR(err);
@@ -369,6 +378,9 @@ void irq_domain_remove(struct irq_domain *domain)
 
 	mutex_unlock(&irq_domain_mutex);
 
+	if (domain->flags & IRQ_DOMAIN_FLAG_DESTROY_GC)
+		irq_domain_remove_generic_chips(domain);
+
 	pr_debug("Removed domain %s\n", domain->name);
 	irq_domain_free(domain);
 }
-- 
2.45.0


