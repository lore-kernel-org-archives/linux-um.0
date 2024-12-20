Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CBB2DE7718C
	for <linux-um@archiver.kernel.org>; Fri, 20 Dec 2024 14:29:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NoZP/C74YL+gAOuTVINVRjr/kSwdZlwelqBG4tRegrQ=; b=DJF7n0ymyYWRqPXMvdjqLJdnwA
	eQDuT0/w0Jg0BOA/6v5MNNwIGFwcsFdBiyXE40UH6eGjF+CeTdiBAOvFbBzrEKkyCv5JS39C2Yfi2
	w0opMnw5suK/ZxNJ+u0NpEqBGikqKn+hEa310Sa2GZhc0tGCf47YOnqbiN3g53uDeG+2jUR5Ss/Ej
	jsBddvSV/8RlWYX4mT1O3g1vTOtvpy1cPpuLSFE6ERHVbVsuSHEI3UFHAYVgqOYVpStC1SHE0OBEJ
	iBGz08gJBRcvsHntF2WuwttgVNFawm85xEoLmGg7J5joXdz7DKNFWTg5L4BozDnov6Gd7e8eP2M8a
	D+pDohwQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOe0s-000000058uC-0dYK;
	Fri, 20 Dec 2024 14:29:58 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tOdzh-000000058nO-0Rio;
	Fri, 20 Dec 2024 14:28:46 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 59F5F1480;
	Fri, 20 Dec 2024 06:29:12 -0800 (PST)
Received: from [10.57.72.191] (unknown [10.57.72.191])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6FAEB3F720;
	Fri, 20 Dec 2024 06:28:38 -0800 (PST)
Message-ID: <7f5e6ac7-01ef-46c8-bc85-7f8399dadb19@arm.com>
Date: Fri, 20 Dec 2024 15:28:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/10] mm: Move common parts of pagetable_*_[cd]tor to
 helpers
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 "Mike Rapoport (IBM)" <rppt@kernel.org>, Ryan Roberts
 <ryan.roberts@arm.com>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, Matthew Wilcox <willy@infradead.org>,
 linux-alpha@vger.kernel.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
 loongarch@lists.linux.dev, x86@kernel.org,
 Alexander Gordeev <agordeev@linux.ibm.com>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <20241219164425.2277022-2-kevin.brodsky@arm.com>
 <20241219171920.GB26279@noisy.programming.kicks-ass.net>
 <75cb4ff8-eb0c-4519-a30a-f8be717ba278@arm.com>
 <0daabd32-cba4-4345-baa8-e8c66bc899ff@bytedance.com>
 <2f65f93e-9d44-4acc-b63c-8f5a35f59699@arm.com>
 <33ce9b58-4787-49cd-a7f2-34272cb3ecf7@bytedance.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <33ce9b58-4787-49cd-a7f2-34272cb3ecf7@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241220_062845_193521_4E004201 
X-CRM114-Status: GOOD (  16.76  )
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

On 20/12/2024 15:16, Qi Zheng wrote:
>>>
>>> Did I miss something?
>>>
>>> My patch series is not only for cleanup, but also for fixes of
>>> UAF issue [1], so is it possible to rebase your patch series onto
>>> mine? I can post v3 ASAP.
>>
>> I see, yours should be merged first then. The issue is that yours would
>> depend on some of the patches in mine, not the other way round.
>>
>> My suggestion would then be for you to take patch 5, 6 and 7 from my
>> series, as they match Alexander's suggestions (and patch 5 is I think a
>> useful simplification), and replace patch 2 in your series with those. I
>> would then rebase my series on top and adapt it accordingly. Does that
>> sound reasonable?
>
> Sounds good. But maybe just patch 5 and 6. Because I actually did
> the work of your patch 7 in my patch 2 and 4.

Yes that's fair! You'd have to do adapt my patch 7 to make it fit in
your series so I agree it makes more sense this way.

>
> So, is it okay to do something like the following?
>
> 1. I separate the ctor()/dtor() part from my patch 2, and then replace
>    the rest with your patch 6.
> 2. take your patch 5 form your series

Sounds good to me!

IIUC Dave Hansen gave his Acked-by for the x86 part of patch 6 [1],
would make sense to add it when you post your v3.

>
> If it's ok, I will post the v3 next Monday. ;)

Perfect. I'm going offline tonight, when I come back in the new year
I'll review your v3 series and post a new version of this one.

Cheers,
- Kevin

[1]
https://lore.kernel.org/linux-mm/a7398426-56d1-40b4-a1c9-40ae8c8a4b4b@intel.com/

