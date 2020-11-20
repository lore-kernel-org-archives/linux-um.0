Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kgF3o-0004Ft-12
 for linux-um@lists.infradead.org; Fri, 20 Nov 2020 22:39:21 +0000
Date: Fri, 20 Nov 2020 23:39:14 +0100
From: Alexandre Belloni <alexandre.belloni@bootlin.com>
Subject: Re: [PATCH] rtc: enable RTC framework on ARCH=um
Message-ID: <20201120223914.GD348979@piout.net>
References: <20201120211103.6895ac740d11.Ic19a9926e8e4c70c03329e55f9e5b1d45095b904@changeid>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201120211103.6895ac740d11.Ic19a9926e8e4c70c03329e55f9e5b1d45095b904@changeid>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-rtc@vger.kernel.org, Alessandro Zummo <a.zummo@towertech.it>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>

On 20/11/2020 21:11:06+0100, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> There's no real reason it should be disabled, and at least we can
> use it for development & testing with the RTC test driver.
> 
> However, two devices are missing a HAS_IOMEM dependency, so add
> that to avoid build failures from e.g. allyesconfig.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Acked-by: Alexandre Belloni <alexandre.belloni@bootlin.com>

> ---
> Would there be objection to taking this through the linux-um tree?
> I have a couple of patches that depend on it as well, to add
> suspend/resume support with a pseudo-RTC to wake up from it.

I'm fine with that.

> ---
>  drivers/rtc/Kconfig | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/rtc/Kconfig b/drivers/rtc/Kconfig
> index 48c536acd777..de187b563989 100644
> --- a/drivers/rtc/Kconfig
> +++ b/drivers/rtc/Kconfig
> @@ -13,7 +13,7 @@ config RTC_MC146818_LIB
>  menuconfig RTC_CLASS
>  	bool "Real Time Clock"
>  	default n
> -	depends on !S390 && !UML
> +	depends on !S390
>  	select RTC_LIB
>  	help
>  	  Generic RTC class support. If you say yes here, you will
> @@ -1007,6 +1007,7 @@ config RTC_DRV_DS1553
>  
>  config RTC_DRV_DS1685_FAMILY
>  	tristate "Dallas/Maxim DS1685 Family"
> +	depends on HAS_IOMEM
>  	help
>  	  If you say yes here you get support for the Dallas/Maxim DS1685
>  	  family of real time chips.  This family includes the DS1685/DS1687,
> @@ -1140,6 +1141,7 @@ config RTC_DRV_STK17TA8
>  
>  config RTC_DRV_M48T86
>  	tristate "ST M48T86/Dallas DS12887"
> +	depends on HAS_IOMEM
>  	help
>  	  If you say Y here you will get support for the
>  	  ST M48T86 and Dallas DS12887 RTC chips.
> -- 
> 2.26.2
> 

-- 
Alexandre Belloni, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

