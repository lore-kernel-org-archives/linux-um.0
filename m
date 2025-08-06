Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E94AC87FCB
	for <linux-um@archiver.kernel.org>; Wed,  6 Aug 2025 13:35:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GkBywKSK+jarcaDEWkMpZ6690o3qyLvHV2Ljs5N+BnY=; b=bYd8fdtTVylNz2ZCsKpM/8CD05
	WsJiEoXHiOxk/g4de5r8tYX3V8RAFRCXWn+Fh9U14+of/nhW+wuVU7999gN35ROPe8AF7KYyTolLS
	MUmOnaD+g9UcMInpNpGG+al6GnNAvpr0daGkpxkCxjBA5lnGig0em1vINlaoJp9aPXWCAwWnGeQ/n
	zk/hUaoqxnmjNhqQP5DV28a3KsF0wbTzK+RVudA3jhQw6wrROYxHTKDXmbGguSta4bqC+HNpETDcr
	2RR0lciy0+zHwriqaDVnFfCaJSf73vGGX6Ulfw138d932xKt4m0MiPl+T2nodpLJyQsqMuugxBRvS
	V7Vmh2pw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujeIP-0000000FJIW-2UdS;
	Wed, 06 Aug 2025 13:35:09 +0000
Received: from mail-lf1-x134.google.com ([2a00:1450:4864:20::134])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujeIM-0000000FJGv-1VCl;
	Wed, 06 Aug 2025 13:35:07 +0000
Received: by mail-lf1-x134.google.com with SMTP id 2adb3069b0e04-55ba2644bdaso562220e87.0;
        Wed, 06 Aug 2025 06:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754487304; x=1755092104; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GkBywKSK+jarcaDEWkMpZ6690o3qyLvHV2Ljs5N+BnY=;
        b=NySPrReumcUTFpj2gIhNZIrCLf9kmaczdgsd739sLBEfxwZkEFn8jUXkmb4UWPyJyB
         9+sw4i1whFqOC+Uo5+G1Jk6PGTkRT82OXnasQ67vdWI72rPFKN3pD5Vn6PA7riox0GPZ
         RvEGuuzG40so72SbBsm85NLHs4lcatADkQXgRhEkFHDk+GdxwEOjELtZ/on3AEFCX24F
         IncXKh3JUsEgIp81y1PZkHfZ5zB1pXX/6fQ79OKcXDw53MMyxbGIx5WJCqMAGBRI281f
         sI9swj9K98Gw4KaCIFSG+RD0wCMOnEvudZhxMRpcqzsce4PuAQccg2Uu1d6U+F4DfCUA
         4LDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754487304; x=1755092104;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GkBywKSK+jarcaDEWkMpZ6690o3qyLvHV2Ljs5N+BnY=;
        b=jcFsYF1kqDM3e8lnt7/XfLtEwO823/5U2v9pMNqXjFsV4OSF+CF7/e4UF1EZ8MOMLy
         138NT48ZND8HChzR/FmiJR0ACdOr5iBe5ige1HU7/22YfbaCyg4h1iWRVj57oq1+lzYS
         FR6N/vr796V0xLxnnsI3ZjvqkFcRH9ejE6kT0Io8H2MmuzwFcUe7PYbfR2gG5rijnnM3
         HJqZFHWjxiPSlXm+w2q3vDooUERv4jM1drfj80B1RrP2GXosn4fJ+G2nl+wx+aejReoy
         zXdkjgZQfYZtbCFjaefyf2/NtOxFs4MRRIw5MeICeag0wVryq3ig+4FMsc/D8b28EQpm
         nB/A==
X-Forwarded-Encrypted: i=1; AJvYcCVvV+fLqOprsdPwvW0AOYYOOjsKAc3PKEqEMPEpIpR5GIiadXqJvZApToxYMGeO4hW84owh0b3dyTDZmQ==@lists.infradead.org, AJvYcCXNK9D+Xuspch52tJvsrMBdx5RcvnKCz1d9jLNNiCuvoMpeeNAq6a5h7WbJTGZUJZcs67vKhXepTSc=@lists.infradead.org
X-Gm-Message-State: AOJu0YxrcELAzi2U2ZJ3hYwC33YpOiLvHSoRdC2f3F+FXrTLcO1UuCFA
	ntGzWJyRsj41TG6aRNG2aXKAZNWAweCznGkk3LhINUNhZK/nR9RJpWMC
X-Gm-Gg: ASbGncuaBnl2k6yVJmvuWb8a1dOfDBPQMLLaBdmvu0BzlnPfAZkQxOcWR7q9grziSCf
	6RYQcvRZ39kH1A9T/11x3Ka2HgC2k7yAfVTpXxZfHV+NvsLjKzaucu2XOnWKN2rvnzgY+4j92bM
	McANfMGx6TAsZ3ueKLHP9OZvO2LJAbi+GRG11G4AlR6TbFccMYW73lSvQB7VFYzM0gdqlrVByiJ
	KMuV5CdKIEBrk/cxr00Wb1+YObPz44elAzyvQ3V3bdvesHN+bA9QwZCI9hw34RXjc51IOpXupA4
	d3iVI+e/OuPJPWDQu4HCHdtaXgv1Wwqzi8XhCbHXsNwzUkeESsyrx0nMunHz77Zg1f+8s0yDP9m
	K8O3MIE0thAr5cd5n5x6RhvSA1j5V
X-Google-Smtp-Source: AGHT+IG/+xV14jPScIlu8zUGGDD+ajQ7/dFSreWgfNZ5pS9U8lvRiqBw989XNjNOSP9y7GWZ8ScIMA==
X-Received: by 2002:a05:6512:ad1:b0:55a:4d9e:6536 with SMTP id 2adb3069b0e04-55caf2f956dmr417291e87.2.1754487304191;
        Wed, 06 Aug 2025 06:35:04 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-55b8899ebd2sm2302283e87.42.2025.08.06.06.35.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 06:35:03 -0700 (PDT)
Message-ID: <5a73e633-a374-47f2-a1e1-680e24d9f260@gmail.com>
Date: Wed, 6 Aug 2025 15:34:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 trishalfonso@google.com, davidgow@google.com
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-2-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250805142622.560992-2-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_063506_406130_BCCBD263 
X-CRM114-Status: GOOD (  25.86  )
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



On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
> to defer KASAN initialization until shadow memory is properly set up,
> and unify the static key infrastructure across all KASAN modes.
> 
> Some architectures (like PowerPC with radix MMU) need to set up their
> shadow memory mappings before KASAN can be safely enabled, while others
> (like s390, x86, arm) can enable KASAN much earlier or even from the
> beginning.
> 
> Historically, the runtime static key kasan_flag_enabled existed only for
> CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
> architecture-specific kasan_arch_is_ready() implementations or evaluated
> KASAN checks unconditionally, leading to code duplication.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v4:
> - Fixed HW_TAGS static key functionality (was broken in v3)

I don't think it fixed. Before you patch kasan_enabled() esentially
worked like this:

 if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))
        return static_branch_likely(&kasan_flag_enabled);
 else
        return IS_ENABLED(CONFIG_KASAN);

Now it's just IS_ENABLED(CONFIG_KASAN);

And there are bunch of kasan_enabled() calls left whose behavior changed for
no reason.


> - Merged configuration and implementation for atomicity
> ---
>  include/linux/kasan-enabled.h | 36 +++++++++++++++++++++++-------
>  include/linux/kasan.h         | 42 +++++++++++++++++++++++++++--------
>  lib/Kconfig.kasan             |  8 +++++++
>  mm/kasan/common.c             | 18 ++++++++++-----
>  mm/kasan/generic.c            | 23 +++++++++++--------
>  mm/kasan/hw_tags.c            |  9 +-------
>  mm/kasan/kasan.h              | 36 +++++++++++++++++++++---------
>  mm/kasan/shadow.c             | 32 ++++++--------------------
>  mm/kasan/sw_tags.c            |  4 +++-
>  mm/kasan/tags.c               |  2 +-
>  10 files changed, 133 insertions(+), 77 deletions(-)
> 
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index 6f612d69ea0..52a3909f032 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -4,32 +4,52 @@
>  
>  #include <linux/static_key.h>
>  
> -#ifdef CONFIG_KASAN_HW_TAGS
> +/* Controls whether KASAN is enabled at all (compile-time check). */
> +static __always_inline bool kasan_enabled(void)
> +{
> +	return IS_ENABLED(CONFIG_KASAN);
> +}
>  
> +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> +/*
> + * Global runtime flag for KASAN modes that need runtime control.
> + * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
> + */
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  
> -static __always_inline bool kasan_enabled(void)
> +/*
> + * Runtime control for shadow memory initialization or HW_TAGS mode.
> + * Uses static key for architectures that need deferred KASAN or HW_TAGS.
> + */
> +static __always_inline bool kasan_shadow_initialized(void)

Don't rename it, just leave as is - kasan_enabled().
It's better name, shorter and you don't need to convert call sites, so
there is less chance of mistakes due to unchanged kasan_enabled() -> kasan_shadow_initialized().


>  {
>  	return static_branch_likely(&kasan_flag_enabled);
>  }
>  
> -static inline bool kasan_hw_tags_enabled(void)
> +static inline void kasan_enable(void)
> +{
> +	static_branch_enable(&kasan_flag_enabled);
> +}
> +#else
> +/* For architectures that can enable KASAN early, use compile-time check. */
> +static __always_inline bool kasan_shadow_initialized(void)
>  {
>  	return kasan_enabled();
>  }
>  

...

>  
>  void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
> -int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> -void kasan_release_vmalloc(unsigned long start, unsigned long end,
> +
> +int __kasan_populate_vmalloc(unsigned long addr, unsigned long size);
> +static inline int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
> +{
> +	if (!kasan_shadow_initialized())
> +		return 0;


What's the point of moving these checks to header?
Leave it in C, it's easier to grep and navigate code this way.


> +	return __kasan_populate_vmalloc(addr, size);
> +}
> +
> +void __kasan_release_vmalloc(unsigned long start, unsigned long end,
>  			   unsigned long free_region_start,
>  			   unsigned long free_region_end,
>  			   unsigned long flags);
> +static inline void kasan_release_vmalloc(unsigned long start,
> +			   unsigned long end,
> +			   unsigned long free_region_start,
> +			   unsigned long free_region_end,
> +			   unsigned long flags)
> +{
> +	if (kasan_shadow_initialized())
> +		__kasan_release_vmalloc(start, end, free_region_start,
> +			   free_region_end, flags);
> +}
>  

...> @@ -250,7 +259,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
>  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>  				unsigned long ip)
>  {
> -	if (!kasan_arch_is_ready() || is_kfence_address(object))
> +	if (is_kfence_address(object))
>  		return false;
>  	return check_slab_allocation(cache, object, ip);
>  }
> @@ -258,7 +267,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  		       bool still_accessible)
>  {
> -	if (!kasan_arch_is_ready() || is_kfence_address(object))
> +	if (is_kfence_address(object))
>  		return false;
>  
>  	poison_slab_object(cache, object, init, still_accessible);
> @@ -282,9 +291,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  
>  static inline bool check_page_allocation(void *ptr, unsigned long ip)
>  {
> -	if (!kasan_arch_is_ready())
> -		return false;
> -


Well, you can't do this yet, because no arch using ARCH_DEFER_KASAN yet, so this breaks
bisectability.
Leave it, and remove with separate patch only when there are no users left.

>  	if (ptr != page_address(virt_to_head_page(ptr))) {
>  		kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
>  		return true;
> @@ -511,7 +517,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
>  		return true;
>  	}
>  
> -	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
> +	if (is_kfence_address(ptr))
>  		return true;
>  
>  	slab = folio_slab(folio);



