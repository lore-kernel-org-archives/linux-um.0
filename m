Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9526FC28B2F
	for <linux-um@archiver.kernel.org>; Tue, 11 Mar 2025 06:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qfQ8fQV+HqU0Qyc/Dri7YXItrVPHcO+rnRFfjqJQ+Js=; b=IBeY+SVEJYTFb+/ovAnaWwzKNx
	AwODiqx5S9wAzWHsgfQyhyT2HjEv1GoP7qARoPgu78Tm5t2cYMvkSC7DSxgFhjJkRRGIHRHfimU+E
	MNy1m9Wi08k1utfplalNVrScgqAE6+Rb4LvRgyCXFtXiU6A8JvUfxdP4gjhy11K2cxIrXNxr1OYDz
	pWvHglL9ak0oJR71Bg4660y0rLnRFpVkWiKst59oauP5WQQd+FowFC4Ypf+XXs7NYO1QOAT5caFGt
	+EXAJPJwmkaxizaGfLKtYR+/R3H7X5J+646IRPhUUaNqyXpFgzetPG35WX0r8Y+8E2LxCxQHn4b1H
	lEha90fQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1trshW-00000004i9i-1PAt;
	Tue, 11 Mar 2025 06:02:50 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1trsbH-00000004gWJ-3zUE;
	Tue, 11 Mar 2025 05:56:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id D3DBF5C4D94;
	Tue, 11 Mar 2025 05:54:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D93EC4CEED;
	Tue, 11 Mar 2025 05:56:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741672582;
	bh=JR5aE1/6W9bEsH29C5z708XdvBh3y3whu03ldRN1cT0=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=f48a7jPdRs+4CFxnOQTPCHsm75344xXl4kGcXGjsNF7CXHD6rakA6cXBClsJrVEtn
	 WMcp4MDOS6ujAbPjNce+g3L+xfZC5vi4RqizMWw2e621BlT1F9Ay/Loxsxa26BilyR
	 V3RuJvI1gFKwfV3U+Q95PUC/u4Gy4+xVTdXkrb9dHTeavvebfTfgzz2yhmQ89ydU2G
	 kiwkfL2BapKmKWzCToyXgMHRmDr7W8auvyr26g/1+MWMbdjrYYGY9Pgy3JpC8H5B/G
	 ocFRu6iz+c47Alu4XK27RyF2DFlSe0JprTDW9yyHuXhbUMDy3L4Bzl+ZBGVJfIovu1
	 qQCLqsddFmhPA==
Date: Tue, 11 Mar 2025 07:55:55 +0200
From: Mike Rapoport <rppt@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Andreas Larsson <andreas@gaisler.com>,
	Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Borislav Petkov <bp@alien8.de>, Brian Cain <bcain@kernel.org>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"David S. Miller" <davem@davemloft.net>,
	Dinh Nguyen <dinguyen@kernel.org>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Guo Ren <guoren@kernel.org>, Helge Deller <deller@gmx.de>,
	Huacai Chen <chenhuacai@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Jiaxun Yang <jiaxun.yang@flygoat.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Matt Turner <mattst88@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Michal Simek <monstr@monstr.eu>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Peter Zijlstra <peterz@infradead.org>,
	Richard Weinberger <richard@nod.at>,
	Russell King <linux@armlinux.org.uk>,
	Stafford Horne <shorne@gmail.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Thomas Gleixner <tglx@linutronix.de>,
	Vasily Gorbik <gor@linux.ibm.com>, Vineet Gupta <vgupta@kernel.org>,
	Will Deacon <will@kernel.org>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-snps-arc@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, linux-csky@vger.kernel.org,
	linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
	linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
	linux-openrisc@vger.kernel.org, linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org
Subject: Re: [PATCH 07/13] s390: make setup_zero_pages() use memblock
Message-ID: <Z8_Qawg0dGtZdys7@kernel.org>
References: <20250306185124.3147510-1-rppt@kernel.org>
 <20250306185124.3147510-8-rppt@kernel.org>
 <20250307152815.9880Gbd-hca@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250307152815.9880Gbd-hca@linux.ibm.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250310_225624_094369_6A07DD0C 
X-CRM114-Status: GOOD (  25.20  )
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

On Fri, Mar 07, 2025 at 04:28:15PM +0100, Heiko Carstens wrote:
> On Thu, Mar 06, 2025 at 08:51:17PM +0200, Mike Rapoport wrote:
> > From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
> > 
> > Allocating the zero pages from memblock is simpler because the memory is
> > already reserved.
> > 
> > This will also help with pulling out memblock_free_all() to the generic
> > code and reducing code duplication in arch::mem_init().
> > 
> > Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> > ---
> >  arch/s390/mm/init.c | 14 +++-----------
> >  1 file changed, 3 insertions(+), 11 deletions(-)
> 
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
> 
> > -	empty_zero_page = __get_free_pages(GFP_KERNEL | __GFP_ZERO, order);
> > +	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
> >  	if (!empty_zero_page)
> >  		panic("Out of memory in setup_zero_pages");
> 
> This could have been converted to memblock_alloc_or_panic(), but I
> guess this can also be done at a later point in time.

Duh, I should have remembered about memblock_alloc_or_panic() :)

@Andrew, can you please pick this as a fixup?

From 344fec8519e5152c25809c9277b54a68f9cde0e9 Mon Sep 17 00:00:00 2001
From: "Mike Rapoport (Microsoft)" <rppt@kernel.org>
Date: Tue, 11 Mar 2025 07:51:27 +0200
Subject: [PATCH] s390: use memblock_alloc_or_panic() in setup_zero_page()

Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
---
 arch/s390/mm/init.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/s390/mm/init.c b/arch/s390/mm/init.c
index ab8ece3c41f1..c6a97329d7e7 100644
--- a/arch/s390/mm/init.c
+++ b/arch/s390/mm/init.c
@@ -81,9 +81,7 @@ static void __init setup_zero_pages(void)
 	while (order > 2 && (total_pages >> 10) < (1UL << order))
 		order--;
 
-	empty_zero_page = (unsigned long)memblock_alloc(PAGE_SIZE << order, order);
-	if (!empty_zero_page)
-		panic("Out of memory in setup_zero_pages");
+	empty_zero_page = (unsigned long)memblock_alloc_or_panic(PAGE_SIZE << order, order);
 
 	zero_page_mask = ((PAGE_SIZE << order) - 1) & PAGE_MASK;
 }
-- 
2.47.2


-- 
Sincerely yours,
Mike.

