Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] auxdisplay: img-ascii-lcd: don't build without HAS_IOMEM
Date: Mon, 02 Jan 2017 09:32:15 +0100
Message-ID: <2271567.NkZGHHkdue@wuerfel>
In-Reply-To: <81455897-f6c1-79c1-7410-eff7656c1a0f@infradead.org>
References: <81455897-f6c1-79c1-7410-eff7656c1a0f@infradead.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
To: Randy Dunlap <rdunlap@infradead.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kbuild test robot <fengguang.wu@intel.com>, Paul Burton <paul.burton@imgtec.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net, Lee Jones <lee.jones@linaro.org>, Geert Uytterhoeven <geert@linux-m68k.org>, Ralf Baechle <ralf@linux-mips.org>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sunday, January 1, 2017 6:42:38 PM CET Randy Dunlap wrote:
> --- lnx-410-rc2.orig/drivers/auxdisplay/Kconfig
> +++ lnx-410-rc2/drivers/auxdisplay/Kconfig
> @@ -121,6 +121,7 @@ config CFAG12864B_RATE
>  
>  config IMG_ASCII_LCD
>         tristate "Imagination Technologies ASCII LCD Display"
> +       depends on HAS_IOMEM
>         default y if MIPS_MALTA || MIPS_SEAD3
>         select SYSCON
>         help

Maybe "depends on MIPS || COMPILE_TEST" instead?

That hides the symbol for most people that don't really want the driver
anyway, and it takes care of HAS_IOMEM for UML as well.

	Arnd


