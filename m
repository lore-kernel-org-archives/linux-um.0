Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3638EC27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 17:33:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JtCflf5DaqbhOm9L/XxD0yo5M1odlrsrVmdrUVelr04=; b=nXEJ9KpMCU19U8e48YJiJz4U+Z
	98nYESylO+Mm8ePeGlQVo/UxFbTI3teNKX6hL6JN77SyRic9fUokgaGtqnxKtWSj/DPdEEOFpGMjV
	wyEPon+KWd8+Oxk2pkTse1gRxZsSPhItsuJuVpIxKXLNp6OhlVHzhKDIju7qSwwirD02Yw762EKCp
	1ILnmssq1Bbp6to+aXgS6WHJ7/iAwjQydIKzQI2qQzO1C4YASNFT0zfy6TE4yOYDbUgjeqwtJ44ZN
	5wL+eJyuvvtE56Pi7itfApNt8VAR6OAMaulU2Nw02DQZaJ5ke29bb23xWihGqEApiYgliIjoy0cD4
	aXx06/pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnh-00000003ebX-2moW;
	Fri, 14 Jun 2024 17:33:21 +0000
Received: from relay9-d.mail.gandi.net ([2001:4b98:dc4:8::229])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIAnT-00000003eOU-3zOU
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 17:33:10 +0000
Received: by mail.gandi.net (Postfix) with ESMTPA id 2C54AFF811;
	Fri, 14 Jun 2024 17:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1718386385;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JtCflf5DaqbhOm9L/XxD0yo5M1odlrsrVmdrUVelr04=;
	b=T+mQ/YfDW76Ir33ovd2mMbE/wy/n+Lioh//KKzIjrcUfQ+YWbPCBJJrN3TSzvNE/ZKAQ6q
	oDJ6ais8BaG6r0qxRkjs82DqIeSyqEMu6zJUTxWDI+sxIEs3pAaKFTrlyjfosvaUTGuKVI
	LPO3z2+qbyxyUM4/Ps7CNml66YUyGBTVpJtD8B4EGT1k4WtyeaMq/5k2+7fHhIS5B9KKu9
	k1DQTwKQy7+xfEW8vyjfkYne6wvaLt7I4NTdSAICcX9Lu9dNlCusETzRm5OQ9InqfjQo0j
	BhV9u2/tRY43ouYgUyQHVWsx5GgM/gFFTzLSKOylqw+JJ3b8GrtJCPZCYNh0eQ==
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
Subject: [PATCH 23/23] MAINTAINERS: Add the Microchip LAN966x OIC driver entry
Date: Fri, 14 Jun 2024 19:32:24 +0200
Message-ID: <20240614173232.1184015-24-herve.codina@bootlin.com>
X-Mailer: git-send-email 2.45.0
In-Reply-To: <20240614173232.1184015-1-herve.codina@bootlin.com>
References: <20240614173232.1184015-1-herve.codina@bootlin.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-GND-Sasl: herve.codina@bootlin.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_103308_238666_601CC89D 
X-CRM114-Status: UNSURE (   7.69  )
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

After contributing the driver, add myself as the maintainer for the
Microchip LAN966x OIC driver.

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
---
 MAINTAINERS | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index d6c90161c7bf..baeb307344cd 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14727,6 +14727,12 @@ L:	netdev@vger.kernel.org
 S:	Maintained
 F:	drivers/net/ethernet/microchip/lan966x/*
 
+MICROCHIP LAN966X OIC DRIVER
+M:	Herve Codina <herve.codina@bootlin.com>
+S:	Maintained
+F:	Documentation/devicetree/bindings/interrupt-controller/microchip,lan966x-oic.yaml
+F:	drivers/irqchip/irq-lan966x-oic.c
+
 MICROCHIP LCDFB DRIVER
 M:	Nicolas Ferre <nicolas.ferre@microchip.com>
 L:	linux-fbdev@vger.kernel.org
-- 
2.45.0


