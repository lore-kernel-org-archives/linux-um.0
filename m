Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F276C021AA
	for <linux-um@archiver.kernel.org>; Tue, 18 Feb 2025 16:25:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=psCROh/u4XmmWnXZwEf+kEObSVmJ4+iZ2KgCVphV0Bc=; b=gRQt/+y8ESUGVZ8LtUNuo7W8C4
	Oh7dgSMi8qjhZpQ3GTMmX36DEEOKA8oxasfjD3Tu3uFrie8baWIkWVyCZoH1wNqLuTJqS38v5Chi8
	jncmnfevoG9R3yX3GzERZQ1wzy1NKf0gKucczOpr/qrKUu9p4IJmJvc8Wj5VdWsdAQc6xj5g2S3yb
	WF7e4+FwNJb17c82Bsv8y2ltnt+wT+YRwnc3JYzMMwPcSsjgehEUoAkEgYy4ZtorLc0zMjdnhyZxq
	JWBA+ynnzAVU2EIUxEo0h/P01UBiGcaK3ezmcRLbL8jDrbQ1ktR/vczjwZCfdvsg/VjCBQZfH04lN
	icn4YRxA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQPQ-00000008xEv-2AE2;
	Tue, 18 Feb 2025 16:25:20 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkQKy-00000008w6N-0Nri
	for linux-um@lists.infradead.org;
	Tue, 18 Feb 2025 16:20:45 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51IG934F009895;
	Tue, 18 Feb 2025 16:20:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=psCROh/u4XmmWnXZwEf+kEObSVmJ4+
	iZ2KgCVphV0Bc=; b=Cq837tT1QEabHYlI9JkZ6FlnIMYHMyZWQHN+crU7BS2D7P
	EeImSs1ujqHvOsE9vgr1xvUMk9PbhHEbJdgMfpSQbu2TmqdxEj6lO1eSYViHbW5Y
	Xiom5hy7LO4i/BqYFt38C9nlWQJhP8VYuXnZAAKW1nIlOoPPEco27JwBgxv9ffR3
	NlIOfJv+iYVaEUrwQ1lMgkTJpvp+ngQ+8ipeGn0JF2qrJKa4yO5fecVy7mLOu5tE
	LEkHqfi1P0grKaZmha+Wt8mRFcyvPUJQLMOoTmXGw98I+fKkd7X21LFbm52G85pL
	2EPK0W1SQKJqqFC3oyXyG7bg6P7OIjZtHX2MOnWA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vnwpjhpq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 16:20:33 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51IEEF6P013325;
	Tue, 18 Feb 2025 16:20:32 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 44u7fkkuum-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Feb 2025 16:20:32 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51IGKV6B9109868
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Feb 2025 16:20:31 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1775420043;
	Tue, 18 Feb 2025 16:20:31 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7297520040;
	Tue, 18 Feb 2025 16:20:30 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.88.119])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 18 Feb 2025 16:20:30 +0000 (GMT)
Date: Tue, 18 Feb 2025 17:20:28 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7SzTHQGFXreZ6zd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217190836.435039-2-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KfuzgK7HnCFLppKRBSZ3W5dKc20FQNnF
X-Proofpoint-ORIG-GUID: KfuzgK7HnCFLppKRBSZ3W5dKc20FQNnF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-18_07,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 spamscore=0 mlxlogscore=290 impostorscore=0 lowpriorityscore=0
 malwarescore=0 phishscore=0 mlxscore=0 adultscore=0 suspectscore=0
 bulkscore=0 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2501170000 definitions=main-2502180116
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_082044_245629_A3CB00AC 
X-CRM114-Status: GOOD (  23.32  )
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

On Mon, Feb 17, 2025 at 07:08:28PM +0000, Matthew Wilcox (Oracle) wrote:

Hi Matthew,

> If the first access to a folio is a read that is then followed by a
> write, we can save a page fault.  s390 implemented this in their
> mk_pte() in commit abf09bed3cce ("s390/mm: implement software dirty
> bits"), but other architectures can also benefit from this.
> 
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/s390/include/asm/pgtable.h | 7 +------
>  mm/memory.c                     | 2 ++
>  2 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
> index 3ca5af4cfe43..3ee495b5171e 100644
> --- a/arch/s390/include/asm/pgtable.h
> +++ b/arch/s390/include/asm/pgtable.h
> @@ -1451,12 +1451,7 @@ static inline pte_t mk_pte_phys(unsigned long physpage, pgprot_t pgprot)
>  
>  static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
>  {
> -	unsigned long physpage = page_to_phys(page);
> -	pte_t __pte = mk_pte_phys(physpage, pgprot);
> -
> -	if (pte_write(__pte) && PageDirty(page))
> -		__pte = pte_mkdirty(__pte);
> -	return __pte;
> +	return mk_pte_phys(page_to_phys(page), pgprot);
>  }

With the above the implicit dirtifying of hugetlb PTEs (as result of
mk_huge_pte() -> mk_pte()) in make_huge_pte() is removed:

static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
		bool try_mkwrite)
{
	...
	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
					 vma->vm_page_prot)));
	} else {
		entry = huge_pte_wrprotect(mk_huge_pte(page,
					   vma->vm_page_prot));
	}
	...
}

What is your take on this?

>  #define pgd_index(address) (((address) >> PGDIR_SHIFT) & (PTRS_PER_PGD-1))
> diff --git a/mm/memory.c b/mm/memory.c
> index 539c0f7c6d54..4330560eee55 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -5124,6 +5124,8 @@ void set_pte_range(struct vm_fault *vmf, struct folio *folio,
>  
>  	if (write)
>  		entry = maybe_mkwrite(pte_mkdirty(entry), vma);
> +	else if (pte_write(entry) && folio_test_dirty(folio))
> +		entry = pte_mkdirty(entry);
>  	if (unlikely(vmf_orig_pte_uffd_wp(vmf)))
>  		entry = pte_mkuffd_wp(entry);
>  	/* copy-on-write page */

Thanks!

