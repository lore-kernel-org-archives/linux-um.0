Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 602CBE77188
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 14:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=; b=gVP4QjIuHbCp7d1DbpiI/m1xPl
	PVHQOiwRznARtrQBE6B9TeSrjozGwROcR6Oq8R5PWV7qLzfcae/jdYtm5PFqGSTxmUglDI5KE1Dq7
	1+rpNWjXb8cWhnpK0YW0JbWYgIEB2zsldlsNADeopTe0KJLAnFsOClQYV4YNcgdfIvXJEq3UXk0tm
	wAnHj8m2+wyhTzLrctpk8cWy0DykN3l5VddAr1uN9z8rdrahcPmkJxtZBFZIlXX6zi6mEqVA/6f+w
	8p/9voPiJDqvxCOEi/Ow3BXIuVS5S7hoMuOC36N4Ec2gLGWZB79GhvTnt9WkM8g9VQzkF9lw0trJE
	Cb2RdXwg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoWZ-00000001gOK-0FLW;
	Mon, 06 Jan 2025 14:56:11 +0000
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoLN-00000001cYS-0p3D
	for linux-um@lists.infradead.org;
	Mon, 06 Jan 2025 14:44:39 +0000
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-216634dd574so137625675ad.2
        for <linux-um@lists.infradead.org>; Mon, 06 Jan 2025 06:44:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736174674; x=1736779474; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=;
        b=Rlh/9xjXK2Dii6eJOv0At1o6MrcJZXqiaC9rM2aMSgJGN7m4N8/5IH4Ud1EfeH4E6R
         4LYJ75YJorOPgje+DQmHp9fvPPuMtHwTAK4wEO/jlGQ/RN8XXxS+NAB/juRwE0Dcwmgv
         7aztfE3DfKksNPIsYOB7cHQZGOuGjjPKhUVQ/yX5aqEP4x8iTE91YcQFTDy52jKBMnZc
         uAL0b/PK+GjB5KFeg65TfGBlT79bWSJtwIVOdETTmbEhqscVcyNGg6xIyWC2tGdJ6Nxb
         1/02sOVxL47qeg9T4H81kHDesMsGOKBVoc5SnOOQSndv/O3RHpR/6MDdGIhv2gwqWx6p
         k4HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736174674; x=1736779474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=NViglkR77PlL2AqsFJ9M2rA8vsy0VBtzEibmSHACi+I=;
        b=Keth9aZeJO2EX1YF9Pngh77h4nvEAKQ8xn3H1Xrygii52zIimSNusGjsktDBM4BYvv
         Zno1uRYLrsDbz3eywzZXBpO8qwd5VB8vDX7VygWaAVvzmUJAdDmcpKeEOfa9RAyjal/J
         Qeuj6Oi65a/hawTq5XeCtCPsZY9UM2yl2oBE+PXJHkxUtfE573rtRNblrPcUtRiB9NdB
         nSsz6PadSzv5CHVa3ZtlWv7EP296QD6axbCwk8UWWfF9dcFXnyAoVAqNTM9M1QfVkIZf
         73V0+5lOf2FjlJXMOXe0PADGFoZUkb9jCzhm0Vo2obDTkca/PseuESkWlKU2qTdP92/r
         PHrQ==
X-Forwarded-Encrypted: i=1; AJvYcCXo1u4h2z1biUThKvjRPI1YRvYuvjKeuCFesb4r4Mhj6YrL9grhgr5ZIbWBBLgY0LtDYkeZatnatA==@lists.infradead.org
X-Gm-Message-State: AOJu0YyhT1/lB1x5gyBbDLZusTzzTKVCimJBkkorpafZi2oL2EdjCC50
	NG+JDFkrZPRkxSxR33Isa3qSmYvYslpzDf3ZZlAdHvz1TBu6v8r5/m55ZgA+bhU=
X-Gm-Gg: ASbGncto9rMzqWoA3hNdfPgdFoh7Xl5/RYD/e8ZTlHR8mbNQtout/I3++L5Z+igmi7F
	FR3+gVuMkxOcBNKYjrZ2DE+mQNwsi1jGsPOnDFd02ste82PF4eSEY/BZT2FCkkJAexj6Ozq69vn
	82uhiCsWC7UqQKwQdJjpC7UzZWdsf34P5PFkWgNeQxGqpMhDrWNNc8JX2vO41BPNAfiR+cqiUdY
	3VTwGJZmo3IF2B0gLFSEB9gHagsoKrdjku56+FQpyDpZ413v1kYz57UtEKAkpL66hEZpLctF3/2
	FCcT8qEwvAkF4u8eo2xua7wXXpOE8EYOd93VWH+gcMuNj+Fn21sh
X-Google-Smtp-Source: AGHT+IHfRKlSBRBXUw7mHIW0SQFNESOEWbBrtQcBXd7/ffhetsdlBCZHRjeTrMJdIBfoDiMG7l+wRg==
X-Received: by 2002:a05:6a00:ac3:b0:726:f7c9:7b1e with SMTP id d2e1a72fcca58-72abddcadd6mr82367083b3a.13.1736174674262;
        Mon, 06 Jan 2025 06:44:34 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-72aad815804sm31532588b3a.32.2025.01.06.06.44.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 06:44:33 -0800 (PST)
Message-ID: <dbcbf4c3-f86a-4414-be52-8ac02dae5b6b@bytedance.com>
Date: Mon, 6 Jan 2025 22:44:21 +0800
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
 <57ea8193-2fd9-41a9-85b4-7af924f900f4@bytedance.com>
 <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vqHXdwIMBVQ2GT@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_064437_226969_FA8EC8E1 
X-CRM114-Status: UNSURE (   9.97  )
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



On 2025/1/6 22:35, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 09:34:55PM +0800, Qi Zheng wrote:
>> OK, will change the subject and description to:
>>
>> s390: pgtable: also move pagetable_dtor() of PxD to pagetable_dtor_free()
>>
>> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
>> PMD|PUD|P4D to pagetable_dtor_free().
>>
>> But pagetable_dtor_free() is newly introduced in this patch, should it
>> be changed to 'move ... to pagetable_pte_dtor_free()'? But this seems
>> strange. :(
> 
> s390: pgtable: consolidate PxD and PTE TLB free paths
> 
> Call pagetable_dtor() for PMD|PUD|P4D tables just before ptdesc is
> freed - same as it is done for PTE tables. That allows consolidating
> TLB free paths for all table types.
> 
> Makes sense?

Ah, make sense. Many thanks to you!

Will do it in v5.

> 
>> Thanks!
> 
> Thank you!

