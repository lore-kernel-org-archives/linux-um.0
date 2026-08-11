Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71834C5CFCF
	for <linux-um@archiver.kernel.org>; Tue, 11 Aug 2026 09:00:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QyeeOcqJB+URGAwRe+Og0D34yFM6sgFjPGvLOxK7FFo=; b=cz4dapzSR2QzWxj8hmOYqdIzxN
	B/7O0idrRuy3xSZr9uYVObVFY4gLYV0OxMTOjqeNOVj6thnK2YVXIwAirDFdWPO9IXntClk7w/gpO
	9hgvrepN2EOZQOvbhr0wbqHQOjC7vhLOTtkYPay6whlGtySwnVTJlJVk9sH8uSaiGI4oahPkB7nAU
	fsqvuLzDU+HKUUwbrhq3N0gx+Qk+lt3edJkdSKLCklFqf9fq9MPpypMbLvumhcna9zdFpnvkhW96M
	STmlUpmP28kJlmR9KlSi4KDgPs5MsLI7iHQ9DKLBQTHDH7ihLRVTPjYt3/5PbyblvAmiGsI/rAVfT
	hkwxjdWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtiLc-0000000DfuH-3P94;
	Tue, 11 Aug 2026 09:00:36 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtiLY-0000000Dft6-0yrc;
	Tue, 11 Aug 2026 09:00:35 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7549F1516;
	Tue, 11 Aug 2026 02:00:26 -0700 (PDT)
Received: from [10.57.5.193] (unknown [10.57.5.193])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3B19F3F86F;
	Tue, 11 Aug 2026 02:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1786438830; bh=tUiTGK9kLGJYJG38Hawj4v69yMlo3kmE+u/Tuup4Yg4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=p0EklLMHJGrKLnVqOINCl1ZfxhRZ+BNvpIRznN2rLsga1Dwdloi6U4xuE1VCQAm02
	 kBFiXP3tqlA3ARY2zoYWjzb5WjBU+6w3Cb3dcRQRjE/0+/SN3iB10dvAMI84fhbPXQ
	 52YnfLEkfwAxucsSI1ar27PS56iSCcvkFqLRrZM8=
Message-ID: <643a624d-0106-44ed-a7f5-aaf9316f94fd@arm.com>
Date: Tue, 11 Aug 2026 11:00:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for
 init_mm
To: David Laight <david.laight.linux@gmail.com>,
 "David Hildenbrand (Arm)" <david@kernel.org>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, linux-mm@kvack.org,
 Andrew Morton <akpm@linux-foundation.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
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
 <20260811091016.5ca67143@pumpkin>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260811091016.5ca67143@pumpkin>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260811_020032_349473_98F8C435 
X-CRM114-Status: GOOD (  15.50  )
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

On 11/08/2026 10:10, David Laight wrote:
> On Wed, 5 Aug 2026 14:07:01 +0200
> "David Hildenbrand (Arm)" <david@kernel.org> wrote:
>
>> On 8/3/26 15:59, Christophe Leroy (CS GROUP) wrote:
>>>
>>> Le 14/07/2026 à 16:03, Kevin Brodsky a écrit :  
>>>> mm code often needs to know whether some mm represents a kernel or
>>>> user address space. This is currently done by comparing the mm
>>>> pointer with &init_mm; besides not being particularly elegant, this
>>>> ignores the fact that other mm's (e.g. efi_mm) may also represent
>>>> parts of the kernel address space.
>>>>
>>>> Introduce a new mm flag MMF_KERNEL and set it for init_mm.
>>>> Subsequent patches will use this flag to replace comparisons with
>>>> &init_mm. No functional change is introduced for now.  
>>> Did you consider performance impact ? This test is usually done in quite
>>> critical memory handling functions.
>>>
>>> init_mm is known at link time. Before your patch 08/22 there is just a
>>> comparison of mm (r3) with a constant (loaded in r10):
>>>
>>> c0014048 <assert_pte_locked>:
>>> c0014048:    3d 40 c1 09     lis     r10,-16119
>>> c001404c:    39 4a 03 98     addi    r10,r10,920
>>> c0014050:    7c 03 50 00     cmpw    r3,r10
>>> c0014054:    4d 82 00 20     beqlr
>>> ...
>>>
>>> After patch 08/22 we have, it first checks that mm is not 0, then it loads the
>>> word located at mm+528 then AND it with 0x1. This load might be costly.
>>>
>>> c0014048 <assert_pte_locked>:
>>> c0014048:    2c 03 00 00     cmpwi   r3,0
>>> c001404c:    7c 85 23 78     mr      r5,r4
>>> c0014050:    41 82 00 10     beq     c0014060 <assert_pte_locked+0x18>
>>> c0014054:    81 23 02 10     lwz     r9,528(r3)
>>> c0014058:    71 29 00 01     andi.   r9,r9,1
>>> c001405c:    4c 82 00 20     bnelr  
>> Is that a real problem, though?
> The cost of the read is likely to matter most if the branch gets mispredicted.
> I'd also guess the mm isn't usually NULL - so that branch needs to statically
> predicted correctly as well.
> I'd also not assume that the mm is in the cache (unless the surrounding code
> has already accessed it), the L1 data caches are small.

You're right, I didn't think about this the right way round - in general
it may not be easy to predict that mm points to init_mm, and an
arbitrary user mm isn't guaranteed to be cached. Repeated calls to
mm_is_kernel(mm) in the same function shouldn't cost much though.

Would some (micro)benchmark be particularly relevant to measure the
overhead, if any?

- Kevin

