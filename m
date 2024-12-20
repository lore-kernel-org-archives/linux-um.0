Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20272E7718C
	for <linux-um@archiver.kernel.org>; Fri, 20 Dec 2024 14:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tOIKmNQEMGn9hjJIR0rcaMsoO1iRnTK3X02bB4ePQuA=; b=WUP6OzH2Q+TTWjFQKf2fsHT+6h
	sSqGGuoe3xCAXsTe6eR+gT3SNfseOj3Jk3lHMzJcmLDlZo1w3LxnBwdx5ih6EGOBlGAX2ZoaPnVuh
	Br0Jyi3+qw2pMc2DE41VaeXPY9zq1QRU52hHeLEUzvdtBFlNiATP2HDEv5AjSkuQcljma5SQcNJfL
	5X5myqcdYNHlUHthXuqgKNnk6ldMrduiZQyb96n0UiWwGHVmGHfIYKhXK+TS0ykPw2/LGhQz66os4
	OQT/BRmFOqW9dHjZSIdMFgrREN899PfQzoutxz26GgF0xoAu+U1cFWJNYGKRTGJBI8U79qjLDlJOa
	+qVnSXOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOdgO-0000000569c-1rnb;
	Fri, 20 Dec 2024 14:08:48 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOdOc-000000053BE-3lFF;
	Fri, 20 Dec 2024 13:50:28 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4E7851480;
	Fri, 20 Dec 2024 05:50:53 -0800 (PST)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BF2793F720;
	Fri, 20 Dec 2024 05:50:19 -0800 (PST)
Message-ID: <2f65f93e-9d44-4acc-b63c-8f5a35f59699@arm.com>
Date: Fri, 20 Dec 2024 14:50:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-2-kevin.brodsky@arm.com>
 <20241219171920.GB26279@noisy.programming.kicks-ass.net>
 <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
 <0daabd32-cba4-4345-baa8-e8c66bc899ff@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <0daabd32-cba4-4345-baa8-e8c66bc899ff@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_055027_022512_22F03776 
X-CRM114-Status: GOOD (  16.88  )
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

On 20/12/2024 12:46, Qi Zheng wrote:
> Hi Kevin,
>
> On 2024/12/20 18:49, Kevin Brodsky wrote:
>> [...]
>>
>> Qi, shall we collaborate to make our series complementary? I believe my
>> series covers patch 2 and 4 of your series, but it goes further by
>> covering all levels and all architectures, and patches introducing
>> ctor/dtor are already split as Alexander suggested on your series. So my
>> suggestion would be:
>>
>> * Remove patch 1 in my series - I'd just introduce
>> pagetable_{p4d,pgd}_[cd]tor with the same implementation as
>> pagetable_pud_[cd]tor.
>> * Remove patch 2 and 4 from your series and rebase it on mine.
>
> I quickly went through your patch series. It looks like my patch 2 and
> your patch 6 are duplicated, so you want me to remove my patch 2.
>
> But I think you may not be able to simple let arm64, riscv and x86 to
> use generic p4d_{alloc_one,free}(). Because even if
> CONFIG_PGTABLE_LEVELS > 4, the pgtable_l5_enabled() may not be true.
>
> For example, in arm64:
>
> #if CONFIG_PGTABLE_LEVELS > 4
>
> static __always_inline bool pgtable_l5_enabled(void)
> {
>     if (!alternative_has_cap_likely(ARM64_ALWAYS_BOOT))
>         return vabits_actual == VA_BITS;
>     return alternative_has_cap_unlikely(ARM64_HAS_VA52);
> }

Correct. That's why the implementation of p4d_free() I introduce in
patch 6 checks mm_p4d_folded(), which is implemented as
!pgtable_l5_enabled() on those architectures (see last paragraph in
commit message). In fact it turns out Alexander suggested exactly this
approach [2].

>
> Did I miss something?
>
> My patch series is not only for cleanup, but also for fixes of
> UAF issue [1], so is it possible to rebase your patch series onto
> mine? I can post v3 ASAP.

I see, yours should be merged first then. The issue is that yours would
depend on some of the patches in mine, not the other way round.

My suggestion would then be for you to take patch 5, 6 and 7 from my
series, as they match Alexander's suggestions (and patch 5 is I think a
useful simplification), and replace patch 2 in your series with those. I
would then rebase my series on top and adapt it accordingly. Does that
sound reasonable?

- Kevin

[2]
https://lore.kernel.org/all/Z2RKpdv7pL34MIEt@tuxmaker.boeblingen.de.ibm.com/


