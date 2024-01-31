Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85297C47258
	for <linux-um@archiver.kernel.org>; Wed, 31 Jan 2024 20:54:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=onKNDUWoZ1uk24G1Nf4vEV2QBZNSo0HPXmplbIR0GvQ=; b=sYIpTOh3/ygSugjBcVcIyTMBw4
	qe/3ArWIxsVH4uNj5VDwfUiyunvRU0VJqgKBCNn/eaJKZbR6DzQffJqQ0D/rmXPrh62OGplfF8n4Y
	Jiw84YzISmmh8/07e+QNC029YrmxYsKvjcVAidEWRSRo5Tbd3cFa+QbzGJ0AenQ8z4Hy79oRI5tQN
	m5PAp5tPZdkSXa5cxNA8WSqtKnrr7g9v99SDG0fPHlJzoHSL6zCCzYdNOau5MX7EcDatxhBCbVVWP
	zh5vCcuwzUo09uDDV/jGlB3NwWxSzpmwAWF2gB6H2kcn7VL+5U0wTK73WakIfO9kBhfxg31V7uV7R
	yXBzgTQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHb2-00000005OrX-40mY;
	Wed, 31 Jan 2024 20:54:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rVHb0-00000005Oql-0VF1;
	Wed, 31 Jan 2024 20:54:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2AE1361922;
	Wed, 31 Jan 2024 20:54:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 975B4C433C7;
	Wed, 31 Jan 2024 20:54:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706734447;
	bh=NpDrXnTuE8BMzuC03lZTD2fYoKrXrjH6wcLbnZRrixs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fYDbUZ2D4G8Ucpq43YFgIGuEfiMThY0LsPeeaIA52P88VbtH57oOMWzfuAtcjXfyr
	 BvjfU0FPX2PFTFQ5ylkvicZKJpXTsJcHF4l7uCwD70Jt+FmQdvdbPh8thxozH/Df6+
	 DIu8J/ooOROKIFpDTTlGy4iVIUzpqRxBrXMypwJuThQYxHSWMREGldwbVtHzrNUItT
	 wjd1GQ3iD/iNwz5msHrGcEtI14au9Ofef5iAEYLPGiJ/S0wiAJhsx5RqquVNC1nYqB
	 ewnoD2OrhPprAKwbYEciNYM8dNFv7rrCY9DT2Z01o5wjc3QQAvxOggMJUDJmwUVJ+S
	 XEBuwdouJOlMA==
Date: Wed, 31 Jan 2024 14:54:05 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH v2 1/7] arm64: Unconditionally call
 unflatten_device_tree()
Message-ID: <20240131205405.GA2249327-robh@kernel.org>
References: <20240130004508.1700335-1-sboyd@kernel.org>
 <20240130004508.1700335-2-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130004508.1700335-2-sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240131_125410_336448_790BA852 
X-CRM114-Status: GOOD (  22.52  )
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

On Mon, Jan 29, 2024 at 04:45:00PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> Override 'initial_boot_params' to NULL when ACPI is in use but the
> bootloader has loaded a DTB so that we don't allow both ACPI and DT to
> be used during boot. If there isn't a valid initial_boot_params dtb then
> unflatten_device_tree() returns early so this is fine.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com>
> Cc: <linux-arm-kernel@lists.infradead.org>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/arm64/kernel/setup.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/kernel/setup.c b/arch/arm64/kernel/setup.c
> index 417a8a86b2db..ffb1942724ae 100644
> --- a/arch/arm64/kernel/setup.c
> +++ b/arch/arm64/kernel/setup.c
> @@ -351,8 +351,11 @@ void __init __no_sanitize_address setup_arch(char **cmdline_p)
>  	/* Parse the ACPI tables for possible boot-time configuration */
>  	acpi_boot_table_init();
>  
> -	if (acpi_disabled)
> -		unflatten_device_tree();
> +	/* Don't use the FDT from boot if ACPI is in use */
> +	if (!acpi_disabled)
> +		initial_boot_params = NULL;

I still think this is a problem for kexec. See 
of_kexec_alloc_and_setup_fdt(). You see it uses initial_boot_params. At 
first glance it looks like it would just write out everything we need. 
But for UEFI boot, I think we need all the chosen properties like 
linux,uefi-mmap-start preserved from the current boot for the next 
kernel we kexec.

I think you'll have to check acpi_disabled in unflatten_device_tree() 
and unflatten the empty tree leaving initial_boot_params alone. That 
means our FDT and unflattened tree will be different DTs, but I think 
that's fine.

Rob

