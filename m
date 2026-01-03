Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60DCFFC6198
	for <linux-um@archiver.kernel.org>; Sat,  3 Jan 2026 20:32:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7o+8V3bXuMIGcHyQUku83CYs/vu8fbyRY+Gob8yvlG8=; b=HuWHojEkNnBPDKcgQITVqj7ycC
	EWPK2gpH30pq/ldusntHztT2l0YAUvVkWTro11YUkC3byZ/lU+2FPpcHFe0VDVu6449Rgn2zTzG67
	W91+VmiO9qZoNBfi8GzvAR79DEuY7A2XabS9XNNAmT3HW6JBJvmaIFv+DP/b/PKDrtPg5PzuL3M2x
	de4Rhk/8P5xuU/cI6fOkAKvwI79FijS8LF1w0pYBwU4k/5LyzI5yZgqPWQ1W2xf7B1mim7lO9CyFs
	JYsL/KjDpMi5q0CdSgCQfX8qqIDuFnNa6nzN83a8l4fBeiCqhs2AZjHcnS6gMBjYQ/Rw/up6fG1bS
	cRXW6J4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vc8Ie-00000009mKD-0vls;
	Sat, 03 Jan 2026 20:32:36 +0000
Received: from mail-lf1-x129.google.com ([2a00:1450:4864:20::129])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vc8IZ-00000009mIF-013V
	for linux-um@lists.infradead.org;
	Sat, 03 Jan 2026 20:32:33 +0000
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-5943d20f352so13720516e87.0
        for <linux-um@lists.infradead.org>; Sat, 03 Jan 2026 12:32:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1767472349; x=1768077149; darn=lists.infradead.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=7o+8V3bXuMIGcHyQUku83CYs/vu8fbyRY+Gob8yvlG8=;
        b=epCeZmj/PkTApal0cxuwgYfGm6imnXLUp9/cftnmdhAEIZQEcSNZ2wVEnye/wJgb4y
         Sok0G7Ma0bszaPUUPTcTbv84pIW9Va0efuXH6Oienhn10MsvsftIDqclOOD0suoRL9TQ
         pI3kOIDJUIhbweAkuyjKtHjsNxouJBQNBB5ouPfelpz3l/ZOLfwStBuP1oqqTgEIRAHX
         mxZANhasJpLKuMtQSckk7NrWWaiNLz8OdYrrdgzR4ZmL5UmODt80NHasdBHy+Qc/g3Qw
         NnzPr/z4oQi8uIiisoZfeOjnJ4LmeViB1eIyTFrhze5ieEzvvBSqiQfKcMzMEOQPBLLQ
         vjGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767472349; x=1768077149;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7o+8V3bXuMIGcHyQUku83CYs/vu8fbyRY+Gob8yvlG8=;
        b=PWzy51d/fZsPbCurkG/Y36eM4McjyHQPj2+FGkdKgjMzFD7FQ+DCZSoq/buLQDQcBW
         PXemufMDRbzBrzzxtIfHVcmOcqGL+jV0ilvoxT/m9ClTVThGi+pzkXoDP669ZM84XwYh
         O3N83hRzByrEIUg7EVjIG238mrEvPdDxHpreFPFLxm/0ozFU6Grbvji34VQ8KeNaE9pk
         ZYqhxpzYlbsOCrEVAG+YvmKawSrtmXdhlf1a/FOhZVFy85uY/6OLyWuc6HeCGXCdp6RE
         SX7BPKkNPYUpqi+VcsDC09Vizb38Vvc2ryYH+kranPlFbXVfg9kuDlHL9275y1Vw5nI6
         T9/w==
X-Forwarded-Encrypted: i=1; AJvYcCWHGGsYbOVKKpEAjiirXeyhq1I/6yFTXXRYzfhqjGGkYByuQartfK84uPa3ywiKm2i42xmklzeFPQ==@lists.infradead.org
X-Gm-Message-State: AOJu0YxBZWx+WdJGmowt6mZcQYhSYUT3UlW4rnt9EVJ9khtux4Im6LBm
	QbXzILNarA5ETN7yi3gA5YH6AEisQebjjswm8ngUR0SAh49bkyaoGTeO
X-Gm-Gg: AY/fxX5DBKl7kcqTgjhOEy7PHM4JZcki85XtRdZrLYlU69ngeAT33o5GJOOFbmG85k6
	UevTvKpufn7Uyp/khBlC4Q9wwi4QMp1b+sTqxw1dFIkH/fbj0Yg+jDMP+gBCZxIaQbD6nQEmd58
	7cCK8HP9fHOiru7yQ2fNE0m19Wjb13+MRQmISKzZWDDOnet56rlQmU9gm8+JBrgdURgN5Z2Bwyt
	SozHHoCGZVuC1WCTwjbyMjdaiEjAvSpLo7GLQ5MmPRI2LnG0ax6nHgQYNM4nbXbu0yljDMni3pV
	fwQ4J5YcJT8225bsfRic1A23Q/2zzaFJRuun2WAtV7hR3NbdI/aWlYpLcCnPZbcg1dwPpW8EvfW
	qbQQY86OxVQ2DMDc1bxgMQkSRVSF51jRfj8cIjAXjdMYblQWMptYD2HORMwv/11ZqvyYDmr+TYU
	jTIOVWkeCbfV/FmFisUaAD+MZ7++XEKHIF7ADTGy1YDw==
X-Google-Smtp-Source: AGHT+IEnoPR3bLjgiHz8V/D0bqIfe+KGL8qN+8iViiiSSYeZJp9K5TsXzLfWqe+YE0ZXBkQi72/slw==
X-Received: by 2002:a05:6512:401b:b0:598:fabf:afc2 with SMTP id 2adb3069b0e04-59a17d77697mr15522207e87.14.1767472348240;
        Sat, 03 Jan 2026 12:32:28 -0800 (PST)
Received: from localhost (parmesan.int.kasm.eu. [2001:678:a5c:1204:126f:f00a:513f:807b])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-59a185ddc12sm13314957e87.37.2026.01.03.12.32.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Jan 2026 12:32:27 -0800 (PST)
Date: Sat, 3 Jan 2026 21:32:26 +0100
From: Klara Modin <klarasmodin@gmail.com>
To: Mike Rapoport <rppt@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Andreas Larsson <andreas@gaisler.com>, 
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>, 
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, 
	"David S. Miller" <davem@davemloft.net>, Dave Hansen <dave.hansen@linux.intel.com>, 
	David Hildenbrand <david@kernel.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>, 
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>, 
	Ingo Molnar <mingo@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Jonathan Corbet <corbet@lwn.net>, 
	"Liam R. Howlett" <Liam.Howlett@oracle.com>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>, 
	Magnus Lindholm <linmag7@gmail.com>, Matt Turner <mattst88@gmail.com>, 
	Max Filippov <jcmvbkbc@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>, 
	Muchun Song <muchun.song@linux.dev>, Oscar Salvador <osalvador@suse.de>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Pratyush Yadav <pratyush@kernel.org>, 
	Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, 
	Stafford Horne <shorne@gmail.com>, Suren Baghdasaryan <surenb@google.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, 
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>, 
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>, x86@kernel.org, 
	linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
	loongarch@lists.linux.dev, sparclinux@vger.kernel.org
Subject: Re: [PATCH v2 22/28] arch, mm: consolidate initialization of nodes,
 zones and memory map
Message-ID: <aVlwOyicOLPB9SOa@parmesan.int.kasm.eu>
References: <20260102070005.65328-1-rppt@kernel.org>
 <20260102070005.65328-23-rppt@kernel.org>
 <aVhN2NgQEKe0yzva@soda.int.kasm.eu>
 <aVll339wim7dCIaQ@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aVll339wim7dCIaQ@kernel.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260103_123231_436635_2278DAB0 
X-CRM114-Status: GOOD (  52.04  )
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

Hi,

On 2026-01-03 20:54:23 +0200, Mike Rapoport wrote:
> Hi,
> 
> On Sat, Jan 03, 2026 at 12:33:29AM +0100, Klara Modin wrote:
> > On 2026-01-02 08:59:58 +0200, Mike Rapoport wrote:
> > > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > > 
> > > To initialize node, zone and memory map data structures every architecture
> > > calls free_area_init() during setup_arch() and passes it an array of zone
> > > limits.
> > > 
> > > Beside code duplication it creates "interesting" ordering cases between
> > > allocation and initialization of hugetlb and the memory map. Some
> > > architectures allocate hugetlb pages very early in setup_arch() in certain
> > > cases, some only create hugetlb CMA areas in setup_arch() and sometimes
> > > hugetlb allocations happen mm_core_init().
> > > 
> > > With arch_zone_limits_init() helper available now on all architectures it
> > > is no longer necessary to call free_area_init() from architecture setup
> > > code. Rather core MM initialization can call arch_zone_limits_init() in a
> > > single place.
> > > 
> > > This allows to unify ordering of hugetlb vs memory map allocation and
> > > initialization.
> > > 
> > > Remove the call to free_area_init() from architecture specific code and
> > > place it in a new mm_core_init_early() function that is called immediately
> > > after setup_arch().
> > > 
> > > After this refactoring it is possible to consolidate hugetlb allocations
> > > and eliminate differences in ordering of hugetlb and memory map
> > > initialization among different architectures.
> > > 
> > > As the first step of this consolidation move hugetlb_bootmem_alloc() to
> > > mm_core_early_init().
> > > 
> > > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > 
> > This breaks boot on my Raspberry Pi 1. The reason seems to be the use of
> > page_folio() when initializing the dynamically allocated zero page in
> > arm, which doesn't work when free_area_init() hasn't been called yet.
> 
> I believe the reason is rather the use of virt_to_phys() that now happens
> before the memory map is ready.
> 

Right, that makes sense, the fault just becomes apparent when
page_folio() is called on some bogus address then?

> > The following oopses are generated:
> > 
> >  8<--- cut here ---
> >  Unable to handle kernel paging request at virtual address 003dfb44 when read
> >  [003dfb44] *pgd=00000000
> >  Internal error: Oops: 5 [#1] ARM
> >  CPU: 0 UID: 0 PID: 0 Comm: swapper Not tainted 6.19.0-rc3-03898-g7975b0084358 #451 NONE
> >  Hardware name: BCM2835
> >  PC is at paging_init (include/linux/page-flags.h:284 (discriminator 2) arch/arm/mm/mmu.c:1790 (discriminator 2))
> >  LR is at paging_init (arch/arm/mm/mmu.c:1789 (discriminator 1))
> 
> ...
> 
> >  8<--- cut here ---
> > 
> > and the second one repeats for some time afterwards.
> > 
> > I experimented a little by allocating the zero page statically as many
> > other arches do which fixes the issue as it does not need to be
> > initialized at this point anymore, though I have no idea if that's
> > appropriate.
> 
> Do you mean putting the zero in the BSS like, e.g. arm64? I don't see a
> reason why this shouldn't work.
> 

Yes, exactly that. The diff I had was:

diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
index 86378eec7757..6fa9acd6a7f5 100644
--- a/arch/arm/include/asm/pgtable.h
+++ b/arch/arm/include/asm/pgtable.h
@@ -15,8 +15,8 @@
  * ZERO_PAGE is a global shared page that is always zero: used
  * for zero-mapped memory areas etc..
  */
-extern struct page *empty_zero_page;
-#define ZERO_PAGE(vaddr)	(empty_zero_page)
+extern unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)];
+#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
 #endif
 
 #include <asm-generic/pgtable-nopud.h>
diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
index 8bac96e205ac..518def8314e7 100644
--- a/arch/arm/mm/mmu.c
+++ b/arch/arm/mm/mmu.c
@@ -45,7 +45,7 @@ extern unsigned long __atags_pointer;
  * empty_zero_page is a special page that is used for
  * zero-initialized data and COW.
  */
-struct page *empty_zero_page;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 /*
@@ -1754,8 +1754,6 @@ static void __init early_fixmap_shutdown(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
-	void *zero_page;
-
 #ifdef CONFIG_XIP_KERNEL
 	/* Store the kernel RW RAM region start/end in these variables */
 	kernel_sec_start = CONFIG_PHYS_OFFSET & SECTION_MASK;
@@ -1781,13 +1779,7 @@ void __init paging_init(const struct machine_desc *mdesc)
 
 	top_pmd = pmd_off_k(0xffff0000);
 
-	/* allocate the zero page. */
-	zero_page = early_alloc(PAGE_SIZE);
-
 	bootmem_init();
-
-	empty_zero_page = virt_to_page(zero_page);
-	__flush_dcache_folio(NULL, page_folio(empty_zero_page));
 }
 
 void __init early_mm_init(const struct machine_desc *mdesc)
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index d638cc87807e..7e42d8accec6 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -31,7 +31,7 @@ unsigned long vectors_base;
  * empty_zero_page is a special page that is used for
  * zero-initialized data and COW.
  */
-struct page *empty_zero_page;
+unsigned long empty_zero_page[PAGE_SIZE / sizeof(unsigned long)] __page_aligned_bss;
 EXPORT_SYMBOL(empty_zero_page);
 
 #ifdef CONFIG_ARM_MPU
@@ -156,18 +156,10 @@ void __init adjust_lowmem_bounds(void)
  */
 void __init paging_init(const struct machine_desc *mdesc)
 {
-	void *zero_page;
-
 	early_trap_init((void *)vectors_base);
 	mpu_setup();
 
-	/* allocate the zero page. */
-	zero_page = (void *)memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
-
 	bootmem_init();
-
-	empty_zero_page = virt_to_page(zero_page);
-	flush_dcache_page(empty_zero_page);
 }
 
 /*

> I also have a patch with some minor changes that still keeps
> empty_zero_page allocated, but avoids virt_to_page() and folio_page()
> dance. Can you please test it in your setup?
> 
> From 8a213c13211106d592fbe96b68ee29879ed739f8 Mon Sep 17 00:00:00 2001
> From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> Date: Sat, 3 Jan 2026 20:40:09 +0200
> Subject: [PATCH] arm: make initialization of zero page independent of the
>  memory map
> 
> Unlike most architectures, arm keeps a struct page pointer to the
> empty_zero_page and to initialize it requires conversion of a virtual
> address to page which makes it necessary to have memory map initialized
> before creating the empty_zero_page.
> 
> Make empty_zero_page a void * to decouple it's initialization from the
> initialization of the memory map.
> 
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/arm/include/asm/pgtable.h |  4 ++--
>  arch/arm/mm/mmu.c              | 10 +++-------
>  arch/arm/mm/nommu.c            | 10 +++-------
>  3 files changed, 8 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/arm/include/asm/pgtable.h b/arch/arm/include/asm/pgtable.h
> index 86378eec7757..08bbd2aed6c9 100644
> --- a/arch/arm/include/asm/pgtable.h
> +++ b/arch/arm/include/asm/pgtable.h
> @@ -15,8 +15,8 @@
>   * ZERO_PAGE is a global shared page that is always zero: used
>   * for zero-mapped memory areas etc..
>   */
> -extern struct page *empty_zero_page;
> -#define ZERO_PAGE(vaddr)	(empty_zero_page)
> +extern void *empty_zero_page;
> +#define ZERO_PAGE(vaddr)	(virt_to_page(empty_zero_page))
>  #endif
>  
>  #include <asm-generic/pgtable-nopud.h>
> diff --git a/arch/arm/mm/mmu.c b/arch/arm/mm/mmu.c
> index 8bac96e205ac..867258f1ae09 100644
> --- a/arch/arm/mm/mmu.c
> +++ b/arch/arm/mm/mmu.c
> @@ -45,7 +45,7 @@ extern unsigned long __atags_pointer;
>   * empty_zero_page is a special page that is used for
>   * zero-initialized data and COW.
>   */
> -struct page *empty_zero_page;
> +void *empty_zero_page;
>  EXPORT_SYMBOL(empty_zero_page);
>  
>  /*
> @@ -1754,8 +1754,6 @@ static void __init early_fixmap_shutdown(void)
>   */
>  void __init paging_init(const struct machine_desc *mdesc)
>  {
> -	void *zero_page;
> -
>  #ifdef CONFIG_XIP_KERNEL
>  	/* Store the kernel RW RAM region start/end in these variables */
>  	kernel_sec_start = CONFIG_PHYS_OFFSET & SECTION_MASK;
> @@ -1782,12 +1780,10 @@ void __init paging_init(const struct machine_desc *mdesc)
>  	top_pmd = pmd_off_k(0xffff0000);
>  
>  	/* allocate the zero page. */
> -	zero_page = early_alloc(PAGE_SIZE);
> +	empty_zero_page = early_alloc(PAGE_SIZE);
> +	__cpuc_flush_dcache_area(empty_zero_page, PAGE_SIZE);
>  
>  	bootmem_init();
> -
> -	empty_zero_page = virt_to_page(zero_page);
> -	__flush_dcache_folio(NULL, page_folio(empty_zero_page));
>  }
>  
>  void __init early_mm_init(const struct machine_desc *mdesc)
> diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
> index d638cc87807e..f80ff5a69fbb 100644
> --- a/arch/arm/mm/nommu.c
> +++ b/arch/arm/mm/nommu.c
> @@ -31,7 +31,7 @@ unsigned long vectors_base;
>   * empty_zero_page is a special page that is used for
>   * zero-initialized data and COW.
>   */
> -struct page *empty_zero_page;
> +void *empty_zero_page;
>  EXPORT_SYMBOL(empty_zero_page);
>  
>  #ifdef CONFIG_ARM_MPU
> @@ -156,18 +156,14 @@ void __init adjust_lowmem_bounds(void)
>   */
>  void __init paging_init(const struct machine_desc *mdesc)
>  {
> -	void *zero_page;
> -
>  	early_trap_init((void *)vectors_base);
>  	mpu_setup();
>  
>  	/* allocate the zero page. */
> -	zero_page = (void *)memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
> +	empty_zero_page = memblock_alloc_or_panic(PAGE_SIZE, PAGE_SIZE);
> +	__cpuc_flush_dcache_area(empty_zero_page, PAGE_SIZE);
>  
>  	bootmem_init();
> -
> -	empty_zero_page = virt_to_page(zero_page);
> -	flush_dcache_page(empty_zero_page);
>  }
>  
>  /*
> -- 
> 2.51.0
> 

This also works for me.

Thanks,
Tested-by: Klara Modin <klarasmodin@gmail.com>

>  
> > Regards,
> > Klara Modin
> > 
> 
> -- 
> Sincerely yours,
> Mike.

