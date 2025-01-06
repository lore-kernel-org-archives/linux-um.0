Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE730E77188
	for <linux-um@archiver.kernel.org>; Mon,  6 Jan 2025 13:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SHRVspXO3U3J22EWQcFrDH7XAHWgniRmJ5qosSJnn6g=; b=q6NDFQzlSryDdjbO3uhGyEZkjN
	saS02JUIrBbu/1T8K37v0T+SeWukm6+KQei8ytLAA+hMbyUUJcRFDjA4xKwg3cGQjuWO7Az3NfPFq
	TCYha8PpMN0gD8z2bwZOXqsnwh1I2sQBMwdq7cc6/XTDckja+4q1R/sC3ygoNK/2FKV5tJlwZRmEi
	0WnVNLyG1weX5s0n3ZrKPe804LmCdbwzxmtMJNyhr6nzlQ22LUW+QxTGDj4rbXoeglIuGBs1i9r1Q
	2ZeSK+3JVr3RzZZU72o/J0DhsK0/ozFZ2F/QCZh2ZLfesEpKkznAO4gkSg1GZ8gREoHmQfyVWA/Lc
	JMZia91Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUmsx-00000001LZK-3X0S;
	Mon, 06 Jan 2025 13:11:11 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUmMc-00000001FWH-1V95;
	Mon, 06 Jan 2025 12:37:47 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5063qlTX013067;
	Mon, 6 Jan 2025 12:37:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=SHRVspXO3U3J22EWQcFrDH7XAHWgni
	RmJ5qosSJnn6g=; b=gylwNq3j8Ick4RHspj1WpowzwXtJldVyTnrF8QuvAYKM9D
	cb8krtFCzCsoyxvh89UJl26z7qHWUqnN/ImInk6EwuS0vqp4PP2dgss2yasVDKW2
	Lff3/BNOwZhA8CZ78PF3yjvRLK1XQw15T7aqhCvEf/yXs04EvpitmkPslxE8hb51
	wgf5maxpIuSGfKzDGpse0DX4tM9gBITxyTYA+7bWfogitjj8uwIINly3796qqLPh
	b77+nf7AsA9eS2XD7o5ZzopzbMCJakQIq7daMPDRVe0joP4ae60Avs8p9yEVq73l
	VN9BQgghYULTXZUzQE9YkTytypyDPG5p2Q7BERgw==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4407nh1wst-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 12:37:03 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 506Cb2iQ020201;
	Mon, 6 Jan 2025 12:37:02 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4407nh1wsr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 12:37:02 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5069MVZp003593;
	Mon, 6 Jan 2025 12:37:01 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 43yfaswvgm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jan 2025 12:37:01 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 506Caxhn26870206
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jan 2025 12:36:59 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 98FB32004B;
	Mon,  6 Jan 2025 12:36:59 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 402EF20040;
	Mon,  6 Jan 2025 12:36:57 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.15.34])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Mon,  6 Jan 2025 12:36:57 +0000 (GMT)
Date: Mon, 6 Jan 2025 13:36:55 +0100
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
Message-ID: <Z3vOZ18jcCpHIcPD@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <cover.1735549103.git.zhengqi.arch@bytedance.com>
 <8ada95453180c71b7fca92b9a9f11fa0f92d45a6.1735549103.git.zhengqi.arch@bytedance.com>
 <Z3uxwiEhYHDqdTh3@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <e1de887c-6193-48ee-a9b3-04c8a0cdda45@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e1de887c-6193-48ee-a9b3-04c8a0cdda45@bytedance.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: mN1kYnlUlqSgV99r0ZXPtutQd1lOYK0_
X-Proofpoint-GUID: 4h_GDpYFs18Yd8GMGP0i2nDMJVSwVuwn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 phishscore=0 spamscore=0
 clxscore=1015 adultscore=0 suspectscore=0 malwarescore=0 mlxlogscore=643
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2501060110
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_043746_401418_C13F8D2B 
X-CRM114-Status: GOOD (  17.99  )
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

On Mon, Jan 06, 2025 at 06:55:58PM +0800, Qi Zheng wrote:
> > > +static inline void pagetable_dtor(struct ptdesc *ptdesc)
> > > +{
> > > +	struct folio *folio = ptdesc_folio(ptdesc);
> > > +
> > > +	ptlock_free(ptdesc);
> > > +	__folio_clear_pgtable(folio);
> > > +	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> > > +}
> > > +
> > 
> > If I am not mistaken, it is just pagetable_pte_dtor() rename.
> > What is the point in moving the code around?
> 
> No, this is to unify pagetable_p*_dtor() into pagetable_dtor(), so
> that we can move pagetable_dtor() to __tlb_remove_table(), and then
> ptlock and PTE page can be freed together through RCU, which is
> also the main purpose of this patch series.

I am only talking about this patch. pagetable_dtor() code above is
the same pagetable_pte_dtor() below - it is only the function name
that changed. So why to move the function body? Anyway, that is
just a nit.

> Thanks!

> > > -static inline void pagetable_pte_dtor(struct ptdesc *ptdesc)
> > > -{
> > > -	struct folio *folio = ptdesc_folio(ptdesc);
> > > -
> > > -	ptlock_free(ptdesc);
> > > -	__folio_clear_pgtable(folio);
> > > -	lruvec_stat_sub_folio(folio, NR_PAGETABLE);
> > > -}

Thank you!

