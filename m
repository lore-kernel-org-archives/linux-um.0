Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8955AC83F26
	for <linux-um@archiver.kernel.org>; Mon, 21 Jul 2025 23:00:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/MErh+IJZfEbaFHl36LqhlLVHvlXTKmbu8riveWqw+Q=; b=x+DGj3fapZnkq90TEtCt/r8byA
	qpamE8uwYktJXyiJq2+g0c7sGo/jc7Shw1/NeHYMwLg5xQ4G1RjIjDe7WCGp3hmLXDS744lKAjdAc
	XnSfUOud5TqgdvLsBK8oqvoIPWUYVakCyD2o58QTQzqmoq8pNBxZTykkWlYTDMDAgFFAqc3xSC+HV
	vdkY76UxGyzzTMxPwEwlPhhIMzOY8+uZfNBifEb1AF0wOd+DCh6WQA4nNMMkMp4zqWw4DEhF7CkA7
	95hwoIfMEMAEY9plNkQT9oAZI4nBRbAcmnst/hJ6vJgRlF9rteaTlaD+fkrZWByfQgTeESsWXNiS2
	pskPPDDQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzUN-00000000qDO-0Wlf;
	Mon, 21 Jul 2025 23:00:07 +0000
Received: from mail-ed1-x534.google.com ([2a00:1450:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1udzUK-00000000qAd-1qzR;
	Mon, 21 Jul 2025 23:00:05 +0000
Received: by mail-ed1-x534.google.com with SMTP id 4fb4d7f45d1cf-6071ac68636so658401a12.3;
        Mon, 21 Jul 2025 16:00:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753138803; x=1753743603; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/MErh+IJZfEbaFHl36LqhlLVHvlXTKmbu8riveWqw+Q=;
        b=Cit5pbwBXBErk2x1UZgKZVJJXF0orkgd7o8jJmflhBImKXKqBsDWtnE+A/ddi4x/Jv
         0rE0TSvE6kAcYQo5sVGKAky/Z9jOS6U2XPiX6TnA1ML+lpqgL+aI7gEUPmhoxpYmkEKv
         e2MTkr5COO+ILDeHogLgTJmS2yBhYNJtHBVKhaQe7ZCKbx46uV3Vw1rWW1jjceMjofne
         trAMuPV4oBKlzdMb/RoIHblK+PwON6lkTRVDJa40maU3rwFTQ0uo6Hsf+ISRVSd2HZet
         xSpfc3Xnca1MEN+82y6FMOPUjyqzi/JORTUFnVAazQeYoZT+D8tt3N3T4D0DPZWiTIi/
         nrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753138803; x=1753743603;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/MErh+IJZfEbaFHl36LqhlLVHvlXTKmbu8riveWqw+Q=;
        b=MyrjljZus/I9dNDG6VQ5GtfwTgOIWgBDFtL9HG0M6pzbdsWeQet0jrO2AQd736R9sO
         VVA7hPdt1BUz3/NkljKSdGR5Xg2E8gdtRy2/f5lHzHBUJJb9XKiibon6GurcOIVfYsP/
         yMECT76NaVdEVQM8m3pE+QFEYHNpFuUC8/XVzNS3IF1O/E+cRLSIprMrtYRWDRuqIFAi
         GiUrBoXPtEBRUAlRJUdy3TgwSzWymbuIb2+xucvkGpUNozMpTjm3cWUA2wQZY1D6ITFt
         ppEHDn56FpWQFJ7d3qt4y3sNkPz5a9k91HtXduXYFTJYNOeGBW7mKD8+sVajvwrGG0Ts
         XSZg==
X-Forwarded-Encrypted: i=1; AJvYcCUj0mX6I3tPCSo9tX2pD2mZfJJHFBk/oR1MuK6Q19VCuBrZzAbDSA+GXHfkNe5ApMg6PNfp8Uq4bAw=@lists.infradead.org, AJvYcCUtapjdz6EyJXEbiJLuLmAV4Xe7Zekx9wAOpAWxrEEvKvVgEaD8HcK1/JReDleG+vQo2cChC0ntVPa+Tw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyPOUrS1fUrIUt5Ggv1GZDoMcGypj3hbFh8RBrNL9C/d3eIKG+N
	1+YqLsNcgIDKrSgC+Yzh53CjZYDJdOnXGKPyrmFcSX+UL0BpGToGto9R
X-Gm-Gg: ASbGncu+NaWcp+PH6bjhchm9N7H0LPIayB8iV7SifX9vVhXM/2ADaXqjf0jyHzPkxtW
	vuRTsGBoQlZL15Uat8EbyMqvMaqCC7nZWJg8J5FSOvYVD4Px656ox1JAWGsiWKCl63jh9nN+AqE
	5YWtMDj6CsMsEHIaXsbyTcSX3lvA7dfMNlHk1Qc9mYhmut0jmRF5n6QXp3s3jaPCu7WpospCBcm
	wX9qpnOwIAODIkKUmY/ZJKAk+XwfpHKyrZN4Gf4NQh85S6LyL3GdW5nAEnaolLIjYPHZ6WXTL82
	c6PtVHAIXfYPagMQCFrTquJ2ruzoppMFpcynHA7gSfqBEISEVsnWXVGjpNSVhR8tH1QKn/p1IvJ
	qSxY58EDZuFHSpx7Gwd5tNwUi144WRILxKuBsl00iuO/vteAuppK0nomET3PrOj2l7Sds
X-Google-Smtp-Source: AGHT+IFhWRkAjq0kp3rYVJajv166B7T+5igJwYiG9mr5QC8ggMyhPPllogHKb3eusDQL2P7c9HNNmg==
X-Received: by 2002:a05:6402:3582:b0:612:b0d9:3969 with SMTP id 4fb4d7f45d1cf-612b0d93f03mr5896945a12.8.1753138802656;
        Mon, 21 Jul 2025 16:00:02 -0700 (PDT)
Received: from [192.168.0.18] (cable-94-189-142-142.dynamic.sbb.rs. [94.189.142.142])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-612c8f543ddsm5962670a12.30.2025.07.21.16.00.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Jul 2025 16:00:01 -0700 (PDT)
Message-ID: <8f93322a-84c1-402b-b8d4-9c66a2b07b0b@gmail.com>
Date: Tue, 22 Jul 2025 00:59:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] kasan: unify static kasan_flag_enabled across
 modes
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250717142732.292822-1-snovitoll@gmail.com>
 <20250717142732.292822-3-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250717142732.292822-3-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250721_160004_489513_BF15CCFD 
X-CRM114-Status: GOOD (  29.31  )
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
> Historically, the runtime static key kasan_flag_enabled existed only for
> CONFIG_KASAN_HW_TAGS mode. Generic and SW_TAGS modes either relied on
> architecture-specific kasan_arch_is_ready() implementations or evaluated
> KASAN checks unconditionally, leading to code duplication.
> 
> This patch implements two-level approach:
> 
> 1. kasan_enabled() - controls if KASAN is enabled at all (compile-time)
> 2. kasan_shadow_initialized() - tracks shadow memory
>    initialization (runtime)
> 
> For architectures that select ARCH_DEFER_KASAN: kasan_shadow_initialized()
> uses a static key that gets enabled when shadow memory is ready.
> 
> For architectures that don't: kasan_shadow_initialized() returns
> IS_ENABLED(CONFIG_KASAN) since shadow is ready from the start.
> 
> This provides:
> - Consistent interface across all KASAN modes
> - Runtime control only where actually needed
> - Compile-time constants for optimal performance where possible
> - Clear separation between "KASAN configured" vs "shadow ready"
> 
> Also adds kasan_init_generic() function that enables the shadow flag and
> handles initialization for Generic mode, and updates SW_TAGS and HW_TAGS
> to use the unified kasan_shadow_enable() function.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v3:
> - Only architectures that need deferred KASAN get runtime overhead
> - Added kasan_shadow_initialized() for shadow memory readiness tracking
> - kasan_enabled() now provides compile-time check for KASAN configuration
> ---
>  include/linux/kasan-enabled.h | 34 ++++++++++++++++++++++++++--------
>  include/linux/kasan.h         |  6 ++++++
>  mm/kasan/common.c             |  9 +++++++++
>  mm/kasan/generic.c            | 11 +++++++++++
>  mm/kasan/hw_tags.c            |  9 +--------
>  mm/kasan/sw_tags.c            |  2 ++
>  6 files changed, 55 insertions(+), 16 deletions(-)
> 
> diff --git a/include/linux/kasan-enabled.h b/include/linux/kasan-enabled.h
> index 6f612d69ea0..fa99dc58f95 100644
> --- a/include/linux/kasan-enabled.h
> +++ b/include/linux/kasan-enabled.h
> @@ -4,32 +4,50 @@
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
> +#ifdef CONFIG_ARCH_DEFER_KASAN
> +/*
> + * Global runtime flag for architectures that need deferred KASAN.
> + * Switched to 'true' by the appropriate kasan_init_*()
> + * once KASAN is fully initialized.
> + */
>  DECLARE_STATIC_KEY_FALSE(kasan_flag_enabled);
>  
> -static __always_inline bool kasan_enabled(void)
> +static __always_inline bool kasan_shadow_initialized(void)
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
> -#else /* CONFIG_KASAN_HW_TAGS */
> +/* No-op for architectures that don't need deferred KASAN. */
> +static inline void kasan_enable(void) {}
> +#endif /* CONFIG_ARCH_DEFER_KASAN */
>  
> -static inline bool kasan_enabled(void)
> +#ifdef CONFIG_KASAN_HW_TAGS
> +static inline bool kasan_hw_tags_enabled(void)
>  {
> -	return IS_ENABLED(CONFIG_KASAN);
> +	return kasan_enabled();
>  }
> -
> +#else
>  static inline bool kasan_hw_tags_enabled(void)
>  {
>  	return false;
>  }
> -
>  #endif /* CONFIG_KASAN_HW_TAGS */
>  
>  #endif /* LINUX_KASAN_ENABLED_H */
> diff --git a/include/linux/kasan.h b/include/linux/kasan.h
> index 890011071f2..51a8293d1af 100644
> --- a/include/linux/kasan.h
> +++ b/include/linux/kasan.h
> @@ -543,6 +543,12 @@ void kasan_report_async(void);
>  
>  #endif /* CONFIG_KASAN_HW_TAGS */
>  
> +#ifdef CONFIG_KASAN_GENERIC
> +void __init kasan_init_generic(void);
> +#else
> +static inline void kasan_init_generic(void) { }
> +#endif
> +
>  #ifdef CONFIG_KASAN_SW_TAGS
>  void __init kasan_init_sw_tags(void);
>  #else
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index ed4873e18c7..c3a6446404d 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -32,6 +32,15 @@
>  #include "kasan.h"
>  #include "../slab.h"
>  
> +#ifdef CONFIG_ARCH_DEFER_KASAN
> +/*
> + * Definition of the unified static key declared in kasan-enabled.h.
> + * This provides consistent runtime enable/disable across KASAN modes.
> + */
> +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +EXPORT_SYMBOL(kasan_flag_enabled);
> +#endif
> +
>  struct slab *kasan_addr_to_slab(const void *addr)
>  {
>  	if (virt_addr_valid(addr))
> diff --git a/mm/kasan/generic.c b/mm/kasan/generic.c
> index d54e89f8c3e..03b6d322ff6 100644
> --- a/mm/kasan/generic.c
> +++ b/mm/kasan/generic.c
> @@ -36,6 +36,17 @@
>  #include "kasan.h"
>  #include "../slab.h"
>  
> +/*
> + * Initialize Generic KASAN and enable runtime checks.
> + * This should be called from arch kasan_init() once shadow memory is ready.
> + */
> +void __init kasan_init_generic(void)
> +{
> +	kasan_enable();
> +
> +	pr_info("KernelAddressSanitizer initialized (generic)\n");
> +}
> +
>  /*
>   * All functions below always inlined so compiler could
>   * perform better optimizations in each of __asan_loadX/__assn_storeX
> diff --git a/mm/kasan/hw_tags.c b/mm/kasan/hw_tags.c
> index 9a6927394b5..c8289a3feab 100644
> --- a/mm/kasan/hw_tags.c
> +++ b/mm/kasan/hw_tags.c
> @@ -45,13 +45,6 @@ static enum kasan_arg kasan_arg __ro_after_init;
>  static enum kasan_arg_mode kasan_arg_mode __ro_after_init;
>  static enum kasan_arg_vmalloc kasan_arg_vmalloc __initdata;
>  
> -/*
> - * Whether KASAN is enabled at all.
> - * The value remains false until KASAN is initialized by kasan_init_hw_tags().
> - */
> -DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> -EXPORT_SYMBOL(kasan_flag_enabled);
> -
>  /*
>   * Whether the selected mode is synchronous, asynchronous, or asymmetric.
>   * Defaults to KASAN_MODE_SYNC.
> @@ -260,7 +253,7 @@ void __init kasan_init_hw_tags(void)
>  	kasan_init_tags();
>  
>  	/* KASAN is now initialized, enable it. */
> -	static_branch_enable(&kasan_flag_enabled);
> +	kasan_enable();
>  

This is obviously broken for the HW_TAGS case. kasan_enable() does nothing,
and kasan_hw_tags_enabled() now always return true.

