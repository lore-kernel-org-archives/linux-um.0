Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FF80C021AA
	for <linux-um@archiver.kernel.org>; Wed, 19 Feb 2025 07:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7cnvWzA7RfaVCOT66pTUOghWekuaZgxsFcMzX2h0QBE=; b=ImrDnSqi9T0upvelh3htI7Yedt
	xRSkbFQnoj9hAulGmumCIpdQnId0c31H1K5cLehRUx4CW10oSOm3wuPYYLvFbkTlB5sr45ziCiPU5
	m4/pVocoCuXD5aqQNRew+S6CUbcXOwmrXkjhODSxzc9+CV+SoSq2gRARTGWvCw4nqcp+RYkLJmpzQ
	2TUsanBfG30atxuotiJHSI2SCvchjoTyeIZRpIl1Wq8GNlgwOM7PxV+X3CJ8Zktc90QABMEWuyl2z
	iuKpdMs0mkQ88+oE4AN6k/3LPy1XkCfKkkOb/ga6NJZp7+C6OXKb20xt74/Z7UbXZQ4UTm3f/OsAT
	HPmUk2xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeVB-0000000BF8s-0uHF;
	Wed, 19 Feb 2025 07:28:13 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkeUa-0000000BExX-0Z4h
	for linux-um@lists.infradead.org;
	Wed, 19 Feb 2025 07:27:37 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75IAE001899;
	Wed, 19 Feb 2025 07:27:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=7cnvWzA7RfaVCOT66pTUOghWekuaZg
	xsFcMzX2h0QBE=; b=R7iIvY16LPJs0SC10eTbpwjNLhVbolsSaxD1XsJbVDUqmu
	j4aNluI6Y1sE0K+zEiv+hGEYnp0ZLBp6q53QAlxiBhjkdesvKL1K0ElytuHPKi0n
	WbRK5AYvW3AlKsWQE4yXqn6SstVjzpQ3wldstJeOkCSTZ7xTwjdyMDOdWlPmtWsT
	ReuIq8iltTpXJtI2o+ZHhbPNvUJ9YscNhq55EeiKZp2boaLjcz1R/049dXNPAbLA
	6TO9/wW9TSwevn9l4JL2JQ/Q885FhOWw511FosvgHbEM4zjCrvOthqydWnv0h+Kk
	gse7GpwQ29bhz9qD3tX8hc6MY/G5BAYdFLw8PdrQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyptgrs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 07:27:27 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J6bfxa030158;
	Wed, 19 Feb 2025 07:27:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 44w01x2spq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 07:27:26 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J7RNGk50594202
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 07:27:24 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63ADA2004E;
	Wed, 19 Feb 2025 07:27:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E17AA20043;
	Wed, 19 Feb 2025 07:27:22 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.14.227])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Feb 2025 07:27:22 +0000 (GMT)
Date: Wed, 19 Feb 2025 08:27:21 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7WH2VPdFvX6reij@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
 <Z7SzTHQGFXreZ6zd@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
 <Z7S-HgdXls65goJx@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7S-HgdXls65goJx@casper.infradead.org>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Qw4yE85lztD2877JVVqO7QrP47WEM6hu
X-Proofpoint-ORIG-GUID: Qw4yE85lztD2877JVVqO7QrP47WEM6hu
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=332 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 impostorscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2502190053
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250218_232736_281625_584DA235 
X-CRM114-Status: GOOD (  17.16  )
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

On Tue, Feb 18, 2025 at 05:06:38PM +0000, Matthew Wilcox wrote:
...
> > With the above the implicit dirtifying of hugetlb PTEs (as result of
> > mk_huge_pte() -> mk_pte()) in make_huge_pte() is removed:
> > 
> > static pte_t make_huge_pte(struct vm_area_struct *vma, struct page *page,
> > 		bool try_mkwrite)
> > {
> > 	...
> > 	if (try_mkwrite && (vma->vm_flags & VM_WRITE)) {
> > 		entry = huge_pte_mkwrite(huge_pte_mkdirty(mk_huge_pte(page,
> > 					 vma->vm_page_prot)));
> > 	} else {
> > 		entry = huge_pte_wrprotect(mk_huge_pte(page,
> > 					   vma->vm_page_prot));
> > 	}
> 
> Took me a moment to spot how this was getting invoked; for anyone else
> playing along, it's mk_huge_pte() which calls mk_pte().
> 
> But I'm not sure how you lose out on the PTE being marked dirty.  In
> the first arm that you've quoted, the pte is made dirty anyway.  In the
> second arm, it's being writeprotected, so marking it dirty isn't a
> helpful thing to do because writing to it will cause a fault anyway?
> 
> I know s390 is a little different, so there's probably something I'm
> missing.

No, it is just me missing the obvious.

