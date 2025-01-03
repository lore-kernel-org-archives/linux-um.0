Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22F0CE77198
	for <linux-um@archiver.kernel.org>; Fri,  3 Jan 2025 09:30:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SqHwiMnjtBXaTnPPiHapkhzS+5DI8VRKfH/MexUMjA0=; b=bhUBBeBA9/h8P9n5i0uL55cmey
	Xr0xItXNSXQ1x5IAluna9wWXylJQPn4Uq3UiomsgeEKb2MXlkddvlIIuYuNyLJDSLG3g/jwF7dzu6
	kSeOCpkAymxIEJmHES6v/L8DeEgC5BIpoNBPwhOSvmyiHBZ3UfIesoAZm005pVQTM/po/3zJzOUJu
	j3IloOIkzhESgrydlL3RhznAx5JHIjho/FPOz8uSACpFQqzqYFE8d8SVWHHFyYxmqa1q0k+9x4Dr5
	bW4LYbXBnEgPkby2Ms0dFBwSWb6uB/1trzz0dfuEk2++MRbMrcahj7ctXBDZ1/200PiOJxzNUslP3
	oxRy8CnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTe0m-0000000CcLk-3GYW;
	Fri, 03 Jan 2025 09:30:32 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tTdz3-0000000CbzE-0XWf;
	Fri, 03 Jan 2025 09:28:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3C0AF1480;
	Fri,  3 Jan 2025 01:29:12 -0800 (PST)
Received: from [10.57.92.237] (unknown [10.57.92.237])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8B153F673;
	Fri,  3 Jan 2025 01:28:35 -0800 (PST)
Message-ID: <80cf6cae-11f6-4db2-816b-b1dcca3cee3e@arm.com>
Date: Fri, 3 Jan 2025 10:28:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 00/10] Account page tables at all levels
To: Dave Hansen <dave.hansen@intel.com>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Linus Walleij <linus.walleij@linaro.org>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, "Mike Rapoport (IBM)"
 <rppt@kernel.org>, Ryan Roberts <ryan.roberts@arm.com>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
 Matthew Wilcox <willy@infradead.org>, linux-alpha@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-um@lists.infradead.org, loongarch@lists.linux.dev, x86@kernel.org,
 Joerg Roedel <jroedel@suse.de>
References: <20241219164425.2277022-1-kevin.brodsky@arm.com>
 <a7398426-56d1-40b4-a1c9-40ae8c8a4b4b@intel.com>
 <765aec36-55a4-4161-bb30-4ff838bc2d98@arm.com>
 <989b55cf-1f9e-4b73-b3dd-d8b6a62be3f2@intel.com>
Content-Language: en-GB
From: Kevin Brodsky <kevin.brodsky@arm.com>
In-Reply-To: <989b55cf-1f9e-4b73-b3dd-d8b6a62be3f2@intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250103_012845_280706_8E95504E 
X-CRM114-Status: GOOD (  18.08  )
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

On 20/12/2024 20:31, Dave Hansen wrote:
> On 12/20/24 02:58, Kevin Brodsky wrote:
>>> One super tiny nit is that the PAE pgd _can_ be allocated using
>>> __get_free_pages(). It was originally there for Xen, but I think it's
>>> being used for PTI only at this point and the comments are wrong-ish.
>>>
>>> I kinda think we should just get rid of the 32-bit kmem_cache entirely.
>> That would certainly simplify things on the x86 side! I'm not at all
>> familiar with that code though, would you be happy with providing a
>> patch? I could add it to this series if that's convenient.
> I hacked this together yesterday:
>
>> https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=simplify-pae-20241220
> It definitely needs some more work. I'm particularly still puzzling
> about why SHARED_KERNEL_PMD is used both as a trigger for 32b vs.
> PAGE_SIZE PAE pgd allocations _and_ for the actual PMD sharing.
>
> Xen definitely needed the whole page behavior but I'm not sure why PTI did.
>
> Either way, that series should make the PAE PGDs a _bit_ less weird at
> the cost of an extra ~2 pages per process for folks who are running
> 32-bit PAE kernels with PTI disabled.
>
> But I think the diffstat is worth it:
>
>  5 files changed, 16 insertions(+), 96 deletions(-)

That does look like a nice simplification! After the first patch, with
my series, we could get rid of _pgd_alloc() and _pgd_free() in
arch/x86/mm/pgtable.c and just call __pgd_alloc() and __pgd_free() directly.

Considering that these changes are not trivial and may need more work,
should I let you post those patches as a separate series? If it gets
merged soon, I'll adapt my series, otherwise I can post a follow-up
patch later if needed.

- Kevin

