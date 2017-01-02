Return-Path: <rdunlap@infradead.org>
Subject: [PATCH] auxdisplay: img-ascii-lcd: don't build without HAS_IOMEM
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <81455897-f6c1-79c1-7410-eff7656c1a0f@infradead.org>
Date: Sun, 1 Jan 2017 18:42:38 -0800
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
To: LKML <linux-kernel@vger.kernel.org>
Cc: kbuild test robot <fengguang.wu@intel.com>, Paul Burton <paul.burton@imgtec.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

From: Randy Dunlap <rdunlap@infradead.org>

Fix build error when the driver is built for arch/um, which does not
support HAS_IOMEM. Furthermore, the in-tree SYSCON drivers also require
HAS_IOMEM.

drivers/built-in.o: In function `img_ascii_lcd_probe':
drivers/auxdisplay/img-ascii-lcd.c:384: undefined reference to `devm_ioremap_resource'

Paul: there is no SYSCON kconfig symbol in the kernel tree. Should that
be MFD_SYSCON or GPIO_SYSCON?
Also, there is no MIPS_SEAD3 kconfig symbol either. Please fix that.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Reported-by: kbuild test robot <fengguang.wu@intel.com>
Cc:	Paul Burton <paul.burton@imgtec.com>
Cc:	Jeff Dike <jdike@addtoit.com>
Cc:	Richard Weinberger <richard@nod.at>
Cc:	user-mode-linux-devel@lists.sourceforge.net
Cc:	Lee Jones <lee.jones@linaro.org>
Cc:	Arnd Bergmann <arnd@arndb.de>
Cc:	Geert Uytterhoeven <geert@linux-m68k.org>
Cc:	Ralf Baechle <ralf@linux-mips.org>
---
 drivers/auxdisplay/Kconfig |    1 +
 1 file changed, 1 insertion(+)

--- lnx-410-rc2.orig/drivers/auxdisplay/Kconfig
+++ lnx-410-rc2/drivers/auxdisplay/Kconfig
@@ -121,6 +121,7 @@ config CFAG12864B_RATE
 
 config IMG_ASCII_LCD
 	tristate "Imagination Technologies ASCII LCD Display"
+	depends on HAS_IOMEM
 	default y if MIPS_MALTA || MIPS_SEAD3
 	select SYSCON
 	help

