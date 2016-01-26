Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 15/22] watchdog: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-16-git-send-email-richard@nod.at>
From: Guenter Roeck <linux@roeck-us.net>
Message-ID: <56A6DE41.9010504@roeck-us.net>
Date: Mon, 25 Jan 2016 18:47:29 -0800
MIME-Version: 1.0
In-Reply-To: <1453760661-1444-16-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Wim Van Sebroeck <wim@iguana.be>, linux-watchdog@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 01/25/2016 02:24 PM, Richard Weinberger wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/Kconfig | 3 +++
>   1 file changed, 3 insertions(+)
>
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 4f0e7be..0bd559a 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -146,6 +146,7 @@ config TANGOX_WATCHDOG
>   	tristate "Sigma Designs SMP86xx/SMP87xx watchdog"
>   	select WATCHDOG_CORE
>   	depends on ARCH_TANGOX || COMPILE_TEST
> +	depends on HAS_IOMEM
>   	help
>   	  Support for the watchdog in Sigma Designs SMP86xx (tango3)
>   	  and SMP87xx (tango4) family chips.
> @@ -618,6 +619,7 @@ config DIGICOLOR_WATCHDOG
>   config LPC18XX_WATCHDOG
>   	tristate "LPC18xx/43xx Watchdog"
>   	depends on ARCH_LPC18XX || COMPILE_TEST
> +	depends on HAS_IOMEM
>   	select WATCHDOG_CORE
>   	help
>   	  Say Y here if to include support for the watchdog timer
> @@ -1374,6 +1376,7 @@ config BCM_KONA_WDT_DEBUG
>   config BCM7038_WDT
>   	tristate "BCM7038 Watchdog"
>   	select WATCHDOG_CORE
> +	depends on HAS_IOMEM
>   	help
>   	 Watchdog driver for the built-in hardware in Broadcom 7038 SoCs.
>
>


