Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C074CDB47E
	for <linux-um@archiver.kernel.org>; Thu, 12 Oct 2023 07:25:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Uj8dYUzwKwMaan/T6tM888KLESVWV0j2jZJL1plx/jg=; b=mzQ7dDyqlUeqUo
	r9e6u2zkib0m5NqHEM5Mk5NEH4WcyHthl29oFqRwgm5HECgMswyG/SmsmTqFdTz+0mR10N9xpn/3o
	d4j4T8kAsekPGMg4chHZtZj0aYqh66E7BFvXdhFlGp6CGr5qpEkE6W7QZ+vDW0N4C5DI0S3DO19Kc
	7HnDbvGYcMhWFqKXotDVH+c6KrzLc5qLrxDkBQYS5fFK8f7s23uMrPFsCewyQIpIR5rGK4VA9MExc
	1I8vnKKXHodK2+x2xB8FmWT9v9JlSJK7/wBRWqrNw71w21mm2MloWihTrCm2v7WliLAn00AeoMrwj
	uJLr2Kq0aSxqCAKnb5Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qqq4Z-000381-22;
	Thu, 12 Oct 2023 07:25:31 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qqq4U-00036v-1Z;
	Thu, 12 Oct 2023 07:25:29 +0000
Received: from pps.filterd (m0353722.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 39C7JN7v017051;
	Thu, 12 Oct 2023 07:25:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=5MqhUHWaw+1K2HvrJPqGawKne8YN3vxBSsQbSVm1zg8=;
 b=p50xijw8s91A2Q9ug3Gd49JWz4ZvgqA6Hy+zMLFDqVv4bzeNaYOveL4uET4RJOp3gesp
 DAwgrwHJ03HgF9eeEvp+eOO7qwrmg+XNvm8OUqoLNt7lJlDAVEqtjN8CiKqDMXhlLcky
 eKGNUZ1kMUtv/z8/kUcfCyEga3J/tdfvDxnt6ZfgS26CGMmztvCMkSoI1bmaVHklgkOD
 4j0SuHSA9ruFRWECactW6nhgOGtTYpcc3OzdI19+LWOAFipwZEMmcg23yiLFkz2UiyBh
 lGMGaxZYCj+Q2PbNgyXx8ufLOeAMZwfSd+coiMBtiELvWv8yrxN+BKmJ1I/kFUJhuVnc VA== 
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpca988bj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 07:25:11 +0000
Received: from m0353722.ppops.net (m0353722.ppops.net [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 39C7JNSY017085;
	Thu, 12 Oct 2023 07:25:10 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3tpca988ax-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 07:25:10 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 39C4sB2E001239;
	Thu, 12 Oct 2023 07:25:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3tkkvk5hry-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 12 Oct 2023 07:25:09 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 39C7P7Zc27001390
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Oct 2023 07:25:08 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DA71020065;
	Thu, 12 Oct 2023 07:25:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8AAA920063;
	Thu, 12 Oct 2023 07:25:07 +0000 (GMT)
Received: from osiris (unknown [9.152.212.60])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 12 Oct 2023 07:25:07 +0000 (GMT)
Date: Thu, 12 Oct 2023 09:25:05 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc: Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
        xen-devel@lists.xenproject.org, kvm@vger.kernel.org,
        Hugh Dickins <hughd@google.com>, David Hildenbrand <david@redhat.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Mike Rapoport <rppt@kernel.org>
Subject: Re: [PATCH mm-unstable v9 14/31] s390: Convert various pgalloc
 functions to use ptdescs
Message-ID: <20231012072505.6160-A-hca@linux.ibm.com>
References: <20230807230513.102486-1-vishal.moola@gmail.com>
 <20230807230513.102486-15-vishal.moola@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20230807230513.102486-15-vishal.moola@gmail.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: R9BBv1jP5we_uE3OHfXIw10GtOr53ihr
X-Proofpoint-GUID: -0DchMoDG4gnKEi3H7t5YnEcLMTMxRGv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.267,Aquarius:18.0.980,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-10-12_02,2023-10-11_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 spamscore=0
 mlxscore=0 priorityscore=1501 suspectscore=0 adultscore=0 mlxlogscore=661
 impostorscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2309180000 definitions=main-2310120061
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231012_002526_639515_745E666B 
X-CRM114-Status: GOOD (  21.08  )
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

On Mon, Aug 07, 2023 at 04:04:56PM -0700, Vishal Moola (Oracle) wrote:
> As part of the conversions to replace pgtable constructor/destructors with
> ptdesc equivalents, convert various page table functions to use ptdescs.
> 
> Some of the functions use the *get*page*() helper functions. Convert
> these to use pagetable_alloc() and ptdesc_address() instead to help
> standardize page tables further.
> 
> Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>
> ---
>  arch/s390/include/asm/pgalloc.h |   4 +-
>  arch/s390/include/asm/tlb.h     |   4 +-
>  arch/s390/mm/pgalloc.c          | 128 ++++++++++++++++----------------
>  3 files changed, 69 insertions(+), 67 deletions(-)
...
> diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
> index d7374add7820..07fc660a24aa 100644
> --- a/arch/s390/mm/pgalloc.c
> +++ b/arch/s390/mm/pgalloc.c
...
> @@ -488,16 +486,20 @@ static void base_pgt_free(unsigned long *table)
>  static unsigned long *base_crst_alloc(unsigned long val)
>  {
>  	unsigned long *table;
> +	struct ptdesc *ptdesc;
>  
> -	table =	(unsigned long *)__get_free_pages(GFP_KERNEL, CRST_ALLOC_ORDER);
> -	if (table)
> -		crst_table_init(table, val);
> +	ptdesc = pagetable_alloc(GFP_KERNEL & ~__GFP_HIGHMEM, CRST_ALLOC_ORDER);

I guess I must miss something, but what is the reason to mask out
__GFP_HIGHMEM here? It is not part of GFP_KERNEL, nor does s390 support
HIGHMEM.

_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
