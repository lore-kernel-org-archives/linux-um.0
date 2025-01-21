Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B74D0C0218B
	for <linux-um@archiver.kernel.org>; Tue, 21 Jan 2025 16:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rk7YrE6UBezqaR/fdDYkZZ8HhhiqPdu23Nnd1oC9law=; b=lWOVx/CTCH7vb2ivvHbMc1lupY
	fwqykKq5Uf6RvLh4Bkqesoq3gTOjCYYVHqs+X/xzAUWCyxNeXu0jenCAHjkvNKeEb2EQr/hz/qvBq
	YinuYL4rIASxcobYTuFsL7KySzzKW4xkG4pQ/CNDlfWMTC8UY3cg95zplCgy4/4FHCNSZ50YkZ6wa
	5Tme8yQf+fTcVQaoekWno83lTV/1NRoe7gWDpZsOk2sOwuOxUO0X+JXl+nZYg1XEkrHEL2z4GGFHe
	B+QUnlXFhMZ2SPPzTsJEc6IZVZJYENEhOuZaPYoBjIYopqqMiWRK0ZVP4ROiHZZsCCw/jQvHJwKtQ
	G9ts/cGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1taHHo-00000008NRi-0pNC;
	Tue, 21 Jan 2025 16:39:32 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1taHGU-00000008NEH-21Qk;
	Tue, 21 Jan 2025 16:38:11 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50LFN5xk011302;
	Tue, 21 Jan 2025 16:37:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=rk7YrE6UBezqaR/fdDYkZZ8HhhiqPd
	u23Nnd1oC9law=; b=fz8cQTU8PvP8JVPbKU6Ynem/RjPPMY4uzRJefS9/1Tx/qT
	LzhhVSjzTVTggodrGdoC7U7DKDLLylgyhVs2FXbeQ7/tfYw6bKUuWYwWuOif/J55
	axSnjLRVcxlX4rVFmGjI9yaNmgps2TdyXZGRxYJBxyypnf4KKtSpIijUn0tx2sG2
	UQkEtTDltlKN8Af1rd91bT/prAvISQdM/HX80B8iBN3U4iv/2IgONEpJfBHX5Mtz
	927QozGW/1WX1WRlYYGSfytKSwEZp1r05DyTHoaBZJKMtMvgB8PB502t9kcSNrkN
	9ZetdoZIDddF9W2j5/S1Aryn/L+NhiQXTESjl6tQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44a5d7k4jx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 16:37:38 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50LCt2RB024252;
	Tue, 21 Jan 2025 16:37:37 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 448q0y45w5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 21 Jan 2025 16:37:36 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50LGbZEl22872488
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 21 Jan 2025 16:37:35 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id DB61420040;
	Tue, 21 Jan 2025 16:37:34 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F9B220043;
	Tue, 21 Jan 2025 16:37:34 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 21 Jan 2025 16:37:34 +0000 (GMT)
Date: Tue, 21 Jan 2025 17:37:33 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Kevin Brodsky <kevin.brodsky@arm.com>
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Ryan Roberts <ryan.roberts@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Qi Zheng <zhengqi.arch@bytedance.com>, linux-alpha@vger.kernel.org,
        linux-arch@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-um@lists.infradead.org, loongarch@lists.linux.dev,
        x86@kernel.org
Subject: Re: [PATCH v2 6/6] mm: Introduce ctor/dtor at PGD level
Message-ID: <Z4/NTRDBXEEimdvc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
 <20250103184415.2744423-7-kevin.brodsky@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250103184415.2744423-7-kevin.brodsky@arm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: _Jbv8MOWLvlsI4K8ecrKg7ZStBAwr44Z
X-Proofpoint-ORIG-GUID: _Jbv8MOWLvlsI4K8ecrKg7ZStBAwr44Z
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-21_07,2025-01-21_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 spamscore=0 clxscore=1011 mlxlogscore=539
 lowpriorityscore=0 phishscore=0 adultscore=0 malwarescore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501210134
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250121_083810_520882_5350EF90 
X-CRM114-Status: GOOD (  16.93  )
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

On Fri, Jan 03, 2025 at 06:44:15PM +0000, Kevin Brodsky wrote:

Hi Kevin,
...
> diff --git a/arch/s390/include/asm/pgalloc.h b/arch/s390/include/asm/pgalloc.h
> index 5fced6d3c36b..b19b6ed2ab53 100644
> --- a/arch/s390/include/asm/pgalloc.h
> +++ b/arch/s390/include/asm/pgalloc.h
> @@ -130,11 +130,18 @@ static inline void pud_populate(struct mm_struct *mm, pud_t *pud, pmd_t *pmd)
>  
>  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
>  {
> -	return (pgd_t *) crst_table_alloc(mm);
> +	unsigned long *table = crst_table_alloc(mm);
> +
> +	if (!table)
> +		return NULL;

I do not know status of this series, but FWIW, this call is missed:

	crst_table_init(table, _REGION1_ENTRY_EMPTY); 

> +	pagetable_pgd_ctor(virt_to_ptdesc(table));
> +
> +	return (pgd_t *) table;
>  }
>  
>  static inline void pgd_free(struct mm_struct *mm, pgd_t *pgd)
>  {
> +	pagetable_dtor(virt_to_ptdesc(pgd));
>  	crst_table_free(mm, (unsigned long *) pgd);
>  }

...

Thanks!

