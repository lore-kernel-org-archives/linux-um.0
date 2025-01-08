Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ED6EE77188
	for <linux-um@archiver.kernel.org>; Wed,  8 Jan 2025 16:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/0pEosJAtrrq7+AZfl2ID181pVMDXxvqRB1iDHPru/M=; b=P1KAQyNIPIz304hMGhdPYAYwkX
	UMbgtaicbvIj8FG6RkgpnfTND5QT9JdcmXQgYFVsv0/ymZ8HaorbTV07G93BHVRbGAbd1rk4wJEU+
	J3DFEvghI+MfK/82y9Infp3uDKBg5GPgTceMqhvb9/375fJHnTnEpUMPqi9JiPAJoAxJlCfLYBXfe
	ab7cEi5naq8BYXt9fATqWj5CaGm0WWQ0eRLrjdDkp6MVyuw4GHFoJLZlF8SatR4ZoJSULnnwWxsSE
	hy4tkVmVmrScAKsOk9CSWIM2TaqYT42WqchQxbtUn8MMpvSh1GPAPzF6ew5G0qA7t1xZs0+RdPABV
	pwutZViw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYhn-000000097r4-0arX;
	Wed, 08 Jan 2025 16:14:51 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tVYgX-000000097Zd-2nsX;
	Wed, 08 Jan 2025 16:13:34 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 508Ew0Hd008979;
	Wed, 8 Jan 2025 16:13:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=/0pEosJAtrrq7+AZfl2ID181pVMDXx
	vqRB1iDHPru/M=; b=Qc2i4Tp0uvBRyl+jGtaMLwYGZKKaztQUee3zrazLkmkths
	BKjfeh5hc4DNF+FovJkBB/fHbU/DPDjRCbIEh/eMZyHyvXxayMqu9FBQFJOug4QH
	iQGB7QT793mBW00g/2e5RWsTUnIRvzEqsPYZoZ1xrycOjY77mjmhxD3Tr58vKYfh
	i5WI1PseA+GU3nr66lZ1WH05bULNRioNAgJgAm9VNeTRLQ4pRSeX+RYdvIB2cetS
	GTBBs7NBz+M3Z6MiU02DQX/J9dzcrcbfHP6qZ8C6ajXXZ6zofEYRDTTx4bda1nof
	mnWd9f4JhtWC7wiQ3TFYDev/txCoPQl/rsnDG/uQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupu905-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:13:02 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 508GD1K1025958;
	Wed, 8 Jan 2025 16:13:01 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 441hupu901-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:13:01 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 508CW5fH003630;
	Wed, 8 Jan 2025 16:13:00 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfat8qq7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 08 Jan 2025 16:13:00 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 508GCwru8061280
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 8 Jan 2025 16:12:58 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B38D720040;
	Wed,  8 Jan 2025 16:12:58 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1575720043;
	Wed,  8 Jan 2025 16:12:58 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed,  8 Jan 2025 16:12:58 +0000 (GMT)
Date: Wed, 8 Jan 2025 17:12:56 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Qi Zheng <zhengqi.arch@bytedance.com>
Cc: peterz@infradead.org, kevin.brodsky@arm.com, alex@ghiti.fr,
        andreas@gaisler.com, palmer@dabbelt.com, tglx@linutronix.de,
        david@redhat.com, jannh@google.com, hughd@google.com,
        yuzhao@google.com, willy@infradead.org, muchun.song@linux.dev,
        vbabka@kernel.org, lorenzo.stoakes@oracle.com,
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
Subject: Re: [PATCH v5 06/17] s390: pgtable: add statistics for PUD and P4D
 level page table
Message-ID: <Z36kCF6tgnzkIRDM@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1736317725.git.zhengqi.arch@bytedance.com>
 <4707dffce228ccec5c6662810566dd12b5741c4b.1736317725.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4707dffce228ccec5c6662810566dd12b5741c4b.1736317725.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: KUhXNS6aArO_tUV9i1PAsm9yGShhoIw3
X-Proofpoint-GUID: AEhKKtU-rxWzLnMSxQ4AI9AzMP3tXlSR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 clxscore=1011 mlxscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 spamscore=0 bulkscore=0 impostorscore=0 mlxlogscore=890
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501080133
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250108_081333_717175_B816F42B 
X-CRM114-Status: GOOD (  18.05  )
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

On Wed, Jan 08, 2025 at 02:57:22PM +0800, Qi Zheng wrote:
> Like PMD and PTE level page table, also add statistics for PUD and P4D
> page table.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
> Cc: linux-s390@vger.kernel.org
> ---
>  arch/s390/include/asm/pgalloc.h | 29 +++++++++++++++++++++--------
>  arch/s390/include/asm/tlb.h     |  2 ++
>  2 files changed, 23 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> index 7b84ef6dc4b6d..a0c1ca5d8423c 100644
> --- a/arch/s390/include/asm/pgalloc.h
> +++ b/arch/s390/include/asm/pgalloc.h
> @@ -53,29 +53,42 @@ static inline p4d_t *p4d_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
>  	unsigned long *table = crst_table_alloc(mm);
>  
> -	if (table)
> -		crst_table_init(table, _REGION2_ENTRY_EMPTY);
> +	if (!table)
> +		return NULL;
> +	crst_table_init(table, _REGION2_ENTRY_EMPTY);
> +	pagetable_p4d_ctor(virt_to_ptdesc(table));
> +
>  	return (p4d_t *) table;
>  }
>  
>  static inline void p4d_free(struct mm_struct *mm, p4d_t *p4d)
>  {
> -	if (!mm_p4d_folded(mm))
> -		crst_table_free(mm, (unsigned long *) p4d);
> +	if (mm_p4d_folded(mm))
> +		return;
> +
> +	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
> +	crst_table_free(mm, (unsigned long *) p4d);
>  }
>  
>  static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>  {
>  	unsigned long *table = crst_table_alloc(mm);
> -	if (table)
> -		crst_table_init(table, _REGION3_ENTRY_EMPTY);
> +
> +	if (!table)
> +		return NULL;
> +	crst_table_init(table, _REGION3_ENTRY_EMPTY);
> +	pagetable_pud_ctor(virt_to_ptdesc(table));
> +
>  	return (pud_t *) table;
>  }
>  
>  static inline void pud_free(struct mm_struct *mm, pud_t *pud)
>  {
> -	if (!mm_pud_folded(mm))
> -		crst_table_free(mm, (unsigned long *) pud);
> +	if (mm_pud_folded(mm))
> +		return;
> +
> +	pagetable_pud_dtor(virt_to_ptdesc(pud));
> +	crst_table_free(mm, (unsigned long *) pud);
>  }
>  
>  static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long vmaddr)
> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
> index e95b2c8081eb8..907d57a68145c 100644
> --- a/arch/s390/include/asm/tlb.h
> +++ b/arch/s390/include/asm/tlb.h
> @@ -122,6 +122,7 @@ static inline void p4d_free_tlb(struct mmu_gather *tlb, p4d_t *p4d,
>  {
>  	if (mm_p4d_folded(tlb->mm))
>  		return;
> +	pagetable_p4d_dtor(virt_to_ptdesc(p4d));
>  	__tlb_adjust_range(tlb, address, PAGE_SIZE);
>  	tlb->mm->context.flush_mm = 1;
>  	tlb->freed_tables = 1;
> @@ -140,6 +141,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>  {
>  	if (mm_pud_folded(tlb->mm))
>  		return;
> +	pagetable_pud_dtor(virt_to_ptdesc(pud));
>  	tlb->mm->context.flush_mm = 1;
>  	tlb->freed_tables = 1;
>  	tlb->cleared_p4ds = 1;

Acked-by: Alexander Gordeev <agordeev@linux.ibm.com>

Thanks!

