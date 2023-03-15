Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1487BC6FD1D
	for <linux-um@archiver.kernel.org>; Wed, 15 Mar 2023 10:12:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Z1BlD0JcDCSbPulRdmF98oHFrDjQAYV4gKNUSMGaBFw=; b=DzyB3WMOzYKYPr
	0svInUiSMAWqhQp8DZjsX0v6fCTTN+gmctvdY+StH+KgwPptWFTi9vzv9S8zk7aCxwLERnjwcpDiy
	YPjgqKOyrw4WWNqv3px5bn2avb/tkrxdcVhzky7J9CbDxOvy9TwFmTj12VDJ4Ix1iOhQVVhwOTsUT
	m8El7milt3Dfoz3VvTSrnNC7jwV3Q4cQd4WNDddfrl5xuGiaAMzYRHs9yomvaOlBVRvXFJRGstn9u
	8H+CSgqrMhhEsR0bVCgwLb19y/gMiB/rrvU2ewoZDkjiFZXWkrA2ABJV/hCRP8TmJPzoDR1r+Z+kV
	MSONghn44IAuIfsDljoQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pcO7Q-00D1xY-0Y;
	Wed, 15 Mar 2023 10:12:28 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pcO7M-00D1wL-2E
	for linux-um@lists.infradead.org;
	Wed, 15 Mar 2023 10:12:26 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 659D6B81DBE;
	Wed, 15 Mar 2023 10:12:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8865FC433EF;
	Wed, 15 Mar 2023 10:12:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1678875142;
	bh=6RQXXi1/KCGGyz8ZwBmv1nxgyFJwq5EE1ye6AJVOLSE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Z9WeGf+dNsLIDXsmj44sliJUdSlT29oimfqFmqZ1bscW0lX+nYLnPAz1ftMVMbbx5
	 LmYHKJENlk6OCyJwDpaAQPN699B8ZjhFpIHCqzcPuFOgpfEf5TepXQvn8iWjugF0Kw
	 Y7mRokzkzM1VWgwMfSp2O7qBpGyKjWvNM95R3cwORNFlYnzofCaWRxIaEi8iRykQ1k
	 IWeJjNmNWebQh8m/h4tNG+Ruc3NEQ/LcypxZLLn/3YppWrsY2lUnbRVglx3dFCvYKs
	 6Xk4+WY5j8jgW8EmK+wY5VGJ14seuCp+pgHEBG+w/bc39xKgNNCTSDdc3XoN+ZTzRO
	 0sjzscthgxInw==
Date: Wed, 15 Mar 2023 12:12:08 +0200
From: Mike Rapoport <rppt@kernel.org>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-arch@vger.kernel.org, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH v4 26/36] um: Implement the new page table range API
Message-ID: <ZBGZ+N2SpvZalEL8@kernel.org>
References: <20230315051444.3229621-1-willy@infradead.org>
 <20230315051444.3229621-27-willy@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230315051444.3229621-27-willy@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230315_031224_884732_8E1F9C78 
X-CRM114-Status: GOOD (  17.19  )
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

On Wed, Mar 15, 2023 at 05:14:34AM +0000, Matthew Wilcox (Oracle) wrote:
> Add PFN_PTE_SHIFT and update_mmu_cache_range().
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> Cc: Richard Weinberger <richard@nod.at>
> Cc: Anton Ivanov <anton.ivanov@cambridgegreys.com>
> Cc: Johannes Berg <johannes@sipsolutions.net>
> Cc: linux-um@lists.infradead.org

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/um/include/asm/pgtable.h | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/um/include/asm/pgtable.h b/arch/um/include/asm/pgtable.h
> index a70d1618eb35..ea5f8122f128 100644
> --- a/arch/um/include/asm/pgtable.h
> +++ b/arch/um/include/asm/pgtable.h
> @@ -242,11 +242,7 @@ static inline void set_pte(pte_t *pteptr, pte_t pteval)
>  	if(pte_present(*pteptr)) *pteptr = pte_mknewprot(*pteptr);
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *pteptr, pte_t pteval)
> -{
> -	set_pte(pteptr, pteval);
> -}
> +#define PFN_PTE_SHIFT		PAGE_SHIFT
>  
>  #define __HAVE_ARCH_PTE_SAME
>  static inline int pte_same(pte_t pte_a, pte_t pte_b)
> @@ -290,6 +286,7 @@ struct mm_struct;
>  extern pte_t *virt_to_pte(struct mm_struct *mm, unsigned long addr);
>  
>  #define update_mmu_cache(vma,address,ptep) do {} while (0)
> +#define update_mmu_cache_range(vma, address, ptep, nr) do {} while (0)
>  
>  /*
>   * Encode/decode swap entries and swap PTEs. Swap PTEs are all PTEs that
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
