Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9F2FE77198
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 10:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KqzYXTStRwHdA2r44yWtS6M9tFw/JByatD25oVsaaPw=; b=eY/vlWGLoTaVXunUc6rzbTUfwh
	KFvHh0fkIFtP+lVOMmtzsL6yK+4nX0lF6BI3TREgYuJ4t/tf3JZRE2hewUmZaCPMoVVotzmzPVm0k
	85zxP7taFL9/DC2dlUyBRR6+qr4+z4GY1AqRkdmlnRGXPMIdvblmziTlFkx8mtdVnfOC9cYSwAPC9
	ZhpdPoBZdFJvao7zppFhzhywNN8zy9Mer3X7jjvcXZB9shvIYdgI9T7gTZlqZomn3kNe7DjEezMI3
	shC05spAzgOCrr9k/2x5SmpEggi+QWXIZk/sDXPcADVGlRx+9IG6lxees0CgMo4WLPEses2No0avq
	aQbTinaQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTf3b-0000000Ck26-1q1U;
	Fri, 03 Jan 2025 10:37:31 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTf2M-0000000Cjvn-0ioI;
	Fri, 03 Jan 2025 10:36:16 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 45A1D150C;
	Fri,  3 Jan 2025 02:36:41 -0800 (PST)
Received: from [10.44.160.93] (e126510-lin.lund.arm.com [10.44.160.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8736A3F6A8;
	Fri,  3 Jan 2025 02:36:06 -0800 (PST)
Message-ID: <39925677-4619-411d-b0b1-40f9db09374f@arm.com>
Date: Fri, 3 Jan 2025 11:36:03 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 05/10] riscv: mm: Skip pgtable level check in
 {pud,p4d}_alloc_one
To: Alexandre Ghiti <alex@ghiti.fr>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, loongarch@lists.linux.dev, x86@kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-6-kevin.brodsky@arm.com>
 <2aed338a-97a4-40e3-8a95-99458756ca28@ghiti.fr>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <2aed338a-97a4-40e3-8a95-99458756ca28@ghiti.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_023614_303221_0C0F016B 
X-CRM114-Status: GOOD (  13.85  )
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

+Qi

On 03/01/2025 11:31, Alexandre Ghiti wrote:
> Hi Kevin,
>
> On 19/12/2024 17:44, Kevin Brodsky wrote:
>> {pmd,pud,p4d}_alloc_one() is never called if the corresponding page
>> table level is folded, as {pmd,pud,p4d}_alloc() already does the
>> required check. We can therefore remove the runtime page table level
>> checks in {pud,p4d}_alloc_one. The PUD helper becomes equivalent to
>> the generic version, so we remove it altogether.
>>
>> This is consistent with the way arm64 and x86 handle this situation
>> (runtime check in p4d_free() only).
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>   arch/riscv/include/asm/pgalloc.h | 22 ++++------------------
>>   1 file changed, 4 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/riscv/include/asm/pgalloc.h
>> b/arch/riscv/include/asm/pgalloc.h
>> index f52264304f77..8ad0bbe838a2 100644
>> --- a/arch/riscv/include/asm/pgalloc.h
>> +++ b/arch/riscv/include/asm/pgalloc.h
>> @@ -12,7 +12,6 @@
>>   #include <asm/tlb.h>
>>     #ifdef CONFIG_MMU
>> -#define __HAVE_ARCH_PUD_ALLOC_ONE
>>   #define __HAVE_ARCH_PUD_FREE
>>   #include <asm-generic/pgalloc.h>
>>   @@ -88,15 +87,6 @@ static inline void pgd_populate_safe(struct
>> mm_struct *mm, pgd_t *pgd,
>>       }
>>   }
>>   -#define pud_alloc_one pud_alloc_one
>> -static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned
>> long addr)
>> -{
>> -    if (pgtable_l4_enabled)
>> -        return __pud_alloc_one(mm, addr);
>> -
>> -    return NULL;
>> -}
>> -
>>   #define pud_free pud_free
>>   static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>>   {
>> @@ -118,15 +108,11 @@ static inline void __pud_free_tlb(struct
>> mmu_gather *tlb, pud_t *pud,
>>   #define p4d_alloc_one p4d_alloc_one
>>   static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned
>> long addr)
>>   {
>> -    if (pgtable_l5_enabled) {
>> -        gfp_t gfp = GFP_PGTABLE_USER;
>> -
>> -        if (mm == &init_mm)
>> -            gfp = GFP_PGTABLE_KERNEL;
>> -        return (p4d_t *)get_zeroed_page(gfp);
>> -    }
>> +    gfp_t gfp = GFP_PGTABLE_USER;
>>   -    return NULL;
>> +    if (mm == &init_mm)
>> +        gfp = GFP_PGTABLE_KERNEL;
>> +    return (p4d_t *)get_zeroed_page(gfp);
>>   }
>>     static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
>
>
> Reviewed-by: Alexandre Ghiti <alexghiti@rivosinc.com>

Thanks for the review! Just FYI this patch is now part of Qi's series
[1], I will drop it when posting the next version of this series.

- Kevin

[1]
https://lore.kernel.org/linux-mm/84ddf857508b98a195a790bc6ff6ab8849b44633.1735549103.git.zhengqi.arch@bytedance.com/

