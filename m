Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63366D7497D
	for <linux-um@archiver.kernel.org>; Wed, 30 Oct 2024 07:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=kADonSwPqbWY02deI/90hvBXFxAQZc7rfAEBMFI6QII=; b=aRCrKbyYL00jSj2BUCdRvj+cjs
	jvz7dsMibF/pzVRTp3fNnI4n/uaKsTe+1XrcGlZO3UM1JKOH1t8fKsKDl5Q0/rdVdeR+x1Iel67w0
	Z7FCDUb3pf7818WGQhgGjPwAPLbESuGBuQUAb0IuGwDdTbEh1C4lRRSkQ41NzAz3AgS2aXL/quQOU
	C764YArtQ1GZ1uIpKE8KrL96+yuiazdAnSSMbgGz3NovisPqE2HZfh2ZvBImstIGw4ymsMy16GJQx
	pcL977802z7734K2kaTHOX2VoQ81wbQIacv/kL1E4n4ZuzYLaJMz1AxSXBXhiIlRAUF5JzcZsekRU
	DIyT1/Ag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t63E7-0000000H9pJ-2yXB;
	Wed, 30 Oct 2024 07:34:47 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t636P-0000000H8fI-0IMV
	for linux-um@lists.infradead.org;
	Wed, 30 Oct 2024 07:26:51 +0000
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49TMRMF9018745;
	Wed, 30 Oct 2024 07:26:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=kADonSwPqbWY02deI/90hv
	BXFxAQZc7rfAEBMFI6QII=; b=Azox7cRyQr68nLEdCJLzhlH0YZUkJmy71YXMLv
	xPUgrZArZwSOwYXRFB2RMC8gzE4NMtfGBXTdti4vRSYRouJkBB3hOqDRGoUdwgYZ
	2UhvZVwiVpFbaEEyupTdORDoIIPyquSihE248xOyZM38uoPq3bZGXZuhz7hEU7Th
	WF+xsGO0wWjZgNNVVcpg+RE2RXGQzPUxcKK5EnNwJrEVUdCtLhtPwqwpmeJcIlhm
	hZmES0goQp1CmnEVJaT1kqJXt3Rnuc/WT1gLk9S+YZPLZO0sMakUd8agYAi4/zuJ
	0UbQ+J+o8gzfBLY0IOxBsr6dYbB3gwaYkAi+XSbvZv6Vqaeg==
Received: from nasanppmta05.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42gqe62ykx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:26:32 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49U7QURl011984
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 30 Oct 2024 07:26:30 GMT
Received: from shaojied-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 30 Oct 2024 00:26:28 -0700
From: Shaojie Dong <quic_shaojied@quicinc.com>
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov
	<anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: Benjamin Berg <benjamin.berg@intel.com>,
        Tiwei Bie
	<tiwei.btw@antgroup.com>,
        Shaojie Dong <quic_shaojied@quicinc.com>,
        <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] um: Remove double zero check
Date: Wed, 30 Oct 2024 15:26:09 +0800
Message-ID: <20241030072609.1645401-1-quic_shaojied@quicinc.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: tWNFPUx_CQn6pqFohoziJNXjLh3pzA9F
X-Proofpoint-ORIG-GUID: tWNFPUx_CQn6pqFohoziJNXjLh3pzA9F
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 spamscore=0
 phishscore=0 bulkscore=0 mlxlogscore=857 malwarescore=0 adultscore=0
 priorityscore=1501 impostorscore=0 mlxscore=0 clxscore=1011
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410300057
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241030_002649_249060_BC4648D3 
X-CRM114-Status: GOOD (  10.26  )
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
 arch/um/kernel/skas/mmu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/arch/um/kernel/skas/mmu.c b/arch/um/kernel/skas/mmu.c
index d3fb506d5bd6..0eb5a1d3ba70 100644
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
-- 
2.34.1


