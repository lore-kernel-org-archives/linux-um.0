Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 514ECC7EE31
	for <linux-um@archiver.kernel.org>; Thu, 26 Jun 2025 13:33:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=p1Vrlz3g9lucIoHJorqCas+zLBoRLvQnyL0+A+0WnpA=; b=m+Ptkr3m0Voqhkm+eZ9cZHZ5EH
	YTshcqIRNZBeQQHUFRu7FNmq/FHerPPXn+8RYHIFEzSkOSO1Irul0X+tSRAh8FisNScZSSpYq6pSY
	pbGmmDvZD8yiVWA9Vygu4bXXVAwzp0XT6ttpV6IruTIrGfY7ecMLcwuTWYx3NuK4Bwu9j4Qeb+kTn
	4avbvFKaNvdKdk/KNoPdCqMgCDYwA3oU9Lv4PydDSBiGfFr/brJ5F/GvKVkUWf15A4URlAzZlWMkF
	FbZGC6imd84JLwFB8akG7cxNrvQ9dX07B/PkroE7dWNUQzvYCQ7OAEnHkcKwTxKu5RQ6SjwWM+QOH
	fBO8DH/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmj4-0000000BgN0-3wkl;
	Thu, 26 Jun 2025 13:33:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmfp-0000000Bfyp-1mPm;
	Thu, 26 Jun 2025 13:29:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=p1Vrlz3g9lucIoHJorqCas+zLBoRLvQnyL0+A+0WnpA=; b=mBNUpeDFYHG7orfAPa6AC3yITs
	wxmxpTh9AObxBPIaUX4pFb8wE8AnO8c/Ndl23AbEuOrgwlCO6RDGwY9LUiqizTNHkDoI9Ba+0Wgj0
	pX7uLGlriKUYuHwiofMoZiktvWNgyLJyHYp2NhGz5Vprhr18X9IvHfEp22IACOrrf4gpKIotChlGj
	imiUGNU/Z1GhPgSWoqhkp6W93i9q1tqHFWYzVQog0c7J4Qaj9QkShWqygMq6vv6Dv3w4ZgG5CZJ8m
	IkpBbwX/8k7/3PaT7NRHYC9Gv6SQY4hlDJ2hX1sQHoXxFGE5cYATi5pWrT1Hi3oOxmDMXD08EG2Ez
	N9J4GBiA==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by casper.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uUmfg-0000000Biam-20O3;
	Thu, 26 Jun 2025 13:29:44 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id 5644930BDA9; Thu, 26 Jun 2025 15:29:43 +0200 (CEST)
Date: Thu, 26 Jun 2025 15:29:43 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
Cc: ryabinin.a.a@gmail.com, glider@google.com, andreyknvl@gmail.com,
	dvyukov@google.com, vincenzo.frascino@arm.com,
	catalin.marinas@arm.com, will@kernel.org, chenhuacai@kernel.org,
	kernel@xen0n.name, maddy@linux.ibm.com, mpe@ellerman.id.au,
	npiggin@gmail.com, christophe.leroy@csgroup.eu, hca@linux.ibm.com,
	gor@linux.ibm.com, agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	dave.hansen@linux.intel.com, luto@kernel.org, tglx@linutronix.de,
	mingo@redhat.com, bp@alien8.de, x86@kernel.org, hpa@zytor.com,
	chris@zankel.net, jcmvbkbc@gmail.com, akpm@linux-foundation.org,
	guoweikang.kernel@gmail.com, geert@linux-m68k.org, rppt@kernel.org,
	tiwei.btw@antgroup.com, richard.weiyang@gmail.com,
	benjamin.berg@intel.com, kevin.brodsky@arm.com,
	kasan-dev@googlegroups.com, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
	linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
	linux-um@lists.infradead.org, linux-mm@kvack.org
Subject: Re: [PATCH 5/9] kasan/loongarch: call kasan_init_generic in
 kasan_init
Message-ID: <20250626132943.GJ1613200@noisy.programming.kicks-ass.net>
References: <20250625095224.118679-1-snovitoll@gmail.com>
 <20250625095224.118679-6-snovitoll@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250625095224.118679-6-snovitoll@gmail.com>
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

On Wed, Jun 25, 2025 at 02:52:20PM +0500, Sabyrzhan Tasbolatov wrote:
> Call kasan_init_generic() which enables the static flag
> to mark generic KASAN initialized, otherwise it's an inline stub.
> 
> Replace `kasan_arch_is_ready` with `kasan_enabled`.
> Delete the flag `kasan_early_stage` in favor of the global static key
> enabled via kasan_enabled().
> 
> printk banner is printed earlier right where `kasan_early_stage`
> was flipped, just to keep the same flow.
> 
> Closes: https://bugzilla.kernel.org/show_bug.cgi?id=218315
> Signed-off-by: Sabyrzhan Tasbolatov <snovitoll@gmail.com>
> ---
>  arch/loongarch/include/asm/kasan.h | 7 -------
>  arch/loongarch/mm/kasan_init.c     | 7 ++-----
>  2 files changed, 2 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/loongarch/include/asm/kasan.h b/arch/loongarch/include/asm/kasan.h
> index 7f52bd31b9d..b0b74871257 100644
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
>  		return (void *)(kasan_early_shadow_page);
>  	} else {
>  		unsigned long maddr = (unsigned long)addr;
> @@ -298,7 +296,7 @@ void __init kasan_init(void)
>  	kasan_populate_early_shadow(kasan_mem_to_shadow((void *)VMALLOC_START),
>  					kasan_mem_to_shadow((void *)KFENCE_AREA_END));
>  
> -	kasan_early_stage = false;
> +	kasan_init_generic();
>  
>  	/* Populate the linear mapping */
>  	for_each_mem_range(i, &pa_start, &pa_end) {
> @@ -329,5 +327,4 @@ void __init kasan_init(void)
>  
>  	/* At this point kasan is fully initialized. Enable error messages */
>  	init_task.kasan_depth = 0;
> -	pr_info("KernelAddressSanitizer initialized.\n");
>  }

This one is weird because its the only arch that does things after
marking early_state false.

Is that really correct, or should kasan_init_generic() be last, like all
the other architectures?

Also, please move init_task.kasan_depth = 0 into the generic thing.
ARM64 might have fooled you with the wrapper function, but they all do
this right before that pr_info you're taking out.

