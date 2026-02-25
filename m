Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E36F4FD3779
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 17:42:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:Date:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aMnEPXSeAknTUn6pBGQAEqhzdOlacieP4zL+mwxArg0=; b=AQS4qLxAWRdHnU4FMBayQUs1tc
	Of50slxgdTHZfVJIwJ8kDhxKZkJ3uWkfX7h+7h/rJWRLVSTXt/p8ldZ+MPwmGQRUmwrllffPkufcZ
	eJULdcpCgJpIb6hiak84AuLczwGexKeR/fo3C9l86BQS9jn72Up0uTG5qM4pATAFANMZwD0o3JTDj
	KbmLxHfR4dTD9Q8U+U+dzT+kbP5VqxormKwdvs+myR6TM10MaIiABvtBxk14m6hMkkH+N/Dqn96Vo
	EFgNND+CIQo5CS+ADJ0LcE/ScYkCA9MJl7kobAlXfShsLM0QiUHqp9iQG9DKth+XeSWCVBa6Whpkp
	t1Ioh/ug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvIte-00000004gOe-1TaW;
	Wed, 25 Feb 2026 17:42:02 +0000
Received: from mail-pf1-x42b.google.com ([2607:f8b0:4864:20::42b])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvIta-00000004gMJ-2aWo
	for linux-um@lists.infradead.org;
	Wed, 25 Feb 2026 17:42:00 +0000
Received: by mail-pf1-x42b.google.com with SMTP id d2e1a72fcca58-8230c33f477so15029b3a.2
        for <linux-um@lists.infradead.org>; Wed, 25 Feb 2026 09:41:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772041318; x=1772646118; darn=lists.infradead.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=aMnEPXSeAknTUn6pBGQAEqhzdOlacieP4zL+mwxArg0=;
        b=adCGUZSvAmS6lagPpBWOUCjfnHP8YrtOw5+kNXdpeuONIdv9w5psZ7NrnW668wQW/0
         XFcEOvfA1EW6npaAEZpjHKlmbcw92I+i+b8TGYCHncvIsKKSj4zM3qbnNkO3vi/qMJTV
         HjUikMdG0SDGr5cM0Tcf+zN7uKrbKZwcCfOQCQOFJ0rThC0UrR6igjGMJ7Y0n7aTl9za
         ogb/gGHx2doL0HyJr3NqPldbPa8msTVF7N+H4vmqVwQyWgCpA4TjzVlWi/XmAcBTYtPu
         wRR0fd4YXAmByXMX6X0WrMORhbC0wRB+z1iu1IEb+ZSbxj9LiJnx8gvos4mcP1mxm5+G
         J2ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772041318; x=1772646118;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aMnEPXSeAknTUn6pBGQAEqhzdOlacieP4zL+mwxArg0=;
        b=GJlz+YlkAyQdfclNjhS/y/G77OmtTT0bAtJpVCWmq5CEhYkb8KMSPnpUWhdxUQWIA9
         myVTwsSsKAy91v+sMRv6Oz6y480aU3LfDJ7emxuLuu/4HaGJ7WXuubTrjbm1LAcy/3ej
         MbZltYMv9AYMRBq9Us/jF+sstToVdg1BD9NhPwBD3umgSQIhg0YX+eaw87MhVrAdEbVC
         p3/7AsSHfvyHXqQ6Mj0SsA0TKWyOtdOHW4aYuW0+bgnAIFYmUJ01YThZ6OFcwyGdCoP9
         /j6A7EkQtqNLVu9XIVmeqN+wrxlu3o/k0OXdk/UrE6GHh1l/xrUhelD/cCmDbsZ8zD0J
         ZQsg==
X-Forwarded-Encrypted: i=1; AJvYcCW2cfOxMwjbc7ijHLWPQqfvkBdjUDtQ2+xs5FZeBuMK+ZDkWOc8c2dSAJD41cUBrg55BK3UCkJkaw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yy2Rdp6VsRT8r40CLZx5HniNDsxe6ESqMnvGcB1ZjwcYuKyVxIk
	tDKI/ROaLHkjIRLXLg0lQ0xOxeOzVJNt//2rkGIZue4EL4F/0QtTUDV2
X-Gm-Gg: ATEYQzyV16jf7/htkBfqQHz3cGZ+4aNzvTitYTmh1oJvqmJ0UXOxTHBcovKYBdk7PzA
	RCwcYlIV45A/29Fi/i7gzX0F2CKjAsR8ljx5SFOJTV5gQo+RNkd/BQkPLgZIaTaV+9N4SauRzYe
	/jN3GRe3bwvUiI9X+V9zF5pnTCkHVYLV6Miwc+SSTK/6GP8E48uEPH3cxFjPkh6u1I1szbyjOhO
	dfEZadBNf+sg0ocKQ/c22Wqx/YvM8LdymjStJpaToUeS3zdAN2rnSKtS+3Nc+YAfIc+3IR9747p
	K/Wp0frUYnycTXi8rpHbw98FzJMqqyPU1IDgg6287Ibupkuor5hD2iN9KrT1ODpXgikA81bsyqn
	iMaKo3qUOEonbd25ckdX7Ziu778ex2GUmYYy8b/4leIZaYVekK4ps2Yvq1safvnr7cw0CWaEML8
	iVubJEvNWiK8HUXlIB7w==
X-Received: by 2002:a05:6a21:3290:b0:38d:edd4:2fbe with SMTP id adf61e73a8af0-39545ed058emr15020115637.31.1772041317482;
        Wed, 25 Feb 2026 09:41:57 -0800 (PST)
Received: from dw-tp ([203.81.243.177])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-826dd8fdb81sm14825760b3a.64.2026.02.25.09.41.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 09:41:56 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	Klara Modin <klarasmodin@gmail.com>, "Liam R. Howlett" <Liam.Howlett@oracle.com>, 
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>, 
	Will Deacon <will@kernel.org>, x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 24/29] arch, mm: consolidate initialization of SPARSE memory model
In-Reply-To: <aZ8idANginXzhf0_@kernel.org>
Date: Wed, 25 Feb 2026 23:08:38 +0530
Message-ID: <87seaohgf5.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-25-rppt@kernel.org> <87tsv5h544.ritesh.list@gmail.com> <aZ8idANginXzhf0_@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_094158_656499_8FCC9F25 
X-CRM114-Status: GOOD (  28.63  )
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

Mike Rapoport <rppt@kernel.org> writes:

> Hello Ritesh,
>
> On Wed, Feb 25, 2026 at 09:00:35AM +0530, Ritesh Harjani wrote:
>> Mike Rapoport <rppt@kernel.org> writes:
>> 
>> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>> >
>> > Every architecture calls sparse_init() during setup_arch() although the
>> > data structures created by sparse_init() are not used until the
>> > initialization of the core MM.
>> >
>> > Beside the code duplication, calling sparse_init() from architecture
>> > specific code causes ordering differences of vmemmap and HVO initialization
>> > on different architectures.
>> >
>> > Move the call to sparse_init() from architecture specific code to
>> > free_area_init() to ensure that vmemmap and HVO initialization order is
>> > always the same.
>> >
>> 
>> Hello Mike,
>> 
>> [    0.000000][    T0] ------------[ cut here ]------------
>> [    0.000000][    T0] WARNING: arch/powerpc/include/asm/io.h:879 at virt_to_phys+0x44/0x1b8, CPU#0: swapper/0
>> [    0.000000][    T0] Modules linked in:
>> [    0.000000][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.19.0-12139-gc57b1c00145a #31 PREEMPT
>> [    0.000000][    T0] Hardware name: IBM pSeries (emulated by qemu) POWER10 (architected) 0x801200 0xf000006 of:SLOF,git-ee03ae pSeries
>> [    0.000000][    T0] NIP:  c000000000601584 LR: c000000004075de4 CTR: c000000000601548
>> [    0.000000][    T0] REGS: c000000004d1f870 TRAP: 0700   Not tainted  (6.19.0-12139-gc57b1c00145a)
>> [    0.000000][    T0] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 48022448  XER: 20040000
>> [    0.000000][    T0] CFAR: c0000000006016c4 IRQMASK: 1
>> [    0.000000][    T0] GPR00: c000000004075dd4 c000000004d1fb10 c00000000304bb00 c000000180000000
>> [    0.000000][    T0] GPR04: 0000000000000009 0000000000000009 c000000004ec94a0 0000000000000000
>> [    0.000000][    T0] GPR08: 0000000000018000 0000000000000001 c000000004921280 0000000048022448
>> [    0.000000][    T0] GPR12: c000000000601548 c000000004fe0000 0000000000000004 0000000000000004
>> [    0.000000][    T0] GPR16: 000000000287fb08 0000000000000060 0000000000000002 0000000002831750
>> [    0.000000][    T0] GPR20: 0000000002831778 fffffffffffffffd c000000004d78050 00000000051cbb00
>> [    0.000000][    T0] GPR24: 0000000005a40008 c000000000000000 c000000000400000 0000000000000100
>> [    0.000000][    T0] GPR28: c000000004d78050 0000000000000000 c000000004ecd4a8 0000000000000001
>> [    0.000000][    T0] NIP [c000000000601584] virt_to_phys+0x44/0x1b8
>> [    0.000000][    T0] LR [c000000004075de4] alloc_bootmem+0x144/0x1a8
>> [    0.000000][    T0] Call Trace:
>> [    0.000000][    T0] [c000000004d1fb50] [c000000004075dd4] alloc_bootmem+0x134/0x1a8
>> [    0.000000][    T0] [c000000004d1fba0] [c000000004075fac] __alloc_bootmem_huge_page+0x164/0x230
>> [    0.000000][    T0] [c000000004d1fbe0] [c000000004030bc4] alloc_bootmem_huge_page+0x44/0x138
>> [    0.000000][    T0] [c000000004d1fc10] [c000000004076e48] hugetlb_hstate_alloc_pages+0x350/0x5ac
>> [    0.000000][    T0] [c000000004d1fd30] [c0000000040782f0] hugetlb_bootmem_alloc+0x15c/0x19c
>> [    0.000000][    T0] [c000000004d1fd70] [c00000000406d7b4] mm_core_init_early+0x7c/0xdf4
>> [    0.000000][    T0] [c000000004d1ff30] [c000000004011d84] start_kernel+0xac/0xc58
>> [    0.000000][    T0] [c000000004d1ffe0] [c00000000000e99c] start_here_common+0x1c/0x20
>> [    0.000000][    T0] Code: 6129ffff 792907c6 6529ffff 6129ffff 7c234840 40810018 3d2201e8 3929a7a8 e9290000 7c291840 41810044 3be00001 <0b1f0000> 3d20bfff 6129ffff 792907c6
>> 
>> 
>> I think this is happening because, now in mm_core_early_init(), the
>> order of initialization between hugetlb_bootmem_alloc() and
>> free_area_init() is reversed. Since free_area_init() -> sparse_init()
>> is responsible for setting SECTIONS and vmemmap area. 
>> 
>> Then in alloc_bootmem() (from hugetlb_bootmem_alloc() path), it uses virt_to_phys(m)...
>> 
>> 			/*
>> 			 * For pre-HVO to work correctly, pages need to be on
>> 			 * the list for the node they were actually allocated
>> 			 * from. That node may be different in the case of
>> 			 * fallback by memblock_alloc_try_nid_raw. So,
>> 			 * extract the actual node first.
>> 			 */
>> 			if (m)
>> 				listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
>> 
>> 
>> ... virt_to_phys on powerpc uses:
>> 
>> static inline unsigned long virt_to_phys(const volatile void * address)
>> {
>> 	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));
>> 
>> 	return __pa((unsigned long)address);
>> }
>> 
>> #define virt_addr_valid(vaddr)	({					\
>> 	unsigned long _addr = (unsigned long)vaddr;			\
>> 	_addr >= PAGE_OFFSET && _addr < (unsigned long)high_memory &&	\
>> 	pfn_valid(virt_to_pfn((void *)_addr));				\
>> })
>> 
>> 
>> I think the above warning in dmesg gets printed from above WARN_ON, i.e.
>> because pfn_valid() is false, since we haven't done sparse_init() yet.
>
> Yes, I agree.
>  
>> So, what I wanted to check was - do you think instead of virt_to_phys(), we
>> could directly use __pa() here() in mm/hugetlb.c, since these are
>> memblock alloc addresses? i.e.: 
>> 
>> // alloc_bootmem():
>> -   listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
>> +   listnode = early_pfn_to_nid(PHYS_PFN(__pa(m)));
>> 
>> // __alloc_bootmem_huge_page():
>> -   memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
>> +   memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),
>
> It surely will work for powerpc :)
> I checked the definitions of __pa() on other architectures and it seems the
> safest and the easiest way to fix this.
>  
> Would you send a formal patch?
>

Thanks Mike for taking a look at above and confirming. Sure, let me
prepare the patch and send it by tomorrow. 

-ritesh

