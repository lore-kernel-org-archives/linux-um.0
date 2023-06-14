Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1142EB64D8
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 15:22:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=5OgrXMUtOsNsUG8USYPL6j1wmOYyGuduEMZaoBgYYS8=; b=g5bRGEE2XVdhZz
	vIcjVin/iu/xGKscE21W/jrCD5W9n+MsCFrEg//52E+CS/Et9TNLJ7iqPAA3l8N/nLZ1HXrl22XWW
	7bsb6iZgALFsBMoFm3PwSGCKchzp3T9kpEOfBwTrrE7G04fRkIChiTcqaxQzVTgTEB6e7yQsymLTw
	ybL963VucqL9mpjAIPq+zL6TtgmLPoKohzAjAxMYhJ8LroT45U16M0DzDiBIn+94mRgRwvd3R5Wcp
	Zj/MMirvXv8ShdB3qC8zmmk5k10mwJX7ZGFfEBW+bGmFDfdfdS+Ju5MnIJBHGwudY8g+Ftt7b/0lC
	KG6O7/GOjJ7DvmU+MF5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9SK1-00C3q4-1m;
	Wed, 14 Jun 2023 15:22:09 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9SJw-00C3mv-2C;
	Wed, 14 Jun 2023 15:22:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id D3FB163FB4;
	Wed, 14 Jun 2023 15:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB0F1C433C0;
	Wed, 14 Jun 2023 15:21:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686756123;
	bh=JJW2yi8jE1xj4PNXmFMp5BSxmEmVsW21Z/BKD3ijRqA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=haxUs5/rQ77/llId2yHHxl+zVtdTrLbyvMnIz3tsRFOuBfKBsufDFPpl6sJMFJSpX
	 XdXGa/cXbRpEhaCxlcG6vxqZV4ZzAZgnbLFIXOUhwM8Ua9bXir/zJSNTjBAjZ03+JP
	 UcP/tVhaYEkS/wXO6HoiCL3DGRWNQpiMx2frieXMXFBs/EuOP4yKcsZnjumnh7yMwt
	 mljclEUSRo9j+Uj9+qbtKqWdq7GxEjZQSCnkNZEtTei1kMdLBLTj7XgI45NhwTOXr3
	 4sBfJLEgvF707hwHqU6mKKWZix4M1FcPGJaAO0WdwWeDGAbdHkQfY6WNHFdb0Gm/o2
	 ZyO+xqT///0Fg==
Date: Wed, 14 Jun 2023 18:21:25 +0300
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
	Richard Weinberger <richard@nod.at>
Subject: Re: [PATCH v4 33/34] um: Convert {pmd, pte}_free_tlb() to use ptdescs
Message-ID: <20230614152125.GF52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-34-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-34-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_082204_762423_BD4C5514 
X-CRM114-Status: GOOD (  13.85  )
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

On Mon, Jun 12, 2023 at 02:04:22PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents. Also cleans up some spacing issues.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/um/include/asm/pgalloc.h | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/arch/um/include/asm/pgalloc.h b/arch/um/include/asm/pgalloc.h
> index 8ec7cd46dd96..de5e31c64793 100644
> --- a/arch/um/include/asm/pgalloc.h
> +++ b/arch/um/include/asm/pgalloc.h
> @@ -25,19 +25,19 @@
>   */
>  extern pgd_t *pgd_alloc(struct mm_struct *);
>  
> -#define __pte_free_tlb(tlb,pte, address)		\
> -do {							\
> -	pgtable_pte_page_dtor(pte);			\
> -	tlb_remove_page((tlb),(pte));			\
> +#define __pte_free_tlb(tlb, pte, address)			\
> +do {								\
> +	pagetable_pte_dtor(page_ptdesc(pte));			\
> +	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  } while (0)
>  
>  #ifdef CONFIG_3_LEVEL_PGTABLES
>  
> -#define __pmd_free_tlb(tlb, pmd, address)		\
> -do {							\
> -	pgtable_pmd_page_dtor(virt_to_page(pmd));	\
> -	tlb_remove_page((tlb),virt_to_page(pmd));	\
> -} while (0)						\
> +#define __pmd_free_tlb(tlb, pmd, address)			\
> +do {								\
> +	pagetable_pmd_dtor(virt_to_ptdesc(pmd));			\
> +	tlb_remove_page_ptdesc((tlb), virt_to_ptdesc(pmd));	\
> +} while (0)
>  
>  #endif
>  
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
