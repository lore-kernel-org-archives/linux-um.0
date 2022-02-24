Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-yw1-x1149.google.com ([2607:f8b0:4864:20::1149])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN5Hk-00GjbO-9Y
 for linux-um@lists.infradead.org; Thu, 24 Feb 2022 03:59:21 +0000
Received: by mail-yw1-x1149.google.com with SMTP id
 00721157ae682-2d6914a097cso10388907b3.10
 for <linux-um@lists.infradead.org>; Wed, 23 Feb 2022 19:59:17 -0800 (PST)
Date: Thu, 24 Feb 2022 11:59:02 +0800
Message-Id: <20220224035902.1594253-1-davidgow@google.com>
Mime-Version: 1.0
Subject: [PATCH] clk: lan966x: Depend on CONFIG_IOMEM
From: David Gow <davidgow@google.com>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Cc: David Gow <davidgow@google.com>, linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org

The lan966x clk driver depends on IOMEM functions, in particular
devm_platform_ioremap_resource(), but doesn't state a formal dependency
on it in Kconfig.

Add such a dependency, which prevents this driver from being enabled
on UML configurations without IOMEM.

This fixes the following build failure:

/usr/bin/ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
clk-lan966x.c:(.text+0x294): undefined reference to `devm_platform_ioremap_resource'
/usr/bin/ld: clk-lan966x.c:(.text+0x3aa): undefined reference to `devm_ioremap_resource'
collect2: error: ld returned 1 exit status

Signed-off-by: David Gow <davidgow@google.com>
---
 drivers/clk/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
index 3cdf33470a75..7b5db8a9eb4f 100644
--- a/drivers/clk/Kconfig
+++ b/drivers/clk/Kconfig
@@ -231,6 +231,7 @@ config COMMON_CLK_GEMINI
 
 config COMMON_CLK_LAN966X
 	bool "Generic Clock Controller driver for LAN966X SoC"
+	depends on IOMEM
 	help
 	  This driver provides support for Generic Clock Controller(GCK) on
 	  LAN966X SoC. GCK generates and supplies clock to various peripherals
-- 
2.35.1.473.g83b2b277ed-goog


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

