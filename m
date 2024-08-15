Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5584EC52D7C
	for <linux-um@archiver.kernel.org>; Thu, 15 Aug 2024 12:13:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Xd64frNEOeLFKhWfmvTBNHEnJQbuJhSqIR8O1N+8JAw=; b=rdUOX3pD7MpbWkZDeroidRF+oN
	cBhJxHPQSCctue+kDDqVPmXjxY63pDm/6AlM8B44GrZbpzmo549h25lx3tKhmtMbllBaLF6WmTDEU
	/C0QIg7Swsqm9de37PEIWB/4/gud70ppGqQc8zPRQE52GNGp9VKqf/gfRDTUMbriqiyoBhobw3Lcr
	ghotKVbnkkG+CI9H25ARb3ExSUOTzDiDgDXqTFmZ5V+DCUnWZ9H3xggdwRaYYIFRaiLPjxbBAVSIW
	dqmQmI+DFacJg4ogDjpQGE2BiFiGhMckn19vd3N75rqd8DV0Gc7jaSbGpOP2Jkweq0wk7x0GxIspq
	DCIUO0kQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seZLg-00000009rTe-1cei;
	Thu, 15 Aug 2024 12:13:00 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1seZLc-00000009rQp-3KVd
	for linux-um@lists.infradead.org;
	Thu, 15 Aug 2024 12:12:58 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47FBKP9r026593;
	Thu, 15 Aug 2024 12:12:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=Xd64frNEOeLFKhWfmvTBNHEnJQb
	uJhSqIR8O1N+8JAw=; b=aEtNSewIsOxiFfdSDm5P7ULut5AJ6szYIqS4Xh1ulKA
	Jhj/jexK11owQT1/zINKb6NBI5WwhuhjEIEHXjYwv7cr/xys7VPKHfMLL8Ue7IHy
	yqG1XOFjiei1f49LYzVJQZsrtjLRI0v5ZPxrsNaaTLh36Zsd7welFEZlVNrElhhL
	6JsH2ooZH5VFVwsL/zHd/FOxtwgkAdNC0nHBjE0uDIw0dFC4frv3vlLdc95YTK3G
	QlygyzeTjErADWAJFIzSqCu5K/vUueCZeuGjNKBre5MyvfCcLcp0I3qRlN1GJvFH
	/x3WFQ8aY7gy4DDZSBdV08KlsK/Br6MYz5t7RpSVmfA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4111d6keaw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 12:12:42 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id 47F8dU2n010055;
	Thu, 15 Aug 2024 12:12:42 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 40xjx0xtgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 15 Aug 2024 12:12:42 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47FCCaGf34341270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 12:12:38 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F38B2004B;
	Thu, 15 Aug 2024 12:12:36 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5770220040;
	Thu, 15 Aug 2024 12:12:35 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.171.11.33])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 15 Aug 2024 12:12:35 +0000 (GMT)
Date: Thu, 15 Aug 2024 14:12:33 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH 4/5] s390: Remove custom definition of mk_pte()
Message-ID: <Zr3wsRHO+hcwv5Y0@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240814154427.162475-1-willy@infradead.org>
 <20240814154427.162475-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814154427.162475-5-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 35RWKvcTfZLS9yX681VV333VTIEl95d-
X-Proofpoint-ORIG-GUID: 35RWKvcTfZLS9yX681VV333VTIEl95d-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-15_03,2024-08-15_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=306
 spamscore=0 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501
 adultscore=0 impostorscore=0 clxscore=1011 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408150087
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240815_051256_989637_6920D232 
X-CRM114-Status: GOOD (  14.90  )
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

On Wed, Aug 14, 2024 at 04:44:24PM +0100, Matthew Wilcox (Oracle) wrote:

Hi Matthew,

> I believe the test for PageDirty() is no longer needed.  The
> commit adding it was abf09bed3cce with the rationale that this
> avoided faults for tmpfs and shmem pages.  shmem does not mark
> newly allocated folios as dirty since 2016 (commit 75edd345e8ed)
> so this test has been ineffective since then.

We will investigate if that is really safe thing to do.
Some people on vacation, so we might be not too quick
with the response.

> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  arch/s390/include/asm/pgtable.h | 11 -----------
>  1 file changed, 11 deletions(-)
...

Thanks!

