Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECAFCEB64DA
	for <linux-um@archiver.kernel.org>; Thu, 22 Jun 2023 22:05:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=9muO7m/T/z6alK0ccHrpromJoAGAwfXg5qfDDi1cX9A=; b=VKfFGw/1mXhhjJ
	z7n4z5mgqPoAdboFkcdWxyz3jDVTC92B7X+raXvdDQ1saAqhSn2JtLGX0NauKUHtIduCsfPZQt2us
	mDqAbVRFW9U5HVPqbeQxcZJL2Z2+X6U+OqO6LzUiOeuL6VsbCxfAyhjymMk8Ju5BNgNUfl2LqKcsu
	U2jiLN0Ir/pDrnqvPJnRccRVXbwQ5WklkqSR4ejmgW6MVofcKiRrzLM1/6LpT8uB+me0nOFtxS0ro
	CSxcVGVyPc7QrNy5CCN3BlltbxCBscN/ODuOn394z/zilN1NTaqGb9NGzoBY8ccxqrWSTD9vOclb9
	6RY6E4O6G0MUY7SVspgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCSQc-001vHg-0P;
	Thu, 22 Jun 2023 22:05:22 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCSQY-001vGN-1Z;
	Thu, 22 Jun 2023 22:05:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7EF4861917;
	Thu, 22 Jun 2023 22:05:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB652C433C8;
	Thu, 22 Jun 2023 22:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1687471516;
	bh=dnifwmEwN5EPVqltpiQCF3MdFT37QyzPJA5VU9yHeeQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=RzL6J1fXaBDz0XMnNSx8x8mXcyvopQkvOXbep39IPzJX6IZTiyxdwE2nHfhbPls3L
	 N+mS72rPbV5Hplxc5fgNpJiDPbV/HNUcjlNM0k72bojGJ4KjFY1InlFqwVw3x6nnQC
	 91+lFDGDXPX57EeoiKgvynYAipkz9J96TnpYMaik9KnCYZuHYn0BitFhgrP4G1fgbY
	 6R4Jpwcj42qDrlJ2D+uH33pP6SPXmc0IbmA4+yG9XAiy7RYgb0iOqdFeCCR7TQblLZ
	 fmEHl1XvZkPJVwZHZ1ypNXpY1N8YMHO70VuR9LvpNAy1Wj1k/paRgs0NZSlBf4+f5g
	 0uQe2Ka6aNE0g==
Message-ID: <bf396b3f-a3f3-817e-8241-222591f88c97@kernel.org>
Date: Thu, 22 Jun 2023 17:05:13 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 26/33] nios2: Convert __pte_free_tlb() to use ptdescs
Content-Language: en-US
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
 linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
 linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
 kvm@vger.kernel.org, Hugh Dickins <hughd@google.com>,
 Mike Rapoport <rppt@kernel.org>
References: <20230622205745.79707-1-vishal.moola@gmail.com>
 <20230622205745.79707-27-vishal.moola@gmail.com>
From: Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <20230622205745.79707-27-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_150518_585969_06A3F443 
X-CRM114-Status: GOOD (  13.21  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org



On 6/22/23 15:57, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> ---
>   arch/nios2/include/asm/pgalloc.h | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/nios2/include/asm/pgalloc.h b/arch/nios2/include/asm/pgalloc.h
> index ecd1657bb2ce..ce6bb8e74271 100644
> --- a/arch/nios2/include/asm/pgalloc.h
> +++ b/arch/nios2/include/asm/pgalloc.h
> @@ -28,10 +28,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>   
>   extern pgd_t *pgd_alloc(struct mm_struct *mm);
>   
> -#define __pte_free_tlb(tlb, pte, addr)				\
> -	do {							\
> -		pgtable_pte_page_dtor(pte);			\
> -		tlb_remove_page((tlb), (pte));			\
> +#define __pte_free_tlb(tlb, pte, addr)					\
> +	do {								\
> +		pagetable_pte_dtor(page_ptdesc(pte));			\
> +		tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>   	} while (0)
>   
>   #endif /* _ASM_NIOS2_PGALLOC_H */

Acked-by: Dinh Nguyen <dinguyen@kernel.org>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
