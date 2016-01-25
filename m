Return-Path: <linux-kernel-owner@vger.kernel.org>
Subject: Re: [PATCH 14/22] pwm: Fix dependencies for !HAS_IOMEM archs
References: <1453760661-1444-1-git-send-email-richard@nod.at>
 <1453760661-1444-15-git-send-email-richard@nod.at>
From: Richard Weinberger <richard@nod.at>
Message-ID: <56A6A46C.7090006@nod.at>
Date: Mon, 25 Jan 2016 23:40:44 +0100
MIME-Version: 1.0
In-Reply-To: <1453760661-1444-15-git-send-email-richard@nod.at>
Content-Type: text/plain; charset=iso-8859-15
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Thierry Reding <thierry.reding@gmail.com>, linux-pwm@vger.kernel.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Am 25.01.2016 um 23:24 schrieb Richard Weinberger:
> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
> 
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/pwm/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 8cf0dae..e83aa94 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -150,6 +150,7 @@ config PWM_FSL_FTM
>  	tristate "Freescale FlexTimer Module (FTM) PWM support"
>  	depends on HAS_IOMEM
>  	depends on OF
> +	depends on HAS_IOMEM

Please drop this patch.

It was created before:
commit 36d5be4bc9059f8123e818c8b63a4049cf1d0e0f
Author: Vegard Nossum <vegard.nossum@oracle.com>
Date:   Sat Jan 2 14:02:07 2016 +0100

    pwm: add HAS_IOMEM dependency to PWM_FSL_FTM

git am did not notice^^

Thanks,
//richard

