Return-Path: <linux-kernel-owner@vger.kernel.org>
Message-ID: <56A75653.8080902@linaro.org>
Date: Tue, 26 Jan 2016 11:19:47 +0000
From: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Subject: Re: [PATCH 12/22] nvmem: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at> <1453760661-1444-13-git-send-email-richard@nod.at>
In-Reply-To: <1453760661-1444-13-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Maxime Ripard <maxime.ripard@free-electrons.com>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>



On 25/01/16 22:24, Richard Weinberger wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Acked-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>

Am happy to pick this one, unless you have plans to get all these 
patches merged via a single tree.

Thanks,
srini
> ---
>   drivers/nvmem/Kconfig | 4 ++++
>   1 file changed, 4 insertions(+)
>
> diff --git a/drivers/nvmem/Kconfig b/drivers/nvmem/Kconfig
> index bc4ea58..c675ee9 100644
> --- a/drivers/nvmem/Kconfig
> +++ b/drivers/nvmem/Kconfig
> @@ -28,6 +28,7 @@ config NVMEM_IMX_OCOTP
>   config NVMEM_MXS_OCOTP
>   	tristate "Freescale MXS On-Chip OTP Memory Support"
>   	depends on ARCH_MXS || COMPILE_TEST
> +	depends on HAS_IOMEM
>   	help
>   	  If you say Y here, you will get readonly access to the
>   	  One Time Programmable memory pages that are stored
> @@ -39,6 +40,7 @@ config NVMEM_MXS_OCOTP
>   config QCOM_QFPROM
>   	tristate "QCOM QFPROM Support"
>   	depends on ARCH_QCOM || COMPILE_TEST
> +	depends on HAS_IOMEM
>   	select REGMAP_MMIO
>   	help
>   	  Say y here to enable QFPROM support. The QFPROM provides access
> @@ -50,6 +52,7 @@ config QCOM_QFPROM
>   config ROCKCHIP_EFUSE
>   	tristate "Rockchip eFuse Support"
>   	depends on ARCH_ROCKCHIP || COMPILE_TEST
> +	depends on HAS_IOMEM
>   	help
>   	  This is a simple drive to dump specified values of Rockchip SoC
>   	  from eFuse, such as cpu-leakage.
> @@ -71,6 +74,7 @@ config NVMEM_SUNXI_SID
>   config NVMEM_VF610_OCOTP
>   	tristate "VF610 SoC OCOTP support"
>   	depends on SOC_VF610 || COMPILE_TEST
> +	depends on HAS_IOMEM
>   	help
>   	  This is a driver for the 'OCOTP' peripheral available on Vybrid
>   	  devices like VF5xx and VF6xx.
>

