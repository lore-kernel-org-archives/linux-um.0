Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-4.v43.ch3.sourceforge.com ([172.29.43.194]
	helo=mx.sourceforge.net)
	by sfs-ml-3.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <rdunlap@infradead.org>) id 1cNspZ-0003XV-5w
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Jan 2017 02:58:37 +0000
Received: from bombadil.infradead.org ([198.137.202.9])
	by sog-mx-4.v43.ch3.sourceforge.com with esmtps (TLSv1:AES128-SHA:128)
	(Exim 4.76) id 1cNspX-00082O-1B
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 02 Jan 2017 02:58:37 +0000
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <8a756f24-4c18-690c-b898-03ecf3d71c84@infradead.org>
Date: Sun, 1 Jan 2017 18:58:27 -0800
MIME-Version: 1.0
Subject: [uml-devel] [PATCH] mtd: nand: oxnas_nand: fix build errors on
 arch/um, require HAS_IOMEM
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>, user-mode-linux-devel@lists.sourceforge.net, Neil Armstrong <narmstrong@baylibre.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, kbuild test robot <fengguang.wu@intel.com>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build errors on arch/um, which does not support HAS_IOMEM,
while the oxnas_nand.c driver uses interfaces that are
supplied by HAS_IOMEM.

(loadable module build:)
ERROR: "devm_ioremap_resource" [drivers/mtd/nand/oxnas_nand.ko] undefined!
or (built-in build:)
drivers/built-in.o: In function `oxnas_nand_probe':
drivers/mtd/nand/oxnas_nand.c:102: undefined reference to `devm_ioremap_resource'

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc:	Jeff Dike <jdike@addtoit.com>
Cc:	Richard Weinberger <richard@nod.at>
Cc:	user-mode-linux-devel@lists.sourceforge.net
Cc:	linux-mtd@lists.infradead.org
---
 drivers/mtd/nand/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-410-rc2.orig/drivers/mtd/nand/Kconfig
+++ lnx-410-rc2/drivers/mtd/nand/Kconfig
@@ -426,6 +426,7 @@ config MTD_NAND_ORION
 
 config MTD_NAND_OXNAS
 	tristate "NAND Flash support for Oxford Semiconductor SoC"
+	depends on HAS_IOMEM
 	help
 	  This enables the NAND flash controller on Oxford Semiconductor SoCs.
 

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
_______________________________________________
User-mode-linux-devel mailing list
User-mode-linux-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel

