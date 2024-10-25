Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD86FD0C5E6
	for <linux-um@archiver.kernel.org>; Fri, 25 Oct 2024 09:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=44TX79ALW/lpoOXazIpFa02hliovVgFvnIMZ51zPpdU=; b=0emQXJwRHN6dG9FUoTAMYXKmzE
	NMeKk8ElN5HODplI6lUZB1qcjRGhwiJ3MX+j46hibQQMuA6NtKTOibTn0T7w08Ptuc7SNPmt3rGA6
	JWuxjnMscJTIXqeq6bjwOpYBm0SV3AbCbD1Sl4fZ5yGENTzDNSLAVT+01WqMJ2seRBLy2xWAJ43lk
	H03nuSi3veVnXMnaO9Rpvoe8rzI/PJPwsgtRzv/EYtbobjNdGFUIJBTzLFC4aJYONwVx0+T2JbpZ+
	eSfMJ2+1I94Nmkdt1OUBYjNPMIyOhwZ+ID5ahTdRrlqJOOvm8y6BTo8EH+yoyg6BXCnmob+zyj9fA
	2fQnyNqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GGM-000000036Ry-0p0R;
	Fri, 25 Oct 2024 09:05:42 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t4GDm-000000035n6-3yyL
	for linux-um@lists.infradead.org;
	Fri, 25 Oct 2024 09:03:04 +0000
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P7SHFe020881;
	Fri, 25 Oct 2024 09:02:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=44TX79ALW/lpoOXazIpFa0
	2hliovVgFvnIMZ51zPpdU=; b=AglFB3HqdjmTUSrNhzm9SIWmoH5xGe/NvPU3Jr
	c/m9J7W+EVsiKlpjssY0mCxdEmB/plAyahMTzhXjK8SGFG1c1aScCEUROyzPdkll
	VI6K53+pUTH2jt0P88wxlBe4IQ+hUupEtD+y8ZSBZNChLrvpfWxclBzMGU9cDOw1
	OHvnIERNDcRV6zS2ILhdYb8tgcJgO4eAhl8MvTUNlT1nY/L6xawJTirS9QHMIt/M
	mlHE2Lz5NE15csNVekrmvdnsvW88yBZrN24+lB5xb+FXAEByfdHCiSkoR0IZ31Hz
	Q3U9V7iLqK2aqFIq+5BU4rpwZRCJ+3d5VpdnFzwBNd0qFsZA==
Received: from nasanppmta04.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42g6y90804-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 09:02:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49P92sBJ005636
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 25 Oct 2024 09:02:54 GMT
Received: from shaojied-gv.ap.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 25 Oct 2024 02:02:52 -0700
From: Shaojie Dong <quic_shaojied@quicinc.com>
Date: Fri, 25 Oct 2024 17:02:37 +0800
Subject: [PATCH v5] um: Remove double zero check
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241025-upstream_branch-v5-1-b8998beb2c64@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAKxeG2cC/4XNQQ6CMBCF4auYrq2ZDqWlrryHMaa0g3QhYKtEQ
 7i7xZ0xhuX/kvlmYolioMT2m4lFGkMKfZej3G6Ya213IR58boaAUgCW/DGkeyR7PdfRdq7loKw
 ha9DIyrN8NURqwvMjHk+525DufXx9HoxiWf9bo+CCywpNCcpp5+vD7RFc6NzO9Ve2aCOuCJgF0
 Ahg6sZqD79CsSIUWWgUOaWBAEH9CnJFkFmojNJe1IpsYb+FeZ7fidxJ1XYBAAA=
X-Change-ID: 20241025-upstream_branch-06a9ea92948d
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov
	<anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Shaojie Dong <quic_shaojied@quicinc.com>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729846972; l=1623;
 i=quic_shaojied@quicinc.com; s=20241025; h=from:subject:message-id;
 bh=Uf1vEBTwHbgxfJRUBR0KvPulBh7lDI+M5ckZLrbCmxQ=;
 b=mo83FOlyWbhvDbwn+tiD6uW3yrB/cNPDohWefBvoY09HMQGoU69oM11RSJvdFgcYZ4dij+9z0
 cVYz26TSBYXAAZaFFn3ftQuUe9j2Wx3FFrds8OKLOXXr7R/BkzlSXr4
X-Developer-Key: i=quic_shaojied@quicinc.com; a=ed25519;
 pk=33bgN72hchuZbXKwEWehpvql40CPvTfN8DSdi8JrU6E=
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: o2PROcHqkRpxQ_8rS2VLYdNHMm6Uqq2R
X-Proofpoint-ORIG-GUID: o2PROcHqkRpxQ_8rS2VLYdNHMm6Uqq2R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 phishscore=0
 spamscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 clxscore=1015
 lowpriorityscore=0 priorityscore=1501 mlxscore=0 malwarescore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250069
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241025_020303_028795_A09012F5 
X-CRM114-Status: GOOD (  10.88  )
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
therefore remove double zero check here.

Signed-off-by: Shaojie Dong <quic_shaojied@quicinc.com>
---
Changes in v5:
- EDITME: fit the git setup and simplify commit description
- Link to v4: https://lore.kernel.org/r/20241025-upstream_branch-v4-1-8967d1b6ea3a@quicinc.com

Changes in v4:
- Link to v3: https://lore.kernel.org/r/20241025-upstream_branch-v3-1-f6ec670e0206@quicinc.com

Changes in v3:
- EDITME: fit the git setup and simplify commit description
- Link to v2: https://lore.kernel.org/r/20241025-upstream_branch-v2-1-072009bfa7d0@quicinc.com

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
Shaojie Dong <quic_shaojied@quicinc.com>


