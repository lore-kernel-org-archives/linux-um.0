Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04841C79FAD
	for <linux-um@archiver.kernel.org>; Wed,  9 Sep 2026 09:15:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WMLhSTvOXcO1Feh9yCp+cQisLkpmflOTkHs5UzK+oYo=; b=0WfNVRHzVoTEqDAklLwVMCHhCC
	l2IJ0uptZLlw0QWoCqEgNiosRGXBlHYAfOfBpdpGCesGXDBT8OoH17fjv9fxl8wSR8Zn4bXvt3OOr
	P3j9EDvmWbBimDmzrIzxxpQzQ6Nnfcj0j2SwwmR7536NTPhMSilCNY4TdOjvWk0ksl2Rc4TcY5yu0
	sSwXuI4aVZtsx/u+UPXmuKCkRWvU7Jdmw8muiJXdlK6ogXKW/y2JjwlW1hHKzcvEpjcmg9sJ/kq8u
	51xFoaawU+6bMUF71VWkVu1oiF3OKzi9bouyJmw7NQInAy3NwCvqQAFqq1cGJZlczu2n68DKfnV3E
	QZD4pHQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EPB-0000000BGGV-16bO;
	Wed, 09 Sep 2026 09:15:45 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4EP5-0000000BGEJ-3qMi;
	Wed, 09 Sep 2026 09:15:39 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 154F744095;
	Wed,  9 Sep 2026 09:15:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E7981F00A3F;
	Wed,  9 Sep 2026 09:15:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788945339;
	bh=WMLhSTvOXcO1Feh9yCp+cQisLkpmflOTkHs5UzK+oYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Pc0mftNOGdEc0Jfw1CtI27FfIQdaxAWsEoGtS00NSboMWgpgq6kMB1PacEkMsCWVE
	 PyBSbte/xncgLgVpiZhfgsZGVbt+xRz3Hc8kbcATJH7G3L2lJ8aalj/R+Aqd6dmX5b
	 5eg5id4TZ80FMMxsUU2JhjgG1tYJRqytdCJUhIr89SM9fK++Q2AG0nlQDtmg/8dhUN
	 0IyRNrUW4GQusS5tQLUvQke7ZfU0WLTad249E94UR52ddvrJGL2nfYN7rtII5ZqTNh
	 iI75Q95afgEguW3TjBoNFF2XDSC2ycRoFQVeNeDMOy9GE8TTAngS8Q4tHYSzej4vlC
	 2tOKgwOhoDyjQ==
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8E752198003A;
	Wed,  9 Sep 2026 05:15:16 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-02.internal (MEProxy); Wed, 09 Sep 2026 05:15:32 -0400
X-ME-Sender: <xms:pCOhapxWpL0GHjdR-LbSmt6pcF7cQoj_8cQ33xSeM7XCtFENM-sJEw>
    <xme:pCOharWahP24PRQXVvE8eeNQnV55db4J_vp16cj_Z8GibP0d05qa3LF6G7CXPobAn
    HafKDVhWfjWxnJEZOfi_ZDCv10ZgG4I_C318m3ajUCuz5cvYfve_vGy>
X-ME-Received: <xmr:pCOhat43rLqB-KpS4v-iRR2MbmJvziGj4K3533xcWcE-RHBMlP2xBju_wd0>
X-ME-Proxy-Cause: dmFkZTFpC8WONluUuvc7dpKb99eg92DQ33MSjEt2sNv2fC237wiMixhMca33e2LldrnTRH
    U75C+KLC/q/LoK5zKzpXIyjFwS1b+E/++uY5aiYodIxAbg9BZ6O3CC6cd1SXYaFEulw8KR
    jAI6ffm11DtQZdknyCWUWVFfuLXw2xt2y4TrUuW5CEhhTR/K3eTVLpp8QK1B0crMmfDXeu
    uwu487939XxAxC04N1S97FZttc+sKd0M0bqZu5+zU/yY2Z2X+w/t7eOM75eiUIDwrFyGW9
    VO3+XGBW9eUcOQwzMaEf6se6jBI4E1kU1BTvjozT7XN+z/WzRNjCEoYCcDV/y4SRQAjlN1
    UJij+//6ITDtj0vpJtsxh3nZgt0K5pHTh0hy5Hu48Cov+xYJKliDjhUO5TEvuCAqjsq3SO
    OxyGdCaNbHBZZb7IXgcT+pITOfdPxsCPlJyBoTr8Le9pMNL/ZTHnXi+/DIJXF17DMcWZIh
    YM5LVoGds+47feWKyzGfEzTv1rFYfFtyh3h/v0wuQgBr2xOdBApwONTAMblqFbOLbUS27j
    NPYBYul31i/zyEEbO83Lgkbp30doOoaMXPcKhFs3Rw8N2hrubUNjgoPgAP5Spz0uSYcxe2
    FDFitH4FhEvRxWxK0irW8E1NKmcImw4MXKQVOJjCI5K3tVhOemySCLVfbAmA
X-ME-Proxy: <xmx:pCOhajUqd18ClRcyZhFPHIYrAAp0-S3k_bVdXd6KZXOebWFu8gPWvw>
    <xmx:pCOhaj7UC-S4UPOWxzOF-A3gNv5YI2PWLCUOMVoriXtNaMxfx7RKrw>
    <xmx:pCOhaqmC_kf4Hp2GOeEHEjH5DxULoNK2H7t84K4BezfXKcQz_belGg>
    <xmx:pCOhalZ7HrNwAby95sPa7N21RVub9YHPEGD6aBYbpelxVLHh1XK2sw>
    <xmx:pCOhauEse5Mk8Ax8FZCi-GcbyLxH-H4DbMf7YweCkQjDO4jCkVmia0fm>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Sep 2026 05:15:14 -0400 (EDT)
Date: Wed, 9 Sep 2026 10:15:13 +0100
From: Kiryl Shutsemau <kas@kernel.org>
To: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
Cc: Andrew Morton <akpm@linux-foundation.org>,
 	David Hildenbrand <david@kernel.org>, Zi Yan <ziy@nvidia.com>,
 	Baolin Wang <baolin.wang@linux.alibaba.com>,
 "Liam R. Howlett" <liam@infradead.org>,
 	Nico Pache <nico.pache@linux.dev>, Ryan Roberts <ryan.roberts@arm.com>,
 Dev Jain <dev.jain@arm.com>, 	Barry Song <baohua@kernel.org>,
 Lance Yang <lance.yang@linux.dev>, 	Usama Arif <usama.arif@linux.dev>,
 Guo Ren <guoren@kernel.org>, Brian Cain <bcain@kernel.org>,
 	Geert Uytterhoeven <geert@linux-m68k.org>,
 Dinh Nguyen <dinguyen@kernel.org>,
 	Simon Schuster <schuster.simon@siemens-energy.com>,
 Jonas Bonn <jonas@southpole.se>,
 	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
 Stafford Horne <shorne@gmail.com>,
 	Yoshinori Sato <ysato@users.sourceforge.jp>,
 Rich Felker <dalias@libc.org>,
 	John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 Paul Walmsley <pjw@kernel.org>, 	Palmer Dabbelt <palmer@dabbelt.com>,
 Albert Ou <aou@eecs.berkeley.edu>, 	Alexandre Ghiti <alex@ghiti.fr>,
 Russell King <linux@armlinux.org.uk>, 	Vineet Gupta <vgupta@kernel.org>,
 Michal Simek <monstr@monstr.eu>, Chris Zankel <chris@zankel.net>,
 	Max Filippov <jcmvbkbc@gmail.com>, Will Deacon <will@kernel.org>,
 	"Aneesh Kumar K.V" <aneesh.kumar@kernel.org>,
 Nick Piggin <npiggin@gmail.com>, 	Peter Zijlstra <peterz@infradead.org>,
 "David S. Miller" <davem@davemloft.net>,
 	Andreas Larsson <andreas@gaisler.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 	Matt Turner <mattst88@gmail.com>, Magnus Lindholm <linmag7@gmail.com>,
 	Catalin Marinas <catalin.marinas@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>,
 	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 	Helge Deller <deller@gmx.de>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 	Michael Ellerman <mpe@ellerman.id.au>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
 	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 	Alexander Gordeev <agordeev@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 	Sven Schnelle <svens@linux.ibm.com>,
 Richard Weinberger <richard@nod.at>,
 	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>,
 	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
 "H. Peter Anvin" <hpa@zytor.com>, 	Arnd Bergmann <arnd@arndb.de>,
 Vlastimil Babka <vbabka@kernel.org>, 	Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, 	Michal Hocko <mhocko@suse.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, 	John Hubbard <jhubbard@nvidia.com>,
 Peter Xu <peterx@redhat.com>, linux-mm@kvack.org,
 	linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org,
 linux-hexagon@vger.kernel.org, 	linux-m68k@lists.linux-m68k.org,
 linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
 	linux-riscv@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 	linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org,
 sparclinux@vger.kernel.org, 	linux-alpha@vger.kernel.org,
 loongarch@lists.linux.dev, linux-mips@vger.kernel.org,
 	linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-s390@vger.kernel.org, 	linux-um@lists.infradead.org,
 Hugh Dickins <hughd@google.com>, Qi Zheng <qi.zheng@linux.dev>
Subject: Re: [PATCH v2 11/12] mm: make userland page table freeing RCU-safe
Message-ID: <aqEivRP0LmJZcgEx@thinkstation>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-11-1f60b64e878e@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-11-1f60b64e878e@kernel.org>
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

On Tue, Sep 08, 2026 at 01:32:20PM +0100, Lorenzo Stoakes (ARM) wrote:
> Now every architecture has been converted to support
> CONFIG_MMU_GATHER_RCU_TABLE_FREE, this configuration option no longer makes
> any sense to keep around.
> 
> Therefore remove it, and remove all the dead code that existed for
> !CONFIG_MMU_GATHER_RCU_TABLE_FREE architectures previously.
> 
> Additionally, CONFIG_MMU_GATHER_TABLE_FREE is no longer necessary, as all
> architectures instead use CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE when a custom
> __tlb_remove_table() is required, so remove this too.
> 
> A number of architectures only enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE if
> CONFIG_MMU was set, however the mmu_gather logic only actually does
> something meaningful if CONFIG_MMU is set (mmu_gather.c is only compiled in
> this case, for instance).
> 
> As a result, there's no need to gate any of this logic on CONFIG_MMU
> explicitly.
> 
> CONFIG_PT_RECLAIM however does have a strict dependency on CONFIG_MMU, so
> make this dependency explicit.
> 
> Additionally, correct comments to remove references to non-RCU page table
> gathering and make it clear that this is not 'semi-RCU', nor has it been
> since commit 1fb3d8c20bfa ("mm/mmu_gather: replace IPI with
> synchronize_rcu() when batch allocation fails").
> 
> With this change in place the kernel policy is now that all page tables are

You missed s/all/userspace/ from v1.

> freed after an RCU grace period, and thus it is now safe to unconditionally
> perform page table walks under RCU, safe in the knowledge that page tables
> will not be freed underneath the walker.


> @@ -151,24 +148,15 @@
>   *  This might be useful if your architecture has size specific TLB
>   *  invalidation instructions.
>   *
> - *  MMU_GATHER_TABLE_FREE
> - *
> - *  This provides tlb_remove_table(), to be used instead of tlb_remove_page()
> - *  for page directores (__p*_free_tlb()).
> - *
> - *  Useful if your architecture has non-page page directories.
> + *  Page directories (__p*_free_tlb()) are always freed via tlb_remove_table(),
> + *  after an RCU grace period (see mm/mmu_gather.c).
>   *
> - *  When used, an architecture is expected to provide __tlb_remove_table() or
> - *  use the generic __tlb_remove_table(), which does the actual freeing of these
> - *  pages.
> + * This serialises against software page-table walkers, including architectures
> + * which do not use IPIs for remote TLB invalidates.

Indentation is broken.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

