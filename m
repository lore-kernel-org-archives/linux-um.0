Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BCE1CE8D4A
	for <linux-um@archiver.kernel.org>; Fri, 14 Nov 2025 15:56:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CKysolUqeVjYcgMrPs/ejmALi8P8XvxL85H5NRIJlY8=; b=eJMejy/0xe+6JwtEB0uDKhJQG3
	Hf64ygPz4qrrXIvUs+o7uuBiAi12SPUIoBmmKTiWSuTSRmOrh8QG3cwVY0AgcsWJqtlDcTse5eGtF
	8a2y9iL+64NvDEGi5yHT1WS/MAWzDOrvd/g8pfcIej9iJfy+8xrrnnTJulxi2ONNTWS5cCaK3vauV
	eB3JTfGJsx7MVtiTHWo6eVGvagChCBohXHUpf6UQmod4cfh909vVq+oh3+CeH0pydYmq7n1+kBcsF
	HHNuPaOAk0M/7CMiaIXpYr5hQVeRLnAS1Sy/egU7ixaOM4CeU/R89QFPXSjNxFCy7X4+RiE4SnTuD
	Ohqi55xA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwA4-0000000CdQK-3e8m;
	Fri, 14 Nov 2025 15:56:32 +0000
Received: from out-177.mta0.migadu.com ([91.218.175.177])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJwA1-0000000CdNc-0kUL
	for linux-um@lists.infradead.org;
	Fri, 14 Nov 2025 15:56:30 +0000
Message-ID: <fc08c1a8-f469-43f1-93c0-7fcd2b1c477c@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763135775;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CKysolUqeVjYcgMrPs/ejmALi8P8XvxL85H5NRIJlY8=;
	b=g/B/dUgxQJEHGDks1FfISlakIsod43sd1FWkLD53noWx1K51GzX035cGzeBE8Edv7rjSas
	eRoApfQqE5kMQiTGhq6jTv0fxdja6UCOlpRx6Wco9NKN4CqyYrziO6a9K/p051HV0WDT14
	Mhzi2WwkSotO4sbe8SdPRtkBrzsJI8U=
Date: Fri, 14 Nov 2025 23:55:11 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 3/7] loongarch: mm: enable MMU_GATHER_RCU_TABLE_FREE
To: Huacai Chen <chenhuacai@kernel.org>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 david@redhat.com, ioworker0@gmail.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-um@lists.infradead.org,
 Qi Zheng <zhengqi.arch@bytedance.com>, WANG Xuerui <kernel@xen0n.name>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <146b5a0207052b38d04caac6b20756a61c2189b3.1763117269.git.zhengqi.arch@bytedance.com>
 <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <CAAhV-H6HL+mXeuLqgo5BOVBB0_GHTUmn7_7NTzdUpLX7NbuQ5w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251114_075629_357409_2D5224CF 
X-CRM114-Status: GOOD (  16.08  )
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

Hi Huacai,

On 11/14/25 10:17 PM, Huacai Chen wrote:
> Hi, Qi Zheng,
> 
> We usually use LoongArch rather than loongarch, but if you want to
> keep consistency for all patches, just do it.

OK, will change to use LoongArch.

> 
> On Fri, Nov 14, 2025 at 7:13 PM Qi Zheng <qi.zheng@linux.dev> wrote:
>>
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
>> empty PTE page table pages (such as 100GB+). To resolve this problem,
>> first enable MMU_GATHER_RCU_TABLE_FREE to prepare for enabling the
>> PT_RECLAIM feature, which resolves this problem.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Cc: Huacai Chen <chenhuacai@kernel.org>
>> Cc: WANG Xuerui <kernel@xen0n.name>
>> ---
>>   arch/loongarch/Kconfig               | 1 +
>>   arch/loongarch/include/asm/pgalloc.h | 6 ++++--
>>   2 files changed, 5 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
>> index 5b1116733d881..3bf2f2a9cd647 100644
>> --- a/arch/loongarch/Kconfig
>> +++ b/arch/loongarch/Kconfig
>> @@ -210,6 +210,7 @@ config LOONGARCH
>>          select USER_STACKTRACE_SUPPORT
>>          select VDSO_GETRANDOM
>>          select ZONE_DMA32
>> +       select MMU_GATHER_RCU_TABLE_FREE
> Please use alpha-betical order.

OK, will do.

> 
>>
>>   config 32BIT
>>          bool
>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
>> index 1c63a9d9a6d35..0539d04bf1525 100644
>> --- a/arch/loongarch/include/asm/pgalloc.h
>> +++ b/arch/loongarch/include/asm/pgalloc.h
>> @@ -79,7 +79,8 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>>          return pmd;
>>   }
>>
>> -#define __pmd_free_tlb(tlb, x, addr)   pmd_free((tlb)->mm, x)
>> +#define __pmd_free_tlb(tlb, x, addr)   \
>> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
> I think we can define it in one line.

will do.

> 
>>
>>   #endif
>>
>> @@ -99,7 +100,8 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>>          return pud;
>>   }
>>
>> -#define __pud_free_tlb(tlb, x, addr)   pud_free((tlb)->mm, x)
>> +#define __pud_free_tlb(tlb, x, addr)   \
>> +       tlb_remove_ptdesc((tlb), virt_to_ptdesc(x))
> The same.
> 
> Other patches have the same problem.

Got it, will convert them all to the one-line type.

Thanks,
Qi

> 
> Huacai
> 
>>
>>   #endif /* __PAGETABLE_PUD_FOLDED */
>>
>> --
>> 2.20.1
>>


