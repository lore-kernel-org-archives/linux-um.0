Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FB32C5AE49
	for <linux-um@archiver.kernel.org>; Mon, 10 Aug 2026 14:08:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l/l2H3T3xXRxtAlEmVxkMBjt3GQq1sSw4qqDUaZjjxc=; b=DqqqIv3KCIMqwumeoSutoMlmkJ
	ebDyZLjB20JGx3qOn6vvsR7RxDF6UwnesWE2naZQREfCwgYrW5j79DygIZzfuiSYJLMp7BGjNaa90
	AT3qyBHbWHbVp2sMZ0ikWXzBGdGP4TKdHeT39AiF2ZTBUEUuMtxy0HaXnxzHLgqdhTBVURv/ZAil0
	R+UekFz3c992PCX2oOYQrynGQynpSSFZTpABb7sWzXpwoZ4l4Cs8tX2ZEzl6fx6CVEJ9B0XdWbcCR
	SxVd90YBAJ+Wa+tkc68ramZQQO36CwliYX2RrAK90gmvH62kbQ5U9VzMOt5krYG+uzY96AbMkOZ+H
	ORpxH9fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQfa-0000000BxQr-1UqT;
	Mon, 10 Aug 2026 14:08:02 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQfX-0000000BxQI-0b84;
	Mon, 10 Aug 2026 14:08:00 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 737BD14BF;
	Mon, 10 Aug 2026 07:07:50 -0700 (PDT)
Received: from [10.57.5.211] (unknown [10.57.5.211])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A0B0D3F86F;
	Mon, 10 Aug 2026 07:07:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786370874; bh=l/l2H3T3xXRxtAlEmVxkMBjt3GQq1sSw4qqDUaZjjxc=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=VDMFqS+FI7dztumWUIj0YSzO03RhoFJUBQIQzYUdFvqVl9cEv8Iw/mDKNo7PN1C6X
	 1VHMihPE5KmCMT17k5n8XBwRp9N9Pbg9cGBMMV/3LzWSgApFGs1tQxNrK6u2zmk9z2
	 n2fKbvDMQjaTvkmApv2yhkGVWehw0StqDsKzTy6c=
Message-ID: <efd52893-bf66-40cc-a53d-980b89cee448@arm.com>
Date: Mon, 10 Aug 2026 16:07:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for
 init_mm
To: "David Hildenbrand (Arm)" <david@kernel.org>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 Lorenzo Stoakes <ljs@kernel.org>, "Liam R. Howlett" <liam@infradead.org>,
 Vlastimil Babka <vbabka@kernel.org>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Pasha Tatashin <pasha.tatashin@soleen.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org,
 Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, linux-riscv@lists.infradead.org,
 Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>, linux-s390@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>,
 Andreas Larsson <andreas@gaisler.com>, sparclinux@vger.kernel.org,
 Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Ning Sun <ning.sun@intel.com>,
 x86@kernel.org, tboot-devel@lists.sourceforge.net,
 Ard Biesheuvel <ardb@kernel.org>,
 Ilias Apalodimas <ilias.apalodimas@linaro.org>, linux-efi@vger.kernel.org,
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
 <01f07ea2-8bdd-4450-8a49-548f8b646cfd@kernel.org>
 <33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <33fc9d31-2866-4315-9510-0004deb93994@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_070759_281854_77F45A61 
X-CRM114-Status: GOOD (  15.21  )
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

On 05/08/2026 14:07, David Hildenbrand (Arm) wrote:
> On 8/3/26 15:59, Christophe Leroy (CS GROUP) wrote:
>> Le 14/07/2026 à 16:03, Kevin Brodsky a écrit :
>>> mm code often needs to know whether some mm represents a kernel or
>>> user address space. This is currently done by comparing the mm
>>> pointer with &init_mm; besides not being particularly elegant, this
>>> ignores the fact that other mm's (e.g. efi_mm) may also represent
>>> parts of the kernel address space.
>>>
>>> Introduce a new mm flag MMF_KERNEL and set it for init_mm.
>>> Subsequent patches will use this flag to replace comparisons with
>>> &init_mm. No functional change is introduced for now.
>> Did you consider performance impact ? This test is usually done in quite
>> critical memory handling functions.
>>
>> init_mm is known at link time. Before your patch 08/22 there is just a
>> comparison of mm (r3) with a constant (loaded in r10):
>>
>> c0014048 <assert_pte_locked>:
>> c0014048:    3d 40 c1 09     lis     r10,-16119
>> c001404c:    39 4a 03 98     addi    r10,r10,920
>> c0014050:    7c 03 50 00     cmpw    r3,r10
>> c0014054:    4d 82 00 20     beqlr
>> ...
>>
>> After patch 08/22 we have, it first checks that mm is not 0, then it loads the
>> word located at mm+528 then AND it with 0x1. This load might be costly.
>>
>> c0014048 <assert_pte_locked>:
>> c0014048:    2c 03 00 00     cmpwi   r3,0
>> c001404c:    7c 85 23 78     mr      r5,r4
>> c0014050:    41 82 00 10     beq     c0014060 <assert_pte_locked+0x18>
>> c0014054:    81 23 02 10     lwz     r9,528(r3)
>> c0014058:    71 29 00 01     andi.   r9,r9,1
>> c001405c:    4c 82 00 20     bnelr
> Is that a real problem, though?

I doubt it, this is a load from a fixed address and therefore highly
cacheable/predictable. At worst we're keeping an extra cache line
allocated, but I'd expect init_mm to be already in the cache most of the
time.

> What we could do is to just keep the == &init_mm check internally on configs
> where we know that there is only a single such MM context.

Sure, if this provides a clear performance benefit on powerpc or other
architectures/configs that don't have an efi_mm we could do that.

- Kevin

