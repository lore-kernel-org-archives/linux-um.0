Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED636C77B7F
	for <linux-um@archiver.kernel.org>; Sat,  6 May 2023 11:36:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:Cc:To:From:Subject:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Nr3CWqEMGtvMW7bqCEwDhlnaJw/3rtgvRofm1v6E1uU=; b=ZpFsedxYgKB9Tc
	UqlzsdJfB0BTTn6EW1GM5+y/n9AkU71EqP8Z666RAvGbJCkyd1HNxXeAZJ/uZ/iW4bhl5B/dfgEvb
	MALPFjKoGfLVKpnnRymdo+RMKT9k7p2QsRDjMtWDspETSEasHG9Vfrj/13cFHcRotPEWDSCZHDs34
	GB+CR2jvH/wSqqKje6IAGfK3dEqiLXNj3+gzEr1uqMe09quSCwmMCb3/X9hD5VmlHZLTwRhLagk/C
	ePaFkrEb/calcvIQCSprUzfeIgtRedKFNWor81yH7SgPFZEE4TdWZOQxnIx8FyAGoOGfb8yIlYRA9
	FBvGiICZD+C8TSGpygRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pvGD7-00DJgk-2K;
	Sat, 06 May 2023 11:36:21 +0000
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pvGD2-00DJcO-11;
	Sat, 06 May 2023 11:36:18 +0000
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.95)
          with esmtps (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@zedat.fu-berlin.de>)
          id 1pvGCa-002hVY-AY; Sat, 06 May 2023 13:35:48 +0200
Received: from p57bd9cee.dip0.t-ipconnect.de ([87.189.156.238] helo=suse-laptop.fritz.box)
          by inpost2.zedat.fu-berlin.de (Exim 4.95)
          with esmtpsa (TLS1.3)
          tls TLS_AES_256_GCM_SHA384
          (envelope-from <glaubitz@physik.fu-berlin.de>)
          id 1pvGCZ-000Sf9-Vs; Sat, 06 May 2023 13:35:48 +0200
Message-ID: <c0677d21a4b6caa2e5018af000294a974121d9e8.camel@physik.fu-berlin.de>
Subject: Re: [PATCH v2 30/34] sh: Convert pte_free_tlb() to use ptdescs
From: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, Andrew Morton
	 <akpm@linux-foundation.org>, Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, 
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	linux-openrisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org, 
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-um@lists.infradead.org, xen-devel@lists.xenproject.org, 
	kvm@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>
Date: Sat, 06 May 2023 13:35:46 +0200
In-Reply-To: <20230501192829.17086-31-vishal.moola@gmail.com>
References: <20230501192829.17086-1-vishal.moola@gmail.com>
	 <20230501192829.17086-31-vishal.moola@gmail.com>
User-Agent: Evolution 3.48.1 
MIME-Version: 1.0
X-Original-Sender: glaubitz@physik.fu-berlin.de
X-Originating-IP: 87.189.156.238
X-ZEDAT-Hint: PO
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230506_043616_518422_684EB421 
X-CRM114-Status: GOOD (  11.90  )
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

Hi Vishal!

On Mon, 2023-05-01 at 12:28 -0700, Vishal Moola (Oracle) wrote:
> Part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents. Also cleans up some spacing issues.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  arch/sh/include/asm/pgalloc.h | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/sh/include/asm/pgalloc.h b/arch/sh/include/asm/pgalloc.h
> index a9e98233c4d4..ce2ba99dbd84 100644
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
> +	ptdesc_pte_dtor(page_ptdesc(pte));			\
> +	tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)));	\
>  } while (0)
>  
>  #endif /* __ASM_SH_PGALLOC_H */

Looking at the patch which introduces tlb_remove_page_ptdesc() [1], it seems that
tlb_remove_page_ptdesc() already calls tlb_remove_page() with ptdesc_page(pt), so
I'm not sure whether the above tlb_remove_page_ptdesc((tlb), (page_ptdesc(pte)))
is correct.

Shouldn't it just be tlb_remove_page_ptdesc((tlb), (pte))?

Thanks,
Adrian

> [1] https://lore.kernel.org/linux-mm/20230417205048.15870-5-vishal.moola@gmail.com/

-- 
 .''`.  John Paul Adrian Glaubitz
: :' :  Debian Developer
`. `'   Physicist
  `-    GPG: 62FF 8A75 84E0 2956 9546  0006 7426 3B37 F5B5 F913

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
