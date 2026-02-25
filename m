Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA0ADEFD218
	for <linux-um@archiver.kernel.org>; Wed, 25 Feb 2026 09:34:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	References:Message-ID:Date:In-Reply-To:Subject:Cc:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JxnsaOQZey5wMq56BxN2EdEuMBW71mGq+RSuzcss/8M=; b=j3mNRsymvHmBV2o9avxQn6RnTf
	5Zlm0ea29MKkUdPvH1U37x61hUmoqLnF4NTNXxltEArHFUDQwf1VnCCnql8EnQPGKtSqhKQB5hGBf
	PbB2HQMjXBxQrL8ZmPulvvqnCC3nt3jm9FiNPP4GpNkCuV0ReHaTqbwVqJvrCIfZ5Ur9DrXIpeFCS
	3YjwRvhQQwln02/H/igMQAV3u/yT/1utH6kNCHZquZSL9WWPu/VT3aF+OdV0octrThLlzN+piaN+/
	5woURblg7xfzJtCGVGHo8kgPF3xgcd0WGYa+5Mbw2yl3cJT18cN0mVPEhM2SZrisUe901lr9kLifE
	OT8NrO4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBHi-00000003hVK-0f9W;
	Wed, 25 Feb 2026 09:34:22 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBHg-00000003hUt-1mz7
	for linux-um@bombadil.infradead.org;
	Wed, 25 Feb 2026 09:34:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Type:MIME-Version:References:
	Message-ID:Date:In-Reply-To:Subject:Cc:To:From:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=JxnsaOQZey5wMq56BxN2EdEuMBW71mGq+RSuzcss/8M=; b=I3xldCR/We3duKCz8JTzE2mIH+
	yQ+iRXFoDn8b4GcGz2296kIc1TS3Djwz++YMEuLBSzutfmcVMrcnTH8fcpMytaKfEAM8RkbOAaXYN
	YxZwbD8yiMlIo+BU+zK9skrhc8seJ6+pV0Q5nJ0rbK4x/e1JG32pP8Gd+i7QTA3S/5iR35LWaBMnU
	hItogWeqw+T1EN3nvPLhGx6g0NkgsXmzIEgLdQH08Ox4lwxXwudVtoxqYz3VFoO96vyEuROPc97aw
	jdbio4Gv41dIUEJbtWNmtadg5hYcFhrMvNZ/GuqUJPBxLkp+ADu8b20FVDfBWIg5DQMNEiUgRmQtb
	/kjCDsFQ==;
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvBHc-00000008gs1-25ic
	for linux-um@lists.infradead.org;
	Wed, 25 Feb 2026 09:34:19 +0000
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-3590408a093so512452a91.2
        for <linux-um@lists.infradead.org>; Wed, 25 Feb 2026 01:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772012054; x=1772616854; darn=lists.infradead.org;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=JxnsaOQZey5wMq56BxN2EdEuMBW71mGq+RSuzcss/8M=;
        b=K9tjWff0olF7asopR7xuRd7yIgfULTywuptbho9XaTCLws0KJcXLOhocx+5rLF7k64
         MrTZZmE27KWssZNdAEf2Xrl5AsnfYFyZtTvd0Ddg24mKh7UNqKzsUjflpDWQFvm/2XVX
         w4NeEh8Lwj6ifwgn1jNOLl1QGN5GWuExCRYuxXSZBAyMT5h0he5B3H83kOthKPWKd0ks
         TsW7tlV5s4SwspWZy6WyHn07LblJTdJQxOi+eWPxLjUXp5MWft9YtvxDqPtfIa+tIvLp
         wDJxUagheVOkD6jVvln7lURv42iGouKgNYj7qZYXBz1aeAAw08a9Pk2/+fZ5aNqp8KhK
         waXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772012054; x=1772616854;
        h=mime-version:references:message-id:date:in-reply-to:subject:cc:to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxnsaOQZey5wMq56BxN2EdEuMBW71mGq+RSuzcss/8M=;
        b=V06MVWQbaBctq+dJuqHq5Kaubkmakt5SoxXxsrOftVnwEiicXyNZnEIB/63reYlNbN
         vQFsthEQhPsavxFiQxacCpsgwUa+Mi7PoZBg3Xhs20BKlYV+ZndFkoVVERJqlcVYUCI1
         oEkcTmu8c2bS5vmDb+BZRd8ZxRQ2qsjY0Iytg22uNAHOqmb62fA4COYllpFFJabpBgaq
         4eivqIi4dwU//HheyXvUrfPYPjZkS4W/XgYV0ifSR92vpkvGFPnJLNdKB6TGvWhNvVNn
         KrfT8rcu7jwzF7/RN3f6/Y3m5CcTM5YtFLJ80yB2YhWFJR3cUYwhpnnXbjgGEjJe7BiZ
         KWJw==
X-Forwarded-Encrypted: i=1; AJvYcCURBQdT54bWdhN50ZRHmNtI4B1nB2yw3FX3uBA12XUWlMNImvvTgTvl6x/xq3LR9uwEIH08+PmRWw==@lists.infradead.org
X-Gm-Message-State: AOJu0Yyzk2ndmToE/vcNHSTYpGb9v62lFI0meFji6MF6dggbQhE6Gp58
	oHlGFTgtAN0tj4fbemCvFqCrFTkWy3z6MBmqKHHrURSa2XCu6efiZ10A
X-Gm-Gg: ATEYQzxqQVd9oD4R2YuRhcOjGm9ep3qfXq8XS36P6njWBEK7lQcy8gQ5ZFZimhwOs8L
	v/xAbac7gKocqyW4np0EHYbIlZbTtvzlWIpNUIYz/hyULAA6OP8+3Gt6aSr7pa9bg5X3RjiGOd9
	FBvQy/yMruPvFe5FkgHHF5rnKyFyp6NOuBZ/FtENW85nt/8dlcvGU6n8TMm7a/HPbJSfMHKfMmo
	kCTpfYk5syXN3MDmf6GcPeOcMaTrC4LDm4nQDSI3wMSug0i6BryLSChg9n2Nfx0CDI1Vj/a94j7
	c+SWEelIpLSX0Z0lA+cg/zIgLdCZhzWY4dWNetkkWLU2q4hgk1DC96ambdUQaA0H+X2H45wsAmH
	dLbBE5sbbJzDiFYqTZP84aJluCdt44SbC0Ew0Lp+7T3gOuTABIEVAE5qC3bKJvgQC6cDc/R588J
	auwYjM0j6kqqZTZU433A==
X-Received: by 2002:a17:90b:3dcc:b0:340:c60b:f362 with SMTP id 98e67ed59e1d1-358ae7c6ca9mr13087754a91.6.1772012054135;
        Wed, 25 Feb 2026 01:34:14 -0800 (PST)
Received: from dw-tp ([203.81.242.210])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3590188126esm2256635a91.6.2026.02.25.01.33.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 01:34:13 -0800 (PST)
From: Ritesh Harjani (IBM) <ritesh.list@gmail.com>
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
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
	Mike Rapoport <rppt@kernel.org>, Muchun Song <muchun.song@linux.dev>, 
	Oscar Salvador <osalvador@suse.de>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Pratyush Yadav <pratyush@kernel.org>, Richard Weinberger <richard@nod.at>, 
	Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>, 
	Suren Baghdasaryan <surenb@google.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Thomas Gleixner <tglx@linutronix.de>, Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-cxl@vger.kernel.org, 
	linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, 
	linux-mips@vger.kernel.org, linux-mm@kvack.org, 
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-snps-arc@lists.infradead.org, 
	linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 24/29] arch, mm: consolidate initialization of SPARSE memory model
In-Reply-To: <20260111082105.290734-25-rppt@kernel.org>
Date: Wed, 25 Feb 2026 09:00:35 +0530
Message-ID: <87tsv5h544.ritesh.list@gmail.com>
References: <20260111082105.290734-1-rppt@kernel.org> <20260111082105.290734-25-rppt@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_093417_699409_DF2EF7E5 
X-CRM114-Status: GOOD (  17.83  )
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

> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
>
> Every architecture calls sparse_init() during setup_arch() although the
> data structures created by sparse_init() are not used until the
> initialization of the core MM.
>
> Beside the code duplication, calling sparse_init() from architecture
> specific code causes ordering differences of vmemmap and HVO initialization
> on different architectures.
>
> Move the call to sparse_init() from architecture specific code to
> free_area_init() to ensure that vmemmap and HVO initialization order is
> always the same.
>

Hello Mike,

[    0.000000][    T0] ------------[ cut here ]------------
[    0.000000][    T0] WARNING: arch/powerpc/include/asm/io.h:879 at virt_to_phys+0x44/0x1b8, CPU#0: swapper/0
[    0.000000][    T0] Modules linked in:
[    0.000000][    T0] CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.19.0-12139-gc57b1c00145a #31 PREEMPT
[    0.000000][    T0] Hardware name: IBM pSeries (emulated by qemu) POWER10 (architected) 0x801200 0xf000006 of:SLOF,git-ee03ae pSeries
[    0.000000][    T0] NIP:  c000000000601584 LR: c000000004075de4 CTR: c000000000601548
[    0.000000][    T0] REGS: c000000004d1f870 TRAP: 0700   Not tainted  (6.19.0-12139-gc57b1c00145a)
[    0.000000][    T0] MSR:  8000000000021033 <SF,ME,IR,DR,RI,LE>  CR: 48022448  XER: 20040000
[    0.000000][    T0] CFAR: c0000000006016c4 IRQMASK: 1
[    0.000000][    T0] GPR00: c000000004075dd4 c000000004d1fb10 c00000000304bb00 c000000180000000
[    0.000000][    T0] GPR04: 0000000000000009 0000000000000009 c000000004ec94a0 0000000000000000
[    0.000000][    T0] GPR08: 0000000000018000 0000000000000001 c000000004921280 0000000048022448
[    0.000000][    T0] GPR12: c000000000601548 c000000004fe0000 0000000000000004 0000000000000004
[    0.000000][    T0] GPR16: 000000000287fb08 0000000000000060 0000000000000002 0000000002831750
[    0.000000][    T0] GPR20: 0000000002831778 fffffffffffffffd c000000004d78050 00000000051cbb00
[    0.000000][    T0] GPR24: 0000000005a40008 c000000000000000 c000000000400000 0000000000000100
[    0.000000][    T0] GPR28: c000000004d78050 0000000000000000 c000000004ecd4a8 0000000000000001
[    0.000000][    T0] NIP [c000000000601584] virt_to_phys+0x44/0x1b8
[    0.000000][    T0] LR [c000000004075de4] alloc_bootmem+0x144/0x1a8
[    0.000000][    T0] Call Trace:
[    0.000000][    T0] [c000000004d1fb50] [c000000004075dd4] alloc_bootmem+0x134/0x1a8
[    0.000000][    T0] [c000000004d1fba0] [c000000004075fac] __alloc_bootmem_huge_page+0x164/0x230
[    0.000000][    T0] [c000000004d1fbe0] [c000000004030bc4] alloc_bootmem_huge_page+0x44/0x138
[    0.000000][    T0] [c000000004d1fc10] [c000000004076e48] hugetlb_hstate_alloc_pages+0x350/0x5ac
[    0.000000][    T0] [c000000004d1fd30] [c0000000040782f0] hugetlb_bootmem_alloc+0x15c/0x19c
[    0.000000][    T0] [c000000004d1fd70] [c00000000406d7b4] mm_core_init_early+0x7c/0xdf4
[    0.000000][    T0] [c000000004d1ff30] [c000000004011d84] start_kernel+0xac/0xc58
[    0.000000][    T0] [c000000004d1ffe0] [c00000000000e99c] start_here_common+0x1c/0x20
[    0.000000][    T0] Code: 6129ffff 792907c6 6529ffff 6129ffff 7c234840 40810018 3d2201e8 3929a7a8 e9290000 7c291840 41810044 3be00001 <0b1f0000> 3d20bfff 6129ffff 792907c6


I think this is happening because, now in mm_core_early_init(), the
order of initialization between hugetlb_bootmem_alloc() and
free_area_init() is reversed. Since free_area_init() -> sparse_init()
is responsible for setting SECTIONS and vmemmap area. 

Then in alloc_bootmem() (from hugetlb_bootmem_alloc() path), it uses virt_to_phys(m)...

			/*
			 * For pre-HVO to work correctly, pages need to be on
			 * the list for the node they were actually allocated
			 * from. That node may be different in the case of
			 * fallback by memblock_alloc_try_nid_raw. So,
			 * extract the actual node first.
			 */
			if (m)
				listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));


... virt_to_phys on powerpc uses:

static inline unsigned long virt_to_phys(const volatile void * address)
{
	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !virt_addr_valid(address));

	return __pa((unsigned long)address);
}

#define virt_addr_valid(vaddr)	({					\
	unsigned long _addr = (unsigned long)vaddr;			\
	_addr >= PAGE_OFFSET && _addr < (unsigned long)high_memory &&	\
	pfn_valid(virt_to_pfn((void *)_addr));				\
})


I think the above warning in dmesg gets printed from above WARN_ON, i.e.
because pfn_valid() is false, since we haven't done sparse_init() yet.

So, what I wanted to check was - do you think instead of virt_to_phys(), we
could directly use __pa() here() in mm/hugetlb.c, since these are
memblock alloc addresses? i.e.: 

// alloc_bootmem():
-   listnode = early_pfn_to_nid(PHYS_PFN(virt_to_phys(m)));
+   listnode = early_pfn_to_nid(PHYS_PFN(__pa(m)));

// __alloc_bootmem_huge_page():
-   memblock_reserved_mark_noinit(virt_to_phys((void *)m + PAGE_SIZE),
+   memblock_reserved_mark_noinit(__pa((void *)m + PAGE_SIZE),


Thoughts?

-ritesh

