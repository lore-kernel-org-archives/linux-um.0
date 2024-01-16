Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14808C4706C
	for <linux-um@archiver.kernel.org>; Tue, 16 Jan 2024 11:51:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NauUEfz2pO3mejpNkHDKuvbNLXuZ7XAFMAu6fTkOYgs=; b=tiLCLJSs7a9GSIDNNzl7HWdRiP
	iRcAGpKpi2lRNS7CBOfn/Y5CCTZ/tGsvrzWQo5TbRD9/s4aglHSMoQKhaed7AZfxoR8Ff5YT5ZWqO
	hFVTe6GvQfCQLVTGnYe/LAKICNaYKg1XUr76Jq0yXAjwHK+pR9wykJEtSvRYFKyBg80hG6aXF7k+E
	l8GVCK/Nw+aUOeaEQRa/KGyY6Gk35nqlRCu+VjBLY7EBagAuShkhg76FDvCcje6LiFuaMLqoQ5Gr1
	lSiJOsjb7P809EOFxDV3U39u1Q2LrsXvOfTGzG/k6ZCeNxB5mJ5UWbDMNTD/uW704le7pMqgxWoDv
	ZhiIgPwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPhyc-00C015-2H;
	Tue, 16 Jan 2024 11:51:30 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPhyZ-00Bzyw-1w;
	Tue, 16 Jan 2024 11:51:29 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5BD412F4;
	Tue, 16 Jan 2024 03:52:10 -0800 (PST)
Received: from FVFF77S0Q05N (unknown [10.57.90.186])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 50E793F5A1;
	Tue, 16 Jan 2024 03:51:20 -0800 (PST)
Date: Tue, 16 Jan 2024 11:51:14 +0000
From: Mark Rutland <mark.rutland@arm.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <ZaZtbU9hre3YhZam@FVFF77S0Q05N>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112200750.4062441-2-sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240116_035127_796909_B09559D8 
X-CRM114-Status: GOOD (  18.04  )
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

Hi Stephen,

On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> There's no harm in calling unflatten_device_tree() unconditionally.

For better or worse, that's not true: there are systems the provide both a DTB
*and* ACPI tables, and we must not consume both at the same time as those can
clash and cause all sorts of problems. In addition, we don't want people being
"clever" and describing disparate portions of their system in ACPI and DT.

It is a very deliberate choice to not unflatten the DTB when ACPI is in use,
and I don't think we want to reopen this can of worms.

Given that, I'm afraid I must NAK this patch.

Thanks
Mark.

> If there isn't a valid initial_boot_params dtb then unflatten_device_tree()
> returns early.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/arm64/kernel/setup.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..ede3d59dabf0 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -351,8 +351,7 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> -	if (acpi_disabled)
> -		unflatten_device_tree();
> +	unflatten_device_tree();
>  
>  	bootmem_init();
>  
> -- 
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git
> 
> 

