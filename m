Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C94D5C021B0
	for <linux-um@archiver.kernel.org>; Wed, 19 Feb 2025 07:40:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MFnKFNb9jMXEzDrSQsUz5lOpmEOrxZYw2EdDJ3aUXXs=; b=KrI4VoCoHY1vr43SNFIB9P2os2
	unnjJJW0lpcdBguTFbBywNSDr0EFVBkUJPGcbVyh0EbMxIb4F563jTdTNpBBT5SylgU86QRVvXeek
	+NN8ebpKfkLF9K5MEFm9M/kb4i5C/LkKaAdrfM4lxlZdyHwGLS43ptCT1qX3/PQmN+lZfXrQ/omoV
	13WS/kOcUXVK9rz1zMsD3kWTUdfMtt5mxk1XmMEPIHJU6wRO1iH1sqoVfSreel3TWVvibv83SaSou
	D8dCjpU7jwAU1wir93chNUbCkC2TZ2tKCe0HoxF2aBzht29bZ7EPJbkHtd7rCc39C6LwiN+a1ixBv
	4BxeRidA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkehW-0000000BItR-2EMs;
	Wed, 19 Feb 2025 07:40:58 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkea4-0000000BGhS-04zT
	for linux-um@lists.infradead.org;
	Wed, 19 Feb 2025 07:33:17 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J7Wi4A002885;
	Wed, 19 Feb 2025 07:33:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=MFnKFNb9jMXEzDrSQsUz5lOpmEOrxZ
	Yw2EdDJ3aUXXs=; b=T5J3UtwsyEg+dsJ1SDMdehm3hiBaxkNsRkQYYA4p4MxLHw
	bxYeiF2aJQCtuUp5FBJwQmDKE24uyPJLvSRKZZ8cJQlD7kB3WNl5Z1zyaDzn0y5p
	NLOkkC3K2mrO14KXGrLC7KM0SvqbTMn16iIjomtiLGRVip+eIfz+1XDKBDpEwZ/f
	k3M4HqT9EqwOptmG2BebgL0tJG1I+ENXt+s2wQqsOzKud9MYxa4XlWdhuc9/LNob
	T+AH6vp/sAqWKyJoAofDfVNY1Uf1ZgGvbMUAjNvOeY3EJmT2dviUtHvY9xqWLPKG
	PcdgULu3KRbIK4vhZSbOsgJSmUtAW2MXDW1Av3lg==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44wb0nr01j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 07:33:08 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J72mXe002364;
	Wed, 19 Feb 2025 07:33:07 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03x2s7j-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 07:33:07 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J7X5Lt41156976
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 07:33:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 95A0020040;
	Wed, 19 Feb 2025 07:33:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 11A9020043;
	Wed, 19 Feb 2025 07:33:05 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.14.227])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Feb 2025 07:33:04 +0000 (GMT)
Date: Wed, 19 Feb 2025 08:33:03 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7WJL+sgPLB3dboi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250217190836.435039-2-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: m5ucgOXnZP2-CVF7bdX2ZteYDEClPNi4
X-Proofpoint-GUID: m5ucgOXnZP2-CVF7bdX2ZteYDEClPNi4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 mlxlogscore=477
 malwarescore=0 lowpriorityscore=0 mlxscore=0 phishscore=0
 priorityscore=1501 suspectscore=0 clxscore=1015 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_233316_168136_4C4054BF 
X-CRM114-Status: GOOD (  21.71  )
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
>  
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

Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

