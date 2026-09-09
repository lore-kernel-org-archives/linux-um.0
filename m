Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B586C79FBF
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 16:44:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Bapc0YSkMfnvYk3VlSbyVwcwaxlxEF/qdP5fqXt2FVU=; b=YS7a1KvM5qEQ8LvqQv/58+8eOH
	ufQFNyQzFkcU8Zi/ToUcn53AUIV5/CS6NCP0yOxtoKgA/yXJVgIuR/XTvKSLbhhVI9kDnsIsIoZHJ
	mLZXJgiT4RfbPi+m6JXGw2NCqbiHRuv4ZV2vn8KuP8TLFeyhG+2GkEEgj//kN+5069EqBYbbcNaNM
	92IezyMPrfRpic20RMcaWI9Hu8BB69oxpRnoo2D0J4LtGmhgFygPYXEjEQSy7LzKx4gHFoKNJVh5/
	X3EaEmK5SOCFqQ3fAtF7P27c14qCQ6icYIa5PkHrW72fmAhoFoNmEFDDKucPT8ee2hOc+DdNABUN9
	YZKcbX1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4LPg-0000000CMue-3O1C;
	Wed, 09 Sep 2026 16:44:46 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4LPf-0000000CMsP-0CbW;
	Wed, 09 Sep 2026 16:44:43 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id A729F60202;
	Wed,  9 Sep 2026 16:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F14881F000FF;
	Wed,  9 Sep 2026 16:44:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788972281;
	bh=Bapc0YSkMfnvYk3VlSbyVwcwaxlxEF/qdP5fqXt2FVU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SvkfUBrj+qqUCItjJr4thxIOtrO+WmcNQus9iN7o7fjn21Kjri7ciOsZZbXojK8eq
	 ebmrsmEhjQ8lMe6NScH5NJJVO7FkHjSrPlMJAzs9SeDQJIL0euxfAANelWLDPoYw1X
	 CcSIvP/FGlOivDpnH/QksUP428gC7WgcKMjXSRAyqMHuiTJd6wYCdFyF9iWecTST2l
	 DPfn0SayJdOumRm8EjJ0YaCf7wOVn5AtF52jH/K7lyYBUkf1LvlE8O39pf5s+r01dw
	 hpz3MZmyVQYZqDR+4GQ6n1zp4Q8/XwEUokZ3xCVu0XLtYHfY7rf+QXRgnY7M4GG9HF
	 fN2FuuSzCKwhQ==
Date: Wed, 9 Sep 2026 17:44:16 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Kiryl Shutsemau <kas@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>, 
	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>, 
	Geert Uytterhoeven <geert@linux-m68k.org>, Dinh Nguyen <dinguyen@kernel.org>, 
	Simon Schuster <schuster.simon@siemens-energy.com>, Jonas Bonn <jonas@southpole.se>, 
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, Stafford Horne <shorne@gmail.com>, 
	Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>, 
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, Paul Walmsley <pjw@kernel.org>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Russell King <linux@armlinux.org.uk>, 
	Vineet Gupta <vgupta@kernel.org>, Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>, 
	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>, Nick Piggin <npiggin@gmail.com>, 
	Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, 
	Andreas Larsson <andreas@gaisler.com>, Richard Henderson <richard.henderson@linaro.org>, 
	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Mark Rutland <mark.rutland@arm.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, 
	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Arnd Bergmann <arnd@arndb.de>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, 
	John Hubbard <jhubbard@nvidia.com>, Peter Xu <peterx@redhat.com>, linux-mm@kvack.org, 
	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org, 
	linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org, 
	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, sparclinux@vger.kernel.org, 
	linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, linux-mips@vger.kernel.org, 
	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org, 
	linux-um@lists.infradead.org, Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 11/12] mm: make userland page table freeing RCU-safe
Message-ID: <aqGMqVxJCWbZePmW@gremlin>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-11-1f60b64e878e@kernel.org>
 <aqEivRP0LmJZcgEx@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aqEivRP0LmJZcgEx@thinkstation>
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

On Wed, Sep 09, 2026 at 10:15:13AM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 08, 2026 at 01:32:20PM +0100, Lorenzo Stoakes (ARM) wrote:
> > Now every architecture has been converted to support
> > CONFIG_MMU_GATHER_RCU_TABLE_FREE, this configuration option no longer makes
> > any sense to keep around.
> >
> > Therefore remove it, and remove all the dead code that existed for
> > !CONFIG_MMU_GATHER_RCU_TABLE_FREE architectures previously.
> >
> > Additionally, CONFIG_MMU_GATHER_TABLE_FREE is no longer necessary, as all
> > architectures instead use CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE when a custom
> > __tlb_remove_table() is required, so remove this too.
> >
> > A number of architectures only enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE if
> > CONFIG_MMU was set, however the mmu_gather logic only actually does
> > something meaningful if CONFIG_MMU is set (mmu_gather.c is only compiled in
> > this case, for instance).
> >
> > As a result, there's no need to gate any of this logic on CONFIG_MMU
> > explicitly.
> >
> > CONFIG_PT_RECLAIM however does have a strict dependency on CONFIG_MMU, so
> > make this dependency explicit.
> >
> > Additionally, correct comments to remove references to non-RCU page table
> > gathering and make it clear that this is not 'semi-RCU', nor has it been
> > since commit 1fb3d8c20bfa ("mm/mmu_gather: replace IPI with
> > synchronize_rcu() when batch allocation fails").
> >
> > With this change in place the kernel policy is now that all page tables are
>
> You missed s/all/userspace/ from v1.

Hmm I thought I got this... will fix on respin!

>
> > freed after an RCU grace period, and thus it is now safe to unconditionally
> > perform page table walks under RCU, safe in the knowledge that page tables
> > will not be freed underneath the walker.
>
>
> > @@ -151,24 +148,15 @@
> >   *  This might be useful if your architecture has size specific TLB
> >   *  invalidation instructions.
> >   *
> > - *  MMU_GATHER_TABLE_FREE
> > - *
> > - *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
> > - *  for page directores (__p*_free_tlb()).
> > - *
> > - *  Useful if your architecture has non-page page directories.
> > + *  Page directories (__p*_free_tlb()) are always freed via tlb_remove_table(),
> > + *  after an RCU grace period (see mm/mmu_gather.c).
> >   *
> > - *  When used, an architecture is expected to provide __tlb_remove_table() or
> > - *  use the generic __tlb_remove_table(), which does the actual freeing of these
> > - *  pages.
> > + * This serialises against software page-table walkers, including architectures
> > + * which do not use IPIs for remote TLB invalidates.
>
> Indentation is broken.

Ugh I thought I fixed this before I respun too, doh!

Will fix.

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo

