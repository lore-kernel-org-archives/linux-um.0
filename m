Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 97F72C64ED6
	for <linux-um@archiver.kernel.org>; Mon, 27 Feb 2023 19:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:Cc:To:Subject:Message-ID:Date:From:
	In-Reply-To:References:MIME-Version:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=0xNMLMrwO4S2r4Wdv+W6iY8JJgSXFKTLpfB5amj7GaM=; b=uPeH+V81DpnPaw
	K0IejsJ8J3mfFT6PKkWrYyOrYjn2467HrDjMIBcy19PIH2M/F9QGS4RqYqKQMthHSCx8Rer+oL0Ya
	eBvpLyS2u/aH08RZKmJ2WUdRc+0hW3nu6I+yCDQWaLS40+duytpMroLn1zh24XrQ2pzTBmgmE/pss
	Zj9Z+IP8NzkVkiSdmzq2KaSgzagW/EcDPwxqof4kg7XrQ2KyFZrOeqwMg9FB0OUclFB3uLz4A9MBz
	mL/PyPZEsKqURDsBI4EF7318ALp3TZ551BJ7DyqS7D5XkdQfqDQPkDUJJDjr0572Ybi6vYwxw/Cdh
	7Z66pFmoUOsQ8W8Pxjlw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWjSh-00B19E-Cq; Mon, 27 Feb 2023 19:47:03 +0000
Received: from mail-qv1-f54.google.com ([209.85.219.54])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pWjSS-00B13e-I3; Mon, 27 Feb 2023 19:46:49 +0000
Received: by mail-qv1-f54.google.com with SMTP id ff4so5284669qvb.2;
        Mon, 27 Feb 2023 11:46:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zgbfP6t1iEXlYeQDHgpgkGKrmlu/wPbkfmiZJDZsq5c=;
        b=oAk2aVaRdffw1H8qNRrFUT9DRXNJpNmQmOcI9SM5lpEDSjpOP+n1ewqrE9Efc7gpDX
         MfPeXL+ltsejMBmv5iduqL7ZcpRt9dRaJrl22y8IXKRWV4tnTRRTS3AFCHWiQUpT+Hyz
         r3Pi0pwY/IlDQscCRHV5tw1Rr5Czvy7vTLRfQbBozSY42C3tP4RYXBNAfPTr8cAoXkuZ
         TiClROp38W5SZSR3ax9N8VPrYH11z8blJP/97sftxvpuQFLiZ1EajFHm9znqJQPr5+an
         Nm7maW5UXpw3XUdb6PrPHdDFHKJa9sZRyaxbiPV4Pezcs03C0mYI4PhX9jbqsWmZDXow
         G7Ag==
X-Gm-Message-State: AO0yUKUhbGOzHndkp3WgNEpG4TKeR+szQuBmRV2GeQ+zmH1DwEKXu583
	eDRmT9wvYG0QACLzVtr6XAI1IXGcEHLZAw==
X-Google-Smtp-Source: AK7set/JcX7GGVfJK3j2rk7gQ9SfEEL3ZfEV7xVdjvYbJa5/QvU7y0HjvH8ox1lYo/gwSe8Vbdebfw==
X-Received: by 2002:a05:6214:2622:b0:56e:9dd8:47f3 with SMTP id gv2-20020a056214262200b0056e9dd847f3mr1289737qvb.13.1677527206421;
        Mon, 27 Feb 2023 11:46:46 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id i3-20020a378603000000b007068b49b8absm5431356qkd.62.2023.02.27.11.46.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 11:46:45 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-536bbef1c5eso206876077b3.9;
        Mon, 27 Feb 2023 11:46:45 -0800 (PST)
X-Received: by 2002:a5b:d4e:0:b0:967:f8b2:7a42 with SMTP id
 f14-20020a5b0d4e000000b00967f8b27a42mr7816406ybr.7.1677527205039; Mon, 27 Feb
 2023 11:46:45 -0800 (PST)
MIME-Version: 1.0
References: <20230113171026.582290-1-david@redhat.com> <20230113171026.582290-12-david@redhat.com>
 <CAMuHMdX-FDga8w=pgg1myskEx6wp+oyZifhPPPFnWrc1zW7ZpQ@mail.gmail.com>
 <9ed766a6-cf06-535d-3337-ea6ff25c2362@redhat.com> <CAMuHMdWSaoKqO1Nx7QMDCcXrRmFbqqX8uwDRezXs8g+HdEFjKA@mail.gmail.com>
 <c145a2db-f92c-65aa-3e68-07dbb2e097a6@redhat.com>
In-Reply-To: <c145a2db-f92c-65aa-3e68-07dbb2e097a6@redhat.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Mon, 27 Feb 2023 20:46:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX7MND++KXgTpx4jscfctQA_-zPt3EN9-+79EWE7e+OjA@mail.gmail.com>
Message-ID: <CAMuHMdX7MND++KXgTpx4jscfctQA_-zPt3EN9-+79EWE7e+OjA@mail.gmail.com>
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
X-CRM114-CacheID: sfid-20230227_114648_620807_555EC630 
X-CRM114-Status: GOOD (  27.17  )
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

On Mon, Feb 27, 2023 at 6:01 PM David Hildenbrand <david@redhat.com> wrote:
> >>>>    /*
> >>>>     * Externally used page protection values.
> >>>> diff --git a/arch/microblaze/include/asm/pgtable.h b/arch/microblaze/include/asm/pgtable.h
> >>>> index 42f5988e998b..7e3de54bf426 100644
> >>>> --- a/arch/microblaze/include/asm/pgtable.h
> >>>> +++ b/arch/microblaze/include/asm/pgtable.h

> >>>>     * - All other bits of the PTE are loaded into TLBLO without
> >>>>     *  * modification, leaving us only the bits 20, 21, 24, 25, 26, 30 for
> >>>>     * software PTE bits.  We actually use bits 21, 24, 25, and
> >>>> @@ -155,6 +155,9 @@ extern pte_t *va_to_pte(unsigned long address);
> >>>>    #define _PAGE_ACCESSED 0x400   /* software: R: page referenced */
> >>>>    #define _PMD_PRESENT   PAGE_MASK
> >>>>
> >>>> +/* We borrow bit 24 to store the exclusive marker in swap PTEs. */
> >>>> +#define _PAGE_SWP_EXCLUSIVE    _PAGE_DIRTY
> >>>
> >>> _PAGE_DIRTY is 0x80, so this is also bit 7, thus the new comment is
> >>> wrong?
> >>
> >> In the example, I use MSB-0 bit numbering (which I determined to be
> >> correct in microblaze context eventually, but I got confused a couple a
> >> times because it's very inconsistent). That should be MSB-0 bit 24.
> >
> > Thanks, TIL microblaze uses IBM bit numbering...
>
> I assume IBM bit numbering corresponds to MSB-0 bit numbering, correct?

Correct, as seen in s370 and PowerPC manuals...

> I recall that I used the comment above "/* Definitions for MicroBlaze.
> */" as an orientation.
>
> 0  1  2  3  4  ... 18 19 20 21 22 23 24 25 26 27 28 29 30 31
> RPN.....................  0  0 EX WR ZSEL.......  W  I  M  G

Indeed, that's where I noticed the "unconventional" numbering...

> So ... either we adjust both or we leave it as is. (again, depends on
> what the right thing to to is -- which I don't know :) )

It depends whether you want to match the hardware documentation,
or the Linux BIT() macro and friends...

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
