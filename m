Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C9A7EEB578
	for <linux-um@archiver.kernel.org>; Thu,  1 Jan 2026 02:07:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UQBF0g7LGMkaWXJONFj1Zzubf3JQP1KLJgb8Ha1McV4=; b=VAKANTQVW3+2dEgOTI0MJFdvlF
	BKO5bfgpwbQgPjuoV92770CTUbBp4KFxznfxqe2+iI/dSt0UOKtfe5aNcDdiTtB5o/zQG8RnmW+zm
	8Eo6OFh+7pt3PolOcR9jrVWFuxUOAzgLkcpTmmtwc6kyH33D35DiAZRErqXxczzNqjUzU4i/cAvs/
	NJZTfu8iNb/Kstc6wVnQNumkJ7KF8tvyfkFNC8gWpq/8YX4W0hgM9X26wSQ5bXfUqyu0B/yi8XUA6
	8d9Gw411/qOrO0zrLl9jFb/biz28MbiOgzvyBa7f+OyLjAgMODpdw6KJ+ZTh5So687rglb0L6WdHZ
	Lw/R3vow==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb85x-00000006W8o-0biu;
	Thu, 01 Jan 2026 02:07:21 +0000
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vb85v-00000006W8I-00JO
	for linux-um@lists.infradead.org;
	Thu, 01 Jan 2026 02:07:20 +0000
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-b7633027cb2so2027782166b.1
        for <linux-um@lists.infradead.org>; Wed, 31 Dec 2025 18:07:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767233237; x=1767838037; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UQBF0g7LGMkaWXJONFj1Zzubf3JQP1KLJgb8Ha1McV4=;
        b=docAJ+2TzoTG9DHmEpfV2WpNaVQFgPxrvqm35TamTCNusnHR+LXh4RcqoU/z4tts1x
         dqy+0Th/UAbXm+C1eLkTFr20HhqRPGqmLeM/+9Xh6eXsWsGTy8bBWUbuL8x0WcIs4XQb
         v8X9mJP1EEeAghrDqxq2/O5dFb+RrG5OD4Hd/uj7PHWZYe5Qlmt3lODC0YMkhhVYfjk4
         CGYEmkTMx7w3eoZZkq/6b+P7bW9fj90rXzk2V5cQc9/Vf0hfENxG8grfJAGpTC6AFU1z
         xlWZ5aRuzD6bLD7R3gyN9x21xSR0uQ0SXXWdTyrP83YKz3G9KwHVEoRk7AdAlCBkkmVq
         W+AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767233237; x=1767838037;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UQBF0g7LGMkaWXJONFj1Zzubf3JQP1KLJgb8Ha1McV4=;
        b=Y0oHkl5MkgNQAsbKyfrUuBWKelZ2K1YANKMyWx/cNueGYC1YEno33CtVtaO/mu6dze
         qU/8WxLtY8Lr+6rnPYLO6raFgmsrUvk58JnRgry3F7qtH21TEayMbp9O/rExOXhTaABB
         gvnuxSn30pNSEcnED9PtdmVL5DN2kT4qlq/iN7X+6ESVtUkjTPEXuoULo2KB3R0i6bkb
         eIKNQfwIv1ORHYKorpntxr2a92u4gRZ3TFQCK66Y1NyCg277GoUtC/r3HnVVRL0Y2fmI
         kOp2N0lfKpXhUi+2obeHw8LDpumMHGlbUOOq3YGVnjtO3v5j37W7kKHfeXHrtvtuoe9E
         i4gQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQVbV7HkkdVCNk83uNM1seVyOf2xqKIq09CMXeL2Q2LN8bmxDFeP/OUBgWhGyklmPBT1Zm1+yH7A==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy5L7PcfGUHzmyn32Zxv6lEhN4n+CUkkCXAgknFK6L9PvdFAReN
	e/NYIMr1ZN7lstDVsNDSbaU5hiG1ZJyyl+ihg4Ghp9f32/jQUuO+6z06
X-Gm-Gg: AY/fxX7xFSZUkcB0jZ/VyGYQrchI/HBW+YbdBp/4xFNDW4D0kiG/HHtD0CEhcos29y1
	ZjclYa9vJzIyh62OeiwJjzXWKQ+IpEZzWzK460pl6oz5pi5ga/o6IJeIYG+GcAOT0prRCo8FXUD
	0UCM/oyBzEDuQ1PiWHcC1HwztVaOxx13evhf9IWrPIoSnxiOEWBCJf5xsOJBlQiw30B1OQue5Ow
	PAjqnCNhQYR2Z5Olnu12xfTZ/6sEYdMn2xzRxwP2wiebbx0OZ8xLm+e/6pKcHDmRKCTQun8ULTn
	Q/8NZgRcoKMAeNLYEc8G8Hu6kA40RaUTHYF26z2yvBiXeHLDo7aL4dRsWezhT0ddCpPYsi9uIaw
	n8uLddLieAhb5kaiNUWWdDxQVG3Pi3FZjMHJYFUwGS4JzfOWDqevk7XdyY0lbz/25FxdcNYwXCE
	K4sT2r2MHanQ==
X-Google-Smtp-Source: AGHT+IGkCnh9dqfLUptvpy4PZGXmScqGnHYP3DGjjwJuJ8br2u0RfwesNHaEMQG1tTnLLwW9sFl6GQ==
X-Received: by 2002:a17:907:7f05:b0:b72:9961:dc04 with SMTP id a640c23a62f3a-b8036f86950mr4237184166b.28.1767233236739;
        Wed, 31 Dec 2025 18:07:16 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-64b910601c7sm39251595a12.14.2025.12.31.18.07.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 31 Dec 2025 18:07:16 -0800 (PST)
Date: Thu, 1 Jan 2026 02:07:15 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: Qi Zheng <qi.zheng@linux.dev>
Cc: Wei Yang <richard.weiyang@gmail.com>, will@kernel.org,
	aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
	dev.jain@arm.com, akpm@linux-foundation.org, david@kernel.org,
	ioworker0@gmail.com, linmag7@gmail.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
Message-ID: <20260101020715.45wqnjgcklvjcth3@master>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
 <20251231094243.zmjs7kgflm7q6k73@master>
 <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_180719_064885_588D3720 
X-CRM114-Status: GOOD (  23.51  )
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
Reply-To: Wei Yang <richard.weiyang@gmail.com>
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Wed, Dec 31, 2025 at 05:52:57PM +0800, Qi Zheng wrote:
>
>
>On 12/31/25 5:42 PM, Wei Yang wrote:
>> On Wed, Dec 17, 2025 at 05:45:48PM +0800, Qi Zheng wrote:
>> > From: Qi Zheng <zhengqi.arch@bytedance.com>
>> > 
>> > The PT_RECLAIM can work on all architectures that support
>> > MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>> > MMU_GATHER_RCU_TABLE_FREE.
>> > 
>> > BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>> > to turn it off.
>> > 
>> > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> > ---
>> > arch/x86/Kconfig | 1 -
>> > mm/Kconfig       | 9 ++-------
>> > 2 files changed, 2 insertions(+), 8 deletions(-)
>> > 
>> > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > index 80527299f859a..0d22da56a71b0 100644
>> > --- a/arch/x86/Kconfig
>> > +++ b/arch/x86/Kconfig
>> > @@ -331,7 +331,6 @@ config X86
>> > 	select FUNCTION_ALIGNMENT_4B
>> > 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>> > 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> > -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>> > 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>> > 	select SCHED_SMT			if SMP
>> > 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>> > diff --git a/mm/Kconfig b/mm/Kconfig
>> > index bd0ea5454af82..fc00b429b7129 100644
>> > --- a/mm/Kconfig
>> > +++ b/mm/Kconfig
>> > @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>> > 	  The architecture has hardware support for userspace shadow call
>> >            stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>> > 
>> > -config ARCH_SUPPORTS_PT_RECLAIM
>> > -	def_bool n
>> > -
>> > config PT_RECLAIM
>> > -	bool "reclaim empty user page table pages"
>> > -	default y
>> > -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> > -	select MMU_GATHER_RCU_TABLE_FREE
>> > +	def_bool y
>> > +	depends on MMU_GATHER_RCU_TABLE_FREE
>> > 	help
>> > 	  Try to reclaim empty user page table pages in paths other than munmap
>> > 	  and exit_mmap path.
>> 
>> Hi, Qi
>> 
>> I am new to PT_RECLAIM, when reading related code I got one question.
>> 
>> Before this patch,  we could have this config combination:
>> 
>>      CONFIG_MMU_GATHER_RCU_TABLE_FREE & !CONFIG_PT_RECLAIM
>> 
>> This means tlb_remove_table_free() is rcu version while tlb_remove_table_one()
>> is semi rcu version.
>> 
>> I am curious could we use rcu version tlb_remove_table_one() for this case?
>> Use rcu version tlb_remove_table_one() if CONFIG_MMU_GATHER_RCU_TABLE_FREE. Is
>> there some limitation here?
>
>I think there's no problem. The rcu version can also ensure that the
>fast GUP works well.
>

Thanks for your quick response :-)

And Happy New Year

So my little suggestion is move the definition of __tlb_remove_table_one()
under CONFIG_MMU_GATHER_RCU_TABLE_FREE. Do you thinks this would be more
clear?

>> 
>> Thanks in advance for your explanation.
>> 
>> 

-- 
Wei Yang
Help you, Help me

