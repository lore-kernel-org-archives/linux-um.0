Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx2-b.sourceforge.net ([10.3.1.92]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1J7xGv-0004V2-CC for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 10:15:57 -0800
Received: from smtp.falooley.org ([66.160.141.103])
	by mail.sourceforge.net with esmtps (TLSv1:AES256-SHA:256)
	(Exim 4.44) id 1J7xGt-0007xQ-Md
	for user-mode-linux-devel@lists.sourceforge.net;
	Thu, 27 Dec 2007 10:15:57 -0800
Date: Thu, 27 Dec 2007 13:15:25 -0500
From: Jason Lunz <lunz@falooley.org>
Message-ID: <20071227181524.GA19051@falooley.org>
References: <22c797d00709272118i33d32b9dy93d5f5ec8f8edd30@mail.gmail.com>
	<20071024011712.GA3762@falooley.org>
	<1193208689.26096.48.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <1193208689.26096.48.camel@pmac.infradead.org>
Subject: [uml-devel] [PATCH] allow use of mtd and jffs2 on uml
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: David Woodhouse <dwmw2@infradead.org>
Cc: atom ota <atomota@sleepyhammer.com>, user-mode-linux-devel@lists.sourceforge.net, Jeff Dike <jdike@addtoit.com>, lkml <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, Rob Landley <rob@landley.net>


Allow parts of drivers/mtd to compile on uml by pushing the HAS_IOMEM
dependencies down closer to the parts of mtd that actually need it. This
allows enough of mtd to build to let jffs2 be used on uml.

Signed-off-by: Jason Lunz <lunz@falooley.org>

---

 arch/um/Kconfig             |    4 +---
 drivers/mtd/Kconfig         |   12 +++++++-----
 drivers/mtd/chips/Kconfig   |   11 ++++++++---
 drivers/mtd/devices/Kconfig |    7 +++++++
 4 files changed, 23 insertions(+), 11 deletions(-)

Index: linux-2.6.23.1-uml/arch/um/Kconfig
===================================================================
--- linux-2.6.23.1-uml.orig/arch/um/Kconfig
+++ linux-2.6.23.1-uml/arch/um/Kconfig
@@ -326,9 +326,7 @@
 
 source "drivers/md/Kconfig"
 
-if BROKEN
-	source "drivers/mtd/Kconfig"
-endif
+source "drivers/mtd/Kconfig"
 
 #This is just to shut up some Kconfig warnings, so no prompt.
 config INPUT
Index: linux-2.6.23.1-uml/drivers/mtd/devices/Kconfig
===================================================================
--- linux-2.6.23.1-uml.orig/drivers/mtd/devices/Kconfig
+++ linux-2.6.23.1-uml/drivers/mtd/devices/Kconfig
@@ -78,6 +78,7 @@
 
 config MTD_SLRAM
 	tristate "Uncached system RAM"
+ 	depends on HAS_IOMEM
 	help
 	  If your CPU cannot cache all of the physical memory in your machine,
 	  you can still use it for storage or swap by using this driver to
@@ -85,6 +86,7 @@
 
 config MTD_PHRAM
 	tristate "Physical system RAM"
+ 	depends on HAS_IOMEM
 	help
 	  This is a re-implementation of the slram driver above.
 
@@ -151,10 +153,13 @@
 	  Testing MTD users (eg JFFS2) on large media and media that might
 	  be removed during a write (using the floppy drive).
 
+if HAS_IOMEM
 comment "Disk-On-Chip Device Drivers"
+endif
 
 config MTD_DOC2000
 	tristate "M-Systems Disk-On-Chip 2000 and Millennium (DEPRECATED)"
+ 	depends on HAS_IOMEM
 	select MTD_DOCPROBE
 	select MTD_NAND_IDS
 	---help---
@@ -177,6 +182,7 @@
 
 config MTD_DOC2001
 	tristate "M-Systems Disk-On-Chip Millennium-only alternative driver (DEPRECATED)"
+ 	depends on HAS_IOMEM
 	select MTD_DOCPROBE
 	select MTD_NAND_IDS
 	---help---
@@ -198,6 +204,7 @@
 
 config MTD_DOC2001PLUS
 	tristate "M-Systems Disk-On-Chip Millennium Plus"
+ 	depends on HAS_IOMEM
 	select MTD_DOCPROBE
 	select MTD_NAND_IDS
 	---help---
Index: linux-2.6.23.1-uml/drivers/mtd/Kconfig
===================================================================
--- linux-2.6.23.1-uml.orig/drivers/mtd/Kconfig
+++ linux-2.6.23.1-uml/drivers/mtd/Kconfig
@@ -2,7 +2,6 @@
 
 menuconfig MTD
 	tristate "Memory Technology Device (MTD) support"
-	depends on HAS_IOMEM
 	help
 	  Memory Technology Devices are flash, RAM and similar chips, often
 	  used for solid state file systems on embedded devices. This option
@@ -278,15 +277,18 @@
 	  This enables read only access to SmartMedia formatted NAND
 	  flash. You can mount it with FAT file system.
 
-source "drivers/mtd/chips/Kconfig"
 
-source "drivers/mtd/maps/Kconfig"
+if HAS_IOMEM
+	source "drivers/mtd/chips/Kconfig"
+	source "drivers/mtd/maps/Kconfig"
+endif
 
 source "drivers/mtd/devices/Kconfig"
 
-source "drivers/mtd/nand/Kconfig"
-
-source "drivers/mtd/onenand/Kconfig"
+if HAS_IOMEM
+	source "drivers/mtd/nand/Kconfig"
+	source "drivers/mtd/onenand/Kconfig"
+endif
 
 source "drivers/mtd/ubi/Kconfig"
 
Index: linux-2.6.23.1-uml/drivers/mtd/Makefile
===================================================================
--- linux-2.6.23.1-uml.orig/drivers/mtd/Makefile
+++ linux-2.6.23.1-uml/drivers/mtd/Makefile
@@ -26,6 +26,9 @@
 nftl-objs		:= nftlcore.o nftlmount.o
 inftl-objs		:= inftlcore.o inftlmount.o
 
-obj-y		+= chips/ maps/ devices/ nand/ onenand/
+obj-y		+= devices/
+ifdef CONFIG_HAS_IOMEM
+obj-y		+= chips/ maps/ nand/ onenand/
+endif
 
 obj-$(CONFIG_MTD_UBI)		+= ubi/

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft
Defy all challenges. Microsoft(R) Visual Studio 2005.
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel
