Return-Path: <richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 21/22] mtd: cs553x: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:20 +0100
Message-Id: <1453760661-1444-22-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Geert Uytterhoeven <geert+renesas@glider.be>, Bill Pringlemeir <bpringlemeir@nbsps.com>, Stefan Agner <stefan@agner.ch>, Alex Smith <alex.smith@imgtec.com>, Zhou Wang <wangzhou1@hisilicon.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Masahiro Yamada <yamada.masahiro@socionext.com>, Anup Patel <anup.patel@broadcom.com>, linux-mtd@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Not every arch has io memory nor can this driver ever work
on UML/i386.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/nand/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 545d82b..b253654 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -311,6 +311,7 @@ config MTD_NAND_CAFE
 config MTD_NAND_CS553X
 	tristate "NAND support for CS5535/CS5536 (AMD Geode companion chip)"
 	depends on X86_32
+	depends on !UML && HAS_IOMEM
 	help
 	  The CS553x companion chips for the AMD Geode processor
 	  include NAND flash controllers with built-in hardware ECC
-- 
1.8.4.5


