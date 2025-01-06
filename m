Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1E55E77188
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 10:38:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RryxP58J6OnCln8Pqlo5t61Qkdx5FcBQVf8+7yUkQC4=; b=nLubXUXwxVFdQ7K3cbD/wU0C74
	PXBi416KT/1QJ5Fp3hehDltAnUvToL/2BdCRx+BoZaa8OpvGwHrCmv48PwYOLJgWAFPUhY2mZ9aTZ
	oMMzWweUnv1kpk9akiqAtH1Ne50BlYhYg2AlUEf2a1vxXVMANQUdd5KQV0jPh1xJ8JtfIyMeg325z
	L07oB7uC9I5OpUJRn5tXGNy+4nyF8C54UbwATulOYDfkYf8A79EV6F2J1uw5qsJK8dpN4edgdT8xi
	NJIZXGQ/yG4OcKArGs45VlSRVOiR/OnDr9xtIBAxA0HaAuaDsjQsXTePHNAvgBCpO5AukQNV5d60U
	7s/EFfdQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkUs-00000000t0g-2Xhi;
	Mon, 06 Jan 2025 10:38:10 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkTf-00000000ske-0jTt;
	Mon, 06 Jan 2025 10:36:56 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5068Lt7i026633;
	Mon, 6 Jan 2025 10:36:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=RryxP58J6OnCln8Pqlo5t61Qkdx5Fc
	BQVf8+7yUkQC4=; b=qBCXpVvdPbt+ywixcDwnQL6Z9ZlbqjoTKd2P0szWJ5PG7K
	HrQ1dU1lfCN1w8QdSGyr0DPgqO66Ie3q/rewjUdpPXV9XDc280aXNb7xaTJA7VBs
	Apmo4/OJijEJhq+G0tWODsOXDI0M6JF8OhuoQwzpyTtJ6p890/4l5MBsiXCoaPdA
	jWrav9CzXcn/gEDNtXvu3d6gHy7ENTCfUp3F/4dtHAicfe3a1lPqMC72/3iWTlQM
	92BjmrYfEN7dxjeYXZgtqtc4DB5H338vNnKVg4GId9wHaKoWlSUxSjz7nK2elinr
	7l9jgdC7oG1Qk16vMHzYBWtDa+b9EVRm1Gss1x4Q==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43yuj5360w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:36:31 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 506AVZkY030738;
	Mon, 6 Jan 2025 10:36:30 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43yuj5360r-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:36:30 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5066jHrP027971;
	Mon, 6 Jan 2025 10:36:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yhhjw3xg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:36:29 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506AaRat55837070
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 10:36:28 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CB29A20049;
	Mon,  6 Jan 2025 10:36:27 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6187320040;
	Mon,  6 Jan 2025 10:36:25 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jan 2025 10:36:25 +0000 (GMT)
Date: Mon, 6 Jan 2025 11:36:23 +0100
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
Subject: Re: [PATCH v4 12/15] s390: pgtable: also move pagetable_dtor() of
 PxD to __tlb_remove_table()
Message-ID: <Z3uyJ2BjslzsjkZI@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ad21b9392096336cf15aee46f68f9989a9cf877e.1735549103.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RDtAwTXGBq-o50c3MhVc3_C2qJNd4B3w
X-Proofpoint-ORIG-GUID: BH90a8PnsJG6ZogqWB6Telp_r4uMcgo3
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 mlxlogscore=745 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501060093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_023655_382116_3B57BD50 
X-CRM114-Status: GOOD (  16.96  )
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

On Mon, Dec 30, 2024 at 05:07:47PM +0800, Qi Zheng wrote:
> To unify the PxD and PTE TLB free path, also move the pagetable_dtor() of
> PMD|PUD|P4D to __tlb_remove_table().

The above and Subject are still incorrect: pagetable_dtor() is
called from pagetable_dtor_free(), not from __tlb_remove_table().

...
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index 569de24d33761..c73b89811a264 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
> @@ -180,7 +180,7 @@ unsigned long *page_table_alloc(struct mm_struct *mm)
>  	return table;
>  }
>  
> -static void pagetable_pte_dtor_free(struct ptdesc *ptdesc)
> +static void pagetable_dtor_free(struct ptdesc *ptdesc)
>  {
>  	pagetable_dtor(ptdesc);
>  	pagetable_free(ptdesc);
> @@ -190,20 +190,14 @@ void page_table_free(struct mm_struct *mm, unsigned long *table)
>  {
>  	struct ptdesc *ptdesc = virt_to_ptdesc(table);
>  
> -	pagetable_pte_dtor_free(ptdesc);
> +	pagetable_dtor_free(ptdesc);
>  }
>  
>  void __tlb_remove_table(void *table)
>  {
>  	struct ptdesc *ptdesc = virt_to_ptdesc(table);
> -	struct page *page = ptdesc_page(ptdesc);
>  
> -	if (compound_order(page) == CRST_ALLOC_ORDER) {
> -		/* pmd, pud, or p4d */
> -		pagetable_free(ptdesc);
> -		return;
> -	}
> -	pagetable_pte_dtor_free(ptdesc);
> +	pagetable_dtor_free(ptdesc);
>  }

