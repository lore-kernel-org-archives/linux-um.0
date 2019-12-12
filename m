Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
From: Radhey Shyam Pandey <radheys@xilinx.com>
Subject: RE: [PATCH v1 3/7] net: axienet: add unspecified HAS_IOMEM dependency
Date: Thu, 12 Dec 2019 05:45:20 +0000
Message-ID: <CH2PR02MB7000A8C27E849A6B81251AFEC7550@CH2PR02MB7000.namprd02.prod.outlook.com>
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-4-brendanhiggins@google.com>
In-Reply-To: <20191211192742.95699-4-brendanhiggins@google.com>
Content-Language: en-US
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>, "jdike@addtoit.com" <jdike@addtoit.com>, "richard@nod.at" <richard@nod.at>, "anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>, David
Cc: "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "davidgow@google.com" <davidgow@google.com>
List-ID: <linux-um.lists.infradead.org>

> -----Original Message-----
> From: Brendan Higgins <brendanhiggins@google.com>
> Sent: Thursday, December 12, 2019 12:58 AM
> To: jdike@addtoit.com; richard@nod.at;
> anton.ivanov@cambridgegreys.com; David S. Miller
> <davem@davemloft.net>; Michal Simek <michals@xilinx.com>; Radhey
> Shyam Pandey <radheys@xilinx.com>
> Cc: linux-um@lists.infradead.org; linux-kernel@vger.kernel.org;
> davidgow@google.com; Brendan Higgins <brendanhiggins@google.com>;
> netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org
> Subject: [PATCH v1 3/7] net: axienet: add unspecified HAS_IOMEM
> dependency
> 
> Currently CONFIG_XILINX_AXI_EMAC=y implicitly depends on
> CONFIG_HAS_IOMEM=y; consequently, on architectures without IOMEM we
> get
> the following build error:
> 
> ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.o: in function
> `axienet_probe':
> drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1680: undefined reference
> to `devm_ioremap_resource'
> ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1779: undefined
> reference to `devm_ioremap_resource'
> ld: drivers/net/ethernet/xilinx/xilinx_axienet_main.c:1789: undefined
> reference to `devm_ioremap_resource'
> 
> Fix the build error by adding the unspecified dependency.
> 
> Reported-by: Brendan Higgins <brendanhiggins@google.com>
> Signed-off-by: Brendan Higgins <brendanhiggins@google.com>
Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@xilinx.com>
Thanks!

> ---
>  drivers/net/ethernet/xilinx/Kconfig | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/net/ethernet/xilinx/Kconfig
> b/drivers/net/ethernet/xilinx/Kconfig
> index 6304ebd8b5c69..b1a285e693756 100644
> --- a/drivers/net/ethernet/xilinx/Kconfig
> +++ b/drivers/net/ethernet/xilinx/Kconfig
> @@ -25,6 +25,7 @@ config XILINX_EMACLITE
> 
>  config XILINX_AXI_EMAC
>  	tristate "Xilinx 10/100/1000 AXI Ethernet support"
> +	depends on HAS_IOMEM
>  	select PHYLINK
>  	---help---
>  	  This driver supports the 10/100/1000 Ethernet from Xilinx for the
> --
> 2.24.0.525.g8f36a354ae-goog

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel

