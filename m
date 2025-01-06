Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69868E77198
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 13:35:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dSl9CiTNSQwE0RKlCdBtogvBaV/TE9/iFGVUzDM7I3Y=; b=o7xrkY3NQqKZl8QQPx/cK8SLxL
	Dn2dQV6sOaLEKeAOLkdytn3XuTV1PjavctjCGvatVEqRABW/yEFUFj82n1Q3Pe0uTiECIkebXd2zE
	vD2LXF1x72cz2Vhdm8be7MJr7792MYqxzgnfSC6tanhrsQsBqpbj7psUMelXk4QObdJFZkOegd3ZF
	LEvp9m9FdKC2fkCbVdy3la8lVmXHB5dd3iI4IUTygrS9eX4zpbBz+BD5KiHXXplu8J8MRJZPTOkJS
	mNmxNduT57usmTT0M8ZTZ3iilQsrk3M8AZOIBqZ1gTrS96shkSaqywHPKiPzdXzcIQZbvPFt35NUL
	q4nbctKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUnGC-00000001PkY-0U1C;
	Mon, 06 Jan 2025 13:35:12 +0000
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUnG9-00000001PiM-1CuM
	for linux-um@lists.infradead.org;
	Mon, 06 Jan 2025 13:35:10 +0000
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2163bd70069so17232685ad.0
        for <linux-um@lists.infradead.org>; Mon, 06 Jan 2025 05:35:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736170508; x=1736775308; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dSl9CiTNSQwE0RKlCdBtogvBaV/TE9/iFGVUzDM7I3Y=;
        b=DbiWHcLFu7mfIIUeiVlA4yR/TdcYuRsQuz9jrGap7NAlptEzyQ5uxUQVxstlGSJ6N2
         YXEeSFhOLjxTzCnIZpv5bxEooFaiPQhcGAiorCDNJmGrk9kIkzKKefdGj+NyJnZqj//p
         EidtfFGyXkhrtzG0c04I23fayfoTLqvHOwWlt4emkiyn/Fsi+aji1SUTxBiIy19eXDGP
         2Q555qAXuQJN6fZj77/hSxgpPOK4h5zMK168D1XnoZ5OFxjdLBcMnUpRvuh5BHSi8yYR
         taTDuOIPGU0rtbqzDKrREnXLEbNT6Sw/1/LbTdvY2kn255NioCT9Z/WEdfZS2SD23kZd
         G2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170508; x=1736775308;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dSl9CiTNSQwE0RKlCdBtogvBaV/TE9/iFGVUzDM7I3Y=;
        b=ufwGaDRT6jk0K0EvCfpo/4gtiDgHS+O75loZBa6UPN/C3snmVjuBAs8k1IbA/oGxJM
         abRLJRtHOXANoItTAvZen5x3TRNVEPkb1Sq/JkQYUC1yX5P/mcBP5zRqe5srVRwi3gR2
         r+ATaUB9bKv0gk5HLo/S9yS3eytgJRxcf6kfOgLlvbH6DthRTThtgNDfWZsepLPqT6CH
         qVcmBb2Qo4XWjHVfUA35JyefHCRMtB/2/6fi3NK/rq69taqUsh43zjfTISgTxDc0VuqN
         t2AFGnCf7RdRUfGnp0vjcOKKcYnHBAKVP4PNCi0/mP9EgCzj8d6vUUMzOe3thX1c8dE4
         WY9g==
X-Forwarded-Encrypted: i=1; AJvYcCWCdGqAfVTqUTy/pRWZXGHd0V1QjuXBJZTSxot0sO8h2YVMkzmsb4rI87j/owTRlHfv9EehpM598g==@lists.infradead.org
X-Gm-Message-State: AOJu0YxJHCAg7hyoqN18QiM0dQOKpOFRPhqZnpHT7bhuax+dIpIyF20t
	ofkF/k+1XZ/g0KtatOuFh21PG+qh4nfLAneA7lYNuxJvoy+yfOVoYBx3UZARSa4=
X-Gm-Gg: ASbGncuTwI+/iWCMl+kG8QVfgg09GW6MAgTY1QyhbdliOtEWpIYRJsAJcfXBsP7nXNw
	2JDsr4Ah2W0bISAJagbdxphrq0XvWPxlNgx+UtT45QrHzEXDP3JXnMyWYki0ueMxY4J/49G3MHH
	HkYwoIJJ4HIR4Z1UK9SjXKsVcV+agysc6xXsiP5K5KcUR/+uncuU9feg5gUN8QygC5BfSSch90n
	fRJ8+tp2a4utwYy7uSN5DnSf6GiLTybOSYO3iQH+ipo6+oS8NvGvzqKTt50PLnxA7nbIOBJLDea
	zXvzl86aOE4UZCNRrPysdYUXsp2DM2WYHnvP3W3aSKojBnufCp+w
X-Google-Smtp-Source: AGHT+IFuxfmftFbdw6fO4bIMnZYJ/q+si7Sq93AxF4PGQarIeYtLJTB7gRBGy3tWc8bUzZwj1LueBQ==
X-Received: by 2002:a17:902:e844:b0:216:3083:d03d with SMTP id d9443c01a7336-219e6f13c50mr852868805ad.44.1736170508636;
        Mon, 06 Jan 2025 05:35:08 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9cdf02sm292469725ad.151.2025.01.06.05.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:35:08 -0800 (PST)
Message-ID: <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
Date: Mon, 6 Jan 2025 21:34:55 +0800
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
 <2d16f0fe-9c7f-4229-b7b5-ffa3ab1b1143@bytedance.com>
 <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vQHplZqtHf6Td8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_053509_349690_A13E5F9A 
X-CRM114-Status: GOOD (  13.11  )
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



On 2025/1/6 20:44, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 07:02:17PM +0800, Qi Zheng wrote:
>>> On Mon, Dec 30, 2024 at 05:07:47PM +0800, Qi Zheng wrote:
>>>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>>>> PMD|PUD|P4D to __tlb_remove_table().
>>>
>>> The above and Subject are still incorrect: pagetable_dtor() is
>>> called from pagetable_dtor_free(), not from __tlb_remove_table().
>>
>> Hmm, __tlb_remove_table() calls pagetable_dtor_free(), so moving to
>> pagetable_dtor_free() means moving to __tlb_remove_table(). Right?
> 
> Right. But you Subject and description claim "... also move the
> pagetable_dtor()" not to pagetable_dtor_free() - which is another
> function.

OK, will change the subject and description to:

s390: pgtable: also move pagetable_dtor() of PxD to pagetable_dtor_free()

To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
PMD|PUD|P4D to pagetable_dtor_free().

But pagetable_dtor_free() is newly introduced in this patch, should it
be changed to 'move ... to pagetable_pte_dtor_free()'? But this seems
strange. :(

> 
>> And the main purpose of this patch is also to move pagetable_dtor()
>> to __tlb_remove_table(). So I think this description makes sense?
> 
> The patch makes sense, but the description it is incorrect ;)
> 
> Thanks!

Thanks!

