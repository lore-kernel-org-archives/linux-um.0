Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A5DDC001DD
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 15:07:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zQBZbknXDHWfG+G6qVe1Gv/JemtfBuoaQ/fD/EKdCEg=; b=j8onf9AP/scBV0
	MiZJRzNF2TMi+PRYQPCQb9QQ7wjxyeMrRXTq5YVaIkHZBvvhyznMIjuUlg8LQZEscjcXRuyfjnRRU
	erGe4fNVttbm5irSol1BgSmaoV5/Vvwzhcw0VMxoTruikYIKI5+w3jUMuwyegYdm9ipT6DyMVa5fR
	Ur7i01UFgkrST9JUmcAVdCTbfok5hhxSwX4LWToXOXzy5Fhe0Tb88aIxTya76SKjMQMC1NhQe1UNF
	MRIKQ6R6fFwpZVWhMTHGCmSAl6ZChZfjJKudMavcLZGJFXF6y+AWW3LcoeGqF3vzXj+AEQfL9/gv6
	axeZD9OMBxQXAm+/tOHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9S65-00C0Rq-06;
	Wed, 14 Jun 2023 15:07:45 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9S61-00C0Q3-0L;
	Wed, 14 Jun 2023 15:07:42 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 8DEC26433D;
	Wed, 14 Jun 2023 15:07:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DBECC433C0;
	Wed, 14 Jun 2023 15:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686755259;
	bh=JsVwqtt4rn+oBmP9veLZYMWTShEVF7o+ZQx0DgLi4Zs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=C5kIgCv/a7WFPC5tRs5sqFZpJHWZmRkycbqhaUCenxA+sXENaMqraBn8uW0a+QebT
	 mZ6OdRi8HqTKN/fLlxiLY+gYTEXBMlPJd7k4eHkAR+MLf6P+LaRVRHLiwBZOMWFPeh
	 Fhqqn9UjnVNIm5Q5RdXmqRztziwcn9ltJweM50aQJ0s3juJZJPLTo3DhbuvPdQJPaq
	 h2LbrXxJrmkyH9p2jpuC5ESJKX7YVXMhAfWp7vNoPgXlO5lI86wghzWDGdue/lx2YA
	 x6FoTUTEZw7X60hwDiqn+akRr/yO0jO9WPeQeAUaQGxHZWlG5RVnPrpPcimJ1Z2/OZ
	 FP8RrhHA6VKEw==
Date: Wed, 14 Jun 2023 18:07:03 +0300
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
	Hugh Dickins <hughd@google.com>, Guo Ren <guoren@kernel.org>
Subject: Re: [PATCH v4 22/34] csky: Convert __pte_free_tlb() to use ptdescs
Message-ID: <20230614150703.GU52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-23-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-23-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_080741_186990_CBF8BA1E 
X-CRM114-Status: GOOD (  14.21  )
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

On Mon, Jun 12, 2023 at 02:04:11PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Guo Ren <guoren@kernel.org>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/csky/include/asm/pgalloc.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
> index 7d57e5da0914..9c84c9012e53 100644
> --- a/arch/csky/include/asm/pgalloc.h
> +++ b/arch/csky/include/asm/pgalloc.h
> @@ -63,8 +63,8 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  
>  #define __pte_free_tlb(tlb, pte, address)		\
>  do {							\
> -	pgtable_pte_page_dtor(pte);			\
> -	tlb_remove_page(tlb, pte);			\
> +	pagetable_pte_dtor(page_ptdesc(pte));		\
> +	tlb_remove_page_ptdesc(tlb, page_ptdesc(pte));	\
>  } while (0)
>  
>  extern void pagetable_init(void);
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
