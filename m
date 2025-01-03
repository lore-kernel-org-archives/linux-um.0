Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5CF81E77188
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 13:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+8G2mn5XjC+6BvOgDwIaLzTXtQekFe6X8F8stkKVxBA=; b=qiU2GV7PxoKRbRlFIb17m/3Cp7
	ttiOLHpL8dQjzMklZGUkGLHLg3nzCkg3QDYlyO6VFlyJBsjLN4F5t4QL33LzaQAWpCjqnBHJWeTGw
	joaDhcnPWhMq42dtTgMJxDqmnS5MqTjcuxajv9BWhhZjvJVboTo26UuI01mpOtYi25CX6TJ2P3daa
	JJL5S97e4AbMC11ZCvZbrPCWP2w9AZaTiOsbTHO+BUVLKxws+zcte4tK72el1s4Vc4DUcsKNC6QKY
	I9LjLac/8fiT+OdvBl4Womn1W8COfM5aDifrZh3ncZuinexCmKiJizK1uFwODEm+Yg7t3mkGn+hpk
	5nJM/C2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tThj4-0000000D0Hi-0UAb;
	Fri, 03 Jan 2025 13:28:30 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tThhp-0000000D055-0T7N;
	Fri, 03 Jan 2025 13:27:15 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 330911480;
	Fri,  3 Jan 2025 05:27:39 -0800 (PST)
Received: from [10.44.160.93] (e126510-lin.lund.arm.com [10.44.160.93])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CB2C23F673;
	Fri,  3 Jan 2025 05:27:02 -0800 (PST)
Message-ID: <d9a14211-4bbd-4fb6-ba87-a555a40bb67a@arm.com>
Date: Fri, 3 Jan 2025 14:27:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
To: Qi Zheng <zhengqi.arch@bytedance.com>, peterz@infradead.org
Cc: agordeev@linux.ibm.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, dave.hansen@linux.intel.com,
 rppt@kernel.org, ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
 <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
 <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
 <e9fe97d4-99d5-443e-b722-43903655a76e@bytedance.com>
 <31e1a033-00a7-4953-81e7-0caedd0227a9@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <31e1a033-00a7-4953-81e7-0caedd0227a9@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_052713_243707_AF58B286 
X-CRM114-Status: GOOD (  19.56  )
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

On 03/01/2025 10:35, Qi Zheng wrote:
> On 2025/1/3 17:13, Qi Zheng wrote:
>> On 2025/1/3 16:02, Kevin Brodsky wrote:
>>> On 03/01/2025 04:48, Qi Zheng wrote:
>>>> [...]
>>>>
>>>> In __tlb_batch_free_encoded_pages(), we can indeed detect PageTable()
>>>> and call pagetable_dtor() to dtor the page table pages.
>>>> But __tlb_batch_free_encoded_pages() is also used to free normal pages
>>>> (not page table pages), so I don't want to add overhead there.
>>>
>>> Interesting, can a tlb batch refer to pages than are not PTPs then?
>>
>> Yes, you can see the caller of __tlb_remove_folio_pages() or
>> tlb_remove_page_size().

I had a brief look but clearly not a good enough one! I hadn't realised
that "table" in tlb_remove_table() means PTP, while "page" in
tlb_remove_page() can mean any page, and it's making more sense now.

[...]

>>
>> For arm, the call to pagetable_dtor() is indeed missed in the
>> non-MMU_GATHER_RCU_TABLE_FREE case. This needs to be fixed. But we
>> can't fix this by adding pagetable_dtor() to tlb_remove_table(),
>> because some architectures call tlb_remove_table() but don't support
>> page table statistics, like sparc.

When I investigated this for my own series, I found that the only case
where ctor/dtor are not called for page-sized page tables is 32-bit
sparc (see table at the end of [1]). However only 64-bit sparc makes use
of tlb_remove_table() (at PTE level, where ctor/dtor are already called).

So really calling pagetable_dtor() from tlb_remove_table() in the
non-MMU_GATHER_TABLE_FREE case seems to be the obvious thing to do.

Once this is done, we should be able to replace all those confusing
calls to tlb_remove_page() on PTPs with tlb_remove_table() and remove
the explicit call to pagetable_dtor(). AIUI this is essentially what
Peter suggested on v3 [2].

[1]
https://lore.kernel.org/linux-mm/20241219164425.2277022-1-kevin.brodsky@arm.com/
[2]
https://lore.kernel.org/linux-mm/20250103111457.GC22934@noisy.programming.kicks-ass.net/

[...]

> Or can we just not let tlb_remove_table() fall back to
> tlb_remove_page()? Like the following:
>
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index a59205863f431..354ffaa4bd120 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -195,8 +195,6 @@
>   *  various ptep_get_and_clear() functions.
>   */
>
> -#ifdef CONFIG_MMU_GATHER_TABLE_FREE
> -
>  struct mmu_table_batch {
>  #ifdef CONFIG_MMU_GATHER_RCU_TABLE_FREE
>         struct rcu_head         rcu;
> @@ -219,16 +217,6 @@ static inline void __tlb_remove_table(void *table)
>
>  extern void tlb_remove_table(struct mmu_gather *tlb, void *table);
>
> -#else /* !CONFIG_MMU_GATHER_HAVE_TABLE_FREE */
> -
> -/*
> - * Without MMU_GATHER_TABLE_FREE the architecture is assumed to have
> page based
> - * page directories and we can use the normal page batching to free
> them.
> - */
> -#define tlb_remove_table(tlb, page) tlb_remove_page((tlb), (page))

We still need a different implementation of tlb_remove_table() in this
case. We could define it inline here:

static inline void tlb_remove_table(struct mmu_gather *tlb, void *table)
{
    struct page *page = table;

    pagetable_dtor(page_ptdesc(page));
    tlb_remove_page(page);
}

- Kevin

