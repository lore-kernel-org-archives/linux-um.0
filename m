Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A54DAD6CFBB
	for <linux-um@archiver.kernel.org>; Fri, 23 Jan 2026 03:24:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DpeJcCHVDm9aGgZT7fLJbUNNelWHXP+Bu4gd7TvaW7g=; b=pp4aBBR7kNBn5sbDmNOsWWKwte
	+b31ZU0hce02Yn5KOuEdYGfAUETgGpSQMssmPRpDg6CebQUIQdILb5qpTWqOp0Wa85bmVRF+qNr6F
	4p0eYNspcuKeDyz90rs6S7tMaKEmfRALtDqD13ibux44A7oVxnYZR+EjhYk22z8lcX8zmRj9lNchu
	l0470uSBd9CCLH/eIoxNyHU127HJSs9uEIomH8w9b+eG3EttTtvaQ8U6zBilwesr85P7SQc9GXQMS
	BVUaKae7OcDoT0HTadi64qau773F7nupYNK2mk/Sk1jMKGLtq6+ZopbPnFwYD9fgsx4RMLQc91wAH
	ywkq494w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj7mi-000000087OR-1v9S;
	Fri, 23 Jan 2026 03:24:32 +0000
Received: from out-170.mta1.migadu.com ([2001:41d0:203:375::aa])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vj7mc-0000000878H-3JKp
	for linux-um@lists.infradead.org;
	Fri, 23 Jan 2026 03:24:30 +0000
Message-ID: <fd90c84b-9829-4699-b7df-c43020519ec9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769138529;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DpeJcCHVDm9aGgZT7fLJbUNNelWHXP+Bu4gd7TvaW7g=;
	b=eXPMNHh9ctUnhtpd2wXxPJprv0KOzhjIIb/JZN2sRw4sr1qJsj2GswbWUwjQC99xFlGN+J
	QxtDjJNo/hWzlNu69ifrt1uEPxLsnWQciI1TqcX0DRrEmtCLkDY/tqkEIuT8fAicEwvtwZ
	cI4zum4BNHwOopAuRPtAWL6yfr/S8g4=
Date: Fri, 23 Jan 2026 11:21:50 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
To: Wei Yang <richard.weiyang@gmail.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 ioworker0@gmail.com, linmag7@gmail.com, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
 <20251231094243.zmjs7kgflm7q6k73@master>
 <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
 <20260101020715.45wqnjgcklvjcth3@master>
 <d38fcbe5-8b4a-40bc-b8c8-1c49ccaa9964@kernel.org>
 <20260122140034.ymigrfppzwvmcjkr@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20260122140034.ymigrfppzwvmcjkr@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260122_192427_114292_B087DD7B 
X-CRM114-Status: GOOD (  19.90  )
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



On 1/22/26 10:00 PM, Wei Yang wrote:
> On Mon, Jan 19, 2026 at 11:18:52AM +0100, David Hildenbrand (Red Hat) wrote:
>> On 1/1/26 03:07, Wei Yang wrote:
>>> On Wed, Dec 31, 2025 at 05:52:57PM +0800, Qi Zheng wrote:
>>>>
>>>>
>>>> On 12/31/25 5:42 PM, Wei Yang wrote:
>>>>> On Wed, Dec 17, 2025 at 05:45:48PM +0800, Qi Zheng wrote:
>>>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>>
>>>>>> The PT_RECLAIM can work on all architectures that support
>>>>>> MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>>>>>> MMU_GATHER_RCU_TABLE_FREE.
>>>>>>
>>>>>> BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>>>>>> to turn it off.
>>>>>>
>>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>>> ---
>>>>>> arch/x86/Kconfig | 1 -
>>>>>> mm/Kconfig       | 9 ++-------
>>>>>> 2 files changed, 2 insertions(+), 8 deletions(-)
>>>>>>
>>>>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>>>>> index 80527299f859a..0d22da56a71b0 100644
>>>>>> --- a/arch/x86/Kconfig
>>>>>> +++ b/arch/x86/Kconfig
>>>>>> @@ -331,7 +331,6 @@ config X86
>>>>>> 	select FUNCTION_ALIGNMENT_4B
>>>>>> 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>>>> 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>>>>> -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>>>>>> 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>>>>>> 	select SCHED_SMT			if SMP
>>>>>> 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>>>>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>>>>> index bd0ea5454af82..fc00b429b7129 100644
>>>>>> --- a/mm/Kconfig
>>>>>> +++ b/mm/Kconfig
>>>>>> @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>>>> 	  The architecture has hardware support for userspace shadow call
>>>>>>              stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>>>>>
>>>>>> -config ARCH_SUPPORTS_PT_RECLAIM
>>>>>> -	def_bool n
>>>>>> -
>>>>>> config PT_RECLAIM
>>>>>> -	bool "reclaim empty user page table pages"
>>>>>> -	default y
>>>>>> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>>>>> -	select MMU_GATHER_RCU_TABLE_FREE
>>>>>> +	def_bool y
>>>>>> +	depends on MMU_GATHER_RCU_TABLE_FREE
>>>>>> 	help
>>>>>> 	  Try to reclaim empty user page table pages in paths other than munmap
>>>>>> 	  and exit_mmap path.
>>>>>
>>>>> Hi, Qi
>>>>>
>>>>> I am new to PT_RECLAIM, when reading related code I got one question.
>>>>>
>>>>> Before this patch,  we could have this config combination:
>>>>>
>>>>>        CONFIG_MMU_GATHER_RCU_TABLE_FREE & !CONFIG_PT_RECLAIM
>>>>>
>>>>> This means tlb_remove_table_free() is rcu version while tlb_remove_table_one()
>>>>> is semi rcu version.
>>>>>
>>>>> I am curious could we use rcu version tlb_remove_table_one() for this case?
>>>>> Use rcu version tlb_remove_table_one() if CONFIG_MMU_GATHER_RCU_TABLE_FREE. Is
>>>>> there some limitation here?
>>>>
>>>> I think there's no problem. The rcu version can also ensure that the
>>>> fast GUP works well.
>>>>
>>>
>>> Thanks for your quick response :-)
>>>
>>> And Happy New Year
>>>
>>> So my little suggestion is move the definition of __tlb_remove_table_one()
>>> under CONFIG_MMU_GATHER_RCU_TABLE_FREE. Do you thinks this would be more
>>> clear?
>>
>>
>> Do you mean
>>
>> diff --git a/mm/mmu_gather.c b/mm/mmu_gather.c
>> index 2faa23d7f8d42..6aeba4bae68d2 100644
>> --- a/mm/mmu_gather.c
>> +++ b/mm/mmu_gather.c
>> @@ -319,7 +319,7 @@ static inline void tlb_table_invalidate(struct mmu_gather
>> *tlb)
>>         }
>> }
>>
>> -#ifdef CONFIG_PT_RECLAIM
>> +#ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>> static inline void __tlb_remove_table_one_rcu(struct rcu_head *head)
>> {
>>         struct ptdesc *ptdesc;
>>
>> ?
> 
> Sorry for the late reply.
> 
> Yes, and maybe we can move the definition to the
> #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE code block above, then to be next to
> tlb_remove_table_free().
> 
> So that we always have rcu version when CONFIG_MMU_GATHER_RCU_TABLE_FREE.

LGTM, could you help submit an official patch?

Thanks,
Qi

> 
>>
>> -- 
>> Cheers
>>
>> David
> 


