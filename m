Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44520C30658
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 19:50:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=X9k8irR/hjfHe9E2iDRNhO+8kHtzMs2pvoUZ0QJlGYM=; b=hIaXXBHHBihdVOib3cIRKgFbJg
	FCG5lTcekoi/SqhLrsI3kH4l+UO9epfffUJCUcLZ4+GetMooIGn3LltNnAH56Q5mJ1W9ojvnSlWrz
	yMYdXXLI8lCKi0+Z66VlruF//JNm2inxbign8TvkExIjDUuhdOH5N5GVaLdqy7Km4DGVW60600CAq
	I181vACTsL+MD54yVXa/77QjGSbi1c034yvCByiUVdM8TXogZQV/zwxGY9NaG5BrGK9e80czkOm+q
	l79LAIavSZaHEYAf15QnWHG6H0Zsw4k9f68KitOEBUKH//3As7bZHucqYvrhunUmj9A6+LpherKHB
	c/Zu6QUQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOjW4-00000007pLt-3TAD;
	Tue, 02 Jul 2024 19:50:16 +0000
Received: from mx0b-0031df01.pphosted.com ([205.220.180.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOjW2-00000007pLN-1X1a
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 19:50:15 +0000
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462HEvFV009458;
	Tue, 2 Jul 2024 19:50:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=X9k8irR/hjfHe9E2iDRNhO
	+8kHtzMs2pvoUZ0QJlGYM=; b=c/37CnBkWdAONoYR4nDXGJ6VzXuSJ1l1LMxBZN
	At2LWdvjCxXAbytGrgE7aB9BnmM4Trcw7CSlRb/l0i8E+1ANKFTunYjkkRw/H+tE
	gBeGlGqk4xW0IvuQYjD8U9bwkAYlPvd3xNjktR5fcxwzrwpkvH6NudSQE5xtDKPh
	5QhA5qj3xdZmUtf/+oNMs5StBonHecf7DVQQ/wAirbzAyQJN8/czwkLghmNvCMd/
	AqzSj7buzDWBMjYzGmzgHkQQgm+1ce5iylLh10y90XT1qbInFqdxNmPCzYOEdlMi
	gbyhnUE8TMXtM4EKef31/L9P4UYr21IRY2D5k4QLoQnsNebg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4029kh6ur7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 19:50:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462Jo77E008191
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 19:50:07 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 12:50:07 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 2 Jul 2024 12:50:02 -0700
Subject: [PATCH] um: harddog: add missing MODULE_DESCRIPTION() macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-md-um-arch-um-drivers-v1-1-79e4f50b5bab@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAOpZhGYC/x3MQQrCMBCF4auUWTsQQyTiVcTFNBnNgIkyY0uh9
 O5NXT2+xftXMFZhg9uwgvIsJp/WcT4NkAq1F6PkbvDOBxedx5pxqkiayrFZZWY1pGug4LOLcbx
 A/36Vn7L8u/dH90jGOCq1VI7aW9q0YCX7scK27fAiSeqGAAAA
To: Richard Weinberger <richard@nod.at>,
        Anton Ivanov
	<anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.14.0
X-Originating-IP: [10.49.16.6]
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j6JyB1mUKIKkcTJGQPu2pa9ccsk8Y1Du
X-Proofpoint-ORIG-GUID: j6JyB1mUKIKkcTJGQPu2pa9ccsk8Y1Du
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_14,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 priorityscore=1501 suspectscore=0 adultscore=0 mlxscore=0 clxscore=1011
 malwarescore=0 bulkscore=0 spamscore=0 impostorscore=0 lowpriorityscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407020145
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_125014_555915_D8F6B12F 
X-CRM114-Status: UNSURE (   8.97  )
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

With ARCH=um, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in arch/um/drivers/harddog.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
Description taken from the file prologue:
/* UML hardware watchdog, shamelessly stolen from:
---
 arch/um/drivers/harddog_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/drivers/harddog_kern.c b/arch/um/drivers/harddog_kern.c
index 60d1c6cab8a9..99a7144b229f 100644
--- a/arch/um/drivers/harddog_kern.c
+++ b/arch/um/drivers/harddog_kern.c
@@ -49,6 +49,7 @@
 #include "mconsole.h"
 #include "harddog.h"
 
+MODULE_DESCRIPTION("UML hardware watchdog");
 MODULE_LICENSE("GPL");
 
 static DEFINE_MUTEX(harddog_mutex);

---
base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
change-id: 20240702-md-um-arch-um-drivers-a84a42d077b5


