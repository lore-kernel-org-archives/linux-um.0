Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C70DEC001DD
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 13:35:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=lREPnTH33jvFS+h/nUGGW8FnERUAIJgN6+RI9YaUim8=; b=qcFePuP0C8prWb
	DnX2VKKRZmGBhmjoYmaW5U74QQJ/bqpmdQG6HhChmDX3VN0iwUqZaDvg0l0TW0CvlE3mj/MP3dOpw
	Wjj/mOKeMQIiBx+P1XH4Cvej/luCsicIJ8OuakvXZE+D27GYJVgUOytJSJ2LeR+vzGf7ZLiHDg3VH
	jSYVwYWdw7nA1yV5xDvs2ezoGLUYLD7h9QkANHrZ4rEkYxowdsqlA713ekgVct1u4D35IjNwG6usd
	/gBfT2/rcdjKGPoR/xFVhZ/abkN4lVKfm+3mn1c8BLEHVNFpJPdN6E//U14pltoeUZh9Zwj5PTZ+5
	hT71Q1qMWi+7M4tBdn9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Qes-00BlcZ-03;
	Wed, 14 Jun 2023 13:35:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9Qeo-00Blb0-2n;
	Wed, 14 Jun 2023 13:35:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 0E80460F45;
	Wed, 14 Jun 2023 13:35:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0713C433CA;
	Wed, 14 Jun 2023 13:35:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686749729;
	bh=81ZlQN2KCaIJsbaaGHZ2hKMohISmlbSD+ssqzisoAQE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=peVIK5PcFaRM99or9IKjg5Wk1GpROr9ctyT8BIC08WEGhT/YvEFdtyhqzVHUa/AJj
	 e0i1V5xO3S+nkbZMN2Z1j+Bn1zFA3bcGptvRkcKcxOtQ1DiUiH/SRvFWkjYuPvNtOb
	 /7PZZr5SP19VfVlFD96OM/KULQ1zOIX2Xbubj4bVzLGTDR+801nenrylY8DxDwa57O
	 6Uw9KCAyHqA9nB1qo3GINyvqzZNtOwnsJDGtTX7sr0o8aiGfHvWm3PF1wyD410WZI6
	 eWxsBLAJy2LJHLpDUj97I0afV+G5xEfwOHfY+jLMTVk+L4qUJ/WcbncB5RrE8B814w
	 cPPJ2HH5q8yYA==
Date: Wed, 14 Jun 2023 16:34:51 +0300
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
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
Message-ID: <20230614133451.GC52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-5-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_063530_985466_198E8D6E 
X-CRM114-Status: GOOD (  19.25  )
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

On Mon, Jun 12, 2023 at 02:03:53PM -0700, Vishal Moola (Oracle) wrote:
> Currently, page table information is stored within struct page. As part
> of simplifying struct page, create struct ptdesc for page table
> information.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  include/linux/pgtable.h | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c5a51481bbb9..330de96ebfd6 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -975,6 +975,57 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
>  #endif /* CONFIG_MMU */
>  
> +
> +/**
> + * struct ptdesc - Memory descriptor for page tables.
> + * @__page_flags: Same as page flags. Unused for page tables.
> + * @pt_list: List of used page tables. Used for s390 and x86.
> + * @_pt_pad_1: Padding that aliases with page's compound head.
> + * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
> + * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap only.
> + * @pt_mm: Used for x86 pgds.
> + * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
> + * @ptl: Lock for the page table.

Do you mind aligning the descriptions by @pt_frag_refcount? I think it'll
be more readable.

> + *
> + * This struct overlays struct page for now. Do not modify without a good
> + * understanding of the issues.
> + */
> +struct ptdesc {
> +	unsigned long __page_flags;
> +
> +	union {
> +		struct list_head pt_list;
> +		struct {
> +			unsigned long _pt_pad_1;
> +			pgtable_t pmd_huge_pte;
> +		};
> +	};
> +	unsigned long _pt_s390_gaddr;
> +
> +	union {
> +		struct mm_struct *pt_mm;
> +		atomic_t pt_frag_refcount;
> +	};
> +
> +#if ALLOC_SPLIT_PTLOCKS
> +	spinlock_t *ptl;
> +#else
> +	spinlock_t ptl;
> +#endif
> +};
> +
> +#define TABLE_MATCH(pg, pt)						\
> +	static_assert(offsetof(struct page, pg) == offsetof(struct ptdesc, pt))
> +TABLE_MATCH(flags, __page_flags);
> +TABLE_MATCH(compound_head, pt_list);
> +TABLE_MATCH(compound_head, _pt_pad_1);
> +TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
> +TABLE_MATCH(mapping, _pt_s390_gaddr);
> +TABLE_MATCH(pt_mm, pt_mm);
> +TABLE_MATCH(ptl, ptl);
> +#undef TABLE_MATCH
> +static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
> +
>  /*
>   * No-op macros that just return the current protection value. Defined here
>   * because these macros can be used even if CONFIG_MMU is not defined.
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
