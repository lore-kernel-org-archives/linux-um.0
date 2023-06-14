Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E8B7EB64DC
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 15:00:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=eEQFIiQDnUKSQJxDpayZQj7jT0KhoybFdKgTz/VlcPw=; b=Zp7lYCgjDE3OWI
	l2latGWo41/wMBMP/2t7yDmjQF+59eM/EhK3mxSxjJDL08uwpRaB/FQxGqHyOPUgRk5O9ICXbt9yB
	5LU0UST8tmTjVFp2CYt5mKDonPaSjGFAw8zkPPZnFJOA6XFBnzB6Z2zcelf0UEWzmE2tvmjLjEpV5
	gIzAFTNMgKUil6NtbZR6hQ0h+Y0uqkHKfl7xiR3ernEqOJ3eoGQsenS6YounJpRrF0RlAr9woJ8aR
	V52ffwqCOKE1fdHBvrAn0YrDHMsUIL5x3LESqyGk2ctq7jC3FWDahsACdf6MSCn/YkS06d70CvVUS
	OZsddnCPPTXB2IGHNVlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Rya-00Bz20-12;
	Wed, 14 Jun 2023 15:00:00 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9RyW-00Bz0W-13;
	Wed, 14 Jun 2023 14:59:57 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CE70D63CDA;
	Wed, 14 Jun 2023 14:59:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CD37C433C8;
	Wed, 14 Jun 2023 14:59:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686754795;
	bh=Snf0vvy1ZfRMDrG2QV2GY/XXoVVQULhRbHTUN6/ozYs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Yb6roLWgU1FpArbgMhm3suW779Jdabd7l+H7dMd2zBGyrh0BOeY5wtdMql6biURZl
	 v4iwBz/HuCXVMtg61KO5mBWTrhq69oDtUrOThilHfsnE8uTE2ZygL8lFanhWvJUrqE
	 vMcJQ9egXs+J1/HmerJQneWZPIb7WwKm6eCArSImVwb+BZcAaye0RccD/lcNjLTILt
	 TGcYSdafz5ds7jjw5qQKCC3YeIHWy3SRi7PvyD5uV8jIRQEF+KcbULtCXAQiLGBilE
	 AxzTGwTNCf+5ligff90SIYQR5ysfy1RO+UiN0WBtTnV4rm3ThxZVJb9CHZkUcTgAgY
	 VSYQ3btc5Uccg==
Date: Wed, 14 Jun 2023 17:59:17 +0300
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
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
	Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 19/34] pgalloc: Convert various functions to use
 ptdescs
Message-ID: <20230614145917.GR52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-20-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-20-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_075956_449455_4E7AA272 
X-CRM114-Status: GOOD (  24.51  )
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

On Mon, Jun 12, 2023 at 02:04:08PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> Some of the functions use the *get*page*() helper functions. Convert
> these to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  include/asm-generic/pgalloc.h | 62 +++++++++++++++++++++--------------
>  1 file changed, 37 insertions(+), 25 deletions(-)
> 
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index a7cf825befae..3fd6ce79e654 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -18,7 +18,11 @@
>   */
>  static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
>  {
> -	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
> +	struct ptdesc *ptdesc = pagetable_alloc(GFP_PGTABLE_KERNEL, 0);
> +
> +	if (!ptdesc)
> +		return NULL;
> +	return ptdesc_address(ptdesc);
>  }
>  
>  #ifndef __HAVE_ARCH_PTE_ALLOC_ONE_KERNEL
> @@ -41,7 +45,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>   */
>  static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  {
> -	free_page((unsigned long)pte);
> +	pagetable_free(virt_to_ptdesc(pte));
>  }
>  
>  /**
> @@ -49,7 +53,7 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   * @mm: the mm_struct of the current context
>   * @gfp: GFP flags to use for the allocation
>   *
> - * Allocates a page and runs the pgtable_pte_page_ctor().
> + * Allocates a ptdesc and runs the pagetable_pte_ctor().

Allocates memory for page table and ptdesc

>   *
>   * This function is intended for architectures that need
>   * anything beyond simple page allocation or must have custom GFP flags.

The Return: description here should be fixed up

> @@ -58,17 +62,17 @@ static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>   */
>  static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
>  {
> -	struct page *pte;
> +	struct ptdesc *ptdesc;
>  
> -	pte = alloc_page(gfp);
> -	if (!pte)
> +	ptdesc = pagetable_alloc(gfp, 0);
> +	if (!ptdesc)
>  		return NULL;
> -	if (!pgtable_pte_page_ctor(pte)) {
> -		__free_page(pte);
> +	if (!pagetable_pte_ctor(ptdesc)) {
> +		pagetable_free(ptdesc);
>  		return NULL;
>  	}
>  
> -	return pte;
> +	return ptdesc_page(ptdesc);
>  }
>  
>  #ifndef __HAVE_ARCH_PTE_ALLOC_ONE
> @@ -76,7 +80,7 @@ static inline pgtable_t __pte_alloc_one(struct mm_struct *mm, gfp_t gfp)
>   * pte_alloc_one - allocate a page for PTE-level user page table
>   * @mm: the mm_struct of the current context
>   *
> - * Allocates a page and runs the pgtable_pte_page_ctor().
> + * Allocates a ptdesc and runs the pagetable_pte_ctor().

Allocates memory for page table and ptdesc

>   *
>   * Return: `struct page` initialized as page table or %NULL on error

Return: ptdesc ...

>   */
> @@ -98,8 +102,10 @@ static inline pgtable_t pte_alloc_one(struct mm_struct *mm)
>   */
>  static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
>  {
> -	pgtable_pte_page_dtor(pte_page);
> -	__free_page(pte_page);
> +	struct ptdesc *ptdesc = page_ptdesc(pte_page);
> +
> +	pagetable_pte_dtor(ptdesc);
> +	pagetable_free(ptdesc);
>  }
>  
>  
> @@ -110,7 +116,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
>   * pmd_alloc_one - allocate a page for PMD-level page table
>   * @mm: the mm_struct of the current context
>   *
> - * Allocates a page and runs the pgtable_pmd_page_ctor().
> + * Allocates a ptdesc and runs the pagetable_pmd_ctor().

Allocate memory for page table and ptdesc

>   * Allocations use %GFP_PGTABLE_USER in user context and
>   * %GFP_PGTABLE_KERNEL in kernel context.
>   *
> @@ -118,28 +124,30 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
>   */
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -	struct page *page;
> +	struct ptdesc *ptdesc;
>  	gfp_t gfp = GFP_PGTABLE_USER;
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	page = alloc_page(gfp);
> -	if (!page)
> +	ptdesc = pagetable_alloc(gfp, 0);
> +	if (!ptdesc)
>  		return NULL;
> -	if (!pgtable_pmd_page_ctor(page)) {
> -		__free_page(page);
> +	if (!pagetable_pmd_ctor(ptdesc)) {
> +		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> -	return (pmd_t *)page_address(page);
> +	return ptdesc_address(ptdesc);
>  }
>  #endif
>  
>  #ifndef __HAVE_ARCH_PMD_FREE
>  static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>  {
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
> +
>  	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
> -	pgtable_pmd_page_dtor(virt_to_page(pmd));
> -	free_page((unsigned long)pmd);
> +	pagetable_pmd_dtor(ptdesc);
> +	pagetable_free(ptdesc);
>  }
>  #endif
>  
> @@ -149,11 +157,15 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>  
>  static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  {
> -	gfp_t gfp = GFP_PGTABLE_USER;
> +	gfp_t gfp = GFP_PGTABLE_USER | __GFP_ZERO;

GFP_PGTABLE_USER already contains __GFP_ZERO

> +	struct ptdesc *ptdesc;
>  
>  	if (mm == &init_mm)
>  		gfp = GFP_PGTABLE_KERNEL;
> -	return (pud_t *)get_zeroed_page(gfp);
> +	ptdesc = pagetable_alloc(gfp, 0);
> +	if (!ptdesc)
> +		return NULL;
> +	return ptdesc_address(ptdesc);
>  }
>  
>  #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
> @@ -175,7 +187,7 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>  static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
>  {
>  	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
> -	free_page((unsigned long)pud);
> +	pagetable_free(virt_to_ptdesc(pud));
>  }
>  
>  #ifndef __HAVE_ARCH_PUD_FREE
> @@ -190,7 +202,7 @@ static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>  #ifndef __HAVE_ARCH_PGD_FREE
>  static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  {
> -	free_page((unsigned long)pgd);
> +	pagetable_free(virt_to_ptdesc(pgd));
>  }
>  #endif
>  
> -- 
> 2.40.1
> 
> 

-- 
Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
