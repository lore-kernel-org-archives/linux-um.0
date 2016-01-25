Return-Path: <linux-pm-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 01/22] power: reset: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:00 +0100
Message-Id: <1453760661-1444-2-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Sender: linux-pm-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Moritz Fischer <moritz.fischer@ettus.com>, Florian Fainelli <f.fainelli@gmail.com>, Jun Nie <jun.nie@linaro.org>, linux-pm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/power/reset/Kconfig | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
index 1131cf7..0a6408a 100644
--- a/drivers/power/reset/Kconfig
+++ b/drivers/power/reset/Kconfig
@@ -148,6 +148,7 @@ config POWER_RESET_KEYSTONE
 config POWER_RESET_SYSCON
 	bool "Generic SYSCON regmap reset driver"
 	depends on OF
+	depends on HAS_IOMEM
 	select MFD_SYSCON
 	help
 	  Reboot support for generic SYSCON mapped register reset.
@@ -155,6 +156,7 @@ config POWER_RESET_SYSCON
 config POWER_RESET_SYSCON_POWEROFF
 	bool "Generic SYSCON regmap poweroff driver"
 	depends on OF
+	depends on HAS_IOMEM
 	select MFD_SYSCON
 	help
 	  Poweroff support for generic SYSCON mapped register poweroff.
-- 
1.8.4.5

