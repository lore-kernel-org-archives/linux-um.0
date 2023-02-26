Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6F9C64ED6
	for <linux-um@archiver.kernel.org>; Sun, 26 Feb 2023 20:14:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=XzZiT9Bcuuk8v6J1NTv8NdDR9LFshzgn48ylgGL9nRo=; b=IMEwjMd53LIUZk
	v/qsumxZQFuw+Js5ld6Kwr4M5tRq63MSx3DgD7HiErgDy9Pz269vHUjNaExpfhSrRsz2g4uhE2LRy
	oI9er//lgKoVAgSrHQ58jLXUCJzt3epFYXlkrO+Yjlu5s+xvMpP1SWLb7ktqFzNxG+MXFzt4W7rt7
	WaqVo37gPHDlgqeciEKuosVlOcAsOM4cQQwb+2q9IrYJqCBhQRlvZEYN3vYCRp7F5kSfpPMHu7GOx
	O/AlhY83AO9fv6hRDs/imAjzPSnEhXIKWYFARTSR/c3nDIBOeN2fckUq+LE9LVt0WwU6gKqEYUjY8
	xkqo7Z2SBQB4RybnBcgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWNPT-007pAl-Jc; Sun, 26 Feb 2023 20:14:15 +0000
Received: from mail-qt1-f170.google.com ([209.85.160.170])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWNP5-007p7n-GL; Sun, 26 Feb 2023 20:13:53 +0000
Received: by mail-qt1-f170.google.com with SMTP id z6so4833852qtv.0;
        Sun, 26 Feb 2023 12:13:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Gg5lD1thnSOjSPD2ugSmhhuDJpRIfjxQ4WV4ji/sEm4=;
        b=y1Zuj55AI7B+5CrT9T76on3GLiRX/6I6Op6adO0Cb+qCbstUz5+rtsAlRp9eNU3ZXc
         8qgQPZ5Kyq6JKlVPtIxs2q5ZFgOmKnq6iQe7p/hsANdVRfYhXR8LxFNvh4OLkeNbMaRO
         /r+JGrptRoXl8xPh37H8fsjNBkRjKD9k79LmOx/25Ca8GGOSChlTSb22VqAGvHX8+PKP
         epjAz6pGIRWjlp7Cy/WcZWXLqnuDvWptLqlYPVo4u5k+jf1thDej7ABYKupjMZv9VkTt
         9pA+IBAfJcd7wcoMbMtc2OYQhmInIgVc+Tr0nfYGBjAm5MV9YSUKiCNMHxeUP/zxYFpq
         egbQ==
X-Gm-Message-State: AO0yUKXFUvcvGNzLD5lsh9uAJaNOC9uUYjenKpgZX2nqPB7Xdt9vd72x
	/rhQCVpcZ53EiqdxVT/K7p8nmGzl53jYJw==
X-Google-Smtp-Source: AK7set9dp2lp9Emkt0gIkvF4cwIlKa43iqEFDAWM2FMmoJJwK47nQclHvzWGTBT7uQdDO1eBofiyBA==
X-Received: by 2002:ac8:7f15:0:b0:3bd:607:434e with SMTP id f21-20020ac87f15000000b003bd0607434emr38898578qtk.55.1677442428954;
        Sun, 26 Feb 2023 12:13:48 -0800 (PST)
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com. [209.85.128.175])
        by smtp.gmail.com with ESMTPSA id h20-20020ac85154000000b0039cc0fbdb61sm3384311qtn.53.2023.02.26.12.13.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 12:13:47 -0800 (PST)
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-536b7ffdd34so123334547b3.6;
        Sun, 26 Feb 2023 12:13:47 -0800 (PST)
X-Received: by 2002:a81:af5f:0:b0:536:38b4:f51 with SMTP id
 x31-20020a81af5f000000b0053638b40f51mr8731562ywj.5.1677442427017; Sun, 26 Feb
 2023 12:13:47 -0800 (PST)
MIME-Version: 1.0
References: <20230113171026.582290-1-david@redhat.com> <20230113171026.582290-12-david@redhat.com>
In-Reply-To: <20230113171026.582290-12-david@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Sun, 26 Feb 2023 21:13:33 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
Message-ID: <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
Subject: Re: [PATCH mm-unstable v1 11/26] microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE
To: David Hildenbrand <david@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Hugh Dickins <hughd@google.com>, John Hubbard <jhubbard@nvidia.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	Mike Rapoport <rppt@linux.ibm.com>, Yang Shi <shy828301@gmail.com>, 
	Vlastimil Babka <vbabka@suse.cz>, Nadav Amit <namit@vmware.com>, 
	Andrea Arcangeli <aarcange@redhat.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	x86@kernel.org, linux-alpha@vger.kernel.org, 
	linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-ia64@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org, 
	openrisc@lists.librecores.org, linux-parisc@vger.kernel.org, 
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
	linux-xtensa@linux-xtensa.org, Michal Simek <monstr@monstr.eu>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230226_121351_584886_1E43BA8C 
X-CRM114-Status: GOOD (  32.36  )
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

Hi David,

On Fri, Jan 13, 2023 at 6:16 PM David Hildenbrand <david@redhat.com> wrote:
> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
> from the type. Generic MM currently only uses 5 bits for the type
> (MAX_SWAPFILES_SHIFT), so the stolen bit is effectively unused.
>
> The shift by 2 when converting between PTE and arch-specific swap entry
> makes the swap PTE layout a little bit harder to decipher.
>
> While at it, drop the comment from paulus---copy-and-paste leftover
> from powerpc where we actually have _PAGE_HASHPTE---and mask the type in
> __swp_entry_to_pte() as well.
>
> Cc: Michal Simek <monstr@monstr.eu>
> Signed-off-by: David Hildenbrand <david@redhat.com>

Thanks for your patch, which is now commit b5c88f21531c3457
("microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE") in

>  arch/m68k/include/asm/mcf_pgtable.h   |  4 +--

What is this m68k change doing here?
Sorry for not noticing this earlier.

Furthermore, several things below look strange to me...

>  arch/microblaze/include/asm/pgtable.h | 45 +++++++++++++++++++++------
>  2 files changed, 37 insertions(+), 12 deletions(-)
>
> diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
> index 3f8f4d0e66dd..e573d7b649f7 100644
> --- a/arch/m68k/include/asm/mcf_pgtable.h
> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> @@ -46,8 +46,8 @@
>  #define _CACHEMASK040          (~0x060)
>  #define _PAGE_GLOBAL040                0x400   /* 68040 global bit, used for kva descs */
>
> -/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
> -#define _PAGE_SWP_EXCLUSIVE    0x080
> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> +#define _PAGE_SWP_EXCLUSIVE    CF_PAGE_NOCACHE

CF_PAGE_NOCACHE is 0x80, so this is still bit 7, thus the new comment
is wrong?

>
>  /*
>   * Externally used page protection values.
> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> index 42f5988e998b..7e3de54bf426 100644
> --- a/arch/microblaze/include/asm/pgtable.h
> +++ b/arch/microblaze/include/asm/pgtable.h
> @@ -131,10 +131,10 @@ extern pte_t *va_to_pte(unsigned long address);
>   * of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
>   * miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
>   * zone.
> - * - PRESENT *must* be in the bottom two bits because swap cache
> - * entries use the top 30 bits.  Because 4xx doesn't support SMP
> - * anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
> - * is cleared in the TLB miss handler before the TLB entry is loaded.
> + * - PRESENT *must* be in the bottom two bits because swap PTEs use the top
> + * 30 bits.  Because 4xx doesn't support SMP anyway, M is irrelevant so we
> + * borrow it for PAGE_PRESENT.  Bit 30 is cleared in the TLB miss handler
> + * before the TLB entry is loaded.

So the PowerPC 4xx comment is still here?

>   * - All other bits of the PTE are loaded into TLBLO without
>   *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
>   * software PTE bits.  We actually use bits 21, 24, 25, and
> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
>  #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
>  #define _PMD_PRESENT   PAGE_MASK
>
> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY

_PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
wrong?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
