Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A52EC7EE2E
	for <linux-um@archiver.kernel.org>; Thu, 25 May 2023 09:19:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aicb1htlKZEsvFpFQzUu9tzNmeN+2MMNyISbgwKmaSs=; b=dbeP2ext1K4Tgh
	vBlfTv4ud+kP5v/PLBicYgDr/7QzCjZgccgWObrxedcjMRUU3cqCOo1h5LlpCfWdmuL13EMpmukQu
	+rp4OvYfku6p9yt1ILJZORGSkknYUbr9NNsyZ5M+SuQMpazdKukFjcejchbLyO3/zZS95KeUFubJs
	H3z+lqP0SpbyaFjTZTsxsyO04yPFCMFy1sh8Cd5VKjWs1NscKGi54FU6BccpJQaT7JT52sbsxOERP
	oMbVPr53v/1cSZ18D2k6CTPxZflPNcpLGoesA4nMbnt8CCoMO7Py6BOqlIHed9giUG47Y2oJRykSs
	wZF9+6D0hl8HVbj6FzuQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2788-00G7cT-2z;
	Thu, 25 May 2023 09:19:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2783-00G7Zx-2p;
	Thu, 25 May 2023 09:19:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0FA426442A;
	Thu, 25 May 2023 09:19:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3CF9C433EF;
	Thu, 25 May 2023 09:19:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685006366;
	bh=wqsrR+VLdLpuPAmDdXqCVY2XwnsXyfpXvlaNwL8b95Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=foE41UqPH1HgRiXHDcvmNVSgga8+6+movhrIvHcP0lKkim5d2C0CveXiAkrsugwUY
	 mTMqHgjGefxYEA1DbMZBeEKmAQcDqRXgChs6yPJ6RFCubSjjaqUfXH5DibAVcYpUBA
	 aCcKgzmG5mhVSa4fQNmh2lbUtoTD+weF0ODUHN0azy9cnLxTNG6czawfKdDGiZ3h9+
	 eQhVfl9VDk2zYUu2V/zd6ljbuCqaKQw9PEhJG6TAu5DceAsH/0TRlb4M7Mib7O0vr6
	 Y2yg35as+E26Oh74LjFv8mXxr+pdJYlNpysggvOKmpyB8i+xjdzE7MqNjdH/FF5KDP
	 bMNE7SNyaBLAA==
Date: Thu, 25 May 2023 12:19:00 +0300
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
Subject: Re: [PATCH v2 13/34] mm: Create ptdesc equivalents for
 pgtable_{pte,pmd}_page_{ctor,dtor}
Message-ID: <20230525091900.GY4967@kernel.org>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
 <20230501192829.17086-14-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230501192829.17086-14-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_021927_997857_76237A4F 
X-CRM114-Status: GOOD (  18.25  )
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

On Mon, May 01, 2023 at 12:28:08PM -0700, Vishal Moola (Oracle) wrote:
> Creates ptdesc_pte_ctor(), ptdesc_pmd_ctor(), ptdesc_pte_dtor(), and
> ptdesc_pmd_dtor() and make the original pgtable constructor/destructors
> wrappers.

I think pgtable_pXY_ctor/dtor names would be better.
 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  include/linux/mm.h | 56 ++++++++++++++++++++++++++++++++++------------
>  1 file changed, 42 insertions(+), 14 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 58c911341a33..dc61aeca9077 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2847,20 +2847,34 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* USE_SPLIT_PTE_PTLOCKS */
>  
> -static inline bool pgtable_pte_page_ctor(struct page *page)
> +static inline bool ptdesc_pte_ctor(struct ptdesc *ptdesc)
>  {
> -	if (!ptlock_init(page_ptdesc(page)))
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	if (!ptlock_init(ptdesc))
>  		return false;
> -	__SetPageTable(page);
> -	inc_lruvec_page_state(page, NR_PAGETABLE);
> +	__folio_set_table(folio);
> +	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>  	return true;
>  }
>  
> +static inline bool pgtable_pte_page_ctor(struct page *page)
> +{
> +	return ptdesc_pte_ctor(page_ptdesc(page));
> +}
> +
> +static inline void ptdesc_pte_dtor(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	ptlock_free(ptdesc);
> +	__folio_clear_table(folio);
> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> +}
> +
>  static inline void pgtable_pte_page_dtor(struct page *page)
>  {
> -	ptlock_free(page_ptdesc(page));
> -	__ClearPageTable(page);
> -	dec_lruvec_page_state(page, NR_PAGETABLE);
> +	ptdesc_pte_dtor(page_ptdesc(page));
>  }
>  
>  #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
> @@ -2942,20 +2956,34 @@ static inline spinlock_t *pmd_lock(struct mm_struct *mm, pmd_t *pmd)
>  	return ptl;
>  }
>  
> -static inline bool pgtable_pmd_page_ctor(struct page *page)
> +static inline bool ptdesc_pmd_ctor(struct ptdesc *ptdesc)
>  {
> -	if (!pmd_ptlock_init(page_ptdesc(page)))
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	if (!pmd_ptlock_init(ptdesc))
>  		return false;
> -	__SetPageTable(page);
> -	inc_lruvec_page_state(page, NR_PAGETABLE);
> +	__folio_set_table(folio);
> +	lruvec_stat_add_folio(folio, NR_PAGETABLE);
>  	return true;
>  }
>  
> +static inline bool pgtable_pmd_page_ctor(struct page *page)
> +{
> +	return ptdesc_pmd_ctor(page_ptdesc(page));
> +}
> +
> +static inline void ptdesc_pmd_dtor(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	pmd_ptlock_free(ptdesc);
> +	__folio_clear_table(folio);
> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> +}
> +
>  static inline void pgtable_pmd_page_dtor(struct page *page)
>  {
> -	pmd_ptlock_free(page_ptdesc(page));
> -	__ClearPageTable(page);
> -	dec_lruvec_page_state(page, NR_PAGETABLE);
> +	ptdesc_pmd_dtor(page_ptdesc(page));
>  }
>  
>  /*
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
