Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CF32CA1014
	for <linux-um@archiver.kernel.org>; Thu,  4 Sep 2025 03:26:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Message-ID:Date:
	In-Reply-To:Subject:Cc:To:From:Reply-To:MIME-Version:Content-Type:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=M9wjahpjajRVdLTvLPg2jmwGdR+YAWepelf042yY0AY=; b=rRupqFYrqcWpEFNhjNRi2iXVtL
	sDTHNBdnewkEfCTps7MrJmJGc5eJv2ArKSpS2dfY0NRXjmzF5ReIdiiww/V47yFq+OdYyUEvoje7f
	cDKoaKZB74AxGhQNFlD791Pw+oQyHiv4lBD8rumQXpy/MeT8gXRpcoEGbBoaMSlI05o/XdfMNimnZ
	qtoOzT7txlwt+NNITfn3jB4qY+TlehN3gRCT/g+dqlyJW+ZB5s2gX2Z7hDuG7DviBv27z+uZQ0AaY
	WeKowTG2glahwH+MjYV/3jz9MHpsqO48AovNiTDybYrtlzdTdC5Cvm75EDHLWkWhrys9TbWb7jRQt
	vUkzed5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uu0bn-00000008fQq-2pwc;
	Thu, 04 Sep 2025 03:25:59 +0000
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uty06-000000080KF-1s8J;
	Thu, 04 Sep 2025 00:38:55 +0000
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-b47475cf8ecso257798a12.0;
        Wed, 03 Sep 2025 17:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756946333; x=1757551133; darn=lists.infradead.org;
        h=references:message-id:date:in-reply-to:subject:cc:to:from:from:to
         :cc:subject:date:message-id:reply-to;
        bh=M9wjahpjajRVdLTvLPg2jmwGdR+YAWepelf042yY0AY=;
        b=JRwD2giJ5NdXsINsWQ65djK/ib5xxnmjvAoXfHBHoZFTDZUCmgBrwOCShOrd12rjqA
         eFFJYTaeYtPUQjEcy7jOWtutUIgak9xouKAmFSXhj9C7xNJYGy2NO3yVrm1u5Ew4MPxC
         ln6eHDfCI0meJsG0R0dVm+4YD0p+dxDWB/FxSuK3R7h0nZ3mRIpuJFsVubjbvOF7g4Fi
         OjjoTTR53V4ZIM/rlkJ+Vmpwvqc0I+nOoyjkqG9CYiJzkK98rMQRZUixAoNeaLkc43pN
         WBAWCgD/cVrDC61dky/rMX5VczD4bKWPPpYzRL2AObvZSA84H9jXwWG7OY2Q5xFbTNd1
         nVMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756946333; x=1757551133;
        h=references:message-id:date:in-reply-to:subject:cc:to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M9wjahpjajRVdLTvLPg2jmwGdR+YAWepelf042yY0AY=;
        b=eGgXLPiOY+RyNmEOetOqdpLkeeneDmDPzYsvlZ1flKw91mam6ydT7TTbKvK2pQFEu6
         qLwev7wxMNbnc+4k//Bu1/dIe9D7XXPxxAygfv1hwPkQoqe4lQNNXzV+Tfo/ZMn3Im9Z
         OUZQBfahYoC5IvH9bYWpBpqWd0gYAu1K9VgRVkGySEyO2p7+8Y7FItBDvPVQP291L8to
         0UMyzoBvIXnE8xUVcKStrpQ66aDVuoTElZZp6wNWUTrjnNvBpd4ZABirQH+aum0GBqO+
         k/Wu84ACejPLjj07UYo34wsr+SqjkJJZHItFFAeQppxc3h2Mv+jx+efzVjCv2aJMYmma
         SYgQ==
X-Forwarded-Encrypted: i=1; AJvYcCUQ5QZ1IUF1iPEmukn7sMdL0JW2MrsNGdx2tmJIzC63CpuzSWp2afdJd4VhjPxymu8RbAFvbEneVvk=@lists.infradead.org, AJvYcCV2Egokw/i1zbzly0Squaf6mXdkiX/r5a7Fmd2lPNfWgv4V+TbLj7kLCGv9Bwu1wa3F9Gsq0x+129d5J/M=@lists.infradead.org, AJvYcCWvdj7C59hpxvSZGFaO3FCXH2xxDI3pjqhS0OBNFDdk4HncV3VewopMLxjQAzJr7Q/v/VFNE/Ncw8wST7ChBkrE@lists.infradead.org
X-Gm-Message-State: AOJu0YwZ8FcidIHehVVRsLJOr2Cf/s/dRLaQd04Xu8DlxmCNlJ3a1MgT
	jXA56lFWx3t5Lfel6l8QMmpa6zY5WExtulYTH+QXhPOuGahKQecchHi+Imbn0Lhi
X-Gm-Gg: ASbGncv37edz+nk40u+8G1k1Ufo8l37hVIVKireSZVVcPcDH6NjR9fHScemH/OHtId+
	fMX/X0F0UijjTl4MUBZkkQ3LsWXBi/bV/JctexETP8u5jkaiPmxrO1nWj2jlS4EWKnImGV4nC7j
	eRfLwCRuxktPc9Z+EcYOmBcdLkqWUCymEJHhvjonQEjkqyU2EPZc68F8wf7CNTy4hIZIcBn2HuU
	Gvghvkt9m/WOCFXL30ZkNNq875jIL/qDWjP4dD13M2dPiUuk8MKpNtx8+d+7iGKNRc0I5nPRFOh
	yCjNdda13hIbMAK16Pet1jH0R7MvE/QuAf9vS43zuklg+X/iv8LJVFwBKVSeXn6HyILv01tF6Vl
	rlDDKfg8JqPy3Xjbsjomb6qY=
X-Google-Smtp-Source: AGHT+IF8fWb/70JgPLh7N7Xn466vomeY7twFDDtFD6ID6JfG4YJmNgXkQZrYmfFbnlzFyM4OYAuWoQ==
X-Received: by 2002:a17:90b:3811:b0:32b:6145:fa63 with SMTP id 98e67ed59e1d1-32b614601acmr4849866a91.4.1756946333006;
        Wed, 03 Sep 2025 17:38:53 -0700 (PDT)
Received: from dw-tp ([171.76.85.3])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-b4fb98f9f6asm1185841a12.8.2025.09.03.17.38.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Sep 2025 17:38:52 -0700 (PDT)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>, ryabinin.a.a@gmail.com, christophe.leroy@csgroup.eu, bhe@redhat.com, hca@linux.ibm.com, andreyknvl@gmail.com, akpm@linux-foundation.org, zhangqing@loongson.cn, chenhuacai@loongson.cn, davidgow@google.com, glider@google.com, dvyukov@google.com, alexghiti@rivosinc.com
Cc: alex@ghiti.fr, agordeev@linux.ibm.com, vincenzo.frascino@arm.com, elver@google.com, kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-mm@kvack.org, snovitoll@gmail.com
Subject: Re: [PATCH v6 1/2] kasan: introduce ARCH_DEFER_KASAN and unify static key across modes
In-Reply-To: <20250810125746.1105476-2-snovitoll@gmail.com>
Date: Thu, 04 Sep 2025 05:54:04 +0530
Message-ID: <87ldmv6p5n.ritesh.list@gmail.com>
References: <20250810125746.1105476-1-snovitoll@gmail.com> <20250810125746.1105476-2-snovitoll@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250903_173854_489722_E3BED632 
X-CRM114-Status: GOOD (  31.96  )
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

Sabyrzhan Tasbolatov <snovitoll@gmail.com> writes:

> Introduce CONFIG_ARCH_DEFER_KASAN to identify architectures [1] that need
> to defer KASAN initialization until shadow memory is properly set up,
> and unify the static key infrastructure across all KASAN modes.
>
> [1] PowerPC, UML, LoongArch selects ARCH_DEFER_KASAN.
>
> The core issue is that different architectures haveinconsistent approaches
> to KASAN readiness tracking:
> - PowerPC, LoongArch, and UML arch, each implement own
>   kasan_arch_is_ready()
> - Only HW_TAGS mode had a unified static key (kasan_flag_enabled)
> - Generic and SW_TAGS modes relied on arch-specific solutions or always-on
>     behavior
>
> This patch addresses the fragmentation in KASAN initialization
> across architectures by introducing a unified approach that eliminates
> duplicate static keys and arch-specific kasan_arch_is_ready()
> implementations.
>
> Let's replace kasan_arch_is_ready() with existing kasan_enabled() check,
> which examines the static key being enabled if arch selects
> ARCH_DEFER_KASAN or has HW_TAGS mode support.
> For other arch, kasan_enabled() checks the enablement during compile time.
>
> Now KASAN users can use a single kasan_enabled() check everywhere.
>
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=217049
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
> Changes in v6:
> - Added more details in git commit message
> - Fixed commenting format per coding style in UML (Christophe Leroy)
> - Changed exporting to GPL for kasan_flag_enabled (Christophe Leroy)
> - Converted ARCH_DEFER_KASAN to def_bool depending on KASAN to avoid
>         arch users to have `if KASAN` condition (Christophe Leroy)
> - Forgot to add __init for kasan_init in UML
>
> Changes in v5:
> - Unified patches where arch (powerpc, UML, loongarch) selects
>     ARCH_DEFER_KASAN in the first patch not to break
>     bisectability
> - Removed kasan_arch_is_ready completely as there is no user
> - Removed __wrappers in v4, left only those where it's necessary
>     due to different implementations
>
> Changes in v4:
> - Fixed HW_TAGS static key functionality (was broken in v3)
> - Merged configuration and implementation for atomicity
> ---
>  arch/loongarch/Kconfig                 |  1 +
>  arch/loongarch/include/asm/kasan.h     |  7 ------
>  arch/loongarch/mm/kasan_init.c         |  8 +++----
>  arch/powerpc/Kconfig                   |  1 +
>  arch/powerpc/include/asm/kasan.h       | 12 ----------
>  arch/powerpc/mm/kasan/init_32.c        |  2 +-
>  arch/powerpc/mm/kasan/init_book3e_64.c |  2 +-
>  arch/powerpc/mm/kasan/init_book3s_64.c |  6 +----
>  arch/um/Kconfig                        |  1 +
>  arch/um/include/asm/kasan.h            |  5 ++--
>  arch/um/kernel/mem.c                   | 13 ++++++++---
>  include/linux/kasan-enabled.h          | 32 ++++++++++++++++++--------
>  include/linux/kasan.h                  |  6 +++++
>  lib/Kconfig.kasan                      | 12 ++++++++++
>  mm/kasan/common.c                      | 17 ++++++++++----
>  mm/kasan/generic.c                     | 19 +++++++++++----
>  mm/kasan/hw_tags.c                     |  9 +-------
>  mm/kasan/kasan.h                       |  8 ++++++-
>  mm/kasan/shadow.c                      | 12 +++++-----
>  mm/kasan/sw_tags.c                     |  1 +
>  mm/kasan/tags.c                        |  2 +-
>  21 files changed, 106 insertions(+), 70 deletions(-)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 93402a1d9c9f..4730c676b6bf 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -122,6 +122,7 @@ config PPC
>  	# Please keep this list sorted alphabetically.
>  	#
>  	select ARCH_32BIT_OFF_T if PPC32
> +	select ARCH_NEEDS_DEFER_KASAN		if PPC_RADIX_MMU
>  	select ARCH_DISABLE_KASAN_INLINE	if PPC_RADIX_MMU
>  	select ARCH_DMA_DEFAULT_COHERENT	if !NOT_COHERENT_CACHE
>  	select ARCH_ENABLE_MEMORY_HOTPLUG
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index b5bbb94c51f6..957a57c1db58 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -53,18 +53,6 @@
>  #endif
>  
>  #ifdef CONFIG_KASAN
> -#ifdef CONFIG_PPC_BOOK3S_64
> -DECLARE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> -
> -static __always_inline bool kasan_arch_is_ready(void)
> -{
> -	if (static_branch_likely(&powerpc_kasan_enabled_key))
> -		return true;
> -	return false;
> -}
> -
> -#define kasan_arch_is_ready kasan_arch_is_ready
> -#endif
>  
>  void kasan_early_init(void);
>  void kasan_mmu_init(void);
> diff --git a/arch/powerpc/mm/kasan/init_32.c b/arch/powerpc/mm/kasan/init_32.c
> index 03666d790a53..1d083597464f 100644
> --- a/arch/powerpc/mm/kasan/init_32.c
> +++ b/arch/powerpc/mm/kasan/init_32.c
> @@ -165,7 +165,7 @@ void __init kasan_init(void)
>  
>  	/* At this point kasan is fully initialized. Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KASAN init done\n");
> +	kasan_init_generic();
>  }
>  
>  void __init kasan_late_init(void)
> diff --git a/arch/powerpc/mm/kasan/init_book3e_64.c b/arch/powerpc/mm/kasan/init_book3e_64.c
> index 60c78aac0f63..0d3a73d6d4b0 100644
> --- a/arch/powerpc/mm/kasan/init_book3e_64.c
> +++ b/arch/powerpc/mm/kasan/init_book3e_64.c
> @@ -127,7 +127,7 @@ void __init kasan_init(void)
>  
>  	/* Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KASAN init done\n");
> +	kasan_init_generic();
>  }
>  
>  void __init kasan_late_init(void) { }
> diff --git a/arch/powerpc/mm/kasan/init_book3s_64.c b/arch/powerpc/mm/kasan/init_book3s_64.c
> index 7d959544c077..dcafa641804c 100644
> --- a/arch/powerpc/mm/kasan/init_book3s_64.c
> +++ b/arch/powerpc/mm/kasan/init_book3s_64.c
> @@ -19,8 +19,6 @@
>  #include <linux/memblock.h>
>  #include <asm/pgalloc.h>
>  
> -DEFINE_STATIC_KEY_FALSE(powerpc_kasan_enabled_key);
> -
>  static void __init kasan_init_phys_region(void *start, void *end)
>  {
>  	unsigned long k_start, k_end, k_cur;
> @@ -92,11 +90,9 @@ void __init kasan_init(void)
>  	 */
>  	memset(kasan_early_shadow_page, 0, PAGE_SIZE);
>  
> -	static_branch_inc(&powerpc_kasan_enabled_key);
> -
>  	/* Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KASAN init done\n");
> +	kasan_init_generic();
>  }
>  

Only book3s64 needs static keys here because of radix v/s hash mode
selection during runtime. The changes in above for powerpc looks good to
me. It's a nice cleanup too.

So feel free to take:
Reviewed-by: Ritesh Harjani (IBM) <ritesh.list@gmail.com> #powerpc

However I have few comments below...

...
> diff --git a/mm/kasan/common.c b/mm/kasan/common.c
> index 9142964ab9c9..e3765931a31f 100644
> --- a/mm/kasan/common.c
> +++ b/mm/kasan/common.c
> @@ -32,6 +32,15 @@
>  #include "kasan.h"
>  #include "../slab.h"
>  
> +#if defined(CONFIG_ARCH_DEFER_KASAN) || defined(CONFIG_KASAN_HW_TAGS)
> +/*
> + * Definition of the unified static key declared in kasan-enabled.h.
> + * This provides consistent runtime enable/disable across KASAN modes.
> + */
> +DEFINE_STATIC_KEY_FALSE(kasan_flag_enabled);
> +EXPORT_SYMBOL_GPL(kasan_flag_enabled);
> +#endif
> +
>  struct slab *kasan_addr_to_slab(const void *addr)
>  {
>  	if (virt_addr_valid(addr))
> @@ -246,7 +255,7 @@ static inline void poison_slab_object(struct kmem_cache *cache, void *object,
>  bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>  				unsigned long ip)
>  {
> -	if (!kasan_arch_is_ready() || is_kfence_address(object))
> +	if (is_kfence_address(object))

For changes in mm/kasan/common.c.. you have removed !kasan_enabled()
check at few places. This seems to be partial revert of commit [1]:
  
  b3c34245756ada "kasan: catch invalid free before SLUB reinitializes the object" 

Can you please explain why this needs to be removed? 
Also the explaination of the same should be added in the commit msg too.

[1]: https://lore.kernel.org/all/20240809-kasan-tsbrcu-v8-1-aef4593f9532@google.com/

>  		return false;
>  	return check_slab_allocation(cache, object, ip);
>  }
> @@ -254,7 +263,7 @@ bool __kasan_slab_pre_free(struct kmem_cache *cache, void *object,
>  bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  		       bool still_accessible)
>  {
> -	if (!kasan_arch_is_ready() || is_kfence_address(object))
> +	if (is_kfence_address(object))
>  		return false;
>  
>  	/*
> @@ -293,7 +302,7 @@ bool __kasan_slab_free(struct kmem_cache *cache, void *object, bool init,
>  
>  static inline bool check_page_allocation(void *ptr, unsigned long ip)
>  {
> -	if (!kasan_arch_is_ready())
> +	if (!kasan_enabled())
>  		return false;
>  
>  	if (ptr != page_address(virt_to_head_page(ptr))) {
> @@ -522,7 +531,7 @@ bool __kasan_mempool_poison_object(void *ptr, unsigned long ip)
>  		return true;
>  	}
>  
> -	if (is_kfence_address(ptr) || !kasan_arch_is_ready())
> +	if (is_kfence_address(ptr))
>  		return true;
>  
>  	slab = folio_slab(folio);

-ritesh

