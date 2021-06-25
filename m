Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga09.intel.com ([134.134.136.24])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lwmuO-001xin-J7
 for linux-um@lists.infradead.org; Fri, 25 Jun 2021 14:34:17 +0000
Subject: Re: [PATCH] dmaengine: idxd: depends on !UML
References: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
From: Dave Jiang <dave.jiang@intel.com>
Message-ID: <ff85e229-9605-7a25-08fa-4013df49b49c@intel.com>
Date: Fri, 25 Jun 2021 07:34:12 -0700
MIME-Version: 1.0
In-Reply-To: <20210625103810.fe877ae0aef4.If240438e3f50ae226f3f755fc46ea498c6858393@changeid>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, dmaengine@vger.kernel.org
Cc: linux-um@lists.infradead.org, Johannes Berg <johannes.berg@intel.com>, kernel test robot <lkp@intel.com>


On 6/25/2021 1:38 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
>
> Now that UML has PCI support, this driver must depend also on
> !UML since it pokes at X86_64 architecture internals that don't
> exist on ARCH=um.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Acked-by: Dave Jiang <dave.jiang@intel.com>


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

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

