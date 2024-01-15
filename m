Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87898C3DA79
	for <linux-um@archiver.kernel.org>; Mon, 15 Jan 2024 20:33:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=10MUXTm5E0823g/MdyxCP+bOmN+hu1CbyjDwNGJLxeA=; b=SAxnQoSHxtygCaYli2tkxhzQ2t
	9EjP4JrEbYs6TzzfzSKlm+B13kzY0tUytEDkJ+yEtbz/7hnJ5FbHu+cwswTsliasVxkUV3CVwRSdV
	gsH99cWQf32tWwav+K8yx6eCnyhbvQNXKLNgPty23PLxdzFj3xoD5HeZ1xEpTjxobwy2fjCuberN8
	5+3l/ha4HGZ1hmahKCqyjLlxOwTIJETdizGIU19UyOYoXCQGQMoP12qAG32ESx96rZxFfH63Os3RE
	mTqZ4Odp5OJV18LIyW4QeiM2yA2AVHUiNC40bSWHLxqPVcTB2cLq6Q1QRCJ6qWN/kb5VtlLA/YFH9
	adRgTA8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPTdu-00A9cG-0B;
	Mon, 15 Jan 2024 20:33:10 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPTdq-00A9aS-0D;
	Mon, 15 Jan 2024 20:33:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1F08660C6C;
	Mon, 15 Jan 2024 20:32:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 874B9C433C7;
	Mon, 15 Jan 2024 20:32:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705350752;
	bh=Nj+5DRK1mAIiOXj9//YfcsT2QRmca2Ur2W3zX//CzEA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=GEYzCBDzsCdWb9gVC8SAxS6/mxihBUtRmfgNAvSz5PViRgINhad5qG2em5naB2kBd
	 AlV/Q7avpsEbvxvTDS4MC4xucx3PXT0DSrBXwbf1PXunjtI3s+OB3WgeXG+hkxZTUp
	 7B0OTUkfQLR+6s1EPfWss4BtO4JNCk6jDp6AiBUG1Oh8LkyvRnUB5r/YdEklvUu5fi
	 fHrP0cVz8bT9R9/XtXTOnTgS3P7mu6C5cyNdtFwI1Oy+zU86AVV8BefZu5qwL/X14E
	 HB/Y8eNRBB/rjgl5loQamQOfPhYY0G/OBMGbtBOYgQCvZu3Eo1d9NYRby4aODAM8fO
	 DbyUGcCgP9TuA==
Date: Mon, 15 Jan 2024 14:32:30 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Frank Rowand <frowand.list@gmail.com>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 4/6] of: Create of_root if no dtb provided by firmware
Message-ID: <20240115203230.GA1439771-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-5-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112200750.4062441-5-sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_123306_197749_E83E35FB 
X-CRM114-Status: GOOD (  38.83  )
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

On Fri, Jan 12, 2024 at 12:07:47PM -0800, Stephen Boyd wrote:
> From: Frank Rowand <frowand.list@gmail.com>
> 
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
> overlays from creating platform devices when the platform bus isn't
> fully initialized.
> 
> Signed-off-by: Frank Rowand <frowand.list@gmail.com>
> Link: https://lore.kernel.org/r/20230317053415.2254616-2-frowand.list@gmail.com
> Cc: Rob Herring <robh+dt@kernel.org>
> [sboyd@kernel.org: Update of_have_populated_dt() to treat this empty dtb
> as not populated. Drop setup_of() initcall]
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  drivers/of/Kconfig        |  7 ++++++-
>  drivers/of/Makefile       |  2 +-
>  drivers/of/empty_root.dts |  6 ++++++
>  drivers/of/fdt.c          | 25 +++++++++++++++++++++++++
>  drivers/of/platform.c     |  3 ---
>  include/linux/of.h        | 17 ++++++++++++-----
>  6 files changed, 50 insertions(+), 10 deletions(-)
>  create mode 100644 drivers/of/empty_root.dts
> 
> diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> index da9826accb1b..9628e48baa15 100644
> --- a/drivers/of/Kconfig
> +++ b/drivers/of/Kconfig
> @@ -54,9 +54,14 @@ config OF_FLATTREE
>  	select CRC32
>  
>  config OF_EARLY_FLATTREE
> -	bool
> +	bool "Functions for accessing Flat Devicetree (FDT) early in boot"

I think we could instead just get rid of this kconfig option. Or 
always enable with CONFIG_OF (except on Sparc). The only cost of 
enabling it is init section functions which get freed anyways.

>  	select DMA_DECLARE_COHERENT if HAS_DMA && HAS_IOMEM
>  	select OF_FLATTREE
> +	help
> +	  Normally selected by platforms that process an FDT that has been
> +	  passed to the kernel by the bootloader.  If the bootloader does not
> +	  pass an FDT to the kernel and you need an empty devicetree that
> +	  contains only a root node to exist, then say Y here.
>  
>  config OF_PROMTREE
>  	bool
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
> index b488ad86d456..9fc7f8b4f48a 100644
> --- a/drivers/of/fdt.c
> +++ b/drivers/of/fdt.c
> @@ -32,6 +32,13 @@
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
> @@ -1343,8 +1350,26 @@ static void __init copy_device_tree(void)
>   */
>  void __init unflatten_device_tree(void)
>  {
> +	bool firmware_loaded = true;
> +
> +	if (!initial_boot_params) {
> +		initial_boot_params = (void *) __dtb_empty_root_begin;
> +		/* fdt_totalsize() will be used for copy size */
> +		if (fdt_totalsize(initial_boot_params) >
> +		    __dtb_empty_root_end - __dtb_empty_root_begin) {
> +			pr_err("invalid size in dtb_empty_root\n");
> +			return;
> +		}
> +		of_fdt_crc32 = crc32_be(~0, initial_boot_params,
> +					fdt_totalsize(initial_boot_params));
> +		copy_device_tree();
> +		firmware_loaded = false;
> +	}
> +
>  	__unflatten_device_tree(initial_boot_params, NULL, &of_root,
>  				early_init_dt_alloc_memory_arch, false);
> +	if (!firmware_loaded)
> +		of_node_set_flag(of_root, OF_EMPTY_ROOT);
>  
>  	/* Get pointer to "/chosen" and "/aliases" nodes for use everywhere */
>  	of_alias_scan(early_init_dt_alloc_memory_arch);
> diff --git a/drivers/of/platform.c b/drivers/of/platform.c
> index 126d265aa7d8..20087bb8a46b 100644
> --- a/drivers/of/platform.c
> +++ b/drivers/of/platform.c
> @@ -549,9 +549,6 @@ static int __init of_platform_default_populate_init(void)
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
> index 6a9ddf20e79a..390ad961ef01 100644
> --- a/include/linux/of.h
> +++ b/include/linux/of.h
> @@ -151,6 +151,7 @@ extern struct device_node *of_stdout;
>  #define OF_POPULATED_BUS	4 /* platform bus created for children */
>  #define OF_OVERLAY		5 /* allocated for an overlay */
>  #define OF_OVERLAY_FREE_CSET	6 /* in overlay cset being freed */
> +#define OF_EMPTY_ROOT		7 /* the builtin empty root node */
>  
>  #define OF_BAD_ADDR	((u64)-1)
>  
> @@ -180,11 +181,6 @@ static inline bool is_of_node(const struct fwnode_handle *fwnode)
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
> @@ -195,6 +191,17 @@ static inline int of_node_check_flag(const struct device_node *n, unsigned long
>  	return test_bit(flag, &n->_flags);
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
> +	return of_root != NULL && !of_node_check_flag(of_root, OF_EMPTY_ROOT);

Just a side comment, but I think many/all callers of this function could 
just be removed.

I don't love new flags. Another possible way to handle this would be 
checking for "compatible" being present in the root node. I guess this 
is fine as-is for now at least.

Rob

