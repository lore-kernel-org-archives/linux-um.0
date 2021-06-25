Return-Path: <dmaengine-owner@vger.kernel.org>
Subject: Re: [PATCH] dmaengine: idxd: depends on !UML
References: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <4de7c73b-a064-2adc-b7ee-ce2df6b72e1b@cambridgegreys.com>
Date: Fri, 25 Jun 2021 10:14:05 +0100
MIME-Version: 1.0
In-Reply-To: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
To: Johannes Berg <johannes@sipsolutions.net>, dmaengine@vger.kernel.org
Cc: Dave Jiang <dave.jiang@intel.com>, linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>
List-ID: <linux-um.lists.infradead.org>



On 25/06/2021 09:38, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>   drivers/dma/Kconfig | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
> index 6ab9d9a488a6..1f3c0e2ea4d9 100644
> --- a/drivers/dma/Kconfig
> +++ b/drivers/dma/Kconfig
> @@ -278,7 +278,7 @@ config INTEL_IDMA64
>   
>   config INTEL_IDXD
>   	tristate "Intel Data Accelerators support"
> -	depends on PCI && X86_64
> +	depends on PCI && X86_64 && !UML
>   	depends on PCI_MSI
>   	depends on SBITMAP
>   	select DMA_ENGINE
> 

Acked-By: Anton Ivanov <anton.ivanov@cambridgegreys.com>

-- 
Anton R. Ivanov
Cambridgegreys Limited. Registered in England. Company Number 10273661
https://www.cambridgegreys.com/

