Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65B2DEB64D9
	for <linux-um@archiver.kernel.org>; Wed, 14 Jun 2023 15:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ImJDtwzSAjYdoeIbTZ4k+j0a9eLOFeBJbs8QgbxOB6c=; b=GIj4KDw+eNGcgU
	mr+vxzyFN+kYEk4sXrCyOxi4+BORn2ixv2S/EDZdZBF1iUpfw6oXQ0Vcc/+qf+aGpYp3IqN9AtO88
	JR71dpjFYuswuUMZuNuM62YP+1fJs4WUhAqBG5RL0ly4fWcjUHIiKzFwe+yIUgzV7UQTulxwQeeuR
	gZCnU/zECvuf23x/mLTL2+95EfBMOf6e5o4QXYWSeENAIGa/rC7NMNtdvrVfBuvd0H+5SQ6Fk28cN
	f5Z0CLjSBfyCElC2qY/iBGsMbb6BuMST17ardv6jbELWslnwbPhJz9zyzAKYQUkh0t1mtNYPuIRAJ
	JJB6BqJGHNyvQo11egiQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9SI1-00C36a-03;
	Wed, 14 Jun 2023 15:20:05 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9SHx-00C34A-1K;
	Wed, 14 Jun 2023 15:20:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BD89F61F65;
	Wed, 14 Jun 2023 15:20:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DADCC433C8;
	Wed, 14 Jun 2023 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1686756000;
	bh=pvs0YVME2yJhlMmiS60aNyWkmP4h1eZnbjNjnr8k7aE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=gpQZOD1HFnMrM9fo4KdT8pfiKgkiDnXqITSqdsPxwtYIOIx2PBHkeiXHNgWscAcgu
	 7Ludmi0rX4hJke5WXXLAQEn2uCuzmmwp55/iPdSkzGfbm3/7b6D/ARVdqBcqHg2PuT
	 IpiZPKRPo311M/7dwEqLNTB4eEbaoSqrCh9SmEM/Nh700FMYjNTJ646BJmkGOl+ViX
	 wyn9wHmVrmWWVolNGJf0+VJI/kXJrLoD+WGEjfmqa8ga4rLQqqHlxKBhJuM4wDRcU2
	 FeUYfth8UqkvYnAB19GLBf6adak/YgfNGfdLVnkPWuFE7ylBYlwtenSYSzQgRBwuNz
	 fifauRpCnWIdg==
Date: Wed, 14 Jun 2023 18:19:21 +0300
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
	Yoshinori Sato <ysato@users.sourceforge.jp>,
	Geert Uytterhoeven <geert+renesas@glider.be>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Subject: Re: [PATCH v4 30/34] sh: Convert pte_free_tlb() to use ptdescs
Message-ID: <20230614151921.GC52412@kernel.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-31-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230612210423.18611-31-vishal.moola@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230614_082001_493024_9B76F863 
X-CRM114-Status: GOOD (  14.79  )
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

On Mon, Jun 12, 2023 at 02:04:19PM -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents. Also cleans up some spacing issues.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Acked-by: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
>  arch/sh/include/asm/pgalloc.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> index a9e98233c4d4..5d8577ab1591 100644
> --- a/arch/sh/include/asm/pgalloc.h
> +++ b/arch/sh/include/asm/pgalloc.h
> @@ -2,6 +2,7 @@
>  #ifndef __ASM_SH_PGALLOC_H
>  #define __ASM_SH_PGALLOC_H
>  
> +#include <linux/mm.h>
>  #include <asm/page.h>
>  
>  #define __HAVE_ARCH_PMD_ALLOC_ONE
> @@ -31,10 +32,10 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmd,
>  	set_pmd(pmd, __pmd((unsigned long)page_address(pte)));
>  }
>  
> -#define __pte_free_tlb(tlb,pte,addr)			\
> -do {							\
> -	pgtable_pte_page_dtor(pte);			\
> -	tlb_remove_page((tlb), (pte));			\
> +#define __pte_free_tlb(tlb, pte, addr)				\
> +do {								\
> +	pagetable_pte_dtor(page_ptdesc(pte));			\
> +	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  } while (0)
>  
>  #endif /* __ASM_SH_PGALLOC_H */
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
