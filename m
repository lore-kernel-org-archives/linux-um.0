Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C58DCE77188
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 14:51:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=45XLTheYrSs123jVGiTYWA09gh8PmFWTSz2LniJsnL8=; b=WxtQW/2pfXKt5nvssyiBxWWGzg
	0ICoRGtCywRuip4xpqNUV0bIy/oE9buWPSVpNg3yix7Jc3vkYSl7xQaQkZTY3++6rk00k6uGR41yh
	UaRv+pRtR1TaeVNxvoE0LIVL3ap+gNjZ3raG4cW0EJsnu0Mg6YKjChOuXA46gG5BR9Qt2rqe5Hwba
	lSwj0LtuOlhQGdjZTQlpQyX34PO1e3aTb3S8xaAeverYJK5we3DDnkIwubAOEYQVYE8f/Hd9gqEsG
	kGyH4DwNrgrRlLPjPr6OcejvuMgrFp+rSI0GQtIbr1Tbzz/pDJPkmYnLJPB/VDJbRiySoK/pT1pPB
	wEyjBqcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUoSM-00000001eYt-2Nv7;
	Mon, 06 Jan 2025 14:51:50 +0000
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUnIk-00000001QJ6-3VZf
	for linux-um@lists.infradead.org;
	Mon, 06 Jan 2025 13:37:53 +0000
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-2163bd70069so17268045ad.0
        for <linux-um@lists.infradead.org>; Mon, 06 Jan 2025 05:37:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1736170670; x=1736775470; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=45XLTheYrSs123jVGiTYWA09gh8PmFWTSz2LniJsnL8=;
        b=J2yEbYLh3x+MWH2BoyOolq7FkMjNKX2NNjKR70KK+uYu835ibBlxWLU6pQ7dJyNX5J
         XVx4WqZXPBXYIHOMoLJ88c85fDyXSEhm3nM598hOwawOUhUnzEXnwnTHE2jfZ74EXvYP
         v6T4DIURq33d1tfanDdGhaJWxZJDVDEMy7t3IET7vM9eI6usCDCi5H+wgMxWA3AzW27f
         cL8s8vFLmq7lFmS4G3ih4hUVZn2bd5xN4Nymauv4wWMlGEFMMXlc97IVXeJlrozELsja
         y31zp5E72zA9ivfTMlQnVkE1oUMXpE1slPXLAdG+Kw7vjYElB8fol00/u+Zuzn46ZPTN
         yHVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736170670; x=1736775470;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=45XLTheYrSs123jVGiTYWA09gh8PmFWTSz2LniJsnL8=;
        b=RA/orZ6Toj7ro5hHFiRdVMOLkz8IiCXPDaTD1MId6JfeOyIjLZXLXN7zuliEtK8Z6V
         6eaXImMOQCSvNJTm9gRB49JtAtptK94IKClwHi+m7kMk3wX9V8PGX7KwjjAyiU4BFdfS
         gz9KqvrmBINH+zys+BvB19WLWuexMJZSF3NzkBILclJ524gI9R2cZszLL67+WVHwIyVX
         OhHflm9ssF9o5jj9Lcif3gO/V7tm3zaLDESqmW5q1AhVsjfL0bY81rynRuY9qgPtdBvz
         uQf2wmTkWyg1ZvqhA9VOf3UT27rp3bSOzHUmrS0gWlK5TTEXjs4FdOFpYLrvqTZXZsaR
         vwnw==
X-Forwarded-Encrypted: i=1; AJvYcCVkCYmnX1uSUA2EbTXeu143pK2lKP7swK5ovhx6kyq38jasyjOOM+gVY0mqhmi748an9L/2Y8brTg==@lists.infradead.org
X-Gm-Message-State: AOJu0YyCvulKIQ6ZbexUEhwyqu1iTvrxaoWLDPES/QtGuDWEbzgfKAQ+
	JInRg58ZxaP38+1+rkcPCjV4R9lk8wmmgXanzyTtxe1jI3mmINC60Rrp31hr5us=
X-Gm-Gg: ASbGncu857xLqAZHul+gUOjGoDWQWmoPnslDOIdxLvs95elUEbFeLYwfnN6tHmXqbBx
	vT3NuqFtyNMimJfzxjR72gh/ihJS3mJpgy/+UGVvP+Xka4Otak9aYmW8NBFa8XyvDRuTErxOpei
	E858gcZ1FTgFyIOMY61YBz7nK6M3aj6kaOIg8DB+/A84NWDEbolFWRmB8PPmZy3N1Rrgvpsh5zg
	SRf4GzJo2pkDQOLJySjjqbdcEy+0CUO8tQgv1HAhO7eSe+kaFAGt6bU9po/cLlypB+h0slr2j6Z
	DderVgLzD7hCdjkb5gixvG7qxKRuDejZTWrcizkzDAhEv9z0MzXJ
X-Google-Smtp-Source: AGHT+IFnWXSZW4FIIFkfBRxwzvmAw3s/HsdTqMia2pBdvLu70V6jfgNFfu5B3ABCLJ+ulhyhNt7Jxw==
X-Received: by 2002:a17:902:c406:b0:216:2bd7:1c4a with SMTP id d9443c01a7336-219e6ebb716mr865705425ad.26.1736170668665;
        Mon, 06 Jan 2025 05:37:48 -0800 (PST)
Received: from ?IPV6:2409:8a28:f44:d64:296c:a8f3:f81e:f88b? ([2409:8a28:f44:d64:296c:a8f3:f81e:f88b])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc9f51a0sm290583325ad.187.2025.01.06.05.37.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Jan 2025 05:37:48 -0800 (PST)
Message-ID: <760c9610-a11b-4bc2-852e-340adb27f666@bytedance.com>
Date: Mon, 6 Jan 2025 21:37:36 +0800
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
 <a3a2bd64-9952-4c66-8626-f2436ce07d1d@bytedance.com>
 <Z3vb+0MktvDNysQD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
From: Qi Zheng <zhengqi.arch@bytedance.com>
In-Reply-To: <Z3vb+0MktvDNysQD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_053750_919240_7783F930 
X-CRM114-Status: UNSURE (   9.82  )
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



On 2025/1/6 21:34, Alexander Gordeev wrote:
> On Mon, Jan 06, 2025 at 07:05:16PM +0800, Qi Zheng wrote:
>>> I understand that you want to sort p.._free_tlb() routines, but please
>>
>> Yes, I thought it was a minor change, so I just did it.
>>
>>> do not move the code around or make a separate follow-up patch.
>>
>> Well, if you have a strong opinion about this, I can send an updated
>> patch.
> 
> If you ever send v5, then please update this patch.

OK, will do.

> 
>> Thanks!
> 
> Thank you!

