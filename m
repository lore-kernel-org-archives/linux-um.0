Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7FADEE2091
	for <linux-um@archiver.kernel.org>; Fri,  6 Feb 2026 11:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dYqXq1NRIfJySgnYSgnc1Tt2EdVmznlx20DFcIB6kE=; b=sILoHvEYJLP4VHtJ12qcOon5zH
	zDp6WnCCykzSAXdjh6d9soXKdAXe/QT3ZalArgvbe9wJzdBApAyL/UHIwXykOQVu/Yss0rixZPeCy
	giU1rjtjDzwZnWHqpaGo/LXIsum5CbLdPua1vjbWDkrtoSV8NmgD9TjWHKzsQQGMhdblpl+v66toB
	55EJoQuqWwiyz83Kq6EIY12pW0ykRN+Yz6GdxfxJ+clXht4fNppFvzx9NwjFDTyuqqfZblkRz7R98
	skqzq7ShW2YN3oTHVR5/VxPwGU7SmSjytWODrLSn77qIXOM3S+9LymfIzOF5lpcrGUHizvHMnASGX
	Ik2Tro6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voKUr-0000000BGq0-2Jlm;
	Fri, 06 Feb 2026 11:59:37 +0000
Received: from out-170.mta1.migadu.com ([95.215.58.170])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1voKUo-0000000BGny-0mRq
	for linux-um@lists.infradead.org;
	Fri, 06 Feb 2026 11:59:35 +0000
Message-ID: <53a1bbdd-26d1-454d-af06-169172278718@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770379151;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5dYqXq1NRIfJySgnYSgnc1Tt2EdVmznlx20DFcIB6kE=;
	b=Aalvtl60ATdjvtCv049X0heOLjC3Ne6UC4Jnw9CBdMvR2rHyEUK1QbvxylKB+AHtJsEUAU
	qvz+5iU0N8RA5zOq5wxvvGIq8Nn3kg8PMVar5v/lHabP5zzzP0j4LoFOtXGenQaBOxygN1
	8rGXHcgmdNLdrCK3y2uriNFt0zpk2rs=
Date: Fri, 6 Feb 2026 19:58:47 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v4 7/8] mm: convert __HAVE_ARCH_TLB_REMOVE_TABLE to
 CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE config
To: "David Hildenbrand (Arm)" <david@kernel.org>, andreas@gaisler.com,
 richard.weiyang@gmail.com, will@kernel.org, peterz@infradead.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dev.jain@arm.com,
 ioworker0@gmail.com, linmag7@gmail.com, akpm@linux-foundation.org
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, sparclinux@vger.kernel.org,
 Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1769515122.git.zhengqi.arch@bytedance.com>
 <5ebfa3d4b56e63c6906bda5eccaa9f7194d3a86b.1769515122.git.zhengqi.arch@bytedance.com>
 <a404e9ec-35ff-44b1-b321-9cc4fbf72060@kernel.org>
 <1663ae90-3247-4e12-a25a-049fc3281e19@linux.dev>
 <538fef61-3903-407e-8486-538a28b99e9d@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <538fef61-3903-407e-8486-538a28b99e9d@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260206_035934_376453_83AD5F65 
X-CRM114-Status: GOOD (  12.46  )
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



On 2/6/26 7:45 PM, David Hildenbrand (Arm) wrote:
> On 2/6/26 12:13, Qi Zheng wrote:
>>
>>
>> On 2/6/26 7:06 PM, David Hildenbrand (Arm) wrote:
>>> On 1/27/26 13:13, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> For architectures that define __HAVE_ARCH_TLB_REMOVE_TABLE, the page
>>>> tables at the pmd/pud level are generally not of struct ptdesc type, 
>>>> and
>>>> do not have pt_rcu_head member, thus these architectures cannot support
>>>> PT_RECLAIM.
>>>>
>>>> In preparation for enabling PT_RECLAIM on more architectures, convert
>>>> __HAVE_ARCH_TLB_REMOVE_TABLE to CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE 
>>>> config,
>>>> so that we can make conditional judgments in Kconfig.
>>>>
>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>> ---
>>>>   arch/powerpc/Kconfig            | 1 +
>>>>   arch/powerpc/include/asm/tlb.h  | 1 -
>>>>   arch/sparc/Kconfig              | 1 +
>>>>   arch/sparc/include/asm/tlb_64.h | 1 -
>>>>   include/asm-generic/tlb.h       | 2 +-
>>>>   mm/Kconfig                      | 3 +++
>>>>   6 files changed, 6 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
>>>> index 9537a61ebae02..b47aa8fd62742 100644
>>>> --- a/arch/powerpc/Kconfig
>>>> +++ b/arch/powerpc/Kconfig
>>>> @@ -304,6 +304,7 @@ config PPC
>>>>       select LOCK_MM_AND_FIND_VMA
>>>>       select MMU_GATHER_PAGE_SIZE
>>>>       select MMU_GATHER_RCU_TABLE_FREE
>>>> +    select HAVE_ARCH_TLB_REMOVE_TABLE
>>>>       select MMU_GATHER_MERGE_VMAS
>>>>       select MMU_LAZY_TLB_SHOOTDOWN        if PPC_BOOK3S_64
>>>>       select MODULES_USE_ELF_RELA
>>>> diff --git a/arch/powerpc/include/asm/tlb.h b/arch/powerpc/include/ 
>>>> asm/tlb.h
>>>> index 2058e8d3e0138..1ca7d4c4b90db 100644
>>>> --- a/arch/powerpc/include/asm/tlb.h
>>>> +++ b/arch/powerpc/include/asm/tlb.h
>>>> @@ -37,7 +37,6 @@ extern void tlb_flush(struct mmu_gather *tlb);
>>>>    */
>>>>   #define tlb_needs_table_invalidate()    radix_enabled()
>>>> -#define __HAVE_ARCH_TLB_REMOVE_TABLE
>>>>   /* Get the generic bits... */
>>>>   #include <asm-generic/tlb.h>
>>>> diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
>>>> index a630d373e6453..25fa2908d6152 100644
>>>> --- a/arch/sparc/Kconfig
>>>> +++ b/arch/sparc/Kconfig
>>>> @@ -74,6 +74,7 @@ config SPARC64
>>>>       select HAVE_KRETPROBES
>>>>       select HAVE_KPROBES
>>>>       select MMU_GATHER_RCU_TABLE_FREE if SMP
>>>> +    select HAVE_ARCH_TLB_REMOVE_TABLE if SMP
>>>
>>> Why the SMP? At least in tlb_64.h, it was not protected by SMP IIUC.
>>
>> Ah, It's just simply aligned with the MMU_GATHER_RCU_TABLE_FREE above.
> 
> But does that work as expected for !SMP?

In the case of !SMP, tlb_remove_table() will not be called:

static inline void pgtable_free_tlb(struct mmu_gather *tlb, void *table, 
bool is_page)
{
	pgtable_free(table, is_page);
}


so I think it's okay to only select it in case of SMP.

> 


