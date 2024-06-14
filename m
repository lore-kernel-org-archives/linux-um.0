Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19CE9C27C77
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+NkYxenKEC9OO3jJ3gxAE6moq1UMvEUEbQkI5OAK8Bk=; b=0VlIjiFL3yM3c5oHfp41Jj6UN6
	iHHJnsvVHJAGEvbekkTg8ywXc6Tcoe4/WRJigunni9gK2OZIjhyvvkobt/6c4XsexAtiVFWdoUu3H
	YtmwQw07rEsJ2oBNPJ3gLwx1AuN+EIVrtocjT2WKqYT9jpXpxABTwvAT/8ZutgCz9h1W+X6mXCaPn
	LWmDnGLip1jau3mkMmJfvmbAsmP+l9hTSQTuUIcIgThFvBy8/45HKlQMyhfCgXOSOUQH+bUwCF/0C
	W7yUkPSKnyrdtSyeOqcNO1U6ax/3ahxQtWrtmAEf0+jV08RdKBSQ+zhriKQZdOp0ELcgz+miVfPgY
	JmUDA1pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnP-00000003eKq-1jvm;
	Fri, 14 Jun 2024 17:33:03 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnG-00000003eAD-22ih
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:56 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 2C61DFF80C;
	Fri, 14 Jun 2024 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+NkYxenKEC9OO3jJ3gxAE6moq1UMvEUEbQkI5OAK8Bk=;
	b=VQBWA83dpargUL4CS6k35jbg8SKlxJAGPHYkzdgEEmtSl5vL1cntkYI6XkIIjtpa9pDh4C
	Av7cVO9vJakY5eylBEXku6OTiL6KMd2IOoKoyZB1SLoNStAzpyvs85hnVXiKH67aGUg5LB
	cNwthBjvoeORgsoaoJphzeU0KPfxvLfHwOvCaJdYipR1WwrcdSwhr4lt7trgfKo87JTomj
	eYlaobYjgGaP/5//iadWWn3YmYO8hWG7wTbkm86mYcq0xYCQouc+z91tocA0gslxRiXzir
	ZjNP2Vq6LDpRBig9FY/deNx2YTwmjqn037zuEpG0NOWpBeyNn9I+8emIGlKV9A==
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
Subject: [PATCH 08/23] irqdomain: Handle domain hierarchy parent in irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:09 +0200
Message-ID: <20240614173232.1184015-9-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103254_746161_1DC0C682 
X-CRM114-Status: UNSURE (   8.79  )
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

To use irq_domain_instantiate() from irq_domain_create_hierarchy(),
irq_domain_instantiate() needs to handle the domain hierarchy parent.

Handle this parent.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 6 ++++++
 kernel/irq/irqdomain.c    | 7 +++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 4683b66eded9..e52fd5e5494c 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -276,6 +276,12 @@ struct irq_domain_info {
 	int					direct_max;
 	const struct irq_domain_ops		*ops;
 	void					*host_data;
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	/**
+	 * @parent: Pointer to the parent irq domain used in a hierarchy domain
+	 */
+	struct irq_domain			*parent;
+#endif
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 34acc2ccfee7..7e4a1da63549 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -265,6 +265,13 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 
 	domain->flags |= info->domain_flags;
 
+#ifdef CONFIG_IRQ_DOMAIN_HIERARCHY
+	if (info->parent) {
+		domain->root = info->parent->root;
+		domain->parent = info->parent;
+	}
+#endif
+
 	__irq_domain_publish(domain);
 
 	return domain;
-- 
2.45.0


