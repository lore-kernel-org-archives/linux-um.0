Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF4E2C79FAD
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 11:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=inNJzZhlDskfV4tobMRa6NUvX+KktI2JxAaJsuypEcU=; b=PAs1b73EOZBZFGecYEHseVFwfc
	A8y46A9ppuMrM8XS2hAWABkNtkFSzHaYaudm4b+RUZky73NOHkQrr5LGCE5in6MNsk04IBmsV1NSF
	3qVJML1PoVLaZNBmsE2bvAuVpHBn0pjrOCH90j85M/rp/K3/RU0AuA/9EcO8TLOGntuXfFL0OfArk
	xjM/25dNhXJD7OjTb7wkFy0SVQyfm+r1ikg9uhqeijA7DzzLJFTMnbPUQ2yPSJIYZw5OrIOH4wXuv
	y0zD9Z4rH5RszAf6nbEeJgc/tlvDXBcVVNRWSe775LaMMhNAvk+bWEZMNhExoBw9fjP+7txnTuckA
	LAJ5Y48g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4GQX-0000000BYzu-0XmN;
	Wed, 09 Sep 2026 11:25:17 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4GQU-0000000BYzG-1hgI;
	Wed, 09 Sep 2026 11:25:15 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 08BF160211;
	Wed,  9 Sep 2026 11:25:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA8571F00A3D;
	Wed,  9 Sep 2026 11:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788953112;
	bh=inNJzZhlDskfV4tobMRa6NUvX+KktI2JxAaJsuypEcU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=YCsVcikzxNnvBT0Y3c5qUMcZq6CnjiF9LAucMz9KUDz/X8rycnl20TJiMBuTV44C6
	 ciuJ5X0Mary0o+RdhTl8tWHSISMo1lGTn+IXwhIQfs7dZg1NC//UvrgDFVVFH2BXXg
	 wGSvIxQ/NBgeVTkoO77PEhxG5tF/kt0hk770YdbvA7jzYldeFCi6gaAA3Ie47dGZ4o
	 rDioSU8ROD/U0Ex4wV585kl0B6XRkVhfL48+PBTUa/l0vXguhxnOvt9I9np0ualYy6
	 L7k5zESC+bnaJX5hWbMNkzgmSv0XEtgXO0Eiy5hQl/cIt/eJwNjq2z/FZB7YFfjxHL
	 0pO6lgM9ge/7g==
Date: Wed, 9 Sep 2026 12:24:48 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, "Liam R. Howlett" <liam@infradead.org>, 
	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, 
	Barry Song <baohua@kernel.org>, Lance Yang <lance.yang@linux.dev>, 
	Usama Arif <usama.arif@linux.dev>, Kiryl Shutsemau <kas@kernel.org>, Guo Ren <guoren@kernel.org>, 
	Brian Cain <bcain@kernel.org>, Geert Uytterhoeven <geert@linux-m68k.org>, 
	Dinh Nguyen <dinguyen@kernel.org>, Simon Schuster <schuster.simon@siemens-energy.com>, 
	Jonas Bonn <jonas@southpole.se>, Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>, 
	Stafford Horne <shorne@gmail.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, 
	Rich Felker <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>, 
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, 
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, 
	Russell King <linux@armlinux.org.uk>, Vineet Gupta <vgupta@kernel.org>, 
	Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>, 
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
Subject: Re: [PATCH v2 00/12] mm: make userland page table freeing RCU-safe
Message-ID: <aqFBXNYGa5cktCeJ@gremlin>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908141543.8180b60400d38b70d249949b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908141543.8180b60400d38b70d249949b@linux-foundation.org>
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

On Tue, Sep 08, 2026 at 02:15:43PM -0700, Andrew Morton wrote:
> On Tue, 08 Sep 2026 13:32:09 +0100 "Lorenzo Stoakes (ARM)" <ljs@kernel.org> wrote:
>
> > The majority of architectures in the kernel defer page table freeing until
> > an RCU grace period has elapsed, this series converts all remaining
> > architectures to do so too and eliminates CONFIG_MMU_GATHER_RCU_TABLE_FREE
> > altogether.
> >
> > This is important because it enables safe lockless page table walking under
> > RCU alone.
> >
> > Doing so allows for reduced lock contention, avoids lock ordering concerns
> > and enables fast, efficient and correct page table walking as a result.
> >
> > Additionally it removes a bunch of code and architecture-specific behaviour
> > which is always a beneficial thing to do.
>
> Thanks.  It's early and unreviewed, but this is mainly an
> if-it-compiles-its-good thing, so I'll add it for exposure to the
> build/checker universe.

Yeah largely, and I have done additional testing for cases which need it.

>
> > However some arches required extra attention - sh-X2, m68k-motorola and
> > sparc32.
>
> OK.  Please lmk later if you think additional reviewer/tester attention
> is desirable in these areas.

Only really the fancier sparc32 setup which can't be emulated [there's a call
out in the cover for that one!] :) though sashiko found an issue with that that
is now fixed.

The other two I boot tested locally under emulation with no issues :)

>

--
Cheers, Lorenzo

