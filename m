Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1BF7C6FD1F
	for <linux-um@archiver.kernel.org>; Tue, 26 Mar 2024 15:06:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NveygydDoL1I2tmP3079U8gSOyukDLicRi2/sGv+Fsk=; b=Sg3LF4H7UJlJW8HD+e/XHlq2ca
	JaK9CFQWUT2AbHiuWx4IiOzyASsxwwju5wOSJFeZ4kBbV1hNS1p3uVgIcPO0BMqBuVxHIdi4fTZaY
	/1EaJAzlI9AbC4N7BeQ3L42e992Kx4cXys778gP6JC7jzQOkjDddDgxgekodXPXw1Z51PROh7K6q0
	/4f3J3pzDwzSpUVfEHulPcVf1hoIrc9HRkL1y5vUmLswGHztLd4qoGSehGkGYGW4+GGxbXJEvtCGW
	eI5S/UnYJrz9RkuCabIGF78cWZkUo/C367zKhxnd/Xcio0ybBEmTXfSOFg9W8UW+4YUU9zR2yPuzV
	+d2Ag7bA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rp8Nc-00000005489-2Pjd;
	Tue, 26 Mar 2024 15:06:24 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rbE1e-00000004jiZ-0sRW;
	Sat, 17 Feb 2024 06:18:15 +0000
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id C4E4E207FD41; Fri, 16 Feb 2024 22:08:43 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com C4E4E207FD41
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1708150123;
	bh=NveygydDoL1I2tmP3079U8gSOyukDLicRi2/sGv+Fsk=;
	h=Date:From:To:Subject:From;
	b=gfBvQkxsgvrgxvx8ei0YKYLbPX0oTpuG0burQvCToL5cZSLkV07frfUcXgTQgv1oF
	 MNIa9jyUEvhxrey7hcAan+vv1VahEWdFY3d8aw5t4gA2lB4B9YgTW/Y9AjnjZyb67J
	 g3GPUMUBsWzrORMWhXrsbLTxrE3is3npS94RZbFs=
Date: Fri, 16 Feb 2024 22:08:43 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, robh+dt@kernel.org,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org
Subject: Re: [PATCH 2/7] of: Create of_root if no dtb provided by firmware
Message-ID: <20240217060843.GA16460@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Bad-Reply: 'Re:' in Subject but no References or In-Reply-To headers
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240216_221814_428362_2BC622CC 
X-CRM114-Status: GOOD (  36.55  )
X-Mailman-Approved-At: Tue, 26 Mar 2024 08:06:23 -0700
X-BeenThere: linux-um@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Fri, Feb 16, 2024 at 05:05:51PM -0800, Frank Rowand wrote:
> When enabling CONFIG_OF on a platform where 'of_root' is not populated
> by firmware, we end up without a root node. In order to apply overlays
> and create subnodes of the root node, we need one. Create this root node
> by unflattening an empty builtin dtb.
> 
> If firmware provides a flattened device tree (FDT) then the FDT is
> unflattened via setup_arch(). Otherwise, the call to
> unflatten(_and_copy)?_device_tree() will create an empty root node.
> 
> We make of_have_populated_dt() return true only if the DTB was loaded by
> firmware so that existing callers don't change behavior after this
> patch. The call in the of platform code is removed because it prevents
> overlays from creating platform devices when the empty root node is
> used.
> 
> [sboyd@kernel.org: Update of_have_populated_dt() to treat this empty dtb
> as not populated. Drop setup_of() initcall]
> 
> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> Link: https://lore.kernel.org/r/20230317053415.2254616-2-frowand.list@gmail.com
> Cc: Rob Herring <robh+dt@kernel.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/Kconfig        |  5 ++---
>  drivers/of/Makefile       |  2 +-
>  drivers/of/empty_root.dts |  6 ++++++
>  drivers/of/fdt.c          | 32 +++++++++++++++++++++++++++++++-
>  drivers/of/platform.c     |  3 ---
>  include/linux/of.h        | 25 +++++++++++++++----------
>  6 files changed, 55 insertions(+), 18 deletions(-)
>  create mode 100644 drivers/of/empty_root.dts
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index da9826accb1b..d738fbad9c36 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -14,9 +14,8 @@ if OF
>  
>  config OF_UNITTEST
>  	bool "Device Tree runtime unit tests"
> -	depends on !SPARC
> +	depends on OF_EARLY_FLATTREE
>  	select IRQ_DOMAIN
> -	select OF_EARLY_FLATTREE
>  	select OF_RESOLVE
>  	help
>  	  This option builds in test cases for the device tree infrastructure
> @@ -54,7 +53,7 @@ config OF_FLATTREE
>  	select CRC32
>  
>  config OF_EARLY_FLATTREE
> -	bool
> +	def_bool OF && !(SPARC || ALPHA || HEXAGON || M68K || PARISC || S390)
>  	select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
>  	select OF_FLATTREE
>  
> diff --git a/drivers/of/Makefile b/drivers/of/Makefile
> index eff624854575..df305348d1cb 100644
> --- a/drivers/of/Makefile
> +++ b/drivers/of/Makefile
> @@ -2,7 +2,7 @@
>  obj-y = base.o cpu.o device.o module.o platform.o property.o
>  obj-$(CONFIG_OF_KOBJ) += kobj.o
>  obj-$(CONFIG_OF_DYNAMIC) += dynamic.o
> -obj-$(CONFIG_OF_FLATTREE) += fdt.o
> +obj-$(CONFIG_OF_FLATTREE) += fdt.o empty_root.dtb.o
>  obj-$(CONFIG_OF_EARLY_FLATTREE) += fdt_address.o
>  obj-$(CONFIG_OF_PROMTREE) += pdt.o
>  obj-$(CONFIG_OF_ADDRESS)  += address.o
> diff --git a/drivers/of/empty_root.dts b/drivers/of/empty_root.dts
> new file mode 100644
> index 000000000000..cf9e97a60f48
> --- /dev/null
> +++ b/drivers/of/empty_root.dts
> @@ -0,0 +1,6 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/dts-v1/;
> +
> +/ {
> +
> +};
> diff --git a/drivers/of/fdt.c b/drivers/of/fdt.c
> index dfeba8b8ce94..e5a385285149 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -8,6 +8,7 @@
>  
>  #define pr_fmt(fmt)	"OF: fdt: " fmt
>  
> +#include <linux/acpi.h>
>  #include <linux/crash_dump.h>
>  #include <linux/crc32.h>
>  #include <linux/kernel.h>
> @@ -32,6 +33,13 @@
>  
>  #include "of_private.h"
>  
> +/*
> + * __dtb_empty_root_begin[] and __dtb_empty_root_end[] magically created by
> + * cmd_dt_S_dtb in scripts/Makefile.lib
> + */
> +extern uint8_t __dtb_empty_root_begin[];
> +extern uint8_t __dtb_empty_root_end[];
> +
>  /*
>   * of_fdt_limit_memory - limit the number of regions in the /memory node
>   * @limit: maximum entries
> @@ -1343,7 +1351,29 @@ static void *__init copy_device_tree(void *fdt)
>   */
>  void __init unflatten_device_tree(void)
>  {
> -	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
> +	void *fdt = initial_boot_params;
> +
> +	/* Don't use the bootloader provided DTB if ACPI is enabled */
> +	if (!acpi_disabled)
> +		fdt = NULL;
> +
> +	/*
> +	 * Populate an empty root node when ACPI is enabled or bootloader
> +	 * doesn't provide one.
> +	 */
> +	if (!fdt) {
> +		fdt = (void *) __dtb_empty_root_begin;
> +		/* fdt_totalsize() will be used for copy size */
> +		if (fdt_totalsize(fdt) >
> +		    __dtb_empty_root_end - __dtb_empty_root_begin) {
> +			pr_err("invalid size in dtb_empty_root\n");
> +			return;
> +		}
> +		of_fdt_crc32 = crc32_be(~0, fdt, fdt_totalsize(fdt));
> +		fdt = copy_device_tree(fdt);
> +	}
> +
> +	__unflatten_device_tree(fdt, NULL, &of_root,
>  				early_init_dt_alloc_memory_arch, false);
>  
>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index b7708a06dc78..39c0ceee3e95 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -510,9 +510,6 @@ static int __init of_platform_default_populate_init(void)
>  
>  	device_links_supplier_sync_state_pause();
>  
> -	if (!of_have_populated_dt())
> -		return -ENODEV;
> -
>  	if (IS_ENABLED(CONFIG_PPC)) {
>  		struct device_node *boot_display = NULL;
>  		struct platform_device *dev;
> diff --git a/include/linux/of.h b/include/linux/of.h
> index 331e05918f11..168357486260 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -180,11 +180,6 @@ static inline bool is_of_node(const struct fwnode_handle *fwnode)
>  			&__of_fwnode_handle_node->fwnode : NULL;	\
>  	})
>  
> -static inline bool of_have_populated_dt(void)
> -{
> -	return of_root != NULL;
> -}
> -
>  static inline bool of_node_is_root(const struct device_node *node)
>  {
>  	return node && (node->parent == NULL);
> @@ -557,11 +552,6 @@ static inline struct device_node *of_find_node_with_property(
>  
>  #define of_fwnode_handle(node) NULL
>  
> -static inline bool of_have_populated_dt(void)
> -{
> -	return false;
> -}
> -
>  static inline struct device_node *of_get_compatible_child(const struct device_node *parent,
>  					const char *compatible)
>  {
> @@ -1645,6 +1635,21 @@ static inline bool of_device_is_system_power_controller(const struct device_node
>  	return of_property_read_bool(np, "system-power-controller");
>  }
>  
> +/**
> + * of_have_populated_dt() - Has DT been populated by bootloader
> + *
> + * Return: True if a DTB has been populated by the bootloader and it isn't the
> + * empty builtin one. False otherwise.
> + */
> +static inline bool of_have_populated_dt(void)
> +{
> +#ifdef CONFIG_OF
> +	return of_property_present(of_root, "compatible");

This adds the strict check for compatible which makes compatible
to be mandatory for root nodes. So far, DeviceTree without compatible
property in root nodes can work. Do we want to make this documented
somewhere ?

- Saurabh

> +#else
> +	return false;
> +#endif
> +}
> +
>  /*
>   * Overlay support
>   */
> -- 
> 2.34.1

