Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F630C54F4C
	for <linux-um@archiver.kernel.org>; Tue, 28 Jul 2026 05:28:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Ye00Is7jPU4U0jDzcsMnYl+RHWorHWwYka8gPhzGHOQ=; b=mAnsp4yrtmarWqoaJa7cAYbQxF
	eKzEojaHh5XQOPkHRqizxe8UwKHY9Bkuz8Q9vTythe9MfydL6iZyf35Ck9v7qZ+lbLHIljaVLKg0N
	Qt0b4Lodi6p5sanVOHoK0U9m3luqltDfYfb+FFDBKF3zmYZbnAlny13jwfLwOQNXjzlNEv7yftJE6
	BiKfokAxDicRQ1uUu71yjddYUrxGsHgeyxflraBgdfGbrKekaAcsxEePrGwpprfAmAEeehAaKkO5r
	G+uqU6XO9r0aoKzSqhwgjflfEvELwchrPdowzWQ4k/IXiW26uqyBxWCeHBtUlf0yM5By9uJjkOTTy
	YmOTRyDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woaMK-00000004SAo-41wv;
	Tue, 28 Jul 2026 05:28:08 +0000
Received: from mail.alien8.de ([65.109.113.108])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woaMH-00000004RxV-49TM
	for linux-um@lists.infradead.org;
	Tue, 28 Jul 2026 05:28:07 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 6690040E00E6;
	Tue, 28 Jul 2026 05:27:49 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id gO_J86D_jvoF; Tue, 28 Jul 2026 05:27:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785216459; bh=Ye00Is7jPU4U0jDzcsMnYl+RHWorHWwYka8gPhzGHOQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AyyTuZQrx5IcYQCDjniH3kzH0vwKAOiL/tVXEx84TG/Z0mZ1S5KEwbp80u+7+YMMq
	 BjzkQZKQ0kHnpHlhiY16/mTkjQtr39XSv69UHewj6U91QfgE/W8YaZJG7gauAYkbhm
	 HCx8I14DeBgZVeDMTL91bJEzSMlbygzEaesrI3+a7Oyyv71xUCtBiN2G0zvqCKFN/y
	 kHtwKRf0tqW7XAHBwmx3yGL+ioa6oDVhGxvNvms9RNowm0xtyBA/I+iKhg2H1J7iEz
	 nzZjVJhkwODyLOt4eGIVjcfXtIhJOLDwWk7tnE1v6mQrnDD8ZVwQj/QAyelbJEQMcv
	 +cMk1Iy7NttH8VPtwsRt7yCDX38H89zjWYOC4GLDNRS6mJun5zwMxgzAcyLzEEUK5Y
	 ZsADSOkyVS5gJWax2NpI/7hdV4wGcZQFXMQq+Oqnm2x8hDKx4xYNmzjeO0bGnVrmqp
	 qmibKljeOWS+yj6KElQTuhgKTaNEfR3trcQN3ztPPiZgmFShav4JwVLGM/iphcOIQC
	 2AWDUBcew+m8iv/OzlBb4U6DMHgtkNdicJuvC4o2u6GijfQuQcXvFN2YFgsxeaOD0+
	 DH7hyqrl4g7BbcHCxzljFE3k9u8A5DP2TruKoXaC0a//LCEiuaxg5I8fx1F3OhdYM0
	 2pbuPmSv2WEUHoEJi5GnbIio=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::43])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id C200140E00C4;
	Tue, 28 Jul 2026 05:27:30 +0000 (UTC)
Date: Mon, 27 Jul 2026 22:27:27 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v2 1/8] x86/fpu: Check for missing AVX and AVX-512 xstate
 bits
Message-ID: <20260728052727.GCamg9v5WxNieTMUwE@fat_crate.local>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-2-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728021603.79870-2-ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_222806_184961_5CDE8C71 
X-CRM114-Status: GOOD (  24.17  )
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

On Mon, Jul 27, 2026 at 07:15:56PM -0700, Eric Biggers wrote:
> If the CPU declares AVX or AVX-512 support, verify that the
> corresponding xstate bits are also set.  If not, warn and clear them.
> 
> This eliminates the perceived need for AVX and AVX-512 optimized code in

s/This eliminates/Eliminate/

> the kernel to call cpu_has_xfeatures().  That has never been universally
> done, which strongly suggests that it has never really been needed in
> practice, but this should remove any remaining doubt.
> 
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

That function name is a bit too long. How about:

clear_cpu_caps_xft()

or so.

> +{
> +	u64 mask;
> +
> +	mask = XFEATURE_MASK_FPSSE | XFEATURE_MASK_YMM;
> +	if (boot_cpu_has(X86_FEATURE_AVX) && (xfeatures & mask) != mask) {
> +		pr_err("x86/fpu: Disabling AVX support due to missing xstate features\n");
> +		setup_clear_cpu_cap(X86_FEATURE_AVX);
> +	}
> +	mask = XFEATURE_MASK_FPSSE | XFEATURE_MASK_YMM | XFEATURE_MASK_AVX512;
> +	if (boot_cpu_has(X86_FEATURE_AVX512F) && (xfeatures & mask) != mask) {
> +		pr_err("x86/fpu: Disabling AVX-512 support due to missing xstate features\n");
> +		setup_clear_cpu_cap(X86_FEATURE_AVX512F);
> +	}
> +}
> +
>  /*
>   * Enable and initialize the xsave feature.
>   * Called once per system bootup.
> @@ -812,12 +829,14 @@ void __init fpu__init_system_xstate(unsigned int legacy_size)
>  
>  	if (!boot_cpu_has(X86_FEATURE_FPU)) {
>  		pr_info("x86/fpu: No FPU detected\n");
> +		clear_cpu_caps_with_missing_xfeatures(0);
>  		return;
>  	}
>  
>  	if (!boot_cpu_has(X86_FEATURE_XSAVE)) {
>  		pr_info("x86/fpu: x87 FPU will use %s\n",
>  			boot_cpu_has(X86_FEATURE_FXSR) ? "FXSAVE" : "FSAVE");
> +		clear_cpu_caps_with_missing_xfeatures(0);

Also, I'm not really clear on the usage here: if the CPU doesn't have FPU or
XSAVE, we pass in xfeature 0 which is XFEATURE_FP in both cases. And then we
clear AVX and AVX-512.

The 0 is basically forcing the checks in the function to match, i.e., it looks
to me like we're defining a new interface but then we're misusing it so that
those basic CPU flags are cleared.

What are we even protecting against here?

AVX and AVX-512 code needs to check whether it has FPU and XSAVE support?

I.e., we're protecting against some weird guests?

I wanna say, we should not protect but let them crash'n'burn in big big flames
which can be seen from a mile away.

Or do you have a sensible use case in mind which we really wanna protect
against and this all actually makes sense?

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

