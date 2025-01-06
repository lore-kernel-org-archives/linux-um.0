Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 135BEE77198
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 11:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PtS7kKDFbbWBE6dlgb91yolih02/BD7li/VWMu2pf+Q=; b=f9dYyMptl9zafcrZPK4641vIZ7
	4k32ZCbqtr8SKOBmMPPWOLKWYx2nR1d2Nk3BKP4eU5cd+yyfbqghsWpDuhSRyL7D/r/ZUUo4MRhUg
	FRwtTQZ8zok29rhEMjSLQrgKCLdJ61/y5pwk2ZnYypP8qORaagqFXkrII5MzfIzaWByIFroNnP6Wg
	TVaQdkDhvQ2D2tPYPfAbdCVa9I50/1MJb+YT+PqHWtNscdoQmTWK+9WbUzrIB9uxyCakhBHqmxE+E
	pPxY2otBlpdq7jtd+qIk6jba0wkWCqTBDz65P7QLWDd4/HjdeDlB59VKokbr/f4v3OMm9fMHSt5NP
	4koRUL+A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUksX-00000000xvz-2cdq;
	Mon, 06 Jan 2025 11:02:37 +0000
Received: from mail-pl1-x632.google.com ([2607:f8b0:4864:20::632])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUksU-00000000xtX-2Lqx
	for linux-um@lists.infradead.org;
	Mon, 06 Jan 2025 11:02:36 +0000
Received: by mail-pl1-x632.google.com with SMTP id d9443c01a7336-216401de828so190698045ad.3
        for <linux-um@lists.infradead.org>; Mon, 06 Jan 2025 03:02:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736161353; x=1736766153; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PtS7kKDFbbWBE6dlgb91yolih02/BD7li/VWMu2pf+Q=;
        b=Eus7dqncoI10RzDL5zgOdMzEsHXl/xJ9w81cT25gIev9l4X6mNV0Q8gVlBn4b32n2S
         E65Vbbw0okGDSJ9Xy9u+dY8WNt/wV5e1NlYe8ELRbW+Jg+J/C3+VIXdJiwgdTqGu7hPj
         Sv7gDXqlmQUmuWWs5xpQJ4mkcQmgRsMjwdlPkxGwWslGTm49i1paAQy1agjMwzqQ9Wwk
         0a29UL+N+yHTkLUSJTisJd2tnRmZ5JS8NsFtxxiMifCzGWRLNPUARVe5MtFBrNj4gIvb
         M/6EMqTNfY0toCzrDdKkSTscuUVsvtJz6NdWqFUD/HKLmp6ngNCVzTLH7XiWH9SHwnVJ
         IDSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736161353; x=1736766153;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PtS7kKDFbbWBE6dlgb91yolih02/BD7li/VWMu2pf+Q=;
        b=QXmw8rgB7+EO7jJ6lL5dwvzY5WTb0i12rHiTzV0J0ylSxCBrmzujWG1HMZVMg1/A9L
         PuBFRDqkwLohbYfjRkBlKAlOcCxEPUjiIpShcvC7tuG5e8J5ix57VfscxPWpPq5FIm9O
         Hx8o5zzia5q29UHqYociH5jjB7hBgwtvVMnhdVZ/w68h3sa7XGW4btAknHTKAkq4rg3G
         8aU+1ydBaKgnaV1KSxlPWGuZw3Y10gg9Q6k/gmxChhlgUmefX1Ot/cPJOEfHjDK42T3/
         S+pPrJoCL9QfdQ11P3enAQQiMaGBhU5JyYZZONdzOEV+sQ8o8yu+1+Q+JLoSDyJ18vkh
         IAZg==
X-Forwarded-Encrypted: i=1; AJvYcCVg6q4kRAFh2q+HlkjmCIBlefDtwSJsV6RAgQihEVWFDMSKtp2i31wcHUOIKsJd46DAf078DUNQgw==@lists.infradead.org
X-Gm-Message-State: AOJu0YyfI5obL5itFIC43azYIrC0/RnwFyjv+31+4rjvPCdMY7wUEuQt
	f+Elg95fyP83KesJaJnuQGxwboQBArw2C6uvKIbsT4O2eHbByOEWM+E2nlB8n4w=
X-Gm-Gg: ASbGncs0TAbtT+SCVa8ky1kIeqnpAe1h0yvEeAkLl1DhITVkxp48npK8XLMde9iT3U6
	pYXarA8oAi5rrl4rWYRRgQmJYzaSYk2ZxgZVivyePDCy9nJyIIN5RHF8dCAAzT3WQBFtM4nS6YK
	46xonJHGajKp1PVp1QDvnrIB3CTqtDK3OOUhl3eOmXpSFj4yxQAAeokIRhUbBihZ1Mha2YQCSB1
	+zVlMKmisXAle/aWr+qUG+xbUVrh1s531Y2YAGepC/p6DG1Ptz7GsBx7T3B/FzDbgBDgJ278ahm
	mFRWMw==
X-Google-Smtp-Source: AGHT+IFCeOw2arXEHpOUWAGun1CKXf9/XTpPQ1dFbIMLlKInW35U2LjXZ6DtTEzjdru/7w1/tbEHpw==
X-Received: by 2002:a05:6a00:4644:b0:725:b347:c3cc with SMTP id d2e1a72fcca58-72abdeb9c33mr83929136b3a.23.1736161353534;
        Mon, 06 Jan 2025 03:02:33 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.150])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad816464sm31123318b3a.40.2025.01.06.03.02.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 03:02:33 -0800 (PST)
Message-ID: <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
Date: Mon, 6 Jan 2025 19:02:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of PxD
 to __tlb_remove_table()
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
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_030234_620145_1DBDBB1B 
X-CRM114-Status: GOOD (  12.91  )
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



On 2025/1/6 18:36, Alexander Gordeev wrote:
> On Mon, Dec 30, 2024 at 05:07:47PM +0800, Qi Zheng wrote:
>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>> PMD|PUD|P4D to __tlb_remove_table().
> 
> The above and Subject are still incorrect: pagetable_dtor() is
> called from pagetable_dtor_free(), not from __tlb_remove_table().

Hmm, __tlb_remove_table() calls pagetable_dtor_free(), so moving to
pagetable_dtor_free() means moving to __tlb_remove_table(). Right?
And the main purpose of this patch is also to move pagetable_dtor()
to __tlb_remove_table(). So I think this description makes sense?

> 
> ...
>> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
>> index 569de24d33761..c73b89811a264 100644
>> --- a/arch/s390/mm/pgalloc.c
>> +++ b/arch/s390/mm/pgalloc.c
>> @@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>>   	return table;
>>   }
>>   
>> -static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
>> +static void pagetable_dtor_free(struct ptdesc *ptdesc)
>>   {
>>   	pagetable_dtor(ptdesc);
>>   	pagetable_free(ptdesc);
>> @@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>>   {
>>   	struct ptdesc *ptdesc = virt_to_ptdesc(table);
>>   
>> -	pagetable_pte_dtor_free(ptdesc);
>> +	pagetable_dtor_free(ptdesc);
>>   }
>>   
>>   void __tlb_remove_table(void *table)
>>   {
>>   	struct ptdesc *ptdesc = virt_to_ptdesc(table);
>> -	struct page *page = ptdesc_page(ptdesc);
>>   
>> -	if (compound_order(page) == CRST_ALLOC_ORDER) {
>> -		/* pmd, pud, or p4d */
>> -		pagetable_free(ptdesc);
>> -		return;
>> -	}
>> -	pagetable_pte_dtor_free(ptdesc);
>> +	pagetable_dtor_free(ptdesc);
>>   }

