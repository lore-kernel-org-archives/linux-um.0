Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76C48C001DD
	for <linux-um@archiver.kernel.org>; Thu, 15 Jun 2023 07:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:Message-ID:
	In-Reply-To:Subject:cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zfMW3V5b6ewzAnGzin6Glm4gK/hbVVLnYTWTJhls63E=; b=cP+NzUbMDzSNAP
	2DEUO4XwXKJMaga5cAvhVjClAZbhJxjP3f6DtXXqiu3zlH7weg0tXvacYLFK8XWeMNWgpVMbePP2h
	GPe1ohHp65ON+egEsyjzr5DKB+AquL/skmp11UrhApZLBBfR1W6vz6767yNgNCV+g7zC0oQ1Pa9ar
	VvumzxkeYtDEcxgZxwtdqhlZYTTvQTN+35A+6gvpfuMVo2W2d1drg8unApmU30lxCaq7+S0pI18x6
	bs1ijRUxLAtH3gw+04PDgi0bNtilLizwpW0gnDvI83pCrfngJviXjpukAZkxNmoIKOQETuq74WTYP
	5V+QrHI9qOCes9P59GAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q9hrM-00E5xz-30;
	Thu, 15 Jun 2023 07:57:36 +0000
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q9hrG-00E5v6-36
	for linux-um@lists.infradead.org;
	Thu, 15 Jun 2023 07:57:34 +0000
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-57015b368c3so12921007b3.3
        for <linux-um@lists.infradead.org>; Thu, 15 Jun 2023 00:57:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686815849; x=1689407849;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=xLt61v9ssqW8THTFBubZKFO6yUx9jJyRuoagCfuj5p4=;
        b=sqOjHZl7egAhowGBIl8syIGU5uGIW1wSh5YqCADkB0Zmhbwaikuj12BL/Atk+qYS71
         8dY5tiV1rX4DjXNhrE2xJeIEdceT4TUB4AfmV60Sg7nUR26TxpBkZUfQbEPDRpELwXiM
         3HDz0uXJ5pPS05kzKVjfB3TERQuwjHm7feUY48emv6g2FTDXB9kM0valHSq3MAkeYNdE
         mA/iBYPYSlEE3tWbGq5EWumSWyWn91B8nqrAaue3xEBOGl9H7R/5SfVVFZg7lrOxN+sl
         dQY9293XfHEDMeAx5R4qX4oCaN7KwBo3Iv/M+KCSiSSfPpdtHzovKysKwSYDtQgZOCuN
         1f9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686815849; x=1689407849;
        h=mime-version:references:message-id:in-reply-to:subject:cc:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xLt61v9ssqW8THTFBubZKFO6yUx9jJyRuoagCfuj5p4=;
        b=bz/Yjt+IOuV7EwY2qEuhzmWyl6h9wzWOjzEv9yrahq9fMQEm8eNRU/kVYc4EuDKH5+
         DChE24WRsN/f283l7mn2mtWulXRqChsB5hqNcUV0Ax0HFfs5peYuPlu2VEF146DBa9/m
         5KUTLdXJYC6NQdYzp+s8yxXxKgVD+FWnBFcKt0ySpHTz31pzMuxaTrpzp9gAPNVlyY+e
         CvKpY96BZZeR8avEytgBtvlUJTlkj3U9sskyEpk+iIm6OwgXBFRlF1Ez+uhDVCm2q7Yl
         JqH/2gYFFlcipT23qS9NCJssGa3rMHjsweQqMYbrNBcpsFc7mh+8mbH1lKMNV4of/w2H
         hWzQ==
X-Gm-Message-State: AC+VfDxHOvavMgYkeuIdHQaeCA9rVolvsauBWJku851jp2gC+KFfW+n1
	LCnx7xQjMODUDMPDQEfhb++I8A==
X-Google-Smtp-Source: ACHHUZ7WkxW4gg02vDJcQOsCLmdXn2XBXedO6GCP0YsU33dh0gQYY291P8lwRaex9WlgnYowIiPsYQ==
X-Received: by 2002:a0d:d9c9:0:b0:56d:244:ab13 with SMTP id b192-20020a0dd9c9000000b0056d0244ab13mr4185666ywe.28.1686815849226;
        Thu, 15 Jun 2023 00:57:29 -0700 (PDT)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id w10-20020a0dd40a000000b00568a207aaedsm4237877ywd.68.2023.06.15.00.57.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 15 Jun 2023 00:57:28 -0700 (PDT)
Date: Thu, 15 Jun 2023 00:57:19 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.attlocal.net
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
cc: Andrew Morton <akpm@linux-foundation.org>, 
    Matthew Wilcox <willy@infradead.org>, 
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
    xen-devel@lists.xenproject.org, kvm@vger.kernel.org, 
    Hugh Dickins <hughd@google.com>
Subject: Re: [PATCH v4 04/34] pgtable: Create struct ptdesc
In-Reply-To: <20230612210423.18611-5-vishal.moola@gmail.com>
Message-ID: <fd63179-6ad6-fd86-79d6-2833c91111f8@google.com>
References: <20230612210423.18611-1-vishal.moola@gmail.com> <20230612210423.18611-5-vishal.moola@gmail.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230615_005731_015207_3523CFEC 
X-CRM114-Status: GOOD (  28.46  )
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

On Mon, 12 Jun 2023, Vishal Moola (Oracle) wrote:

> Currently, page table information is stored within struct page. As part
> of simplifying struct page, create struct ptdesc for page table
> information.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Vishal, as I think you have already guessed, your ptdesc series and
my pte_free_defer() "mm: free retracted page table by RCU" series are
on a collision course.

Probably just trivial collisions in most architectures, which either
of us can easily adjust to the other; powerpc likely to be more awkward,
but fairly easily resolved; s390 quite a problem.

I've so far been unable to post a v2 of my series (and powerpc and s390
were stupidly wrong in the v1), because a good s390 patch is not yet
decided - Gerald Schaefer and I are currently working on that, on the
s390 list (I took off most Ccs until we are settled and I can post v2).

As you have no doubt found yourself, s390 has sophisticated handling of
free half-pages already, and I need to add rcu_head usage in there too:
it's tricky to squeeze it all in, and ptdesc does not appear to help us
in any way (though mostly it's just changing some field names, okay).

If ptdesc were actually allowing a flexible structure which architectures
could add into, that would (in some future) be nice; but of course at
present it's still fitting it all into one struct page, and mandating
new restrictions which just make an architecture's job harder.

Some notes on problematic fields below FYI.

> ---
>  include/linux/pgtable.h | 51 +++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 51 insertions(+)
> 
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index c5a51481bbb9..330de96ebfd6 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -975,6 +975,57 @@ static inline void ptep_modify_prot_commit(struct vm_area_struct *vma,
>  #endif /* __HAVE_ARCH_PTEP_MODIFY_PROT_TRANSACTION */
>  #endif /* CONFIG_MMU */
>  
> +
> +/**
> + * struct ptdesc - Memory descriptor for page tables.
> + * @__page_flags: Same as page flags. Unused for page tables.
> + * @pt_list: List of used page tables. Used for s390 and x86.
> + * @_pt_pad_1: Padding that aliases with page's compound head.
> + * @pmd_huge_pte: Protected by ptdesc->ptl, used for THPs.
> + * @_pt_s390_gaddr: Aliases with page's mapping. Used for s390 gmap only.
> + * @pt_mm: Used for x86 pgds.
> + * @pt_frag_refcount: For fragmented page table tracking. Powerpc and s390 only.
> + * @ptl: Lock for the page table.
> + *
> + * This struct overlays struct page for now. Do not modify without a good
> + * understanding of the issues.
> + */
> +struct ptdesc {
> +	unsigned long __page_flags;
> +
> +	union {
> +		struct list_head pt_list;

I shall be needing struct rcu_head rcu_head (or pt_rcu_head or whatever,
if you prefer) in this union too.  Sharing the lru or pt_list with rcu_head
is what's difficult to get right and efficient on s390 - and if ptdesc gave
us an independent rcu_head for each page table, that would be a blessing!
but sadly not, it still has to squeeze into a struct page.

> +		struct {
> +			unsigned long _pt_pad_1;
> +			pgtable_t pmd_huge_pte;
> +		};
> +	};
> +	unsigned long _pt_s390_gaddr;
> +
> +	union {
> +		struct mm_struct *pt_mm;
> +		atomic_t pt_frag_refcount;

Whether s390 will want pt_mm is not yet decided: I want to use it,
Gerald prefers to go without it; but if we do end up using it,
then pt_frag_refcount is a luxury we would have to give up.

s390 does very well already with its _refcount tricks, and I'd expect
powerpc's simpler but more wasteful implementation to work as well
with _refcount too - I know that a few years back, powerpc did misuse
_refcount (it did not allow for speculative accesses, thought it had
sole ownership of that field); but s390 copes well with that, and I
expect powerpc can do so too, without the luxury of pt_frag_refcount.

But I've no desire to undo powerpc's use of pt_frag_refcount:
just warning that we may want to undo any use of it in s390.

I thought I had more issues to mention, probably Gerald will
remind me of a whole new unexplored dimension! gmap perhaps.

Hugh

> +	};
> +
> +#if ALLOC_SPLIT_PTLOCKS
> +	spinlock_t *ptl;
> +#else
> +	spinlock_t ptl;
> +#endif
> +};
> +
> +#define TABLE_MATCH(pg, pt)						\
> +	static_assert(offsetof(struct page, pg) == offsetof(struct ptdesc, pt))
> +TABLE_MATCH(flags, __page_flags);
> +TABLE_MATCH(compound_head, pt_list);
> +TABLE_MATCH(compound_head, _pt_pad_1);
> +TABLE_MATCH(pmd_huge_pte, pmd_huge_pte);
> +TABLE_MATCH(mapping, _pt_s390_gaddr);
> +TABLE_MATCH(pt_mm, pt_mm);
> +TABLE_MATCH(ptl, ptl);
> +#undef TABLE_MATCH
> +static_assert(sizeof(struct ptdesc) <= sizeof(struct page));
> +
>  /*
>   * No-op macros that just return the current protection value. Defined here
>   * because these macros can be used even if CONFIG_MMU is not defined.
> -- 
> 2.40.1

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
