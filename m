Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2855CC02183
	for <linux-um@archiver.kernel.org>; Tue, 14 Jan 2025 02:28:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Q3uCzTDF/NUXWi9pKun3Q1ZeVpbVlQmIUTgvJ2reRXQ=; b=nfNDjfpsarHdoaC96jCGRbmdwH
	l88VYbf1nx9l/wLJrQvpqioDfLiLmTTniC04hJDyEZ5p6ho6Hz5/P7i/jn3jEteP+jX8OmLV3EVoq
	yqyGxxu+QVjggVgPuzKM2zKYd5SuGqSVC2uFj/WdDXc9VDx/1KUTfDx2+PLA8TN5vyFxSUYEdm5en
	JBGf4ko8DKcmfG7Afnu8bre2di9lLRK6wEysayX9xPWCPzRtPlZfWvLLw343x9fj1EDQVntOgUdHM
	EWUY0q1oqT/uGscbFGLWK7e2xPRgHUiOA9VqXBEJ+rg4CDhsPXfFagRoSHYSdetWyd8zx8m4apiTv
	3pGuoKpQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tXWfR-00000007Fcn-1QPP;
	Tue, 14 Jan 2025 02:28:33 +0000
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tXWeC-00000007FFI-0XID
	for linux-um@lists.infradead.org;
	Tue, 14 Jan 2025 02:27:17 +0000
Received: by mail-pl1-x631.google.com with SMTP id d9443c01a7336-21a7ed0155cso85186515ad.3
        for <linux-um@lists.infradead.org>; Mon, 13 Jan 2025 18:27:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736821632; x=1737426432; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q3uCzTDF/NUXWi9pKun3Q1ZeVpbVlQmIUTgvJ2reRXQ=;
        b=K8aFXw7gyJhWX0ZBNHlubOLIyYeZADf7IRPumXDNCzaApV1dG46yEU2I1D87/q3gwc
         srhCA0xEEMcYalOoXcZnxIJxvEJIzdTwYP6m6g5b7g4cbkUxD+t6+RKFCjn735RnPelR
         qtQq7mlAfQ7NAF95IifDQz3IbLAZKqUGk0CicxngD/MjebqfLMaKaQBU3RnjOy58mBkq
         f0g3xr0RFFmBUoTtG9a1raVhnDVswyKqZb/eSlkxfWc6qwn0hL1mXi4mvDVQRnlM6IYm
         AX1Jdhm+JmSDI2s4wdU5S5ZXU9i2HCUuzm+ns+vwLuRUT9keuRyh8dv7Qjqp467G+kAQ
         OtMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736821632; x=1737426432;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q3uCzTDF/NUXWi9pKun3Q1ZeVpbVlQmIUTgvJ2reRXQ=;
        b=a/LQF1tD1k284wMUnSc8NFtt6B3zA+UD5pTfaBlqLS61mVHVA0LKjvO+rcg82fL7e2
         Y/DNeb1cwTSeTfvYz4QKjTvhebzK6/UZ5/13E80/LSuBZCVa9mY2uaGaqERvNhqa2UQo
         +eyHQkwyCXiXIMBx5EN8EDfWwc8NitCl2Gn0n40hw7F34k092DON0cdBLfr5Xomax5AV
         1VF9okbqRTdIOAHvrXyDNfTOBtv1L24yBw4X0sTw5lXzojCdblZqgyKwsNqRweYT5qEV
         +KXD7KTD0jglXH5l11sA8hcJO1BPrws1P7NITjxsX23I8v206BNIg7btkI+yksC7o9zy
         G/Bg==
X-Forwarded-Encrypted: i=1; AJvYcCXKHc+nov6bwlaD/cugtIj68XKaC4S2Du7DpRE0iI1CVf7Lc067VNFSHlhUV3VeN5cEnbKzSArS2A==@lists.infradead.org
X-Gm-Message-State: AOJu0YztM8P7/pwyCnD10CjCtjOZCITbYKaHpOlH5OzbF2xr6irO7k/j
	LSpGpVV1rrIECr2xjW90JQ+G75Gc09bY8MfCi7FFD+xQNjMTr9FTGZYAXblRKG0=
X-Gm-Gg: ASbGncuQgZ0OGXETFJH+U7FzPoqk8meCTtK2q49tusSHprGugvLBKPtf4zASKnM5lMc
	5Qd2PMvNrqtMqRXm2zPxpDSlYrs9TXv0TZhup0Cv2jNQno76CvAzmhGNTDPa9z2lUQ8jxzJOTTJ
	zsZUt4IIp2bsG5QijS5TB+VmnXXN2+PoiS8biDyL4iqeuIv9YvjaYFCJMargB/SQlef4XczqEeC
	jmt64g+itIMYO3ZrS2bHfCqwMFkE0gtQ+d3lONYgV+uQTWrUKa8jn7MNSuzL512AGqXcRfX8aQ2
	HlHy
X-Google-Smtp-Source: AGHT+IFszANM2ttg3bHXqwu4kokOxCLHcRwKXlC7FRtBmzrGdqYoySfArdJur+xTrJx3xY86w59zAA==
X-Received: by 2002:a05:6a20:7f8a:b0:1db:de38:294b with SMTP id adf61e73a8af0-1e88d2f6820mr38362107637.38.1736821632027;
        Mon, 13 Jan 2025 18:27:12 -0800 (PST)
Received: from [10.84.148.23] ([63.216.146.178])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72d4056a5e8sm6847007b3a.53.2025.01.13.18.26.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jan 2025 18:27:11 -0800 (PST)
Message-ID: <a017d072-943f-4008-bb1d-7be438804a44@bytedance.com>
Date: Tue, 14 Jan 2025 10:26:54 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 05/17] arm64: pgtable: use mmu gather to free p4d level
 page table
To: Will Deacon <will@kernel.org>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
 alex@ghiti.fr, andreas@gaisler.com, palmer@dabbelt.com, tglx@linutronix.de,
 david@redhat.com, jannh@google.com, hughd@google.com, yuzhao@google.com,
 willy@infradead.org, muchun.song@linux.dev, vbabka@kernel.org,
 lorenzo.stoakes@oracle.com, akpm@linux-foundation.org, rientjes@google.com,
 vishal.moola@gmail.com, arnd@arndb.de, aneesh.kumar@kernel.org,
 npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org,
 ryan.roberts@arm.com, linux-mm@kvack.org,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org,
 linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 linux-um@lists.infradead.org
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <3fd48525397b34a64f7c0eb76746da30814dc941.1736317725.git.zhengqi.arch@bytedance.com>
 <20250113162600.GA14101@willie-the-truck>
Content-Language: en-US
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <20250113162600.GA14101@willie-the-truck>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250113_182716_159367_6AD29366 
X-CRM114-Status: GOOD (  13.97  )
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

Hi Will,

On 2025/1/14 00:26, Will Deacon wrote:
> On Wed, Jan 08, 2025 at 02:57:21PM +0800, Qi Zheng wrote:
>> Like other levels of page tables, also use mmu gather mechanism to free
>> p4d level page table.
>>
>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
>> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> Cc: linux-arm-kernel@lists.infradead.org
>> ---
>>   arch/arm64/include/asm/pgalloc.h |  1 -
>>   arch/arm64/include/asm/tlb.h     | 14 ++++++++++++++
>>   2 files changed, 14 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/arm64/include/asm/pgalloc.h b/arch/arm64/include/asm/pgalloc.h
>> index 2965f5a7e39e3..1b4509d3382c6 100644
>> --- a/arch/arm64/include/asm/pgalloc.h
>> +++ b/arch/arm64/include/asm/pgalloc.h
>> @@ -85,7 +85,6 @@ static inline void pgd_populate(struct mm_struct *mm, pgd_t *pgdp, p4d_t *p4dp)
>>   	__pgd_populate(pgdp, __pa(p4dp), pgdval);
>>   }
>>   
>> -#define __p4d_free_tlb(tlb, p4d, addr)  p4d_free((tlb)->mm, p4d)
>>   #else
>>   static inline void __pgd_populate(pgd_t *pgdp, phys_addr_t p4dp, pgdval_t prot)
>>   {
>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>> index a947c6e784ed2..445282cde9afb 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -111,4 +111,18 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>>   }
>>   #endif
>>   
>> +#if CONFIG_PGTABLE_LEVELS > 4
>> +static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4dp,
>> +				  unsigned long addr)
>> +{
>> +	struct ptdesc *ptdesc = virt_to_ptdesc(p4dp);
>> +
>> +	if (!pgtable_l5_enabled())
>> +		return;
>> +
>> +	pagetable_p4d_dtor(ptdesc);
>> +	tlb_remove_ptdesc(tlb, ptdesc);
>> +}
> 
> Should we update p4d_free() to call the destructor, too? It looks like
> it just does free_page() atm.

The patch #3 introduces the generic p4d_free() and lets arm64 to use it.
The patch #4 adds the destructor to generic p4d_free(). So IIUC, there
is no problem here.

Thanks!

> 
> Will

