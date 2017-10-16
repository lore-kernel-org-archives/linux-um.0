Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Rob Herring <robh@kernel.org>
Subject: [PATCH] kconfig: kill off GENERIC_IO option
Date: Mon, 16 Oct 2017 17:16:31 -0500
Message-Id: <20171016221631.23472-1-robh@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, David Woodhouse <dwmw2@infradead.org>, Brian Norris <computersforpeace@gmail.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Marek Vasut <marek.vasut@gmail.com>, Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, user-mode-linux-devel@lists.sourceforge.net, user-mode-linux-user@lists.sourceforge.net, linux-mtd@lists.infradead.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

The GENERIC_IO option is set for every architecture except tile and score
as those define NO_IOMEM. The option only controls visibility of
CONFIG_MTD which doesn't appear to be necessary for any reason, so let's
just remove GENERIC_IO.

Signed-off-by: Rob Herring <robh@kernel.org>
Cc: Jeff Dike <jdike@addtoit.com>
Cc: Richard Weinberger <richard@nod.at>
Cc: David Woodhouse <dwmw2@infradead.org>
Cc: Brian Norris <computersforpeace@gmail.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Marek Vasut <marek.vasut@gmail.com>
Cc: Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>
Cc: user-mode-linux-devel@lists.sourceforge.net
Cc: user-mode-linux-user@lists.sourceforge.net
Cc: linux-mtd@lists.infradead.org
---
 arch/um/Kconfig.common | 1 -
 drivers/mtd/Kconfig    | 1 -
 lib/Kconfig            | 4 ----
 3 files changed, 6 deletions(-)

diff --git a/arch/um/Kconfig.common b/arch/um/Kconfig.common
index 85f6dd204ab6..5514ec52108f 100644
--- a/arch/um/Kconfig.common
+++ b/arch/um/Kconfig.common
@@ -9,7 +9,6 @@ config UML
 	select HAVE_DEBUG_KMEMLEAK
 	select GENERIC_IRQ_SHOW
 	select GENERIC_CPU_DEVICES
-	select GENERIC_IO
 	select GENERIC_CLOCKEVENTS
 	select HAVE_GCC_PLUGINS
 	select TTY # Needed for line.c
diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 5a2d71729b9a..2a8ac6829d42 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -1,6 +1,5 @@
 menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
-	depends on GENERIC_IO
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
 	  used for solid state file systems on embedded devices. This option
diff --git a/lib/Kconfig b/lib/Kconfig
index b1445b22a6de..994fa37a1d96 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -46,10 +46,6 @@ config GENERIC_IOMAP
 	bool
 	select GENERIC_PCI_IOMAP
 
-config GENERIC_IO
-	bool
-	default n
-
 config STMP_DEVICE
 	bool
 
-- 
2.11.0


