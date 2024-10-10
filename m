Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17A8FCF07C8
	for <linux-um@archiver.kernel.org>; Thu, 10 Oct 2024 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1L5wqIlmHIp0sefSX7Jl3+4l/GpyP0ad2y5VEmhBwgQ=; b=zH+Zm1U1NqJr4ohX60FeKNHsAR
	0mftDWoa1EiFRkcadbVgJQVZsn4F10PvXMkIdaATLslgY85yxeeXQ58jyQ2G6B5r73ULZ0iurtth8
	7f1u2gWJlI+1+bGAm097o/06Tp6wV/dI6STMwDSzhM6f3Qq65ecTX4NUMA7yiPOotErw9tIXI97Wm
	0kKXQ7s4OIjq4pRMZwfeVXDUbhow4x8odGLoe70V746YRNB0xi9GcWTN5KoMsv2jtyD7v/zanFUAF
	X4insP9Ah2QNPUSDPMHpyUQ9TYv7Qbafw3O9NRyuUxAwwJD8rRBAgiVxgbg6oXWykumXa2sDCB4sl
	46ArJqXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1syooS-0000000C4RQ-1MOZ;
	Thu, 10 Oct 2024 08:46:24 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1synDA-0000000BmIx-0zfG;
	Thu, 10 Oct 2024 07:03:53 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 1F3E4227A8E; Thu, 10 Oct 2024 09:03:43 +0200 (CEST)
Date: Thu, 10 Oct 2024 09:03:42 +0200
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Cc: Christoph Hellwig <hch@lst.de>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org,
	"linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	"linux-openrisc@vger.kernel.org" <linux-openrisc@vger.kernel.org>,
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org,
	Linux-Arch <linux-arch@vger.kernel.org>,
	Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH] asm-generic: provide generic page_to_phys and
 phys_to_page implementations
Message-ID: <20241010070342.GB6674@lst.de>
References: <20241009114334.558004-1-hch@lst.de> <20241009114334.558004-2-hch@lst.de> <3e12014e-47a7-4cae-bcd1-87d301e1f80c@app.fastmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3e12014e-47a7-4cae-bcd1-87d301e1f80c@app.fastmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241010_000349_458367_7B2682DF 
X-CRM114-Status: GOOD (  25.76  )
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

On Wed, Oct 09, 2024 at 02:06:27PM +0000, Arnd Bergmann wrote:
> This is clearly a good idea, and I'm happy to take that through
> the asm-generic tree if there are no complaints.
> 
> Do you have any other patches that depend on it?

Well, I have new code that would benefit from these helpers, but just
open coding it for now and then doing a swipe to clean that up later
together with the existing open coded versions is easy enough.

> > -/*
> > - * Change "struct page" to physical address.
> > - */
> > -static inline phys_addr_t page_to_phys(struct page *page)
> > -{
> > -	unsigned long pfn = page_to_pfn(page);
> > -
> > -	WARN_ON(IS_ENABLED(CONFIG_DEBUG_VIRTUAL) && !pfn_valid(pfn));
> > -
> > -	return PFN_PHYS(pfn);
> > -}
> 
> This part is technically a change in behavior, not sure how
> much anyone cares.

Well, the only other comment to the patch so far mentioned it.
It also feels like a useful check, but I'm a bit worried about
it triggering in various new places.  Although that's just with
CONFIG_DEBUG_VIRTUAL and probably points to real bugs, so maybe
adding it everywhere is a good idea.

> > +#define page_to_phys(page)	__pfn_to_phys(page_to_pfn(page))
> > +#define phys_to_page(phys)	pfn_to_page(__phys_to_pfn(phys))
> 
> I think we should try to have a little fewer nested macros
> to evaluate here, right now this ends up expanding
> __pfn_to_phys, PFN_PHYS, PAGE_SHIFT, CONFIG_PAGE_SHIFT,
> page_to_pfn and __page_to_pfn. While the behavior is fine,
> modern gcc versions list all of those in an warning message
> if someone passes the wrong arguments.
> 
> Changing the two macros above into inline functions
> would help as well, but may cause other problems.

Doing them as inlines seems useful to me, let me throw that at
the buildbot and see if anything explodes.

> On a related note, it would be even better if we could come
> up with a generic definition for either __pa/__va or
> virt_to_phys/phys_to_virt. Most architectures define one
> of the two pairs in terms of the other, which leads to
> confusion with header include order.

Agreed, but that's a separate project.


