Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5849AC98314
	for <linux-um@archiver.kernel.org>; Thu, 24 Sep 2026 12:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o0m4kYRv5wALhCfiAK1Pey/HeIsY/7BvuyIbFNmvVsg=; b=oIkRak9/kn6MCwzyDt+0d+ZH0k
	utHQP/vqFhk3UbGLoara4hQUpcT6GrRpXeQq1tbbXnoVOdeRduC9XiXi1PLuafQ/rrydAdn1HybGy
	U9MMuEqa+wCy/Qn7HU3LiWWiFrFFtdsS8LpjKqMgRK/7F/ZyO2HsZT1SRc+vSg8vgZlxg0nhh55w2
	UHClErXrLD+ImtNNTxb10h9ZZx1ZGrdk2AOpT5s7+mvbwDRYAH9j00RVX2VCniy9Kc3ha3QYrRFSz
	SieVKk3pCOpr4UOqRlmRbkYEpl/Cp7QliJ0cXgxDL9Cfh/fYQuOMtQC7ICzCk/ExKVZG/H85aJSUQ
	bN1RzU1g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9isP-0000000B0pC-1blX;
	Thu, 24 Sep 2026 12:48:37 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9isM-0000000B0oY-3UUZ
	for linux-um@lists.infradead.org;
	Thu, 24 Sep 2026 12:48:36 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68OC6g4C2028850;
	Thu, 24 Sep 2026 12:48:23 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=pp1; bh=o0m4kYRv5wALhCfiAK1Pey/HeIsY/7
	BvuyIbFNmvVsg=; b=qQ2Hjj2wU+T+jQ2mTdxTjuFtVpGtfWmsD7QYDUoeQ4ubdx
	xdXm0UPp3XRQRDNKxpaK1j19TLttT1lVedzb8W87bA000uF6Rz1iWnmz3LZUpgCq
	IVa7Tu3/yN78Xsc1Hiouu51SIOURWgeU95Lc2DkNPSxnjEoJgWiRWwxMjzCSoxdd
	o11TcXIn1uv8mcF2gHTDOkcL9TV99/l2COJCr44evImCahLxtMEjKslu2S+4rgHe
	2/8jzehwulxGhsuaNsRtUmAxTPc+zMDBB4v5eRI1IOrPOcjNRapMGENVBBK8qH2e
	bReLBU0q4cATeR2guJtDf0X3TJOxOXD66SANMEaA==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gske1rfc4-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 12:48:23 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68OCHUT92060452;
	Thu, 24 Sep 2026 12:48:22 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4gvb6qnt96-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 24 Sep 2026 12:48:22 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68OCmK8045941090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Sep 2026 12:48:21 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D5AF92004B;
	Thu, 24 Sep 2026 12:48:20 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE86420040;
	Thu, 24 Sep 2026 12:48:20 +0000 (GMT)
Received: from osiris (unknown [9.224.90.220])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Thu, 24 Sep 2026 12:48:20 +0000 (GMT)
Date: Thu, 24 Sep 2026 14:48:19 +0200
From: Heiko Carstens <hca@linux.ibm.com>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
        linux-um@lists.infradead.org, linux-s390@vger.kernel.org,
        Huacai Chen <chenhuacai@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Johannes Berg <johannes.berg@intel.com>
Subject: Re: [PATCH 1/4] s390: remove unwind_module_init()
Message-ID: <20260924124819.13740Cdf-hca@linux.ibm.com>
References: <20260924124039.1621965-6-johannes@sipsolutions.net>
 <20260924144039.4af0d88b163a.I91f8c59a12ad3d5fe67d50aa3b0434d666ffc9f8@changeid>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260924144039.4af0d88b163a.I91f8c59a12ad3d5fe67d50aa3b0434d666ffc9f8@changeid>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WJNZQMETORnTgCCwmirSHN5QHnf5fLl4
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1MiBTYWx0ZWRfXxNLqobSNdxpd
 I6r97ViBB0WlbXEAvgScardNjmnxkgDd+HM066h1sbWWhoEzdXTXRjXsgnjzTY6PYU2ctlUMCPr
 xVQG7ogdMc2acOch0yL9Nn0xMRVicMcr1T0PpdwJPSkEFRauRswt6JHm3D9aMCSIHCwabW/Cc7x
 UHZojJ4gnoPLJHB2BZp9i5O0lf9u/TY27id8onKUzJRrxWt1O8AX+oKVT8Z8tjmKLi6QVhzhpW+
 iRRJScrs6OSqJtvK1lGT0ZTnqal0Ge7IEnjfrdAZ3YV4nrtVImwVlXHDRilrDVnnSjhBAkk6Cq6
 PRHf/dmrgIlwjRQuxAmKpU+6/8s/PZr76RF/1sQIAJSkf9pna0O23Q69gOz63g1EoeEY7/Zz5Fz
 96k+DEzBHfUPdKRJVrDYcanmy2aS9J03tflzpbD2+M9aM0GSTBjN5XTvGq3omU13QTuIfjK8Vf/
 mTZQM5ln2P2UV/VjyEA==
X-Authority-Analysis: v=2.4 cv=O/KsLx9W c=1 sm=1 tr=0 ts=6ab51c17 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=QyXUC8HyAAAA:8
 a=VnNF1IyMAAAA:8 a=Kv2GCGW8xjvUN6ocNewA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1MiBTYWx0ZWRfX0XqNPV2Gthkn
 Gk4bzlxiWAdOJUbLnjHSoyOF/4Xgtwga3JaQ56xrPJobHZOzZ7of+K0VrCnGOxMOGVx3DG1xC3k
 n+3StKlMeIztxo4/+1G++5zySygRSUk=
X-Proofpoint-GUID: WJNZQMETORnTgCCwmirSHN5QHnf5fLl4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 phishscore=0 impostorscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2609240052
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260924_054834_987621_67E1F29B 
X-CRM114-Status: GOOD (  17.02  )
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

On Thu, Sep 24, 2026 at 02:35:50PM +0200, Johannes Berg wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> This is dead code, but will likely conflict with
> the ORC unwinder unification.
> 
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>
> ---
>  arch/s390/include/asm/unwind.h | 3 ---
>  1 file changed, 3 deletions(-)
> 
> diff --git a/arch/s390/include/asm/unwind.h b/arch/s390/include/asm/unwind.h
> index b8ecf04e3468..021056d5982c 100644
> --- a/arch/s390/include/asm/unwind.h
> +++ b/arch/s390/include/asm/unwind.h
> @@ -91,8 +91,5 @@ static inline struct pt_regs *unwind_get_entry_regs(struct unwind_state *state)
>  	     unwind_next_frame(state))
>  
>  static inline void unwind_init(void) {}
> -static inline void unwind_module_init(struct module *mod, void *orc_ip,
> -				      size_t orc_ip_size, void *orc,
> -				      size_t orc_size) {}

This probably went upstream by mistake a couple of years ago.

Acked-by: Heiko Carstens <hca@linux.ibm.com>

