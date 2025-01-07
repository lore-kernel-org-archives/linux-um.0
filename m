Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BEAE77197
	for <linux-um@archiver.kernel.org>; Tue,  7 Jan 2025 12:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rBNgt4Pp+5r8EWFOkpTfSkW0RGZvpIi++k6cMXShG00=; b=Bng5g8MuGcE3kqikfQ7ZrN4ZWQ
	CmNXMKUyyHHN+Ah8pQ7osCw9tMuOpByEHOhvKtmGhPMyKnUdVGAcjc2/yJeVYb4PA+3+YfhxA0IRw
	roYBAPD+RUpVyozWwZ/pr+BLFJbKX7np4Mrlyt/VKYlxKzVUNl5oYEwppcdWGPCzYBW7qaw5lVWvp
	TV7m7LZlppAzX0ZjHVT4SqXKGoYRQG18biCfpOJsDiJ6HalpXOzgxqWruusuiJhOhs6/vGzbtNcPN
	0yAiwKUulUdsa2NucvjOupw1Sx63rAoHS2qwFWIiK2L/ldLKAQhCfrhAlDs3qadHb3WzI8O+KZQp/
	98PHB8Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tV8p1-00000004nR7-2vaR;
	Tue, 07 Jan 2025 12:36:35 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tV8nB-00000004mv8-2LhI
	for linux-um@lists.infradead.org;
	Tue, 07 Jan 2025 12:34:48 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2163dc5155fso222185605ad.0
        for <linux-um@lists.infradead.org>; Tue, 07 Jan 2025 04:34:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736253281; x=1736858081; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rBNgt4Pp+5r8EWFOkpTfSkW0RGZvpIi++k6cMXShG00=;
        b=l2/Vit2DKZvUFAHNzQk0nTt3q9RldYSfxSXgtNVRPYgNpJ9N2eVzqILJiSoGg18Bnp
         DcD93rC3He0tJxhAzS4gUxMJSVfgjKdpSkCETl4yZq/cWtmZAPcLNl7WQm2FgMNpLADy
         pdsgqREwqNrbMyxmc4tk2JFv8vbf9HCnueSNl7wtCygTeZIYLCr8quMTygGZYpIhCYJm
         sQmeLpQ4F/Z+htKXXnvwSIZQLngO0K4EFJ04YVTw+QJX/maX59Ne/v9hxCvnA65Q0gK5
         oYkREmkFt2IbMJBQGGUnYjr6YDg2Uwpa6gF+/kr7PEZjSMJY/Cr//os2Sziaa+FhSoeW
         8/+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736253281; x=1736858081;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rBNgt4Pp+5r8EWFOkpTfSkW0RGZvpIi++k6cMXShG00=;
        b=J6OodzpBKsSjrvMnE04V+VpxEK67KUUZrjRqedbBR3RE1p+SWnn3WnS4M2kceGVN/n
         UMElONb7QIaLNFuQddDQxROSk4lwtIrNxA/VKslB1TUowYFhie/sde4+1F3eMyoBLyJ8
         MwbSNk05W86AJFENvZrM18vYaOEnyhTEtN1QPsAMzoHvbrBe6pyq3YRBTEcS1fnp987n
         3x9oHUXTbF1ki4UIK2uCkJkJCB2mrYdWb0IhqdMaHDm8Qm5gxf/04TzkyMSxAeJRaZlA
         j93FPYASQdit5QVx3kZ/9qzoXWCMcjwLNUTNXXv/nw2xNCn282QVHdwYZBu1T2MYhKMe
         SUGg==
X-Forwarded-Encrypted: i=1; AJvYcCVHTkPfRkUL8prMfk8NMq9NTushSeNXjw4mDTZJjsB5olTC7KmqbLkvEWZx2x2O09n+ZgGqAtY2Dg==@lists.infradead.org
X-Gm-Message-State: AOJu0YwF16xVudD29SJBkIzBF+X2CpjAf/7314dxmx5peBzrILjQSXFv
	CFDNuUfRVNwAYkv/UDKOjh/JiawMg2wyPqeIv/sXX7YKEBDG4dFTCHVyermgFlM=
X-Gm-Gg: ASbGncvAtVzTfTcf0GnzgQoiXq0JAaHdQYJ1bXex6aolhQjZql/wtOTlY5REPZfhB29
	lStSMjD3cURujIaESiR4jVzyzsYO7HDHXu8nJ9zYrSvo9oA3AwKlcYNof0HpVKIRzVJCwgpCcGg
	LDYn7nbAsvKhQsewcGGh7CAZRffykec7E0mMSLkF7Es3W6ym8LYBCroMTCuNNtBI8LV7p9NLMCi
	ylpMDv/1GCes6DI08MbGMcOPWjeqVXxS249DzuGVe65l9l/ZrsoELgf/eZtV5CT9m03sqvxSsiq
	8qR0
X-Google-Smtp-Source: AGHT+IE3yUUkb0m+aLP2spLDFrGsHc6y1BQTdsXYC7/WM0wTJqWEm80meD2oBwGaRCvgAk0D5TXwug==
X-Received: by 2002:a17:902:e746:b0:215:8847:435c with SMTP id d9443c01a7336-219e6e8c595mr965146185ad.12.1736253280842;
        Tue, 07 Jan 2025 04:34:40 -0800 (PST)
Received: from [10.4.33.153] ([139.177.225.247])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc962cddsm311379695ad.48.2025.01.07.04.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jan 2025 04:34:40 -0800 (PST)
Message-ID: <9040b9ee-88c9-4347-b8b6-5894b45e62b8@bytedance.com>
Date: Tue, 7 Jan 2025 20:34:22 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 13/15] mm: pgtable: introduce generic
 __tlb_remove_table()
Content-Language: en-US
To: Andreas Larsson <andreas@gaisler.com>
Cc: peterz@infradead.org, agordeev@linux.ibm.com, kevin.brodsky@arm.com,
 palmer@dabbelt.com, tglx@linutronix.de, david@redhat.com, jannh@google.com,
 hughd@google.com, yuzhao@google.com, willy@infradead.org,
 muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
 akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
 arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com,
 dave.hansen@linux.intel.com, rppt@kernel.org, ryan.roberts@arm.com,
 linux-mm@kvack.org, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, linux-arch@vger.kernel.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-sh@vger.kernel.org, linux-um@lists.infradead.org
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <f7febc7719fd84673a8eae8af71b7b4278d3e110.1735549103.git.zhengqi.arch@bytedance.com>
 <6e1aa2aa-a70d-4292-9c5e-21c8fea386f5@gaisler.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <6e1aa2aa-a70d-4292-9c5e-21c8fea386f5@gaisler.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_043441_600650_3F9F8E47 
X-CRM114-Status: GOOD (  10.03  )
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



On 2025/1/7 20:32, Andreas Larsson wrote:
> On 2024-12-30 10:07, Qi Zheng wrote:
>> diff --git a/arch/sparc/include/asm/tlb_32.h b/arch/sparc/include/asm/tlb_32.h
>> index 5cd28a8793e39..910254867dfbd 100644
>> --- a/arch/sparc/include/asm/tlb_32.h
>> +++ b/arch/sparc/include/asm/tlb_32.h
>> @@ -2,6 +2,7 @@
>>   #ifndef _SPARC_TLB_H
>>   #define _SPARC_TLB_H
>>   
>> +#define __HAVE_ARCH_TLB_REMOVE_TABLE
> 
> sparc32 does not select MMU_GATHER_TABLE_FREE, and therefore does not
> have (nor need) __tlb_remove_table, so this define should not be added.

Got it. Will remove it in v5.

> 
> 
>>   #include <asm-generic/tlb.h>
>>   
>>   #endif /* _SPARC_TLB_H */
>> diff --git a/arch/sparc/include/asm/tlb_64.h b/arch/sparc/include/asm/tlb_64.h
>> index 3037187482db7..1a6e694418e39 100644
>> --- a/arch/sparc/include/asm/tlb_64.h
>> +++ b/arch/sparc/include/asm/tlb_64.h
>> @@ -33,6 +33,7 @@ void flush_tlb_pending(void);
>>   #define tlb_needs_table_invalidate()	(false)
>>   #endif
>>   
>> +#define __HAVE_ARCH_TLB_REMOVE_TABLE
>>   #include <asm-generic/tlb.h>
>>   
>>   #endif /* _SPARC64_TLB_H */
> LGTM.
> 
> 
> With the removal of the define for sparc32 in v5:
> 
> Acked-by: Andreas Larsson <andreas@gaisler.com> # sparc

Thanks!

> 
> Thanks,
> Andreas
> 

