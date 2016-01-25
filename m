Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 14/22] pwm: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:13 +0100
Message-Id: <1453760661-1444-15-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/pwm/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
index 8cf0dae..e83aa94 100644
--- a/drivers/pwm/Kconfig
+++ b/drivers/pwm/Kconfig
@@ -150,6 +150,7 @@ config PWM_FSL_FTM
 	tristate "Freescale FlexTimer Module (FTM) PWM support"
 	depends on HAS_IOMEM
 	depends on OF
+	depends on HAS_IOMEM
 	select REGMAP_MMIO
 	help
 	  Generic FTM PWM framework driver for Freescale VF610 and
-- 
1.8.4.5


