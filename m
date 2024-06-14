Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5E50C41513
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:32:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rTbRL0qnBuvXH1zQoBWsJHhVuNTZbzn7iLMor6spAIk=; b=D/R11jx1eIT9oHX1Nx4GSyVeEy
	smzzsowlVlQ6UMxO79pW8/TrA5jX1dDQnLIxzqsBD/xduquBwP5ouweLOn9vfS2WM0vUuMSxrrM1X
	SLRUYGVbGduR3IAqdq3wKnVa9Fybc+5BktkVQ3JGHBiIHWkY532H/HZAMv7DqUE6mdrEzSuTzwweV
	cZqyF6ZdRMmGHjwemtSq89cEMxyUAe/8yRFSBAKW6rXg4q7pIKx3+redsdJvwr4B24ol1pdzQ0PqA
	JnQIwNPd2Qi0mhtpqcdtzV4JliLdiAVeR5/koW2Tj2t2MVAefYqtWjqbwqe2asax6R5fh1l56uq3T
	1s10/Lgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnH-00000003eBu-00gh;
	Fri, 14 Jun 2024 17:32:55 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnB-00000003e7m-3nNl
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:53 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 886E6FF806;
	Fri, 14 Jun 2024 17:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386368;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rTbRL0qnBuvXH1zQoBWsJHhVuNTZbzn7iLMor6spAIk=;
	b=cuMXidjZFlDUPwkClU+4BnO1XQw1HNsIqDezaiP9DFkLkv6PlxkkbHLjWwJAJ+dPibHWm+
	PSZVswV4By/kBZMMIblWiD8sQUS0tlUqVlnMfvxiH31Zb75juVJ3al0TzDQwF3U5TSm4TP
	4WNPgJENI1GZ2TxpYKKZn6gEe+28VN2V59I9SSgd8YrUKwVTELQ270vkecSZh0wYgaJKRz
	6jpX/Or5Gn2pqDMQDWl52LmSPO5y7om2QF4H2yLCiyZiDGjm4xRGRndDeQdNJsQoyT3FeS
	uCU1DXZ7+0qp2MXJuuC2krGaKb1ieBQT9/Q0WdaOl5KY8pLd1PYIXOvlYKyMJQ==
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
	Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
	stable@vger.kernel.org
Subject: [PATCH 03/23] irqdomain: Fixed unbalanced fwnode get and put
Date: Fri, 14 Jun 2024 19:32:04 +0200
Message-ID: <20240614173232.1184015-4-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103250_101479_C964D902 
X-CRM114-Status: UNSURE (   9.88  )
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

fwnode_handle_get(fwnode) is called when a domain is created with fwnode
passed as a function parameter. fwnode_handle_put(domain->fwnode) is
called when the domain is destroyed but during the creation a path
exists that does not set domain->fwnode.

If this path is taken, the fwnode get will never be put.

To avoid the unbalanced get and put, set domain->fwnode unconditionally.

Fixes: d59f6617eef0 ("genirq: Allow fwnode to carry name information only")
Cc: stable@vger.kernel.org
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 012ada09b419..31277488ed42 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -156,7 +156,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		switch (fwid->type) {
 		case IRQCHIP_FWNODE_NAMED:
 		case IRQCHIP_FWNODE_NAMED_ID:
-			domain->fwnode = fwnode;
 			domain->name = kstrdup(fwid->name, GFP_KERNEL);
 			if (!domain->name) {
 				kfree(domain);
@@ -165,7 +164,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 			domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 			break;
 		default:
-			domain->fwnode = fwnode;
 			domain->name = fwid->name;
 			break;
 		}
@@ -185,7 +183,6 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		}
 
 		domain->name = strreplace(name, '/', ':');
-		domain->fwnode = fwnode;
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
@@ -201,8 +198,8 @@ static struct irq_domain *__irq_domain_create(struct fwnode_handle *fwnode,
 		domain->flags |= IRQ_DOMAIN_NAME_ALLOCATED;
 	}
 
-	fwnode_handle_get(fwnode);
-	fwnode_dev_initialized(fwnode, true);
+	domain->fwnode = fwnode_handle_get(fwnode);
+	fwnode_dev_initialized(domain->fwnode, true);
 
 	/* Fill structure */
 	INIT_RADIX_TREE(&domain->revmap_tree, GFP_KERNEL);
-- 
2.45.0


