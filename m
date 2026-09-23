Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 846ECC9830B
	for <linux-um@archiver.kernel.org>; Wed, 23 Sep 2026 07:10:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=t9RAe9ZjvGj6dYOYWWXV4UowTJ/0wUjk9Zi0mnvN1Ks=; b=OYuW3oUIiWoh/ncw480GBUG3fj
	pq9Hte2DPomBqAB97S5L7UmQ0Y3ernuKp4SpeaeOIA8WQT9veIRUb2Bm8gXbCMjlher8S08diAU8T
	Xk+57JFe9vSl9iz+2HhgzuWhxbiu6czpVhidQly2MPwZsI+9t+c6nwhkFchQqBJrq0tt+B9nfQdbC
	mlEbMXHGOQb9oCJjMiETkxGTHHgVsm+4kjQRhuR+gKLVmjwm98pURTwMUiEn42GD75hzoEk74MCaR
	vcijxWCxLvS3jZb13MlzzMZmQgIXpk5piUnQpH7efPzJZHeYlwGZE/QDmR9eVVhpel+AmG5Q92H5o
	TyIx200A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9H7a-00000007MAI-235U;
	Wed, 23 Sep 2026 07:10:26 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9H7Y-00000007M9Y-19AO;
	Wed, 23 Sep 2026 07:10:24 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 8524F60200;
	Wed, 23 Sep 2026 07:10:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4AF7D1F00893;
	Wed, 23 Sep 2026 07:10:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790147422;
	bh=t9RAe9ZjvGj6dYOYWWXV4UowTJ/0wUjk9Zi0mnvN1Ks=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ZktHXeeVHUdVX84HQm0s5eTwxdjCgV+/1qk2ubVk78nV17YKtFkiFazEoAUDTsoXc
	 M9HCiTHUQ7J69MHTAi4rLJyLVgYuyNbgSZJz+v4NLmOvNpB/bSTDv4lHPBz5Q4Gbdm
	 cw1DRtF+qN9ZW+I8gS7aCogIW950qmkzAO26UzPGSnMSRMFt2p6bBCYM4H0oUIHroz
	 jtcloLZ16zE9tgGKnollzIYQBpif6cPAzGzXl2ECvovYLZTpgksOX/6bxn4RAYnBNk
	 G5I4qUhKiokal3pqf0QgZTJFeUKOfYndJa8L1dZhaKM+4yq8dKa2tMGYzCO83fHsqT
	 OShYOOxxd3Q4Q==
Date: Wed, 23 Sep 2026 08:09:58 +0100
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Lance Yang <lance.yang@linux.dev>
Cc: akpm@linux-foundation.org, david@kernel.org, ziy@nvidia.com, 
	baolin.wang@linux.alibaba.com, liam@infradead.org, nico.pache@linux.dev, ryan.roberts@arm.com, 
	dev.jain@arm.com, baohua@kernel.org, usama.arif@linux.dev, kas@kernel.org, 
	guoren@kernel.org, bcain@kernel.org, geert@linux-m68k.org, dinguyen@kernel.org, 
	schuster.simon@siemens-energy.com, jonas@southpole.se, stefan.kristiansson@saunalahti.fi, 
	shorne@gmail.com, dalias@libc.org, glaubitz@physik.fu-berlin.de, pjw@kernel.org, 
	palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, linux@armlinux.org.uk, 
	vgupta@kernel.org, monstr@monstr.eu, chris@zankel.net, jcmvbkbc@gmail.com, 
	will@kernel.org, aneesh.kumar@kernel.org, npiggin@gmail.com, peterz@infradead.org, 
	davem@davemloft.net, andreas@gaisler.com, richard.henderson@linaro.org, 
	mattst88@gmail.com, linmag7@gmail.com, catalin.marinas@arm.com, mark.rutland@arm.com, 
	chenhuacai@kernel.org, kernel@xen0n.name, tsbogend@alpha.franken.de, 
	James.Bottomley@hansenpartnership.com, deller@gmx.de, maddy@linux.ibm.com, mpe@ellerman.id.au, 
	chleroy@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com, agordeev@linux.ibm.com, 
	borntraeger@linux.ibm.com, svens@linux.ibm.com, richard@nod.at, 
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net, tglx@kernel.org, mingo@redhat.com, 
	bp@alien8.de, dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com, 
	arnd@arndb.de, vbabka@kernel.org, rppt@kernel.org, surenb@google.com, 
	mhocko@suse.com, jgg@ziepe.ca, jhubbard@nvidia.com, peterx@redhat.com, 
	ysato@users.sourceforge.jp, shakeel.butt@linux.dev, corbet@lwn.net, rdunlap@infradead.org, 
	linux-mm@kvack.org, linux-kernel@vger.kernel.org, linux-csky@vger.kernel.org, 
	linux-hexagon@vger.kernel.org, linux-m68k@lists.linux-m68k.org, linux-openrisc@vger.kernel.org, 
	linux-sh@vger.kernel.org, linux-riscv@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linux-snps-arc@lists.infradead.org, linux-arch@vger.kernel.org, 
	sparclinux@vger.kernel.org, linux-alpha@vger.kernel.org, loongarch@lists.linux.dev, 
	linux-mips@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	linux-s390@vger.kernel.org, linux-um@lists.infradead.org, hughd@google.com, 
	qi.zheng@linux.dev, linux-doc@vger.kernel.org
Subject: Re: [PATCH v4 01/12] mm/khugepaged: deposit a newly allocated page
 table on collapse
Message-ID: <arN6TnhWK0j61E3q@gremlin>
References: <20260922-rcu-pagetable-freeing-v4-1-fe1ad1f1e303@kernel.org>
 <20260923022436.61930-1-lance.yang@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260923022436.61930-1-lance.yang@linux.dev>
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

On Wed, Sep 23, 2026 at 10:24:36AM +0800, Lance Yang wrote:
> > mm/khugepaged.c | 32 ++++++++++++++++++++++++++++++--
> > 1 file changed, 30 insertions(+), 2 deletions(-)
> >
> >diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >index f49a6710933b..dab421f8233e 100644
> >--- a/mm/khugepaged.c
> >+++ b/mm/khugepaged.c
> >@@ -1278,6 +1278,23 @@ static enum scan_result alloc_charge_folio(struct folio **foliop, struct mm_stru
> > 	return SCAN_SUCCEED;
> > }
> >
> >+static pgtable_t alloc_deposit_pte(struct mm_struct *mm)
> >+{
> >+	/*
> >+	 * khugepaged is run from a kernel thread, so need to manually set the
> >+	 * correct memcg so the allocation gets charged correctly.
> >+	 */
> >+	struct mem_cgroup *memcg = get_mem_cgroup_from_mm(mm);
> >+	struct mem_cgroup *old_memcg = set_active_memcg(memcg);
> >+	pgtable_t pgtable;
> >+
> >+	pgtable = pte_alloc_one(mm);
> >+
> >+	set_active_memcg(old_memcg);
> >+	mem_cgroup_put(memcg);
> >+	return pgtable;
> >+}
> >+
> > /*
> >  * collapse_huge_page() expects the mmap_lock to be unlocked before entering and
> >  * will always return with the lock unlocked, to avoid holding the mmap_lock
> >@@ -1293,7 +1310,7 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
> > 	LIST_HEAD(compound_pagelist);
> > 	pmd_t *pmd, _pmd;
> > 	pte_t *pte = NULL;
> >-	pgtable_t pgtable;
> >+	pgtable_t pgtable = NULL;
> > 	struct folio *folio;
> > 	spinlock_t *pmd_ptl, *pte_ptl;
> > 	enum scan_result result = SCAN_FAIL;
> >@@ -1310,6 +1327,12 @@ static enum scan_result collapse_huge_page(struct mm_struct *mm, unsigned long s
> > 		goto out_nolock;
> > 	}
> >
> >+	if (is_pmd_order(order)) {
> >+		pgtable = alloc_deposit_pte(mm);
> >+		if (!pgtable)
> >+			goto out_nolock;
>
> One small thing: result is still SCAN_SUCCEED after alloc_charge_folio(),
>
> 	result = alloc_charge_folio(&folio, mm, cc, order);
> 	if (result != SCAN_SUCCEED)
> 		goto out_nolock;
>
> 	if (folio_memcg_alloc_deferred(folio)) {
> 		result = SCAN_ALLOC_HUGE_PAGE_FAIL;
> 		goto out_nolock;
> 	}
>
> 	if (is_pmd_order(order)) {
> 		pgtable = alloc_deposit_pte(mm);
> 		if (!pgtable)
> 			goto out_nolock;
> 	}
>
> so if alloc_deposit_pte() fails, collapse_huge_page() returns success
> without installing a PMD.
>
> I see sashiko pointed that out too :)
>
> Cheers, Lance

Sigh ack yeah oops :) I think SCAN_ALLOC_HUGE_PAGE_FAIL is the closest though
it's not allocating a huge page so much as the page table, but gets the correct
MADV_COLLAPSE -ENOMEM back.

(Another case of local AI review not catchign something btw! Sashiko does lean
towards over-reporting/hallucinating but catches more)

Will ask Andrew to update in reply to this patch as a quick thing rather than
respin so quick, and fix up on any respin.

--
Cheers, Lorenzo

