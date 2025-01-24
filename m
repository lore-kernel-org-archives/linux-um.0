Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3D0FC02181
	for <linux-um@archiver.kernel.org>; Fri, 24 Jan 2025 13:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J9XmywjVHeUTjwcf5l2PXOWSUMffMYwpksAkrprwOHU=; b=B0nQL57F/ifRxPdEWvYC/JGU5e
	xFcCv08KfYOAgG/dJ+Y/TdyYt+P3TYNOp+wghbcNTgORx1ugF4VwDXmF75I//hUQbSqU7WWAUFDLf
	qh/fTqp+KsnSr5x5wamfHKdRJwQVnWYCv3FnCCHQZCkX5DV1YeNzqqdm3HR1Tp2wpy3aWoNdsNhTG
	RuuzJ6F7zqj0L8v83SIvtbMaf+ugA6DKAufnmGs6+u4NNUP/hwXiQpRmVhgSgbX5EpScp5Dv9LBM/
	sTVEB4HsWGN3bUXemcMNe3h5lS2nTyTYq/SzGWWZPcaN3YopOSTxlab5ICVfyS8Q3gmH6GieLqmkh
	wzT3MtRQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tbJJC-0000000Ehow-2WIe;
	Fri, 24 Jan 2025 13:01:14 +0000
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tbJJ9-0000000EhmW-2iGo
	for linux-um@lists.infradead.org;
	Fri, 24 Jan 2025 13:01:13 +0000
Received: by mail-pj1-x102d.google.com with SMTP id 98e67ed59e1d1-2ee9a780de4so2842461a91.3
        for <linux-um@lists.infradead.org>; Fri, 24 Jan 2025 05:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1737723670; x=1738328470; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=J9XmywjVHeUTjwcf5l2PXOWSUMffMYwpksAkrprwOHU=;
        b=CL0qPiN9jjLtBQyVDQiCQsjH93iJgdc9XlAFsEMb1bnJaMXLe1Tz7aCMek0wSgctRC
         C1mcA/sPFm6pwGfn7AU5acPGPjG19o7I0FmY35atr+wR/cCyr90WqkWdsaNU7O67cqhb
         1YcNRb1+wkrOVnJ6pQ8qjWGUgsQScsI0gpcLKL8Y6o5wP7xmNxhJYmL17/FIw2nFVz5S
         jUlFyggZ98R0QAF94Fk0LTjD7CIRMWp47bdtyaoQp46r81NCAgKSYe7zysgpzM3sUB+7
         u5yxxDLK3Q3vSAOS+n5gxoeyzi96RbyGoqsfFGWjAiKxC2gF7g1wkrPcC+AmsxZYA+oh
         VISw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737723670; x=1738328470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J9XmywjVHeUTjwcf5l2PXOWSUMffMYwpksAkrprwOHU=;
        b=sYgmzOnZnZef6iMFIwSVsMc3VeIqi+O0U1kd66oK7ekljVmvKdmvvWcxdWSvmireMa
         KE/GKiiV5yKmntBNQTspQVHNOphZBddOX8Ks46bqPniQ0mXDW5z3TRNzb4/hq9Wl6VeT
         HMPUfVbHkQuoBi3osO80uxtuE0RFJ4bmVn4sH49+4q97jBYnlgFKIqLxqwy1zhBo0VMz
         sInou27RxGnPy30SXBJHmiTYvC+AQ45WvkgPVFJQiZOW7p0NIhhj79KpaMXGTpOnRO3P
         1OzgjiVc9k9mZkztGI7qMM+EgftWBad7FNzZPOTIEpvWAlyAoA+n/qIflEnxX+1XC4OZ
         4iKw==
X-Forwarded-Encrypted: i=1; AJvYcCU44IoJIj0sxzFmkUm/vTZqrpn23nC8E4/1vorwmtbLjkZ0k3kLdN52jGt28FQkELoEstrKkft8pQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxwXUuu0cexMZ/AKBPLI+Oq5wB++K0mktwK6aKuxzMoVzBB2XAs
	Dc0GmDGp68HXBWKlDMGoedB2hxYxtKmdYEszGmPlp9Msx/OoOF0G+SO6hVFs8Zo=
X-Gm-Gg: ASbGncsxXQFUXG9XyIrfohiyfFAK5doJCMM9APdvTFpaAF3wlfl5iR0QDdSUanyvOja
	nl/R18PxbUkU9APugmG8NbHz7IqCOZNV6VRLHUXmymvESeTP6tX7J6Cg7LlzPa6xkZayQxXLEiG
	7bzd3o+tuHsiTe7FDmZaSPiykV0kgVxnxSS7KyJjWSkm7kr+vkoGJ+EBvU1TfKoNIETgdqzCoEi
	lIZhEXh2+7rQfMQSShqfdi32Itel1GV8pGKNDOrgZVZhJLNDuxrFOYnrVG6awXyCNmjgTIdnfG2
	4Z8eOFAo2GRZYFrtMmJQrjE2Mccis5NAT04ftvK+5bQbfiGxGAuiC3u4a2oLSg0gf52PPwGJPWl
	ePuQL
X-Google-Smtp-Source: AGHT+IErpp3kusfvXhlhlaUEnTbjj0q85I8IgEHut5MJR7L8i7tS+ZolAw1OFFdRR3HhDghe0oVaNg==
X-Received: by 2002:a17:90b:2e41:b0:2ee:b875:6d30 with SMTP id 98e67ed59e1d1-2f782c779d1mr44385106a91.9.1737723669817;
        Fri, 24 Jan 2025 05:01:09 -0800 (PST)
Received: from ?IPV6:240e:370:8b13:5250:f0b9:2326:6cb0:b423? ([240e:370:8b13:5250:f0b9:2326:6cb0:b423])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2f7ffa6b269sm1606110a91.24.2025.01.24.05.01.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Jan 2025 05:01:09 -0800 (PST)
Message-ID: <45651097-c056-49e3-9cc8-c289c1c0030d@bytedance.com>
Date: Fri, 24 Jan 2025 21:00:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] x86: pgtable: unconditionally use tlb_remove_table()
Content-Language: en-US
To: Peter Zijlstra <peterz@infradead.org>
Cc: kevin.brodsky@arm.com, riel@surriel.com, vishal.moola@gmail.com,
 david@redhat.com, jannh@google.com, hughd@google.com, willy@infradead.org,
 yuzhao@google.com, muchun.song@linux.dev, akpm@linux-foundation.org,
 will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, arnd@arndb.de,
 dave.hansen@linux.intel.com, rppt@kernel.org, alexghiti@rivosinc.com,
 linux-mm@kvack.org, linux-kernel@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org, x86@kernel.org,
 linux-riscv@lists.infradead.org
References: <cover.1737637631.git.zhengqi.arch@bytedance.com>
 <00bf7935d65826eee547ac195d7854b1c946dbc5.1737637631.git.zhengqi.arch@bytedance.com>
 <20250124113854.GA15996@noisy.programming.kicks-ass.net>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250124113854.GA15996@noisy.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250124_050111_791571_F7B0D12B 
X-CRM114-Status: GOOD (  18.38  )
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



On 2025/1/24 19:38, Peter Zijlstra wrote:
> On Thu, Jan 23, 2025 at 09:26:17PM +0800, Qi Zheng wrote:
>> If the CONFIG_MMU_GATHER_TABLE_FREE is disabled, the tlb_remove_table()
>> will fall back to pagetable_dtor() + tlb_remove_page(). So let's use
>> tlb_remove_table() unconditionally to free page table pages.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> 
> I think we can clean up more :-)

Yes, but Rik van Riel has already done the same thing in his patch 
series [1], so I was originally planning to wait for his patch to be
merged into the linux-next branch, and then rebase this series onto his
patch.

[1]. https://lore.kernel.org/lkml/20250120024104.1924753-1-riel@surriel.com/

Thanks!

> 
> 
> diff --git a/arch/x86/hyperv/mmu.c b/arch/x86/hyperv/mmu.c
> index cc8c3bd0e7c2..1f7c3082a36d 100644
> --- a/arch/x86/hyperv/mmu.c
> +++ b/arch/x86/hyperv/mmu.c
> @@ -239,5 +239,4 @@ void hyperv_setup_mmu_ops(void)
>   
>   	pr_info("Using hypercall for remote TLB flush\n");
>   	pv_ops.mmu.flush_tlb_multi = hyperv_flush_tlb_multi;
> -	pv_ops.mmu.tlb_remove_table = tlb_remove_table;
>   }
> diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
> index 041aff51eb50..38a632a282d4 100644
> --- a/arch/x86/include/asm/paravirt.h
> +++ b/arch/x86/include/asm/paravirt.h
> @@ -91,11 +91,6 @@ static inline void __flush_tlb_multi(const struct cpumask *cpumask,
>   	PVOP_VCALL2(mmu.flush_tlb_multi, cpumask, info);
>   }
>   
> -static inline void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
> -{
> -	PVOP_VCALL2(mmu.tlb_remove_table, tlb, table);
> -}
> -
>   static inline void paravirt_arch_exit_mmap(struct mm_struct *mm)
>   {
>   	PVOP_VCALL1(mmu.exit_mmap, mm);
> diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
> index fea56b04f436..e26633c00455 100644
> --- a/arch/x86/include/asm/paravirt_types.h
> +++ b/arch/x86/include/asm/paravirt_types.h
> @@ -134,8 +134,6 @@ struct pv_mmu_ops {
>   	void (*flush_tlb_multi)(const struct cpumask *cpus,
>   				const struct flush_tlb_info *info);
>   
> -	void (*tlb_remove_table)(struct mmu_gather *tlb, void *table);
> -
>   	/* Hook for intercepting the destruction of an mm_struct. */
>   	void (*exit_mmap)(struct mm_struct *mm);
>   	void (*notify_page_enc_status_changed)(unsigned long pfn, int npages, bool enc);
> diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
> index 7a422a6c5983..3be9b3342c67 100644
> --- a/arch/x86/kernel/kvm.c
> +++ b/arch/x86/kernel/kvm.c
> @@ -838,7 +838,6 @@ static void __init kvm_guest_init(void)
>   #ifdef CONFIG_SMP
>   	if (pv_tlb_flush_supported()) {
>   		pv_ops.mmu.flush_tlb_multi = kvm_flush_tlb_multi;
> -		pv_ops.mmu.tlb_remove_table = tlb_remove_table;
>   		pr_info("KVM setup pv remote TLB flush\n");
>   	}
>   
> diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
> index 527f5605aa3e..2aa251d0b308 100644
> --- a/arch/x86/kernel/paravirt.c
> +++ b/arch/x86/kernel/paravirt.c
> @@ -180,7 +180,6 @@ struct paravirt_patch_template pv_ops = {
>   	.mmu.flush_tlb_kernel	= native_flush_tlb_global,
>   	.mmu.flush_tlb_one_user	= native_flush_tlb_one_user,
>   	.mmu.flush_tlb_multi	= native_flush_tlb_multi,
> -	.mmu.tlb_remove_table	= tlb_remove_table,
>   
>   	.mmu.exit_mmap		= paravirt_nop,
>   	.mmu.notify_page_enc_status_changed	= paravirt_nop,
> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
> index 3bc8ad282b27..b1c1f72c1fd1 100644
> --- a/arch/x86/mm/pgtable.c
> +++ b/arch/x86/mm/pgtable.c
> @@ -18,14 +18,6 @@ EXPORT_SYMBOL(physical_mask);
>   #define PGTABLE_HIGHMEM 0
>   #endif
>   
> -#ifndef CONFIG_PARAVIRT
> -static inline
> -void paravirt_tlb_remove_table(struct mmu_gather *tlb, void *table)
> -{
> -	tlb_remove_table(tlb, table);
> -}
> -#endif /* !CONFIG_PARAVIRT */
> -
>   gfp_t __userpte_alloc_gfp = GFP_PGTABLE_USER | PGTABLE_HIGHMEM;
>   
>   pgtable_t pte_alloc_one(struct mm_struct *mm)
> @@ -53,7 +45,7 @@ early_param("userpte", setup_userpte);
>   void ___pte_free_tlb(struct mmu_gather *tlb, struct page *pte)
>   {
>   	paravirt_release_pte(page_to_pfn(pte));
> -	paravirt_tlb_remove_table(tlb, page_ptdesc(pte));
> +	tlb_remove_table(tlb, page_ptdesc(pte));
>   }
>   
>   #if CONFIG_PGTABLE_LEVELS > 2
> @@ -67,21 +59,21 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>   #ifdef CONFIG_X86_PAE
>   	tlb->need_flush_all = 1;
>   #endif
> -	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pmd));
> +	tlb_remove_table(tlb, virt_to_ptdesc(pmd));
>   }
>   
>   #if CONFIG_PGTABLE_LEVELS > 3
>   void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
>   {
>   	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
> -	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(pud));
> +	tlb_remove_table(tlb, virt_to_ptdesc(pud));
>   }
>   
>   #if CONFIG_PGTABLE_LEVELS > 4
>   void ___p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d)
>   {
>   	paravirt_release_p4d(__pa(p4d) >> PAGE_SHIFT);
> -	paravirt_tlb_remove_table(tlb, virt_to_ptdesc(p4d));
> +	tlb_remove_table(tlb, virt_to_ptdesc(p4d));
>   }
>   #endif	/* CONFIG_PGTABLE_LEVELS > 4 */
>   #endif	/* CONFIG_PGTABLE_LEVELS > 3 */
> diff --git a/arch/x86/xen/mmu_pv.c b/arch/x86/xen/mmu_pv.c
> index 2c70cd35e72c..a0b371557125 100644
> --- a/arch/x86/xen/mmu_pv.c
> +++ b/arch/x86/xen/mmu_pv.c
> @@ -2141,7 +2141,6 @@ static const typeof(pv_ops) xen_mmu_ops __initconst = {
>   		.flush_tlb_kernel = xen_flush_tlb,
>   		.flush_tlb_one_user = xen_flush_tlb_one_user,
>   		.flush_tlb_multi = xen_flush_tlb_multi,
> -		.tlb_remove_table = tlb_remove_table,
>   
>   		.pgd_alloc = xen_pgd_alloc,
>   		.pgd_free = xen_pgd_free,

