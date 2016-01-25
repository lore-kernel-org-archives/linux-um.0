Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 02/22] phy: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:01 +0100
Message-Id: <1453760661-1444-3-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Kishon Vijay Abraham I <kishon@ti.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/phy/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index e7e117d..ddfbaf9 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -33,6 +33,7 @@ config ARMADA375_USBCLUSTER_PHY
 	def_bool y
 	depends on MACH_ARMADA_375 || COMPILE_TEST
 	depends on OF
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 
 config PHY_DM816X_USB
@@ -128,6 +129,7 @@ config PHY_RCAR_GEN3_USB2
 config OMAP_CONTROL_PHY
 	tristate "OMAP CONTROL PHY Driver"
 	depends on ARCH_OMAP2PLUS || COMPILE_TEST
+	depends on HAS_IOMEM
 	help
 	  Enable this to add support for the PHY part present in the control
 	  module. This driver has API to power on the USB2 PHY and to write to
@@ -224,6 +226,7 @@ config PHY_MT65XX_USB3
 
 config PHY_HI6220_USB
 	tristate "hi6220 USB PHY support"
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	select MFD_SYSCON
 	help
@@ -400,6 +403,7 @@ config PHY_BRCMSTB_SATA
 config PHY_CYGNUS_PCIE
 	tristate "Broadcom Cygnus PCIe PHY driver"
 	depends on OF && (ARCH_BCM_CYGNUS || COMPILE_TEST)
+	depends on HAS_IOMEM
 	select GENERIC_PHY
 	default ARCH_BCM_CYGNUS
 	help
-- 
1.8.4.5


