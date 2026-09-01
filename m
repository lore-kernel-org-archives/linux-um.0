Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 326CBC61DD3
	for <linux-um@archiver.kernel.org>; Tue,  1 Sep 2026 17:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FGNWee/yfyIYUeq0phNhaEpYpUuczRbQOv0XGs51Szs=; b=MKmsNtFZFbQCoDuooKY/E8MJNe
	3QwWXUaPjCq4QSAmvVpAag756tXL7MD2D6Poi9V98LUaTW+nzUbAu/Gt3m3p949JhLbhaFfzmdcWF
	dkHOGxxiDFQDEqC5TxZzcCsy7mYyej1ye8dk7oD0uFEbJxWkd6Lk1H2Sl4/TxMqCRyDx+5vE2LTVi
	HXh+pGXzEArffyiaQOnBe5rbeBLPBBfj2Dvgj5YNA6YyWL4OfrFGdiXwCtztCceqk/lqU4q/i9DR6
	vNezC616luR8KBTtw6cScwI3HfhWFp+/OeNxwZkarLr2rQICuERfsjoqzRUK+PJGPHgrz/1dENbEu
	la0pznMA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1S5I-0000000Cn5O-2bgd;
	Tue, 01 Sep 2026 17:15:44 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x1S5G-0000000Cn4i-2efP;
	Tue, 01 Sep 2026 17:15:42 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 4FE9943875;
	Tue,  1 Sep 2026 17:15:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0181F00A3A;
	Tue,  1 Sep 2026 17:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788282942;
	bh=FGNWee/yfyIYUeq0phNhaEpYpUuczRbQOv0XGs51Szs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=RIXa8dZkzMG2REHgA+VDAVKolhCMPi+Irdr20SxXJMX7HMyXOMlIZP78yNzX5WGK9
	 2Q4fXWAmZrvB514yG3zy5S8VLVpqQ3vQkgHOehuxKNoTERFFWTW4+QLvqN20efYMvx
	 C3unqe6ijhgX3ovf1O8T9Vz9+k4UMWd/bYoJTnhtxLRd4Kgy/9lp+XCWbYXgMalSOY
	 nrPiTr7Yh8PLixNUIX1V0R4kTFgkjX2hngNjLdW0hS5WPPS3VopfDXq68957fjP1n+
	 WFiWsZyfSI61wWrG8R+nmkPCKmtMMrQguU2YX4lBdcYCQjfVs2NOssv9ZhspqUsm//
	 Rg36srZr7tcEQ==
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfauth.ams.internal (Postfix) with ESMTP id 8D10B1980082;
	Tue,  1 Sep 2026 13:15:21 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Tue, 01 Sep 2026 13:15:36 -0400
X-ME-Sender: <xms:KAiXamaWurlDWcSWtiiI_a8Lcfn91lpmibrmHgLKZ6ypEgYGgUt4tg>
    <xme:KAiXarwzI-qXlEY39EylIjZLSRQmv6T2YJJlC7pBrl-WfQSDaeds8uYj56TGi28LW
    lvu44LT0krOxbglBo974viVzoKsnxOQiDnBrYXcWz59mggZdBV4yEMQ>
X-ME-Received: <xmr:KAiXalWBs4NrLqXlTlwp0u3zvZXANRO3tSUHxaylIfQKC8ElPGDWAJQ9itc>
X-ME-Proxy-Cause: dmFkZTEYX5efotjdzBxG3ALFHNBriUAjRl1NaDQcBbtf545JlTWl8puARyoc1M48QLkTle
    Zy+DNI48newDPVlWImF1Faw5W1GdOvkG331QFNWqXsS36x8nYIvZkExZ02FyZDNo3imqSO
    vx+6PbbCZjIWTmWK3f9wDaPsdOrKllg3nPiDeTujNg7QScH79PdB1/uzR6LCnWC3G64VYn
    GHMdJtZr7tl3naSkkwKGVvaRI3xNIM1Vpn9wQM1eNoqT7XIGThtVtOA+q2qz2+cjtaTpZj
    qEM5PDu25TZmRuhbx6DVTKRpS6Xkl1hJA5Lrjt0ldQvhD92NmcHWzFHmiu5NS/Ddrh91RS
    oEIYoI6jcBVZRYEqPIQ3YWxmK7df4Xai0OPDkg2MfU9DIhhXQx3bsZyOPdYoBu1fZzi3mI
    9COKHxpd51axawUzzdPbbHo4qFiQXCsINSt5OTD8o2xsQivlbyxj6NFVUlP4m225t89xIR
    dJ5apX7XlKEtt4HhCJ9eBLLmWDTmsQzhqfdzCVOyy89B/ed+iZD0tvpmPkm8HXDlmFmgUX
    pI+m2W4cNU8lg3Mlsu1jG0yzbdxBrZA1C5l94jk+JqKA2fZ/+87Dm/Bai+4A0tSdNZXigK
    1YTCuTPU5tr3c9qwCJxPS8mFmNq97ErTQXKYdjvem1U1fQYobqoM2g+1Krcg
X-ME-Proxy: <xmx:KQiXav4pWFuyTgFAhbzVsukM2InctHMMf5E4KwRh2L53m9-W8MpSmw>
    <xmx:KQiXatUBtjn6n3-i-vWEuVZzfqmIQzC6k_DG1rn628nvEiKBCu-HvQ>
    <xmx:KQiXal5jB87KLgjgKNo3_zppQxD0Dv25MMvSTMtfoGVpBmJxAI4ywg>
    <xmx:KQiXakkzMZzUmAt3b-3WpwA8iMAsSzmNzZjVeX-fJEA7W_zTyKoJaQ>
    <xmx:KQiXanZv46oZZYjbuhaIstn0oU5BW-0SoVImP3l6ujABxChFibnEYBig>
Feedback-ID: i10464835:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Sep 2026 13:15:18 -0400 (EDT)
Date: Tue, 1 Sep 2026 18:15:17 +0100
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
Subject: Re: [PATCH 12/12] mm: change the contract for free_pgtables(),
 update docs
Message-ID: <apcH74QsR5I-DIbL@thinkstation>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-12-5456a81c8212@kernel.org>
 <apbUpMDJglS99_yK@thinkstation>
 <apbfzUwBQyxe3P9R@gremlin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <apbfzUwBQyxe3P9R@gremlin>
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

On Tue, Sep 01, 2026 at 03:31:26PM +0100, Lorenzo Stoakes (ARM) wrote:
> On Tue, Sep 01, 2026 at 02:57:13PM +0100, Kiryl Shutsemau wrote:
> > On Tue, Sep 01, 2026 at 12:01:32PM +0100, Lorenzo Stoakes (ARM) wrote:
> > > diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
> > > index b91b1a98029c..ff8ff3706485 100644
> > > --- a/mm/pgtable-generic.c
> > > +++ b/mm/pgtable-generic.c
> > > @@ -386,9 +386,21 @@ pte_t *pte_offset_map_rw_nolock(struct mm_struct *mm, pmd_t *pmd,
> > >   * be read-only/read-write protected.
> > >   *
> > >   * Note that free_pgtables(), used after unmapping detached vmas, or when
> > > - * exiting the whole mm, does not take page table lock before freeing a page
> > > - * table, and may not use RCU at all: "outsiders" like khugepaged should avoid
> > > - * pte_offset_map() and co once the vma is detached from mm or mm_users is zero.
> > > + * exiting the whole mm, does not take the page table lock before freeing a
> > > + * table.
> > > + *
> > > + * However, the PMD entry is cleared first, and the table freed only after
> > > + * an RCU grace period, so a walker that mapped the table under
> > > + * rcu_read_lock() stays safe, and the pmd_same() recheck in
> > > + * pte_offset_map_lock() detects the teardown.
> > > + *
> > > + * Therefore it is safe for "outsiders" like khugepaged to use
> > > + * pte_offset_map() and co. for VMAs that might be undergoing page table
> > > + * teardown.
> >
> > Is it strictly true?
> >
> > free_pte_range() clears the pmd without taking the PTL, so the
> > pmd_same() recheck in pte_offset_map_lock() can pass and the pmd gets
> > cleared right after.
> >
> > Readers are fine -- __pte_offset_map() holds rcu_read_lock() until
> > pte_unmap(), so the table cannot go away.
> >
> > khugepaged is an odd example here. collapse_pte_mapped_thp() and
> > retract_page_tables() don't rely on this recheck -- they take pmd_lock()
> > plus the ptl and do their own pmd_same() under both.
> >
> > Can we say walks are safe and leave the write rule where it is?
> 
> Hmm yeah, ah page tables, what a rabbit hole of horror :)
> 
> I guess this is effectively a reflection of the 'write lock on write, RCU load
> on read' pattern in RCU itself generally.
> 
> So, maybe something like:
> 
>  * Note that free_pgtables(), used after unampping detached vmas, or when
>  * exiting the whoel mm, does not take a page table lock before freeing a page
>  * table.
>  *
>  * As page table freeing itself is RCU-safe, page table readers can safely run
>  * concurrently with page table teardown. However, writers cannot, as without
>  * a lock nothing prevents concurrent teardown.
>  */
> 
> Instead? What do you think?

s/whoel/whole/

Otherwise, LGTM.

-- 
  Kiryl Shutsemau / Kirill A. Shutemov

