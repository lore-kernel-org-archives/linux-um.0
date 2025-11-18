Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01D46CED617
	for <linux-um@archiver.kernel.org>; Tue, 18 Nov 2025 12:03:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YSfDkQJHByC5W64S3r1RZBfV7l+QzHRtZt5IkHkWjXM=; b=nl0zqo1hIkRMQeq9zrfM+k7G0h
	i+r/9MRo3050Rq+JUrZvd8ySwbMG+fN8algrxjJNpAO9mu7ompYmNRFwsZDAL2jN1aLOOqHLHgfrw
	MshtY6zgD34B7KpIBKFTS7l3zicrJRsN9Urw93ZGXN+jCYYmH7E0gPYjgKqHqhRGBDF72KS4eMSqc
	RN4OLnWSm6IPkG3mODVLiFhUIghaLKt/RUj3igAz2Is1BfyHpA+LsFX5wUt5fd85F1RG4Rc5cdCFw
	p/mgd7oL49LIsGa2rBaQEXUaace2ImDpJwBwCFCIKKAZ2OnMMmJ0/DAPAdDC15n/Divcl+Gu0Qfig
	ok4zvwVw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLKR8-00000000NRo-3tA9;
	Tue, 18 Nov 2025 12:03:54 +0000
Received: from out-179.mta1.migadu.com ([95.215.58.179])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLKR6-00000000NQm-20tn
	for linux-um@lists.infradead.org;
	Tue, 18 Nov 2025 12:03:53 +0000
Message-ID: <195baf7c-1f4e-46a4-a4aa-e68e7d00c0f9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763467417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YSfDkQJHByC5W64S3r1RZBfV7l+QzHRtZt5IkHkWjXM=;
	b=Z9Rbcq7i2Y1LGHCoUGuTi6ppSLunSulmRKUQ4pjayjy42viyJ+DcXrTYmImrfSRJw+UKR4
	UVTRGLFHLTlNdVaXnjT3ixLkagqhNZyq0Aqov/I7FCpMijq/fe4cVtkKv+q+YaHP5txxbN
	qqqQe//KpgfJbRYA+2BGf/imvJ4aYQ4=
Date: Tue, 18 Nov 2025 20:02:30 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
 <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251118_040352_656987_36D5E449 
X-CRM114-Status: GOOD (  17.75  )
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



On 11/18/25 12:57 AM, David Hildenbrand (Red Hat) wrote:
> On 14.11.25 12:11, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
> 
> Subject: s/&&/&/

will do.

> 
>>
>> Make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE so that PT_RECLAIM 
>> can
>> be enabled by default on all architectures that support
>> MMU_GATHER_RCU_TABLE_FREE.
>>
>> Considering that a large number of PTE page table pages (such as 100GB+)
>> can only be caused on a 64-bit system, let PT_RECLAIM also depend on
>> 64BIT.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/x86/Kconfig | 1 -
>>   mm/Kconfig       | 6 +-----
>>   2 files changed, 1 insertion(+), 6 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index eac2e86056902..96bff81fd4787 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -330,7 +330,6 @@ config X86
>>       select FUNCTION_ALIGNMENT_4B
>>       imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>       select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>       select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>       select SCHED_SMT            if SMP
>>       select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index a5a90b169435d..e795fbd69e50c 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1440,14 +1440,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>         The architecture has hardware support for userspace shadow call
>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>> -config ARCH_SUPPORTS_PT_RECLAIM
>> -    def_bool n
>> -
>>   config PT_RECLAIM
>>       bool "reclaim empty user page table pages"
>>       default y
>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> -    select MMU_GATHER_RCU_TABLE_FREE
>> +    depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT
> 
> Who would we have MMU_GATHER_RCU_TABLE_FREE without MMU? (can we drop 
> the MMU part)

OK.

> 
> Why do we care about SMP in the first place? (can we frop SMP)

OK.

> 
> But I also wonder why we need "MMU_GATHER_RCU_TABLE_FREE && 64BIT":
> 
> Would it be harmful on 32bit (sure, we might not reclaim as much, but 
> still there is memory to be reclaimed?)?

This is also fine on 32bit, but the benefits are not significant, So I
chose to enable it only on 64-bit.

I actually tried enabling MMU_GATHER_RCU_TABLE_FREE on all
architectures, and apart from sparc32 being a bit troublesome (because
it uses mm->page_table_lock for synchronization within
__pte_free_tlb()), the modifications were relatively simple.

> 
> If all 64BIT support MMU_GATHER_RCU_TABLE_FREE (as you previously 
> state), why can't we only check for 64BIT?

OK, will do.

Thanks,
Qi

> 


