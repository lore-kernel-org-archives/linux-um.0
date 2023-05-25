Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C89A8C7EE2F
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 09:10:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fNarx3J0i5pwyLON3rWBBnAKu/Qq8+W3l0NxRDeaYCg=; b=XuUmqpXKthYlu4
	JRU/oELCyalEzQASsvFv0hesJ8FrF4N/kTc/1mSR535hZpA5AU+d55RZe0KxRybk0TUELORFkhKt1
	egMyuY9SzZIqPVZIIaWUbDgJOSrnViPNUKvLa+AzcpeZQYAvmud0YVZE9G4PbXlYYaW8KFmMIyNbb
	Ps/jq43XZsJSoIB0X49KJe7ZTI+XGjpwKptoDVkFDiUddynZa9syjt/fDn0RT98bG/kqhBCiCmHx9
	yZRFui85cyQMfaM3T4dDlnVmZLA1U0krOBb3THNbtzobPg3SDjCq3hJktUerd8ykZn1Vo9ZNot9QY
	TqteIBXC/e1JfXZZRTdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q26zM-00G6SE-1H;
	Thu, 25 May 2023 09:10:28 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q26zI-00G6Q5-0v;
	Thu, 25 May 2023 09:10:25 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 809E861BBA;
	Thu, 25 May 2023 09:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8403CC433EF;
	Thu, 25 May 2023 09:10:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685005822;
	bh=MayrgJlsA1aps5AHa6GJzt/W5Ikkau0xb4ZAVQYzQBo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=SgalnFj1QWcNg1KScmp5H/gdVoIyJuaOadG2ifarouuXrmiB7bi9+cLPwWxcgkwKz
	 1IyntPwPA+EmY6AjW5UDtLdwwJ3zz/UtAAl1BLherHNkW0KbQ0Vj890ZE5p6a13DIS
	 hkYVdqhetUjWojkx2/7AjaVgzIa198Y5wjTklUVGqqcLaG8f9YIGzEMH5AmQoMQBog
	 1bbeK2vGuhU9HCOtlm+WrwdReQcCmUNdPB4Y9zS1KRog1DX9x6MgYk37MxpgTJO9T1
	 0x6ywoFyjjiRy6focH76H1sf0CwEaS3h/tQ+TQUinImlTf/D6/o+fMS3tvP214c0RS
	 Gpi+okO0Ilpeg==
Date: Thu, 25 May 2023 12:09:56 +0300
From: Mike Rapoport <rppt@kernel.org>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 05/34] mm: add utility functions for ptdesc
Message-ID: <20230525090956.GX4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-6-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230501192829.17086-6-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_021024_405375_B5AA235E 
X-CRM114-Status: GOOD (  25.55  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Mon, May 01, 2023 at 12:28:00PM -0700, Vishal Moola (Oracle) wrote:
> Introduce utility functions setting the foundation for ptdescs. These
> will also assist in the splitting out of ptdesc from struct page.
> 
> ptdesc_alloc() is defined to allocate new ptdesc pages as compound
> pages. This is to standardize ptdescs by allowing for one allocation
> and one free function, in contrast to 2 allocation and 2 free functions.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  include/asm-generic/tlb.h | 11 ++++++++++
>  include/linux/mm.h        | 44 +++++++++++++++++++++++++++++++++++++++
>  include/linux/pgtable.h   | 12 +++++++++++
>  3 files changed, 67 insertions(+)
> 
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index b46617207c93..6bade9e0e799 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -481,6 +481,17 @@ static inline void tlb_remove_page(struct mmu_gather *tlb, struct page *page)
>  	return tlb_remove_page_size(tlb, page, PAGE_SIZE);
>  }
>  
> +static inline void tlb_remove_ptdesc(struct mmu_gather *tlb, void *pt)
> +{
> +	tlb_remove_table(tlb, pt);
> +}
> +
> +/* Like tlb_remove_ptdesc, but for page-like page directories. */
> +static inline void tlb_remove_page_ptdesc(struct mmu_gather *tlb, struct ptdesc *pt)
> +{
> +	tlb_remove_page(tlb, ptdesc_page(pt));
> +}
> +
>  static inline void tlb_change_page_size(struct mmu_gather *tlb,
>  						     unsigned int page_size)
>  {
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index b18848ae7e22..258f3b730359 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2744,6 +2744,45 @@ static inline pmd_t *pmd_alloc(struct mm_struct *mm, pud_t *pud, unsigned long a
>  }
>  #endif /* CONFIG_MMU */
>  
> +static inline struct ptdesc *virt_to_ptdesc(const void *x)
> +{
> +	return page_ptdesc(virt_to_head_page(x));

Do we ever use compound pages for page tables?

> +}
> +
> +static inline void *ptdesc_to_virt(const struct ptdesc *pt)
> +{
> +	return page_to_virt(ptdesc_page(pt));
> +}
> +
> +static inline void *ptdesc_address(const struct ptdesc *pt)
> +{
> +	return folio_address(ptdesc_folio(pt));
> +}
> +
> +static inline bool ptdesc_is_reserved(struct ptdesc *pt)
> +{
> +	return folio_test_reserved(ptdesc_folio(pt));
> +}
> +
> +static inline struct ptdesc *ptdesc_alloc(gfp_t gfp, unsigned int order)
> +{
> +	struct page *page = alloc_pages(gfp | __GFP_COMP, order);
> +
> +	return page_ptdesc(page);
> +}
> +
> +static inline void ptdesc_free(struct ptdesc *pt)
> +{
> +	struct page *page = ptdesc_page(pt);
> +
> +	__free_pages(page, compound_order(page));
> +}

The ptdesc_{alloc,free} API does not sound right to me. The name
ptdesc_alloc() implies the allocation of the ptdesc itself, rather than
allocation of page table page. The same goes for free.

> +
> +static inline void ptdesc_clear(void *x)
> +{
> +	clear_page(x);
> +}
> +
>  #if USE_SPLIT_PTE_PTLOCKS
>  #if ALLOC_SPLIT_PTLOCKS
>  void __init ptlock_cache_init(void);
> @@ -2970,6 +3009,11 @@ static inline void mark_page_reserved(struct page *page)
>  	adjust_managed_page_count(page, -1);
>  }
>  
> +static inline void free_reserved_ptdesc(struct ptdesc *pt)
> +{
> +	free_reserved_page(ptdesc_page(pt));
> +}
> +
>  /*
>   * Default method to free all the __init memory into the buddy system.
>   * The freed pages will be poisoned with pattern "poison" if it's within
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 5e0f51308724..b067ac10f3dd 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1041,6 +1041,18 @@ TABLE_MATCH(ptl, ptl);
>  #undef TABLE_MATCH
>  static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
>  
> +#define ptdesc_page(pt)			(_Generic((pt),			\
> +	const struct ptdesc *:		(const struct page *)(pt),	\
> +	struct ptdesc *:		(struct page *)(pt)))
> +
> +#define ptdesc_folio(pt)		(_Generic((pt),			\
> +	const struct ptdesc *:		(const struct folio *)(pt),	\
> +	struct ptdesc *:		(struct folio *)(pt)))
> +
> +#define page_ptdesc(p)			(_Generic((p),			\
> +	const struct page *:		(const struct ptdesc *)(p),	\
> +	struct page *:			(struct ptdesc *)(p)))
> +
>  /*
>   * No-op macros that just return the current protection value. Defined here
>   * because these macros can be used even if CONFIG_MMU is not defined.
> -- 
> 2.39.2
> 
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
