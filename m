Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 06/22] iio: adc: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-7-git-send-email-richard@nod.at>
From: Jonathan Cameron <jic23@kernel.org>
Message-ID: <56ACDA78.1070208@kernel.org>
Date: Sat, 30 Jan 2016 15:44:56 +0000
MIME-Version: 1.0
In-Reply-To: <1453760661-1444-7-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Hartmut Knaack <knaack.h@gmx.de>, Lars-Peter Clausen <lars@metafoo.de>, Peter Meerwald <pmeerw@pmeerw.net>, Pradeep Goudagunta <pgoudagunta@nvidia.com>, Haibo Chen <haibo.chen@freescale.com>, Phani Movva <Phani.Movva@imgtec.com>, Andrea Galbusera <gizero@gmail.com>, Stanimir Varbanov <svarbanov@mm-sol.com>, Vladimir Barinov <vladimir.barinov@cogentembedded.com>, Sean Nyekjaer <sean.nyekjaer@prevas.dk>, =?UTF-8?Q?Oliver_St=c3=a4bler?= <oliver.staebler@bytesatwork.ch>, =?UTF-8?Q?Urs_F=c3=a4ssler?= <urs.fassler@bytesatwork.ch>, =?UTF-8?Q?S=c3=b8ren_Andersen?= <san@rosetechnology.dk>, linux-iio@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 25/01/16 22:24, Richard Weinberger wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
Applied to the temporary branch for post 4.5 fixes
(as I haven't unwound that yet) for iio.git.
> ---
>  drivers/iio/adc/Kconfig | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 605ff42..283ded7 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -175,6 +175,7 @@ config DA9150_GPADC
>  config EXYNOS_ADC
>  	tristate "Exynos ADC driver support"
>  	depends on ARCH_EXYNOS || ARCH_S3C24XX || ARCH_S3C64XX || (OF && COMPILE_TEST)
> +	depends on HAS_IOMEM
>  	help
>  	  Core support for the ADC block found in the Samsung EXYNOS series
>  	  of SoCs for drivers such as the touchscreen and hwmon to use to share
> @@ -207,6 +208,7 @@ config INA2XX_ADC
>  config IMX7D_ADC
>  	tristate "IMX7D ADC driver"
>  	depends on ARCH_MXC || COMPILE_TEST
> +	depends on HAS_IOMEM
>  	help
>  	  Say yes here to build support for IMX7D ADC.
>  
> @@ -409,6 +411,7 @@ config TWL6030_GPADC
>  config VF610_ADC
>  	tristate "Freescale vf610 ADC driver"
>  	depends on OF
> +	depends on HAS_IOMEM
>  	select IIO_BUFFER
>  	select IIO_TRIGGERED_BUFFER
>  	help
> 


