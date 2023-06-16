Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B93EB64D7
	for <linux-um@archiver.kernel.org>; Fri, 16 Jun 2023 20:38:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=3RvBCFsue2+phD2aD6M/vB1PMpP1vGUbOuZHUgx0mUw=; b=qyAkgZz1cN9YFH
	Pmq3pOeimJySBQKc5wu7gkGhAGYJhuA6f+lW5gLuHgV4AqhQrik5/1waVbuL2gYDw4tu3WxwFA4ZK
	MBoO8QHoMEJ4Pi6MlfDmwkcGbAz/8agtRClKHjoB5qTxZI5J3u2X1vbjRlDtCQthosYI8iPurHH/q
	3SBGrfHv06OBk7rTtbhG6lCyd8DthaOrGoWDE57C2qvLPUSvscYu7KrcxUikyIlKNJvXH0fq2/55k
	H6r9MbO1QIrTnGsHcBEc6hUEZIOomZzmXRLZ56TPC/PNv0YPjbq1TWakRnOEr8hnMYsZok6wrdId7
	Lv6V6s6u7xr+3YS1I8FA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qAGDD-001oHs-1p;
	Fri, 16 Jun 2023 20:38:27 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qAGDB-001oHE-0t;
	Fri, 16 Jun 2023 20:38:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
	References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=fw74FAZhkocnJnJyLR/WQNNOz26kiObyhL++hGG0nWw=; b=QBNdm8qv6j/A/iWrMKfpB6M7G8
	dX02GHdjAg9rPGckqaKAq0nuLHgnEOZOUcT5iS1KFKrWFBJlTrkF2I4g5N2YgCfsexrQECwyFoHPp
	z6yd+/vIl/PequagU7pGV8UNE2yhdOrdkDT+t3SJSVONZj6Q1cQWhoxiK+7FUVh/Fb17OdOH8kjtt
	OWIuj2P4ze5K/i70TfCVLOSJSXO+Ry9WEoIoy6BlMNh0EJ1wlu/c8zXDIuEPPIicVlz2AV+6m8LDv
	lA4vOEDBJYuPKGoF8lu2OSuuFhx10iSF/LiB0UcYpqrALuMFJM02PbH03w+/bd9OLb/nrxdqasmpe
	J/m6D//w==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
	id 1qAGD7-009Lj7-EI; Fri, 16 Jun 2023 20:38:21 +0000
Date: Fri, 16 Jun 2023 21:38:21 +0100
From: Matthew Wilcox <willy@infradead.org>
To: Hugh Dickins <hughd@google.com>
Cc: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>,
	Heiko Carstens <hca@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>, linux-mm@kvack.org,
	linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
	loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
	linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	xen-devel@lists.xenproject.org, kvm@vger.kernel.org
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
Message-ID: <ZIzIPQBXvnMtQekj@casper.infradead.org>
References: <20230612210423.18611-1-vishal.moola@gmail.com>
 <20230612210423.18611-5-vishal.moola@gmail.com>
 <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On Thu, Jun 15, 2023 at 12:57:19AM -0700, Hugh Dickins wrote:
> Probably just trivial collisions in most architectures, which either
> of us can easily adjust to the other; powerpc likely to be more awkward,
> but fairly easily resolved; s390 quite a problem.
> 
> I've so far been unable to post a v2 of my series (and powerpc and s390
> were stupidly wrong in the v1), because a good s390 patch is not yet
> decided - Gerald Schaefer and I are currently working on that, on the
> s390 list (I took off most Ccs until we are settled and I can post v2).
> 
> As you have no doubt found yourself, s390 has sophisticated handling of
> free half-pages already, and I need to add rcu_head usage in there too:
> it's tricky to squeeze it all in, and ptdesc does not appear to help us
> in any way (though mostly it's just changing some field names, okay).
> 
> If ptdesc were actually allowing a flexible structure which architectures
> could add into, that would (in some future) be nice; but of course at
> present it's still fitting it all into one struct page, and mandating
> new restrictions which just make an architecture's job harder.

The intent is to get ptdescs to be dynamically allocated at some point
in the ~2-3 years out future when we have finished the folio project ...
which is not a terribly helpful thing for me to say.

I have three suggestions, probably all dreadful:

1. s390 could change its behaviour to always allocate page tables in
pairs.  That is, it fills in two pmd_t entries any time it takes a fault
in either of them.

2. We could allocate two or four pages at a time for s390 to allocate
2kB pages from.  That gives us a lot more space to store RCU heads.

3. We could use s390 as a guinea-pig for dynamic ptdesc allocation.
Every time we allocate a struct page, we have a slab cache for an
s390-special definition of struct ptdesc, we allocate a ptdesc and store
a pointer to that in compound_head.

We could sweeten #3 by doing that not just for s390 but also for every
configuration which has ALLOC_SPLIT_PTLOCKS today.  That would get rid
of the ambiguity between "is ptl a pointer or a lock".

> But I've no desire to undo powerpc's use of pt_frag_refcount:
> just warning that we may want to undo any use of it in s390.

I would dearly love ppc & s390 to use the _same_ scheme to solve the
same problem.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
