Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7D26D3EE66
	for <linux-um@archiver.kernel.org>; Thu, 22 Jan 2026 14:00:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KXXllTpn+4j3DQ+o0FpmjiZEdWUg34VA5GPm+3TDwac=; b=Wm1f1rLo546godmh4RMHRjfMj9
	oagD+rK+bsdLI5+WZkKeG7HbnjQLyLto1z2G35b0EdtX2iK01V9PjVifr2W6NFyFxN8hovzO8SVUD
	wLV0NdUhx9jN/ZvDDpBETM27NQq4+hFXTvZOmBuzmsKUHpCMTpRPE9jkXexQmJlOluVD9b9wRmdx5
	T5Pyz5QIAmmo+Xv2izrjbCZKP96Gftu7HtFmtezYntb5dRcpRd5mqOjGcMZOj/908F4avsvegMThE
	eGLvI+benUslV9s4G+kN7hA7p8wbByDnpXRE6LnZosFUZ4NfIbKrYyR0Flo4qefsvd5fJ5mzLXArs
	mSK+Ysfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vivEo-00000007CCY-0KOG;
	Thu, 22 Jan 2026 14:00:42 +0000
Received: from mail-ed1-x52f.google.com ([2a00:1450:4864:20::52f])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vivEl-00000007CC1-02KV
	for linux-um@lists.infradead.org;
	Thu, 22 Jan 2026 14:00:40 +0000
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-6505d3b84bcso1294773a12.3
        for <linux-um@lists.infradead.org>; Thu, 22 Jan 2026 06:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1769090436; x=1769695236; darn=lists.infradead.org;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KXXllTpn+4j3DQ+o0FpmjiZEdWUg34VA5GPm+3TDwac=;
        b=MW7nP2lfhZs1ZADvsC4ekVxLv/ZeZ7JoOanpXXjutZwUODCsjuD5ix188I98eWP0F0
         Ffwl4wkROglU/uX9PKDMteDM8t6c4a/D1dIvzE4Ru+D9kigxCI4g3eXC2GquWkFnVs11
         kXEijl+cBKzMzDA2M0gTVfNrw/4fl4UvjEudrggnxqTMW1thMfMJPHwL85wfhdt0U9+u
         961pR4Mfb9XdbMkDlrxxka7/1ZmD5UfARN/dR2QBEdbx20U042zsDAtJrQ+Vu9rLdpYm
         KroAxck07OJ801UvkgH3yKlbwNl3p6+uRrSOIZ918vnO31EnvIgMdbPnrFXnlznA6DCj
         Ns8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769090436; x=1769695236;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KXXllTpn+4j3DQ+o0FpmjiZEdWUg34VA5GPm+3TDwac=;
        b=E68aKVYl/gFxW5b3XhZiJY/Y0nY3nSYfH7d1lRCvioLVmVotkmLgKqVC4oPS/qyC76
         UGnRinCow/wCf52wVmqZ5z1ziIZusB28u0zZVvnDqNCqSYPW/UmOBIY2Oy+B13oKqgqj
         qerY5usv0GCz3izLuwjcMRLZ8R0cXcHi5V2eq91hsikTbheniBJetYr/B9qV6yfxXWAE
         BnWap406lEDXAnPUlmjHjNn5UlcTAoAbsJPSVSHy2GNGrHIcBqqWD1hREh+oVfgozetz
         CwFjlChA9TVWJGDAfClg/oGVgRQ/oGbfaLJPIxsP7hRRFd9pB8hsIZFAQDOD9CUYjHVy
         0vgA==
X-Forwarded-Encrypted: i=1; AJvYcCVLlxiCsVXlIHyk+ouJLHtpIIVDNmftxc9ZaetzlfFmwrlP6QbrUmWywcSxL8qr2jqvfvAreYCvlQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YzsOjfW2IgZyF1iYMvv0pXVIGcwg6Pu0vT9UZOg30ONAZ0gEb/P
	+qzkL00qwvpjaASQWYHHtrFr8i7vyEJPaQnSpNx+oq1OBktSkwyB1/dU
X-Gm-Gg: AZuq6aLGvhyn3B29TjvGDkcRRVbyMo8Uhuhy9y+iQptni+KsvBhgscvesjt2gcXx06y
	wnLu35nOFm1/AX82EmIahpx2gR17skHdPoOf312jyV7Vjm8Z+dRD50Y99HDOnjmzWUQsghqSc+h
	D1ub2goBkpe5g0qlMOplIFJ0b4EZiGJ86Yfy1qVi192T3bfWjpx1BRpFgdy7tL2Mlk/RhopdF+K
	79blk/g4gB853QsXC6C89siSGmAKc1j4A3PUtEfQriB2U3buDxB5z24s9JLp3dMakayltsMD84a
	IO7nUZ/RjvnEyzo4kX0eMWir4CRlJLKqBqlngyUpa1hE5BR4SX1HEFaMz/lgaWkMZPP4ZR56N6s
	BD5q7wDGMIiy9bu2VBRPV//7rBr5V6+21NjATX3M9ZSdaR+qbJBYxFttv7hkoDwbLcNfyMtYmJY
	TE25Dce3VroA==
X-Received: by 2002:a17:907:84e:b0:b87:33f3:6042 with SMTP id a640c23a62f3a-b8792d3be6dmr1826205366b.9.1769090435585;
        Thu, 22 Jan 2026 06:00:35 -0800 (PST)
Received: from localhost ([185.92.221.13])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b884006d3bbsm68748466b.32.2026.01.22.06.00.34
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 22 Jan 2026 06:00:35 -0800 (PST)
Date: Thu, 22 Jan 2026 14:00:34 +0000
From: Wei Yang <richard.weiyang@gmail.com>
To: "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: Wei Yang <richard.weiyang@gmail.com>, Qi Zheng <qi.zheng@linux.dev>,
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
	peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
	ioworker0@gmail.com, linmag7@gmail.com, linux-arch@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-mm@kvack.org,
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
Message-ID: <20260122140034.ymigrfppzwvmcjkr@master>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
 <20251231094243.zmjs7kgflm7q6k73@master>
 <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
 <20260101020715.45wqnjgcklvjcth3@master>
 <d38fcbe5-8b4a-40bc-b8c8-1c49ccaa9964@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d38fcbe5-8b4a-40bc-b8c8-1c49ccaa9964@kernel.org>
User-Agent: NeoMutt/20170113 (1.7.2)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_060039_081474_67C6015E 
X-CRM114-Status: GOOD (  33.97  )
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

On Mon, Jan 19, 2026 at 11:18:52AM +0100, David Hildenbrand (Red Hat) wrote:
>On 1/1/26 03:07, Wei Yang wrote:
>> On Wed, Dec 31, 2025 at 05:52:57PM +0800, Qi Zheng wrote:
>> > 
>> > 
>> > On 12/31/25 5:42 PM, Wei Yang wrote:
>> > > On Wed, Dec 17, 2025 at 05:45:48PM +0800, Qi Zheng wrote:
>> > > > From: Qi Zheng <zhengqi.arch@bytedance.com>
>> > > > 
>> > > > The PT_RECLAIM can work on all architectures that support
>> > > > MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>> > > > MMU_GATHER_RCU_TABLE_FREE.
>> > > > 
>> > > > BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>> > > > to turn it off.
>> > > > 
>> > > > Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> > > > ---
>> > > > arch/x86/Kconfig | 1 -
>> > > > mm/Kconfig       | 9 ++-------
>> > > > 2 files changed, 2 insertions(+), 8 deletions(-)
>> > > > 
>> > > > diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> > > > index 80527299f859a..0d22da56a71b0 100644
>> > > > --- a/arch/x86/Kconfig
>> > > > +++ b/arch/x86/Kconfig
>> > > > @@ -331,7 +331,6 @@ config X86
>> > > > 	select FUNCTION_ALIGNMENT_4B
>> > > > 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>> > > > 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> > > > -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>> > > > 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>> > > > 	select SCHED_SMT			if SMP
>> > > > 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>> > > > diff --git a/mm/Kconfig b/mm/Kconfig
>> > > > index bd0ea5454af82..fc00b429b7129 100644
>> > > > --- a/mm/Kconfig
>> > > > +++ b/mm/Kconfig
>> > > > @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>> > > > 	  The architecture has hardware support for userspace shadow call
>> > > >             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>> > > > 
>> > > > -config ARCH_SUPPORTS_PT_RECLAIM
>> > > > -	def_bool n
>> > > > -
>> > > > config PT_RECLAIM
>> > > > -	bool "reclaim empty user page table pages"
>> > > > -	default y
>> > > > -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> > > > -	select MMU_GATHER_RCU_TABLE_FREE
>> > > > +	def_bool y
>> > > > +	depends on MMU_GATHER_RCU_TABLE_FREE
>> > > > 	help
>> > > > 	  Try to reclaim empty user page table pages in paths other than munmap
>> > > > 	  and exit_mmap path.
>> > > 
>> > > Hi, Qi
>> > > 
>> > > I am new to PT_RECLAIM, when reading related code I got one question.
>> > > 
>> > > Before this patch,  we could have this config combination:
>> > > 
>> > >       CONFIG_MMU_GATHER_RCU_TABLE_FREE & !CONFIG_PT_RECLAIM
>> > > 
>> > > This means tlb_remove_table_free() is rcu version while tlb_remove_table_one()
>> > > is semi rcu version.
>> > > 
>> > > I am curious could we use rcu version tlb_remove_table_one() for this case?
>> > > Use rcu version tlb_remove_table_one() if CONFIG_MMU_GATHER_RCU_TABLE_FREE. Is
>> > > there some limitation here?
>> > 
>> > I think there's no problem. The rcu version can also ensure that the
>> > fast GUP works well.
>> > 
>> 
>> Thanks for your quick response :-)
>> 
>> And Happy New Year
>> 
>> So my little suggestion is move the definition of __tlb_remove_table_one()
>> under CONFIG_MMU_GATHER_RCU_TABLE_FREE. Do you thinks this would be more
>> clear?
>
>
>Do you mean
>
>diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>index 2faa23d7f8d42..6aeba4bae68d2 100644
>--- a/mm/mmu_gather.c
>+++ b/mm/mmu_gather.c
>@@ -319,7 +319,7 @@ static inline void tlb_table_invalidate(struct mmu_gather
>*tlb)
>        }
> }
>
>-#ifdef CONFIG_PT_RECLAIM
>+#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
> static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
> {
>        struct ptdesc *ptdesc;
>
>?

Sorry for the late reply.

Yes, and maybe we can move the definition to the 
#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE code block above, then to be next to
tlb_remove_table_free().

So that we always have rcu version when CONFIG_MMU_GATHER_RCU_TABLE_FREE.

>
>-- 
>Cheers
>
>David

-- 
Wei Yang
Help you, Help me

