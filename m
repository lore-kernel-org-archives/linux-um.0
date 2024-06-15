Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D197C27C4F
	for <linux-um@archiver.kernel.org>; Sat, 15 Jun 2024 08:20:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/C1OaMkMUNqGrbXHszRG2oF48V9vjQjXgd5y9/cMqtE=; b=Q3JKFxwr39A0OjzoRElPU+NQHO
	jZayJbD9hH061MDKjdzx9BaRvBCfJbL83yWtH7VzJbHmLboIgyg6rEY3aiuY07FFsT1LAwQ+DCynA
	qFLDDEqjF34JZxg2kTY/Pgcr5Es09sieh9p6mhDk8yfGERHbbrrmyLcHF32taEnV2rbgHI+9w3aZg
	7bS0qONSPlN5didP55Ao4+sNrXuqmZ23xDOdD3+xnBLH6F3SIA+0whMx3PdCKHU0nH2bhQz8Cqc4a
	bukcr5d/YreTCzNuo5XBvpdxr8vthw6CPfZ2JFkg30RtsyCy0VkZlUoV9R1FqyiZL3H9JTpFAExJY
	po43dhyg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIOdj-0000000507G-1d9R;
	Sat, 15 Jun 2024 08:19:59 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sIOdg-0000000506d-39wB
	for linux-um@lists.infradead.org;
	Sat, 15 Jun 2024 08:19:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 07104CE059D;
	Sat, 15 Jun 2024 08:19:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 92EDEC116B1;
	Sat, 15 Jun 2024 08:19:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718439593;
	bh=kP5jMFr8uFhLgCSpDSobxyBlrDXjZxRM7l38OANEgkc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=sXYRtG1F6xZqXEPtpeDfbfD6HMH55I9azpupHA0S82GojDFHKy3nMxRT3jRZ9uM/A
	 Ay//zAO5Z4D2FO4fhvz7G4nCMRWLTd4InV/qmLPhYxjDd3tiBSYbIT7bxxU+N/wfxA
	 rY2uuf8ox4oXYeYkcaeDBy5//PkQvAVcUd3koJan6k0ESm3IaOUU9+S2M01t4kO8W6
	 6KRSc8fOSHBDn1KBuRwY+tf8i4xCtn3KnWqK56oR+U7CzXNKeSpAKU5Z16lyoJ9cyF
	 I/l1lJ52hTtechVDegX0bffTpj2B9SXzjFJmfcAfZptFy6ttxftnj478ed2HDIkom4
	 HQc9R2Kn9nzmw==
Date: Sat, 15 Jun 2024 11:17:39 +0300
From: Mike Rapoport <rppt@kernel.org>
To: Wei Yang <richard.weiyang@gmail.com>
Cc: richard@nod.at, anton.ivanov@cambridgegreys.com,
	johannes@sipsolutions.net, linux-um@lists.infradead.org,
	linux-mm@kvack.org, Jeff Dike <jdike@linux.intel.com>,
	Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>,
	Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH v2] um/mm: remove redundant assignment of max_low_pfn
Message-ID: <Zm1OI1C7PVhb1YoF@kernel.org>
References: <20240615034150.2958-1-richard.weiyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240615034150.2958-1-richard.weiyang@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240615_011957_005210_FC756CB7 
X-CRM114-Status: GOOD (  24.73  )
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

On Sat, Jun 15, 2024 at 03:41:50AM +0000, Wei Yang wrote:
> Current calculation of max_low_pfn is introduced in commit af84eab20891
> ("[PATCH] uml: fix LVM crash"). It is intended to set max_low_pfn to the
> same value as max_pfn.
> 
> But I am not sure why the max_pfn is set to totalram_pages, which
> represents the number of usable pages in system instead of an absolute
> page frame number. (The change history stops there.)
> 
> While we have already calculate it in setup_physmem(), so not necessary
> to do it again.
> 
> Also this would help changing totalram_pages accounting, since we plan
> to move the accounting into __free_pages_core(). With this change,
> totalram_pages may not represent the total usable pages at this point,
> since some pages would be deferred initialized.
> 
> Signed-off-by: Wei Yang <richard.weiyang@gmail.com>
> CC: Jeff Dike <jdike@linux.intel.com>
> Cc: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> Cc: Alasdair G Kergon <agk@redhat.com>
> CC: Andrew Morton <akpm@linux-foundation.org>
> CC: Mike Rapoport (IBM) <rppt@kernel.org>
> CC: David Hildenbrand <david@redhat.com>

Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>

> ---
> v2: remove redundant assignment of max_low_pfn
> ---
>  arch/um/kernel/mem.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/arch/um/kernel/mem.c b/arch/um/kernel/mem.c
> index ca91accd64fc..a5b4fe2ad931 100644
> --- a/arch/um/kernel/mem.c
> +++ b/arch/um/kernel/mem.c
> @@ -73,7 +73,6 @@ void __init mem_init(void)
>  
>  	/* this will put all low memory onto the freelists */
>  	memblock_free_all();
> -	max_low_pfn = totalram_pages();
>  	max_pfn = max_low_pfn;
>  	kmalloc_ok = 1;
>  }
> -- 
> 2.34.1
> 

-- 
Sincerely yours,
Mike.

