Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9683C44501
	for <linux-um@archiver.kernel.org>; Thu, 16 Jul 2026 09:49:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DULupypI0kQO6VR/9Hnm6xvd1I56RK/sZSlBe1w/CWE=; b=I68zyTSBcy6JP1latbAlZniIqJ
	lWAwyKxR1vmYjk4iqRhCXRAYiUaUIDznEUyo5YaRAAPofE3BTwO2TF/DZc6h4ifgtfTrkub7iyYEs
	GNugIE7J5BkBZ8oy2yr30dO6As0V2dyz6n4a0VrgLUoc7C+pBTpweeTFY/Ql+t2OQtaVZr1vyGIWN
	QTu83vm8SEt5AG0sia1G4knVE+evq2QepJuhUFgimJ3COGS8HUsMIC+WuBS+B+cL7VsHN3SpYm//3
	fS9ST1n+5DGQdRJqLK0Of3lB9kzQT2EsH25B9F2kcaZ9htjh0PSvx6Y49BISrPGb/ryhjpbmCXUtM
	EO3mifBg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIj0-0000000GvUa-0TCz;
	Thu, 16 Jul 2026 09:49:50 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkIiw-0000000GvTk-1tdf;
	Thu, 16 Jul 2026 09:49:47 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A60E11477;
	Thu, 16 Jul 2026 02:49:40 -0700 (PDT)
Received: from [10.57.83.230] (unknown [10.57.83.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28D693F905;
	Thu, 16 Jul 2026 02:49:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784195384; bh=DULupypI0kQO6VR/9Hnm6xvd1I56RK/sZSlBe1w/CWE=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=s0WjY92k6FXXGsVb/uHJpLBIVOYUjUI8eS0BHss4CJRfj+QIoU4lVy2lHkTcCkoLf
	 HXbioh4bhVzyH7KrUz8UAnwAXsoSNPBoK+CXb0kGziyOHBz0wHOsqFAI5ri0j0KaxN
	 AXVBsuWhv1zZICmG2yvm8TKcS7aYUdVdoYT9nYUs=
Message-ID: <f3afa5df-73f3-49da-87a6-d75eb5f3610f@arm.com>
Date: Thu, 16 Jul 2026 11:49:31 +0200
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
 <alZSwAM4pwmMOeaD@fedora>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <alZSwAM4pwmMOeaD@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_024946_590096_76480DFE 
X-CRM114-Status: GOOD (  16.61  )
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

On 14/07/2026 17:16, Vishal Moola wrote:
> On Tue, Jul 14, 2026 at 03:04:03PM +0100, Kevin Brodsky wrote:
>> As a step towards removing pagetable ctor/dtor calls for kernel
>> mm's, move the page type updates from the ctor/dtor to
>> pagetable_{alloc,free}.
> Thanks for doing this patchset.

Thanks for suggesting it :) It's turning out to be quite a bit more
involved than I expected though! (There are multiple cases where we call
the ctor/dtor without using pagetable_{alloc,free}, see my reply to the
cover letter.)

> We should switch over from __folio_set_pgtable() to __SetPagePgtable()
> in this patch. Ptdescs and folios should be treated as distinctly
> independent of each other.

I sure remember the previous discussion, but my reading of your comments
[1] is that we cannot really change this as long as pagetable_alloc()
can be called with order > 0, right? Multiple archs still rely on that.

> Eventually, we want to replace the memcg accounting as well, but
> there's no existing API for that right now. Lets leave that as is for
> now; this patchset is big enough already ;)

Yep, looks like there was an attempt to improve this but it had to be
reverted [2].

- Kevin

[1] https://lore.kernel.org/all/aha321ndGSdReBJR@fedora/
[2]
https://lore.kernel.org/all/20260225002434.2953895-1-axelrasmussen@google.com/


