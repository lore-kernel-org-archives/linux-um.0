Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EA6610BA439
	for <linux-um@archiver.kernel.org>; Fri, 27 Mar 2026 08:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=OzrpGpkHqWUx/eMcJ1jKlsZ1lwKvENOYTWoZ0OfZ1qw=; b=oyC3WLQN+2NkSx3BP0H9Uio/iQ
	za3zUEEA8pZOA29Uz92vYbYV501W4FxCwZaROjP5vMzoNJ6UxcDVOJVGyexobchwHyy36gtUHwFBK
	jInqfwA7Zs8orKT0BuUpozMMIrLzbagRe/NgdRw3zj5G6BF7KdVPUsbBr6DmOaJYEfXHKNXMlnhNV
	I824Yldi2odwZKk/G9sEw0AQO69LSGevR0Q9T1FFh8FYEmfTcfP9mqYKy6xZEfjxfx/57v+g2RFyZ
	3f7vSxu9/IAP3qG4iPn7vOpPqEV6L+cxthVOs0YU8BEBzGSVhj56VkXCLaLTO33/GBV2ZgcpiSx6L
	UU25/Lkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w62NQ-00000006wzk-22Vq;
	Fri, 27 Mar 2026 08:17:08 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w62NN-00000006wxN-1roI;
	Fri, 27 Mar 2026 08:17:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=References:Content-Type:
	Content-Transfer-Encoding:In-Reply-To:From:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Sender:Reply-To:Content-ID:Content-Description;
	bh=OzrpGpkHqWUx/eMcJ1jKlsZ1lwKvENOYTWoZ0OfZ1qw=; b=JryILBKDdsH5d+p6jgXrV73VMS
	Us+KEaGCj0SntivEmtjWvodCvjsVVTdKc/JzQTH9MqFUL9qz7PpQYd/mhgp8q/ZPwt6en4nmRDBCB
	yl1oTyH6Gl9GTca6OWgxiN2/nO3RFyYSBRGEgXPiGkI662j5HW7fXUPqD66+ZuwDoxbIxhYHYPOGA
	xi64wBBS8w7AdL1ePJA//LwzulwQzLsQtrE9h9rLHXT/Q+lFM7KDUqxEqD+zTgUzzqSt7++BfLxJ8
	0HZogAW9YbfwwCqECqmTlb9oEl78BpGtlVSxyvNB+1jSrKJOq4jMGOuivNGKE3LbaeS2sMGShW2i7
	WLd0vT+A==;
Received: from mailout1.w1.samsung.com ([210.118.77.11])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w62NJ-00000009wr3-2ud5;
	Fri, 27 Mar 2026 08:17:03 +0000
Received: from eucas1p1.samsung.com (unknown [182.198.249.206])
	by mailout1.w1.samsung.com (KnoxPortal) with ESMTP id 20260327081656euoutp0159ffbf0a635c1b7e11620b7d0f98b0d3~gpMRSEAKq0448704487euoutp010;
	Fri, 27 Mar 2026 08:16:56 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout1.w1.samsung.com 20260327081656euoutp0159ffbf0a635c1b7e11620b7d0f98b0d3~gpMRSEAKq0448704487euoutp010
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1774599416;
	bh=OzrpGpkHqWUx/eMcJ1jKlsZ1lwKvENOYTWoZ0OfZ1qw=;
	h=Date:Subject:To:Cc:From:In-Reply-To:References:From;
	b=hYym+IrJIbRVHQG1K2UWuA0h9Vy29fYkdvIs8yKDeB0yJ5xCqXBaCsZmHZBarhjQg
	 OCISHCnKlHEu/bJerBpD0vdOwTGPrgXPwT20DQxx9+LqEwPiyD9mT1YPKzcY4kn8L2
	 Iz4H4PewEUdxdr5cQTnZYxMoNHTZIAFMZduYpLGg=
Received: from eusmtip2.samsung.com (unknown [203.254.199.222]) by
	eucas1p2.samsung.com (KnoxPortal) with ESMTPA id
	20260327081656eucas1p2369161b823605f46f83f110ed6d23a01~gpMRDRogp1270412704eucas1p2M;
	Fri, 27 Mar 2026 08:16:56 +0000 (GMT)
Received: from [106.210.134.192] (unknown [106.210.134.192]) by
	eusmtip2.samsung.com (KnoxPortal) with ESMTPA id
	20260327081653eusmtip255f1b4030f7274a851dfc4787d135774~gpMOrILMZ2779627796eusmtip2C;
	Fri, 27 Mar 2026 08:16:53 +0000 (GMT)
Message-ID: <9a19ccac-f7ce-4780-a251-f69a1fa45757@samsung.com>
Date: Fri, 27 Mar 2026 09:16:52 +0100
MIME-Version: 1.0
User-Agent: Betterbird (Windows)
Subject: Re: [PATCH v2 0/3] Inline helpers into Rust without full LTO
To: Arnd Bergmann <arnd@arndb.de>, Miguel Ojeda <ojeda@kernel.org>, Robin
	Murphy <robin.murphy@arm.com>, Danilo Krummrich <dakr@kernel.org>, Abdiel
	Janulgue <abdiel.janulgue@gmail.com>, Daniel Almeida
	<daniel.almeida@collabora.com>, Andreas Hindborg <a.hindborg@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Cc: iommu@lists.linux.dev, driver-core@lists.linux.dev, acourbot@nvidia.com,
	Andrew Morton <akpm@linux-foundation.org>, Alice Ryhl
	<aliceryhl@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	=?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>, Boqun Feng
	<boqun.feng@gmail.com>, David Gow <david@davidgow.net>, Gary Guo
	<gary@garyguo.net>, Johannes Berg <johannes@sipsolutions.net>, Justin Stitt
	<justinstitt@google.com>, linux-arm-kernel@lists.infradead.org,
	linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-mm@kvack.org, linux-um@lists.infradead.org, Russell King
	<linux@armlinux.org.uk>, llvm@lists.linux.dev, Benno Lossin
	<lossin@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	mmaurer@google.com, Bill Wendling <morbo@google.com>, Nathan Chancellor
	<nathan@kernel.org>, Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Nicolas Schier <nicolas.schier@linux.dev>, Nicolas Schier <nsc@kernel.org>,
	Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>,
	rust-for-linux@vger.kernel.org, Trevor Gross <tmgross@umich.edu>,
	"Uladzislau Rezki (Sony)" <urezki@gmail.com>, Will Deacon <will@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>
Content-Language: en-US
From: Marek Szyprowski <m.szyprowski@samsung.com>
In-Reply-To: <7ad8bdf9-5eff-4443-ad15-c05355d793d1@app.fastmail.com>
Content-Transfer-Encoding: 7bit
X-CMS-MailID: 20260327081656eucas1p2369161b823605f46f83f110ed6d23a01
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-RootMTR: 20260326211326eucas1p28e4e09d74d0798124d3dd5943b5b4c83
X-EPHeader: CA
X-CMS-RootMailID: 20260326211326eucas1p28e4e09d74d0798124d3dd5943b5b4c83
References: <20260322192159.88138-1-ojeda@kernel.org>
	<20260322194616.89847-1-ojeda@kernel.org>
	<CGME20260326211326eucas1p28e4e09d74d0798124d3dd5943b5b4c83@eucas1p2.samsung.com>
	<7ad8bdf9-5eff-4443-ad15-c05355d793d1@app.fastmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_081702_139337_3F6593BC 
X-CRM114-Status: GOOD (  30.20  )
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

On 26.03.2026 22:12, Arnd Bergmann wrote:
> On Sun, Mar 22, 2026, at 20:46, Miguel Ojeda wrote:
>> On Sun, 22 Mar 2026 20:21:59 +0100 Miguel Ojeda <ojeda@kernel.org> wrote:
>>        BINDGEN rust/bindings/bindings_generated.rs - due to target
>> missing
>>      In file included from rust/helpers/helpers.c:59:
>>      rust/helpers/dma.c:17:2: warning: static function 'dma_free_attrs'
>> is used in an inline function with external linkage [-Wstatic-in-inline]
>>         17 |         dma_free_attrs(dev, size, cpu_addr, dma_handle,
>> attrs);
>>            |         ^
>>      rust/helpers/dma.c:12:1: note: use 'static' to give inline function
>> 'rust_helper_dma_free_attrs' internal linkage
>>         12 | __rust_helper void rust_helper_dma_free_attrs(struct device
>> *dev, size_t size,
>>            | ^
>>            | static
>>
>> For some reason, `dma_free_attrs` is not marked `inline` in
>> `include/linux/dma-mapping.h` to begin with, unlike the rest.
>>
>> Unless I am missing something and there is a reason for that, it looks
>> like it has just been missing since it was added in commit ed6ccf10f24b
>> ("dma-mapping: properly stub out the DMA API for !CONFIG_HAS_DMA").
>>
>> Do you want a patch?
> I have an older patch to drop CONFIG_NO_DMA entirely, which
> may be better here, since we know that nobody cares about the
> empty stubs.

The inline fix is already merged to v7.0-rc, but I'm fine with stubs 
removal and I can queue them to -next. Could You send a proper patch 
separately so I can easily apply it?


> The only targets that 'select NO_DMA' today are m68k (sun3
> and dragonball), sh2 and um, which are some of the targets
> that don't have any DMA masters, but there is little downside
> of enabling the DMA mapping interfaces on those as well.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>
> diff --git a/arch/m68k/Kconfig b/arch/m68k/Kconfig
> index 11835eb59d94..19fb556357fc 100644
> --- a/arch/m68k/Kconfig
> +++ b/arch/m68k/Kconfig
> @@ -38,7 +38,6 @@ config M68K
>   	select MMU_GATHER_NO_RANGE if MMU
>   	select MODULES_USE_ELF_REL
>   	select MODULES_USE_ELF_RELA
> -	select NO_DMA if !MMU && !COLDFIRE
>   	select OLD_SIGACTION
>   	select OLD_SIGSUSPEND3
>   	select UACCESS_MEMCPY if !MMU
> diff --git a/arch/m68k/Kconfig.cpu b/arch/m68k/Kconfig.cpu
> index c9a7e602d8a4..adc50396b87d 100644
> --- a/arch/m68k/Kconfig.cpu
> +++ b/arch/m68k/Kconfig.cpu
> @@ -38,7 +38,6 @@ config SUN3
>   	depends on MMU
>   	select HAVE_ARCH_PFN_VALID
>   	select LEGACY_TIMER_TICK
> -	select NO_DMA
>   	select M68020
>   	help
>   	  This option enables support for the Sun 3 series of workstations
> @@ -558,4 +557,4 @@ config COLDFIRE_COHERENT_DMA
>   config M68K_NONCOHERENT_DMA
>   	bool
>   	default y
> -	depends on HAS_DMA && !COLDFIRE_COHERENT_DMA
> +	depends on HAS_DMA && !COLDFIRE_COHERENT_DMA && !SUN3
> diff --git a/arch/m68k/include/asm/pgtable_mm.h b/arch/m68k/include/asm/pgtable_mm.h
> index 7501ff030c63..d095ae6c19f9 100644
> --- a/arch/m68k/include/asm/pgtable_mm.h
> +++ b/arch/m68k/include/asm/pgtable_mm.h
> @@ -159,8 +159,10 @@ static inline void update_mmu_cache_range(struct vm_fault *vmf,
>   	    ? (__pgprot((pgprot_val(prot) & _CACHEMASK040) | _PAGE_NOCACHE_S))	\
>   	    : (prot)))
>   
> +#ifndef CONFIG_SUN3
>   pgprot_t pgprot_dmacoherent(pgprot_t prot);
>   #define pgprot_dmacoherent(prot)	pgprot_dmacoherent(prot)
> +#endif
>   
>   #endif /* CONFIG_COLDFIRE */
>   #endif /* !__ASSEMBLER__ */
> diff --git a/arch/m68k/kernel/dma.c b/arch/m68k/kernel/dma.c
> index 16063783aa80..c52584e024af 100644
> --- a/arch/m68k/kernel/dma.c
> +++ b/arch/m68k/kernel/dma.c
> @@ -8,7 +8,7 @@
>   #include <linux/kernel.h>
>   #include <asm/cacheflush.h>
>   
> -#ifndef CONFIG_COLDFIRE
> +#if !defined(CONFIG_COLDFIRE) && !defined(CONFIG_SUN3)
>   void arch_dma_prep_coherent(struct page *page, size_t size)
>   {
>   	cache_push(page_to_phys(page), size);
> diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
> index d5795067befa..e246f295ec48 100644
> --- a/arch/sh/Kconfig
> +++ b/arch/sh/Kconfig
> @@ -63,7 +63,6 @@ config SUPERH
>   	select LOCK_MM_AND_FIND_VMA
>   	select MODULES_USE_ELF_RELA
>   	select NEED_SG_DMA_LENGTH
> -	select NO_DMA if !MMU && !DMA_COHERENT
>   	select NO_GENERIC_PCI_IOPORT_MAP if PCI
>   	select OLD_SIGACTION
>   	select OLD_SIGSUSPEND
> @@ -133,10 +132,10 @@ config SWAP_IO_SPACE
>   	bool
>   
>   config DMA_COHERENT
> -	bool
> +	def_bool !MMU
>   
>   config DMA_NONCOHERENT
> -	def_bool !NO_DMA && !DMA_COHERENT
> +	def_bool !DMA_COHERENT
>   	select ARCH_HAS_DMA_PREP_COHERENT
>   	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
>   	select DMA_DIRECT_REMAP
> diff --git a/arch/um/Kconfig b/arch/um/Kconfig
> index 098cda44db22..dd3428a49614 100644
> --- a/arch/um/Kconfig
> +++ b/arch/um/Kconfig
> @@ -25,7 +25,6 @@ config UML
>   	select HAVE_DEBUG_KMEMLEAK
>   	select HAVE_DEBUG_BUGVERBOSE
>   	select HAVE_PAGE_SIZE_4KB
> -	select NO_DMA if !UML_DMA_EMULATION
>   	select OF_EARLY_FLATTREE if OF
>   	select GENERIC_IRQ_SHOW
>   	select GENERIC_CPU_DEVICES
> diff --git a/include/linux/dma-mapping.h b/include/linux/dma-mapping.h
> index 677c51ab7510..a96a22f857f1 100644
> --- a/include/linux/dma-mapping.h
> +++ b/include/linux/dma-mapping.h
> @@ -138,7 +138,6 @@ static inline void debug_dma_map_single(struct device *dev, const void *addr,
>   }
>   #endif /* CONFIG_DMA_API_DEBUG */
>   
> -#ifdef CONFIG_HAS_DMA
>   static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
>   {
>   	debug_dma_mapping_error(dev, dma_addr);
> @@ -200,146 +199,6 @@ void *dma_vmap_noncontiguous(struct device *dev, size_t size,
>   void dma_vunmap_noncontiguous(struct device *dev, void *vaddr);
>   int dma_mmap_noncontiguous(struct device *dev, struct vm_area_struct *vma,
>   		size_t size, struct sg_table *sgt);
> -#else /* CONFIG_HAS_DMA */
> -static inline dma_addr_t dma_map_page_attrs(struct device *dev,
> -		struct page *page, size_t offset, size_t size,
> -		enum dma_data_direction dir, unsigned long attrs)
> -{
> -	return DMA_MAPPING_ERROR;
> -}
> -static inline void dma_unmap_page_attrs(struct device *dev, dma_addr_t addr,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -}
> -static inline dma_addr_t dma_map_phys(struct device *dev, phys_addr_t phys,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -	return DMA_MAPPING_ERROR;
> -}
> -static inline void dma_unmap_phys(struct device *dev, dma_addr_t addr,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -}
> -static inline unsigned int dma_map_sg_attrs(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	return 0;
> -}
> -static inline void dma_unmap_sg_attrs(struct device *dev,
> -		struct scatterlist *sg, int nents, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -}
> -static inline int dma_map_sgtable(struct device *dev, struct sg_table *sgt,
> -		enum dma_data_direction dir, unsigned long attrs)
> -{
> -	return -EOPNOTSUPP;
> -}
> -static inline dma_addr_t dma_map_resource(struct device *dev,
> -		phys_addr_t phys_addr, size_t size, enum dma_data_direction dir,
> -		unsigned long attrs)
> -{
> -	return DMA_MAPPING_ERROR;
> -}
> -static inline void dma_unmap_resource(struct device *dev, dma_addr_t addr,
> -		size_t size, enum dma_data_direction dir, unsigned long attrs)
> -{
> -}
> -static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
> -{
> -	return -ENOMEM;
> -}
> -static inline void *dma_alloc_attrs(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t flag, unsigned long attrs)
> -{
> -	return NULL;
> -}
> -static inline void dma_free_attrs(struct device *dev, size_t size,
> -		void *cpu_addr, dma_addr_t dma_handle, unsigned long attrs)
> -{
> -}
> -static inline void *dmam_alloc_attrs(struct device *dev, size_t size,
> -		dma_addr_t *dma_handle, gfp_t gfp, unsigned long attrs)
> -{
> -	return NULL;
> -}
> -static inline void dmam_free_coherent(struct device *dev, size_t size,
> -		void *vaddr, dma_addr_t dma_handle)
> -{
> -}
> -static inline int dma_get_sgtable_attrs(struct device *dev,
> -		struct sg_table *sgt, void *cpu_addr, dma_addr_t dma_addr,
> -		size_t size, unsigned long attrs)
> -{
> -	return -ENXIO;
> -}
> -static inline int dma_mmap_attrs(struct device *dev, struct vm_area_struct *vma,
> -		void *cpu_addr, dma_addr_t dma_addr, size_t size,
> -		unsigned long attrs)
> -{
> -	return -ENXIO;
> -}
> -static inline bool dma_can_mmap(struct device *dev)
> -{
> -	return false;
> -}
> -static inline bool dma_pci_p2pdma_supported(struct device *dev)
> -{
> -	return false;
> -}
> -static inline int dma_set_mask(struct device *dev, u64 mask)
> -{
> -	return -EIO;
> -}
> -static inline int dma_set_coherent_mask(struct device *dev, u64 mask)
> -{
> -	return -EIO;
> -}
> -static inline u64 dma_get_required_mask(struct device *dev)
> -{
> -	return 0;
> -}
> -static inline bool dma_addressing_limited(struct device *dev)
> -{
> -	return false;
> -}
> -static inline size_t dma_max_mapping_size(struct device *dev)
> -{
> -	return 0;
> -}
> -static inline size_t dma_opt_mapping_size(struct device *dev)
> -{
> -	return 0;
> -}
> -static inline unsigned long dma_get_merge_boundary(struct device *dev)
> -{
> -	return 0;
> -}
> -static inline struct sg_table *dma_alloc_noncontiguous(struct device *dev,
> -		size_t size, enum dma_data_direction dir, gfp_t gfp,
> -		unsigned long attrs)
> -{
> -	return NULL;
> -}
> -static inline void dma_free_noncontiguous(struct device *dev, size_t size,
> -		struct sg_table *sgt, enum dma_data_direction dir)
> -{
> -}
> -static inline void *dma_vmap_noncontiguous(struct device *dev, size_t size,
> -		struct sg_table *sgt)
> -{
> -	return NULL;
> -}
> -static inline void dma_vunmap_noncontiguous(struct device *dev, void *vaddr)
> -{
> -}
> -static inline int dma_mmap_noncontiguous(struct device *dev,
> -		struct vm_area_struct *vma, size_t size, struct sg_table *sgt)
> -{
> -	return -EINVAL;
> -}
> -#endif /* CONFIG_HAS_DMA */
>   
>   #ifdef CONFIG_IOMMU_DMA
>   /**
> diff --git a/kernel/dma/Kconfig b/kernel/dma/Kconfig
> index 0748091339f7..228a3566d344 100644
> --- a/kernel/dma/Kconfig
> +++ b/kernel/dma/Kconfig
> @@ -1,12 +1,7 @@
>   # SPDX-License-Identifier: GPL-2.0-only
>   
> -config NO_DMA
> -	bool
> -
>   config HAS_DMA
> -	bool
> -	depends on !NO_DMA
> -	default y
> +	def_bool y
>   
>   config DMA_OPS_HELPERS
>   	bool
>
Best regards
-- 
Marek Szyprowski, PhD
Samsung R&D Institute Poland


