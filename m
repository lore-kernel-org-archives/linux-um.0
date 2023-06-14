Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BA9C001DD
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 13:58:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=VPU91OEyKscnoGXHmoLNCtL+bnb4PS9veTZhp/I5T1w=; b=Rm8b9gN79C4tLx
	JOd2b3Dmsld38lPPQIY4ktiM99mEFYxY1BwrZyK95N7kILeo1AAow4j8jVZd60/7yBYG/4YfjUyWJ
	Vz9W97WOvxgQus1Wdw3FO6ZXAE0fSR4A8eKFA7cuABxLrERoZQTJD76uqsFi/OStY1XEY0BTpfrfC
	E1zfGMu1R99ozokSLOjWB0Rfgzb45sQ+iGeHYDGwVFYopJN+crCqCcC9IEFNoMMMOnHTNl4QxWLQh
	jqjMvmxKruMf49HxwggDV7Z09DnHqvy+TKWYSikItCcx+fsX27hG0Xu9scFMel/0hehgUGQXIlxqL
	9HUoQzbVi4wTxEiTg/Cg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9R17-00Bq8K-1s;
	Wed, 14 Jun 2023 13:58:33 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9R14-00Bq77-0z;
	Wed, 14 Jun 2023 13:58:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C25E463EA8;
	Wed, 14 Jun 2023 13:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0141C433C8;
	Wed, 14 Jun 2023 13:58:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686751109;
	bh=zODqmBJZryq+bXrqw2+dO7/Egr05l6EFGh7EoAR+f5Q=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=lSDu5H7KOZKMWJOQe/RZf66XvE8x+eCZ2Ytzhs66p+GHx+ddxnclpSnPyGBBVOC05
	 kntWJ9TrG8h428EjebftgV+rAv2YXAhTb0cmqdcy2uTjvuT0Ga5hGuS9drSzCT7vEe
	 lZBUTVYDwjRpPWR0zfBUHmtTwZ2dHpcIOTvlm3uWIc27APHLBBUO1V3IJqvs3/W4hf
	 V4LiUm2GDpkcLNAf56LDxlLuEAL6oO/16Aw5vUDA8I/ZMKz2QG0XPQLr9Bk8rgf5Zl
	 R9Y5FHwwoN9JyP4cz6UUoLxJJznNWVeOmwWxNxC0W9lJyus9Kc2Q39K0WgkNq1Cbbd
	 +hjJK6ETZawtw==
Date: Wed, 14 Jun 2023 16:57:51 +0300
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
Subject: Re: [PATCH v4 10/34] mm: Convert ptlock_init() to use ptdescs
Message-ID: <20230614135751.GI52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-11-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-11-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_065830_428647_AE0AD806 
X-CRM114-Status: GOOD (  16.54  )
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

On Mon, Jun 12, 2023 at 02:03:59PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index daecf1db6cf1..f48e626d9c98 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2857,7 +2857,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return ptlock_ptr(page_ptdesc(pmd_page(*pmd)));
>  }
>  
> -static inline bool ptlock_init(struct page *page)
> +static inline bool ptlock_init(struct ptdesc *ptdesc)
>  {
>  	/*
>  	 * prep_new_page() initialize page->private (and therefore page->ptl)
> @@ -2866,10 +2866,10 @@ static inline bool ptlock_init(struct page *page)
>  	 * It can happen if arch try to use slab for page table allocation:
>  	 * slab code uses page->slab_cache, which share storage with page->ptl.
>  	 */
> -	VM_BUG_ON_PAGE(*(unsigned long *)&page->ptl, page);
> -	if (!ptlock_alloc(page_ptdesc(page)))
> +	VM_BUG_ON_PAGE(*(unsigned long *)&ptdesc->ptl, ptdesc_page(ptdesc));
> +	if (!ptlock_alloc(ptdesc))
>  		return false;
> -	spin_lock_init(ptlock_ptr(page_ptdesc(page)));
> +	spin_lock_init(ptlock_ptr(ptdesc));
>  	return true;
>  }
>  
> @@ -2882,13 +2882,13 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  	return &mm->page_table_lock;
>  }
>  static inline void ptlock_cache_init(void) {}
> -static inline bool ptlock_init(struct page *page) { return true; }
> +static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct page *page) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
>  static inline bool pgtable_pte_page_ctor(struct page *page)
>  {
> -	if (!ptlock_init(page))
> +	if (!ptlock_init(page_ptdesc(page)))
>  		return false;
>  	__SetPageTable(page);
>  	inc_lruvec_page_state(page, NR_PAGETABLE);
> @@ -2947,7 +2947,7 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	ptdesc->pmd_huge_pte = NULL;
>  #endif
> -	return ptlock_init(ptdesc_page(ptdesc));
> +	return ptlock_init(ptdesc);
>  }
>  
>  static inline void pmd_ptlock_free(struct page *page)
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
