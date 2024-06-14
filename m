Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60A77C27C79
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6CVX37YYxogQc3necMFvOYHcfj0KlRLwJOiGoHdPMpg=; b=q8zXlzrK9+iQG1ZnB4usJG9Ra1
	vdSjMOy9WyS6T1XDoVE2YGw97aVFpqho8x4lr0vz0izFgfn+OSqN/7n1VSWUBs/uYHYzv/rOl/m6I
	BwSB0bDkEzrmBByv474W7WUI4jqkynlyn5KKkt+5eiZiBODDHsLXiUru/hvgv31zizNQR3g14eMIU
	m1zSpsEQM2hUvMEVnFxYoUufnH97sgDCTrxWKpTjjC5nbJyNdNkLZCxvCQEJni31YPSUhsoQPGcy9
	LD9sGVibyGiiCCT/IRFsiKxerRpia8hkGLWjD7g86Y15uCTEMPAFFj782MWPV73x+FoTe7TLdPHqP
	eeJdsqWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnR-00000003eNk-3x4g;
	Fri, 14 Jun 2024 17:33:06 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnI-00000003eBv-0QsQ
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:58 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id D4E0DFF80D;
	Fri, 14 Jun 2024 17:32:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386374;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6CVX37YYxogQc3necMFvOYHcfj0KlRLwJOiGoHdPMpg=;
	b=bOAGkTHf3Tt4ls6Rby+74mlUNWvvt7xuujriO8VAYqeS01DWwJH0z3FgQ768dyYI5qxHZb
	8UdUmTgJXVMAyPT5BgpS4RHVp74FS2dH4X1tbsIR8biMD5IzhtOYhd57YiMEH8X1VibSEl
	xijuFc1C6ngU/B6VZB1TtARWw62kO+4C97kaHLPiP4smjQNUCOj9jSE7Q/S9hPz2/Ndewd
	Hk7SHuz84/Iaqvo8j0yY24EFji/ZveAoOWlTYW8aUq33KcWNoQ+w8t04mqdfRHRS/vKnt3
	Y5OklgaaJ0wDlRNUH/4xrzsWwPLklEd5AoqGRdvZTq924IyaFOavphjhWeityg==
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
Subject: [PATCH 10/23] irqdomain: Make __irq_domain_create() return an error code
Date: Fri, 14 Jun 2024 19:32:11 +0200
Message-ID: <20240614173232.1184015-11-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103256_540915_BCD4B1AF 
X-CRM114-Status: GOOD (  11.56  )
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

__irq_domain_create() can fail for several reasons. When it fails it
returns a NULL pointer and so filters out the exact failure reason.
The only user of __irq_domain_create() is irq_domain_instantiate() which
can return a PTR_ERR value. On __irq_domain_create() failure, it uses an
arbitrary error code.

Rather than using this arbitrary error value, make __irq_domain_create()
return is own error code and use that one.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index edfd386be985..5090b1c572c6 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -187,17 +187,17 @@ static struct irq_domain *__irq_domain_create(const struct irq_domain_info *info
 	if (WARN_ON((info->size && info->direct_max) ||
 		    (!IS_ENABLED(CONFIG_IRQ_DOMAIN_NOMAP) && info->direct_max) ||
 		    (info->direct_max && info->direct_max != info->hwirq_max)))
-		return NULL;
+		return ERR_PTR(-EINVAL);
 
 	domain = kzalloc_node(struct_size(domain, revmap, info->size),
 			      GFP_KERNEL, of_node_to_nid(to_of_node(info->fwnode)));
 	if (!domain)
-		return NULL;
+		return ERR_PTR(-ENOMEM);
 
 	err = irq_domain_set_name(domain, info->fwnode);
 	if (err) {
 		kfree(domain);
-		return NULL;
+		return ERR_PTR(err);
 	}
 
 	domain->fwnode = fwnode_handle_get(info->fwnode);
@@ -260,8 +260,8 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	struct irq_domain *domain;
 
 	domain = __irq_domain_create(info);
-	if (!domain)
-		return ERR_PTR(-ENOMEM);
+	if (IS_ERR(domain))
+		return ERR_CAST(domain);
 
 	domain->flags |= info->domain_flags;
 
-- 
2.45.0


