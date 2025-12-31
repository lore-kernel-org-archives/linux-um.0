Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02D1CEE57F7
	for <linux-um@archiver.kernel.org>; Wed, 31 Dec 2025 09:53:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Wl7HEoZMUzGsbQepWMVSfO0JV4YjBapS0e5mq4W7b+4=; b=saWq+zsaJiZpucvrr13o66hl+j
	iiHIWokkiBt1M6Li+A2lYpKP4utyp+5GQ5EzwapGeYF1BNp8+hWh6yUC/ydGVcA4uP42Ez7HjvQC2
	8m3Kjw9Sl7GZPO0jz3Uj29NNwFBIlCnlixjlOhCX36160i0qZIsbkkpi5ldYzT33p1Gf+KgHtWlS2
	BRox9czrmAhBZseAj0X+ShREQS8h7lSc3nkMsqAsnaooch5NHkRtTAfW2ALkv/JKxt58ZQL1UKUzD
	9UBnSqm7pjShO/Pxu6aUIXUUsCfXT1Vy0q5ZYUvMm7iINV+o8JL+Q6889Ap6u+dPunw8gwghbE282
	KT4WO8AQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vastJ-00000005qj5-060h;
	Wed, 31 Dec 2025 09:53:17 +0000
Received: from out-180.mta1.migadu.com ([2001:41d0:203:375::b4])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vastE-00000005qig-2yg5
	for linux-um@lists.infradead.org;
	Wed, 31 Dec 2025 09:53:15 +0000
Message-ID: <a3a60bbb-70b7-49ed-abc6-937e6c13d681@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1767174787;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Wl7HEoZMUzGsbQepWMVSfO0JV4YjBapS0e5mq4W7b+4=;
	b=kA0qCy5swxT9/bUHnpErzkaTUIfgXxao85n1AotjzFLMJUomMkCAQjLXpZ4B+KRO9Tbq2L
	WU+1OAl5FxBAuCo1I3+CkOeCjPhLEPbag/rozOxh+CRn8kHOwBSKIYK4ige8l1o+gK7jtK
	Vz5BljGIGicYjbCKFeIBggxM5nn/wOQ=
Date: Wed, 31 Dec 2025 17:52:57 +0800
MIME-Version: 1.0
Subject: Re: [PATCH v3 7/7] mm: make PT_RECLAIM depends on
 MMU_GATHER_RCU_TABLE_FREE
To: Wei Yang <richard.weiyang@gmail.com>
Cc: will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 peterz@infradead.org, dev.jain@arm.com, akpm@linux-foundation.org,
 david@kernel.org, ioworker0@gmail.com, linmag7@gmail.com,
 linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1765963770.git.zhengqi.arch@bytedance.com>
 <ac2bdb2a66da1edb24f60d1da1099e2a0b734880.1765963770.git.zhengqi.arch@bytedance.com>
 <20251231094243.zmjs7kgflm7q6k73@master>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <20251231094243.zmjs7kgflm7q6k73@master>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251231_015313_963454_750A86BE 
X-CRM114-Status: GOOD (  19.45  )
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



On 12/31/25 5:42 PM, Wei Yang wrote:
> On Wed, Dec 17, 2025 at 05:45:48PM +0800, Qi Zheng wrote:
>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>
>> The PT_RECLAIM can work on all architectures that support
>> MMU_GATHER_RCU_TABLE_FREE, so make PT_RECLAIM depends on
>> MMU_GATHER_RCU_TABLE_FREE.
>>
>> BTW, change PT_RECLAIM to be enabled by default, since nobody should want
>> to turn it off.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> ---
>> arch/x86/Kconfig | 1 -
>> mm/Kconfig       | 9 ++-------
>> 2 files changed, 2 insertions(+), 8 deletions(-)
>>
>> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
>> index 80527299f859a..0d22da56a71b0 100644
>> --- a/arch/x86/Kconfig
>> +++ b/arch/x86/Kconfig
>> @@ -331,7 +331,6 @@ config X86
>> 	select FUNCTION_ALIGNMENT_4B
>> 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
>> 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
>> -	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
>> 	select ARCH_SUPPORTS_SCHED_SMT		if SMP
>> 	select SCHED_SMT			if SMP
>> 	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
>> diff --git a/mm/Kconfig b/mm/Kconfig
>> index bd0ea5454af82..fc00b429b7129 100644
>> --- a/mm/Kconfig
>> +++ b/mm/Kconfig
>> @@ -1447,14 +1447,9 @@ config ARCH_HAS_USER_SHADOW_STACK
>> 	  The architecture has hardware support for userspace shadow call
>>            stacks (eg, x86 CET, arm64 GCS or RISC-V Zicfiss).
>>
>> -config ARCH_SUPPORTS_PT_RECLAIM
>> -	def_bool n
>> -
>> config PT_RECLAIM
>> -	bool "reclaim empty user page table pages"
>> -	default y
>> -	depends on ARCH_SUPPORTS_PT_RECLAIM && MMU && SMP
>> -	select MMU_GATHER_RCU_TABLE_FREE
>> +	def_bool y
>> +	depends on MMU_GATHER_RCU_TABLE_FREE
>> 	help
>> 	  Try to reclaim empty user page table pages in paths other than munmap
>> 	  and exit_mmap path.
> 
> Hi, Qi
> 
> I am new to PT_RECLAIM, when reading related code I got one question.
> 
> Before this patch,  we could have this config combination:
> 
>      CONFIG_MMU_GATHER_RCU_TABLE_FREE & !CONFIG_PT_RECLAIM
> 
> This means tlb_remove_table_free() is rcu version while tlb_remove_table_one()
> is semi rcu version.
> 
> I am curious could we use rcu version tlb_remove_table_one() for this case?
> Use rcu version tlb_remove_table_one() if CONFIG_MMU_GATHER_RCU_TABLE_FREE. Is
> there some limitation here?

I think there's no problem. The rcu version can also ensure that the
fast GUP works well.

> 
> Thanks in advance for your explanation.
> 
> 


