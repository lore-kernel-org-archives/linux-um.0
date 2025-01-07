Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CE59E77199
	for <linux-um@archiver.kernel.org>; Tue,  7 Jan 2025 09:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B6jA30ID1W/7/7ogTwqiCTGjsVA+UOtm0dKxYnyJ8+Q=; b=RKMwQWe7/GKTGMawLzOTeaX3eG
	MCEiMcxMM0gSZPhFlioB0ELuc9j7Z5TrTxsAj96guqoSyJFAYPFGBAK83C05IX06MVBGR7PRCKxTy
	f24tuSvsq016zzgl+qDjSFgE6I/ZBhPoQspzpsGeOOQ6/FTI9qZLB5YrNHmEb68CBoBAQ+xMvWDZy
	8rEAgeT6663L7zubCfdNGiQ6+INmlIPXZ4j52iQcbOpBx+4qe3RIbQUlIRD4AHG7kc4qNBXjKjCIV
	BSqslmVlfBNvsDEMujzIvwwn8UQcJnnOewdFojK5myhJUvy4Xe7/2UHtYptw2VocWwm1AIH+8CJyT
	Ff6EshAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5rK-000000047GT-3fwG;
	Tue, 07 Jan 2025 09:26:46 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV5oi-000000046Wy-3Nmu;
	Tue, 07 Jan 2025 09:24:06 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ADFCE143D;
	Tue,  7 Jan 2025 01:24:31 -0800 (PST)
Received: from [10.57.93.53] (unknown [10.57.93.53])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 96F593F66E;
	Tue,  7 Jan 2025 01:23:54 -0800 (PST)
Message-ID: <83df51a5-5eb9-4470-92a1-e69fd12b98b4@arm.com>
Date: Tue, 7 Jan 2025 10:23:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 07/15] mm: pgtable: introduce pagetable_dtor()
To: Qi Zheng <zhengqi.arch@bytedance.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, palmer@dabbelt.com, tglx@linutronix.de,
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
 <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <e1de887c-6193-48ee-a9b3-04c8a0cdda45@bytedance.com>
 <Z3vOZ18jcCpHIcPD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <bce4bb4e-459a-44c8-945b-8889149377fd@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <bce4bb4e-459a-44c8-945b-8889149377fd@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_012404_887239_34D3927F 
X-CRM114-Status: GOOD (  10.74  )
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

On 06/01/2025 14:23, Qi Zheng wrote:
> On 2025/1/6 20:36, Alexander Gordeev wrote:
>> On Mon, Jan 06, 2025 at 06:55:58PM +0800, Qi Zheng wrote:
>>>>> +static inline void pagetable_dtor(struct ptdesc *ptdesc)
>>>>> +{
>>>>> +    struct folio *folio = ptdesc_folio(ptdesc);
>>>>> +
>>>>> +    ptlock_free(ptdesc);
>>>>> +    __folio_clear_pgtable(folio);
>>>>> +    lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>>>>> +}
>>>>> +
>>>>
>>>> If I am not mistaken, it is just pagetable_pte_dtor() rename.
>>>> What is the point in moving the code around?
>>>
>>> No, this is to unify pagetable_p*_dtor() into pagetable_dtor(), so
>>> that we can move pagetable_dtor() to __tlb_remove_table(), and then
>>> ptlock and PTE page can be freed together through RCU, which is
>>> also the main purpose of this patch series.
>>
>> I am only talking about this patch. pagetable_dtor() code above is
>> the same pagetable_pte_dtor() below - it is only the function name
>> that changed. So why to move the function body? Anyway, that is
>
> Ah, I just don't want to put pagetable_dtor() in between
> pagetable_pte_ctor() and ___pte_offset_map(), so I moved it above
> pagetable_pte_ctor(). No other special reason. 😉 

I think inserting pagetable_dtor() there makes sense. I wouldn't say
that pagetable_pte_dtor() is being renamed to pagetable_dtor(), because
in fact this patch replaces all of pagetable_{pte,pmd,pud}_dtor() with
pagetable_dtor(), and it is arguably clearer to insert the latter higher
up in mm.h.

FWIW my follow-up series introduces a common __pagetable_dtor(),
inserted below pagetable_ctor() [1].

- Kevin

[1]
https://lore.kernel.org/linux-mm/20250103184415.2744423-2-kevin.brodsky@arm.com/

