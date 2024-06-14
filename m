Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 383E6C27C79
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AMFrvT6Mdf1M8/KeTvOvOwVZ5loFJ3PtGAldEjb671s=; b=lS7anT4czLfSyIkAnZ2g79C9bA
	Ct4rV8c7Dj1p2GMep7TuhaNJwSrTFUFHtosZCd4baSVCLTmDRWrQR//EOVUciY3a0t9suN84I6cBL
	l5K+idN8VoYDFSk7i/W/qN+yEB1UDjTS40nrS1fqhro3V/KD2j7tKL1ydlV+k66g4Y9l/wVvhXopR
	rhN81m+4kcdO6DIyjCgNaljsiCkANycS+z8NN+ifGp+RAWkspgDwmTlYC8oCggLOgAd758hzE/Y/y
	ZmieBoNfRF7J+8TJIz6LrPDFHh6SfI9IgLuJT8SNSYyPUUv1McEON8hbbhQUN8UNEYkw5d4bqEkJ0
	xpsn9dyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnO-00000003eJd-1c6u;
	Fri, 14 Jun 2024 17:33:02 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnF-00000003e9n-2pWC
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:55 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 52054FF809;
	Fri, 14 Jun 2024 17:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386372;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AMFrvT6Mdf1M8/KeTvOvOwVZ5loFJ3PtGAldEjb671s=;
	b=NqjJr4g4eXcxFlWRTnbsdfo6sVMTxYST9ZqL8ikpV8nap+AARRvMtiktNHwc6cYTUz4jm8
	MAKRY8pGwBQRrwd/tzOjV+ONRuSgmsUG4qkyaV0ESriPcUY/Dgb9EEELubShaaz7HygpaV
	UfyCkCtb1nNQRmqhByP59AgbhKaxaTajgrbBl5NjpLWDEWcWVS2DL1aQ6cuJPylUKcTKGx
	VL2AbzVH6bDjS5hxy8tcO2WWkkOvwZjtiOJeZuBdQN/i2AWEXXlvDY/FEAgtwsPc3osb3G
	+8H1qSV5ARKkUYxiO7wpJYMPxziQUeW2D7ij7nqhPzMvWdo/MzZPcMg7hqZ08g==
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
Subject: [PATCH 07/23] irqdomain: Handle additional domain flags in irq_domain_instantiate()
Date: Fri, 14 Jun 2024 19:32:08 +0200
Message-ID: <20240614173232.1184015-8-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103254_011145_64DE0EA0 
X-CRM114-Status: GOOD (  10.32  )
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

In order to use irq_domain_instantiate() from several places such as
irq_domain_create_hierarchy(), irq_domain_instantiate() needs to handle
additional domain flags.

Handle these additional flags.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 2 ++
 kernel/irq/irqdomain.c    | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index a3b43e357009..4683b66eded9 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -260,6 +260,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
 /**
  * struct irq_domain_info - Domain information structure
  * @fwnode:		firmware node for the interrupt controller
+ * @domain_flags:	Additional flags to add to the domain flags
  * @size:		Size of linear map; 0 for radix mapping only
  * @hwirq_max:		Maximum number of interrupts supported by controller
  * @direct_max:		Maximum value of direct maps;
@@ -269,6 +270,7 @@ void irq_domain_free_fwnode(struct fwnode_handle *fwnode);
  */
 struct irq_domain_info {
 	struct fwnode_handle			*fwnode;
+	unsigned int				domain_flags;
 	unsigned int				size;
 	irq_hw_number_t				hwirq_max;
 	int					direct_max;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 28a463e25d99..34acc2ccfee7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -263,6 +263,8 @@ struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info)
 	if (!domain)
 		return ERR_PTR(-ENOMEM);
 
+	domain->flags |= info->domain_flags;
+
 	__irq_domain_publish(domain);
 
 	return domain;
-- 
2.45.0


