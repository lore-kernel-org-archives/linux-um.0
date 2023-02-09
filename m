Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 057B6C636D4
	for <linux-um@archiver.kernel.org>; Thu,  9 Feb 2023 18:16:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Date:Subject:CC
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=+D7TrnkyCTeKnxGGimxeuLZP5co4pOKzQnT5yznuYKM=; b=1JsUKQUtARO42k
	/ze2MA8Wk50v+r7TDz3YD3a5A4rYcHhEb1bujcy09ibI/QDZW8piEzz/A0Tp0wi4K1+VMESE1YKOA
	1F/w37slNqi9KdaOOX+wpp09Yo7qQ7TaA0ybJy8LWF9cya6HfUmN35qDNDvO/51sGtHralbs7h7ui
	5ItotK5OgSlYfD1nTdTIdHfitcaT1goVkzFWIzsqoqcF6QA2pSXwgRWMsvq4UY2sLgyKN/c/hZy8C
	FvoUMcmcJ363PZvZsBu4fxP87zPrEvnLO/MMAYG1D5eE+DVFGxNhdnWaXq2Iz7qECIz6WoO8Y9CfF
	9FXtmGFw9xle0t4tH2Lg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQBTW-002mjC-96; Thu, 09 Feb 2023 18:16:50 +0000
Received: from mail-mw2nam12on2061a.outbound.protection.outlook.com ([2a01:111:f400:fe5a::61a] helo=NAM12-MW2-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pQBTQ-002mfa-TT
	for linux-um@lists.infradead.org; Thu, 09 Feb 2023 18:16:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Imcd6GhvQYpEU+/dC/FnWA/vP277lYzIwLuyzMpP/EfoYxcE6xTY82oZIy8/WoVDTweelKg7CpklNqnNuu85p/G/eX/0Cv51mKLjEZy/37GqZ70S7WepyeZARQXv2RAsmML6ocUYBGYB3PC5YpnqujZvK64uQkFQhfZk+00CuQUyo0+KPdyTX1mVlf5I3out7UOuZ3Id12LnHHrxrhL6n/FFTyz9HzTJzpNyfhu5+hqrjWsGPcljOCy3LIFMypml33Zlq//Sm4kObJ8eTrQtwfrB1F9C6rUO8KQWv7bXd+7MN6GLeYB8k3TXAwWVuw32+2ty1/LRdSomRa8mFq7Vig==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u/2lo5vVECPIh2AIUbDWY/g83c8uxNaea9yHO85xlOQ=;
 b=H6IDibootjq6Liw+x5NAef9xjXrpFcPTU6Y7PVRKuOwtrK4qsVXr6WNf7KkBfglPDhHhrw1OYmTVAqWsMbI5f0etmpbOIcUTeAnSPyHfM2tDTToDOOcTo82aJxjjSXosorp2PvuKnqfHdPRqhyQ5FK4/LqXQltuqEAOFhZwwPNJlgELuBzcqpa5im688azqTiItiGYroTc0SHrxbDiSB9QG+Oj1y1lPPt4MlE+pAyc+laogIE3+Y6yOFcGS8OEVu9xERIYUoUpk83TysUkIWoDulInmc7xWwsC+AvD6T/0c/J+TfBuEdBhlpdnARRIF5siHLwdeMZ8vvFK9gAtm1rQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nod.at smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u/2lo5vVECPIh2AIUbDWY/g83c8uxNaea9yHO85xlOQ=;
 b=Bi58kTJPOwW5/cbURYvPugd3yHTkxMsK7G98k0xigWYh5LsIrAoowe4nwC7puWdFAcffwyZQSH0WDBC/wNJQy0zpGdDuPzw8fZZd5s02I9LpEKtXZmlu/AVWvEJ+9BPRW+QV6L2biryPIbTNrmkWKxXjkGi7H3gblveubICsay0=
Received: from DM6PR03CA0025.namprd03.prod.outlook.com (2603:10b6:5:40::38) by
 PH7PR12MB5949.namprd12.prod.outlook.com (2603:10b6:510:1d8::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.17; Thu, 9 Feb
 2023 18:16:41 +0000
Received: from DS1PEPF0000E634.namprd02.prod.outlook.com
 (2603:10b6:5:40:cafe::31) by DM6PR03CA0025.outlook.office365.com
 (2603:10b6:5:40::38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.19 via Frontend
 Transport; Thu, 9 Feb 2023 18:16:40 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=SATLEXMB04.amd.com; pr=C
Received: from SATLEXMB04.amd.com (165.204.84.17) by
 DS1PEPF0000E634.mail.protection.outlook.com (10.167.17.138) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.20.6086.16 via Frontend Transport; Thu, 9 Feb 2023 18:16:40 +0000
Received: from SATLEXMB06.amd.com (10.181.40.147) by SATLEXMB04.amd.com
 (10.181.40.145) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 12:16:39 -0600
Received: from SATLEXMB03.amd.com (10.181.40.144) by SATLEXMB06.amd.com
 (10.181.40.147) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Thu, 9 Feb
 2023 12:16:39 -0600
Received: from iron-maiden.amd.com (10.180.168.240) by SATLEXMB03.amd.com
 (10.181.40.144) with Microsoft SMTP Server id 15.1.2375.34 via Frontend
 Transport; Thu, 9 Feb 2023 12:16:39 -0600
From: Carlos Bilbao <carlos.bilbao@amd.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>
CC: <linux-um@lists.infradead.org>, <linux-kernel@vger.kernel.org>, "Carlos
 Bilbao" <carlos.bilbao@amd.com>
Subject: [PATCH] uml: vector: Remove unused definitions VECTOR_{WRITE,HEADERS}
Date: Thu, 9 Feb 2023 12:16:38 -0600
Message-ID: <20230209181638.3781977-1-carlos.bilbao@amd.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF0000E634:EE_|PH7PR12MB5949:EE_
X-MS-Office365-Filtering-Correlation-Id: 83c68bc0-fd20-41c7-9d81-08db0ac9ca50
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	XCKY05P92/AsudHf+4YuTu+E0KhToNi6tzbF6PF2xPUDOQPS0KbmBCPJa1sJt9Nht/8QYanyji1dju/4FJhdKaDI066QrpjUgFZ5Akg7Rw4sMdIrbiHCFNIIMFWDJIgIDCvRVTPgyyd7XP/9oDXyCCIWdhb0ez49sWKCzcclc5QlC1WGwLiNLzE6ug4BqgwrjO1EYmjFmDbaSfv9NxV1teturV53lEM7bmDBaMpJozuXAKV9Nqg7J08Dif4TTE79SJf6vjDuE2HtoTrLlEioCKaj0YadekdpqZA47AIWryLuIhiQbY8j+vbuSatWvBRjvpXRULdbz/SFD5vHKzjLqtsq6u6Bo6BVQrFdaXOfjUC2ZHxuuvigY7o4CB9XZzauBsObFsUR16uLvSJN4CzBSFTvyU/I1+YO98TNb4LzlSA8gER85QvZzK3MNozsGyf9d5/k+nyjHxStkrSuUJfbVuBaSB5h5vawO0rYVej6OIMiXSXgbBQ/0YhYzkv2rARoble13uDJ7VwptX0LP+15tyu4Z4Fohhj6o+Bdg+S70Oy8cDqY2CFIdmyMMNpalAPgzRzoKkXH51yls9p9PEIbOwDhmcmA3hRmEkYrfErU+aYEAVx4jG4I/gKJ05yJhlOEzt+3ablk4QRX3nLKwPWgUJAf7RV8oSnbMfKmmVl02lYl8fRzTVDxDGDA92CP8D9NezwX9DG+26/pEfgDL5bqXAHGvelTNt4gmnS2k1PoBnk=
X-Forefront-Antispam-Report: 	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:SATLEXMB04.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230025)(4636009)(136003)(39860400002)(376002)(396003)(346002)(451199018)(40470700004)(36840700001)(46966006)(26005)(186003)(2906002)(316002)(4744005)(8936002)(110136005)(1076003)(36860700001)(5660300002)(356005)(54906003)(83380400001)(2616005)(86362001)(82740400003)(47076005)(336012)(36756003)(40460700003)(478600001)(426003)(70206006)(70586007)(82310400005)(44832011)(4326008)(41300700001)(81166007)(40480700001)(7696005)(8676002)(36900700001);DIR:OUT;SFP:1101;
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2023 18:16:40.1261
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83c68bc0-fd20-41c7-9d81-08db0ac9ca50
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[SATLEXMB04.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: 	DS1PEPF0000E634.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB5949
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230209_101645_055254_F4261D15 
X-CRM114-Status: UNSURE (   7.73  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

Remove definitions of VECTOR_WRITE and VECTOR_HEADERS since no longer used.

Signed-off-by: Carlos Bilbao <carlos.bilbao@amd.com>
---
 arch/um/drivers/vector_user.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/um/drivers/vector_user.h b/arch/um/drivers/vector_user.h
index 3a73d17a0161..59ed5f9e6e41 100644
--- a/arch/um/drivers/vector_user.h
+++ b/arch/um/drivers/vector_user.h
@@ -68,8 +68,6 @@ struct vector_fds {
 };
 
 #define VECTOR_READ	1
-#define VECTOR_WRITE	(1 < 1)
-#define VECTOR_HEADERS	(1 < 2)
 
 extern struct arglist *uml_parse_vector_ifspec(char *arg);
 
-- 
2.34.1


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
