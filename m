Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AF46C83F25
	for <linux-um@archiver.kernel.org>; Mon, 21 Jul 2025 23:00:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qL9A0aUIl8Uddr//bj642F7utZi72l2outni4topsME=; b=e700MGVy5OuVxfgZr/ouV9iUI4
	ANNlyGXwwylULkMQg90mCqh5wTJ0YWqzLAQxdFOISiulQLMMkNchObk8AOUdk3XDsjPsvrsU6LGfv
	Z2f1r5cP5p9/v8W0MoI2p8kpqBnuT1VX2IYvIv0ztt+RD/YcAthms4jhK/V/Utj2gG52dRjyygrqd
	+vs3zIrxdX5iYvsd6ifvwLYZ56bgumEmWPicEWZFYpEwgJleBBMyc8vz5KrhJakr41AaSVFEVmoF4
	qUd0AYbcNVuCLECrDTG81Guk6rlMUDSTZnTNDAyKMSIOr3ZQOEhZQnYwwUKuLuT4p6+hwtK47e8Vg
	OfjeRpkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzUc-00000000qL8-1VBX;
	Mon, 21 Jul 2025 23:00:22 +0000
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzUZ-00000000qJi-0saX;
	Mon, 21 Jul 2025 23:00:20 +0000
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-60fdd24613fso982443a12.1;
        Mon, 21 Jul 2025 16:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138818; x=1753743618; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qL9A0aUIl8Uddr//bj642F7utZi72l2outni4topsME=;
        b=Kss27gHJ77IyoE3kjIQkiztYG4vp6AgLL7rfRaW1BP4dPyiQvYGQ4KgZT7fQnlfL1n
         WsbziqLQ7xVHwCvZAEegw70gLTwu6a+I2ivXWEOB2XnfIX7mDBTHnrSEgrV+hl2OL4nf
         fldkM+qouWRKDP/XCmuiG/gURsEWtJlIRzrjN3Gny4qPVp/EB8yf5EnYBljVMWmybUyn
         EoTAUORV7Zs1kmUHtgdRCrCDdeRe5v4izvSiTEjYpmlvjAL/sRW8Ua/EEy6Wzn7DnErS
         dGqdiY2wE1N1hGVAnURJl93PocRVXCP/265GSnkpPB+MNADsEV6X/jtgFb9mJD7lUc33
         9qBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138818; x=1753743618;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qL9A0aUIl8Uddr//bj642F7utZi72l2outni4topsME=;
        b=uFxiHlo4mSS1pdar0QzTXsM5B3g/JBfNCfFDlhfS/V25HFuAi0LsFWOkTZwI9RVm5x
         UTBnm8DyS5gF2wwn46mw11bHcCZ6wMyade5GhtSvA59eQf9Z4zjl/DbPf2prsMc+5abE
         36IHBDUXAiO547p9+u6lk6j3B+UkvJGmCpeU3ezekG9vrcvQB+c2sVbowxnm4870kAkv
         VVvRv54/Mceo0zdCRalimbq7k4c3e8vJx56pwmPCtqL6uZeZu/qNJlTZNrkncyheRIml
         z20bgdWozDwjk9o/Tahugv2MsCjwfCeHQLTBTaBycKgD5u+CEhSx01HUSWwPKhPwRTHm
         XQxQ==
X-Forwarded-Encrypted: i=1; AJvYcCW2PcyOgSP7L8MnI3oftUqPl+06umKUsReMJ5OvlQE0Q7xm8//BHJlk1BZ9gXpTqSE8L23Qx25QGJI=@lists.infradead.org, AJvYcCWNqf6uk43GZ2nV0b33uXL5AFuymvCO1ABbWPqFRVOMIybRHhlBhW4QhQ4i4mfvIX7+tMXjn0dkmQ88Cg==@lists.infradead.org
X-Gm-Message-State: AOJu0YxcBMgrt6Uv7tDWA7/dLDUYU7cOfq826P+SiI8w/MJPNhIn86cm
	r76XUDR0DCdtrhQItOyhs6fAe5wcZNaeqDI03SSn+NqmXmJf0OvMO0I7
X-Gm-Gg: ASbGncuGF6fnu1N/76q4q6NznMM6XXLYFGnBV6k5gJiELstOkvl0DtsPRRov0lEWOSR
	O3cV/C+yHgjyeRQRi6VCK1QxxLLCKtxKV60ntzELQr71J1nR/rNBIDa3aEcE5mSI9ZvlUOSEaON
	LjDfCijfRNZoSp2n5yk8m4c4Hy/PZ7DlI1OBG0sUHNfulxi+O73xB+jHNVRbZCrBsV99252hTLK
	NjT8XgBVFpRyU0dHk5lVAstVOhUQeq9yiFzLTtu8EpjUokAZvZ26zIvHk6+TB5gVfHkQKZUNdii
	7MfjRs80hD5PuQPFNQuhszTRs+tP2vkoZjbi4vw1y/egnkrHzcM6eeAvjdBvgVZEF/dojIcZGWQ
	lpN3m6ca4xToeFMYL8CthVvJoZ3uHqTkkXgi1C8mJC7f9e972IVfG58xIjjtRskbvLaSZ
X-Google-Smtp-Source: AGHT+IHckuXEWvfAMpSzjjL6pEsgi7MWI7yYCMOiqpAqEO5gMn0ATvaVtw0/vmnoItEaOlX4DlEKBQ==
X-Received: by 2002:a17:907:7fa1:b0:ae6:c555:8dbb with SMTP id a640c23a62f3a-ae9c9af98e3mr887526166b.11.1753138817353;
        Mon, 21 Jul 2025 16:00:17 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aec6c7d8357sm753164466b.52.2025.07.21.16.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:00:16 -0700 (PDT)
Message-ID: <c8b0be89-6c89-46ed-87c3-8905b6ccbbeb@gmail.com>
Date: Tue, 22 Jul 2025 00:59:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 07/12] kasan/loongarch: select ARCH_DEFER_KASAN and
 call kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-8-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-8-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_160019_256238_6E886231 
X-CRM114-Status: GOOD (  10.23  )
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



On 7/17/25 4:27 PM, Sabyrzhan Tasbolatov wrote:

> diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
> index 62f139a9c87..0e50e5b5e05 100644
> --- a/arch/loongarch/include/asm/kasan.h
> +++ b/arch/loongarch/include/asm/kasan.h
> @@ -66,7 +66,6 @@
>  #define XKPRANGE_WC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKPRANGE_WC_KASAN_OFFSET)
>  #define XKVRANGE_VC_SHADOW_OFFSET	(KASAN_SHADOW_START + XKVRANGE_VC_KASAN_OFFSET)
>  
> -extern bool kasan_early_stage;
>  extern unsigned char kasan_early_shadow_page[PAGE_SIZE];
>  
>  #define kasan_mem_to_shadow kasan_mem_to_shadow
> @@ -75,12 +74,6 @@ void *kasan_mem_to_shadow(const void *addr);
>  #define kasan_shadow_to_mem kasan_shadow_to_mem
>  const void *kasan_shadow_to_mem(const void *shadow_addr);
>  
> -#define kasan_arch_is_ready kasan_arch_is_ready
> -static __always_inline bool kasan_arch_is_ready(void)
> -{
> -	return !kasan_early_stage;
> -}
> -
>  #define addr_has_metadata addr_has_metadata
>  static __always_inline bool addr_has_metadata(const void *addr)
>  {
> diff --git a/arch/loongarch/mm/kasan_init.c b/arch/loongarch/mm/kasan_init.c
> index d2681272d8f..cf8315f9119 100644
> --- a/arch/loongarch/mm/kasan_init.c
> +++ b/arch/loongarch/mm/kasan_init.c
> @@ -40,11 +40,9 @@ static pgd_t kasan_pg_dir[PTRS_PER_PGD] __initdata __aligned(PAGE_SIZE);
>  #define __pte_none(early, pte) (early ? pte_none(pte) : \
>  ((pte_val(pte) & _PFN_MASK) == (unsigned long)__pa(kasan_early_shadow_page)))
>  
> -bool kasan_early_stage = true;
> -
>  void *kasan_mem_to_shadow(const void *addr)
>  {
> -	if (!kasan_arch_is_ready()) {
> +	if (!kasan_enabled()) {

This doesn't make sense, !kasan_enabled() is compile-time check which is always false here.

>  		return (void *)(kasan_early_shadow_page);
>  	} else {
>  		unsigned long maddr = (unsigned long)addr;

