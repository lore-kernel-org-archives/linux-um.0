Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F144CC46CD2
	for <linux-um@archiver.kernel.org>; Tue, 30 Jan 2024 13:30:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZLNex+omPb8kR2FC1v86zHkS3N/7w2iPpa2gpSI68QM=; b=ajEDvJe1AR2sf9rMmLy8A3wj1I
	UagjGTYkdD8J7iilPwEWE99M58J+7SWaZgWE9ifBFVLpCtlnrMC1rsi+i1MJlkZgKM30V3Ecflxfo
	5Nhfo40pZpXQLDowUUYdCKWOgpQV2rhzNGUNDvre0+5HP9N2zaSXVfSBI3Cvx8Ki05uRFdwXaVPTw
	f0e/RLdH+FbbEAQokveV+CflAPowpXQUkxIwC7u8eoorwLFM1/UeudqzMeHJClA1tdBcqQ7QsVPU+
	8zhUtHPJFV4fLiBwbxvuVYjSDwjfcOr6E1L9gGOW+QQOIRJnJVkoole1o9Weulm9rMqk46ad9Q6ph
	uptLhKsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUoCN-0000000Gr3T-0tsb;
	Tue, 30 Jan 2024 13:30:47 +0000
Received: from linux.microsoft.com ([13.77.154.182])
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rUoCJ-0000000Gr2U-1Xep;
	Tue, 30 Jan 2024 13:30:44 +0000
Received: by linux.microsoft.com (Postfix, from userid 1127)
	id CE7A720541E0; Tue, 30 Jan 2024 05:30:39 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE7A720541E0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
	s=default; t=1706621439;
	bh=ZLNex+omPb8kR2FC1v86zHkS3N/7w2iPpa2gpSI68QM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Rbwg8KdwmuF0kHUacib13DpfzInP3vZHX/+hfW09KnFzo6Vlp6zTGDgLeji3qo5wH
	 b4tDmJq1rU3aTjakORccWuLGbjBkX/j2KQ4/5/hmdWBeR27ZNjM9JjRMnVELt7dv5F
	 PFpsMNrlrJPT6b4ufXNLB8DRaNpOLcVTCKPx4XYU=
Date: Tue, 30 Jan 2024 05:30:39 -0800
From: Saurabh Singh Sengar <ssengar@linux.microsoft.com>
To: Stephen Boyd <sboyd@kernel.org>
Cc: Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org,
	patches@lists.linux.dev, linux-um@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, kunit-dev@googlegroups.com,
	linux-kselftest@vger.kernel.org, devicetree@vger.kernel.org,
	Frank Rowand <frowand.list@gmail.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [PATCH v2 3/7] x86/of: Unconditionally call
 unflatten_and_copy_device_tree()
Message-ID: <20240130133039.GA1444@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
References: <20240130004508.1700335-1-sboyd@kernel.org>
 <20240130004508.1700335-4-sboyd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240130004508.1700335-4-sboyd@kernel.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240130_053043_516685_D67BB6DE 
X-CRM114-Status: GOOD (  19.20  )
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

On Mon, Jan 29, 2024 at 04:45:02PM -0800, Stephen Boyd wrote:
> Call this function unconditionally so that we can populate an empty DTB
> on platforms that don't boot with a firmware provided or builtin DTB.
> 
> Cc: Rob Herring <robh+dt@kernel.org>
> Cc: Frank Rowand <frowand.list@gmail.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: <x86@kernel.org>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: Saurabh Sengar <ssengar@linux.microsoft.com>
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>
> ---
>  arch/x86/kernel/devicetree.c | 24 +++++++++++++-----------
>  1 file changed, 13 insertions(+), 11 deletions(-)
> 
> diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
> index afd09924094e..650752d112a6 100644
> --- a/arch/x86/kernel/devicetree.c
> +++ b/arch/x86/kernel/devicetree.c
> @@ -283,22 +283,24 @@ void __init x86_flattree_get_config(void)
>  	u32 size, map_len;
>  	void *dt;
>  
> -	if (!initial_dtb)
> -		return;
> +	if (initial_dtb) {
> +		map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
>  
> -	map_len = max(PAGE_SIZE - (initial_dtb & ~PAGE_MASK), (u64)128);
> +		dt = early_memremap(initial_dtb, map_len);
> +		size = fdt_totalsize(dt);
> +		if (map_len < size) {
> +			early_memunmap(dt, map_len);
> +			dt = early_memremap(initial_dtb, size);
> +			map_len = size;
> +		}
>  
> -	dt = early_memremap(initial_dtb, map_len);
> -	size = fdt_totalsize(dt);
> -	if (map_len < size) {
> -		early_memunmap(dt, map_len);
> -		dt = early_memremap(initial_dtb, size);
> -		map_len = size;
> +		early_init_dt_verify(dt);
>  	}
>  
> -	early_init_dt_verify(dt);
>  	unflatten_and_copy_device_tree();
> -	early_memunmap(dt, map_len);
> +
> +	if (initial_dtb)
> +		early_memunmap(dt, map_len);
>  }
>  #endif
>  
> -- 
> https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
> https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git


Tested the series in Hyper-V environment. Please feel free to add:
Tested-by: Saurabh Sengar <ssengar@linux.microsoft.com>


