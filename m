Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B306C3065C
	for <linux-um@archiver.kernel.org>; Tue,  2 Jul 2024 20:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:CC:To:Message-ID:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pDoDdNk1hd0Hd67iYs0FEzBCbvrGkjAB6hRRSe/fjws=; b=C2MTeI3Kc3t7hlynl/k8WHo20z
	ENyPhiqUCrvK4930tSzwAnqXMA55VAjlUFQwZy9XrJNbwF1K4wtw+3I/3lrxiWqOg+cIhoexjmxAA
	UYbbJCVzbLRwNGWdhzBhKnZnxJauVTMgPEzh020bMH1JPNYP86scujrKHlMCMzVu4ZAMHaCCPqHlh
	CKEsi/Nt8jGKwXX+l64bUHNjuQ5Qhd/fGwO4dzgFx7v8W05F6Dnw1cGTakDOLfcwhcdciJcFEZRKI
	nohvzMiyOw2N+Xt3ymrIpLUQnPLI6xxmxJNWrnr6NNnAx0d2kvCKuyDqvOPn6p7TCAzEHfg1epHOR
	9Y0V9h9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOk6N-00000007tEW-3foD;
	Tue, 02 Jul 2024 20:27:47 +0000
Received: from mx0a-0031df01.pphosted.com ([205.220.168.131])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sOk6L-00000007tE3-19fy
	for linux-um@lists.infradead.org;
	Tue, 02 Jul 2024 20:27:46 +0000
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 462IJVb3009131;
	Tue, 2 Jul 2024 20:27:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=pDoDdNk1hd0Hd67iYs0FEz
	BCbvrGkjAB6hRRSe/fjws=; b=Jdk7sGe5sYLYXB7s7bCzy9JskRu32+KZcYO3T9
	Z6waoW8x0knOeY/SefPytZddytOzH3vqLeqJrEpWoeqCY5iPUCaowIyp+fz+VOeR
	YeojYF5fGW80ufbEZKQ/AyIYocvMdEw3T6kqjVgdFImfGquPhKazIcYWWF0KxAv7
	nYJQGLtfFctFLvxBj/NkJdDuxCfiOQyD/Rdlm4CkBX5GGn5j6H9c7LFfB/11z0/j
	0rIfci0N0eJ4KkLrWmTcRqLjFeCetI0UJrNaE3QctIvfbjxNEKyxRj43+zloRY5k
	/e6GsDj1WsKsvNMTFAQseBcdh/6jp9YoYBQzC4tfU4xKX3LQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 402bj89frs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 02 Jul 2024 20:27:36 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 462KRZDS019008
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 2 Jul 2024 20:27:35 GMT
Received: from [169.254.0.1] (10.49.16.6) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 2 Jul 2024
 13:27:34 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Tue, 2 Jul 2024 13:27:34 -0700
Subject: [PATCH] hostfs: add missing MODULE_DESCRIPTION() macro
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240702-md-um-fs-hostfs-v1-1-fd2b565027e7@quicinc.com>
X-B4-Tracking: v=1; b=H4sIALVihGYC/x3MQQrCMBCF4auUWTsQQ7XoVcTFJJ2YAZPKTFsKp
 Xc3unp8i/fvYKzCBvduB+VVTKbacD51EDPVF6OMzeCd793gPJYRl4LJME82t0l05RDTcPH9Ddr
 ro5xk+xcfz+ZAxhiUasy/zlvqsmEhm1nhOL6JOBJQgAAAAA==
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
X-Proofpoint-ORIG-GUID: 6UaXOYRe2t3aiAHmrPsbINGoxEGKxR0D
X-Proofpoint-GUID: 6UaXOYRe2t3aiAHmrPsbINGoxEGKxR0D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-02_15,2024-07-02_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 spamscore=0 suspectscore=0 mlxlogscore=990 mlxscore=0 priorityscore=1501
 malwarescore=0 adultscore=0 bulkscore=0 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407020150
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240702_132745_427764_EA43DC48 
X-CRM114-Status: UNSURE (   8.91  )
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
WARNING: modpost: missing MODULE_DESCRIPTION() in fs/hostfs/hostfs.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 fs/hostfs/hostfs_kern.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/hostfs/hostfs_kern.c b/fs/hostfs/hostfs_kern.c
index a73d27c4dd58..ff5f14ffa838 100644
--- a/fs/hostfs/hostfs_kern.c
+++ b/fs/hostfs/hostfs_kern.c
@@ -1010,4 +1010,5 @@ static void __exit exit_hostfs(void)
 
 module_init(init_hostfs)
 module_exit(exit_hostfs)
+MODULE_DESCRIPTION("User-Mode Linux Host filesystem");
 MODULE_LICENSE("GPL");

---
base-commit: 1dfe225e9af5bd3399a1dbc6a4df6a6041ff9c23
change-id: 20240702-md-um-fs-hostfs-fa6ebcf75249


