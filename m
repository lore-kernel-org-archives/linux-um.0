Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4ECAEF5545D
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 05:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=d3wtTwTG1KNrTlOiUEKRONaqf46vu4shf9EW634K5b0=; b=yzByvbb3WZWk0xa654eC32N7Rf
	ekvHYjufrbSYsUXS8Qv2NSwHNEVM+n49uDD7UYi7YgKc0UtSsRcDG1W/KYgbFozqBIERhSaioM+Ua
	dSIZ7lZXbLiIbvZJtjDb5ClZDIM4pZ9MzOyz9Ec6rSFrLvGDDRG1zEx229Ynh0AxwFNzqdioxID00
	fojE7kZICw5FjHynNXrcfz8qfcY3+qV206Jv9hKx26yeCn9nU7UYprt2/g4bp4IgPykO7JbRrctLR
	NbrW71uiokYKpi/oRAidjrU6WgwQP+xDmWb1o1ivUMA2mc8EbHvfYtKVwNfNSAFthh05h7iEjzpGI
	XKgGQg8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv7kc-00000003GAP-1sLz;
	Wed, 25 Feb 2026 05:47:58 +0000
Received: from [50.53.43.113] (helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vv7kZ-00000003G9x-1kmX;
	Wed, 25 Feb 2026 05:47:55 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Jeff Chang <jeff_chang@richtek.com>,
	Mark Brown <broonie@kernel.org>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: [PATCH v2] regulator: RT5133: add missing HAS_IOMEM dependency
Date: Tue, 24 Feb 2026 21:47:53 -0800
Message-ID: <20260225054753.227535-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

When building on ARCH=um (which does not set HAS_IOMEM), kconfig
reports an unmet dependency caused by REGULATOR_RT5133. It selects
OF_GPIO, which depends on HAS_IOMEM. To stop this warning,
REGULATOR_RT5133 should also depend on HAS_IOMEM.

kconfig warning:
WARNING: unmet direct dependencies detected for OF_GPIO
  Depends on [n]: GPIOLIB [=y] && OF [=y] && HAS_IOMEM [=n]
  Selected by [y]:
  - REGULATOR_RT5133 [=y] && REGULATOR [=y] && I2C [=y] && GPIOLIB [=y] && OF [=y]

Fixes: 714165e1c4b0 ("regulator: rt5133: Add RT5133 PMIC regulator Support")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
---
v2: verify still needed, rebase, add Cc:s

Cc: Jeff Chang <jeff_chang@richtek.com>
Cc: Mark Brown <broonie@kernel.org>
Cc: Liam Girdwood <lgirdwood@gmail.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-um@lists.infradead.org

 drivers/regulator/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- linux-next-20260224.orig/drivers/regulator/Kconfig
+++ linux-next-20260224/drivers/regulator/Kconfig
@@ -1330,6 +1330,7 @@ config REGULATOR_RT5120
 config REGULATOR_RT5133
 	tristate "Richtek RT5133 PMIC Regulators"
 	depends on I2C && GPIOLIB && OF
+	depends on HAS_IOMEM
 	select REGMAP
 	select CRC8
 	select OF_GPIO

