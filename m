Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH] mtd: nand: oxnas_nand: fix build errors on arch/um,
 require HAS_IOMEM
References: <8a756f24-4c18-690c-b898-03ecf3d71c84@infradead.org>
From: Neil Armstrong <narmstrong@baylibre.com>
Message-ID: <271b3ede-b784-07f2-8028-19be4ea7fcbd@baylibre.com>
Date: Mon, 2 Jan 2017 09:33:27 +0100
MIME-Version: 1.0
In-Reply-To: <8a756f24-4c18-690c-b898-03ecf3d71c84@infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org
Cc: kbuild test robot <fengguang.wu@intel.com>, Boris Brezillon <boris.brezillon@free-electrons.com>, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, user-mode-linux-devel@lists.sourceforge.net
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 01/02/2017 03:58 AM, Randy Dunlap wrote:
> From: Randy Dunlap <rdunlap@infradead.org>
> 
> Fix build errors on arch/um, which does not support HAS_IOMEM,
> while the oxnas_nand.c driver uses interfaces that are
> supplied by HAS_IOMEM.
> 
> (loadable module build:)
> ERROR: "devm_ioremap_resource" [drivers/mtd/nand/oxnas_nand.ko] undefined!
> or (built-in build:)
> drivers/built-in.o: In function `oxnas_nand_probe':
> drivers/mtd/nand/oxnas_nand.c:102: undefined reference to `devm_ioremap_resource'
> 
> Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
> Reported-by: kbuild test robot <fengguang.wu@intel.com>
> Cc: Boris Brezillon <boris.brezillon@free-electrons.com>
> Cc: Neil Armstrong <narmstrong@baylibre.com>
> Cc:	Jeff Dike <jdike@addtoit.com>
> Cc:	Richard Weinberger <richard@nod.at>
> Cc:	user-mode-linux-devel@lists.sourceforge.net
> Cc:	linux-mtd@lists.infradead.org
> ---
>  drivers/mtd/nand/Kconfig |    1 +
>  1 file changed, 1 insertion(+)
> 
> --- lnx-410-rc2.orig/drivers/mtd/nand/Kconfig
> +++ lnx-410-rc2/drivers/mtd/nand/Kconfig
> @@ -426,6 +426,7 @@ config MTD_NAND_ORION
>  
>  config MTD_NAND_OXNAS
>  	tristate "NAND Flash support for Oxford Semiconductor SoC"
> +	depends on HAS_IOMEM
>  	help
>  	  This enables the NAND flash controller on Oxford Semiconductor SoCs.
>  
> 

Thanks Randy,

Acked-by: Neil Armstrong <narmstrong@baylibre.com>

