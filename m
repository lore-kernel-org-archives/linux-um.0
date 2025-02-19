Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C094BC021AA
	for <linux-um@archiver.kernel.org>; Wed, 19 Feb 2025 09:14:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tnUmi/+GDTm7yWualJNQl5++GpWqIIggR47W1xDCCK0=; b=fVQWXNLwPBBPjILforGHM+4In+
	HBP8BSvZvdMPyoBRnsL3HSxPSMdrbTul1XMxs3IX24bk5ogQUzG9LbI67D4bjri9LIR3bGmSj2nui
	Fv0KGkOs62aLTRLGDDKZjuzDnxqlpz/2ZQ8PY67Kxx1Mbz7HIH8OzCDXoflKRzTmsa5sKg+aWysV1
	i6R9ZxB9pKD6G20tZtZU9Mzh/wVkkvwCdVxw7UKkFqUf2IyE2p9Yk+1oxE+hQsff7ARKPxwxMroN3
	Wa1xKP6h6r5AE55l964gtcMVBl1YAUdss1M7HBVpiaUqCNQ8jR+g3GK9w7h18VRHF78kb3MwRC6P0
	Rbd3/b/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tkgAS-0000000Bm1q-1i1w;
	Wed, 19 Feb 2025 09:14:56 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tkfj7-0000000Bcmh-34fl
	for linux-um@lists.infradead.org;
	Wed, 19 Feb 2025 08:46:42 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51J75CS5019820;
	Wed, 19 Feb 2025 08:46:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=tnUmi/+GDTm7yWualJNQl5++GpWqII
	ggR47W1xDCCK0=; b=Ug04kj8iMYHe7BiulyxakjeqvhE5vGWEcPq1sZxyUUiMpV
	L96GGlP4zARNaJAQWTwAIzJ7EYyj0/fLOO/eEeUz1Qm6PfyohszWQLhfigjhHJuO
	9pkGDOD9Duvtl78Z15h0FvDq7LS487A6ZFmo8kLD6G82ubP/YDeq9iB1rUmZRZhV
	Acyq1Urx+Hj4DKgbBOSfp73Oe9aQ9jKG9rh3AJoHS80RUjKxZQa0+nlkm+JhwtlT
	46b85K1laetS/QWKGHZ9udfq6tm95YB6oytrzPAwgmJLUzssI8GbBT28E9SPsn4S
	P1ZDUi46KCB2gRarv3/+GEPtr7ZabhTbY890Zxrw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 44vyyq2vp3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:46:30 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 51J6YC18009702;
	Wed, 19 Feb 2025 08:46:29 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 44w03y33kv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Feb 2025 08:46:29 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 51J8kREv49545472
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 19 Feb 2025 08:46:28 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D4C172004B;
	Wed, 19 Feb 2025 08:46:27 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5CB2B20040;
	Wed, 19 Feb 2025 08:46:27 +0000 (GMT)
Received: from li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com (unknown [9.179.14.227])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 19 Feb 2025 08:46:27 +0000 (GMT)
Date: Wed, 19 Feb 2025 09:46:25 +0100
From: Alexander Gordeev <agordeev@linux.ibm.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc: linux-mm@kvack.org, linux-arch@vger.kernel.org, x86@kernel.org,
        linux-s390@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-um@lists.infradead.org
Subject: Re: [PATCH 1/7] mm: Set the pte dirty if the folio is already dirty
Message-ID: <Z7WaYRjS/VW2aKJN@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
References: <20250217190836.435039-1-willy@infradead.org>
 <20250217190836.435039-2-willy@infradead.org>
 <Z7WJL+sgPLB3dboi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z7WJL+sgPLB3dboi@li-008a6a4c-3549-11b2-a85c-c5cc2836eea2.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: 0vOIzLJ4HxK9oV3CqviyzbQJOr99MTrw
X-Proofpoint-ORIG-GUID: 0vOIzLJ4HxK9oV3CqviyzbQJOr99MTrw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-19_03,2025-02-18_01,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 adultscore=0 bulkscore=0 mlxscore=0 clxscore=1015
 spamscore=0 suspectscore=0 phishscore=0 mlxlogscore=414 priorityscore=1501
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2502100000 definitions=main-2502190066
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250219_004641_882148_D060D307 
X-CRM114-Status: UNSURE (   8.72  )
X-CRM114-Notice: Please train this message.
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

> Reviewed-by: Alexander Gordeev <agordeev@linux.ibm.com>

Sorry, I meant for s390.
Can not judge the other archs impact.

