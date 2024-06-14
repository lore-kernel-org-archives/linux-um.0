Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F090C27C77
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gbvgscye7X8+RemWHl+jq7TxdKmm/D41gcDp9jZK0oo=; b=tGkPknUHRQ9E+rNw9mzt0MMKRE
	8nX1e2oFuhj4ak8x5CW1NIlQE0Q6isAyZ3i+TbyGKtmBXp5qhREuP0SfZpcYv8XN/XWoySCQbxLGs
	//M2nv9m7khOkkKLQs9yzkieDHRILXdvT7EQIjJR5AV1ZmfHAaQWpFcCGVW6k6VCqghgfKiquQwOY
	id6pnXknMePrFj/rQQqJ/GO6qRyU8OfmdYuY/cYrgB+EX1L855UpDMqOU7U6zZzEKBPLtKrj2Buk9
	GMcMA4vinXPe2fmBj9apEnkHe3q7N5eExwhN+5wiO3T5j8fZZY6dPl4Vz6qmEwwGGRc0JJyopbdkj
	N2kmAYog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAna-00000003eVZ-3hDO;
	Fri, 14 Jun 2024 17:33:14 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnL-00000003eGW-3H3L
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:03 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 64542FF804;
	Fri, 14 Jun 2024 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gbvgscye7X8+RemWHl+jq7TxdKmm/D41gcDp9jZK0oo=;
	b=aspKBPe6SV6vCwYniMfxh+fFuWqoqZcKl9dbM11gV0d4QwGndS1/VUvkhAsDIADTanaOnS
	B77RKSGsYZxRjpWRNVNBO6eEmVrXySk47PSkxOOrB0AbGOe2u5a2/SEzWi4Q/876Rb2fzb
	oOeSsFi4g3L1RyEwJBBxPUzUyuZFGIrJLSGx+d37v7NYP0KjEKX8qFtmbMWsfmszg5ULob
	6dnFyDwcB2qWRMJptXwnt+ly0z7QUPz1Ix49vdBomtfgXMwPA3bptSTVyw39aBYqbT0ZRN
	R06P9ogRgs/BNs2OznRo71+RFdwcf6ReaRgUw+Onog+8tI8im+ODYwEH7hTRjg==
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
Subject: [PATCH 14/23] genirq/generic_chip: Introduce init() and exit() hooks
Date: Fri, 14 Jun 2024 19:32:15 +0200
Message-ID: <20240614173232.1184015-15-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103300_181690_FA29409F 
X-CRM114-Status: GOOD (  16.96  )
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

Most of generic chip drivers need to perform some more additional
initializations on the generic chips allocated before they can be fully
ready.

These additional initializations need to be performed before the IRQ
domain is published to avoid a race condition between IRQ consumers and
suppliers.

Introduce the init() hook to perform these initializations at the right
place just after the generic chip creation. Also introduce the exit()
hook to allow reververting operations done by the init() hook just
before the generic chip is destroyed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irq.h       |  8 ++++++++
 kernel/irq/generic-chip.c | 24 ++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 58264b236cbf..712bcee56efc 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1106,6 +1106,7 @@ enum irq_gc_flags {
  * @irq_flags_to_set:	IRQ* flags to set on irq setup
  * @irq_flags_to_clear:	IRQ* flags to clear on irq setup
  * @gc_flags:		Generic chip specific setup flags
+ * @exit:		Function called on each chip when they are destroyed.
  * @gc:			Array of pointers to generic interrupt chips
  */
 struct irq_domain_chip_generic {
@@ -1114,6 +1115,7 @@ struct irq_domain_chip_generic {
 	unsigned int		irq_flags_to_clear;
 	unsigned int		irq_flags_to_set;
 	enum irq_gc_flags	gc_flags;
+	void			(*exit)(struct irq_chip_generic *gc);
 	struct irq_chip_generic	*gc[];
 };
 
@@ -1127,6 +1129,10 @@ struct irq_domain_chip_generic {
  * @irq_flags_to_clear:	IRQ_* bits to clear in the mapping function
  * @irq_flags_to_set:	IRQ_* bits to set in the mapping function
  * @gc_flags:		Generic chip specific setup flags
+ * @init:		Function called on each chip when they are created.
+ *			Allow to do some additional chip initialisation.
+ * @exit:		Function called on each chip when they are destroyed.
+ *			Allow to do some chip cleanup operation.
  */
 struct irq_domain_chip_generic_info {
 	const char		*name;
@@ -1136,6 +1142,8 @@ struct irq_domain_chip_generic_info {
 	unsigned int		irq_flags_to_clear;
 	unsigned int		irq_flags_to_set;
 	enum irq_gc_flags	gc_flags;
+	int			(*init)(struct irq_chip_generic *gc);
+	void			(*exit)(struct irq_chip_generic *gc);
 };
 
 /* Generic chip callback functions */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index d9696f5dcc38..32ffcbb87fa1 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -293,6 +293,7 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 	size_t gc_sz;
 	size_t sz;
 	void *tmp;
+	int ret;
 
 	if (d->gc)
 		return -EBUSY;
@@ -314,6 +315,7 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 	dgc->irq_flags_to_set = info->irq_flags_to_set;
 	dgc->irq_flags_to_clear = info->irq_flags_to_clear;
 	dgc->gc_flags = info->gc_flags;
+	dgc->exit = info->exit;
 	d->gc = dgc;
 
 	/* Calc pointer to the first generic chip */
@@ -331,6 +333,12 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 			gc->reg_writel = &irq_writel_be;
 		}
 
+		if (info->init) {
+			ret = info->init(gc);
+			if (ret)
+				goto err;
+		}
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
@@ -338,6 +346,16 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 		tmp += gc_sz;
 	}
 	return 0;
+
+err:
+	while (i--) {
+		if (dgc->exit)
+			dgc->exit(dgc->gc[i]);
+		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
+	}
+	d->gc = NULL;
+	kfree(dgc);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_domain_alloc_generic_chips);
 
@@ -353,9 +371,11 @@ void irq_domain_remove_generic_chips(struct irq_domain *d)
 	if (!dgc)
 		return;
 
-	for (i = 0; i < dgc->num_chips; i++)
+	for (i = 0; i < dgc->num_chips; i++) {
+		if (dgc->exit)
+			dgc->exit(dgc->gc[i]);
 		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
-
+	}
 	d->gc = NULL;
 	kfree(dgc);
 }
-- 
2.45.0


