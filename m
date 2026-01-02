Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C669BFA3728
	for <linux-um@archiver.kernel.org>; Fri,  2 Jan 2026 06:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=I0saHnqZE8DNUz3Eq4POw6LWeguXVeLKnWvje6WQ15M=; b=LNpvPUqnivRDMu9Ca3GBFJJA3T
	4onzC96xjBu9Y3y6uIWBANusp5n0kQYgjkvpLKLgyhQYku6A+Uz65JnCwRZYldQPs3d6tWBh7H3iu
	WPqxaJQbTDC+NRNv3i/9ydIz3RdQCBJ58awiYLFWWPf6wS7UqlxRYb1MggW6Qv79Qw5Gk+U2I6qnO
	pKtk8pAES6QIJYk4ntVcoLPC5nCxbWjNxNsXWWcwUL5JPaRR5Qd8Am5lmtFnWbcWqqlQuu90enE2F
	cuv8qCNDkaF7oZXjAcxRqAUkv+LL3+HBZ1wbEZCKati9k47hLGZNQUaTT7cq39/erVVxAP9N06i1f
	PAV9ptvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbZ8R-00000007rm8-0XyI;
	Fri, 02 Jan 2026 06:59:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vbZ8M-00000007rl8-16lA;
	Fri, 02 Jan 2026 06:59:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6490F439EC;
	Fri,  2 Jan 2026 06:59:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09B4AC116B1;
	Fri,  2 Jan 2026 06:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767337175;
	bh=6UamW9ypeYvnLArvWXDR1zXy9G1XczNWSIs66XcI5UY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JURDexdXezRaYfVCWbUaXW3lzvXlm31RIqEgAxJWeFjD7mvppUL+nB5Q6DW/syoE7
	 9KCN3XX0+IFrZ6lXHKvj23Zbubf1juMpQoyVR3R5K+W0wTXoTePytdymIvKf7/FuUt
	 b7F7Op6aP4W0iuoMzjx2QqloKghcV05PUK7YhWlqmCDHRezSFJ5+E+XxOvd9U94KrO
	 yMpXKhnr9xm6zugptlmyDIWLkIzbYaeb0b/lyAP5EPPZjPoSkHAZCyI/7qGe07Bh3c
	 ZF/OMYqQXU+WaQeAzqytLFSZafleWXTxSNL1jQdGV6O5YweZiL0UFX3Jm+OycztA8g
	 kFuOhUi2qJ56g==
Date: Fri, 2 Jan 2026 08:59:12 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alex Shi <alexs@kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>,
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
Subject: Re: [PATCH 00/28] arch, mm: consolidate hugetlb early reservation
Message-ID: <aVdswNM9PUN6Kr8Q@kernel.org>
References: <20251228124001.3624742-1-rppt@kernel.org>
 <20251231172714.a7fe44e856c14fdc8fe1cb43@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251231172714.a7fe44e856c14fdc8fe1cb43@linux-foundation.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260101_225938_671500_E09AAF6C 
X-CRM114-Status: GOOD (  28.65  )
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

On Wed, Dec 31, 2025 at 05:27:14PM -0800, Andrew Morton wrote:
> On Sun, 28 Dec 2025 14:39:30 +0200 Mike Rapoport <rppt@kernel.org> wrote:
> 
> > Order in which early memory reservation for hugetlb happens depends on
> > architecture, on configuration options and on command line parameters.
> > 
> > Some architectures rely on the core MM to call hugetlb_bootmem_alloc()
> > while others call it very early to allow pre-allocation of HVO-style
> > vmemmap.
> > 
> > When hugetlb_cma is supported by an architecture it is initialized during
> > setup_arch() and then later hugetlb_init code needs to understand did it
> > happen or not.
> > 
> > To make everything consistent and unified, both reservation of hugetlb
> > memory from bootmem and creation of CMA areas for hugetlb must be called
> > from core MM initialization and it would have been a simple change.
> > However, HVO-style pre-initialization ordering requirements slightly
> > complicate things and for HVO pre-init to work sparse and memory map should
> > be initialized after hugetlb reservations.
> > 
> > This required pulling out the call to free_area_init() out of setup_arch()
> > path and moving it MM initialization and this is what the first 23 patches
> > do.
> > 
> > These changes are deliberately split into per-arch patches that change how
> > the zone limits are calculated for each architecture and the patches 22 and
> > 23 just remove the calls to free_area_init() and sprase_init() from arch/*.
> > 
> > Patch 24 is a simple cleanup for MIPS.
> > 
> > Patches 25 and 26 actually consolidate hugetlb reservations and patches 27
> > and 28 perform some aftermath cleanups.
> 
> Thanks for the diligence - this can't have been the most exciting thing
> to work on!
> 
> > I tried to trim the distribution list and although it's still quite long
> > if you feel that someone was wrongly excluded please add them back.
> 
> I'll add these to mm.git's mm-new branch for some testing.  I'll
> suppress the usual email storm because 41 * 28 is a lot of emails ;)

kbuild reported failures on some configurations so I'm anyway going to send
a lot of emails for v2 :)

-- 
Sincerely yours,
Mike.

