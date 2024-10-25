Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FF86D116F7
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 06:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=JagbP0hzDjaKwiHKO4fecRmGpmxLAC3Y7SA7f/4dOhM=; b=P3mM6WhXfnaaPL5FYDUMCGiqNg
	AOsjicHZ5wOkY3Ln/MSADMPL/dVuzsi530A3W9wEeEKaxSlGdcGfVsZU16pZbfqQDVjEc4vPOtXMh
	qPEfpHBdfK3jGXycuY5Ks1K2GQvl7zpauADDT+LQEQl3jCPufAdTFeu2hsbg1zomHkqTPv+0JdMss
	YuAlK1z9mj9TVqX9+i05Y32hb1fjv2/wLEpQUqMBS3hor/qTLUcm77G7bAmYD3iSRP1HHcS5c6thO
	USI1VmPTzql+S9McLl0Hgkctsw34sYQKrnmnDLKhNSqFmge5iYF2Tm41WeSONYfyiPWhrMGqHlfdf
	oxXi7T9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4DQm-00000002dRH-09Wr;
	Fri, 25 Oct 2024 06:04:16 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4DQi-00000002dQd-2vQC
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 06:04:14 +0000
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49OMn8Cq021958;
	Fri, 25 Oct 2024 06:04:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=JagbP0hzDjaKwiHKO4fecR
	mGpmxLAC3Y7SA7f/4dOhM=; b=Yhmfjkv+Zye7ieKE3FS1DgdMJCi9UkMOG1z8DX
	ulvvBEMixlIcvasFEVUXOrTTA2PaOeq2EyTply23gLNcwO9Tn7oVQVWobQy2XgJy
	dq2ukxk10Dg44voXFjz6ty2cWkKxfYIAh3k3xVC/pcHIQm/UJ/RICfcVm5Qj10Sg
	nraCrP7jnhk2PrmwefSUciYH7pSLJvLW9beHo0+2vlQhPhdm7PBh3JjTk0wqzghn
	syNyj3CLaDhf9kdbZ2SNqnZjEdo4VyHh9xqTgP0d15X1t8Wdw2NBGjK4X2/kPCwd
	KEC4/X6saxCgIgaxjGQurb++IVruMm/1qEni2D3iIPwBNuag==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42fk52ju2v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:04:03 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P641fe025391
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 06:04:01 GMT
Received: from shaojied-gv.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 24 Oct 2024 23:03:59 -0700
From: shaojiedong <quic_shaojied@quicinc.com>
Date: Fri, 25 Oct 2024 14:03:32 +0800
Subject: [PATCH v2] um: Remove double zero check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241025-upstream_branch-v2-1-072009bfa7d0@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALM0G2cC/3WNQQ6CMBBFr0JmbU3bAFJX3sMQU6ajzIICLTQaw
 t2t7F2+l/z3N4gUmCJciw0CJY48+gz6VAD21r9IsMsMWupSSV2JdYpLIDs8umA99kLW1pA12pS
 Ng7yaAj35fRTvbeae4zKGz3GQ1M/+byUllCgbbSpZ4wVdd5tXRvZ4xnGAdt/3L6VhKIWwAAAA
X-Change-ID: 20241025-upstream_branch-06a9ea92948d
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov
	<anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        shaojiedong <quic_shaojied@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729836239; l=1280;
 i=quic_shaojied@quicinc.com; s=20241025; h=from:subject:message-id;
 bh=8o9W8zhApjPR6I1YoCkF8eddbfkiaDsXaRFyIgHuQ5k=;
 b=ADX67u1LQn9dycjyPbyzdDKPmQZySgOseU8sJw+puI/rH2ziXdJTbe686cUA1QWIZGaUXt+pK
 625iABGGRNKAZzGti+5EBKMgAblH7aZLNSf4v8E0JBHlP3qcLblkcbO
X-Developer-Key: i=quic_shaojied@quicinc.com; a=ed25519;
 pk=33bgN72hchuZbXKwEWehpvql40CPvTfN8DSdi8JrU6E=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: FQ1xxVqBiOPJY6chUcQlL2PqojzizjMo
X-Proofpoint-ORIG-GUID: FQ1xxVqBiOPJY6chUcQlL2PqojzizjMo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 mlxscore=0
 lowpriorityscore=0 malwarescore=0 impostorscore=0 phishscore=0
 adultscore=0 mlxlogscore=928 priorityscore=1501 spamscore=0 bulkscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250045
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241024_230412_896684_004D3FCA 
X-CRM114-Status: GOOD (  10.53  )
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

free_pages() performs a parameter null check inside
previous code also does zero check as following
    if (stack == 0)
        goto out;

    to_mm->id.stack = stack;

therefore remove double zero check here.

Signed-off-by: shaojiedong <quic_shaojied@quicinc.com>
---
Changes in v2:
- EDITME: describe what is new in this series revision.
- EDITME: use bulletpoints and terse descriptions.
- Link to v1: https://lore.kernel.org/r/20241025-upstream_branch-v1-1-4829506c7cdb@quicinc.com
---
 arch/um/kernel/skas/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index d3fb506d5bd6084046cf5903c629432cd42b5ab3..0eb5a1d3ba70134f75d9b2af18544fca7248c6d6 100644
--- a/arch/um/kernel/skas/mmu.c
+++ b/arch/um/kernel/skas/mmu.c
@@ -46,8 +46,7 @@ int init_new_context(struct task_struct *task, struct mm_struct *mm)
 	return 0;
 
  out_free:
-	if (new_id->stack != 0)
-		free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
+	free_pages(new_id->stack, ilog2(STUB_DATA_PAGES));
  out:
 	return ret;
 }

---
base-commit: fd21fa4a912ebbf8a6a341c31d8456f61e7d4170
change-id: 20241025-upstream_branch-06a9ea92948d

Best regards,
-- 
shaojiedong <quic_shaojied@quicinc.com>


