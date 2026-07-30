Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EDE89C5516D
	for <linux-um@archiver.kernel.org>; Thu, 30 Jul 2026 23:07:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YodGI8Uo9Mf0qUG367VMmipBlJYI9zYdoawBldpOADg=; b=g9ZHkGLxHwHq+hbT2cFcDz6xj6
	FKBveyx/ptsRlxKDqfEY3U783r/lWNjqV4ZWT2fIx6JdA7BnGFWNEWu82sGXMv6Dm6+9tVdeLUVfn
	gZORd6FTN6DIXyeYczXxWSscq8uNR+FZPBoaJ3izQARKHLR7vI1/InQCo1QWanM1W8fUoCCi6NJoR
	gGKSbJe9N91OQoe2wIuURbrJI/l6SO0mO6a5rEOJsn4QsQQWAbAitwPZTadV1kA5f3WfbiaF/YAch
	7ICuWrzLPVRpDl5jr/X2fHN1C5bf/CAMVUut4DGcbzMJKIVKDqsm6eOTYLI8h4NbtDnrfKhhb43b5
	qWWGKQrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpZqW-0000000BT23-3aQH;
	Thu, 30 Jul 2026 23:07:24 +0000
Received: from mail.alien8.de ([2a01:4f9:3051:3f93::2])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wpZqR-0000000BSzd-2Woo
	for linux-um@lists.infradead.org;
	Thu, 30 Jul 2026 23:07:23 +0000
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 4060B40E014C;
	Thu, 30 Jul 2026 23:07:04 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id EXY0n7lmqV1E; Thu, 30 Jul 2026 23:06:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1785452812; bh=YodGI8Uo9Mf0qUG367VMmipBlJYI9zYdoawBldpOADg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=My/0Ue3slwON/tIdXcj0IVDWf1LhcoJ1NhUAA2l4wGki5k2IlkM4VrXZhdUtvBVcY
	 Sqy0il+XL+MEtdWN4Cpk8pRmJpIt1xVoBrYNhzAwIheCEHBWon7EwRFCNsB0yFLZd9
	 09ptmod7IHp+LN5YRoMnMdyFMv3nP4pL1akGgDdQLOmrp+W+FeWAxE2eHEJpgx4pLY
	 L0WWIn+9f2860RI2d6Lu3dgSgJRwf6l5/vJbe7e3vDINt78Mv7ZU0VQcq/UgqsUjLm
	 KAMPUEg4kZpWVRh7CqllZ5rFN2dTnWgx8wV21BV++kAw6odQIdpf8hVvAd2ph0ukme
	 FYDgNYWVzL28E3Ryeao8llMrC3EZgW9acDxlwXSZl/dC5HQZzs1Hfr2g4kngFzx7+/
	 dgSvBb5d5KOrFg3cgTC8qPAvX7gLgFgNIRxARPpLKKNnih9NL0b5t1SjXwP4+PcTAZ
	 orvDv6m5ea1+bRcaRGq2KgtCKzbGGBX8iTQHhuVlYORC+9LfxWexcOtH6KzSN7EVza
	 hkKE852vZLgX0UvZ5aotmSBwexMw85ghgH1R1DX48gjZNaxrkVOwionhvlDrkrBvwu
	 nIxhNFPnZ4o4b1DZjMvyMLFnxzjwy7hPE/ait0Mbm3eNWvMsU8HqGxsWt/t8uMbcTq
	 SJDU+ALaiLl8otfaX3a1HB6o=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::1b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 21DB540E00C4;
	Thu, 30 Jul 2026 23:06:40 +0000 (UTC)
Date: Thu, 30 Jul 2026 16:06:37 -0700
From: Borislav Petkov <bp@alien8.de>
To: Eric Biggers <ebiggers@kernel.org>
Cc: x86@kernel.org, linux-um@lists.infradead.org,
	linux-raid@vger.kernel.org, linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [PATCH v2 2/8] um: Check for missing AVX and AVX-512 xstate bits
Message-ID: <20260730230637.GKamvY_aj0Uxn8Dshs@fat_crate.local>
References: <20260728021603.79870-1-ebiggers@kernel.org>
 <20260728021603.79870-3-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260728021603.79870-3-ebiggers@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260730_160719_806480_12E60E53 
X-CRM114-Status: GOOD (  22.23  )
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

On Mon, Jul 27, 2026 at 07:15:57PM -0700, Eric Biggers wrote:
> If the CPU declares AVX or AVX-512 support, verify that all the
> corresponding bits are set in the XCR0 register.  If any are missing,
> warn and don't set the corresponding X86_FEATURE_* flags.
> 
> This eliminates the perceived need for UML-supporting AVX and AVX-512
> optimized code in the kernel (that is, lib/raid/ currently) to start
> checking the XCR0 bits in addition to X86_FEATURE_AVX*.
> 
> This aligns UML with the vast majority of userspace programs, which
> check the XCR0 bits before considering AVX and AVX-512 to be supported,
> as per the procedure documented in Intel's CPU manual.
> 
> Signed-off-by: Eric Biggers <ebiggers@kernel.org>
> ---
>  arch/um/kernel/um_arch.c | 78 +++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 1 deletion(-)

./scripts/get_maintainer.pl -f arch/um/kernel/um_arch.c
Richard Weinberger <richard@nod.at> (maintainer:USER-MODE LINUX (UML))
Anton Ivanov <anton.ivanov@cambridgegreys.com> (maintainer:USER-MODE LINUX (UML))
Johannes Berg <johannes@sipsolutions.net> (maintainer:USER-MODE LINUX (UML),commit_signer:8/10=80%,authored:1/10=10%,removed_lines:2/40=5%)
...

Please use that script. CCed now.

> diff --git a/arch/um/kernel/um_arch.c b/arch/um/kernel/um_arch.c
> index 2141f5f1f5a20..aafbaef2ae82f 100644
> --- a/arch/um/kernel/um_arch.c
> +++ b/arch/um/kernel/um_arch.c
> @@ -264,12 +264,88 @@ unsigned long brk_start;
>  
>  #define MIN_VMALLOC (32 * 1024 * 1024)
>  
> +static u64 __init read_xcr0(void)
> +{
> +	u32 a, b, c, d;
> +
> +	asm volatile("cpuid"
> +		     : "=a"(a), "=b"(b), "=c"(c), "=d"(d)
> +		     : "a"(0), "c"(0));
> +	if (a >= 1) { /* max_leaf >= 1 */
> +		asm volatile("cpuid"
> +			     : "=a"(a), "=b"(b), "=c"(c), "=d"(d)
> +			     : "a"(1), "c"(0));
> +		if (c & (1 << 27)) { /* XSAVE enabled by OS */
> +			asm volatile("xgetbv" : "=d"(d), "=a"(a) : "c"(0));
> +			return ((u64)d << 32) | a;
> +		}
> +	}

I don't know - I probably would pull in some helpers for cpuid and xgetbv
instead of doing this ad-hoc. UML maintainers' call.

> +	return 0;
> +}

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

