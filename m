Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35252C3DA79
	for <linux-um@archiver.kernel.org>; Mon, 15 Jan 2024 17:57:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/1nw2uXWDl1a0Y8x/WBBs08kxcDRyDODFBsQ8376Ju8=; b=YLsO+vQSnYRcH6v62EX9dwHPEJ
	VJZjZfeMyYZUZDIWhGnAjMTh/m65TKzIgxsIPgEKgvtO2MmViKPnOGlY3DHlcAFAGw/5MPe8meWHC
	U8gY9ZUjo9DxKDzpA/fZ492p1sQeG6I3bHXo93nYtDyD5hSWa7Hy/vR/s0KMFUB2JCuP5XB27krUM
	XScAcX1JP/tGDN16niEhoojQnS2db/8AWzMPYV4+K7Hg/VDb7cdfMILU9lLZeBkEwyfLQDl193YIY
	QhGNn5vu98oR+MatH/9YQ/eZcQwdf20hDgH+7LB+Bt8eudwZoVPzVj18+feM5NAwV+IHChdneAC9s
	HbpMJU6Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rPRDE-009rTC-10;
	Mon, 15 Jan 2024 17:57:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rPRDA-009rRI-01;
	Mon, 15 Jan 2024 17:57:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7B7CC60FAB;
	Mon, 15 Jan 2024 17:57:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E7B96C433C7;
	Mon, 15 Jan 2024 17:57:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705341443;
	bh=thBhnHt9jZFGQePPNqkyQjdjPMKZmxdsMlzWKPj8+Jc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=p35Gl/yrY53OdCBI06PlYbOCPu8PAdffbIyGPu1B+JJ8LCI4uLoO8zCBoPhEbZDLS
	 2IuoXD/t8k77ozhb8mPOLhbNFyEP4GY8mx1XWU4y7yBIbDXxNC5TLZcXn4YQydXZb+
	 ihr5kYCGinap2g3Ra56/Q9Wdrh9KoWNBTljTqqTGVPXMUstYfVTqYHhmmbvqbuBaqQ
	 R0D0wrr1HgN2cQjEjJrRRpn7IK2XvNg/wtd9MvHtZWsxwRCZJ8BWJdfLf157zF8Ife
	 iEtCOl9+pCW2cWVL5OumkEzSAdDC5KxaFB7NfQJIEp+JhKI5bT6ZCPEyvbkuFrYfyK
	 obT1KF8SeUyhQ==
Date: Mon, 15 Jan 2024 11:57:20 -0600
From: Rob Herring <robh@kernel.org>
To: Stephen Boyd <sboyd@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	kunit-dev@googlegroups.com, linux-kselftest@vger.kernel.org,
	devicetree@vger.kernel.org, Frank Rowand <frowand.list@gmail.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>
Subject: Re: [PATCH 1/6] arm64: Unconditionally call unflatten_device_tree()
Message-ID: <20240115175720.GA1017185-robh@kernel.org>
References: <20240112200750.4062441-1-sboyd@kernel.org>
 <20240112200750.4062441-2-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240112200750.4062441-2-sboyd@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240115_095724_120344_FD7C7157 
X-CRM114-Status: GOOD (  17.05  )
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

On Fri, Jan 12, 2024 at 12:07:44PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> There's no harm in calling unflatten_device_tree() unconditionally. If
> there isn't a valid initial_boot_params dtb then unflatten_device_tree()
> returns early.

There's always a valid DTB because that's the boot params even for ACPI 
systems. This does also create a userspace visible change that 
/proc/device-tree will be populated. I don't see an issue with that.

There was worry when ACPI was added that systems would pass both DT and 
ACPI tables and that the kernel must only use ACPI. That was more to 
force ACPI adoption, but I'm not sure if that actually exists in any 
early system. I think we're past forcing adoption now.

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

