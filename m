Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 09/22] leds: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-10-git-send-email-richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56A6A4C7.7090906@nod.at>
Date: Mon, 25 Jan 2016 23:42:15 +0100
MIME-Version: 1.0
In-Reply-To: <1453760661-1444-10-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Purdie <rpurdie@rpsys.net>, Jacek Anaszewski <j.anaszewski@samsung.com>, linux-leds@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 25.01.2016 um 23:24 schrieb Richard Weinberger:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/leds/Kconfig | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/leds/Kconfig b/drivers/leds/Kconfig
> index 7f940c2..e76a45c 100644
> --- a/drivers/leds/Kconfig
> +++ b/drivers/leds/Kconfig
> @@ -54,6 +54,7 @@ config LEDS_BCM6328
>  	depends on LEDS_CLASS
>  	depends on HAS_IOMEM
>  	depends on OF
> +	depends on HAS_IOMEM
>  	help
>  	  This option enables support for LEDs connected to the BCM6328
>  	  LED HW controller accessed via MMIO registers.
> @@ -63,6 +64,7 @@ config LEDS_BCM6358
>  	depends on LEDS_CLASS
>  	depends on HAS_IOMEM
>  	depends on OF
> +	depends on HAS_IOMEM

Please drop this patch too.
Did not notice that this was fixed already.

Thanks,
//richard

