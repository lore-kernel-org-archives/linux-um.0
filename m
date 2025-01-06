Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 165EEE77188
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 10:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dnAi9vboNreX09uRn4QgN1f6lRQiYdckkGm/8S9k+Vc=; b=Wkey8ANZBU7VYaR/zlcSNfk1il
	zVBMyZPRFb4WeagERL7v0qQWJ/wWD3FZ4udm9tlE51DZibn171Qr05B+Jv+tNxRuVQ1QkxQ16YaFi
	6o48fW2turBZDGH2J7L5qYdRYpA6mGfscFwb7UEEnpQvJFQA+9WuSx3dITpUahnI6tyh9/afK5qIg
	GMAcXib4SYdyQECfOf4+ijO1x/o6PNuynUr2mUzJbyYruDsX+ngfhb3Xa6mO0UL1XevLGF5RuQ2Hi
	XetPbUBT30GehLcjsQl2Y9vFKsza8M6B3Frgo1g0TcUIAX1f7N+GQ8lp2N6r6D46v1bCo94GdNlrM
	u14gGh0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkTG-00000000scR-3ZNR;
	Mon, 06 Jan 2025 10:36:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUkS1-00000000sFk-43P8;
	Mon, 06 Jan 2025 10:35:15 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 505JvJen031175;
	Mon, 6 Jan 2025 10:34:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=dnAi9vboNreX09uRn4QgN1f6lRQiYd
	ckkGm/8S9k+Vc=; b=lJjDdKQbHBAfb2paVM4758NXe1/08nF6JK3uPflEn31ywo
	1C0/oBGvo+Ljgoc8PbS/JHw2VSdo16T40bu7fqXETUxwGPxIHe1vYQpzGB/IVJ/+
	ILYsydLUu1DCIt7AGPJsrcByuGV5RY8fiD4Yd44lrKx9+HqXFnP9gd9cHbonHYbC
	BJlVtgSazqQQEHcEXS23IfkMVxl57CRM9NGSfC3DnvIhpP4n/W/sv7O7sr43fum0
	M8q7Sscq7ZMICtfmFQLksYfQNImyVC3WC29iJ+rIJHTum6ej9wbIdZUXURyvohT5
	EmZwj35ZLWmpFz1qlcU0aEk9eaRHKtXv7XMrc4xQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43yuj535pe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:34:50 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 506AYna5006101;
	Mon, 6 Jan 2025 10:34:49 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 43yuj535pb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:34:49 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5069LKLx008875;
	Mon, 6 Jan 2025 10:34:48 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 43yfpyne4b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 10:34:48 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506AYkCL50004474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 10:34:46 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9455920040;
	Mon,  6 Jan 2025 10:34:46 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5C37F20043;
	Mon,  6 Jan 2025 10:34:44 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jan 2025 10:34:44 +0000 (GMT)
Date: Mon, 6 Jan 2025 11:34:42 +0100
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
Subject: Re: [PATCH v4 07/15] mm: pgtable: introduce pagetable_dtor()
Message-ID: <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: EI5YeJeBWRmXu7KfUK8OQ8xMPr6rjfLI
X-Proofpoint-ORIG-GUID: 1-ZrVK8NzjkPVWjFoOuBxf3mikBbpEnE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 clxscore=1011
 malwarescore=0 priorityscore=1501 bulkscore=0 spamscore=0 impostorscore=0
 mlxlogscore=571 phishscore=0 suspectscore=0 mlxscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2411120000
 definitions=main-2501060093
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_023514_160466_8875D05C 
X-CRM114-Status: GOOD (  21.49  )
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

On Mon, Dec 30, 2024 at 05:07:42PM +0800, Qi Zheng wrote:
> The pagetable_p*_dtor() are exactly the same except for the handling of
> ptlock. If we make ptlock_free() handle the case where ptdesc->ptl is
> NULL and remove VM_BUG_ON_PAGE() from pmd_ptlock_free(), we can unify
> pagetable_p*_dtor() into one function. Let's introduce pagetable_dtor()
> to do this.
> 
> Later, pagetable_dtor() will be moved to tlb_remove_ptdesc(), so that
> ptlock and page table pages can be freed together (regardless of whether
> RCU is used). This prevents the use-after-free problem where the ptlock
> is freed immediately but the page table pages is freed later via RCU.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> Originally-by: Peter Zijlstra (Intel) <peterz@infradead.org>
...
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 5d82f42ddd5cc..cad11fa10c192 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -2992,6 +2992,15 @@ static inline bool ptlock_init(struct ptdesc *ptdesc) { return true; }
>  static inline void ptlock_free(struct ptdesc *ptdesc) {}
>  #endif /* defined(CONFIG_SPLIT_PTE_PTLOCKS) */
>  
> +static inline void pagetable_dtor(struct ptdesc *ptdesc)
> +{
> +	struct folio *folio = ptdesc_folio(ptdesc);
> +
> +	ptlock_free(ptdesc);
> +	__folio_clear_pgtable(folio);
> +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> +}
> +

If I am not mistaken, it is just pagetable_pte_dtor() rename.
What is the point in moving the code around?

>  static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>  {
>  	struct folio *folio = ptdesc_folio(ptdesc);
> @@ -3003,15 +3012,6 @@ static inline bool pagetable_pte_ctor(struct ptdesc *ptdesc)
>  	return true;
>  }
>  
> -static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
> -{
> -	struct folio *folio = ptdesc_folio(ptdesc);
> -
> -	ptlock_free(ptdesc);
> -	__folio_clear_pgtable(folio);
> -	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> -}
> -
>  pte_t *___pte_offset_map(pmd_t *pmd, unsigned long addr, pmd_t *pmdvalp);
>  static inline pte_t *__pte_offset_map(pmd_t *pmd, unsigned long addr,
>  			pmd_t *pmdvalp)

