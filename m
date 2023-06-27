Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E466C001DE
	for <linux-um@archiver.kernel.org>; Tue, 27 Jun 2023 20:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=TQYe7Wtuo/gljEQQXeCIy1IeTEESGuoBqyjyeNBVCBg=; b=J/x4L96FVq8REI
	kxqvkJmBw2v7C4NCA9G01hxf2DEIk+D9+JkvTUbXfwz1jGKiInRbKKJs8OvJgI9AMQgRq9lJuPYRz
	wGDkPJ04wbaiBw2u1jueYo39Ba1mjd2qyvL3zFpaw5ws098YF1ZDMS0TGCYamur24FBtC3goWA+Rj
	RIgdOXYvQAywgR/aIaIUVglIh9WS7Sb3KERRQUUDmhpAosm8bHEb5+AXw/oevuMpqXw6ufbW7hIyS
	KZgYdmM/FC+tsexhnkUfxBxuTSWAhzGzMFZWVhE/5D4OZyaPwj/Fg4SgoPpC93ksOj+3jpLjSaAdu
	ZcvOsyetdlj+8ca7fa5g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEFGF-00E599-0a;
	Tue, 27 Jun 2023 20:26:03 +0000
Received: from mail-oi1-x232.google.com ([2607:f8b0:4864:20::232])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEFGB-00E56i-0J
	for linux-um@lists.infradead.org;
	Tue, 27 Jun 2023 20:26:00 +0000
Received: by mail-oi1-x232.google.com with SMTP id 5614622812f47-3a1e6022b93so1604701b6e.1
        for <linux-um@lists.infradead.org>; Tue, 27 Jun 2023 13:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687897556; x=1690489556;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LZAV5n644nbF2fspex915RKKOQRg7bETsj2bpveqEMY=;
        b=xNz2k+2fBy79SBSN7O3Nv7cLANq5HCaENIBFu+yQEGe96a1YOHtJEoPaKnyife8HRe
         5dU95/2GVD5K+lpOCTP593eJsZJwf/2wZp9yo1OQfO/oNZwywWrdmA09H1o2gjeFBMGa
         2z17oC13XR4C8ajUueC5PeNsuXdi61YrDmFXBoVZVdvnVAtqQrU5JobTasqjeN7xrIeJ
         MpmBPZJhwD6ptkxugjRgmTxswvpeogN6O0bHDNZg4lSF5UmKAFt+JTRw6jFkbjRuUe/7
         Do+RKbNuWG1nZ+QFgPFa8R4odd5nhFz3t0Eq/rbGXPI4aHvGzMWePtxiLYZ9tzwtN2+N
         73Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687897556; x=1690489556;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LZAV5n644nbF2fspex915RKKOQRg7bETsj2bpveqEMY=;
        b=WhufuDTEUGDi0I2w0GPOQPDrA225UFiEeeZ+HUOMTpKJxS5Ugp1DREKQaFkUBWl7dc
         qSZ09CCtUpFFavl2b654HvofwTBFL9oHLhuUZkK5yvFkrEUbDSNLgGixrVu24w+vApHa
         jUvzIV2R71xxUOuQCqcuofKPx6/RJgbRISVNwa4RIXyUjKclKeU59v+qTvNTeFm5c/dg
         nLlXiZ9YQSOPjxes6MkkZQJTKpAaWKMu1ndBPcvpYpV68SuTFEt7rB46SB5sc1d33dbM
         JsTvVaZDBPNLk44+fBFxUUr4xgWQzx3OlXCRVcsM/JXtHAn73tlWZyN9zem9wLrRRVsD
         QhGA==
X-Gm-Message-State: AC+VfDwbrlllGSLB6EUzVhO55cd3OcPJW9a0mg8n60+8I9c8FfyalMyS
	5sX2AzYTMY+n3Jfpc/lGtcNsqg==
X-Google-Smtp-Source: ACHHUZ4XO8G5i/7kBsDqN0SkVyZDmn1Y3+y5XriSrT6/YkoTOhARrZtNyfUTkKT2V2obJFMfnoberA==
X-Received: by 2002:a05:6808:1a8d:b0:39e:ff3d:af9d with SMTP id bm13-20020a0568081a8d00b0039eff3daf9dmr24552508oib.46.1687897555783;
        Tue, 27 Jun 2023 13:25:55 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id p79-20020a0de652000000b00573a2a0808esm2002459ywe.77.2023.06.27.13.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 13:25:55 -0700 (PDT)
Date: Tue, 27 Jun 2023 13:25:52 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: Matthew Wilcox <willy@infradead.org>
cc: Hugh Dickins <hughd@google.com>, 
    "Vishal Moola (Oracle)" <vishal.moola@gmail.com>, 
    Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org, 
    linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
    linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
    loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org, 
    linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org, 
    linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org, 
    linux-s390@vger.kernel.org, linux-sh@vger.kernel.org, 
    sparclinux@vger.kernel.org, linux-um@lists.infradead.org, 
    xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
    Catalin Marinas <catalin.marinas@arm.com>, 
    Huacai Chen <chenhuacai@kernel.org>, 
    Geert Uytterhoeven <geert@linux-m68k.org>, 
    Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
    Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, 
    David Hildenbrand <david@redhat.com>, 
    Claudio Imbrenda <imbrenda@linux.ibm.com>, 
    Paul Walmsley <paul.walmsley@sifive.com>, 
    "David S. Miller" <davem@davemloft.net>, 
    Richard Weinberger <richard@nod.at>, 
    Yoshinori Sato <ysato@users.sourceforge.jp>, 
    Dave Hansen <dave.hansen@linux.intel.com>, Arnd Bergmann <arnd@arndb.de>, 
    Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v6 00/33] Split ptdesc from struct page
In-Reply-To: <ZJsG3oMF+FaH0iMw@casper.infradead.org>
Message-ID: <8f1f3dd-50a-3726-87f2-b66d35804ba7@google.com>
References: <20230627031431.29653-1-vishal.moola@gmail.com> <e8992eee-4140-427e-bacb-9449f346318@google.com> <ZJsG3oMF+FaH0iMw@casper.infradead.org>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_132559_139487_E6A924F5 
X-CRM114-Status: GOOD (  25.85  )
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

On Tue, 27 Jun 2023, Matthew Wilcox wrote:
> On Mon, Jun 26, 2023 at 09:44:08PM -0700, Hugh Dickins wrote:
> > On Mon, 26 Jun 2023, Vishal Moola (Oracle) wrote:
> > 
> > > The MM subsystem is trying to shrink struct page. This patchset
> > > introduces a memory descriptor for page table tracking - struct ptdesc.
> > ...
> > >  39 files changed, 686 insertions(+), 455 deletions(-)
> > 
> > I don't see the point of this patchset: to me it is just obfuscation of
> > the present-day tight relationship between page table and struct page.
> > 
> > Matthew already explained:
> > 
> > > The intent is to get ptdescs to be dynamically allocated at some point
> > > in the ~2-3 years out future when we have finished the folio project ...
> > 
> > So in a kindly mood, I'd say that this patchset is ahead of its time.
> > But I can certainly adapt to it, if everyone else sees some point to it.
> 
> If you think this patchset is ahead of its time, we can certainly put
> it on hold.  We're certainly prepared to redo it to be merged after your
> current patch series.

Thank you, but I can adapt.  That was not my point:
I'm claiming this patchset is ~2-3 years ahead of its time.

> 
> I think you can see the advantage of the destination, so I don't think
> you're against that.

Maybe - I have some scepticism, but I'll be happy for that to be dissolved.

> Are you opposed to the sequencing of the work to
> get us there?  I'd be happy to discuss another way to do it.

Yes, I'm opposed to churn for no benefit.

> 
> For example, we could dynamically allocate ptdescs right now.  We'd get
> the benefit of having an arbitrary amount of space in the ptdesc,
> although not the benefit of a smaller memmap until everything else is
> also dynamically allocated.

That sounded much better, at first: churn serving good purpose.  But now
I suspect you're offering to dynamically allocate a ptdesc, in addition
to the struct page of the page table(s) itself, which will be wasted:
more memory consumption to no advantage.  If that's so, no thanks.

Hugh

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
