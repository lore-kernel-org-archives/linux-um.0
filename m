Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F029C27C6E
	for <linux-um@archiver.kernel.org>; Fri, 14 Jun 2024 07:53:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i0sWIEGLKtKBH/fny7BtcjHZ6cxqhkIlHlCdeRJ1H6c=; b=M142P07HKeWRKLNPgjQm8/k82L
	uxRjuCNvwduRXprAjzAI83dEuXY3OqCsZFRMgLJnMOChy16uSwV9x/NtmWqCjnJFhRLkYYJtXHoO6
	jNxgubGqbtKtRIr9njmv0CpV6hQ7EbiCMc4tuOE0pNwYqzYD1S+v06FKFMGWQSDqlCAJYPEiyU7Md
	nwBg65082GIeFxUk2s/Qz3WRsVkeONBI1lgIbkuF1BBNYvTUyK3UHWO2sGLBXTBRbYhn1fojkC/ZW
	p2Sess+67oEU+CI8He8ZbbbODp6CqLlhZtd76rpZzrPfkuOc5e+PwEAh2ZeiJXAbCKBDyuw5JG5Na
	AGyttbgQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1kv-00000001rXL-3X2i;
	Fri, 14 Jun 2024 07:53:53 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sI1kt-00000001rWh-2RtD
	for linux-um@lists.infradead.org;
	Fri, 14 Jun 2024 07:53:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 83C57CE29B0;
	Fri, 14 Jun 2024 07:53:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC066C32786;
	Fri, 14 Jun 2024 07:53:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718351624;
	bh=h+/wniDhffow13/0x9wXBCH5L3m2C2ifbo5JQH39Ctk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CXEgI2L5Juu2diryLHebBXJlQBjclK3htRMxEw0WSoJqLMQgpfzrVv3Y/hlN7Q+DP
	 h6q2O8Nhe1Yo6QsTaxnC5TWrG0Sh7Zuz2mB9WnqJUUJd3oezlYlxKSsEIKgKSA2cNT
	 Ykv1S5Kz4eDALY0OaYLeJeYwouQptu3s8nf8Bv6+9KVgWKux4Pa5TUt9D5cD3238Nk
	 nZyoyAnxUqzp/ctsyIokKtInIGmZQWaoSdeIcmduVd9lYELIkv0dXgvydC5t11oD8v
	 gAc9skRkCs/bopuIkcNd/ONi/uWZPZ9p2+FuToFXRluCFtTANJD5jBY80k+WOoKlO3
	 vZTjgYjgiC7lw==
Date: Fri, 14 Jun 2024 10:51:32 +0300
From: Mike Rapoport <rppt@kernel.org>
To: David Hildenbrand <david@redhat.com>
Cc: Wei Yang <richard.weiyang@gmail.com>, richard@nod.at,
	anton.ivanov@cambridgegreys.com, johannes@sipsolutions.net,
	linux-um@lists.infradead.org, linux-mm@kvack.org,
	Jason Lunz <lunz@falooley.org>, Jeff Dike <jdike@linux.intel.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	Alasdair G Kergon <agk@redhat.com>,
	Jens Axboe <jens.axboe@oracle.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Tiezhu Yang <yangtiezhu@loongson.cn>
Subject: Re: [PATCH] um/mm: get max_low_pfn from memblock
Message-ID: <Zmv2hHamxBh0_Gew@kernel.org>
References: <20240614015840.12632-1-richard.weiyang@gmail.com>
 <d21c00f1-bd9d-48ae-bb54-86cf126c45ef@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d21c00f1-bd9d-48ae-bb54-86cf126c45ef@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240614_005352_007840_3849A5B1 
X-CRM114-Status: GOOD (  28.38  )
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

On Fri, Jun 14, 2024 at 09:31:59AM +0200, David Hildenbrand wrote:
> On 14.06.24 03:58, Wei Yang wrote:
> > Current calculation of max_low_pfn is introduced in commit af84eab20891
> > ("[PATCH] uml: fix LVM crash"). It is intended to set max_low_pfn to the
> > same value as max_pfn.
> > 
> > But I am not sure why the max_pfn is set to totalram_pages, which
> > represents the number of usable pages in system instead of an absolute
> > page frame number. (The change history stops there.)
> > 
> > While we can get the maximum page frame number from memblock, this looks
> > more reasonable than setting to totalram_pages.
> > 
> > Also this would help changing totalram_pages accounting, since we plan
> > to move the accounting into __free_pages_core(). With this change,
> > totalram_pages may not represent the total usable pages at this point,
> > since some pages would be deferred initialized.
> 
> Question is if deferred page init is even a thing on UM. But it certainly looks odd+suspiciously wrong to rely on totalram_pages().
 
As long as there is no HIGHMEM, 

max_pfn = max_low_pfn = PFN_DOWN(memblock_end_of_DRAM())

should be ok.
 
> > Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> > CC: Jason Lunz <lunz@falooley.org>
> > CC: Jeff Dike <jdike@linux.intel.com>
> > Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> > Cc: Alasdair G Kergon <agk@redhat.com>
> > Cc: Jens Axboe <jens.axboe@oracle.com>
> > CC: Andrew Morton <akpm@linux-foundation.org>
> > CC: Mike Rapoport (IBM) <rppt@kernel.org>
> > CC: David Hildenbrand <david@redhat.com>
> > 
> > ---
> > A simple UML bootup test looks good.
> > ---
> >   arch/um/kernel/mem.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> > index ca91accd64fc..ca682879e28f 100644
> > --- a/arch/um/kernel/mem.c
> > +++ b/arch/um/kernel/mem.c
> > @@ -73,7 +73,7 @@ void __init mem_init(void)
> >   	/* this will put all low memory onto the freelists */
> >   	memblock_free_all();
> > -	max_low_pfn = totalram_pages();
> > +	max_low_pfn = PFN_DOWN(memblock_end_of_DRAM());

This assignment seem redundant as there is already

	max_low_pfn = min_low_pfn + (map_size >> PAGE_SHIFT);

in setup_physmem

> >   	max_pfn = max_low_pfn;
> >   	kmalloc_ok = 1;
> >   }
> 
> Matches what a bunch of other archs do.
> 
> Acked-by: David Hildenbrand <david@redhat.com>
> 
> 
> Randomly staring at other users:
> 
> arch/loongarch/kernel/numa.c:   max_low_pfn = PHYS_PFN(memblock_end_of_DRAM());
> arch/loongarch/kernel/setup.c:  max_low_pfn = PFN_PHYS(memblock_end_of_DRAM());
> 
> What? the latter cannot possibly be right, no? Looks odd at least.
> Only applies to CONFIG_OF_EARLY_FLATTREE. CCing loongarch maintainer.
> 
> -- 
> Cheers,
> 
> David / dhildenb
> 

-- 
Sincerely yours,
Mike.

