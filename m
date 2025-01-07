Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177AFE77198
	for <linux-um@archiver.kernel.org>; Tue,  7 Jan 2025 10:25:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zdmYeT6nirJQQeULEz/Mx26Ga9KASAi8ohiMId5QGl8=; b=JqPjC4zHSwgk3JSn/9pQLOlUFq
	duAKr4k+WLRU9APzwoj8H88Fnd+8XU0Rm30GXYx+L8BCJgSqU6B73jf+xxcxagba8tTQKKeWWFhsP
	W+WBRry29SpMklCF8Y8/scedU7S1d3bSvbei2YVroDsHuGxM8HJE+NuhxWoEsfcgwtrfMs8KyN0B5
	Dt86gA7vf0offMUBJB39qwz/wwBaDtdBKwJafruxHs2Irw4aM7bilPRIY8dPJYutPvop0b7PlS3dl
	6463xES8nTejafSrYreAzWFQyhIyJ3ENp70k5lYOVa4SAL2p9uSsOcFJQR3QajK+U2yuf9fdrVfhZ
	YzRm8zuA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6lj-00000004KKx-2s1B;
	Tue, 07 Jan 2025 10:25:03 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV6Li-00000004Eb2-0qvc;
	Tue, 07 Jan 2025 09:58:11 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D1D0143D;
	Tue,  7 Jan 2025 01:58:37 -0800 (PST)
Received: from [10.44.160.93] (e126510-lin.lund.arm.com [10.44.160.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 46B0F3F673;
	Tue,  7 Jan 2025 01:58:01 -0800 (PST)
Message-ID: <ee393a7f-d01e-4e5d-9bf8-779795613af1@arm.com>
Date: Tue, 7 Jan 2025 10:57:59 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: agordeev@linux.ibm.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org,
 peterz@infradead.org, akpm@linux-foundation.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
 <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
 <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
 <e9fe97d4-99d5-443e-b722-43903655a76e@bytedance.com>
 <31e1a033-00a7-4953-81e7-0caedd0227a9@bytedance.com>
 <d9a14211-4bbd-4fb6-ba87-a555a40bb67a@arm.com>
 <de8756aa-dbf7-4f6f-91f0-934270397192@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <de8756aa-dbf7-4f6f-91f0-934270397192@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_015810_320361_C67CC3BF 
X-CRM114-Status: GOOD (  17.54  )
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

On 06/01/2025 04:49, Qi Zheng wrote:
> [...]
>
>> Once this is done, we should be able to replace all those confusing
>> calls to tlb_remove_page() on PTPs with tlb_remove_table() and remove
>> the explicit call to pagetable_dtor(). AIUI this is essentially what
>> Peter suggested on v3 [2].
>
> Since this patch series is mainly for bug fix, I think that these things
> can be done in separate patch series later.

Sure that's fair.

>
>>
>> [...]
>>
>>> Or can we just not let tlb_remove_table() fall back to
>>> tlb_remove_page()? Like the following:
>>>
>>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>>> index a59205863f431..354ffaa4bd120 100644
>>> --- a/include/asm-generic/tlb.h
>>> +++ b/include/asm-generic/tlb.h
>>> @@ -195,8 +195,6 @@
>>>    *  various ptep_get_and_clear() functions.
>>>    */
>>>
>>> -#ifdef CONFIG_MMU_GATHER_TABLE_FREE
>>> -
>>>   struct mmu_table_batch {
>>>   #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>>>          struct rcu_head         rcu;
>>> @@ -219,16 +217,6 @@ static inline void __tlb_remove_table(void *table)
>>>
>>>   extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>>>
>>> -#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
>>> -
>>> -/*
>>> - * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have
>>> page based
>>> - * page directories and we can use the normal page batching to free
>>> them.
>>> - */
>>> -#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))
>>
>> We still need a different implementation of tlb_remove_table() in this
>> case. We could define it inline here:
>>
>> static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
>> {
>>      struct page *page = table;
>>
>>      pagetable_dtor(page_ptdesc(page));
>>      tlb_remove_page(page);
>> }
>
> Right. As I said above, will add this to the updated patch #8.

I think it would be preferable to make it a standalone patch, because
this is a change to generic code that could in principle impact other
arch's too.

- Kevin

