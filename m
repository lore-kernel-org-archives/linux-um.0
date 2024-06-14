Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99889C27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dX/NvEFRPKEGikk8fwukiwvaTdASJSmA9+QFa3LM6Fo=; b=gu5N+CYQUt+GdYF/8SHxBBQGu3
	54XeAwravTlazYiXvRl3qNeCf8qW1kI9aNyL7zYOEODgrAF+jgQ24jER5qU/R08HMDRrya2Yiwr1u
	WPYKTh3dD9cCfav4ERcQngucrOV88Bnnh32tSzhYYk/MNDDevcWcfXLXVuqLABmWxE3NId3QHwwV4
	N45Rr+FvFqpZZrbE9J0d/hCST8lAK4x0onu41xWQuTjnxKql9TIWF8d59w+MOzqYjaasO64FKyjYP
	WhMaOsc4nQsPRKtjD61q8EKhBiMjorvUA79KVGb3DLESclxjyNXft4wrj5aIzJRm9sAxEUZ5mRPat
	cDClT5vw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnQ-00000003eMV-2F9E;
	Fri, 14 Jun 2024 17:33:04 +0000
Received: from relay9-d.mail.gandi.net ([217.70.183.199])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnH-00000003eBG-192S
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:57 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 042AEFF80B;
	Fri, 14 Jun 2024 17:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386373;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dX/NvEFRPKEGikk8fwukiwvaTdASJSmA9+QFa3LM6Fo=;
	b=cdBiBEETH3brboDNfayAgM3woKf5vj4k+CQ5YUUbP085D876D2hYH2lP6MDnIMck9yqphV
	qNvDKs53bNCkYxZ/qE7ENTcj33R3ZaHdCOBFx48ljIbzv84YnX5c26N+NfhBXupdgYPrpQ
	ZhrhAR0ZAm5TyFduZdBIrvG1jX4I0354HZsoQ3sD/vzpqqWzLyZUUxLecKtVQy5oIphQa1
	2yTpLY+ZiVxBlstiUK721FfVjz2datIWgNf3wXPsDnAHBvVv+bv/wk5X/47L2rq1VAQ6Qu
	Y4wc720rwxdXpS7aM38Dm8sAxyxMIx348GFv22vG8cCa4FS2punTlySJ/AJs/g==
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
Subject: [PATCH 09/23] irqdomain: Use irq_domain_instantiate() for hierarchy domain creation
Date: Fri, 14 Jun 2024 19:32:10 +0200
Message-ID: <20240614173232.1184015-10-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103255_503469_89B11383 
X-CRM114-Status: UNSURE (   8.77  )
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

irq_domain_instantiate() handles all needs to be used in
irq_domain_create_hierarchy()

Avoid code duplication and use directly irq_domain_instantiate() for
hierarchy domain creation.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 kernel/irq/irqdomain.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 7e4a1da63549..edfd386be985 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1213,23 +1213,16 @@ struct irq_domain *irq_domain_create_hierarchy(struct irq_domain *parent,
 		.hwirq_max = size,
 		.ops = ops,
 		.host_data = host_data,
+		.domain_flags = flags,
+		.parent = parent,
 	};
-	struct irq_domain *domain;
+	struct irq_domain *d;
 
 	if (!info.size)
 		info.hwirq_max = ~0U;
 
-	domain = __irq_domain_create(&info);
-	if (domain) {
-		if (parent)
-			domain->root = parent->root;
-		domain->parent = parent;
-		domain->flags |= flags;
-
-		__irq_domain_publish(domain);
-	}
-
-	return domain;
+	d = irq_domain_instantiate(&info);
+	return IS_ERR(d) ? NULL : d;
 }
 EXPORT_SYMBOL_GPL(irq_domain_create_hierarchy);
 
-- 
2.45.0


