Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4E8BEC27C77
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F4UTRwPoFTKHJqdbzIHC3NBEYq/X/HYViIjDNKKF0PI=; b=BWAjHEghFxvPJPJRK0lwzmbbJz
	wKqV1iDSjHMDizROMi5oFZ7lyCQxhjBmVKWLF9THxvZRxbuvx7Kz97AwdJJT+rx21cLSa1MFc8ulz
	IIaqRzTuTKDzAS1GOWJ36lRX45VOmVgFCkI6uHg8Y/5b4Y98RHm7byOkA0qRBP+VZ5YIzcgRJREFb
	yKUH3Od6Cb1gRQ1v7Qb4NpYoy83dqjiWjWRt9tjcLHEnc9ERrwxrLGFmuZ6S+sw8fpmWQDzYAaEF+
	ucN2UHz7Qg2KHjofGIGzao5Y6n0RV5jQdeuPWrxIf1H+ormaGgAA61gAWjp/6Ud6sjachQZIEXZeE
	bbMmYWDg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnj-00000003edB-1Yuj;
	Fri, 14 Jun 2024 17:33:23 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnR-00000003eLk-0Bsb
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:10 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 7DC07FF80A;
	Fri, 14 Jun 2024 17:33:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386383;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F4UTRwPoFTKHJqdbzIHC3NBEYq/X/HYViIjDNKKF0PI=;
	b=JwwhzYuMC8Ol30/NGIcS3ArYrXZ4xbLT093w7YISLo/DU4gvnghJ+scUFMWBB5DlfW+9ke
	SwSo9g14jsySVjdYBqOqF/fJhd5GQHzTOpc2QQVIET9bKEPya7d7dmevq/G2adZhDUWqTc
	OUZrpK2Xp7l8ABxLrenaUHRuEO8ykLlMMepEGUhoigjQMcQKHMTSY0YzzdL0BlKuQIjYUy
	18CPFExQFfRu9GWxlCn0OTU8tp17qyWGPY3i0CC1aTKc99JCAG+WcACcuhZCGTXgUcKH+J
	rGOGUdk9uPI4n1rwhiccdOm4XYj7EbTOPtBsAessVOqc37LtNU9Lc96wqJbN0g==
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
Subject: [PATCH 20/23] irqdomain: Remove __irq_domain_add()
Date: Fri, 14 Jun 2024 19:32:21 +0200
Message-ID: <20240614173232.1184015-21-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103305_850259_C36FF63A 
X-CRM114-Status: GOOD (  11.67  )
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

__irq_domain_add() has been replaced by irq_domain_instanciate() and so,
it is no more used.

Simply remove it.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h |  6 +-----
 kernel/irq/irqdomain.c    | 33 ---------------------------------
 2 files changed, 1 insertion(+), 38 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 1cd1cbf57736..401dca796633 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -184,7 +184,7 @@ enum {
 	/* Irq domain is hierarchical */
 	IRQ_DOMAIN_FLAG_HIERARCHY	= (1 << 0),
 
-	/* Irq domain name was allocated in __irq_domain_add() */
+	/* Irq domain name was allocated internally */
 	IRQ_DOMAIN_NAME_ALLOCATED	= (1 << 1),
 
 	/* Irq domain is an IPI domain with virq per cpu */
@@ -307,10 +307,6 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
 struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
 					       const struct irq_domain_info *info);
 
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data);
 struct irq_domain *irq_domain_create_simple(struct fwnode_handle *fwnode,
 					    unsigned int size,
 					    unsigned int first_irq,
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index e1ceb2ba2699..53c38f951348 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -317,39 +317,6 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 }
 EXPORT_SYMBOL_GPL(irq_domain_instantiate);
 
-/**
- * __irq_domain_add() - Allocate a new irq_domain data structure
- * @fwnode: firmware node for the interrupt controller
- * @size: Size of linear map; 0 for radix mapping only
- * @hwirq_max: Maximum number of interrupts supported by controller
- * @direct_max: Maximum value of direct maps; Use ~0 for no limit; 0 for no
- *              direct mapping
- * @ops: domain callbacks
- * @host_data: Controller private data pointer
- *
- * Allocates and initializes an irq_domain structure.
- * Returns pointer to IRQ domain, or NULL on failure.
- */
-struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
-				    irq_hw_number_t hwirq_max, int direct_max,
-				    const struct irq_domain_ops *ops,
-				    void *host_data)
-{
-	struct irq_domain_info info = {
-		.fwnode = fwnode,
-		.size = size,
-		.hwirq_max = hwirq_max,
-		.direct_max = direct_max,
-		.ops = ops,
-		.host_data = host_data,
-	};
-	struct irq_domain *d;
-
-	d = irq_domain_instantiate(&info);
-	return IS_ERR(d) ? NULL : d;
-}
-EXPORT_SYMBOL_GPL(__irq_domain_add);
-
 /**
  * irq_domain_remove() - Remove an irq domain.
  * @domain: domain to remove
-- 
2.45.0


