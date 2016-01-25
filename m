Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Richard Weinberger <richard@nod.at>
Subject: [PATCH 20/22] clocksource: Fix dependencies for !HAS_IOMEM archs
Date: Mon, 25 Jan 2016 23:24:19 +0100
Message-Id: <1453760661-1444-21-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-1-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>, Daniel Lezcano <daniel.lezcano@linaro.org>, Thomas Gleixner <tglx@linutronix.de>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Not every arch has io memory.
So, unbreak the build by fixing the dependencies.

[rw: Found these linker issues after
resolving a pile of other build issues.]
Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/clocksource/Kconfig | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/clocksource/Kconfig b/drivers/clocksource/Kconfig
index 56777f0..224841e 100644
--- a/drivers/clocksource/Kconfig
+++ b/drivers/clocksource/Kconfig
@@ -30,6 +30,7 @@ config CLKSRC_MMIO
 config DIGICOLOR_TIMER
 	bool "Digicolor timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	help
 	  Enables the support for the digicolor timer driver.
 
@@ -76,6 +77,7 @@ config ORION_TIMER
 config SUN4I_TIMER
 	bool "Sun4i timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	select CLKSRC_MMIO
 	help
 	  Enables support for the Sun4i timer.
@@ -96,6 +98,7 @@ config TEGRA_TIMER
 config VT8500_TIMER
 	bool "VT8500 timer driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	help
 	  Enables support for the VT8500 driver.
 
@@ -131,6 +134,7 @@ config CLKSRC_NOMADIK_MTU_SCHED_CLOCK
 config CLKSRC_DBX500_PRCMU
 	bool "Clocksource PRCMU Timer" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	help
 	  Use the always on PRCMU Timer as clocksource
 
@@ -248,6 +252,7 @@ config CLKSRC_EXYNOS_MCT
 config CLKSRC_SAMSUNG_PWM
 	bool "PWM timer drvier for Samsung S3C, S5P" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	help
 	  This is a new clocksource driver for the PWM timer found in
 	  Samsung S3C, S5P and Exynos SoCs, replacing an earlier driver
@@ -257,6 +262,7 @@ config CLKSRC_SAMSUNG_PWM
 config FSL_FTM_TIMER
 	bool "Freescale FlexTimer Module driver" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	select CLKSRC_MMIO
 	help
 	  Support for Freescale FlexTimer Module (FTM) timer.
@@ -360,6 +366,7 @@ config CLKSRC_TANGO_XTAL
 config CLKSRC_PXA
 	bool "Clocksource for PXA or SA-11x0 platform" if COMPILE_TEST
 	depends on GENERIC_CLOCKEVENTS
+	depends on HAS_IOMEM
 	select CLKSRC_MMIO
 	help
 	  This enables OST0 support available on PXA and SA-11x0
-- 
1.8.4.5


