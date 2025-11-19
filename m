Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B808CF31B5
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 12:16:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=T8UxEgfEvYYIYjqonyzaX1YNHYFvCPlixYyfl5K/5Us=; b=DRAMUFZ0zoX03D9OBFqVeUnPzD
	VCyFsFcibcAeWnlbXOD587WedmVjtgp6rRfGZDPC0wpkQShjYoiJpD6jmcKpcdRPYcrL3I72Htdvo
	mxrhqBQxvsC5knn08qlYrHy0DSvwCeVEoZyz3pZC8LI0RyrRbez6JlkK0nkqsOy10a8gHnWGjAGA/
	w25D/pRR8Rl6JA1lr51az+TSCVge4Znlqn+iLq1TIiLcu9q0fQrKe/hwAK+xrVXo65UzXsQcU4bMa
	VlGmC3OrgewUX+6ZvaF22mFrSYen7NVW6Q03lsUmO5XLXCi+mbASHvyYXoBs9wVy3nUyYTYMHCQtX
	3tMt5Nug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLh6d-000000036Nd-1ev6;
	Wed, 19 Nov 2025 12:16:15 +0000
Received: from out-173.mta0.migadu.com ([2001:41d0:1004:224b::ad])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLh6a-000000036NA-3UIM
	for linux-um@lists.infradead.org;
	Wed, 19 Nov 2025 12:16:14 +0000
Message-ID: <6e6d8390-1f9e-40cf-949d-168160fa9a15@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763554567;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T8UxEgfEvYYIYjqonyzaX1YNHYFvCPlixYyfl5K/5Us=;
	b=AVtUPokbskA2fxW7sCPAzJUrWf8TDNbPt/WdsQfOCSbGOGvqVUig5Chd70lHJMkyln4ufj
	X6Bg1RKVDftg0vFjwYVYCXvoFKw63N958H75bSqPHgoSBbSpEmPqQpJlqP6Lz5U8HFdbCb
	XKACOfahN120NBnxDteAgU+KBrLLN4I=
Date: Wed, 19 Nov 2025 20:15:58 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v2 7/7] mm: enable PT_RECLAIM on all 64-bit architectures
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com,
 linmag7@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763537007.git.zhengqi.arch@bytedance.com>
 <caacf08b765ef00770b7c75afdb5e5754485b2aa.1763537007.git.zhengqi.arch@bytedance.com>
 <9b55623a-4606-4610-a0fe-55b8cd6b95e7@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <9b55623a-4606-4610-a0fe-55b8cd6b95e7@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_041613_017437_EF2BED3C 
X-CRM114-Status: GOOD (  14.05  )
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



On 11/19/25 7:38 PM, David Hildenbrand (Red Hat) wrote:
> On 19.11.25 08:31, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Now, the MMU_GATHER_RCU_TABLE_FREE is enabled on all 64-bit 
>> architectures,
>> so make PT_RECLAIM depend on 64BIT, thereby enabling PT_RECLAIM on all
>> 64-bit architectures.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>>   arch/x86/Kconfig | 1 -
>>   mm/Kconfig       | 9 ++-------
>>   2 files changed, 2 insertions(+), 8 deletions(-)
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
>> index d548976d0e0ad..94eec5c0cad96 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1448,14 +1448,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>>         The architecture has hardware support for userspace shadow call
>>             stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>> -config ARCH_SUPPORTS_PT_RECLAIM
>> -    def_bool n
>> -
>>   config PT_RECLAIM
>> -    bool "reclaim empty user page table pages"
>> -    default y
>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> -    select MMU_GATHER_RCU_TABLE_FREE
>> +    def_bool y
>> +    depends on 64BIT
> 
> As discussed in the other thread, likely
> 
> config PT_RECLAIM
>      def_bool y
>      depends on MMU_GATHER_RCU_TABLE_FREE && 64BIT
> 
> Could be nice, and if possible even dropping the 64BIT limitation as 
> well if there is no need to.

I think it's ok to drop the 64BIT limitation. There should be some
32-bit architectures that already enable MMU_GATHER_RCU_TABLE_FREE.

> 
> 


