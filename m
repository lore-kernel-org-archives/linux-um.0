Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03FF9C27C79
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+CQfiI+Nq1S9v1Nm6K78UW44sXVdGGexG8I5gR9gXYM=; b=MkJK5y5qsMaYFEL6KkRIkPMT4e
	s9FO0PBa5rlTjA3M9orDtE2DSSQSytG8O7HOmf78YcS4mSH3lB7Jn6fqus9yKQyrQ4LynBCsq+bG0
	YoQIVG194Px0AkeGBqoRueID6d3/njeQ1KSLMCa4HfPt+oH23LNm7SdylU3P0eQieEZLzZSRfLCv0
	WBiC4gP0GtUhC5p5RqokONPyX9jqfRmPUMzHAjdp+HNCN/6qBnOV4h0rIxoniCTR099WNpN/r3CeW
	KXkblmeym5EIXu+R25ZImnCngL9WwQsl1rLIaDWXlUPa3jjLHOVItFI7XzXiVkKOEQ0ri1++T204T
	S4ETQzwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnF-00000003eAg-3MJZ;
	Fri, 14 Jun 2024 17:32:53 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnB-00000003e7G-2YyC
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:52 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id B4F37FF803;
	Fri, 14 Jun 2024 17:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386366;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+CQfiI+Nq1S9v1Nm6K78UW44sXVdGGexG8I5gR9gXYM=;
	b=K4mjauuGA30E+3QwBWCUnq0ia7ivGj9hrqSLbujhgwzAtgq6x89MuJTpz1udhPcEH+ZIbw
	nWaJiGSDGdXijQaZn6wMu+fvH4tWrcbD4fHzt5NlQa5Z4ORlpYZqssNWBeACWggtvYZcRc
	ECER1RTDcsJY30Y+LfW5hSUCGKzMn34/0GNRLQzX377vdW7iXju7rLa3/feML2gMAJFjKv
	0uUScPaUzURWX9ycbe21cdRoFjbnBjNoNgZRTfq1EPgjfe7cpiMypDSltLKfpiWla9T3OX
	RSOd5yQIzXU+L8SV5QNM1v9fqXcE1HdDuIEOQJbDKF+5wr5s9x+EzLDEJGBWHw==
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
Subject: [PATCH 01/23] irqdomain: Introduce irq_domain_free()
Date: Fri, 14 Jun 2024 19:32:02 +0200
Message-ID: <20240614173232.1184015-2-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103249_823788_AF8BA338 
X-CRM114-Status: UNSURE (   9.69  )
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

In preparation of the introduction of the irq domain instantiation,
introduce irq_domain_free() to avoid code duplication on later
modifications.

This new function is an extraction of the current operations performed
to free the irq domain. No functional changes are introduced.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 86f8b91b0d3a..95eda206367f 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -241,6 +241,15 @@ static void __irq_domain_publish(struct irq_domain *domain)
 	pr_debug("Added domain %s\n", domain->name);
 }
 
+static void irq_domain_free(struct irq_domain *domain)
+{
+	fwnode_dev_initialized(domain->fwnode, false);
+	fwnode_handle_put(domain->fwnode);
+	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
+		kfree(domain->name);
+	kfree(domain);
+}
+
 /**
  * __irq_domain_add() - Allocate a new irq_domain data structure
  * @fwnode: firmware node for the interrupt controller
@@ -296,12 +305,7 @@ void irq_domain_remove(struct irq_domain *domain)
 	mutex_unlock(&irq_domain_mutex);
 
 	pr_debug("Removed domain %s\n", domain->name);
-
-	fwnode_dev_initialized(domain->fwnode, false);
-	fwnode_handle_put(domain->fwnode);
-	if (domain->flags & IRQ_DOMAIN_NAME_ALLOCATED)
-		kfree(domain->name);
-	kfree(domain);
+	irq_domain_free(domain);
 }
 EXPORT_SYMBOL_GPL(irq_domain_remove);
 
-- 
2.45.0


