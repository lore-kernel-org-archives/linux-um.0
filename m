Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0236E77188
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 03:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ExtURrdtg4wvz/5S73kPKLfYL+g+cN7JWlBZcDSiUw0=; b=ygCpsctL668nSo6WNtCa653tP4
	QFB5NgJ20+8DGWW+ZWJtzzUfbWdTIssoddv7pZj1jQgxs0zNIPnN69MbbTWqVn9ibp0F9E3g7Z6jv
	TxYGPoP6P1uya7LkUYwwLwYhoDWGxsUsJqEQDBqbSsAex29QmI0XWGgXnNZvrcz/fs19jbvPQHHCy
	a1H2Lhd67CroVKDXkzlC/rMb/LeOsRzwuTPqs/j3HVaki/cLzcu6lIHJJmatttX+KZrJh2YWwbpY9
	Awc7RFz5dBkv63hBFgC5n7v0c+jw24R9tLz3u18Q5wP3sd9GoM900t/XvLKdC4I354sK5j9qutYnZ
	swFJibHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTYmS-0000000C33i-0QQB;
	Fri, 03 Jan 2025 03:55:24 +0000
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tTYlH-0000000C2tk-341n
	for linux-um@lists.infradead.org;
	Fri, 03 Jan 2025 03:54:13 +0000
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-2163bd70069so65841385ad.0
        for <linux-um@lists.infradead.org>; Thu, 02 Jan 2025 19:54:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1735876451; x=1736481251; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ExtURrdtg4wvz/5S73kPKLfYL+g+cN7JWlBZcDSiUw0=;
        b=B1fqOdhK8IHuMqOIFCeOIkU7l0urKOAAMNoqYQCOqlti8pXiHNEzZdUa02M5M3JXZd
         /G4dvwJKTNmeM78N+W5XLVvCUTkyKzJUCaKNhf2NKzAofb8bvN61EOdN6YXdyDS8Qd4Z
         2Rk+bgQkgzM6rIaI/01npNJcGLKuK3B4MzqwOGbuU5u7SktcgEeDNxCTfuUfccomjA11
         yGGOB5t/zogG3unf55NheSQ8usD813F1SwvR4/xqGe16jowW1IQtfZtCUhTNGebEu3ME
         fLO2qX+nSu+TorzNAIQENiN3yDUbNF/LPA8sYRzfkEliKwMtThRy6nzl3DjNvu9684U7
         KmSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735876451; x=1736481251;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ExtURrdtg4wvz/5S73kPKLfYL+g+cN7JWlBZcDSiUw0=;
        b=EqRHSKtM8S+377BKt30hiJfgdT0gz0Qm0stwn0h3jre9B1uVUDKCx3jIigk+YartNQ
         GULVn6kSMzyX+YL/keqcHA6zIhYzl2fuQmBQKv6DTtMrFXoXEb7E6SKp2eeWneCkww5o
         SNLqAdu7n5iEJfoKNNiF/2WvJPZYBRzbwbxvfxYmn4tSzK/2AobcghRZGaPqN4pycfmZ
         j13Uym5un68eR8zKhUZ4+75pfoyngKCyFB+gplk47DBvJRA+buLHVYJS56gx8k9Ubm1K
         qWkD5lrJ8FThCTM5eZYERUKQ4hResM4572TKb7JwFnrGRfaRLeqCch3Z/7Hu+L3mKqF8
         6JMQ==
X-Forwarded-Encrypted: i=1; AJvYcCXQV/+jqyuXMP1VOg7lmZryGTGO45sS1eoBERUn+Fcn2D7ZRUxZuT+V3aSfcfot9nCEG3JfhETpyw==@lists.infradead.org
X-Gm-Message-State: AOJu0YzN0mgc8ThlrT01cZycJ7wdhe5/kahlM//AxBDMVlDsF1FYFaAv
	CYh6K7BMfy3yiJw7KIDC+vpfMLGXsCXBJE/Aai05t7MU55Xzne2Kmp+GM2h4SeI=
X-Gm-Gg: ASbGncvH/4FdAJreWHSN+1u13w1hjnGeFoW7NYCU39SSvcNh5lig2LWpMfsvuDZLl53
	C9ZwTueWLAeK8kz9EgyxP5wiVSwE5lcH2uSPVcdXKxyHsD9ttINEGkmwU1qhJ9NUt1cxbbt7fTW
	pf+INfNa+AwHPe/dWtSnv8RVt6Sa8c4AC/Ha9MjI6gSSbH5bdBTGCQIIS4w8oXUcazd12jcKLqf
	PHOe9IsGewLQNXcJ9p82KC1RCDU8NuvYiHsqrrMYaYfeWPq5w/DlmnFs/XveRlKWsZCq9AwAMDK
	MjVCng==
X-Google-Smtp-Source: AGHT+IGRLBberTsNPcVz5fDDiJ496OTTAGvxwwTdPWwuUiji7gMKzctc+wxIQ/Y0LkCE8MhlfHWUlw==
X-Received: by 2002:a05:6a21:6d86:b0:1e0:ae58:2945 with SMTP id adf61e73a8af0-1e5e081179bmr90059001637.31.1735876450877;
        Thu, 02 Jan 2025 19:54:10 -0800 (PST)
Received: from [10.84.148.23] ([203.208.167.148])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad8fba98sm25284573b3a.161.2025.01.02.19.53.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jan 2025 19:54:10 -0800 (PST)
Message-ID: <77c202bf-e0a3-45e7-bf8d-eef7903e3c64@bytedance.com>
Date: Fri, 3 Jan 2025 11:53:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 04/15] mm: pgtable: add statistics for P4D level page
 table
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
 <2fa644e37ab917292f5c342e40fa805aa91afbbd.1735549103.git.zhengqi.arch@bytedance.com>
 <237a3bf6-c24f-4feb-8d3d-bb3beb2fd18e@arm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <237a3bf6-c24f-4feb-8d3d-bb3beb2fd18e@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250102_195411_764448_37D8B6B4 
X-CRM114-Status: UNSURE (   8.71  )
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



On 2025/1/3 00:53, Kevin Brodsky wrote:
> On 30/12/2024 10:07, Qi Zheng wrote:
>> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
>> index 551d614d3369c..3466fbe2e508d 100644
>> --- a/arch/riscv/include/asm/pgalloc.h
>> +++ b/arch/riscv/include/asm/pgalloc.h
>> @@ -108,8 +108,12 @@ static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>>   static inline void __p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>>   				  unsigned long addr)
>>   {
>> -	if (pgtable_l5_enabled)
>> +	if (pgtable_l5_enabled) {
>> +		struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
>> +
>> +		pagetable_p4d_dtor(ptdesc);
>>   		riscv_tlb_remove_ptdesc(tlb, virt_to_ptdesc(p4d));
> 
> Nit: could use the new ptdesc variable here instead of calling
> virt_to_ptdesc().

Right, but we will remove pagetable_p4d_dtor() in patch #10, so this
may not matter.

Thanks!

> 
> - Kevin

