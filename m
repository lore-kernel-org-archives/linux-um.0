Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga03.intel.com ([134.134.136.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kfhwY-0005QY-5M
 for linux-um@lists.infradead.org; Thu, 19 Nov 2020 11:17:39 +0000
Date: Thu, 19 Nov 2020 19:13:21 +0800
From: Xu Yilun <yilun.xu@intel.com>
Subject: Re: [PATCH] drivers: fpga: Specify HAS_IOMEM dependency for FPGA_DFL
Message-ID: <20201119111321.GA26472@yilunxu-OptiPlex-7050>
References: <20201119082209.3598354-1-davidgow@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20201119082209.3598354-1-davidgow@google.com>
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
To: David Gow <davidgow@google.com>
Cc: Tom Rix <trix@redhat.com>, linux-fpga@vger.kernel.org, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, Moritz Fischer <mdf@kernel.org>, Brendan Higgins <brendanhiggins@google.com>

Thanks for the fix, looks good to me.

Thanks,
Yilun

On Thu, Nov 19, 2020 at 12:22:09AM -0800, David Gow wrote:
> Because dfl.c uses the 'devm_ioremap', 'devm_iounmap',
> 'devm_ioremap_resource', and 'devm_platform_ioremap_resource'
> functions, it should depend on HAS_IOMEM.
> 
> This fixes make allyesconfig under UML (ARCH=um), which doesn't provide
> HAS_IOMEM.
> 
> Signed-off-by: David Gow <davidgow@google.com>
> ---
>  drivers/fpga/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/fpga/Kconfig b/drivers/fpga/Kconfig
> index 7cd5a29fc437..5645226ca3ce 100644
> --- a/drivers/fpga/Kconfig
> +++ b/drivers/fpga/Kconfig
> @@ -142,6 +142,7 @@ config FPGA_DFL
>  	tristate "FPGA Device Feature List (DFL) support"
>  	select FPGA_BRIDGE
>  	select FPGA_REGION
> +	depends on HAS_IOMEM
>  	help
>  	  Device Feature List (DFL) defines a feature list structure that
>  	  creates a linked list of feature headers within the MMIO space
> -- 
> 2.29.2.454.gaff20da3a2-goog

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

