Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-oi1-f177.google.com ([209.85.167.177])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n8Mx8-009Flh-Br
 for linux-um@lists.infradead.org; Fri, 14 Jan 2022 13:49:15 +0000
Received: by mail-oi1-f177.google.com with SMTP id e81so12208699oia.6
 for <linux-um@lists.infradead.org>; Fri, 14 Jan 2022 05:49:13 -0800 (PST)
Date: Fri, 14 Jan 2022 07:49:09 -0600
From: Rob Herring <robh@kernel.org>
Subject: Re: [PATCH 2/2] um: Add devicetree support
Message-ID: <YeF/Vbxo6fAt0WLp@robh.at.kernel.org>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <20211208151123.29313-3-vincent.whitchurch@axis.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211208151123.29313-3-vincent.whitchurch@axis.com>
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, kernel@axis.com, linux-kernel@vger.kernel.org, linux-um@lists.infradead.org, devicetree@vger.kernel.org

On Wed, Dec 08, 2021 at 04:11:23PM +0100, Vincent Whitchurch wrote:
> Add a dtb=<filename> option to boot UML with a devicetree blob.  This
> can be used for testing driver code using UML.

Neat!

> Signed-off-by: Vincent Whitchurch <vincent.whitchurch@axis.com>
> ---
>  arch/um/Kconfig          |  1 +
>  arch/um/kernel/Makefile  |  1 +
>  arch/um/kernel/dtb.c     | 41 ++++++++++++++++++++++++++++++++++++++++
>  arch/um/kernel/um_arch.c |  3 +++
>  arch/um/kernel/um_arch.h |  6 ++++++
>  5 files changed, 52 insertions(+)
>  create mode 100644 arch/um/kernel/dtb.c
> 
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index c18b45f75d41..1cf7ef3a2b81 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -18,6 +18,7 @@ config UML
>  	select HAVE_DEBUG_KMEMLEAK
>  	select HAVE_DEBUG_BUGVERBOSE
>  	select NO_DMA if !UML_DMA_EMULATION
> +	select OF_EARLY_FLATTREE
>  	select GENERIC_IRQ_SHOW
>  	select GENERIC_CPU_DEVICES
>  	select HAVE_GCC_PLUGINS
> diff --git a/arch/um/kernel/Makefile b/arch/um/kernel/Makefile
> index 92692bfef7ae..ebd0cca3ff26 100644
> --- a/arch/um/kernel/Makefile
> +++ b/arch/um/kernel/Makefile
> @@ -22,6 +22,7 @@ obj-y += load_file.o
>  
>  obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
>  obj-$(CONFIG_GPROF)	+= gprof_syms.o
> +obj-$(CONFIG_OF) += dtb.o
>  obj-$(CONFIG_EARLY_PRINTK) += early_printk.o
>  obj-$(CONFIG_STACKTRACE) += stacktrace.o
>  obj-$(CONFIG_GENERIC_PCI_IOMAP) += ioport.o
> diff --git a/arch/um/kernel/dtb.c b/arch/um/kernel/dtb.c
> new file mode 100644
> index 000000000000..ca69d72025f3
> --- /dev/null
> +++ b/arch/um/kernel/dtb.c
> @@ -0,0 +1,41 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +
> +#include <linux/init.h>
> +#include <linux/of_fdt.h>
> +#include <linux/printk.h>
> +#include <linux/memblock.h>
> +#include <init.h>
> +
> +#include "um_arch.h"
> +
> +static char *dtb __initdata;
> +
> +void uml_dtb_init(void)
> +{
> +	long long size;
> +	void *area;
> +
> +	area = uml_load_file(dtb, &size);
> +	if (!area)
> +		return;
> +
> +	if (!early_init_dt_scan(area)) {
> +		pr_err("invalid DTB %s\n", dtb);
> +		memblock_free(area, size);
> +		return;
> +	}
> +
> +	unflatten_device_tree();
> +	early_init_fdt_scan_reserved_mem();

These should be reversed. early_init_fdt_scan_reserved_mem() works on 
the flat tree. Reserved memory needs to be reserved before 
unflatten_device_tree() starts allocating memory. Though I imagine that 
doesn't really matter for UML.

Also, does the dtb end up in permanently allocated memory (i.e. not 
init)? It needs to be if not.

Rob

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um

