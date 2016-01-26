Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 05/22] hw_random: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-6-git-send-email-richard@nod.at>
From: Daniel Thompson <daniel.thompson@linaro.org>
Message-ID: <56A7435B.5000405@linaro.org>
Date: Tue, 26 Jan 2016 09:58:51 +0000
MIME-Version: 1.0
In-Reply-To: <1453760661-1444-6-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Matt Mackall <mpm@selenic.com>, Herbert Xu <herbert@gondor.apana.org.au>, Lee Jones <lee.jones@linaro.org>, Kieran Bingham <kieranbingham@gmail.com>, Pankaj Dev <pankaj.dev@st.com>, Ray Jui <rjui@broadcom.com>, Scott Branden <sbranden@broadcom.com>, linux-crypto@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

On 25/01/16 22:24, Richard Weinberger wrote:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>

Reviewed-by: Daniel Thompson <daniel.thompson@linaro.org>

Thanks for cleaning up after me!

> ---
>   drivers/char/hw_random/Kconfig | 1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/drivers/char/hw_random/Kconfig b/drivers/char/hw_random/Kconfig
> index dbf2271..ff00331 100644
> --- a/drivers/char/hw_random/Kconfig
> +++ b/drivers/char/hw_random/Kconfig
> @@ -372,6 +372,7 @@ config HW_RANDOM_XGENE
>   config HW_RANDOM_STM32
>   	tristate "STMicroelectronics STM32 random number generator"
>   	depends on HW_RANDOM && (ARCH_STM32 || COMPILE_TEST)
> +	depends on HAS_IOMEM
>   	help
>   	  This driver provides kernel-side support for the Random Number
>   	  Generator hardware found on STM32 microcontrollers.
>


