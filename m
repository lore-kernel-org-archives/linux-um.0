Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C63D715E2
	for <linux-um@archiver.kernel.org>; Sat, 24 Jan 2026 10:16:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=W/5NPMb0LZF5TbTdERpsT57n+ZMmWhyHLzllN9jVgX4=; b=RiTnUn5T03nbW7hAMmvzF+aev0
	rLF3T0CZKxhhxzPL3MwGmfSG2rjA/35R2Y9VKLqrCjkRK8eAJmja6S+5rKS+2l0pHTZjCSuqPGcLR
	Z5jd9Y/EdpOZQPNs52yLOr2oZuhetyFQOfhU/rXfFbMRsPPq74+AsUMIiAHS7Sad74eK4ym0AhEEp
	voGcO6uRnGf4n6C0h14DS/LFd1ffj8bR4EDHhVxDHcm3tUm5KYNDAoaU0sf6jDIiAPCssq2TnurGc
	1UqcKr2B7ofXjgLxD/RI2XGs0AoB/ExNu/+Pt5o7G9ExlkIVbrlm4DMI6G3Err1upWzXR0g3QrzBQ
	4gyy522g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjagZ-0000000A9Ld-00Vt;
	Sat, 24 Jan 2026 10:16:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vjagV-0000000A9Kz-1UWB;
	Sat, 24 Jan 2026 10:16:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7ED6843C9A;
	Sat, 24 Jan 2026 10:16:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1D83BC116D0;
	Sat, 24 Jan 2026 10:15:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769249762;
	bh=UPTxfV10NFGsFNMLbllwwGihhByrD9Chz5Ya/aU4aSQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=BG+9wd2ovrMG5pu7KsxBmuHPlYw48y+qEQuXSOmuaQ786O9ubyptVjzd3TPikqKEV
	 MtPvuwrKZtwGgD5G4X1PGRfnjjFohKmYb3O3Y4u5BFFb01X2hKPytrs6tuQ52Dm9nS
	 fmDIq7vs8J8McangAIFv826LCzRZLNgtf/9d3q8GVASVYzXNiEOedwA61U/TSPBRLw
	 B/uNVy9iMafbxhVtHeEUGbMQNxTqlAJ8n51n6Tyk+R2myqLHAu834xSBnmo1UVELl7
	 eeika37+zLOWSlLAtg5QwuglP1fRf1menyZ0BPn8+f6CDzm2bJ29YHmoNsPqWpbZ5/
	 er2PErNhz4kjQ==
Message-ID: <02784e9a-d934-44c3-ae24-a83a1bcf678d@kernel.org>
Date: Sat, 24 Jan 2026 11:15:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH mm-unstable] arch, mm: consolidate empty_zero_page
To: Mike Rapoport <rppt@kernel.org>, Andrew Morton <akpm@linux-foundation.org>
Cc: Andreas Larsson <andreas@gaisler.com>, Borislav Petkov <bp@alien8.de>,
 Brian Cain <bcain@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>,
 "David S. Miller" <davem@davemloft.net>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
 Palmer Dabbelt <palmer@dabbelt.com>, Richard Weinberger <richard@nod.at>,
 Russell King <linux@armlinux.org.uk>, Stafford Horne <shorne@gmail.com>,
 Suren Baghdasaryan <surenb@google.com>, Thomas Gleixner <tglx@kernel.org>,
 Vineet Gupta <vgupta@kernel.org>, Vlastimil Babka <vbabka@suse.cz>,
 Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-sh@vger.kernel.org,
 sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
 linux-mm@kvack.org, x86@kernel.org
References: <20260124095628.668870-1-rppt@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260124095628.668870-1-rppt@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260124_021603_478582_C87B7B25 
X-CRM114-Status: GOOD (  19.42  )
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



Le 24/01/2026 à 10:56, Mike Rapoport a écrit :
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> 
> Reduce 22 declarations of empty_zero_page to 3 and 23 declarations of
> ZERO_PAGE() to 4.
> 
> Every architecture defines empty_zero_page that way or another, but for the
> most of them it is always a page aligned page in BSS and most definitions
> of ZERO_PAGE do virt_to_page(empty_zero_page).
> 
> Move Linus vetted x86 definition of empty_zero_page and ZERO_PAGE() to the
> core MM and drop these definitions in architectures that do not implement
> colored zero page (MIPS and s390).
> 
> ZERO_PAGE() remains a macro because turning it to a wrapper for a static
> inline causes severe pain in header dependencies.
> 
> For the most part the change is mechanical, with these being noteworthy:
> 
> * alpha: aliased empty_zero_page with ZERO_PGE that was also used for boot
>    parameters. Switching to a generic empty_zero_page removes the aliasing
>    and keeps ZERO_PGE for boot parameters only
> * arm64: uses __pa_symbol() in ZERO_PAGE() so that definition of
>    ZERO_PAGE() is kept intact.
> * m68k/parisc/sparc64/um: allocated empty_zero_page from memblock,
>    although they do not support zero page coloring and having it in BSS
>    will work fine.
> * sh: used empty_zero_page for boot parameters at the very early boot.
>    Rename the parameters page to boot_params_page and let sh use the generic
>    empty_zero_page.
> * hexagon: had an amusing comment about empty_zero_page
> 
> 	/* A handy thing to have if one has the RAM. Declared in head.S */
> 
>    that unfortunately had to go :)
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>   arch/alpha/include/asm/pgtable.h          |  6 ------
>   arch/arc/include/asm/pgtable.h            |  3 ---
>   arch/arc/mm/init.c                        |  2 --
>   arch/arm/include/asm/pgtable.h            |  9 ---------
>   arch/arm/mm/mmu.c                         |  7 -------
>   arch/arm/mm/nommu.c                       |  7 -------
>   arch/arm64/include/asm/pgtable.h          |  1 -
>   arch/arm64/mm/mmu.c                       |  7 -------
>   arch/csky/include/asm/pgtable.h           |  3 ---
>   arch/csky/mm/init.c                       |  3 ---
>   arch/hexagon/include/asm/pgtable.h        |  6 ------
>   arch/hexagon/kernel/head.S                |  5 -----
>   arch/hexagon/kernel/hexagon_ksyms.c       |  1 -
>   arch/loongarch/include/asm/pgtable.h      |  9 ---------
>   arch/loongarch/mm/init.c                  |  3 ---
>   arch/m68k/include/asm/pgtable_mm.h        |  9 ---------
>   arch/m68k/include/asm/pgtable_no.h        |  7 -------
>   arch/m68k/mm/init.c                       |  9 ---------
>   arch/m68k/mm/mcfmmu.c                     |  2 --
>   arch/m68k/mm/motorola.c                   |  6 ------
>   arch/m68k/mm/sun3mmu.c                    |  2 --
>   arch/microblaze/include/asm/pgtable.h     | 10 ----------
>   arch/microblaze/kernel/head.S             |  4 ----
>   arch/microblaze/kernel/microblaze_ksyms.c |  2 --
>   arch/nios2/include/asm/pgtable.h          |  7 -------
>   arch/nios2/kernel/head.S                  | 10 ----------
>   arch/nios2/kernel/nios2_ksyms.c           |  1 -
>   arch/openrisc/include/asm/pgtable.h       |  4 ----
>   arch/openrisc/kernel/head.S               |  3 ---
>   arch/openrisc/kernel/or32_ksyms.c         |  1 -
>   arch/openrisc/mm/init.c                   |  3 ---
>   arch/parisc/include/asm/pgtable.h         | 11 -----------
>   arch/parisc/mm/init.c                     |  6 ------
>   arch/powerpc/include/asm/pgtable.h        |  6 ------
>   arch/powerpc/mm/mem.c                     |  3 ---

For powerpc:

Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>

>   arch/riscv/include/asm/pgtable.h          |  7 -------
>   arch/riscv/mm/init.c                      |  4 ----
>   arch/sh/include/asm/pgtable.h             |  8 --------
>   arch/sh/include/asm/setup.h               |  3 ++-
>   arch/sh/kernel/head_32.S                  |  4 ++--
>   arch/sh/kernel/sh_ksyms_32.c              |  1 -
>   arch/sh/mm/init.c                         |  1 -
>   arch/sparc/include/asm/pgtable_32.h       |  8 --------
>   arch/sparc/include/asm/pgtable_64.h       |  3 ---
>   arch/sparc/include/asm/setup.h            |  2 --
>   arch/sparc/kernel/head_32.S               |  7 -------
>   arch/sparc/mm/init_32.c                   |  4 ----
>   arch/sparc/mm/init_64.c                   | 15 ---------------
>   arch/um/include/asm/pgtable.h             |  9 ---------
>   arch/um/include/shared/kern_util.h        |  1 -
>   arch/um/kernel/mem.c                      | 16 ----------------
>   arch/um/kernel/um_arch.c                  |  1 -
>   arch/x86/include/asm/pgtable.h            |  8 --------
>   arch/x86/kernel/head_32.S                 |  4 ----
>   arch/x86/kernel/head_64.S                 |  7 -------
>   arch/xtensa/include/asm/pgtable.h         |  4 ----
>   arch/xtensa/kernel/head.S                 |  3 ---
>   arch/xtensa/kernel/xtensa_ksyms.c         |  2 --
>   include/linux/pgtable.h                   |  8 ++++++++
>   mm/mm_init.c                              |  9 +++++++++
>   60 files changed, 21 insertions(+), 296 deletions(-)
> 

