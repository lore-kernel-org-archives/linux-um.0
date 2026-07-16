Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A405C44501
	for <linux-um@archiver.kernel.org>; Thu, 16 Jul 2026 09:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=PSf5NVNQU/qg/WZaziEf6MJsCA+xP66TswCfDndguR4=; b=VKj9hK0C+YtmARHM6z2phOdY0q
	Zul54vUkeR5O/hU8OU7G2koWkMdz0h/CdirZ5SPS6CEWhxUw5hEavj1JV9G1x8UKjfD0VQbNhoACs
	8tne4Zv7muO+UAWk5si6ksfpimuaV+iEB7u5NWRctZWFZ88QTO5tRU3zswok43WjmJUFd6F/nrTvu
	vjiekJTDBQDkZDqW8/pGJ7z9JiCwe4q5PxBAuMiADPQU05/rdjxyRIe0JaKaG+FZsvCrZWBv+I+m0
	tUpUhTyTUnMeGONxu/cnEloLlAipWMYyEAU9fjiLz/8pi2rULNBl+UXwD7BmL6HpJTS9g/npGh47d
	IVk/Y6hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIV6-0000000GtWL-2eR0;
	Thu, 16 Jul 2026 09:35:28 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIV3-0000000GtVQ-3DAC;
	Thu, 16 Jul 2026 09:35:26 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3F0BC1477;
	Thu, 16 Jul 2026 02:35:20 -0700 (PDT)
Received: from [10.57.83.230] (unknown [10.57.83.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D48693F905;
	Thu, 16 Jul 2026 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784194524; bh=1BVLyLaF1qecs+fgW08zdSlsqUZduOIGJBU1ULHtkjI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=WfF+qmdktWvhJyvXuGhu5iu7o0FWtOqQ5I0g8heoED31AV02y/qkTuaH5oKdQgNVz
	 Zk0OME+7E85ZuIaQ7/UmrEgiZGtJ9Onp9GZygZefACK6bIgVDye7nneuzPpsC+bgGq
	 OEE0LznhDFEX6R7AoNIGyWQ01U2Y9n4+8Xjc5eLI=
Message-ID: <02565237-d777-4c63-8b17-817df59feac4@arm.com>
Date: Thu, 16 Jul 2026 11:35:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 04/22] mm: use mm_is_kernel() in generic page table code
To: linux-mm@kvack.org
Cc: Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
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
 <20260714-remove_pgtable_cdtor-v1-4-44be8a7685d7@arm.com>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260714-remove_pgtable_cdtor-v1-4-44be8a7685d7@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_023525_886016_2BBEA97A 
X-CRM114-Status: GOOD (  14.42  )
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

On 14/07/2026 16:03, Kevin Brodsky wrote:
> diff --git a/mm/memory.c b/mm/memory.c
> index d5e87624f692..c0244c0b0756 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -3394,13 +3394,13 @@ static int apply_to_pte_range(struct mm_struct *mm, pmd_t *pmd,
>  	spinlock_t *ptl;
>  
>  	if (create) {
> - mapped_pte = pte = (mm == &init_mm) ?
> + mapped_pte = pte = mm_is_kernel(mm) ?
>  			pte_alloc_kernel_track(pmd, addr, mask) :
>  			pte_alloc_map_lock(mm, pmd, addr, &ptl);

As noted by Sashiko, this is a little problematic because if
apply_to_page_range() is called on efi_mm, then we will end up with
__pte_alloc_kernel() taking the init_mm lock, since that's hardcoded.

That probably means we should pass the mm to __pte_alloc_kernel().

FWIW calling the kernel alloc function for efi_mm is the correct thing
to do: this ensures we use pmd_populate_kernel() and therefore kernel
page table attributes (just like efi_create_mapping()). This path is
currently never hit because EFI regions whose permissions are modified
are PTE-mapped, but it is clearly more correct to use the kernel path
for such mm's.

- Kevin

