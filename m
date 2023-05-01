Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 986EFC7EE2C
	for <linux-um@archiver.kernel.org>; Mon,  1 May 2023 20:59:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Mime-Version:Message-ID:To:From:CC:In-Reply-To:
	Subject:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:References:List-Owner;
	bh=3E65pY5J8lPrRXsW3heODkHVwOsrH5EOPa+jKZ4JPI0=; b=aq1ByhTA42LTXt9pDem2HdZQsS
	fgyckz4Sf/e4oi2R/mPgvOKqXQ2Eo4b6CDmc/T37QDJDVconouUQWNPT/MtlvOYCQT6byMoPwYvjV
	69qopaK11k/Wt7qtGHcARf80kS2LwZpFRO0rPriUJEaHsUg/GNzxF4ev8wxXPrUqhh15rkZ7MbZ+O
	lqsNWws/ET2p9k6d+XfFhOxKvyNV8/v272XwRSx6zBESOKvlx+WPzqxDjIuPbgLvm3uVuUeYLea9u
	RNbsUK2RYoVF1omzd2Px0H1zgfs8EYzZNMnzAhdwQz38VCHWaAw3uZCOydZDLGhVLOva0zgX0W/GW
	yQd2skdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1ptacP-00GxRM-0D;
	Mon, 01 May 2023 20:59:33 +0000
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1ptacJ-00GxPE-1H
	for linux-um@lists.infradead.org;
	Mon, 01 May 2023 20:59:30 +0000
Received: by mail-pf1-x42c.google.com with SMTP id d2e1a72fcca58-63b5fca48bcso2242518b3a.0
        for <linux-um@lists.infradead.org>; Mon, 01 May 2023 13:59:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20221208.gappssmtp.com; s=20221208; t=1682974766; x=1685566766;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=56zwdsQPzBA4Fq57F7zZq8xm3cbpRSpnOmcnA0Dh+zY=;
        b=dhuoKYDmXvVL9rcvID9l7RqV772Z8lTC+U0WXQUi0tYJbLE9a48GrmSzQs7bEghGbC
         JAz8rXoL1w4B9KKuEwX7POjH3Ox3r6V4zpIxvsvZpSsylQJD8ptmZ7+Vz+V8jAHJj04w
         T6FV37TSFDDCD7el69cwAEuuEXi6g8EgNvIcALlfkGBQgAio2kQ2a6bJAUGpYJRLsZzz
         ZNQyL545JSX++O1LCUyCJsybjwMgrDioUAedrjXfVSqEM2lGIt3XAkC5ujMjWrYDbKAU
         lx6fFu18ULaY/km5rliSpJC6ISEyi513He8uKlna726VX+0Zf3a2zrJJ6SJgvgEWorgq
         velw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682974766; x=1685566766;
        h=content-transfer-encoding:mime-version:message-id:to:from:cc
         :in-reply-to:subject:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=56zwdsQPzBA4Fq57F7zZq8xm3cbpRSpnOmcnA0Dh+zY=;
        b=Y9FKZk9spKETUI9llrztlntR91GR9IqHJONLa9C0ifZVVDUTJIPntMoGA15RIV3PLW
         32V1cTGRbf4wsmNH9+wPoRjBYpwtQaaaLU/BbggcJ+8d5kX8bJ71pREWALCY03gh2Tnq
         tE7TiH/X/SGKBH/6N25bhVz3OAWvT4wJ6y4dXeN7RSi3x73Kh+7zSsvInSWrn22eLAzd
         I9VJSCXbQoHNS53W/9I8+7AZB4/VyLkC3hMBB5qeDLa9a58p79TSe0X1QON7NPoaht1m
         7wPI1s+Oo7IQeZ9+N74bXx182YwKDn+29iLBFI+4Fe0Am2gJBNKTK6lrWksGKluVgQoJ
         S5Nw==
X-Gm-Message-State: AC+VfDyqgmBnlcP8hZ8EmlE5s/VrJDD9ljBvszq8tuaoV7dmbXl5TyKx
	Fqtz4R9HpmYYJVc256Dm7qlTRA==
X-Google-Smtp-Source: ACHHUZ7NRh0XptQx7EX4B/2U8oMa1VyQthNvjC4nK5qetnlZ9yiAEbyNISqPVXEejwWKpBkEgu1KUQ==
X-Received: by 2002:a05:6a00:1301:b0:63d:27a1:d578 with SMTP id j1-20020a056a00130100b0063d27a1d578mr19620776pfu.20.1682974765524;
        Mon, 01 May 2023 13:59:25 -0700 (PDT)
Received: from localhost ([50.221.140.188])
        by smtp.gmail.com with ESMTPSA id x3-20020a628603000000b0063d666566d1sm20322681pfd.72.2023.05.01.13.59.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 May 2023 13:59:24 -0700 (PDT)
Date: Mon, 01 May 2023 13:59:24 -0700 (PDT)
X-Google-Original-Date: Mon, 01 May 2023 13:59:09 PDT (-0700)
Subject: Re: [PATCH v2 29/34] riscv: Convert alloc_{pmd, pte}_late() to use ptdescs
In-Reply-To: <20230501192829.17086-30-vishal.moola@gmail.com>
CC: akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
  linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
  linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
  linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
  linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
  sparclinux@vger.kernel.org, linux-um@lists.infradead.org, xen-devel@lists.xenproject.org,
  kvm@vger.kernel.org, vishal.moola@gmail.com, Paul Walmsley <paul.walmsley@sifive.com>
From: Palmer Dabbelt <palmer@dabbelt.com>
To: vishal.moola@gmail.com
Message-ID: <mhng-e6f12727-9abe-4a93-a361-15a6cd333f51@palmer-ri-x1c9a>
Mime-Version: 1.0 (MHng)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230501_135927_629752_BE0973F7 
X-CRM114-Status: GOOD (  18.03  )
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

On Mon, 01 May 2023 12:28:24 PDT (-0700), vishal.moola@gmail.com wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
>
> Some of the functions use the *get*page*() helper functions. Convert
> these to use ptdesc_alloc() and ptdesc_address() instead to help
> standardize page tables further.
>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  arch/riscv/include/asm/pgalloc.h |  8 ++++----
>  arch/riscv/mm/init.c             | 16 ++++++----------
>  2 files changed, 10 insertions(+), 14 deletions(-)
>
> diff --git a/arch/riscv/include/asm/pgalloc.h b/arch/riscv/include/asm/pgalloc.h
> index 59dc12b5b7e8..cb5536403bd8 100644
> --- a/arch/riscv/include/asm/pgalloc.h
> +++ b/arch/riscv/include/asm/pgalloc.h
> @@ -153,10 +153,10 @@ static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>
>  #endif /* __PAGETABLE_PMD_FOLDED */
>
> -#define __pte_free_tlb(tlb, pte, buf)   \
> -do {                                    \
> -	pgtable_pte_page_dtor(pte);     \
> -	tlb_remove_page((tlb), pte);    \
> +#define __pte_free_tlb(tlb, pte, buf)			\
> +do {							\
> +	ptdesc_pte_dtor(page_ptdesc(pte));		\
> +	tlb_remove_page_ptdesc((tlb), page_ptdesc(pte));\
>  } while (0)
>  #endif /* CONFIG_MMU */
>
> diff --git a/arch/riscv/mm/init.c b/arch/riscv/mm/init.c
> index eb8173a91ce3..8f1982664687 100644
> --- a/arch/riscv/mm/init.c
> +++ b/arch/riscv/mm/init.c
> @@ -353,12 +353,10 @@ static inline phys_addr_t __init alloc_pte_fixmap(uintptr_t va)
>
>  static phys_addr_t __init alloc_pte_late(uintptr_t va)
>  {
> -	unsigned long vaddr;
> -
> -	vaddr = __get_free_page(GFP_KERNEL);
> -	BUG_ON(!vaddr || !pgtable_pte_page_ctor(virt_to_page(vaddr)));
> +	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
>
> -	return __pa(vaddr);
> +	BUG_ON(!ptdesc || !ptdesc_pte_ctor(ptdesc));
> +	return __pa((pte_t *)ptdesc_address(ptdesc));
>  }
>
>  static void __init create_pte_mapping(pte_t *ptep,
> @@ -436,12 +434,10 @@ static phys_addr_t __init alloc_pmd_fixmap(uintptr_t va)
>
>  static phys_addr_t __init alloc_pmd_late(uintptr_t va)
>  {
> -	unsigned long vaddr;
> -
> -	vaddr = __get_free_page(GFP_KERNEL);
> -	BUG_ON(!vaddr || !pgtable_pmd_page_ctor(virt_to_page(vaddr)));
> +	struct ptdesc *ptdesc = ptdesc_alloc(GFP_KERNEL, 0);
>
> -	return __pa(vaddr);
> +	BUG_ON(!ptdesc || !ptdesc_pmd_ctor(ptdesc));
> +	return __pa((pmd_t *)ptdesc_address(ptdesc));
>  }
>
>  static void __init create_pmd_mapping(pmd_t *pmdp,

Acked-by: Palmer Dabbelt <palmer@rivosinc.com>

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
