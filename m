Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4C2CC531FA
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 16:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZObIlia0bF/5KoAO7QHOC3KkZX1rkeg1RIL22kW+K4Y=; b=YMRPxnxcgsFMwgYiXTI38cdbim
	3PgvoWhRepLDXZvEcPvpUb2MPv15t7HiXZyDCbe5F/5IWj5vDMdgeUxJ6jdRttHKduX2RqYL0os12
	uIp8mel7+AgOzh46D1jQHBKr+gdS0izQq8sRV9AQvub64lb9og1ChiX66p7XHpBUBWS8wxRtpuEup
	5bS2if8IsX1SepUmdmFHk2anFK3SCALc+3M0hFzTkDZQHCJOYSzISoUMx0Zv9yFy1lmQ9XGg5RTDi
	WyeiO00EMTmujq+iKnA2Yi8LcXoTLS1lDZXC31AySwj4F37SQjp6BHwzFHkQeOjFsohK0T6BkGB55
	EMc1DWYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnIij-0000000Gq9T-3hVU;
	Fri, 24 Jul 2026 16:25:57 +0000
Received: from foss.arm.com ([217.140.110.172])
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnIig-0000000Gq8j-1OUF;
	Fri, 24 Jul 2026 16:25:55 +0000
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 820DC1BB0;
	Fri, 24 Jul 2026 09:25:48 -0700 (PDT)
Received: from [10.57.0.90] (unknown [10.57.0.90])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8D9153F66F;
	Fri, 24 Jul 2026 09:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1784910352; bh=90PjtwWiYZulmqV39H8fGSHBZ8shBRidW6H3XBOLz1E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=LSeaOheALTDiD44xvkD55jNPMvVMiWCKhoAY3QOMhLgjHKQ4vGk/sCbVALnk8LQcs
	 UGzo+QT8sgIjgylea7jT8NDptv0jyxQHH1Yl0mF7+8llAZ/r++VL9OJQZ9z7INpPWZ
	 IvaE6ewh0IBZMWQRx7oS05rwa6Tfr8Ub24gxyRR8=
Message-ID: <13be2648-f68d-46ae-ae8a-5ca9e067cc90@arm.com>
Date: Fri, 24 Jul 2026 18:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/22] mm: only initialise pt_share_count for user
 pgtables
To: "David Hildenbrand (Arm)" <david@kernel.org>, linux-mm@kvack.org
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
 <20260714-remove_pgtable_cdtor-v1-15-44be8a7685d7@arm.com>
 <e95aabc0-522b-4660-958a-d648c1cfa78f@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <e95aabc0-522b-4660-958a-d648c1cfa78f@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260724_092554_531939_07A8B1D1 
X-CRM114-Status: GOOD (  17.09  )
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

On 21/07/2026 17:12, David Hildenbrand (Arm) wrote:
> On 7/14/26 16:04, Kevin Brodsky wrote:
>> ptdesc_pmd_pts_init() initialises the pt_share_count ptdesc field.
>> That field is only used for hugetlb tracking purposes, so there is
>> no need to initialise it for kernel page tables. Skip the call for
>> kernel page tables, like pmd_ptlock_init().
>>
>> From now on pagetable_*_ctor() and pagetable_dtor() do nothing for
>> kernel page tables.
>>
>> Signed-off-by: Kevin Brodsky <kevin.brodsky@arm.com>
>> ---
>>  include/linux/mm.h | 9 ++++++---
>>  1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 94f0fb1c662a..b217ccbed5a3 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -3905,9 +3905,12 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
>>  static inline bool pagetable_pmd_ctor(struct mm_struct *mm,
>>  				      struct ptdesc *ptdesc)
>>  {
>> -	if (!mm_is_kernel(mm) && !pmd_ptlock_init(ptdesc))
>> -		return false;
>> -	ptdesc_pmd_pts_init(ptdesc);
>> +	if (!mm_is_kernel(mm)) {
>> +		if (!pmd_ptlock_init(ptdesc))
>> +			return false;
>> +		ptdesc_pmd_pts_init(ptdesc);
>> +	}
>> +
> I'd have said "the initialization is cheap, why bother", but we already do have
> the mm_is_kernel() check in place, so

This isn't mainly about the overhead, but rather the fact that from here
on the ctor/dtor do nothing for kernel page tables. Patch 20-22 rely on
this, and in part 2 I would go further and only ever call the ctor/dtor
for user page tables, so that the mm_is_kernel() check can be dropped.

> Acked-by: David Hildenbrand (Arm) <david@kernel.org>

Thanks for the reviews!

- Kevin

