Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2EA97C87FD1
	for <linux-um@archiver.kernel.org>; Tue,  5 Aug 2025 17:48:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RZ2R+1+DK7TrYxovSWYDOowvbSOnIqHJEfLqNkyHn6I=; b=a0BthKOWwa28WNp8erJ70nwWQ2
	U72mkbM12LB/MKlg+bnzDcRr0KMn17yAahX1N2qF2hfMVAKDqEBFT9I4SrBoE8dN2Hc0Sl6O1XL6p
	kSQwY1aeJWBoK1g4cUHBO/1bc7xczUxs/ul0NO8ALvisPRDBirt8W9gwM+/RaWQnei5cT7kMDXTvf
	j+IFEse4AkGn0VQfHv6E+5vrHR5iWLk3JK7Fl9CBT86I0NljwKVwa5QAiDZkbCpVtRWYj4mgMEfwr
	zqA8WGvES/GJh1cNBpQ/1ee0UmeEsMNFaQtw5sY8AoYeAjw3+qBcsw73kSzf8ToSoCg7bBAlMBW9e
	r/NAUKZQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujLlj-0000000DT19-3LI2;
	Tue, 05 Aug 2025 17:48:11 +0000
Received: from mail-lj1-x22c.google.com ([2a00:1450:4864:20::22c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ujLIk-0000000DPMX-1hdX;
	Tue, 05 Aug 2025 17:18:15 +0000
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-332308477easo6581751fa.0;
        Tue, 05 Aug 2025 10:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1754414292; x=1755019092; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=RZ2R+1+DK7TrYxovSWYDOowvbSOnIqHJEfLqNkyHn6I=;
        b=RBmobwv6oNIN2Vtezz7YG1IU/dwHzZdSxU+qp4bYl9CIt7T7MR4NQvMEBQw/Mfn0un
         bEphFnKJh+SgF5fyCMmtmwg0dTi0jXI40X5Wru4WqQo0ulfSNv3YiqpUpq88ei+SEN8T
         0dl0xWy8HNj67LknS55N1rw+rNsFLlb1JOc9XAvj9BuCWOk7vjZC7m60m5Xi/y4dj2/Y
         uL3ShLMFVfcCVKtA2NZplJs4+YwHHIHBv24mzAn/iZ6REvbJ0DTO7N6t5FJtGm6AiG9T
         PdeqTOQcDP+05H0wYiJ83KBKYJpjbhy/trjWYzr5uVqYkFjWsRkscgvTngYtVq1TIsCs
         T7Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754414292; x=1755019092;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RZ2R+1+DK7TrYxovSWYDOowvbSOnIqHJEfLqNkyHn6I=;
        b=Ur6eLtEz6JBTHMp2IHGppTTDH3SkYLwmnx70WxH99C6E67lAHrc+D3ShvpccjjWl2E
         lo9CjG2gT8a6OHQ5gkzh0NGtVStZi2+WvlciwwwFeShYSalBCUF6bO6Sb/3CrsdW07rL
         Xji96w7KxqiUDGr+j0mYz2gChfY04Mwoxsncxzm8w/Y8T0GEYkjTsE2ZOADTsfBGtivt
         McJ4M/77W+WI/xikUaD7opHstSNHDunymj9tiZFjEhrtyNtvfl6Dtq9ar7KdnHXJxkOH
         PBKDkPWiJ4rfzYA04WDBFXk2wlhftoXNrCg9DhzEnVkmNnoHhJ7GRjFZqaBMOgjlOCgm
         qXoA==
X-Forwarded-Encrypted: i=1; AJvYcCWLD3iRIaa3mXuE/CGGllyLrrLOxacT7BBw4oB2OZ/Bqy3ni0PDqT/BQfxKhvwufG3hOgCZ0l52R6n/xg==@lists.infradead.org, AJvYcCWi7t5Yxvjw9kHwN+nWwodehPzwdTQn7PDLeMivA+sh0DHrHHsWQXLMOan8Qd0jtm/TS0qW40v+z9c=@lists.infradead.org
X-Gm-Message-State: AOJu0YxQqEmvZv11ep8sW0efsxhPgs4Rgmfm7lCJRRAaI/cCfIwOzCGS
	NyfbomXmAuZ/vnmNP7xY2e32CV+VIDrpzLy1VvaM6RWLIcbU44EQKxmF
X-Gm-Gg: ASbGncu7LQpnSXSDEZlMaDl5Wmjmo2PDY85QS7A5Dcx09hXKMGmTH5XHX9d2vyaO8Yx
	S0eJ7DO7Pv2jvLx2IkNqY6Lr5ZdBDDyMyVzetuQm9Qo6zCfTM1oFClKDZYAy2j9yZSAsbJ2fiiF
	HPPRT3etib/r4I1wUjAfvdSGhnyNEl2IrIJ0Wqskwuh4a2hvWOcbPmgfda/drsNPibgfHDzHqG9
	JdTCm14h9mo+q/4s6vH911Xl+7Ng4ibQtp8unSbwBsS43xe10EO7J5rVlWmR64pNUdC/Ddh2tu9
	0he6VRgZQypM9vRwA0XfaYcUAasxY7gnlHoWbxRat0hKuvDyeYIx/UsVsq0+USZqT779YVaRTTs
	zPmmeQyFHoiVN7GCYaAOAvURTQcmyOUa0T3rrQZA9QZn6JYcftA==
X-Google-Smtp-Source: AGHT+IFS2HbTLqS5A/HgTtiIoYjwUumHARImAD+oD4FUxoQg3JqtFBL0/dOcC7iWrPVn65io3WaVpA==
X-Received: by 2002:a2e:be24:0:b0:32b:5a24:b9d8 with SMTP id 38308e7fff4ca-33256856534mr14686731fa.8.1754414291879;
        Tue, 05 Aug 2025 10:18:11 -0700 (PDT)
Received: from [10.214.35.248] ([80.93.240.68])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-332382be4a7sm21072541fa.32.2025.08.05.10.18.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Aug 2025 10:18:11 -0700 (PDT)
Message-ID: <e15e1012-566f-45a7-81d5-fd504af780da@gmail.com>
Date: Tue, 5 Aug 2025 19:17:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/9] kasan/loongarch: select ARCH_DEFER_KASAN and call
 kasan_init_generic
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, hca@linux.ibm.com,
 christophe.leroy@csgroup.eu, andreyknvl@gmail.com, agordeev@linux.ibm.com,
 akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn,
 trishalfonso@google.com, davidgow@google.com
Cc: glider@google.com, dvyukov@google.com, kasan-dev@googlegroups.com,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org
References: <20250805142622.560992-1-snovitoll@gmail.com>
 <20250805142622.560992-6-snovitoll@gmail.com>
Content-Language: en-US
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
In-Reply-To: <20250805142622.560992-6-snovitoll@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250805_101814_451381_560223B1 
X-CRM114-Status: GOOD (  23.19  )
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
> LoongArch needs deferred KASAN initialization as it has a custom
> kasan_arch_is_ready() implementation that tracks shadow memory
> readiness via the kasan_early_stage flag.
> 
> Select ARCH_DEFER_KASAN to enable the unified static key mechanism
> for runtime KASAN control. Call kasan_init_generic() which handles
> Generic KASAN initialization and enables the static key.
> 
> Replace kasan_arch_is_ready() with kasan_enabled() and delete the
> flag kasan_early_stage in favor of the unified kasan_enabled()
> interface.
> 
> Note that init_task.kasan_depth = 0 is called after kasan_init_generic(),
> which is different than in other arch kasan_init(). This is left
> unchanged as it cannot be tested.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v4:
> - Replaced !kasan_enabled() with !kasan_shadow_initialized() in
>   loongarch which selects ARCH_DEFER_KASAN (Andrey Ryabinin)
> ---
>  arch/loongarch/Kconfig             | 1 +
>  arch/loongarch/include/asm/kasan.h | 7 -------
>  arch/loongarch/mm/kasan_init.c     | 8 ++------
>  3 files changed, 3 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
> index f0abc38c40a..f6304c073ec 100644
> --- a/arch/loongarch/Kconfig
> +++ b/arch/loongarch/Kconfig
> @@ -9,6 +9,7 @@ config LOONGARCH
>  	select ACPI_PPTT if ACPI
>  	select ACPI_SYSTEM_POWER_STATES_SUPPORT	if ACPI
>  	select ARCH_BINFMT_ELF_STATE
> +	select ARCH_DEFER_KASAN
>  	select ARCH_DISABLE_KASAN_INLINE
>  	select ARCH_ENABLE_MEMORY_HOTPLUG
>  	select ARCH_ENABLE_MEMORY_HOTREMOVE
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
> index d2681272d8f..57fb6e98376 100644
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
> +	if (!kasan_shadow_initialized()) {
>  		return (void *)(kasan_early_shadow_page);
>  	} else {
>  		unsigned long maddr = (unsigned long)addr;
> @@ -298,8 +296,6 @@ void __init kasan_init(void)
>  	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
>  					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
>  
> -	kasan_early_stage = false;
> -

There is a reason for this line to be here.
Your patch will change the result of the follow up kasan_mem_to_shadow() call and
feed the wrong address to kasan_map_populate()


>  	/* Populate the linear mapping */
>  	for_each_mem_range(i, &pa_start, &pa_end) {
>  		void *start = (void *)phys_to_virt(pa_start);
> @@ -329,5 +325,5 @@ void __init kasan_init(void)
>  
>  	/* At this point kasan is fully initialized. Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized.\n");
> +	kasan_init_generic();
>  }


