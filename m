Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31BCFEB64D9
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 15:08:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=1/+0wTJSqF82TVazXTAYI73LRnW8dUvbiHxG3kd0KeE=; b=yw/3I0UHnNxKiW
	0mGL65oSwkE8Z5LJFC63P385IEXZ7Et/UMzNo/mUnkrR1Ij1iWjyYt7ObX1wwwXFzRl96zVZwdR5b
	ZluOS84sPc3/j3SehXXhze4TPqSjH9a1wFsjliatUtYHo0/d4e8OpSzP/rouX8GQYsXDWPy+dy3eM
	SVc3gcGzf3j7cbl1pTIIAlp+Qy/z8tSR5zIOaTy/u1tK+nBTVRQ32jVH1hqCi+OixQbDWQ+pEyD8l
	Ow7NG9/tG0hzUbu1isayOdZkwFo1aP3cyOCQBVLGU6qXwKp3zwETj6NqWzcQZ9363xRBLR7jK7g0u
	Xn/COcHLNhhL9ekx1+Ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9S6o-00C0fe-1x;
	Wed, 14 Jun 2023 15:08:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9S6l-00C0dq-10;
	Wed, 14 Jun 2023 15:08:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C103D64274;
	Wed, 14 Jun 2023 15:08:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F8B4C433C8;
	Wed, 14 Jun 2023 15:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686755306;
	bh=KMZ0sWg3oWLcgQ10FZDJEZz1Q4wDlpsgjoFRtVSwfW0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=H25tJoPWfpWcsaynauNwXB5hTK36bRqtx/0xTnssPgH0lhjlolKnlOLsfsGu434eI
	 CxYybNyd9SBr/0zVFCnQrFd7/DAbM63g53GRk5YtH7zmCHpo6SmKK/U51sN1E2BFQl
	 m04/LPDFqZFfvtJmJDOYTB/nU393uOzKg1Z3ZAInkjBg8hEXnAKN3CDXAJ7hETSDfQ
	 bbwHZ58euJx0VpBLsdgAjNte0WFG4VJlXw54eBPKUuDtJgtDpvznyTJ/YlrJnQxY8Q
	 qCOf+ZUXW3rIBbsyRwFsS4/dxVgK+bq5VCCnS7blNCFjXDH39Ph8uFmZvgC9UdIhtD
	 AY2vel4DKq+Jg==
Date: Wed, 14 Jun 2023 18:07:48 +0300
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
Subject: Re: [PATCH v4 23/34] hexagon: Convert __pte_free_tlb() to use ptdescs
Message-ID: <20230614150748.GV52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-24-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-24-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_080827_388745_EF5BE6BC 
X-CRM114-Status: GOOD (  14.34  )
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

On Mon, Jun 12, 2023 at 02:04:12PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/hexagon/include/asm/pgalloc.h | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/hexagon/include/asm/pgalloc.h b/arch/hexagon/include/asm/pgalloc.h
> index f0c47e6a7427..55988625e6fb 100644
> --- a/arch/hexagon/include/asm/pgalloc.h
> +++ b/arch/hexagon/include/asm/pgalloc.h
> @@ -87,10 +87,10 @@ static inline void pmd_populate_kernel(struct mm_struct *mm, pmd_t *pmd,
>  		max_kernel_seg = pmdindex;
>  }
>  
> -#define __pte_free_tlb(tlb, pte, addr)		\
> -do {						\
> -	pgtable_pte_page_dtor((pte));		\
> -	tlb_remove_page((tlb), (pte));		\
> +#define __pte_free_tlb(tlb, pte, addr)				\
> +do {								\
> +	pagetable_pte_dtor((page_ptdesc(pte)));			\
> +	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  } while (0)
>  
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
