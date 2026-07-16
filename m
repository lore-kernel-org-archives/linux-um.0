Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53B99C44501
	for <linux-um@archiver.kernel.org>; Thu, 16 Jul 2026 09:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UHmQFj6AU7St8El+2pNSzIqPn66g96jJ/wr+CVCA58g=; b=KBT/PKNqqxIv7LoMK/5QZY0RWu
	V2BtBpiVOTbIKF/8TRVHMmvtbQZdSA22KOF5kdAFiPT8Y54w97eWg2CJ6Wh6GSM5jyaYocxgfMwpy
	8QlWEfv5ldpuaIuUgwOaRweCviRQYF3/f68xLkAzzNJbsIQWa6wma7p2soEbh2hGHNGYH3VYuIHCE
	Ken2ECkSRphFqn7w1pQu3L/9QdoEAI1ebxcFjf1HBQN/8t48opx74UAhjm+L9kszknEpCezIRNrew
	SspQUXqZxc2pJot+EjOFJS32TxBkgIHCB4TyMPDNUBkH8AtEmXdR/2LgdMGY4HDOa0nPOAsVjhUk4
	w6tMqZkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkITY-0000000GsZ7-0V7i;
	Thu, 16 Jul 2026 09:33:52 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wkITV-0000000GsYR-0CKm;
	Thu, 16 Jul 2026 09:33:50 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3A3792F;
	Thu, 16 Jul 2026 02:33:43 -0700 (PDT)
Received: from [10.57.83.230] (unknown [10.57.83.230])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1894E3F905;
	Thu, 16 Jul 2026 02:33:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784194427; bh=Jiq0eRIkC/oi6OkkmArmlbDUuLGok8mQdQh0yrF9YB0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=IZauRYRl5ICTEYN8zkstcpXUOGTNSh9WC4OOdZL7resltad2ntP1sTBpfqQKq/LOy
	 NJ7R16g/TBidqac95gDoBdSGmrESHyLIJbhrl3Pu0YR5HqAz6dxQoYwAZrSwLCNC6+
	 RzqdaEwAda9C20R94gG615k7hLEu0nCXftHu3u9w=
Message-ID: <5ce00109-c0ea-43f0-881d-f58a0fda8dcb@arm.com>
Date: Thu, 16 Jul 2026 11:33:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/22] mm: introduce MMF_KERNEL flag and set it for
 init_mm
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
 David Hildenbrand <david@kernel.org>, "Liam R. Howlett"
 <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>,
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
 Vishal Moola <vishal.moola@gmail.com>, Alistair Popple <apopple@nvidia.com>,
 "Matthew Wilcox (Oracle)" <willy@infradead.org>,
 linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
References: <20260714-remove_pgtable_cdtor-v1-0-44be8a7685d7@arm.com>
 <20260714-remove_pgtable_cdtor-v1-3-44be8a7685d7@arm.com>
 <71045fa8-89fe-4a0b-a05b-67e19ce89834@intel.com> <alZOs30ziqa7l_Lq@lucifer>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <alZOs30ziqa7l_Lq@lucifer>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260716_023349_427460_7DDB0666 
X-CRM114-Status: GOOD (  16.46  )
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

On 14/07/2026 17:04, Lorenzo Stoakes (ARM) wrote:
> On Tue, Jul 14, 2026 at 07:47:43AM -0700, Dave Hansen wrote:
>> On 7/14/26 07:03, Kevin Brodsky wrote:
>>> +static inline bool mm_is_kernel(const struct mm_struct *mm)
>>> +{
>>> +	return mm && mm_flags_test(MMF_KERNEL, mm);
>>> +}
>> Could we give this some nice comments explaining what a kernel mm is,
>> please? Part of the problem with the init_mm checks is that they're
>> magic and it's not always clear what's special about init_mm.

Agreed, we need to define what this property means exactly, and your
comments on patch 14 show that extending it to efi_mm isn't necessarily
as benign as it appeared to me at first.

My motivation really is about how page tables are handled (in particular
whether ptlocks are used), so as you suggested on patch 19 maybe this
flag should be narrower in scope, and the naming should reflect it.
Possibly MMF_KERNEL_PGTABLES? That's at least one thing that should be
true of all of init_mm, efi_mm and tboot_mm: their page tables use
kernel permissions, not user, and should follow the same rules including
not using ptlocks.

>> Maybe start with this list?
>>
>> 1. There's only one of them.
>> 2. All kernel threads share it. tsk->mm is the same for all kernel
>>    threads.
>> 3. It holds the reference copy of the kernel page tables
>> 4. Userspace can't be entered when it is the current mm
>> 5. It has different TLB flushing rules than userspace mms
>>
>> I _think_ those are universal across all architectures.
> Well point 1 isn't true of efimm or tboot_mm so we possibly need a better
> name :)
>
> "Special" is overloaded too much already. I quite like "eternal" so:
>
> 	static inline bool mm_is_eternal(const struct mm_struct *mm)
> 	{
> 		return mm && mm_flags_test(MMF_ETERNAL, mm);
> 	}

Cheeky but why not! I do wonder whether this conveys the right idea
though. The main point of this flag is that page tables are
allocated/initialised/locked differently; in principle you could have a
temporary non-user mm.

- Kevin

