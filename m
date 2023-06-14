Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB60BEB64DB
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 13:59:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5ov06zY1GAu/3zOvlaOUTFCNYV69sHJmbm3FEfBvXfY=; b=Va0p9ptg9Em0rl
	rTru9k75vzaep38xPCPk7x/oJvCxDbC5bJ5AICMbB3vXNcwYR3/w4mcwwI3SsLKU9Yhz61WkKZP1s
	e4Jb2HKIsJ5towMtAieyzb8F4+d2AhqKjA778AQgXtQqhbYpKCjMLqQhzXeqSgru2MHSGSd3pLEAr
	hpjaPLaUbgI6rQ4w/OgB1NGPYCOiRRMUXtlvDZ7QbX9U3LORxz1UT8dqpOktMKZfmM48EYPU1V0dH
	QxxkDkF9MFnZUpiqlsvKoS8cLMdH12/n3o6jEDNxuhnsynlNRs7YGOipBPk3wjR86m3oXqKDZK9AQ
	iLie9VRD9JQR9bzSmJRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9R2P-00BqOH-1I;
	Wed, 14 Jun 2023 13:59:53 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9R2L-00BqMU-1i;
	Wed, 14 Jun 2023 13:59:50 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D676263914;
	Wed, 14 Jun 2023 13:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75DD0C433C8;
	Wed, 14 Jun 2023 13:59:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686751188;
	bh=bczNeLQKsA4Jn/cyv5Zpe2oQqQ9DoTlx1RmcfxuzAiw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=rB5cuxD7f+pVV/2kNGOgyZm/CMnI+FrUzScbpb3WvoAusSUJT4mgiOW93EX9McJH2
	 FhTySbUNTBv9MPhFHuVa5nuJ1XZTkWt5yRSSUAhZSNmRhZbJ31odisGjIKfu1++lsZ
	 CH2YOx06YFt56y6ifO55IZUoGHHh/jigUaNtJtYKTg86qZrpU96rQcXjsvJGzQn/kn
	 YLwGgJim4snk8fpaILSaD4wUTac4kDSaDw7wbBi0N7ZYhBsLDqm0a86c4hplOXMBZK
	 gjGoFTFEI0ysZIaZZuOB0qrBTQ+cGwB5XLuAStdydY6oCdalsx3dIZVfFXIzN0yL0V
	 8u2LU4VeWNaSQ==
Date: Wed, 14 Jun 2023 16:59:11 +0300
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
Subject: Re: [PATCH v4 11/34] mm: Convert pmd_ptlock_free() to use ptdescs
Message-ID: <20230614135911.GJ52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-12-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-12-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_065949_612392_9BD6E272 
X-CRM114-Status: GOOD (  14.46  )
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

On Mon, Jun 12, 2023 at 02:04:00PM -0700, Vishal Moola (Oracle) wrote:
> This removes some direct accesses to struct page, working towards
> splitting out struct ptdesc from struct page.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/mm.h | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index f48e626d9c98..3b54bb4c9753 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2950,12 +2950,12 @@ static inline bool pmd_ptlock_init(struct ptdesc *ptdesc)
>  	return ptlock_init(ptdesc);
>  }
>  
> -static inline void pmd_ptlock_free(struct page *page)
> +static inline void pmd_ptlock_free(struct ptdesc *ptdesc)
>  {
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> -	VM_BUG_ON_PAGE(page->pmd_huge_pte, page);
> +	VM_BUG_ON_PAGE(ptdesc->pmd_huge_pte, ptdesc_page(ptdesc));
>  #endif
> -	ptlock_free(page);
> +	ptlock_free(ptdesc_page(ptdesc));
>  }
>  
>  #define pmd_huge_pte(mm, pmd) (pmd_ptdesc(pmd)->pmd_huge_pte)
> @@ -2968,7 +2968,7 @@ static inline spinlock_t *pmd_lockptr(struct mm_struct *mm, pmd_t *pmd)
>  }
>  
>  static inline bool pmd_ptlock_init(struct ptdesc *ptdesc) { return true; }
> -static inline void pmd_ptlock_free(struct page *page) {}
> +static inline void pmd_ptlock_free(struct ptdesc *ptdesc) {}
>  
>  #define pmd_huge_pte(mm, pmd) ((mm)->pmd_huge_pte)
>  
> @@ -2992,7 +2992,7 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
>  
>  static inline void pgtable_pmd_page_dtor(struct page *page)
>  {
> -	pmd_ptlock_free(page);
> +	pmd_ptlock_free(page_ptdesc(page));
>  	__ClearPageTable(page);
>  	dec_lruvec_page_state(page, NR_PAGETABLE);
>  }
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
