Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Tue, 3 Jan 2017 09:20:04 +0100
From: Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: Re: [PATCH] mtd: nand: oxnas_nand: fix build errors on arch/um,
 require HAS_IOMEM
Message-ID: <20170103092004.6edd6e3e@bbrezillon>
In-Reply-To: <8a756f24-4c18-690c-b898-03ecf3d71c84@infradead.org>
References: <8a756f24-4c18-690c-b898-03ecf3d71c84@infradead.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: user-mode-linux-devel@lists.sourceforge.net, Neil Armstrong <narmstrong@baylibre.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, LKML <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, kbuild test robot <fengguang.wu@intel.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On Sun, 1 Jan 2017 18:58:27 -0800
Randy Dunlap <rdunlap@infradead.org> wrote:

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

Applied to nand/fixes. It should appear in one of the next -rc
(probably not -rc3 though).

Thanks,

Boris

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


______________________________________________________
Linux MTD discussion mailing list
http://lists.infradead.org/mailman/listinfo/linux-mtd/

