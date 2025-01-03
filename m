Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0CC0E77188
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 09:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FvjXC1OjFutvGYgxD2wHa2wTk86a/9lW5eStlVFSRNE=; b=26mvaTP3lx+jnKAAWWekOz36YH
	0xH4qj5bKjbbc2pLkIoyseprHH/gjFoleVREgDmwvVTj1SJU8W3K2RZqIK5sUb4/CnH1yEsEt36mA
	e8MDbuPkDWRsAzzESonstir9IQJZpQtWoQdoMNWhFBgndTs8TOB3aZ+jjQFl0L51NFiM0evyGjcpO
	tOvxRhwLrjb8rH4mvn7IMcIlNlt2BZMgEwpAemSxYpbL5aYwyKbFGiFKPmrN7/VnIFXmzRjOSDhPg
	twnJW5AcQ6fBLwiGIQWYRXPm6DLL+w2zu2yjdlyruvzULr5jSpuOLZP6iYnFpIzLGnO3DWqpvuzTG
	TL0Eqm6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdlW-0000000CZSg-2aVy;
	Fri, 03 Jan 2025 09:14:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdkT-0000000CZKI-1vYR
	for linux-um@bombadil.infradead.org;
	Fri, 03 Jan 2025 09:13:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=FvjXC1OjFutvGYgxD2wHa2wTk86a/9lW5eStlVFSRNE=; b=VGWrp9w0hWhDfwLckeVy2khrI5
	emZlbOXWh0sxvXS2aWcItSxXCRw7UEckKEMNAf1thkp+iISAWKTn37gGB/vsAykBpMRGDDWF9KRlZ
	ctA7zVPwJL7lP5SJQ0kkflViJYTa3s/4MeUlQ06KMlLdk7Bjb6Fa1Zrmca7MNa4kXMFLqTiGokPye
	LS31wEW7EpIoEww1/dKo9XE4Nu4Ek4Bbipxf+N79MNkUR1XB62MfOJYEhgC0RwX8+SfELuKSHBkJC
	qhqV6OoXgwFRHCvES2pc9t/7fQaziq8OTi0teS5zRKkjrvkvB6jS4t3Ws5vNH8SkL9Q74ifTNyfLg
	6A2j6ocQ==;
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by desiato.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdkO-00000008LEP-3bmP
	for linux-um@lists.infradead.org;
	Fri, 03 Jan 2025 09:13:39 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-216634dd574so111295645ad.2
        for <linux-um@lists.infradead.org>; Fri, 03 Jan 2025 01:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735895609; x=1736500409; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FvjXC1OjFutvGYgxD2wHa2wTk86a/9lW5eStlVFSRNE=;
        b=YaRCkHDqDpY8yb4dktxA6vn4U6QJCDSlOjJ+/dCx8JZC40KbzAyhAmmxALdBV+sYk2
         AnySEVz2WxzFNS+gbuhtMdzZFeqGJO/5T3iTar0lgU9O4VpGc/Egm4NzNeH3uqte3AmE
         uSrdo1ZOvYwlywWzqa5KVIa7ifKq1m/NUq5cF52GZb/BtsGMQQZ3N3HILs69Z3GkLtwe
         I9csdAWmU5Ml94Itv0EpKVoayON8/LN2uw2U8fIW/klIhHaN5jQNruX5kvLOqRTy8dzY
         EWTN/QLU4DDBNLBweAstFL84MSPs7moAkdZFlhzq3hgkryhrzO+3t5OI2dU2eUE6XvSi
         4KZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735895609; x=1736500409;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FvjXC1OjFutvGYgxD2wHa2wTk86a/9lW5eStlVFSRNE=;
        b=cKNZq1ul3wt84VnG7xB1J8lG5xRBM8VYwq32tac7llpYdgwoeXUZ6VKTxRQgvacQaa
         D4ZyvE7gQ/XR1vCpd/+3IkJFmMF+h8srkx4D947tT31jnrpx2qo4xBym83Jw1a/+cdli
         2U41ya71X8NU44saqQddB+5z+zSJBkZapf7niyivCW0dDMDuRHtgmAT7MjOIKy6XHbHs
         UdcnJpmeTWerSKi+lrgCgknxer626KktMcf8/vvRKe//iB48R4N6cYAkpIQADzjM77fS
         SG/zqhY0L56e4thaajE4pYoze7mdncq5ORHi1elZxoNVbwtpmJpXljxb1p417B+5yVGo
         krMw==
X-Forwarded-Encrypted: i=1; AJvYcCUiwZJKZseEeS4Upci4zSbXwPSi0F5R7Ip3VFfz7JnW8uWxDMPtBY414tlmsR1oWnsV66D4ma6z3A==@lists.infradead.org
X-Gm-Message-State: AOJu0YwxMtKp2efRprcJ0FtvDZUHfNEDG0HpB1qX5c+F7IrmKIMb96GO
	jrjPH37dzZt8nb66Y2FEe7k9kN3TvoBTAlZqv1l9bIVhbl4zJmszrKg7x7REx6s=
X-Gm-Gg: ASbGncvOaqGBth1FwPug5L4MjXR0054o8saw5NtvcotBK1/6dKW5+Mqnmr9TUmfEvNM
	wTUqYfp9gITJNvtGjRa+MpyBFAOULIXcqYoBgh1ck2o++sukA0cY38iBHbIP4QrHKCIEO6QHqa3
	LKcZRXqmYk6T+sjn4hvuIKRXfkMKQjs453ChWuX24jQK/6M76F+Ol5fY0A/QiqLS90Pp2KEK55x
	LBULhxU93aaqxa6aM2kZ93LkacrpNZBae1jPX0/wVMK3qrneeEWuJ6Nhav698C4DpkriKberugA
	DApSZw==
X-Google-Smtp-Source: AGHT+IEXJPN8gGhA2HYYDOMJlHA0eNtjpiDq/sKLXwKwTWFhE1ZE5FTpP/Am20/VMhak6uDuJsOrhQ==
X-Received: by 2002:a17:903:11d2:b0:215:a60d:bcc9 with SMTP id d9443c01a7336-219e6e89536mr708942765ad.2.1735895609241;
        Fri, 03 Jan 2025 01:13:29 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cde19sm241412365ad.167.2025.01.03.01.13.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Jan 2025 01:13:27 -0800 (PST)
Message-ID: <e9fe97d4-99d5-443e-b722-43903655a76e@bytedance.com>
Date: Fri, 3 Jan 2025 17:13:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 10/15] riscv: pgtable: move pagetable_dtor() to
 __tlb_remove_table()
Content-Language: en-US
To: Kevin Brodsky <kevin.brodsky@arm.com>
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
 <0e8f0b3835c15e99145e0006ac1020ae45a2b166.1735549103.git.zhengqi.arch@bytedance.com>
 <1b09335c-f0b6-4ccb-9800-5fb22f7e8083@arm.com>
 <ebce5e05-5e46-4c6e-94a0-bcf3655a862b@bytedance.com>
 <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <7e2c26c8-f5df-4833-a93f-3409b00b58fd@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_091337_335752_707F651D 
X-CRM114-Status: GOOD (  23.88  )
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



On 2025/1/3 16:02, Kevin Brodsky wrote:
> On 03/01/2025 04:48, Qi Zheng wrote:
>> Hi Kevin,
>>
>> On 2025/1/3 00:53, Kevin Brodsky wrote:
>>> On 30/12/2024 10:07, Qi Zheng wrote:
>>>>    static inline void riscv_tlb_remove_ptdesc(struct mmu_gather *tlb,
>>>> void *pt)
>>>>    {
>>>> -    if (riscv_use_sbi_for_rfence())
>>>> +    if (riscv_use_sbi_for_rfence()) {
>>>>            tlb_remove_ptdesc(tlb, pt);
>>>> -    else
>>>> +    } else {
>>>> +        pagetable_dtor(pt);
>>>>            tlb_remove_page_ptdesc(tlb, pt);
>>>
>>> I find the imbalance pretty confusing: pagetable_dtor() is called
>>> explicitly before using tlb_remove_page() but not tlb_remove_ptdesc().
>>> Doesn't that assume that CONFIG_MMU_GATHER_HAVE_TABLE_FREE is selected?
>>> Could we not call pagetable_dtor() from __tlb_batch_free_encoded_pages()
>>> to ensure that the dtor is always called just before freeing, and remove
>>
>> In __tlb_batch_free_encoded_pages(), we can indeed detect PageTable()
>> and call pagetable_dtor() to dtor the page table pages.
>> But __tlb_batch_free_encoded_pages() is also used to free normal pages
>> (not page table pages), so I don't want to add overhead there.
> 
> Interesting, can a tlb batch refer to pages than are not PTPs then?

Yes, you can see the caller of __tlb_remove_folio_pages() or 
tlb_remove_page_size().

> 
>>
>> But now I think maybe we can do this in tlb_remove_page_ptdesc(), like
>> this:
>>
>> diff --git a/arch/csky/include/asm/pgalloc.h
>> b/arch/csky/include/asm/pgalloc.h
>> index f1ce5b7b28f22..e45c7e91dcbf9 100644
>> --- a/arch/csky/include/asm/pgalloc.h
>> +++ b/arch/csky/include/asm/pgalloc.h
>> @@ -63,7 +63,6 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>>
>>   #define __pte_free_tlb(tlb, pte, address)              \
>>   do {                                                   \
>> -       pagetable_dtor(page_ptdesc(pte));               \
>>          tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));  \
>>   } while (0)
>>
>> [...]
>>
>> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
>> index a96d4b440f3da..a59205863f431 100644
>> --- a/include/asm-generic/tlb.h
>> +++ b/include/asm-generic/tlb.h
>> @@ -506,6 +506,7 @@ static inline void tlb_remove_ptdesc(struct
>> mmu_gather *tlb, void *pt)
>>   /* Like tlb_remove_ptdesc, but for page-like page directories. */
>>   static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb,
>> struct ptdesc *pt)
>>   {
>> +       pagetable_dtor(pt);
>>          tlb_remove_page(tlb, ptdesc_page(pt));
>>   }
> 
> I think this is an interesting idea, it does make arch code easier to
> follow. OTOH it would have been more natural to me to call
> pagetable_dtor() from tlb_remove_page(). I can however see that this
> doesn't work, because tlb_remove_table() is defined as tlb_remove_page()
> if CONFIG_MMU_GATHER_HAVE_TABLE_FREE isn't selected. Which brings me
> back to my earlier question: in that case, aren't we missing a call to
> pagetable_dtor() when using tlb_remove_table() (or tlb_remove_ptdesc())?

Thank you for pointing this out!

Now, there are the following architectures selected 
CONFIG_MMU_GATHER_RCU_TABLE_FREE:

1. arm: select MMU_GATHER_RCU_TABLE_FREE if SMP && ARM_LPAE
2. arm64: select MMU_GATHER_RCU_TABLE_FREE
3. powerpc: select MMU_GATHER_RCU_TABLE_FREE
4. riscv: select MMU_GATHER_RCU_TABLE_FREE if SMP && MMU
5. s390: select MMU_GATHER_RCU_TABLE_FREE
6. sparc: select MMU_GATHER_RCU_TABLE_FREE if SMP
7. x86: select MMU_GATHER_RCU_TABLE_FREE	if PARAVIRT

If CONFIG_MMU_GATHER_TABLE_FREE is selected, an architecture is expected
to provide __tlb_remove_table(). This patch series modifies the
__tlb_remove_table() in arm, arm64, riscv, s390 and x86. Among them,
arm64 and s390 unconditionally select MMU_GATHER_RCU_TABLE_FREE, so we
only need to double-check arm, riscv and x86.

For x86, it was called tlb_remove_page() in the non-PARAVIRT case, and I
added pagetable_dtor() for it explicitly (see patch #11), so this should
be no problem.

For riscv, it will only call tlb_remove_ptdesc() in the case of
SMP && MMU, so this should be no problem.

For arm, the call to pagetable_dtor() is indeed missed in the
non-MMU_GATHER_RCU_TABLE_FREE case. This needs to be fixed. But we
can't fix this by adding pagetable_dtor() to tlb_remove_table(),
because some architectures call tlb_remove_table() but don't support
page table statistics, like sparc.

So a more direct fix might be:

diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
index a59205863f431..0a131444a18ca 100644
--- a/include/asm-generic/tlb.h
+++ b/include/asm-generic/tlb.h
@@ -500,6 +500,9 @@ static inline void tlb_remove_page(struct mmu_gather 
*tlb, struct page *page)

  static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
  {
+#ifndef CONFIG_MMU_GATHER_TABLE_FREE
+       pagetable_dtor(pt);
+#endif
         tlb_remove_table(tlb, pt);
  }

Or fix it directly in arm? Like the following:

diff --git a/arch/arm/include/asm/tlb.h b/arch/arm/include/asm/tlb.h
index ea4fbe7b17f6f..cf5d0ca021440 100644
--- a/arch/arm/include/asm/tlb.h
+++ b/arch/arm/include/asm/tlb.h
@@ -43,6 +43,9 @@ __pte_free_tlb(struct mmu_gather *tlb, pgtable_t pte, 
unsigned long addr)
         __tlb_adjust_range(tlb, addr - PAGE_SIZE, 2 * PAGE_SIZE);
  #endif

+#ifndef CONFIG_MMU_GATHER_TABLE_FREE
+       pagetable_dtor(ptdesc);
+#endif
         tlb_remove_ptdesc(tlb, ptdesc);
  }

Thanks,
Qi

> 
> - Kevin

