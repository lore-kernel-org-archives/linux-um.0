Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82717EB64D8
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 15:20:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9jXhrygqAwaCS9dcs83hwKRE+j/r4B1RA65N+CpqVk8=; b=Dtc0IFqMpn1M1F
	9/KkuGiFrKW90C1+OltURQ4Oyq8APHAE4INGNrWN27jiH/qlo9YTo5PGNvvwyhBCjaJa+0zn93pn4
	SbDRU2is99FUE6RETh6PnDe8+zDmvGh+Ktlt+ceWLf/6spGjWq5bRj8u9fwHxnJeW2YJjts6jbd0t
	1Ldjf+8klRB4LkotbaH784iVvO3nY2n9LfrgVLUyVnkC0WxFSCRRkbIKdn8dFs6qVs6RBvHD3n+Ti
	O2Enp+k/6OKgIoGW8g+e40QHWE3Rf1ymR2sqjcXItz2R4C4rmyJnAXUQBKy8p434bgwf8HCdNPrV2
	/LSHJvRhlXV4VFc20n0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9SIl-00C3MN-0M;
	Wed, 14 Jun 2023 15:20:51 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9SIf-00C3IX-0N;
	Wed, 14 Jun 2023 15:20:47 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6917063A46;
	Wed, 14 Jun 2023 15:20:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D7CFC433C8;
	Wed, 14 Jun 2023 15:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686756043;
	bh=96hB/Dutg7+YAlKNWDoQ2GAzZAZD6BC/gRuTrx6fMnE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PFKiOvSreJTfh5Xtv6ubZJTR9fklehqu0ZAN5wgMUW/sLqZjohhJPxRlmW70y9tfb
	 MJLE0xzsHXtV1/gKV+4z7tPzVs1ZREMtj8U0/znRVOW0O8y6uNIHnGpjzdr49RBrYC
	 xBb5NI93jS0qUzMwboMr7y3y4ocYh19ocFZmLT8j7b8qsMYlxYS9jlizQt+L95Bpg7
	 ZJLiQdwmzorCuBbqjkmB8vgbIliB9r128kkEi0yENbNqrP9+TzrpqoRpFbndP1I//x
	 MAHASOLZvbHnJOfb7hXUM8MLSqBbEToS6swaIXlfv1V66JK3DzG4OV417sT6SCG7QR
	 ESRbrUE0cTyFQ==
Date: Wed, 14 Jun 2023 18:20:05 +0300
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
	Hugh Dickins <hughd@google.com>,
	"David S. Miller" <davem@davemloft.net>
Subject: Re: [PATCH v4 31/34] sparc64: Convert various functions to use
 ptdescs
Message-ID: <20230614152005.GD52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-32-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-32-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_082045_251436_81745CE9 
X-CRM114-Status: GOOD (  18.90  )
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

On Mon, Jun 12, 2023 at 02:04:20PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/sparc/mm/init_64.c | 17 +++++++++--------
>  1 file changed, 9 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/sparc/mm/init_64.c b/arch/sparc/mm/init_64.c
> index 04f9db0c3111..105915cd2eee 100644
> --- a/arch/sparc/mm/init_64.c
> +++ b/arch/sparc/mm/init_64.c
> @@ -2893,14 +2893,15 @@ pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>  
>  pgtable_t pte_alloc_one(struct mm_struct *mm)
>  {
> -	struct page *page = alloc_page(GFP_KERNEL | __GFP_ZERO);
> -	if (!page)
> +	struct ptdesc *ptdesc = pagetable_alloc(GFP_KERNEL | __GFP_ZERO, 0);
> +
> +	if (!ptdesc)
>  		return NULL;
> -	if (!pgtable_pte_page_ctor(page)) {
> -		__free_page(page);
> +	if (!pagetable_pte_ctor(ptdesc)) {
> +		pagetable_free(ptdesc);
>  		return NULL;
>  	}
> -	return (pte_t *) page_address(page);
> +	return ptdesc_address(ptdesc);
>  }
>  
>  void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
> @@ -2910,10 +2911,10 @@ void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
>  
>  static void __pte_free(pgtable_t pte)
>  {
> -	struct page *page = virt_to_page(pte);
> +	struct ptdesc *ptdesc = virt_to_ptdesc(pte);
>  
> -	pgtable_pte_page_dtor(page);
> -	__free_page(page);
> +	pagetable_pte_dtor(ptdesc);
> +	pagetable_free(ptdesc);
>  }
>  
>  void pte_free(struct mm_struct *mm, pgtable_t pte)
> -- 
> 2.40.1
> 
> 
> _______________________________________________
> linux-riscv mailing list
> linux-riscv@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-riscv

-- 
Sincerely yours,
Mike.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
