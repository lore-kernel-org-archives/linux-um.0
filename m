Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D46EC27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=w3cpBYdF6cMVxUW5Waih2GLzWLev0FdUvUlF6XEkz6w=; b=MBBOE8yUi/ek7s0JXn/Jg2t5HN
	/f9zJSmPBU6cEnaUSNOFTjFF9bLRh/bYqOPm5l3x4Ta83+6be7nT8Y1s4GctVO3jkILGEvkIluiOD
	hlJiK3PoSNbQ7kK11AIZ8XMPz3JPFw2PwNxgnkTtFyu4hSY2Qp90aUPiY0ZSzrQnR7RwEv6bW4TrD
	ND0UBG0wcQnJHciekupCd7n5Z0ceAa+bdFFoCitfIB5kB+hhaV8+FA4mMZbxuvP08vT1AZO7s+aXd
	NfWFSl2oeK5Cc6TOCX3jP6ALzqoGBHiIVPz0z1zN6rLmsm53tNtkNVvmK+tKRjz9bx0jU1D66ttNE
	SUvCR6qw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAne-00000003eZG-3X0x;
	Fri, 14 Jun 2024 17:33:18 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnQ-00000003eKL-0bBZ
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:09 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 91E50FF812;
	Fri, 14 Jun 2024 17:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386382;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w3cpBYdF6cMVxUW5Waih2GLzWLev0FdUvUlF6XEkz6w=;
	b=hOHqyhLOwwkkxkU6/4uv0vGXq4lG0/g6HnaOmVENSryxC7pYTsnYvJxvJl38DoAigBwEpJ
	UnSGTd+bGOyJHsZm7oqnQrIgUvs8hTf0mrBxs2OuvXXwpR+I65zbUCKj50dn6GjFB+bqCc
	qgl6Te/E5Q0wVwnbmAppzcm9etiqmeDEzfH2+YnaW99FoA3OvjlAoGrUmrmf8sF4RaSgn0
	dx9OButAg7KJoQOEdH9WsgqCvEY1Mxq209udmJTu43BenpEOI/8GrX2OidK2AJDpr4Oy/k
	oImLWkZ9rxOa82WSkXTHxNBSSB0oqLxd66T+Q4FgGdVj5OyFqkbpLDccQuR1yg==
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
Subject: [PATCH 19/23] um: virt-pci: Use irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:20 +0200
Message-ID: <20240614173232.1184015-20-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103304_635337_2D0E00AA 
X-CRM114-Status: GOOD (  10.35  )
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

um_pci_init() uses __irq_domain_add(). With the introduction of
irq_domain_instantiate(), __irq_domain_add() becomes obsolete.

In order to fully remove __irq_domain_add(), use directly
irq_domain_instantiate().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 arch/um/drivers/virt-pci.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/um/drivers/virt-pci.c b/arch/um/drivers/virt-pci.c
index 7cb503469bbd..597d89338693 100644
--- a/arch/um/drivers/virt-pci.c
+++ b/arch/um/drivers/virt-pci.c
@@ -986,6 +986,11 @@ static struct resource virt_platform_resource = {
 
 static int __init um_pci_init(void)
 {
+	struct irq_domain_info inner_domain_info = {
+		.size = MAX_MSI_VECTORS,
+		.hwirq_max = MAX_MSI_VECTORS,
+		.ops = &um_pci_inner_domain_ops,
+	};
 	int err, i;
 
 	WARN_ON(logic_iomem_add_region(&virt_cfgspace_resource,
@@ -1015,11 +1020,10 @@ static int __init um_pci_init(void)
 		goto free;
 	}
 
-	um_pci_inner_domain = __irq_domain_add(um_pci_fwnode, MAX_MSI_VECTORS,
-					       MAX_MSI_VECTORS, 0,
-					       &um_pci_inner_domain_ops, NULL);
-	if (!um_pci_inner_domain) {
-		err = -ENOMEM;
+	inner_domain_info.fwnode = um_pci_fwnode;
+	um_pci_inner_domain = irq_domain_instantiate(&inner_domain_info);
+	if (IS_ERR(um_pci_inner_domain)) {
+		err = PTR_ERR(um_pci_inner_domain);
 		goto free;
 	}
 
@@ -1056,7 +1060,7 @@ static int __init um_pci_init(void)
 		goto free;
 	return 0;
 free:
-	if (um_pci_inner_domain)
+	if (!IS_ERR_OR_NULL(um_pci_inner_domain))
 		irq_domain_remove(um_pci_inner_domain);
 	if (um_pci_fwnode)
 		irq_domain_free_fwnode(um_pci_fwnode);
-- 
2.45.0


