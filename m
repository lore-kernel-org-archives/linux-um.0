Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ED2BCF3188
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 10:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Y0rdwwjsXpeRwB9NhZAk3xyU/erTdr/J8x8SlVHkjww=; b=ptd1iKXBV79qpoTszF6o17Je4E
	yGOlOBb3wEgusTgVWRMQ8VQJsbqpGGFTxuWYYE1WiGGLpmg6NPukO5P2t5jZwge6qtw6ymHFw4EDg
	tvcl1fuvwKyRk9996C/uZeIL41mduVN+sjmPuutk4AfBxJgqrmfU94P1m3+yXOEBCO7v5rs5Zej35
	lrJY0irhbuFyDzfP1sLqTpcNGQq6RYcUk/PHxqccS3/EOLrtlPDRkKg3M98iptPEGwVMqscgSxp4s
	C4GyWXuS8tHO44aeHWtHtH2alhMgh3VUTQ/9tHXiiIO8OnRTlxeNaeFdz+Lyb+9aDtlWGCuTbrvVJ
	wtfn+CHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfIA-00000002x0Q-3Qhn;
	Wed, 19 Nov 2025 10:20:02 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfI8-00000002wza-1HY2;
	Wed, 19 Nov 2025 10:20:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C94044412;
	Wed, 19 Nov 2025 10:19:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED579C113D0;
	Wed, 19 Nov 2025 10:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1763547599;
	bh=8gID8BLUqz27ftdyuyVystLlDDq4KdFYCustoOe54RY=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=XKzsfyaktYk1NfN18S9hccOsNg6wsjdvBDLtH0msz229ZMI3K2CpzJjlq9zogKst2
	 IpRt8Vacn6bPvhAXJdPHwvnVsyk6/LZ60Qv8L+fBjOvTfDozVL9UROfYk950jLCsWS
	 z34Iocb3hYkWz25pZf8wW4+AEb0QYUxLALyXcNTRJvEqAW1in4xBVuLd65R+AO4LmD
	 3mR3cklLqI+9GQ2KEyAt9BlaxeG6te4kJv7JSGHicczEifcPTgrsoQEfXUbh9/ck8O
	 H/mZ5W6d8h1ftYMiR98ZlqQUntxOjDHk0Ldf3QsAumi71SRiq5wve77UId9Sr0YPuj
	 rsuuFhSqOdrMg==
Message-ID: <9386032c-9840-49da-83f9-74b112f3e752@kernel.org>
Date: Wed, 19 Nov 2025 11:19:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/7] mm: make PT_RECLAIM depend on
 MMU_GATHER_RCU_TABLE_FREE && 64BIT
To: Qi Zheng <qi.zheng@linux.dev>, will@kernel.org, aneesh.kumar@kernel.org,
 npiggin@gmail.com, peterz@infradead.org, dev.jain@arm.com,
 akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <0a4d1e6f0bf299cafd1fc624f965bd1ca542cea8.1763117269.git.zhengqi.arch@bytedance.com>
 <355d3bf3-c6bc-403e-9f19-89259d868611@kernel.org>
 <195baf7c-1f4e-46a4-a4aa-e68e7d00c0f9@linux.dev>
From: "David Hildenbrand (Red Hat)" <david@kernel.org>
Content-Language: en-US
In-Reply-To: <195baf7c-1f4e-46a4-a4aa-e68e7d00c0f9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_022000_389663_5771483D 
X-CRM114-Status: GOOD (  23.93  )
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

On 18.11.25 13:02, Qi Zheng wrote:
> 
> 
> On 11/18/25 12:57 AM, David Hildenbrand (Red Hat) wrote:
>> On 14.11.25 12:11, Qi Zheng wrote:
>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> Subject: s/&&/&/
> 
> will do.
> 
>>
>>>
>>> Make PT_RECLAIM depend on MMU_GATHER_RCU_TABLE_FREE so that PT_RECLAIM
>>> can
>>> be enabled by default on all architectures that support
>>> MMU_GATHER_RCU_TABLE_FREE.
>>>
>>> Considering that a large number of PTE page table pages (such as 100GB+)
>>> can only be caused on a 64-bit system, let PT_RECLAIM also depend on
>>> 64BIT.
>>>
>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>> ---
>>>    arch/x86/Kconfig | 1 -
>>>    mm/Kconfig       | 6 +-----
>>>    2 files changed, 1 insertion(+), 6 deletions(-)
>>>
>>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>>> index eac2e86056902..96bff81fd4787 100644
>>> --- a/arch/x86/Kconfig
>>> +++ b/arch/x86/Kconfig
>>> @@ -330,7 +330,6 @@ config X86
>>>        select FUNCTION_ALIGNMENT_4B
>>>        imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>>>        select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>>> -    select ARCH_SUPPORTS_PT_RECLAIM        if X86_64
>>>        select ARCH_SUPPORTS_SCHED_SMT        if SMP
>>>        select SCHED_SMT            if SMP
>>>        select ARCH_SUPPORTS_SCHED_CLUSTER    if SMP
>>> diff --git a/mm/Kconfig b/mm/Kconfig
>>> index a5a90b169435d..e795fbd69e50c 100644
>>> --- a/mm/Kconfig
>>> +++ b/mm/Kconfig
>>> @@ -1440,14 +1440,10 @@ config ARCH_HAS_USER_SHADOW_STACK
>>>          The architecture has hardware support for userspace shadow call
>>>              stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>> -config ARCH_SUPPORTS_PT_RECLAIM
>>> -    def_bool n
>>> -
>>>    config PT_RECLAIM
>>>        bool "reclaim empty user page table pages"
>>>        default y
>>> -    depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>>> -    select MMU_GATHER_RCU_TABLE_FREE
>>> +    depends on MMU_GATHER_RCU_TABLE_FREE && MMU && SMP && 64BIT
>>
>> Who would we have MMU_GATHER_RCU_TABLE_FREE without MMU? (can we drop
>> the MMU part)
> 
> OK.
> 
>>
>> Why do we care about SMP in the first place? (can we frop SMP)
> 
> OK.
> 
>>
>> But I also wonder why we need "MMU_GATHER_RCU_TABLE_FREE && 64BIT":
>>
>> Would it be harmful on 32bit (sure, we might not reclaim as much, but
>> still there is memory to be reclaimed?)?
> 
> This is also fine on 32bit, but the benefits are not significant, So I
> chose to enable it only on 64-bit.

Right. Address space is smaller, but also memory is smaller. Not that I 
think we strictly *must* to support 32bit, I merely wonder why we 
wouldn't just enable it here.

OTOH, if there is a good reason we cannot enable it, we can definitely 
just keep it 64bit only.

> 
> I actually tried enabling MMU_GATHER_RCU_TABLE_FREE on all
> architectures, and apart from sparc32 being a bit troublesome (because
> it uses mm->page_table_lock for synchronization within
> __pte_free_tlb()), the modifications were relatively simple.
> 
>>
>> If all 64BIT support MMU_GATHER_RCU_TABLE_FREE (as you previously
>> state), why can't we only check for 64BIT?
> 
> OK, will do.

This was also more of a question for discussion:

Would it make sense to have

config PT_RECLAIM
	def_bool y
	depends on MMU_GATHER_RCU_TABLE_FREE

(a) Would we want to make it configurable (why?)
(b) Do we really care about SMP (why?)
(c) Do we want to limit to 64bit (why?)
(d) Do we really need the MMU check in addition to
     MMU_GATHER_RCU_TABLE_FREE


-- 
Cheers

David

