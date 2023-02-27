Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01B7EC64ED6
	for <linux-um@archiver.kernel.org>; Mon, 27 Feb 2023 14:43:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T27J4IJ4LrGTVmfiolDnE07yS7kyC2Lg3UFUypPbYNI=; b=tsrdBnm4ZKTcDs
	ySRiEPDHhxBUiOBp1e6bzHUrven1bmPx+tJgk/44U1+cEEgtyc2IIr2JekQJOjufHhHszosruEdas
	6c5q5Zcilh/QHZR6T8QlUKNfm5Yvs15TVPw9XFla2XCxrWLnvge5NNMBiTCwDtEDnoFl221y2I4x4
	cQftOStqNfVQm/zxFHrrijdcl4U8ozCp91aCEl2sT65//8vgFDKuxUmClxZmnRNxFpkBGh0XU2MMl
	/bQ7QGOMm9oi/2JHzfDbz3O7vZ+WnmKzTxM4kRTpgWehQsX9Pp+kk3tWuQwqj+mS0EyMPbMUeaFBd
	/vXrsF24TqrBBjBWVY/g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWej7-00A27P-Px; Mon, 27 Feb 2023 14:43:41 +0000
Received: from mail-qt1-f178.google.com ([209.85.160.178])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWeis-00A1zn-M9; Mon, 27 Feb 2023 14:43:28 +0000
Received: by mail-qt1-f178.google.com with SMTP id w23so6815052qtn.6;
        Mon, 27 Feb 2023 06:43:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZtpzGlheMp9cWEjldclbCx07Trvxzhn2kfeNTxmqNPE=;
        b=745K4QDD6epck+JVxmrGhFh2f9okmPFJvOAc2h16Ej1CGCGJoKC2j4WT/f9SrKv7aK
         8sQAJUn4h0lMJzAq++gDpEtGhwz4tiDVyoxkiXKssT3Q7YD+LZuQltcjUwZ4TsJZLEgp
         eoA0LfBW8tyut5Zc+3i4JBZ+rWh+8pFzV/q88BYMmzaMPijo7xKvQCGiRBBP0Ki1iWgX
         jXixZVD8f/Jcd5g9hA00VM0LyFTv14ADxUmznQGPUongAau6AiyfVmBE5tX7lzBPQcWe
         0HuspeTX/IOxlC2J3RNXq3QmRaBCDFDE0RxE7/ev06D/CvMdygwp00Z3Xth0mVliS76A
         DtgQ==
X-Gm-Message-State: AO0yUKWrqEKgwnic2jd9PEfkACcOKZ845gj1EdsV4KZzZli1ZooJUAGr
	i8SF4AT9cK18KvhSN7Gd7KVLpaUE5Jto3w==
X-Google-Smtp-Source: AK7set9gFUy8F8NKfIVCCONJPkJKq0Q2VVgwRteJ+W+KfgrJ1dOYx2fSX+o81O0RRruXDpZSeHC7BQ==
X-Received: by 2002:a05:622a:2d6:b0:3bd:16cf:2f17 with SMTP id a22-20020a05622a02d600b003bd16cf2f17mr36160847qtx.53.1677509003417;
        Mon, 27 Feb 2023 06:43:23 -0800 (PST)
Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com. [209.85.128.177])
        by smtp.gmail.com with ESMTPSA id d21-20020ac86155000000b003b2ea9b76d0sm4714454qtm.34.2023.02.27.06.43.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 06:43:22 -0800 (PST)
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-536bf92b55cso180751547b3.12;
        Mon, 27 Feb 2023 06:43:21 -0800 (PST)
X-Received: by 2002:a81:ad43:0:b0:533:91d2:9d94 with SMTP id
 l3-20020a81ad43000000b0053391d29d94mr10571733ywk.5.1677509001567; Mon, 27 Feb
 2023 06:43:21 -0800 (PST)
MIME-Version: 1.0
References: <20230113171026.582290-1-david@redhat.com> <20230113171026.582290-12-david@redhat.com>
 <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com> <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com>
In-Reply-To: <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Feb 2023 15:43:07 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
Message-ID: <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230227_064326_758708_3A99A600 
X-CRM114-Status: GOOD (  47.47  )
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

On Mon, Feb 27, 2023 at 2:31 PM David Hildenbrand <david@redhat.com> wrote:
> On 26.02.23 21:13, Geert Uytterhoeven wrote:
> > On Fri, Jan 13, 2023 at 6:16 PM David Hildenbrand <david@redhat.com> wrote:
> >> Let's support __HAVE_ARCH_PTE_SWP_EXCLUSIVE by stealing one bit
> >> from the type. Generic MM currently only uses 5 bits for the type
> >> (MAX_SWAPFILES_SHIFT), so the stolen bit is effectively unused.
> >>
> >> The shift by 2 when converting between PTE and arch-specific swap entry
> >> makes the swap PTE layout a little bit harder to decipher.
> >>
> >> While at it, drop the comment from paulus---copy-and-paste leftover
> >> from powerpc where we actually have _PAGE_HASHPTE---and mask the type in
> >> __swp_entry_to_pte() as well.
> >>
> >> Cc: Michal Simek <monstr@monstr.eu>
> >> Signed-off-by: David Hildenbrand <david@redhat.com>
> >
> > Thanks for your patch, which is now commit b5c88f21531c3457
> > ("microblaze/mm: support __HAVE_ARCH_PTE_SWP_EXCLUSIVE") in
> >
>
> Right, it went upstream, so we can only fixup.
>
> >>   arch/m68k/include/asm/mcf_pgtable.h   |  4 +--
> >
> > What is this m68k change doing here?
> > Sorry for not noticing this earlier.
>
> Thanks for the late review, still valuable :)
>
> That hunk should have gone into the previous patch, looks like I messed
> that up when reworking.
>
> >
> > Furthermore, several things below look strange to me...
> >
> >>   arch/microblaze/include/asm/pgtable.h | 45 +++++++++++++++++++++------
> >>   2 files changed, 37 insertions(+), 12 deletions(-)
> >>
> >> diff --git a/arch/m68k/include/asm/mcf_pgtable.h b/arch/m68k/include/asm/mcf_pgtable.h
> >> index 3f8f4d0e66dd..e573d7b649f7 100644
> >> --- a/arch/m68k/include/asm/mcf_pgtable.h
> >> +++ b/arch/m68k/include/asm/mcf_pgtable.h
> >> @@ -46,8 +46,8 @@
> >>   #define _CACHEMASK040          (~0x060)
> >>   #define _PAGE_GLOBAL040                0x400   /* 68040 global bit, used for kva descs */
> >>
> >> -/* We borrow bit 7 to store the exclusive marker in swap PTEs. */
> >> -#define _PAGE_SWP_EXCLUSIVE    0x080
> >> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> >> +#define _PAGE_SWP_EXCLUSIVE    CF_PAGE_NOCACHE
> >
> > CF_PAGE_NOCACHE is 0x80, so this is still bit 7, thus the new comment
> > is wrong?
>
> You're right, it's still bit 7 (and we use LSB-0 bit numbering in that
> file). I'll send a fixup.

OK.

> >>   /*
> >>    * Externally used page protection values.
> >> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> >> index 42f5988e998b..7e3de54bf426 100644
> >> --- a/arch/microblaze/include/asm/pgtable.h
> >> +++ b/arch/microblaze/include/asm/pgtable.h
> >> @@ -131,10 +131,10 @@ extern pte_t *va_to_pte(unsigned long address);
> >>    * of the 16 available.  Bit 24-26 of the TLB are cleared in the TLB
> >>    * miss handler.  Bit 27 is PAGE_USER, thus selecting the correct
> >>    * zone.
> >> - * - PRESENT *must* be in the bottom two bits because swap cache
> >> - * entries use the top 30 bits.  Because 4xx doesn't support SMP
> >> - * anyway, M is irrelevant so we borrow it for PAGE_PRESENT.  Bit 30
> >> - * is cleared in the TLB miss handler before the TLB entry is loaded.
> >> + * - PRESENT *must* be in the bottom two bits because swap PTEs use the top
> >> + * 30 bits.  Because 4xx doesn't support SMP anyway, M is irrelevant so we
> >> + * borrow it for PAGE_PRESENT.  Bit 30 is cleared in the TLB miss handler
> >> + * before the TLB entry is loaded.
> >
> > So the PowerPC 4xx comment is still here?
>
> I only dropped the comment above __swp_type(). I guess you mean that we
> could also drop the "Because 4xx doesn't support SMP anyway, M is
> irrelevant so we borrow it for PAGE_PRESENT." sentence, correct? Not

Yes, that's what I meant.

> sure about the "Bit 30 is cleared in the TLB miss handler" comment, if
> that can similarly be dropped.

No idea, didn't check. But if it was copied from PPC, chances are
high it's no longer true....

> >>    * - All other bits of the PTE are loaded into TLBLO without
> >>    *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
> >>    * software PTE bits.  We actually use bits 21, 24, 25, and
> >> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
> >>   #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
> >>   #define _PMD_PRESENT   PAGE_MASK
> >>
> >> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> >> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY
> >
> > _PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
> > wrong?
>
> In the example, I use MSB-0 bit numbering (which I determined to be
> correct in microblaze context eventually, but I got confused a couple a
> times because it's very inconsistent). That should be MSB-0 bit 24.

Thanks, TIL microblaze uses IBM bit numbering...

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
