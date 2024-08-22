Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B53A1C3DA4A
	for <linux-um@archiver.kernel.org>; Thu, 22 Aug 2024 14:07:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=012mDUm2fCWZDcYIJ2hFYZSZaAjp60g7PcWojz+2NIk=; b=CsCVrIr9uMjDgcdiLhpDFDkM5W
	iAc8RnV/daARX+vuTZiP9ZCmkuL6Ns5ldITTcqnHMrzdrXK8YPbgUkQ4pwfzihG7+5qrf4GABKLaV
	WXoHMWzWFpvfqRSDjI4iOQcmOEqX4y0BnHSS0N7XMdrItq8IRyhfNHoLAMMolI0iTM43mgwH0X+Y9
	meZgI7Tfg7j23hiFSppgoLSj4M2zUJJBonow7LpUz1Sh3owhTnrC0M4vhr7r5K8z90ydcCgxnOwCm
	1seXGXDN/VRtd2qNvn9VZ6gkBD+9fGcSrW3JwDqkWtv0upbPpXkX17TSw2VpPtQwjEkqO7SctmAM8
	QhCFGTQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh8Th-0000000D5sg-3SC6;
	Thu, 22 Aug 2024 14:07:53 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sh8Te-0000000D5rO-3fbt
	for linux-um@lists.infradead.org;
	Thu, 22 Aug 2024 14:07:52 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47M578Q1027428;
	Thu, 22 Aug 2024 14:07:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date
	:from:to:cc:subject:message-id:references:mime-version
	:content-type:in-reply-to; s=pp1; bh=012mDUm2fCWZDcYIJ2hFYZSZaAj
	p60g7PcWojz+2NIk=; b=lu8L21yGqnD+aEH/XD4Frt5dOHPwym/cMrn1uj3GVa4
	kzuO1DKexUdezI3Lef1EROsNR0YJHwQ+cuoVaJlf9cJi1Tbga4uqgXuWbGE6Fmi0
	UyFcLtbb+vfxAU9jq0xiHCPPxFfSSEq74r8E6OH3h1tTvu16J5LgXVWzoWUpMySt
	tAEU8oFkFXuJWypIdR9T8o28/Ataz5dxpWlr5GJi4t7iHP3djTrVp/arawkT39Wg
	JYtfqueMjZdj7SFCZfXa0UKh1s/hxbFRXw3/CrBYFdntLsM5EPyegxcQ1XstMtsl
	PDly7cy4minOakIdflJ8HE3Wjg09J6vaTyHLbaWCfhQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4141y20ptv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 14:07:03 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 47MC1itj017651;
	Thu, 22 Aug 2024 14:07:02 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4138w3cr2b-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 22 Aug 2024 14:07:02 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 47ME6wj655837100
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 22 Aug 2024 14:07:00 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 60A5820043;
	Thu, 22 Aug 2024 14:06:58 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2F6C320040;
	Thu, 22 Aug 2024 14:06:58 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.155.204.135])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 22 Aug 2024 14:06:58 +0000 (GMT)
Date: Thu, 22 Aug 2024 16:06:56 +0200
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-um@lists.infradead.org, x86@kernel.org
Subject: Re: [PATCH 4/5] s390: Remove custom definition of mk_pte()
Message-ID: <ZsdGAHP5rwG5yLr8@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20240814154427.162475-1-willy@infradead.org>
 <20240814154427.162475-5-willy@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240814154427.162475-5-willy@infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: K53dTj0IefNPmG9sfYv2aFJl57u7cE44
X-Proofpoint-ORIG-GUID: K53dTj0IefNPmG9sfYv2aFJl57u7cE44
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-22_07,2024-08-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 suspectscore=0 spamscore=0 mlxlogscore=312 bulkscore=0 impostorscore=0
 malwarescore=0 lowpriorityscore=0 phishscore=0 clxscore=1015
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408220105
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240822_070750_934234_5A66579B 
X-CRM114-Status: GOOD (  18.62  )
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

The PageDirty() test you suggest to remove is still entered.
I initially thought that test could also be useful for other
architectures as an optimization, but at least one path we
take for shmem mapping is raising eyebrow, because it is a
read accesss:

handle_pte_fault() -> do_pte_missing() -> do_fault() ->
do_read_fault() -> finish_fault() -> set_pte_range() -> mk_pte()

A read fault causing the PTE dirtifying is something strange
and your patch alone could be a nice cleanup.

As other architectures do not do such a trick suggests that
mk_pte() + pte_mkdirty() is called from the same handler
or pte_mkdirty() is expected to be called from a follow-up
write handler.

I could not identify locations where that would not be the case,
but may be you know?

...
> -static inline pte_t mk_pte(struct page *page, pgprot_t pgprot)
> -{
> -	unsigned long physpage = page_to_phys(page);
> -	pte_t __pte = mk_pte_phys(physpage, pgprot);
> -
> -	if (pte_write(__pte) && PageDirty(page))
> -		__pte = pte_mkdirty(__pte);
> -	return __pte;
> -}
> -#define mk_pte mk_pte

Thanks!

