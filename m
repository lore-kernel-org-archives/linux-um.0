Return-Path: <linux-pm-owner@vger.kernel.org>
Message-ID: <56A8026F.8090001@gmail.com>
Date: Tue, 26 Jan 2016 15:34:07 -0800
From: Florian Fainelli <f.fainelli@gmail.com>
MIME-Version: 1.0
Subject: Re: [PATCH 01/22] power: reset: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at> <1453760661-1444-2-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-2-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Sender: linux-pm-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Sebastian Reichel <sre@kernel.org>, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>, David Woodhouse <dwmw2@infradead.org>, Alexandre Belloni <alexandre.belloni@free-electrons.com>, Moritz Fischer <moritz.fischer@ettus.com>, Jun Nie <jun.nie@linaro.org>, linux-pm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 25/01/16 14:24, Richard Weinberger wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/power/reset/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/power/reset/Kconfig b/drivers/power/reset/Kconfig
> index 1131cf7..0a6408a 100644
> --- a/drivers/power/reset/Kconfig
> +++ b/drivers/power/reset/Kconfig
> @@ -148,6 +148,7 @@ config POWER_RESET_KEYSTONE
>  config POWER_RESET_SYSCON
>  	bool "Generic SYSCON regmap reset driver"
>  	depends on OF
> +	depends on HAS_IOMEM
>  	select MFD_SYSCON

Should this dependency go into REGMAP_MMIO instead? MFD_SYSCON in itself
does not issue I/O accesses per-se, but does use helpers from regmap,
which in turn do it.

>  	help
>  	  Reboot support for generic SYSCON mapped register reset.
> @@ -155,6 +156,7 @@ config POWER_RESET_SYSCON
>  config POWER_RESET_SYSCON_POWEROFF
>  	bool "Generic SYSCON regmap poweroff driver"
>  	depends on OF
> +	depends on HAS_IOMEM
>  	select MFD_SYSCON

Likewise.
-- 
Florian
