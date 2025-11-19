Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C84FCF3185
	for <linux-um@archiver.kernel.org>; Wed, 19 Nov 2025 10:38:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2TBsWCikXGWQPUUHsPA7sycMNKDe7zouYf7GZ8q6JeI=; b=vMvhqdYCiKSbFRIcOf0IaWDTR9
	+y/vZq9VvXy9RQW1ynmZ3QA+pP9GTvATy5qFRUqCM/lICEr6tBKYqW38pU38Wa138IZOnMDF4tnr9
	K8mB75Cu5h1cs0K81WaucWsvQBDe4Uw+OtdqtFVURZx4qoc/Aqd9WuNYlXiEjGX22LDTB/SSBXObR
	4Ly4KnRcN/kmYVLKrLY1g1s6BmXK+XFXZmQ4711EkTHOqbLLeKO4390peq87BsHtb1uOW8K6KND12
	S3mxyoyoej+sDHtJwjj0v8Utyr8f9GxJ+f5PKCTcWdKbaANkUCaiFyq1/0bobw5mxWovcDukeT/VA
	IrvczyWw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfZl-00000002ybb-1AJp;
	Wed, 19 Nov 2025 10:38:13 +0000
Received: from out-186.mta0.migadu.com ([91.218.175.186])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vLfZi-00000002yae-03HD
	for linux-um@lists.infradead.org;
	Wed, 19 Nov 2025 10:38:11 +0000
Message-ID: <9c884aeb-c1ec-4fe0-8495-639344633569@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1763548677;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2TBsWCikXGWQPUUHsPA7sycMNKDe7zouYf7GZ8q6JeI=;
	b=WlmCPbWnPdAaCcans4XB+sX3p9j7swCRg/bKjIgLcOdwHQGNX8Ly6s46NtS/bk1YRUX5nD
	P/USmoX3HrHHdMyNu4n5ttfSh4oinQ+knKhggVYN1S4ezwiWm1UMI+WsjcrjIT6sAYxVwY
	YCuykmmow7b6GErFp6rT+UF5iCgIJi0=
Date: Wed, 19 Nov 2025 18:37:47 +0800
MIME-Version: 1.0
Subject: Re: [PATCH 0/7] enable PT_RECLAIM on all 64-bit architectures
To: "David Hildenbrand (Red Hat)" <david@kernel.org>, will@kernel.org,
 aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org,
 dev.jain@arm.com, akpm@linux-foundation.org, ioworker0@gmail.com
Cc: linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, loongarch@lists.linux.dev,
 linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-um@lists.infradead.org, Qi Zheng <zhengqi.arch@bytedance.com>
References: <cover.1763117269.git.zhengqi.arch@bytedance.com>
 <83e88171-54cb-4112-a344-f6a7d7f13784@kernel.org>
 <f7f0ca8d-bca2-4a3e-8c45-85cba1b0ff18@gmail.com>
 <afecde77-a4af-40f1-a905-9de8a1bdd783@kernel.org>
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Qi Zheng <qi.zheng@linux.dev>
In-Reply-To: <afecde77-a4af-40f1-a905-9de8a1bdd783@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251119_023810_226565_BD64BE9E 
X-CRM114-Status: UNSURE (   9.11  )
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



On 11/19/25 6:13 PM, David Hildenbrand (Red Hat) wrote:
> On 18.11.25 12:53, Qi Zheng wrote:
>>
>>
>> On 11/18/25 12:53 AM, David Hildenbrand (Red Hat) wrote:
>>> On 14.11.25 12:11, Qi Zheng wrote:
>>>> From: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>
>>>> Hi all,
>>>>
>>>> This series aims to enable PT_RECLAIM on all 64-bit architectures.
>>>>
>>>> On a 64-bit system, madvise(MADV_DONTNEED) may cause a large number of
>>>> empty PTE
>>>> page table pages (such as 100GB+). To resolve this problem, we need to
>>>> enable
>>>> PT_RECLAIM, which depends on MMU_GATHER_RCU_TABLE_FREE.
>>>>
>>>
>>> Makes sense!
>>>
>>>> Therefore, this series first enables MMU_GATHER_RCU_TABLE_FREE on all
>>>> 64-bit
>>>> architectures, and finally makes PT_RECLAIM depend on
>>>> MMU_GATHER_RCU_TABLE_FREE
>>>> && 64BIT. This way, PT_RECLAIM can be enabled by default on all 64-bit
>>>> architectures.
>>>
>>> Could we then even go ahead and stop making PT_RECLAIM user-selectable?
>>
>> OK, will change to:
> 
> Was more of a question: is there any scenario where we ran so far into 
> issues with it?

No, I haven't received any reports of related issues, either within the
company or in the community.

> 


