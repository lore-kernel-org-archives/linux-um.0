Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C56E3C0218C
	for <linux-um@archiver.kernel.org>; Wed, 22 Jan 2025 21:19:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=esFAzaN6g7njZiCCkaClyDhZIQCDyBL4ZttyeT6NCzw=; b=0iIBnhVEEGQjUxFGDS5QcXg9M/
	jRG365nyMN5Z43eTmkzOzfj4T//DYLXZDzpz0j2ItQU87xsm1bRi2zmnPoMLVpolhsgXX6+tEjwtd
	3TWaRVQhRh41uY22roPWtHRTXthscMQyi1n5voQQEmI6DnukDXJ5Lxws/Ws3gzvw1x12r7qaRovEE
	6hxtDEUmGdJg2N8zxhz8FVYE13Jbs7zw6xhZQRd0q73pHU0n17EDd/3EffOvtUc3VQB4WaJc+Jpz6
	0s4PZo4ErfpHOfPTrE0PIK2pnZf+0RZg0nROdTn5UjHXQjs+yR5m1ZywmKlL1P8jEGroL35W9FdLT
	GiWv1OHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tai8X-0000000BE9i-1yoO;
	Wed, 22 Jan 2025 21:19:45 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tai8U-0000000BE99-424h;
	Wed, 22 Jan 2025 21:19:44 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50MHQxkg012829;
	Wed, 22 Jan 2025 21:17:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=esFAzaN6g7njZiCCkaClyDhZIQCDyB
	L4ZttyeT6NCzw=; b=MD/1i4r7lMchVZDMxCd4+OmTL+gqvz4EsoCc3lhjzl61q/
	dWCbk7Dc9E+/mkxibxIfcO+5M2miNjCQj+Zb6N7aFJSgK9pEAqx6PGNDi1udxJ2D
	5GRkpG+GUOuS40Gu4kk1nLVzuQ6b0Ms8Wu06boltLFfDgJ845roakAZxLi7ece1K
	21P0Y61Gf0j8zaE10R3dSPAxGJBBECX5J1pPuXnnL27yt6dWzGu7RpbRMXnWFft4
	1i9lfntcbQEcz44pnsvGFWB7JR/kgZ5jistInR187FAC2imqV46/9k08iOuxZ7q0
	9o0IVrdT0Bd2ZHNbMuzwATcn0fOtey6n4VrpyBow==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44avcp3s7s-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 21:17:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 50MKlol5019223;
	Wed, 22 Jan 2025 21:17:06 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 448pmsjk01-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 22 Jan 2025 21:17:06 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 50MLH4Kc13697392
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 22 Jan 2025 21:17:04 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6C62A2004D;
	Wed, 22 Jan 2025 21:17:04 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A40CD20043;
	Wed, 22 Jan 2025 21:17:00 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.77.114])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 22 Jan 2025 21:17:00 +0000 (GMT)
Date: Wed, 22 Jan 2025 22:16:58 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Kevin Brodsky <kevin.brodsky@arm.com>
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
Message-ID: <Z5FgSn0y/c9pItED@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250103184415.2744423-1-kevin.brodsky@arm.com>
 <20250103184415.2744423-7-kevin.brodsky@arm.com>
 <Z4/NTRDBXEEimdvc@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <20250122074954.8685-A-hca@linux.ibm.com>
 <Z5D7TSR3AttkC0Jf@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z5D7TSR3AttkC0Jf@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: lJbHIFaitD84VbMmVKAwv1LP_Khu2fra
X-Proofpoint-GUID: lJbHIFaitD84VbMmVKAwv1LP_Khu2fra
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-22_09,2025-01-22_02,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 bulkscore=0 mlxlogscore=925 spamscore=0 phishscore=0 mlxscore=0
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 clxscore=1015
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501220151
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_131943_113079_A2F084A2 
X-CRM114-Status: GOOD (  32.09  )
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

On Wed, Jan 22, 2025 at 03:06:05PM +0100, Alexander Gordeev wrote:

Hi Kevin,

> On Wed, Jan 22, 2025 at 08:49:54AM +0100, Heiko Carstens wrote:
> > > >  static inline pgd_t *pgd_alloc(struct mm_struct *mm)
> > > >  {
> > > > -	return (pgd_t *) crst_table_alloc(mm);
> > > > +	unsigned long *table = crst_table_alloc(mm);
> > > > +
> > > > +	if (!table)
> > > > +		return NULL;
> > > 
> > > I do not know status of this series, but FWIW, this call is missed:
> > > 
> > > 	crst_table_init(table, _REGION1_ENTRY_EMPTY); 
> > 
> > Why is that missing?
> 
> Because the follow-up pagetable_pgd_ctor() is called against uninitialized
> page table, while other pagetable_pXd_ctor() variants are called against
> initialized one. I could imagine complications as result of that.
> 
> Whether Region1 table is the right choice is a big question though, as you
> noticed below.

As discussed with Heiko, we do not want to add the extra crst_table_init() call
at least due to performance impact. So please ignore my comment.

> > A pgd table can be a Region1, Region2, or Region3 table. The only caller of
> > this function is mm_init() via mm_alloc_pgd(); and right after mm_alloc_pgd()
> > there is a call to init_new_context() which will initialize the pgd correctly.
> 
> init_new_context() is in a way a constructor as well, so whole thing looks odd
> to me. But I do not immedeately see a better way :(
> 
> > I guess what really gets odd, and might be broken (haven't checked yet) is
> > what happens on dynamic upgrade of page table levels (->crst_table_upgrade()).
> 
> Hmm, that is a good point.
> 
> > With that a pgd may become a pud, and with that we get an imbalance with
> > the ctor/dtor calls for the various page table levels when they get freed
> 
> The ctor/dtor mismatch should not be a problem, as pagetable_pgd|p4d|pud_ctor()
> are the same and there is one pagetable_dtor() for all top levels as of now.
> But if it ever comes to separate implementations, then we are in the world
> of pain.
> 
> > again. Plus, at first glance, it looks also broken that we have open-coded
> > crst_alloc() calls instead of using the "proper" page table allocation API
> > within crst_table_upgrade(), which again would cause an imbalance.
> 
> This is a good point too.

The below bits are seems to be missed. We will test it and send a patch.

diff --git a/arch/s390/mm/pgalloc.c b/arch/s390/mm/pgalloc.c
index a4e761902093..d33f55b7ee98 100644
--- a/arch/s390/mm/pgalloc.c
+++ b/arch/s390/mm/pgalloc.c
@@ -88,12 +88,14 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 		if (unlikely(!p4d))
 			goto err_p4d;
 		crst_table_init(p4d, _REGION2_ENTRY_EMPTY);
+		pagetable_p4d_ctor(virt_to_ptdesc(p4d));
 	}
 	if (end > _REGION1_SIZE) {
 		pgd = crst_table_alloc(mm);
 		if (unlikely(!pgd))
 			goto err_pgd;
 		crst_table_init(pgd, _REGION1_ENTRY_EMPTY);
+		pagetable_pgd_ctor(virt_to_ptdesc(pgd));
 	}
 
 	spin_lock_bh(&mm->page_table_lock);
@@ -130,6 +132,7 @@ int crst_table_upgrade(struct mm_struct *mm, unsigned long end)
 	return 0;
 
 err_pgd:
+	pagetable_dtor(virt_to_ptdesc(p4d));
 	crst_table_free(mm, p4d);
 err_p4d:
 	return -ENOMEM;

Thanks!

