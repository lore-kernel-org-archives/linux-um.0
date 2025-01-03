Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2FCBFE77188
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 03:58:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZAFSLXktiWezwRLeMqNHQIZ8a5HqagkfYDHtpNVk3Hg=; b=VEwR1NOLOrX8z+UAg+UpnYfm1O
	W98vyn3S+vFeH6KduVhfz7Wya7olJ5grOfamIY8E5g60as86EDbOeAgdCRMMmHYgqBq8+wDr0PP4P
	ibvQ3DWKiOyb31r0yzpNGwEjy3cnW5/kZkatqGjhJjTvPT6I6C945Tonp8cc05Je0CcfsIGnQOXlx
	Kn4oHA8oTaUOQwxCq1weXekiSn9bI3cwWDUtEPN8ujtrDC9dl0YSiTbyDfcUWBhFiUcS+asMDvZCa
	TmnnZsLu0VtrxGGP+3rXZ112kij97yDhzxPaXRsC6uZJ4lrz7Dn8fcAr7scHvtRTxSWUalttSV8Dr
	Sy/phemQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTYp3-0000000C3TH-3HLH;
	Fri, 03 Jan 2025 03:58:05 +0000
Received: from mail-pl1-x62b.google.com ([2607:f8b0:4864:20::62b])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTYnn-0000000C3FY-35EL
	for linux-um@lists.infradead.org;
	Fri, 03 Jan 2025 03:56:49 +0000
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-216426b0865so160354945ad.0
        for <linux-um@lists.infradead.org>; Thu, 02 Jan 2025 19:56:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735876607; x=1736481407; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZAFSLXktiWezwRLeMqNHQIZ8a5HqagkfYDHtpNVk3Hg=;
        b=LTXOpWEnaubze8l9bv+/Z+4DqJ4GJmRjF8GmtL7BB2ylECR4GIpWqxar0k0KHbCgmd
         Cbd6Bm6oV7YcpodEH4ckulNKZo+09Qy1yupVi+ETbqp/lqEKD2j9oiXF6MUYmSSczpJL
         2E/k6m/o0/XsF+nNIzs0s1fGi3dCoWiO8pGhDtIRXgn5BM9TUg+y5vAye3AkW+y5qOBL
         osx/5NqtBKV+gmqL/fsQffyLAluoygOnz+cydRnxHvroUVs5hN93Z+JaOMHvXhvJw4Gk
         er01/ZjNotjH/lWRp359/YXMpTNgzt/vS5jdyYnfN7SrLUwKFHiefGXCS/j7paEp2+Q9
         Kxgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735876607; x=1736481407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZAFSLXktiWezwRLeMqNHQIZ8a5HqagkfYDHtpNVk3Hg=;
        b=kpbk2Od+ARiZ4jp5JRlUjNAk4gEiyBUhIaOrveD/g/oNAd7MT62GGPL55uHOczpiU0
         Evv73eQBExWeEt1NgiCqhkX9EKkXZisH85hXFHJSKAGPIZkQTONHs3OYjlNAUXu4r55D
         QxxtsmXzrvQBfcCyR9+C1Sxi0EYUbFjr2DXn69wy0ObXHIlNbq4KWkx2S6+aHc9dcJ+s
         Eqrt5+ufEEW7va5vfbsKvbVLx1jgNduYhdWoe7uh3n8pgimV+7XKvIhsPWuFxS+eT7Mh
         8YysqIso4OsYeMJmefGpTUTWXwOnN/LQ/EaqIkbyzeS4uApXcxfIVMPLSY/3Db+nDuvU
         UBQA==
X-Forwarded-Encrypted: i=1; AJvYcCXNta8nDwXCVfLkOGalqWXfui8o9WRe4urnHMfs8TJWhwvV1iJgvp9xf+FRgL19ujsBgHDKbYaOOQ==@lists.infradead.org
X-Gm-Message-State: AOJu0Yzx7wyhwJKgCMWDBpaaCgzCPIf74C5cx91LYSwLXO2Sb6r9pGfL
	cM0xB2pD2XijeuyQ+J6iVRP7p5tS0DSlruKf5vadN274X67SyeDXCqIT58pZ66o=
X-Gm-Gg: ASbGncseTs4uhQ394Sk/2e6ZDkKhcBKvrKYSWrfhBuiEiIKLb+Kg3v68C2ZynoDp4tb
	6IBSWCVLC45WO8G2MBsXgvcfbXFb97p67AI2xEYdA2vKMd5sRT+j9/5GW6loQ4q5o6oNJ/8IJ+Z
	T5nXUTK0R0i4QZLaq1Y9+hmAzoG+vYdPcjt2Tz2eX0uljsg+PKSECWx1TujuWsoaG4y1ziUw69s
	2M73sT08hDHWvUzE/PSuX1CBBl+hHmVs2QKsmqvyrwCQwqxtEtFd6o2GN9+N5k7ksSuLLma0trn
	gCWjKA==
X-Google-Smtp-Source: AGHT+IEc/ggyHLTYoMeUluV4bigOVwXpofNkIsaBMCcId3pHP1FalWdw/+NGvDWYCJeax838Cotn8g==
X-Received: by 2002:a05:6a21:158d:b0:1e1:ca91:b0e3 with SMTP id adf61e73a8af0-1e5e0800420mr68823527637.36.1735876606776;
        Thu, 02 Jan 2025 19:56:46 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8dbafesm25847661b3a.128.2025.01.02.19.56.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 19:56:46 -0800 (PST)
Message-ID: <1cea8c66-626e-434f-aafd-9d44d37f5cc4@bytedance.com>
Date: Fri, 3 Jan 2025 11:56:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 00/15] move pagetable_*_dtor() to __tlb_remove_table()
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
 <04b0a778-7a6b-4df3-b40e-ca76adddb243@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <04b0a778-7a6b-4df3-b40e-ca76adddb243@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_195647_768197_2BDC9625 
X-CRM114-Status: UNSURE (   9.33  )
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



On 2025/1/3 01:00, Kevin Brodsky wrote:
> On 30/12/2024 10:07, Qi Zheng wrote:
>> Qi Zheng (13):
>>    Revert "mm: pgtable: make ptlock be freed by RCU"
>>    mm: pgtable: add statistics for P4D level page table
>>    arm64: pgtable: use mmu gather to free p4d level page table
>>    s390: pgtable: add statistics for PUD and P4D level page table
>>    mm: pgtable: introduce pagetable_dtor()
>>    arm: pgtable: move pagetable_dtor() to __tlb_remove_table()
>>    arm64: pgtable: move pagetable_dtor() to __tlb_remove_table()
>>    riscv: pgtable: move pagetable_dtor() to __tlb_remove_table()
>>    x86: pgtable: move pagetable_dtor() to __tlb_remove_table()
>>    s390: pgtable: also move pagetable_dtor() of PxD to
>>      __tlb_remove_table()
>>    mm: pgtable: introduce generic __tlb_remove_table()
>>    mm: pgtable: move __tlb_remove_table_one() in x86 to generic file
>>    mm: pgtable: introduce generic pagetable_dtor_free()
> 
> Aside from the nit on patch 4 and the request for clarification on patch
> 10, this is looking good to me, so for the whole series (aside from my
> own patches of course):
> 
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

Thanks for your review!

> 
> And happy new year!

Happy New Year!! :)

> 
> Cheers,
> - Kevin

