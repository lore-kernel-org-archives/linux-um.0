Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21288EB64DB
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 14:00:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=38+K/uiDnV1sna8kbRelrhrzys+RmQgDAPoAaaBTy04=; b=ukWIBaRqddv04T
	iQj/hO30rfCFvQvf2oou+HUYOhyMAM8iIs88p7rCNYS2jrzWDFmy515z3vuts7GAtx5ngO59wCKId
	QIZWauynbitScqk8+lRx8li/yxji6OcF2QaF9oBqkvro2mAIblIr+ALClUpV3RYxmEWcKavaaf6MF
	yYeIUP3v7T41GRtr/8IDB8U2fqTxM44eoGCicb44PWkmYbDdXrBKJif/5tNVnpeIy9tM1YyyEHPHb
	siJmYZtucsBgzwgajWMG2Ml8YKke485ovKTC+beP5+bNi/zs1PmElQgXUjThkmSVzAWnC/WbL1PF7
	701Igg25j2UF8r6mUMLA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9R30-00BqZ4-2T;
	Wed, 14 Jun 2023 14:00:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9R2w-00BqX8-1K;
	Wed, 14 Jun 2023 14:00:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id E28C463F79;
	Wed, 14 Jun 2023 14:00:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67061C433C8;
	Wed, 14 Jun 2023 14:00:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686751225;
	bh=uKraQGeV6CHflKMTQULlWthGg679fqUnVunPDgo/6HY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PDvLwogGgBD7itA4KpDmMOz5f6z6VH2iaHunkUOmJGb2CV9/5MwRPKrP111EYXtEb
	 UEqH+CWzIgF1Rc6XrQFIv/yMpYEmEBGoEuDURlPd52I/fGmF+q5wVqQlIl9KpU5+Uk
	 bgdwaGWMrQOsCsKhPDLR53apMHeHe+9FdmAd1a7miKQKkWiXMpItAY3NijXk99Jluh
	 Pxd9FqKP+sLyI/lOsBPezf8JoB5Fqp5Gg8oE7VA+UHq8nk2Bo7G2Cvf5IS4Aq32CvE
	 s4FZBegGotMSVk+KfyEvDwvHHiHE5HW4dc9hJuLo8yp+W1/X4mVZFqgnWQ8kmzqF33
	 SBYFIqusV7nCA==
Date: Wed, 14 Jun 2023 16:59:47 +0300
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
Subject: Re: [PATCH v4 12/34] mm: Convert ptlock_free() to use ptdescs
Message-ID: <20230614135947.GK52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-13-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-13-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_070026_528763_537E990A 
X-CRM114-Status: GOOD (  15.52  )
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

On Mon, Jun 12, 2023 at 02:04:01PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 10 +++++-----
>  mm/memory.c        |  4 ++--
>  2 files changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 3b54bb4c9753..a1af7983e1bd 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2826,7 +2826,7 @@ static inline void pagetable_clear(void *x)
>  #if ALLOC_SPLIT_PTLOCKS
>  void __init ptlock_cache_init(void);
>  bool ptlock_alloc(struct ptdesc *ptdesc);
> -extern void ptlock_free(struct page *page);
> +void ptlock_free(struct ptdesc *ptdesc);
>  
>  static inline spinlock_t *ptlock_ptr(struct ptdesc *ptdesc)
>  {
> @@ -2842,7 +2842,7 @@ static inline bool ptlock_alloc(struct ptdesc *ptdesc)
>  	return true;
>  }
>  
> -static inline void ptlock_free(struct page *page)
> +static inline void ptlock_free(struct ptdesc *ptdesc)
>  {
>  }
>  
> @@ -2883,7 +2883,7 @@ static inline spinlock_t *pte_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  }
>  static inline void ptlock_cache_init(void) {}
>  static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
> -static inline void ptlock_free(struct page *page) {}
> +static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
>  static inline bool pgtable_pte_page_ctor(struct page *page)
> @@ -2897,7 +2897,7 @@ static inline bool pgtable_pte_page_ctor(struct page *page)
>  
>  static inline void pgtable_pte_page_dtor(struct page *page)
>  {
> -	ptlock_free(page);
> +	ptlock_free(page_ptdesc(page));
>  	__ClearPageTable(page);
>  	dec_lruvec_page_state(page, NR_PAGETABLE);
>  }
> @@ -2955,7 +2955,7 @@ static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
>  #endif
> -	ptlock_free(ptdesc_page(ptdesc));
> +	ptlock_free(ptdesc);
>  }
>  
>  #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
> diff --git a/mm/memory.c b/mm/memory.c
> index ba9579117686..d4d2ea5cf0fd 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5945,8 +5945,8 @@ bool ptlock_alloc(struct ptdesc *ptdesc)
>  	return true;
>  }
>  
> -void ptlock_free(struct page *page)
> +void ptlock_free(struct ptdesc *ptdesc)
>  {
> -	kmem_cache_free(page_ptl_cachep, page->ptl);
> +	kmem_cache_free(page_ptl_cachep, ptdesc->ptl);
>  }
>  #endif
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
