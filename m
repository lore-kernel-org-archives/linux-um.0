Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nN95y-00HDIe-LC
 for linux-um@lists.infradead.org; Thu, 24 Feb 2022 08:03:28 +0000
Subject: Re: [PATCH] clk: lan966x: Depend on CONFIG_IOMEM
References: <20220224035902.1594253-1-davidgow@google.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <e2a5b8f1-2117-c1be-9223-91904de885d5@kot-begemot.co.uk>
Date: Thu, 24 Feb 2022 08:03:15 +0000
MIME-Version: 1.0
In-Reply-To: <20220224035902.1594253-1-davidgow@google.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: David Gow <davidgow@google.com>, Stephen Boyd <sboyd@kernel.org>, Michael Turquette <mturquette@baylibre.com>
Cc: linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org



On 24/02/2022 03:59, David Gow wrote:
> The lan966x clk driver depends on IOMEM functions, in particular
> devm_platform_ioremap_resource(), but doesn't state a formal dependency
> on it in Kconfig.
> 
> Add such a dependency, which prevents this driver from being enabled
> on UML configurations without IOMEM.
> 
> This fixes the following build failure:
> 
> /usr/bin/ld: drivers/clk/clk-lan966x.o: in function `lan966x_clk_probe':
> clk-lan966x.c:(.text+0x294): undefined reference to `devm_platform_ioremap_resource'
> /usr/bin/ld: clk-lan966x.c:(.text+0x3aa): undefined reference to `devm_ioremap_resource'
> collect2: error: ld returned 1 exit status
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>   drivers/clk/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/clk/Kconfig b/drivers/clk/Kconfig
> index 3cdf33470a75..7b5db8a9eb4f 100644
> --- a/drivers/clk/Kconfig
> +++ b/drivers/clk/Kconfig
> @@ -231,6 +231,7 @@ config COMMON_CLK_GEMINI
>   
>   config COMMON_CLK_LAN966X
>   	bool "Generic Clock Controller driver for LAN966X SoC"
> +	depends on IOMEM
>   	help
>   	  This driver provides support for Generic Clock Controller(GCK) on
>   	  LAN966X SoC. GCK generates and supplies clock to various peripherals
> 

Acked-By: anton ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
https://www.kot-begemot.co.uk/

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

