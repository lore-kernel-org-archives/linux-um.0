Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93656C87FCB
	for <linux-um@archiver.kernel.org>; Wed,  6 Aug 2025 19:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jOJUufvksrkNMkhUfUMzFksoWwIudiaNrjydPYTPe/E=; b=nNOo0+tlVr2qlUTjxK9FLyWewt
	aOE9+QkaC8jYrAu5vCCB3yRifaevLJfk/rwP4KpeDPYIU7R/JMKfx50O7rt7y1qKty/L8FK9qM//Q
	2IYdARUMT6xUiN9+53FS9lvfJsMOt7O5CW5Ug2LnB5LAiaWG9pVUYRjJpjuy5Ju0hYZuHdl2ls6uS
	7k6X4k6pO80C6H55jRf4J1HiGs+FUV4GKnrQlfYMTYu6rpisH0N92q0RkfraZceKK3KZWIgqDOGU9
	kl+kptuLkqjm0T0xE9o5UXe9093siFQVCNUT9rE5/0eqXb9dDW+mTebR1kcwJyLllXUvTwPgPDjUd
	vAcwGKPw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujkBA-0000000GF9P-0zC8;
	Wed, 06 Aug 2025 19:52:04 +0000
Received: from mail-qk1-x731.google.com ([2607:f8b0:4864:20::731])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujkB7-0000000GF8a-04xD;
	Wed, 06 Aug 2025 19:52:02 +0000
Received: by mail-qk1-x731.google.com with SMTP id af79cd13be357-7e801406a6cso1417185a.0;
        Wed, 06 Aug 2025 12:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754509919; x=1755114719; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jOJUufvksrkNMkhUfUMzFksoWwIudiaNrjydPYTPe/E=;
        b=YhWo/ecRTGTkXyAX9Q2vdbfLuHAwtbMtxAmG8QuArKKdRsTDhQQ6jMzL7k5Ycw6A4e
         uuO5+crjccTE6a0yIL8Z9QJJzC/NTLOirYx75byFtTP4SHC31otUCrFRzK2joPp8lr2k
         2NpgHsEyt7LdkpVGIjZ/6Jn6JRoaUdIylQQo5UviUCgg8CSbhO5mncat43hqlKfeMbcm
         E1dsQK9/al5ekqY8PAWClLLtG5em7ohTJDYwLn1SoTqHL89ucEFqqCbANkFiQ+uHdDcC
         4I9pv/TXLF7WrhHUoQ5RxfrSpV+HTos+Cvw0mvJzmWHvuL3CCkWsQX5q7rgDvOthjU2A
         ropw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754509919; x=1755114719;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=jOJUufvksrkNMkhUfUMzFksoWwIudiaNrjydPYTPe/E=;
        b=FTPSYG6whQfyD0E976FRG0TYL7W2BwFJLjbR/1xVstTzf9Wt6CWl+t1giLSa9Pnhk1
         Fewshw9cWrfGvJKKnhxMCK0cfuw5Mlz9gknocZCXQl+OO/O61qxDMk6OoZQQ9VIpID+9
         Dtxehma3I5NDUHVnvcudLd27+bNrJzohERqlikdQhrr16RM08f82eGSFzjSowh2wg+sx
         Lk6DR3wOC8xZLiZV36KnhftC4Nc2K9k4LoccmbxSR5uFBIx6pa9QvYNuz7MHeqyy3J8H
         v053/5727yn/hHejk/c4KvrqEWxVPwBQ+CGXwW2Suw3gQ01+CYgw/9UmDdEjwW7b2z5V
         PoDA==
X-Forwarded-Encrypted: i=1; AJvYcCURF5ZE0uPjqgBJ21AIRL++eHlpjQ8OCtxFGa/++PNIQZnVO3Ni0pPx8TEb/Un6N5Ur9Ge6JrkddC9wVw==@lists.infradead.org, AJvYcCVOejEFILxo6QgS12Tkqw1cAIO57IZwUQL8HUUZxkbO4xUkENO7WXpYssE5vnvPxQNm9rgk/8uEs3s=@lists.infradead.org
X-Gm-Message-State: AOJu0YyCqjKvEBk8KOeFzC2iohro6lnSbusZd5XHWCdyk0Wh3lR0fgT2
	1b0gUUTTDfxdrophUbBzzcDBwWj3KGDNRJ0GFa/yvrdYG9jVEf1SpyPv
X-Gm-Gg: ASbGncv3OWp6J0+PdbKUnB/mBJgh1j3ge8wuT64l7W49jB3mOnuysRIQOw5dZVOyOcL
	lPzY/avvFV77cW70yKt/ZjgkPcnD4olwoU+JLHYCqkvkiEvQZdBr5JZo7z1lYJoYB5MhFTYwb3V
	YY2Nodlls3pCZJ4Dtgu3yaIvVIB4qV52hPEUmLcfpW8OX5lc72N4qttn0zQzg9GmYiPgwz1Rm2l
	dW0iOfvVMo3gibBpc6vIJ4h5X41oT5Mhgee952TdsNXMEQDONhAHbDtPimj/Ad4RgbKX0Hx6SKO
	FYJpPLVCHOcN6NAmqa1tqTNbHl8wdYZRYEs0WFxPfVk9tGys2yvwMprZGjbAQ2kEi6gBMczpR92
	MOc3teS+Xv8R2AdeLXimAYvyfpOk12U6WzgLdP20ATBGPVbXXYEl2jWBUSLKwO3wCkWvO
X-Google-Smtp-Source: AGHT+IFmzUMSDyUQoeXjvqgYHBfr+pQThJ0xtd5NGlSxIHAVfwgMAAXU9ZJsjUzM039DpZsjSBydog==
X-Received: by 2002:a05:620a:1a04:b0:7e2:6be2:38eb with SMTP id af79cd13be357-7e814d64573mr316228785a.4.1754509919359;
        Wed, 06 Aug 2025 12:51:59 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-140-132.dynamic.sbb.rs. [94.189.140.132])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7e67f5c55a2sm866617085a.36.2025.08.06.12.51.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Aug 2025 12:51:58 -0700 (PDT)
Message-ID: <dd25cb14-5df1-4b2c-bff7-0ca901dfd824@gmail.com>
Date: Wed, 6 Aug 2025 21:51:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/9] kasan: introduce ARCH_DEFER_KASAN and unify static
 key across modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: hca@linux.ibm.com, christophe.leroy@csgroup.eu, andreyknvl@gmail.com,
 agordeev@linux.ibm.com, akpm@linux-foundation.org, zhangqing@loongson.cn,
 chenhuacai@loongson.cn, trishalfonso@google.com, davidgow@google.com,
 glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-2-snovitoll@gmail.com>
 <5a73e633-a374-47f2-a1e1-680e24d9f260@gmail.com>
 <CACzwLxg=zC-82sY6f-z0VOnmbpN2E8tQxe7RyOnynpbJEFP+NA@mail.gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <CACzwLxg=zC-82sY6f-z0VOnmbpN2E8tQxe7RyOnynpbJEFP+NA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250806_125201_067616_1622422F 
X-CRM114-Status: GOOD (  31.88  )
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



On 8/6/25 4:15 PM, Sabyrzhan Tasbolatov wrote:
> On Wed, Aug 6, 2025 at 6:35 PM Andrey Ryabinin <ryabinin.a.a@gmail.com> wrote:
>>
>>
>>
>> On 8/5/25 4:26 PM, Sabyrzhan Tasbolatov wrote:
>>> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures that need
>>> to defer KASAN initialization until shadow memory is properly set up,
>>> and unify the static key infrastructure across all KASAN modes.
>>>
>>> Some architectures (like PowerPC with radix MMU) need to set up their
>>> shadow memory mappings before KASAN can be safely enabled, while others
>>> (like s390, x86, arm) can enable KASAN much earlier or even from the
>>> beginning.
>>>
>>> Historically, the runtime static key kasan_flag_enabled existed only for
>>> CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
>>> architecture-specific kasan_arch_is_ready() implementations or evaluated
>>> KASAN checks unconditionally, leading to code duplication.
>>>
>>> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
>>> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
>>> ---
>>> Changes in v4:
>>> - Fixed HW_TAGS static key functionality (was broken in v3)
>>
>> I don't think it fixed. Before you patch kasan_enabled() esentially
>> worked like this:
>>
>>  if (IS_ENABLED(CONFIG_KASAN_HW_TAGS))
>>         return static_branch_likely(&kasan_flag_enabled);
>>  else
>>         return IS_ENABLED(CONFIG_KASAN);
>>
>> Now it's just IS_ENABLED(CONFIG_KASAN);
> 
> In v4 it is:
> 
>         #if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
>         static __always_inline bool kasan_shadow_initialized(void)
>         {
>                 return static_branch_likely(&kasan_flag_enabled);
>         }
>         #else
>         static __always_inline bool kasan_shadow_initialized(void)
>         {
>                 return kasan_enabled(); // which is IS_ENABLED(CONFIG_KASAN);
>         }
>         #endif
> 
> So for HW_TAGS, KASAN is enabled in kasan_init_hw_tags().

You are referring to  kasan_shadow_initialized(), but I was talking about kasan_enabled() specifically.
E.g. your patch changes behavior for kasan_init_slab_obj() which doesn't use kasan_shadow_initialized()
 (in the case of HW_TAGS=y && kasan_flag_enabled = false) :

static __always_inline void * __must_check kasan_init_slab_obj(
                                struct kmem_cache *cache, const void *object)
{
        if (kasan_enabled())
                return __kasan_init_slab_obj(cache, object);
        return (void *)object;
}



>>> +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
>>> +/*
>>> + * Global runtime flag for KASAN modes that need runtime control.
>>> + * Used by ARCH_DEFER_KASAN architectures and HW_TAGS mode.
>>> + */
>>>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>>>
>>> -static __always_inline bool kasan_enabled(void)
>>> +/*
>>> + * Runtime control for shadow memory initialization or HW_TAGS mode.
>>> + * Uses static key for architectures that need deferred KASAN or HW_TAGS.
>>> + */
>>> +static __always_inline bool kasan_shadow_initialized(void)
>>
>> Don't rename it, just leave as is - kasan_enabled().
>> It's better name, shorter and you don't need to convert call sites, so
>> there is less chance of mistakes due to unchanged kasan_enabled() -> kasan_shadow_initialized().
> 
> I actually had the only check "kasan_enabled()" in v2, but went to
> double check approach in v3
> after this comment:
> https://lore.kernel.org/all/CA+fCnZcGyTECP15VMSPh+duLmxNe=ApHfOnbAY3NqtFHZvceZw@mail.gmail.com/

AFAIU the comment suggest that we need two checks/flags, one in kasan_enabled() which checks
whether kasan was enabled via cmdline (currently only for HW_TAGS)
 and one in kasan_arch_is_ready()(or kasan_shadow_initialized()) which checks if arch initialized KASAN.
And this not what v3/v4 does. v4 basically  have one check, just under different name. 

Separate checks might be needed if we have code paths that need 'kasan_arch_is_ready() && !kasan_enabled()'
and vise versa '!kasan_arch_is_ready() && kasan_enabled()'.

From the top of my head, I can't say if we have such cases.

> 
> Ok, we will have the **only** check kasan_enabled() then in
> kasan-enabled.h which
> 
>         #if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
>         static __always_inline bool kasan_enabled(void)
>         {
>                 return static_branch_likely(&kasan_flag_enabled);
>         }
>         #else
>         static inline bool kasan_enabled(void)
>         {
>                 return IS_ENABLED(CONFIG_KASAN);
>         }
> 
> And will remove kasan_arch_is_ready (current kasan_shadow_initialized in v4).
> 
> So it is the single place to check if KASAN is enabled for all arch
> and internal KASAN code.
> Same behavior is in the current mainline code but only for HW_TAGS.
> 
> Is this correct?
> 

Yep, that's what I meant.

>>
>>
>>>  {
>>>       return static_branch_likely(&kasan_flag_enabled);
>>>  }
>>>
>>> -static inline bool kasan_hw_tags_enabled(void)
>>> +static inline void kasan_enable(void)
>>> +{
>>> +     static_branch_enable(&kasan_flag_enabled);
>>> +}
>>> +#else
>>> +/* For architectures that can enable KASAN early, use compile-time check. */
>>> +static __always_inline bool kasan_shadow_initialized(void)
>>>  {
>>>       return kasan_enabled();
>>>  }
>>>
>>
>> ...
>>
>>>
>>>  void kasan_populate_early_vm_area_shadow(void *start, unsigned long size);
>>> -int kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>>> -void kasan_release_vmalloc(unsigned long start, unsigned long end,
>>> +
>>> +int __kasan_populate_vmalloc(unsigned long addr, unsigned long size);
>>> +static inline int kasan_populate_vmalloc(unsigned long addr, unsigned long size)
>>> +{
>>> +     if (!kasan_shadow_initialized())
>>> +             return 0;
>>
>>
>> What's the point of moving these checks to header?
>> Leave it in C, it's easier to grep and navigate code this way.
> 
> Andrey Konovalov had comments [1] to avoid checks in C
> by moving them to headers under __wrappers.
> 
> : 1. Avoid spraying kasan_arch_is_ready() throughout the KASAN
> : implementation and move these checks into include/linux/kasan.h (and
> : add __wrappers when required).
> 
> [1] https://lore.kernel.org/all/CA+fCnZcGyTECP15VMSPh+duLmxNe=ApHfOnbAY3NqtFHZvceZw@mail.gmail.com/
> 

I think Andrey K. meant cases when we have multiple implementations of one function for each mode.
In such case it makes sense to merge multiple kasan_arch_is_ready() checks into one in the header.
But in case like with kasan_populate_vmalloc() we have only one implementation so I don't see any
value in adding wrapper/moving to header. 

>>
>>
>>> +     return __kasan_populate_vmalloc(addr, size);
>>> +}
>>> +
>>> +void __kasan_release_vmalloc(unsigned long start, unsigned long end,
>>>                          unsigned long free_region_start,
>>>                          unsigned long free_region_end,
>>>                          unsigned long flags);
>>> +static inline void kasan_release_vmalloc(unsigned long start,
>>> +                        unsigned long end,
>>> +                        unsigned long free_region_start,
>>> +                        unsigned long free_region_end,
>>> +                        unsigned long flags)
>>> +{
>>> +     if (kasan_shadow_initialized())
>>> +             __kasan_release_vmalloc(start, end, free_region_start,
>>> +                        free_region_end, flags);
>>> +}
>>>
>>
>> ...> @@ -250,7 +259,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
>>>  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>>>                               unsigned long ip)
>>>  {
>>> -     if (!kasan_arch_is_ready() || is_kfence_address(object))
>>> +     if (is_kfence_address(object))
>>>               return false;
>>>       return check_slab_allocation(cache, object, ip);
>>>  }
>>> @@ -258,7 +267,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>>>  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>>>                      bool still_accessible)
>>>  {
>>> -     if (!kasan_arch_is_ready() || is_kfence_address(object))
>>> +     if (is_kfence_address(object))
>>>               return false;
>>>
>>>       poison_slab_object(cache, object, init, still_accessible);
>>> @@ -282,9 +291,6 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>>>
>>>  static inline bool check_page_allocation(void *ptr, unsigned long ip)
>>>  {
>>> -     if (!kasan_arch_is_ready())
>>> -             return false;
>>> -
>>
>>
>> Well, you can't do this yet, because no arch using ARCH_DEFER_KASAN yet, so this breaks
>> bisectability.
>> Leave it, and remove with separate patch only when there are no users left.
> 
> Will do in v5 at the end of patch series.
> 
>>
>>>       if (ptr != page_address(virt_to_head_page(ptr))) {
>>>               kasan_report_invalid_free(ptr, ip, KASAN_REPORT_INVALID_FREE);
>>>               return true;
>>> @@ -511,7 +517,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
>>>               return true;
>>>       }
>>>
>>> -     if (is_kfence_address(ptr) || !kasan_arch_is_ready())
>>> +     if (is_kfence_address(ptr))
>>>               return true;
>>>
>>>       slab = folio_slab(folio);
>>
>>


