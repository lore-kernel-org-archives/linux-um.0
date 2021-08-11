Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mga05.intel.com ([192.55.52.43])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mDpT5-007SyR-Gc
 for linux-um@lists.infradead.org; Wed, 11 Aug 2021 14:44:32 +0000
Subject: Re: [PATCH] PCI: vmd: depend on !UML
References: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
From: "Derrick, Jonathan" <jonathan.derrick@intel.com>
Message-ID: <a8905276-7b46-cc50-740f-b9d86ec54717@intel.com>
Date: Wed, 11 Aug 2021 08:43:45 -0600
In-Reply-To: <20210811162530.affe26231bc3.I131b3c1e67e3d2ead6e98addd256c835fbef9a3e@changeid>
Content-Language: en-US
MIME-Version: 1.0
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
To: Johannes Berg <johannes@sipsolutions.net>, "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, Randy Dunlap <rdunlap@infradead.org>, Berg,

Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>

On 8/11/2021 8:25 AM, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> With UML having enabled (simulated) PCI on UML, VMD breaks
> allyesconfig/allmodconfig compilation because it assumes
> it's running on X86_64 bare metal, and has hardcoded API
> use of ARCH=x86. Make it depend on !UML to fix this.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  drivers/pci/controller/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/controller/Kconfig b/drivers/pci/controller/Kconfig
> index 64e2f5e379aa..297bbd86806a 100644
> --- a/drivers/pci/controller/Kconfig
> +++ b/drivers/pci/controller/Kconfig
> @@ -257,7 +257,7 @@ config PCIE_TANGO_SMP8759
>  	  config and MMIO accesses.
>  
>  config VMD
> -	depends on PCI_MSI && X86_64 && SRCU
> +	depends on PCI_MSI && X86_64 && SRCU && !UML
>  	tristate "Intel Volume Management Device Driver"
>  	help
>  	  Adds support for the Intel Volume Management Device (VMD). VMD is a
> 

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

