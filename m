Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Subject: Re: [PATCH 08/22] hwtracing: Fix dependencies for !HAS_IOMEM archs
In-Reply-To: <1453760661-1444-9-git-send-email-richard@nod.at>
References: <1453760661-1444-1-git-send-email-richard@nod.at> <1453760661-1444-9-git-send-email-richard@nod.at>
Date: Fri, 05 Feb 2016 16:07:06 +0200
Message-ID: <878u2z5jzp.fsf@ashishki-desk.ger.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
To: Richard Weinberger <richard@nod.at>, linux-kernel@vger.kernel.org
Cc: user-mode-linux-devel@lists.sourceforge.net, Richard Weinberger <richard@nod.at>
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

Richard Weinberger <richard@nod.at> writes:

> Not every arch has io memory.
> So, unbreak the build by fixing the dependencies.
>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  drivers/hwtracing/intel_th/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/drivers/hwtracing/intel_th/Kconfig b/drivers/hwtracing/intel_th/Kconfig
> index b7a9073..467dae9 100644
> --- a/drivers/hwtracing/intel_th/Kconfig
> +++ b/drivers/hwtracing/intel_th/Kconfig
> @@ -1,5 +1,6 @@
>  config INTEL_TH
>  	tristate "Intel(R) Trace Hub controller"
> +	depends on HAS_IOMEM
>  	help
>  	  Intel(R) Trace Hub (TH) is a set of hardware blocks (subdevices) that
>  	  produce, switch and output trace data from multiple hardware and

Didn't apply to my queue (as there were a few more Kconfig fixes
earlier), but I yanked it there by hand. Thanks!

Regards,
--
Alex

