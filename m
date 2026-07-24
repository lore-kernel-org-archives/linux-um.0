Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24802C531FA
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NEwnT35D7tuzT3xeTQQMHkJEWGepfSu0cwMv30sxXLk=; b=ay25V9l6pfZfm1u2OpJr1eaWLF
	9z3FDBoyGg87SM3/TBuvgSaDOsmtYyZkW830Il1fXk48DqtaiufRwWv60o8RzXNUQtXuxgwwhLGWz
	37j9UtQQD4wqVWgTj9w6QgrS2U8r5EZ1v6kuarn+0el8iDsI2IvYuU2On75BB35Yzut/Q17B4y0/r
	SeA9266cHd4bTpS6pLxZpAsSkzNREN+LWuurGzvskQUxj2Z1FcdrIEJF/sJnWVmkXHyAbqKGO3ZN4
	QIw+brvBUhBtYZ5aUb5WIuRG6elbz+T+znz7qmXo3N5IApIfsL9VXR1XwY+d4gSD4Qo8NJSwoQKkK
	kUHlC/dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnIoR-0000000GqgO-3Na8;
	Fri, 24 Jul 2026 16:31:51 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnIoO-0000000GqfJ-3YZM;
	Fri, 24 Jul 2026 16:31:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4AE7F1BB2;
	Fri, 24 Jul 2026 09:31:43 -0700 (PDT)
Received: from [10.57.0.90] (unknown [10.57.0.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ACA703F66F;
	Fri, 24 Jul 2026 09:31:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784910707; bh=NEwnT35D7tuzT3xeTQQMHkJEWGepfSu0cwMv30sxXLk=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=rJ2DJJ7D9c7D1FVu9FvWF7Hq7v5HoLI/CdhriAp1fJ4dLBnD8EJRRWBa3d3TSeSRj
	 y4giJ+zCCtRJVGca1Zy4119yCr4CT8kuPBEs9cPEAEswfrfTiiEZd9fOxFya5yiDAq
	 5lH15CX22toaprtjLQyFDxQHqVRAyMvOmxdmryBU=
Message-ID: <c17ccb0b-9f6b-4521-a992-bdc658b91597@arm.com>
Date: Fri, 24 Jul 2026 18:31:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 14/22] mm: set page table page type when allocated
To: Vishal Moola <vishal.moola@gmail.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, Lorenzo Stoakes <ljs@kernel.org>,
 "Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
 Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>,
 Michal Hocko <mhocko@suse.com>, Pasha Tatashin <pasha.tatashin@soleen.com>,
 Russell King <linux@armlinux.org.uk>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, linux-arm-kernel@lists.infradead.org,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
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
 Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-14-44be8a7685d7@arm.com>
 <alZSwAM4pwmMOeaD@fedora> <f3afa5df-73f3-49da-87a6-d75eb5f3610f@arm.com>
 <al5xZHiFwatn518I@fedora>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <al5xZHiFwatn518I@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_093149_025579_A14A7476 
X-CRM114-Status: GOOD (  18.29  )
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

On 20/07/2026 21:05, Vishal Moola wrote:
> On Thu, Jul 16, 2026 at 11:49:31AM +0200, Kevin Brodsky wrote:
>>> We should switch over from __folio_set_pgtable() to __SetPagePgtable()
>>> in this patch. Ptdescs and folios should be treated as distinctly
>>> independent of each other.
>> I sure remember the previous discussion, but my reading of your comments
>> [1] is that we cannot really change this as long as pagetable_alloc()
>> can be called with order > 0, right? Multiple archs still rely on that.
> Kinda...
>
> The concern was about callers accessing tail pages directly for that
> information. Using the folio API ensures that we always look into the
> head page.
>
> Since we're now doing it at allocation time, we know we always have the
> head page, so it's fine.

Ah got it, that makes sense.

>
> The dtor/free should be more questionable because the underlying api
> uses virt_to_page() which could look at a tail page... oopsie. I
> haven't seen any reports tied to it so its probably fine (the
> setting/clearing has been using the folio API since ptdescs).

Right, that should be fine - calling pagetable_free() on anything else
than a ptdesc allocated by pagetable_alloc() is a bug, so if we get any
crash because of this we should just go and fix the underlying issue.
I'd still switch to __SetPagePgtable() in a separate commit to improve
bisectability.

FWIW there are definitely cases where pagetable_free() and
pagetable_alloc() calls aren't properly matched (see my reply to the
cover letter), this needs to be addressed for this series anyway.

> We can say thats a happy accident that makes distinguishing ptdescs
> and folios easier :)

Indeed!

- Kevin

