Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70D8CD25043
	for <linux-um@archiver.kernel.org>; Mon, 12 Jan 2026 07:35:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MpZZgA7Z9Th48hWh+uWd3ploF1QFnvsBfVrDzcsw5WM=; b=FGGuj4gagkDqHAY5mbE8PnyCOX
	lTsLEy7ox70ZwiVgG42YFmIXlQ+diAAjzonCxDr/nWPO9UnZX1qXYbiEmxXei1HoIAMJ7MjFSa0kw
	4v5liGqNc/yANgcghAN90BgQVaAfxXRGPElRrDjV7OTCCBiQ95tb0/tJZMOkj3v0mbyaO7Gt7PQl6
	U8KXm00alx7zh4mKlLs3QrszAlJq1Rjxddj2Xci2T/4aI1JyE7F+r+d5Dzwp8JpZGORyL5d2WxkO+
	tx2AniRtI3FKlCebnmMeWeQ5ZClYDkG66DFQa06iW0esVzFlwfbyUcU+oY1ULjDZEDaBTKMQRuz5U
	L25ZDjfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfCSB-00000004t6q-3oFU;
	Mon, 12 Jan 2026 07:35:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vfCS8-00000004t5r-0kYw;
	Mon, 12 Jan 2026 07:35:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 1CBFE43C1F;
	Mon, 12 Jan 2026 07:35:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61041C19422;
	Mon, 12 Jan 2026 07:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768203303;
	bh=H0wpDyU4+hGvGadEaJXaoKwU4fABU87rkRhUJIykrtE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=cB9JlNOsE5ASTDSwfciaJvBRecBB1lB0Uwj+GaWwyCjgypyJQWPdkiELZQ8iVJPfz
	 nMocJbirHN/1lk3J7Si3fdDg+XjkNRlIqWpD36vowiVH0S+GvTZEHLt/X4w6L2bjbX
	 MW70tMpH6LtqJ9xirliNmH6ey3Jn3uobFlK0X2Mc7rV2i4ddTSmSf1HxKEBm5toCRi
	 d46Yvu6ZlmDb9ZF7jcWZyute2z21cTSvo7YbjPFCodLjqoxUiSIWkDnwdalYjHh76y
	 ow7pMfD3F6CiXLdHJYJqrOQj4clSEc/bsWScF8TIIT22yhLrTWzvu1RJLquyFnQ26r
	 U5L75tv4dABXw==
Date: Mon, 12 Jan 2026 09:34:40 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, Alex Shi <alexs@kernel.org>,
	Andreas Larsson <andreas@gaisler.com>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	David Hildenbrand <david@kernel.org>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Guo Ren <guoren@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Jonathan Corbet <corbet@lwn.net>,
	Klara Modin <klarasmodin@gmail.com>,
	"Liam R. Howlett" <Liam.Howlett@oracle.com>,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Hocko <mhocko@suse.com>, Michal Simek <monstr@monstr.eu>,
	Muchun Song <muchun.song@linux.dev>,
	Oscar Salvador <osalvador@suse.de>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Pratyush Yadav <pratyush@kernel.org>,
	Richard Weinberger <richard@nod.at>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Suren Baghdasaryan <surenb@google.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Vlastimil Babka <vbabka@suse.cz>, Will Deacon <will@kernel.org>,
	x86@kernel.org, linux-alpha@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-cxl@vger.kernel.org, linux-doc@vger.kernel.org,
	linux-hexagon@vger.kernel.org, linux-kernel@vger.kernel.org,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-mm@kvack.org, linux-openrisc@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-snps-arc@lists.infradead.org, linux-um@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	sparclinux@vger.kernel.org
Subject: Re: [PATCH v3 17/29] s390: introduce arch_zone_limits_init()
Message-ID: <aWSkELL7xJ04QAct@kernel.org>
References: <20260111082105.290734-1-rppt@kernel.org>
 <20260111082105.290734-18-rppt@kernel.org>
 <b211f877-f9bb-4892-b67c-d2610048575a-agordeev@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b211f877-f9bb-4892-b67c-d2610048575a-agordeev@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260111_233504_273611_23C8D9CF 
X-CRM114-Status: GOOD (  16.82  )
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
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Hi,

On Mon, Jan 12, 2026 at 08:02:48AM +0100, Alexander Gordeev wrote:
> On Sun, Jan 11, 2026 at 10:20:51AM +0200, Mike Rapoport wrote:
> 
> Hi Mike,
> 
> ...
> > +void __init arch_zone_limits_init(unsigned long *max_zone_pfns)
> > +{
> > +	max_zone_pfns[ZONE_DMA] = virt_to_pfn(MAX_DMA_ADDRESS);
> > +	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> > +}
> > +
> >  /*
> >   * paging_init() sets up the page tables
> >   */
> > @@ -97,8 +103,7 @@ void __init paging_init(void)
> >  	sparse_init();
> >  	zone_dma_limit = DMA_BIT_MASK(31);
> >  	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
> > -	max_zone_pfns[ZONE_DMA] = virt_to_pfn(MAX_DMA_ADDRESS);
> > -	max_zone_pfns[ZONE_NORMAL] = max_low_pfn;
> > +	arch_zone_limits_init(max_zone_pfns);
> 
> You move initialization of max_zone_pfns[] to a function, name the
> function arch_zone_limits_init(), but leave the initializatio of
> max_zone_pfns[] to zeroes outside. Should not it be brought along?

The idea is that is the caller responsibility to initialize max_zone_pfns
to zero. After patch 24: "arch, mm: consolidate initialization of
SPARSE memory model" there is a single caller of arch_zone_limits_init()
and having initialization of max_zone_pfns() there is more optimal than
having 20-something of those.
 
> >  	free_area_init(max_zone_pfns);
> >  }
> 
> Thanks!

-- 
Sincerely yours,
Mike.

