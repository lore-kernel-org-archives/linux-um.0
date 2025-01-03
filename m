Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0545EE7718F
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 07:49:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzXoocIGNPwPKsYdLFaXMb11ojm1vKIwEO1w66c7Yo8=; b=aVjNoz4w2HYgMJ5hhO7R66CVgB
	FrSNoGxkQjiN6tbSidpgZWpX38OFdvETOyGGfMsSwtS06XQXPYTXOv8cAnm0pING3XykShX4eHtBS
	BLfuH7tiD3z63hAf+OkJL2fcAfY38UMZnLzXVj+mp2VawBNgwjBVj5baTsLsQRlnajdoYYGBi2lNv
	fozpPfANF+Xz0IpyV50tJnRPNqQ7FWKS31mfhe67N3EBxdMUyvpKOW0C6loMWaCXU/iMxfQWlzd+S
	F3KmR5wS8ZAy2plM0Kvj3uwHMmX72BZ8wVGYjLcATuEHCH7tjpF2ph1XqSTDLjlyPyTbLNmOO5sKr
	F3PKPnmg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcQV-0000000COse-1I7k;
	Fri, 03 Jan 2025 07:48:59 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTcOD-0000000COXF-47UT;
	Fri, 03 Jan 2025 07:46:39 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 21C9D1516;
	Thu,  2 Jan 2025 23:47:05 -0800 (PST)
Received: from [10.57.92.237] (unknown [10.57.92.237])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6E1313F6A8;
	Thu,  2 Jan 2025 23:46:28 -0800 (PST)
Message-ID: <d7f079ea-6530-4f92-9cab-bee90b84e2c3@arm.com>
Date: Fri, 3 Jan 2025 08:46:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] mm: pgtable: add statistics for P4D level page
 table
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, palmer@dabbelt.com,
 tglx@linutronix.de, david@redhat.com, jannh@google.com, hughd@google.com,
 yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
 vbabka@kernel.org, lorenzo.stoakes@oracle.com, akpm@linux-foundation.org,
 rientjes@google.com, vishal.moola@gmail.com, arnd@arndb.de, will@kernel.org,
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
 <2fa644e37ab917292f5c342e40fa805aa91afbbd.1735549103.git.zhengqi.arch@bytedance.com>
 <237a3bf6-c24f-4feb-8d3d-bb3beb2fd18e@arm.com>
 <77c202bf-e0a3-45e7-bf8d-eef7903e3c64@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <77c202bf-e0a3-45e7-bf8d-eef7903e3c64@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_234638_056905_43BB219C 
X-CRM114-Status: UNSURE (   7.65  )
X-CRM114-Notice: Please train this message.
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

On 03/01/2025 04:53, Qi Zheng wrote:
> On 2025/1/3 00:53, Kevin Brodsky wrote:
>> On 30/12/2024 10:07, Qi Zheng wrote:
>>> diff --git a/arch/riscv/include/asm/pgalloc.h
>>> b/arch/riscv/include/asm/pgalloc.h
>>> index 551d614d3369c..3466fbe2e508d 100644
>>> --- a/arch/riscv/include/asm/pgalloc.h
>>> +++ b/arch/riscv/include/asm/pgalloc.h
>>> @@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct
>>> mmu_gather *tlb, pud_t *pud,
>>>   static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>>>                     unsigned long addr)
>>>   {
>>> -    if (pgtable_l5_enabled)
>>> +    if (pgtable_l5_enabled) {
>>> +        struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
>>> +
>>> +        pagetable_p4d_dtor(ptdesc);
>>>           riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
>>
>> Nit: could use the new ptdesc variable here instead of calling
>> virt_to_ptdesc().
>
> Right, but we will remove pagetable_p4d_dtor() in patch #10, so this
> may not matter.

You're right, I missed that. Makes sense not to create a diff that's
reverted later then :)

- Kevin

