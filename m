Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27442E77197
	for <linux-um@archiver.kernel.org>; Tue,  7 Jan 2025 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2B7QsXhwZNID9hkdJMhXhhx17J8OxXWuj8JjzDXzWQA=; b=Z9c2a5bHkvIS4aSXTLJ0khQ2KD
	nfNC3cG8PIlfsggc8WG8vQq/UnYE4OXdoSBykwndWqGpevBByJkb5vIsb2+BNHtMEyIpsRzHqlvvJ
	8o7IJZnqtlcONd6kENYpACrJzefHKWlHw1rPDUKJkQTUE52bikD2ug8XZFp+a3+QyP5yv9tGzIC4G
	XpXNn30xSTQ3s6RDz/v6U7aw5/+bJmTPcJUH5DEXg9cjZlyArIukfhsLxSOqTsu6EOKK2Odji15FR
	hXaIALLhapufZBoU+2q53xBUZbe7ISbdvkfWLjUeHwBp7rsHYj0xmtenrrDb1/CUlefKe/ay+J0Kw
	UcGO9jWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVAXd-00000005CVd-3LfG;
	Tue, 07 Jan 2025 14:26:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVATt-00000005BJ4-3o2M;
	Tue, 07 Jan 2025 14:22:58 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50785ZGY017710;
	Tue, 7 Jan 2025 14:22:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=2B7QsXhwZNID9hkdJMhXhhx17J8OxX
	Wuj8JjzDXzWQA=; b=m0f+8NRkRQ5k6iEjZnjbuEmNBycrqf76ItjYHFoPDUTOdH
	tsDcx5zUcXHTnSo13TQHIktaMW3Ad5Lgiteov3XI7UyYvcHfs7tupMQKv7w+lpWi
	4YLFjjrj3XJCNnlUHzBTj+CqV5Wfk1Tu9P3NK58XARBZIsYIoNvUqA/O4coLLn3B
	ZSyQoHvvvyoIu5c9lj7lHuDq6Jy7QSdEt4aDTyu6zAC3xDyVGqw+EC8rnEQUvB4M
	qTx/kRHnKTqWC1L1KpzOVhfnwVqqgCP8PkyNrpobTfKho0LfDQVBy1vGN7qwBYGb
	bQQ9LoXaqcbGbf/ddlkC1nG1T6m79jZRlMxk0gng==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f39jwh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:22:20 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 507E7cHb024539;
	Tue, 7 Jan 2025 14:22:20 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4410f39jwe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:22:20 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 507AEgaT027976;
	Tue, 7 Jan 2025 14:22:19 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhk2m6g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 07 Jan 2025 14:22:19 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 507EMHnJ39453010
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 7 Jan 2025 14:22:17 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3E19420043;
	Tue,  7 Jan 2025 14:22:17 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 584C920040;
	Tue,  7 Jan 2025 14:22:16 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue,  7 Jan 2025 14:22:16 +0000 (GMT)
Date: Tue, 7 Jan 2025 15:22:15 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, palmer@dabbelt.com,
        tglx@linutronix.de, david@redhat.com, jannh@google.com,
        hughd@google.com, yuzhao@google.com, willy@infradead.org,
        muchun.song@linux.dev, vbabka@kernel.org, lorenzo.stoakes@oracle.com,
        akpm@linux-foundation.org, rientjes@google.com, vishal.moola@gmail.com,
        arnd@arndb.de, will@kernel.org, aneesh.kumar@kernel.org,
        npiggin@gmail.com, dave.hansen@linux.intel.com, rppt@kernel.org,
        ryan.roberts@arm.com, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
        linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-arch@vger.kernel.org, linux-csky@vger.kernel.org,
        linux-hexagon@vger.kernel.org, loongarch@lists.linux.dev,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        linux-openrisc@vger.kernel.org, linux-sh@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH v4 15/15] mm: pgtable: introduce generic
 pagetable_dtor_free()
Message-ID: <Z304l1Y6DHosXlBh@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <cb5700c21d0eed9eb50bac385be1fb6cdef7e530.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cb5700c21d0eed9eb50bac385be1fb6cdef7e530.1735549103.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yROkuy-wyK9H6Q7dEn2Q7Ir9AUmTd7MT
X-Proofpoint-ORIG-GUID: J54oxTq0KOpExrJ-UIH_1SyWDONwdbzM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 mlxlogscore=578
 spamscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 priorityscore=1501 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501070118
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250107_062254_059500_F266C574 
X-CRM114-Status: GOOD (  19.00  )
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

On Mon, Dec 30, 2024 at 05:07:50PM +0800, Qi Zheng wrote:
> The pte_free(), pmd_free(), __pud_free() and __p4d_free() in
> asm-generic/pgalloc.h and the generic __tlb_remove_table() are basically
> the same, so let's introduce pagetable_dtor_free() to deduplicate them.
> 
> In addition, the pagetable_dtor_free() in s390 does the same thing, so
> let's s390 also calls generic pagetable_dtor_free().
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  arch/s390/mm/pgalloc.c        |  6 ------
>  include/asm-generic/pgalloc.h | 12 ++++--------
>  include/asm-generic/tlb.h     |  3 +--
>  include/linux/mm.h            |  6 ++++++
>  4 files changed, 11 insertions(+), 16 deletions(-)
> 
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index 3e002dea6278f..a4e7619020931 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -180,12 +180,6 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  	return table;
>  }
>  
> -static void pagetable_dtor_free(struct ptdesc *ptdesc)
> -{
> -	pagetable_dtor(ptdesc);
> -	pagetable_free(ptdesc);
> -}
> -
>  void page_table_free(struct mm_struct *mm, unsigned long *table)
>  {
>  	struct ptdesc *ptdesc = virt_to_ptdesc(table);
> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
> index 4afb346eae255..e3977ddca15e4 100644
> --- a/include/asm-generic/pgalloc.h
> +++ b/include/asm-generic/pgalloc.h
> @@ -109,8 +109,7 @@ static inline void pte_free(struct mm_struct *mm, struct page *pte_page)
>  {
>  	struct ptdesc *ptdesc = page_ptdesc(pte_page);
>  
> -	pagetable_dtor(ptdesc);
> -	pagetable_free(ptdesc);
> +	pagetable_dtor_free(ptdesc);
>  }
>  
>  
> @@ -153,8 +152,7 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>  	struct ptdesc *ptdesc = virt_to_ptdesc(pmd);
>  
>  	BUG_ON((unsigned long)pmd & (PAGE_SIZE-1));
> -	pagetable_dtor(ptdesc);
> -	pagetable_free(ptdesc);
> +	pagetable_dtor_free(ptdesc);
>  }
>  #endif
>  
> @@ -202,8 +200,7 @@ static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
>  	struct ptdesc *ptdesc = virt_to_ptdesc(pud);
>  
>  	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
> -	pagetable_dtor(ptdesc);
> -	pagetable_free(ptdesc);
> +	pagetable_dtor_free(ptdesc);
>  }
>  
>  #ifndef __HAVE_ARCH_PUD_FREE
> @@ -248,8 +245,7 @@ static inline void __p4d_free(struct mm_struct *mm, p4d_t *p4d)
>  	struct ptdesc *ptdesc = virt_to_ptdesc(p4d);
>  
>  	BUG_ON((unsigned long)p4d & (PAGE_SIZE-1));
> -	pagetable_dtor(ptdesc);
> -	pagetable_free(ptdesc);
> +	pagetable_dtor_free(ptdesc);
>  }
>  
>  #ifndef __HAVE_ARCH_P4D_FREE
> diff --git a/include/asm-generic/tlb.h b/include/asm-generic/tlb.h
> index 69de47c7ef3c5..a96d4b440f3da 100644
> --- a/include/asm-generic/tlb.h
> +++ b/include/asm-generic/tlb.h
> @@ -213,8 +213,7 @@ static inline void __tlb_remove_table(void *table)
>  {
>  	struct ptdesc *ptdesc = (struct ptdesc *)table;
>  
> -	pagetable_dtor(ptdesc);
> -	pagetable_free(ptdesc);
> +	pagetable_dtor_free(ptdesc);
>  }
>  #endif
>  
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index cad11fa10c192..94078c488e904 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -3001,6 +3001,12 @@ static inline void pagetable_dtor(struct ptdesc *ptdesc)
>  	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
>  }
>  
> +static inline void pagetable_dtor_free(struct ptdesc *ptdesc)
> +{
> +	pagetable_dtor(ptdesc);
> +	pagetable_free(ptdesc);
> +}
> +
>  static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>  {
>  	struct folio *folio = ptdesc_folio(ptdesc);

For s390:

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

