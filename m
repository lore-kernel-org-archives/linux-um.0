Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard@nod.at>) id 1RuYpE-0003l0-Mz
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2012 00:22:24 +0000
Received: from a.ns.miles-group.at ([95.130.255.143] helo=radon.swed.at)
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.76) id 1RuYpD-0004DD-Q3
	for user-mode-linux-devel@lists.sourceforge.net;
	Tue, 07 Feb 2012 00:22:24 +0000
From: Richard Weinberger <richard@nod.at>
Date: Tue,  7 Feb 2012 01:22:50 +0100
Message-Id: <1328574170-2286-5-git-send-email-richard@nod.at>
In-Reply-To: <1328574170-2286-1-git-send-email-richard@nod.at>
References: <1328574170-2286-1-git-send-email-richard@nod.at>
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: [uml-devel] [PATCH 5/5] MTD: Relax dependencies
To: linux-kernel@vger.kernel.org
Cc: Artem.Bityutskiy@linux.intel.com, linux-mtd@lists.infradead.org, viro@zeniv.linux.org.uk, user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>

CONFIG_GENERIC_IO is just enough for the basic MTD stuff.

Signed-off-by: Richard Weinberger <richard@nod.at>
---
 drivers/mtd/Kconfig         |    2 +-
 drivers/mtd/devices/Kconfig |    1 +
 drivers/mtd/maps/Kconfig    |    1 +
 drivers/mtd/nand/Kconfig    |    2 ++
 drivers/mtd/onenand/Kconfig |    1 +
 5 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/drivers/mtd/Kconfig b/drivers/mtd/Kconfig
index 1be6218..284cf34 100644
--- a/drivers/mtd/Kconfig
+++ b/drivers/mtd/Kconfig
@@ -1,6 +1,6 @@
 menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
-	depends on HAS_IOMEM
+	depends on GENERIC_IO
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
 	  used for solid state file systems on embedded devices. This option
diff --git a/drivers/mtd/devices/Kconfig b/drivers/mtd/devices/Kconfig
index 37b05c3..8d3dac4 100644
--- a/drivers/mtd/devices/Kconfig
+++ b/drivers/mtd/devices/Kconfig
@@ -1,5 +1,6 @@
 menu "Self-contained MTD device drivers"
 	depends on MTD!=n
+	depends on HAS_IOMEM
 
 config MTD_PMC551
 	tristate "Ramix PMC551 PCI Mezzanine RAM card support"
diff --git a/drivers/mtd/maps/Kconfig b/drivers/mtd/maps/Kconfig
index 6c5c431..8af67cf 100644
--- a/drivers/mtd/maps/Kconfig
+++ b/drivers/mtd/maps/Kconfig
@@ -1,5 +1,6 @@
 menu "Mapping drivers for chip access"
 	depends on MTD!=n
+	depends on HAS_IOMEM
 
 config MTD_COMPLEX_MAPPINGS
 	bool "Support non-linear mappings of flash chips"
diff --git a/drivers/mtd/nand/Kconfig b/drivers/mtd/nand/Kconfig
index 31b034b..80de7b3 100644
--- a/drivers/mtd/nand/Kconfig
+++ b/drivers/mtd/nand/Kconfig
@@ -246,6 +246,7 @@ config MTD_NAND_BCM_UMI_HWCS
 config MTD_NAND_DISKONCHIP
 	tristate "DiskOnChip 2000, Millennium and Millennium Plus (NAND reimplementation) (EXPERIMENTAL)"
 	depends on EXPERIMENTAL
+	depends on HAS_IOMEM
 	select REED_SOLOMON
 	select REED_SOLOMON_DEC16
 	help
@@ -431,6 +432,7 @@ config MTD_NAND_GPMI_NAND
 
 config MTD_NAND_PLATFORM
 	tristate "Support for generic platform NAND driver"
+	depends on HAS_IOMEM
 	help
 	  This implements a generic NAND driver for on-SOC platform
 	  devices. You will need to provide platform-specific functions
diff --git a/drivers/mtd/onenand/Kconfig b/drivers/mtd/onenand/Kconfig
index 772ad29..91467bb 100644
--- a/drivers/mtd/onenand/Kconfig
+++ b/drivers/mtd/onenand/Kconfig
@@ -1,6 +1,7 @@
 menuconfig MTD_ONENAND
 	tristate "OneNAND Device Support"
 	depends on MTD
+	depends on HAS_IOMEM
 	help
 	  This enables support for accessing all type of OneNAND flash
 	  devices. For further information see
-- 
1.7.6


------------------------------------------------------------------------------
Keep Your Developer Skills Current with LearnDevNow!
The most comprehensive online learning library for Microsoft developers
is just $99.99! Visual Studio, SharePoint, SQL - plus HTML5, CSS3, MVC3,
Metro Style Apps, more. Free future releases when you subscribe now!
http://p.sf.net/sfu/learndevnow-d2d
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

