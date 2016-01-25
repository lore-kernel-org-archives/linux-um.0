Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 11/22] mtd: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:10 +0100
Message-Id: <1453760661-1444-12-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Bill Pringlemeir <bpringlemeir@nbsps.com>, Stefan Agner <stefan@agner.ch>, Kevin Hao <haokexin@gmail.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Alex Smith <alex.smith@imgtec.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Zhou Wang <wangzhou1@hisilicon.com>, Anup Patel <anup.patel@broadcom.com>, Han xu <han.xu@freescale.com>, Joachim Eastwood <manabian@gmail.com>, Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>, Bayi Cheng <bayi.cheng@mediatek.com>, Fabio Estevam <fabio.estevam@freescale.com>, linux-mtd@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/nand/Kconfig    | 2 ++
 drivers/mtd/spi-nor/Kconfig | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 20f01b3..545d82b 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -74,6 +74,7 @@ config MTD_NAND_DENALI_SCRATCH_REG_ADDR
 config MTD_NAND_GPIO
 	tristate "GPIO assisted NAND Flash driver"
 	depends on GPIOLIB || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  This enables a NAND flash driver where control signals are
 	  connected to GPIO pins, and commands and data are communicated
@@ -463,6 +464,7 @@ config MTD_NAND_MPC5121_NFC
 config MTD_NAND_VF610_NFC
 	tristate "Support for Freescale NFC for VF610/MPC5125"
 	depends on (SOC_VF610 || COMPILE_TEST)
+	depends on HAS_IOMEM
 	help
 	  Enables support for NAND Flash Controller on some Freescale
 	  processors like the VF610, MPC5125, MCF54418 or Kinetis K70.
diff --git a/drivers/mtd/spi-nor/Kconfig b/drivers/mtd/spi-nor/Kconfig
index 0dc9275..83befab 100644
--- a/drivers/mtd/spi-nor/Kconfig
+++ b/drivers/mtd/spi-nor/Kconfig
@@ -9,6 +9,7 @@ if MTD_SPI_NOR
 
 config MTD_MT81xx_NOR
 	tristate "Mediatek MT81xx SPI NOR flash controller"
+	depends on HAS_IOMEM
 	help
 	  This enables access to SPI NOR flash, using MT81xx SPI NOR flash
 	  controller. This controller does not support generic SPI BUS, it only
-- 
1.8.4.5


