Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from metis.ext.pengutronix.de ([2001:67c:670:201:290:27ff:fe1d:cc33])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iwN4a-0000ZG-Gp
 for linux-um@lists.infradead.org; Tue, 28 Jan 2020 09:22:17 +0000
Message-ID: <01d73961207b5110c2edc72d4964582b12bcc8f7.camel@pengutronix.de>
Subject: Re: [PATCH v1 2/5] reset: brcmstb-rescal: add unspecified HAS_IOMEM
 dependency
From: Philipp Zabel <p.zabel@pengutronix.de>
Date: Tue, 28 Jan 2020 10:22:08 +0100
In-Reply-To: <20200127235356.122031-3-brendanhiggins@google.com>
References: <20200127235356.122031-1-brendanhiggins@google.com>
 <20200127235356.122031-3-brendanhiggins@google.com>
MIME-Version: 1.0
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com
Cc: linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, davidgow@google.com, heidifahim@google.com

On Mon, 2020-01-27 at 15:53 -0800, Brendan Higgins wrote:
> Currently CONFIG_RESET_BRCMSTB_RESCAL=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we get
> the following build error:
> 
> /usr/bin/ld: drivers/reset/reset-brcmstb-rescal.o: in function `brcm_rescal_reset_probe':
> drivers/reset/reset-brcmstb-rescal.c:76: undefined reference to `devm_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
> ---
>  drivers/reset/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
> index 461b0e506a26f..a19bd303f31a9 100644
> --- a/drivers/reset/Kconfig
> +++ b/drivers/reset/Kconfig
> @@ -51,6 +51,7 @@ config RESET_BRCMSTB
>  
>  config RESET_BRCMSTB_RESCAL
>  	bool "Broadcom STB RESCAL reset controller"
> +	depends on HAS_IOMEM
>  	default ARCH_BRCMSTB || COMPILE_TEST
>  	help
>  	  This enables the RESCAL reset controller for SATA, PCIe0, or PCIe1 on

Thank you, I'll pick up the reset patches 2 and 3.

regards
Philipp

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

