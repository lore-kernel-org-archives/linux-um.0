Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B5D3C021AF
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 17:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9hy7D4lXck0JMXuwDNv/ayTqn9sb236P26uPki4bGys=; b=KyqzmhqlDGwHAfmpWj1+GRt84l
	FU6YbpGqKhMJhPu7ADN7DYn0ZOna6RMG5nnbMpSkW4B7qIH/7ypOuRAVcF8vgubuRWadcLesmQJCk
	H5Bo6PSVlMGJL25NMeSewfcEKYg/iozyorI4eEoMuVys26509xBND8qE534fUEY4Or0ZAIxKFeA/q
	qcoP+9aK7liuuYGnE/hN48x1YDw1oXy5WMalPoX/whKp3MjB81i1Rtg1L0jt6reGShYnoSl8pC4+2
	q1Sp5ALiRbUFE1/egACB2QHl803yzrqQ6PACUw9kRvr/ZRVXRWmstV1Dm98X2i0FH0m3GbAOvKUKL
	HGBLgtog==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkR5Y-0000000965X-0w1i;
	Tue, 18 Feb 2025 17:08:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkR3Q-000000095Rf-13JL
	for linux-um@bombadil.infradead.org;
	Tue, 18 Feb 2025 17:06:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=9hy7D4lXck0JMXuwDNv/ayTqn9sb236P26uPki4bGys=; b=LWsZYxLwr4+Ph4Uz9Qv2fQmhiU
	V8qiO7S3WT217jOSvW0lhI9LpXKrcwZOM06+tjwwMhOeoVpCoMdIQA9DO8c/ARLRFHdXwaCao64Gc
	0+OhNhlqNdt05UtXSKMz1nnQcYHQDuuGzpj+SRtsC+mdTJS4V/RuYZ0bRiLKTpDTQ3t7wqIyGYbux
	SGBbpBZ/PMwUanq05+noL/j2Ct5d1MALfYTOjTSse/wVbBRN4mRzwlyg9JcvWZXML99DW/xt/a2r7
	ZT5DkvhXhxhnRlJTMi/789+ogpaLyqSd/6bjyWwx8OVrpu2XyZlJlj4HbvWgFArqygd7YCL0kZHtG
	161YexWA==;
Received: from willy by casper.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tkR3O-00000003MNz-3Cxq;
	Tue, 18 Feb 2025 17:06:38 +0000
Date: Tue, 18 Feb 2025 17:06:38 +0000
From: Matthew Wilcox <willy@infradead.org>
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
	linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7S-HgdXls65goJx@casper.infradead.org>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
 <Z7SzTHQGFXreZ6zd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7SzTHQGFXreZ6zd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
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

On Tue, Feb 18, 2025 at 05:20:28PM +0100, Alexander Gordeev wrote:
> > +++ b/arch/s390/include/asm/pgtable.h
> > @@ -1451,12 +1451,7 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
> >  
> >  static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
> >  {
> > -	unsigned long physpage = page_to_phys(page);
> > -	pte_t __pte = mk_pte_phys(physpage, pgprot);
> > -
> > -	if (pte_write(__pte) && PageDirty(page))
> > -		__pte = pte_mkdirty(__pte);
> > -	return __pte;
> > +	return mk_pte_phys(page_to_phys(page), pgprot);
> >  }
> 
> With the above the implicit dirtifying of hugetlb PTEs (as result of
> mk_huge_pte() -> mk_pte()) in make_huge_pte() is removed:
> 
> static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> 		bool try_mkwrite)
> {
> 	...
> 	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
> 		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
> 					 vma->vm_page_prot)));
> 	} else {
> 		entry = huge_pte_wrprotect(mk_huge_pte(page,
> 					   vma->vm_page_prot));
> 	}

Took me a moment to spot how this was getting invoked; for anyone else
playing along, it's mk_huge_pte() which calls mk_pte().

But I'm not sure how you lose out on the PTE being marked dirty.  In
the first arm that you've quoted, the pte is made dirty anyway.  In the
second arm, it's being writeprotected, so marking it dirty isn't a
helpful thing to do because writing to it will cause a fault anyway?

I know s390 is a little different, so there's probably something I'm
missing.

