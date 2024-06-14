Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9952AC27C79
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TgSTclGEyMVNAcyML8FqLvo4YRpuke6IGp+WHuItynU=; b=SK/W+9kteJkuwQZo9au/r5Tf4x
	5RR8/g5LmFekccBhZE73SddGzw/bGRce39/s9oVO/re6Q5+LNUoAXt+J3ZE5MUpoz1222c/LIydGt
	2lLaIfVjsthwRZ0aCrtkWXTm9LtnAULazaim594vzMBk+LFoUy1/Y0BHAo4UErBxC0BQop4LhcaXC
	eewHMQImAc1vHYmd8vVMhmp1KfYOU3x+Ua9wP9o81c3reBOVioPRNv2wRPqOovM2gcweHT0dAZziR
	B+HkjFuts0+0fZdlJQ4Jk6b5nTC7kVono+XtPP03s8zYH1b3iWP1KZ+q0R6R83GYzzRI0fSeNy4UH
	ZhNC8e9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnd-00000003eXX-0ejc;
	Fri, 14 Jun 2024 17:33:17 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnN-00000003eI6-34l2
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:05 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 1569EFF806;
	Fri, 14 Jun 2024 17:32:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386379;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TgSTclGEyMVNAcyML8FqLvo4YRpuke6IGp+WHuItynU=;
	b=dEv8F+YnoNI0QIBoh3E5anMu3hKDqUOCr8ora+u+Di5YR922JEF+cKtDfeUAM6W3MK1yuU
	zZOBncfdU/J4snrEKG7burRvMzc4gCJW3fkvfKsNmQHoqJONN3PsE0v9DnEoQmk9YTLrGq
	qayVRK9g3/daqT9BizVyKmQ3aUZB9THh5TNa7QG0rKRcPQvql4rEY+9UmapVDWiWcwXB5H
	j7kvJWE4WvIqxaPjsT3Z3oIrgdU3gzhyzre0jNOb7NyoJX9+VbQ+hT8MuOJhiIh5ZI1tfe
	Smx+ZrOZpDDru6tzqqm/opoLeAehq5Q9LUWxuz12kWrsMi262Zx2akJKw4gYww==
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
Subject: [PATCH 16/23] irqdomain: Add a resource managed version of irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:17 +0200
Message-ID: <20240614173232.1184015-17-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103302_186188_8F07A3DF 
X-CRM114-Status: GOOD (  13.28  )
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

Add a devres version of irq_domain_instantiate().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  2 ++
 kernel/irq/devres.c       | 41 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 43 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5540b22a755c..8820317582c4 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -304,6 +304,8 @@ struct irq_domain_info {
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
+struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
+					       const struct irq_domain_info *info);
 
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515ee077..b3e98668f4dd 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
 #include <linux/irq.h>
@@ -282,3 +283,43 @@ int devm_irq_setup_generic_chip(struct device *dev, struct irq_chip_generic *gc,
 }
 EXPORT_SYMBOL_GPL(devm_irq_setup_generic_chip);
 #endif /* CONFIG_GENERIC_IRQ_CHIP */
+
+#ifdef CONFIG_IRQ_DOMAIN
+static void devm_irq_domain_remove(struct device *dev, void *res)
+{
+	struct irq_domain **domain = res;
+
+	irq_domain_remove(*domain);
+}
+
+/**
+ * devm_irq_domain_instantiate() - Instantiate a new irq domain data for a
+ *                                 managed device.
+ * @dev:	Device to instantiate the domain for
+ * @info:	Domain information pointer pointing to the information for this
+ *		domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
+					       const struct irq_domain_info *info)
+{
+	struct irq_domain *domain;
+	struct irq_domain **dr;
+
+	dr = devres_alloc(devm_irq_domain_remove, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	domain = irq_domain_instantiate(info);
+	if (!IS_ERR(domain)) {
+		*dr = domain;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(devm_irq_domain_instantiate);
+#endif /* CONFIG_IRQ_DOMAIN */
-- 
2.45.0


