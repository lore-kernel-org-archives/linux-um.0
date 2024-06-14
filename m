Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85AF0C2BA1A
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3ETpH9U3zJAUx8gMI+S0kUDXLMTaIq1vXRUaXwjXffw=; b=0DMRGfU7J9I7TaJcSF2ziMCd+G
	Zf8j4fDd38xAhWY/KChGFSCa8szGEhDTSdcO2iq54944y5oXxD1Cy9yNsICHASfUSc5dgY00jeTy9
	/GNFNtK/oNQRtJM1s3vJkuVXZ57m9iGSZTkjdbgivf0r80FfbdMSTi+o2ZIrLJDO0rrGcsYKfHbFP
	VFeigGd79NFAI0pDsyx9gKL0/oDWZSR6joLtFDfHHPpMwsA+YcvCFbo40rD3uSrSK7eKzP7mzxr+0
	rLHnw+dSxBwPCawfZpDwnqMqJE5hJJO5jfqcOXx8pOEKd45zdLVd7RXh/+y/U99dA7EgBVyPKzqJf
	rWPHyTnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnI-00000003eEn-3neE;
	Fri, 14 Jun 2024 17:32:56 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnD-00000003e7w-1Fky
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:32:53 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 8A994FF807;
	Fri, 14 Jun 2024 17:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386369;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3ETpH9U3zJAUx8gMI+S0kUDXLMTaIq1vXRUaXwjXffw=;
	b=j9mZJCjipsjNo9x7akuPGHHDXKc0Wm1HJ4TWq+w5/oxvjSXJeUY+HI4VGcrdMaAoDxP+sf
	vjpuSZ2vzgCxSbmmbnmNnyBDB+XHxQWKG8KuiZbd0HAJ3Yh93hcoENeyGrpSzUa9yJtufb
	crnSJHlhie1of9gkpFRwnOnGLsOiVUXyMJPhQSzGrDrS2y3g0tJRrShODauoGhpzLlAt2q
	ETxw6v4nimxi2MFQx/Y1I+tShZ7zG+bTZy703umJLkihTezVbrD1jtcp+1yQzLIUEoQL6F
	qHXckEQOvxIF/VFUHFzQbnqrL6oEjC+FCQnjr4UeaZyfu+Y6Scc+P8vc68kiZw==
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
Subject: [PATCH 04/23] irqdomain: Constify parameter in is_fwnode_irqchip()
Date: Fri, 14 Jun 2024 19:32:05 +0200
Message-ID: <20240614173232.1184015-5-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103251_514817_B1A6BE03 
X-CRM114-Status: UNSURE (   9.23  )
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

The fwnode parameter has no reason to be pointer to an un-const struct
fwnode_handle. Indeed, struct fwnode_handle is not modified by the
function.

Be consistent with other function performing the same kind
of operation such as is_of_node(), is_acpi_device_node() or
is_software_node(): constify the fwnode parameter.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 include/linux/irqdomain.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index ab8939c8724d..a3b43e357009 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -314,7 +314,7 @@ static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 
 extern const struct fwnode_operations irqchip_fwnode_ops;
 
-static inline bool is_fwnode_irqchip(struct fwnode_handle *fwnode)
+static inline bool is_fwnode_irqchip(const struct fwnode_handle *fwnode)
 {
 	return fwnode && fwnode->ops == &irqchip_fwnode_ops;
 }
-- 
2.45.0


