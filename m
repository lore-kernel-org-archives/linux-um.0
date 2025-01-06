Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D11FE77188
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 11:10:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=90v7s8TT3xlSw2lUPUFz/yMbjnPAJgy/hnUWpq/XFIU=; b=X7BcV4I5WSQrdiKvrwl4tQHeT0
	FYKSqbbqhxhLUjO1UvrxbUICQT4yUesZ84gro5ebqBWedr7sUBubd61eAZAijLbfdodJ9LuJZbzYA
	8GlKVQENjUaqJ7iyukwIrIdg2lcjNqKSAN6YeJp1So+x3hRw6NHBQt0IRUEcQ5xq7dMD3QBiNSCD3
	e4uu3hxe2z8Ac01PCDWt1IQWAABQUC20+AwCrl6f2xaforVMxMao32nWmuzK+FJYpbsll4OZUHC/y
	LX8/mddqyHirQDtYAo5DG89ADwc/15sPlauECBs22tcHn8DJ+GL28DNgrAd4jyuxA9EQ3xH4KrSps
	GmU5FY8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkzw-00000000zcv-45in;
	Mon, 06 Jan 2025 11:10:16 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkvM-00000000yjB-25NY
	for linux-um@lists.infradead.org;
	Mon, 06 Jan 2025 11:05:34 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2161eb95317so209101725ad.1
        for <linux-um@lists.infradead.org>; Mon, 06 Jan 2025 03:05:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736161531; x=1736766331; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=90v7s8TT3xlSw2lUPUFz/yMbjnPAJgy/hnUWpq/XFIU=;
        b=Bv55tGF0gCDk/sTKnGiu16ou8/9GM7sG1kTUfv174eGrnrBZDksLX39KJC3IHlnoRb
         YU5SYpm40F8mLyhbyLjIGNSLdfCwbqMC1WQoMCunpyvbeiSskQpKTDpRIHMDQVon4xB9
         XOYQvVpch5qo0jkpA97g1fgsr5A91789Orvo2z8rCZsQ2MdJ+RsyKJhuXec91V28k+zJ
         yBwMjD+Y2V2+3EbCIF+cQEI4FDf5JQ+bubhCljw2pfcUOOs/JgBc/Vs/pBaM9jElHZGK
         ooVZdI8JfcaA9jI3rodxP9R2M8Rsm3lbcixe52v5YbPdPKMrJo+bA5QL6UxMVuDzdyi/
         J4jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736161531; x=1736766331;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=90v7s8TT3xlSw2lUPUFz/yMbjnPAJgy/hnUWpq/XFIU=;
        b=mvF7Gtzixk1bFOrKvp+WdhUNuvE+qnts/Gg56+h6nnz4Ac+wiE6Dz+qViVYjORoLm2
         g1dGZsBr8qSehccFS3KEwGYPzOa1AsjT+GzxVQ1Zi170QBmX+j2YCyMr1+/u9Kx7/qH3
         p60u3jFh9RS2juF8IA+KYsY7C8U9TUnlx7CqBCGogM2/cb3fbWNGVQaknXIrtNhJq8uq
         jb6Rva4+ORGPmrhINCJgiV1pcHDUHqKMEJxpeCXjUrHg7MlaTq+M7ennJP9JURRu9LWy
         0PRGWuG98DXNticzoamCQ2cyKn04aVbPcsQ49XLdE9ABPDhXJr9JH3qSiNyk3k/NzcO3
         SfRw==
X-Forwarded-Encrypted: i=1; AJvYcCU547Nl5nU60B0cY9iZCoUckvT+ZvLRtR6VlL8GiguVYWuatAoI025DfE57gMpSQKtdUDrmPCLHMA==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyt8473jHIhSWiPpS/giUxht1z2fNWNq1dEsGWyGB0CYclrNFbR
	ql378BC+oLcOyRLcYGF7TVYTiacOw68gr3gu3sWYmwn+pj1wwRV/2LZEC4EknDc=
X-Gm-Gg: ASbGncvrs3OwkdKpP+o7PvDVvv7Yvo60yrJkaTN2pQK9h+gt1vN+ng3B3Yjt7GE2Pk/
	QIibJ9lAjmaUufJb/coZdOXs6sSB+KsJ/H/Bhx53OmEPAj4NeQjtAJMVDKLoz+nL7zrHtqs74dx
	Lb5AMa7IUSXf4mw4JGRU7itBHQmgfq7uTI0+M1zv6eN2mWHuvIcmH++8okf9+kY49y016jZVQw9
	lanobYK1HNiRVl6SLH4uiLASOnDf6H4Zj4gptJOM/YLD0uLWRCepJesLnB9zaW0LbJrdd8oPrAH
	ZDo+MQ==
X-Google-Smtp-Source: AGHT+IE9JcDEXfRGdbs/GeoaL5OkZZjAJop4jCS2xW4+Uq7eaBcmeEMmC0BHepygycRFzBYwAZovzA==
X-Received: by 2002:a05:6a00:35c6:b0:725:4109:5b5f with SMTP id d2e1a72fcca58-72abdd7bc5dmr104274758b3a.8.1736161531577;
        Mon, 06 Jan 2025 03:05:31 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbb42sm31017515b3a.115.2025.01.06.03.05.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 03:05:31 -0800 (PST)
Message-ID: <a3a2bd64-9952-4c66-8626-f2436ce07d1d@bytedance.com>
Date: Mon, 6 Jan 2025 19:05:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 06/15] s390: pgtable: add statistics for PUD and P4D
 level page table
Content-Language: en-US
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
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
 <35be22a2b1666df729a9fc108c2da5cce266e4be.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxVkg3i7zXI92e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3uxVkg3i7zXI92e@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_030532_553388_B52465A4 
X-CRM114-Status: GOOD (  15.19  )
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



On 2025/1/6 18:32, Alexander Gordeev wrote:
> On Mon, Dec 30, 2024 at 05:07:41PM +0800, Qi Zheng wrote:
>> Like PMD and PTE level page table, also add statistics for PUD and P4D
>> page table.
> ...
>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
>> index e95b2c8081eb8..b946964afce8e 100644
>> --- a/arch/s390/include/asm/tlb.h
>> +++ b/arch/s390/include/asm/tlb.h
>> @@ -110,24 +110,6 @@ static inline void pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd,
>>   	tlb_remove_ptdesc(tlb, pmd);
>>   }
>>   
>> -/*
>> - * p4d_free_tlb frees a pud table and clears the CRSTE for the
>> - * region second table entry from the tlb.
>> - * If the mm uses a four level page table the single p4d is freed
>> - * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
>> - * to avoid the double free of the p4d in this case.
>> - */
>> -static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>> -				unsigned long address)
>> -{
>> -	if (mm_p4d_folded(tlb->mm))
>> -		return;
>> -	__tlb_adjust_range(tlb, address, PAGE_SIZE);
>> -	tlb->mm->context.flush_mm = 1;
>> -	tlb->freed_tables = 1;
>> -	tlb_remove_ptdesc(tlb, p4d);
>> -}
>> -
>>   /*
>>    * pud_free_tlb frees a pud table and clears the CRSTE for the
>>    * region third table entry from the tlb.
>> @@ -140,11 +122,30 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>>   {
>>   	if (mm_pud_folded(tlb->mm))
>>   		return;
>> +	pagetable_pud_dtor(virt_to_ptdesc(pud));
>>   	tlb->mm->context.flush_mm = 1;
>>   	tlb->freed_tables = 1;
>>   	tlb->cleared_p4ds = 1;
>>   	tlb_remove_ptdesc(tlb, pud);
>>   }
>>   
>> +/*
>> + * p4d_free_tlb frees a p4d table and clears the CRSTE for the
>> + * region second table entry from the tlb.
>> + * If the mm uses a four level page table the single p4d is freed
>> + * as the pgd. p4d_free_tlb checks the asce_limit against 8PB
>> + * to avoid the double free of the p4d in this case.
>> + */
>> +static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>> +				unsigned long address)
>> +{
>> +	if (mm_p4d_folded(tlb->mm))
>> +		return;
>> +	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
>> +	__tlb_adjust_range(tlb, address, PAGE_SIZE);
>> +	tlb->mm->context.flush_mm = 1;
>> +	tlb->freed_tables = 1;
>> +	tlb_remove_ptdesc(tlb, p4d);
>> +}
> 
> I understand that you want to sort p.._free_tlb() routines, but please

Yes, I thought it was a minor change, so I just did it.

> do not move the code around or make a separate follow-up patch.

Well, if you have a strong opinion about this, I can send an updated
patch.

Thanks!

> 
> Thanks!

