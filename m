Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23634C53219
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 22:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Date:References:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2dECJoqDvj4NsK+08JPKeYoArhUSVLNfBOHa/8BAcXA=; b=LxLMN4pFwtOrX6fvehHiNO10+M
	2B2620LWtfCvCeEM9tJh7IJlJgV81mGy2m50lam5n+vDyKitPmEX78OjAN+gPngffO5DiLS+n+HR6
	SM8kDt+t30Th/RNAOyw7aEQ1nHWygTsaXseBTIGGdh+1yXh55bUg/3Hd8Z+aTiCeUQ6+JtzAvHFaR
	u1l718TsAhk4M4+MzAuCy4cFGDXf9U2xAYvR+DVDdMaixeoWdK5fTfZXOK1cOFoAS4et7Hxs5/yXz
	GwWN9tgKJE9YmnNcVlCQ/HFVhnHsYnTvrMwTfqtt7zGhFDQIlUpinZ66o4mH2er4Mi8PeJCkDYDG4
	LSXOEm0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woqOV-00000006R03-0rv4;
	Tue, 28 Jul 2026 22:35:27 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woqOU-00000006Qzu-20yw
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 22:35:26 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id F41264067E;
	Tue, 28 Jul 2026 22:35:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A9451F00A3A;
	Tue, 28 Jul 2026 22:35:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785278125;
	bh=2dECJoqDvj4NsK+08JPKeYoArhUSVLNfBOHa/8BAcXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date;
	b=Whqt1K+/CUV9Mh3XC8eca+9SCZtLe5sElQd/5GbDmVQ2zsVeg0iTsWidtKNnQqTm9
	 46+mFHOEJz9FrrejwzX9WRD8JHEpHjyihMxqomzDT9E5h5NO0TyfFTP2P7fAJyrjYr
	 QuZRtXFwYggWUie3bmocmDlk5UFcWRMM5uGu1OFWTgHLutyctbDC3Nh5Rhc544TAwo
	 CGtTryd+B+4TJpt+S0haGPy0MKEmm6t0yCKkcBylRKdZ1jsIx09eR9iBtMp81FOxIe
	 ytuTvAdtUFW3VxHThpyr2OrdS9TddcxTIq0LTLmZ6YW7Sa0Fj85Fknu40rnKYipvBB
	 UJB3luW1/DNrQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Eric Biggers <ebiggers@kernel.org>, x86@kernel.org
Cc: linux-um@lists.infradead.org, linux-raid@vger.kernel.org,
 linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org, Christoph
 Hellwig <hch@lst.de>, Andrew Morton <akpm@linux-foundation.org>, Eric
 Biggers <ebiggers@kernel.org>
Subject: Re: [PATCH v2 1/8] x86/fpu: Check for missing AVX and AVX-512
 xstate bits
In-Reply-To: <20260728021603.79870-2-ebiggers@kernel.org>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-2-ebiggers@kernel.org>
Date: Wed, 29 Jul 2026 00:35:22 +0200
Message-ID: <87fr12hhed.ffs@fw13>
MIME-Version: 1.0
Content-Type: text/plain
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

On Mon, Jul 27 2026 at 19:15, Eric Biggers wrote:
> If the CPU declares AVX or AVX-512 support, verify that the
> corresponding xstate bits are also set.  If not, warn and clear them.

That's clearly a firmware bug which has to be treated as all other
inconsistencies of that sort.

> This eliminates the perceived need for AVX and AVX-512 optimized code in
> the kernel to call cpu_has_xfeatures().  That has never been universally
> done, which strongly suggests that it has never really been needed in
> practice, but this should remove any remaining doubt.

Indeed it is inconsistent all over the place. While looking at the
follow up patches I wondered how many of these remaining nested
conditions are redundant. Most of them should be covered by the
dependency checks. If they are not, then we should add them.

> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  arch/x86/kernel/fpu/xstate.c | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
>
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index a7b6524a9dea2..904ff933c0d88 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -799,6 +799,23 @@ static u64 __init guest_default_mask(void)
>  	return ~(u64)XFEATURE_MASK_USER_DYNAMIC;
>  }
>  
> +/* Clear any X86_FEATURE_* used by the kernel whose xfeatures are missing. */
> +static void __init clear_cpu_caps_with_missing_xfeatures(u64 xfeatures)
> +{
> +	u64 mask;
> +
> +	mask = XFEATURE_MASK_FPSSE | XFEATURE_MASK_YMM;
> +	if (boot_cpu_has(X86_FEATURE_AVX) && (xfeatures & mask) != mask) {
> +		pr_err("x86/fpu: Disabling AVX support due to missing xstate features\n");

Please make these

       pr_err(FW_BUG "...")

As that's what it is.

Thanks,

        tglx

