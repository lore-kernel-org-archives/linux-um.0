Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0A9C624D5
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 17:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RU/XHZsQrPB/KjzCrGwIunh3KbYqDQIpxjG/zB2SrYU=; b=T/p1e+YQ4pdkox6Rj1WiYlQZB/
	5VsIMydGO4i+0bPaWHfJLQeu39y/FgeM9Lm0SvLRtcq/kOITcWB9A3AAHLcphlrVkWUppVBWhp3Uw
	v2g5qA9F51y0HJkCEC0MW5ooIpen+C0PGuk73eJb32GC2ZwzFlZ9T46YzeJV/ia2/4yOXCni4A3XZ
	D5czXRFmHfBqkAMhiLhYLdlyCqydPrr2j28vwsi6mBGzh69FM3czeqhhxgtjiWDe95Tg/OMeQvP2L
	UJihULIV56mL7Km3MqcPaQF5MkiUV5d1DJR/vNX3z6Lbte4/QC0b6wtZZSFPvHcsoGJxiXSQAkMA1
	6VaDmKGw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1SF1-0000000Cp73-3DJd;
	Tue, 01 Sep 2026 17:25:47 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1SEz-0000000Cp6O-0YR4;
	Tue, 01 Sep 2026 17:25:45 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 9F5C86020D;
	Tue,  1 Sep 2026 17:25:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F38E1F000E9;
	Tue,  1 Sep 2026 17:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788283543;
	bh=RU/XHZsQrPB/KjzCrGwIunh3KbYqDQIpxjG/zB2SrYU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=Yi2t1tkD7CbVI2GlNVLMPxmx2y6uQ0N17KQVN6tfdVVmsc8e3U70HKz60pHNwlQs3
	 1uaubu11GEhlMNqEwwCAnmGwy18sQmPBDQlkl4HFerFnkf9qqSXhXZRQB4AbUCIy65
	 +F5eg8cH3mV8+ZyrzWtQ7QlVH0tfsCC88xh+SXAYBAqn1Leh14VC/K7s9GATAG+x4E
	 KI4pAxyEdR503wQD7kpPC4DxKOGSs/zzQQ249JbOJTrJb8Tg6ICIFvJvGHbD91pyny
	 gkZbMWCaIAhY75HIF/43FdM8kRnN6lg6QLV7LnJhpcpnHrbOS/0Iht1oAeMIckn9b0
	 Sr0NCrNgxEH6Q==
Date: Tue, 1 Sep 2026 18:25:26 +0100
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
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <apcJhtvnd45EkjJI@gremlin>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation>
 <apbfzUwBQyxe3P9R@gremlin>
 <apcH74QsR5I-DIbL@thinkstation>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apcH74QsR5I-DIbL@thinkstation>
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

On Tue, Sep 01, 2026 at 06:15:17PM +0100, Kiryl Shutsemau wrote:
> On Tue, Sep 01, 2026 at 03:31:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> > On Tue, Sep 01, 2026 at 02:57:13PM +0100, Kiryl Shutsemau wrote:
> > > On Tue, Sep 01, 2026 at 12:01:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > > index b91b1a98029c..ff8ff3706485 100644
> > > > --- a/mm/pgtable-generic.c
> > > > +++ b/mm/pgtable-generic.c
> > > > @@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
> > > >   * be read-only/read-write protected.
> > > >   *
> > > >   * Note that free_pgtables(), used after unmapping detached vmas, or when
> > > > - * exiting the whole mm, does not take page table lock before freeing a page
> > > > - * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
> > > > - * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
> > > > + * exiting the whole mm, does not take the page table lock before freeing a
> > > > + * table.
> > > > + *
> > > > + * However, the PMD entry is cleared first, and the table freed only after
> > > > + * an RCU grace period, so a walker that mapped the table under
> > > > + * rcu_read_lock() stays safe, and the pmd_same() recheck in
> > > > + * pte_offset_map_lock() detects the teardown.
> > > > + *
> > > > + * Therefore it is safe for "outsiders" like khugepaged to use
> > > > + * pte_offset_map() and co. for VMAs that might be undergoing page table
> > > > + * teardown.
> > >
> > > Is it strictly true?
> > >
> > > free_pte_range() clears the pmd without taking the PTL, so the
> > > pmd_same() recheck in pte_offset_map_lock() can pass and the pmd gets
> > > cleared right after.
> > >
> > > Readers are fine -- __pte_offset_map() holds rcu_read_lock() until
> > > pte_unmap(), so the table cannot go away.
> > >
> > > khugepaged is an odd example here. collapse_pte_mapped_thp() and
> > > retract_page_tables() don't rely on this recheck -- they take pmd_lock()
> > > plus the ptl and do their own pmd_same() under both.
> > >
> > > Can we say walks are safe and leave the write rule where it is?
> >
> > Hmm yeah, ah page tables, what a rabbit hole of horror :)
> >
> > I guess this is effectively a reflection of the 'write lock on write, RCU load
> > on read' pattern in RCU itself generally.
> >
> > So, maybe something like:
> >
> >  * Note that free_pgtables(), used after unampping detached vmas, or when
> >  * exiting the whoel mm, does not take a page table lock before freeing a page
> >  * table.
> >  *
> >  * As page table freeing itself is RCU-safe, page table readers can safely run
> >  * concurrently with page table teardown. However, writers cannot, as without
> >  * a lock nothing prevents concurrent teardown.
> >  */
> >
> > Instead? What do you think?
>
> s/whoel/whole/

Haha yup the inevitable typo...

>
> Otherwise, LGTM.

Thanks! :)

>
> --
>   Kiryl Shutsemau / Kirill A. Shutemov

--
Cheers, Lorenzo

