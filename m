Return-Path: <linux-kernel-owner@vger.kernel.org>
Date: Wed, 11 Dec 2019 11:27:37 -0800
In-Reply-To: <20191211192742.95699-1-brendanhiggins@google.com>
Message-Id: <20191211192742.95699-3-brendanhiggins@google.com>
Mime-Version: 1.0
References: <20191211192742.95699-1-brendanhiggins@google.com>
Subject: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM dependency
From: Brendan Higgins <brendanhiggins@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
To: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, Miquel Raynal <miquel.raynal@bootlin.com>, Vignesh Raghavendra <vigneshr@ti.com>, Boris Brezillon <bbrezillon@kernel.org>, Piotr Sroka <piotrs@cadence.com>
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, Brendan Higgins <brendanhiggins@google.com>, linux-mtd@lists.infradead.org
List-ID: <linux-um.lists.infradead.org>

Currently CONFIG_MTD_NAND_CADENCE implicitly depends on
CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
the following build error:

ld: drivers/mtd/nand/raw/cadence-nand-controller.o: in function `cadence_nand_dt_probe.cold.31':
drivers/mtd/nand/raw/cadence-nand-controller.c:2969: undefined reference to `devm_platform_ioremap_resource'
ld: drivers/mtd/nand/raw/cadence-nand-controller.c:2977: undefined reference to `devm_ioremap_resource'

Fix the build error by adding the unspecified dependency.

Reported-by: Brendan Higgins <brendanhiggins@google.com>
Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
---
 drivers/mtd/nand/raw/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mtd/nand/raw/Kconfig b/drivers/mtd/nand/raw/Kconfig
index 74fb91adeb469..a80a46bb5b8bc 100644
--- a/drivers/mtd/nand/raw/Kconfig
+++ b/drivers/mtd/nand/raw/Kconfig
@@ -452,7 +452,7 @@ config MTD_NAND_PLATFORM
 
 config MTD_NAND_CADENCE
 	tristate "Support Cadence NAND (HPNFC) controller"
-	depends on OF || COMPILE_TEST
+	depends on (OF || COMPILE_TEST) && HAS_IOMEM
 	help
 	  Enable the driver for NAND flash on platforms using a Cadence NAND
 	  controller.
-- 
2.24.0.525.g8f36a354ae-goog


