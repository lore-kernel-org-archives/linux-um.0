Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3012CD4F39
	for <linux-um@archiver.kernel.org>; Thu, 13 Nov 2025 02:25:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:Date:
	Content-Type:Subject:To:From:Message-ID:Reply-To:Cc:Content-Transfer-Encoding
	:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jPoO5xhn8epjlQj4FOSt+sQaXi9dauPXbPsed+H4jLs=; b=UaSFqcIh5zRqbGThYiF84engLt
	064ZmO4zfvOi9loNawXy2cb4zCsSRFLQxSAO5jXf7LqfbVQBRfY5vJ8lx9P0oMM5YPFbvzjXCmtl8
	H8x8SGyqac5eCuXahCHPcSzDmmtux5bAKC1faB3wfyJ4z/GBCWqH01r8eXvwAlmcYKdKxRznxVxHT
	UtiufeYdICgHOEtso74jQ0bTL3CFsguqXBjHkvJq3Yo0Xxcjg8ggbQaB3LcZT/5rpVOfpZUTSV76H
	CasVr3Bbw6azgwsJZbawQ7ADf2Vcl6bcY28brthMMb8IZ492eodJuA2LphEIdPd0Nh6no5lyjaqnY
	eHjiXzkw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJN1n-00000009ncS-2yff;
	Thu, 13 Nov 2025 02:25:39 +0000
Received: from mail-japanwestazon11010030.outbound.protection.outlook.com ([52.101.228.30] helo=OS0P286CU011.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vJN1j-00000009nbw-2sMU
	for linux-um@lists.infradead.org;
	Thu, 13 Nov 2025 02:25:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=sLkAP+AD0rSoEVrEAB51TjIY3PrxqcCUZ+gdgi41Q3zwtd3cMMNcqfHER1SMUsyFJV7KP+Ta+n4I2Dl+nrhqjvBOptdu3/maWBUjK2lT6RgRzfSkW2txPM4NvwMoq1zl2586rAFoBppG9R2C7sTDbG6y8KRtz5yv2Cq/6ZxTLY2TQ3JZUz+qonxfVI4aqszeo93dDeUyDfSQkjvPh90PTjiIASaIwfpKzNqQq11epVUUuw5RaFZ135/os7IXwnEmDIvhhkGtlfbLJIUbPSWYpPbghJwKDqllKkjNoCeWdx4FOx7cSeLVEVHqfKKTZq6Zee4/iAgOI/e6QwyZ7cWm2A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jPoO5xhn8epjlQj4FOSt+sQaXi9dauPXbPsed+H4jLs=;
 b=EgiTk8yo7sLeJ6YIrLsmrjBeY5WwVGMT+fyKFbd2IawI75kWo2HNIgfQwB1iyuGdsfNieqjZb8d33icem2LCoEiJc71WSaTqd/mAjXvi67/qahP/ws3U9G7T4UR1h7GkML/gNBGsfefIH85q8bPxXDfDGRF69b96Pa4gzp488fp/zJNDrcreM6MtvG1KEFf0RzCT9RMwq66hdH+z4KRaYuT1u9yiMSSAQQ/Of3l/FdcGNVES+ZT0xzS2zfkI9JkYNCC6bevo0YB0tO/kkYkFsOlZq9qdapOJ3tAM2ge34pTtaUs85zh0HG28kjjHtCE1t8KU41GNXk2vGUdvylY3lw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=renesas.com; dmarc=pass action=none header.from=renesas.com;
 dkim=pass header.d=renesas.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=renesas.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jPoO5xhn8epjlQj4FOSt+sQaXi9dauPXbPsed+H4jLs=;
 b=a7xfkbnoFELUqzzjXKix4JQl/JVJ9MQBwdh/ykaa7Uw1oaD8TE01cyBz7tIvcz2Yvtu4ES6i2wpwL2PcpTUaGCr4l7DVAimY+GP8J02srtwhlj0l2FRCyEK8Ie+aOktuhRaUG2RMedMzClzjVQORnc9reJ968/rcazR1yN7DQko=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=renesas.com;
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11) by OS3PR01MB7014.jpnprd01.prod.outlook.com
 (2603:1096:604:12b::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9320.15; Thu, 13 Nov
 2025 02:25:26 +0000
Received: from TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11]) by TYCPR01MB10914.jpnprd01.prod.outlook.com
 ([fe80::c568:1028:2fd1:6e11%3]) with mapi id 15.20.9320.013; Thu, 13 Nov 2025
 02:25:26 +0000
Message-ID: <87h5uywtwp.wl-kuninori.morimoto.gx@renesas.com>
From: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org
Subject: [PATCH] um: drivers: virtio: use string choices helper
User-Agent: Wanderlust/2.15.9 Emacs/29.3 Mule/6.0
Content-Type: text/plain; charset=US-ASCII
Date: Thu, 13 Nov 2025 02:25:26 +0000
X-ClientProxiedBy: TYCPR01CA0081.jpnprd01.prod.outlook.com
 (2603:1096:405:3::21) To TYCPR01MB10914.jpnprd01.prod.outlook.com
 (2603:1096:400:3a9::11)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: TYCPR01MB10914:EE_|OS3PR01MB7014:EE_
X-MS-Office365-Filtering-Correlation-Id: 017b7b89-05b7-495c-d976-08de225be826
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|52116014|1800799024|366016|38350700014;
X-Microsoft-Antispam-Message-Info: =?us-ascii?Q?EGo2wQZrzAp6ZYyJqV+aNYITHuIPbmBsdLrRKwQ31bYsdQIq3TYVUFWjWXir?=
 =?us-ascii?Q?d7JXyP5bFGbblyzgSeWFoVvNYPtPjfDeTKoNtP2cA2qaBAuMfJ7BTGCXtSwJ?=
 =?us-ascii?Q?yZ6hL1o/yne6PD2pITEQRyODC4akTvIrvxoYznXtyZr6+8bfcY9EIb6a1JiT?=
 =?us-ascii?Q?VfygVDS8W1MrwNERVylNjJzsowy9x7VWNNORMsHkOxXt0hYOyJ5cseGicpP3?=
 =?us-ascii?Q?jdL/QR9ebW1iyD91guVSPzBu7Nb+Xsvrgp77wdwErzTv0M9WKBcku6Z/9YEU?=
 =?us-ascii?Q?BHRTHd07lfESx1Yg7oy4o4U3XOJO0OyUEViYyQqT3VHCW5F174F0YZ98RtoS?=
 =?us-ascii?Q?xa+HLIEOSBoDzzBiCD4ZXBTa/TvPy8Ve48DvnZNZjrCytFkY4bZXtPHEcoc6?=
 =?us-ascii?Q?G9swiXcsJ+771p5njlsRsj1EAt+jH7ALgyLY58QDuJVXm8WKvWfJThuLMvKb?=
 =?us-ascii?Q?mMzrWYqF5atdTfLgHE67aApZckzhmNnJ9gpfjLILAUXm8XeyPuT9W7V2Af3K?=
 =?us-ascii?Q?eniWE+kDsrj3TGoj19B7Nh5sOdaaEcxQvQudxXMkiGMhtfx76w/7Bj6eOI+Y?=
 =?us-ascii?Q?3aZk9S2LaoKda4mC6DKrOl2xOrvHTTzLMrrpO2STPrbAF9fBXus9HkxeanyE?=
 =?us-ascii?Q?+RE43IwKZKNK8miexaINo/wkACiRnaxONy6Xv+H8nYFroF4giCeyMDi5+G7Z?=
 =?us-ascii?Q?Iaq0bB5XWUY9Z7BJVF1QGGaCY/o9ZfiY0wzg8znBkCsM5zEH3xtrwcmECmOj?=
 =?us-ascii?Q?J5WXVU56pduvhNjOfBGZXRl13gDSxtRR6G04vsEaUhFDnrrE5i0FSEfskQPv?=
 =?us-ascii?Q?X8otCTCc5wTSIlCEkba2fyRK2Gipobj0lRwgffyjFc92YQA38OytnBs2xETd?=
 =?us-ascii?Q?HbU6RniEGDWDTIuzdxIle+9aGSbdOWRQj3WA/UVfzkuMtiZdEzTjfN870l5I?=
 =?us-ascii?Q?zeKOnEE1vxOdas0EvUrAX3oJkb+wRECjima9VWcphNyvn2ztagO/6PFtMWaI?=
 =?us-ascii?Q?EPY5ePa2D39fhje/PaWoNWz471b/j7p8yIXtXRjpQNKU8dPTAlAXMSx15U5F?=
 =?us-ascii?Q?AsQOlSoSeLN5qp/8lnf8etoEko88Qzka2VqWAitYwZjlU7cei4EpBeUW1nej?=
 =?us-ascii?Q?x30HWTdeaDWciG3DCLc0NGurNjRI/LyrlddFg9Qoc+yDdeXdlrFX8eWTWmJo?=
 =?us-ascii?Q?VVTXbHACzqUX7z+gVPGctnMM50O3umnXylvGBFnOSX/YHBOLYRrCWAcKPftu?=
 =?us-ascii?Q?cT0+dOt0LdpFXdcUWUrbEu+5g3fIc/rFjHnbsfD1eas0BYena6Zkpdi5ST7d?=
 =?us-ascii?Q?SP9/+HRQigVakv8nH8201CjPbHLVzad3mOKOb7M5eMpRCyM2nGDak4r/0EXb?=
 =?us-ascii?Q?L/ngpNCZL0ySZbaYvntmjFO1eODt/2qOH5TBzcwwNWTsgkR0v7RuWFOgGCEh?=
 =?us-ascii?Q?Uc+a0joG8+QZ/7IlmLPy5rpqFpBBoZlqsSfqNd1lGsLUkY3YxZvM5M4EQ85D?=
 =?us-ascii?Q?/7eYZW/q6APUQHt9sJvHPRNKSAosiRZZFQcL?=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYCPR01MB10914.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(52116014)(1800799024)(366016)(38350700014);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zk/9rWV0tVVv6B3j9Ey2KVWvnlb2Ba+TSKAORuh2+u22lFesJ9OwFGePBHPj?=
 =?us-ascii?Q?CDSpdl0lQ8dUwgMzdPcrVhS5+HsASzyD2yMigXV8M1e+lOVszQSReLpW/HRd?=
 =?us-ascii?Q?DeCqiOfYHmUKINY4aS+6sGOSm1SVCBNAcLEWy90/wk8RhTOPV0NoK2wggMcB?=
 =?us-ascii?Q?WBNLXlLSdeLQforxsGLjSUn72M+kmvWNsjNoVN8hbEB5PQHM3CmkAm1wKzwX?=
 =?us-ascii?Q?DEoz5K01e1QvoCZKab5fNYPrH4nN6iFEJv12UMr2WIV67Fea0tXKYxcT7UCQ?=
 =?us-ascii?Q?j5zJTp7wHbdF5rmjTC16IYrDH1z1cb0RD8GJ6l8M+v4dkuBPhfMTh08o8Pcj?=
 =?us-ascii?Q?69uIkAFsaa7vZZojZzY/pQ+luKmwFkqfE4X2B7IDmORKHphg5HOKC9opUIOj?=
 =?us-ascii?Q?4gvwCzqATCvM/BFSc7+c+U5sWp/C3bfbkcxOIpepImBT25UT7IyjRe0qnPSu?=
 =?us-ascii?Q?jIHehXLX42ztUu+eEaGRqoIqsXjDBHZNPWZdNBzUrHD9e6Fdg7pxIgXY6Ouq?=
 =?us-ascii?Q?/sIoWBllYmeJLPZFOdhguKRcelUXOs0D+x84Iwz2XWRlFYIJMrIC2fxyO4b3?=
 =?us-ascii?Q?JoadgRYSJ1K6fvf16chsgkTqqw1vBtVnwBvryOJAHiMW3zs/Y9Bte57KWuo9?=
 =?us-ascii?Q?4VnQ08KrlDJvVR08HNej/zxF6wAlYYcEj5hvClmvdbaPG6B74zTQJZHUgAxp?=
 =?us-ascii?Q?/np8XrEyesWlk2LmWDIkhlS/S2gwJUuAwgHyRgnMEKUXKymG2/NNSTjdWt6A?=
 =?us-ascii?Q?QqL7j1qQvrhECLHCfscz57k4Bc8C8mqrrbfsxs5Wsm21d2QIaC3OQTsaLuVY?=
 =?us-ascii?Q?/d38G33nH3we0IlGwJe0SsJpK0D1ZfmCIbkAAAawqUkjR104SiYuCG3RpsId?=
 =?us-ascii?Q?oqooAUyEm2U64urGO172QBS6OZ4Nr34J6PD+uORU7gj2kd9UEGo+zhUoYrQH?=
 =?us-ascii?Q?gltGklVWnrI83lMq6T8HRnkYCTxEANpBjzjFKSTt6YL3GdVZBh5QQB2oDHEd?=
 =?us-ascii?Q?Uwn5oicxqD7WFXcJWfxTP1cT8EXdICiBso5VtZaYpQ/1otbfamStfhLqd2mo?=
 =?us-ascii?Q?MNiWzv0bXnszVXlYiZ7ZrBUhZv3rmWro1qHmaroJAc0NHN+fDqjR9j9JS670?=
 =?us-ascii?Q?S639Db9BPxWwEZdVrFIwv67ummmmpXa0usWmD5qRplx5SzXuMEiN+awjm4VM?=
 =?us-ascii?Q?/Qu7/8+s5SmOqEUqnn9wSLv7KAH01n7NF+7VzyGYaVwQlyuWcQr1fZId5Tw6?=
 =?us-ascii?Q?62pgQMbq3v+Kt71OmttjpfDgF2oKPlsD2e4VSQL98RS1iQ8kIH8Nw8kkKENX?=
 =?us-ascii?Q?rW6S5zzl/D9joj7TDQMV89OX8N0YJRmAOKJZ/ORVMGNSu+bKn/JlkbDZfRgo?=
 =?us-ascii?Q?ih6p9jY8qSfX7LLM1RUjUxZqo20OY0X/Ttx8X2t+wSIM10h1RjMqVX5oUMyA?=
 =?us-ascii?Q?Jw4WTW8xFFFJWBalKEmotD9fz47kN07CKZEFDdGme+gDUvqgkhA1aIC9mNmG?=
 =?us-ascii?Q?kFxH3mmnMVP2Tb5w2M4F/NLI3lzzBGHXmFtaJcg2kCRKMF09yJfwGfC16TON?=
 =?us-ascii?Q?HiWu0uCb388ft4ooOZTjEuB8b5V33K9Z/m9ZWZjb7ibwnvMTAaUYXNKRP0vS?=
 =?us-ascii?Q?/yQCwW2ZjZKsdCIduR3Kx9g=3D?=
X-OriginatorOrg: renesas.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 017b7b89-05b7-495c-d976-08de225be826
X-MS-Exchange-CrossTenant-AuthSource: TYCPR01MB10914.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2025 02:25:26.6508
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 53d82571-da19-47e4-9cb4-625a166a4a2a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JaZn0qZ/QwOonA9kZnvshspHr34rOXonTrJOrV60/30pcgWHyPAuafgLOOec9o63gSeIdhoTw+Nms9IPsWNXPY9mDBpGrUgiY+9M2yADJy7JgNxykdr6hgcVYz8Yc3zw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: OS3PR01MB7014
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251112_182535_960278_E2F53C49 
X-CRM114-Status: UNSURE (   8.57  )
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

Remove hard-coded strings by using the string helper functions

Signed-off-by: Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
---
 arch/um/drivers/virtio_uml.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
index de7867ae220d0..6cf1152a1a4e6 100644
--- a/arch/um/drivers/virtio_uml.c
+++ b/arch/um/drivers/virtio_uml.c
@@ -24,6 +24,7 @@
 #include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/slab.h>
+#include <linux/string_choices.h>
 #include <linux/virtio.h>
 #include <linux/virtio_config.h>
 #include <linux/virtio_ring.h>
@@ -1151,8 +1152,7 @@ void virtio_uml_set_no_vq_suspend(struct virtio_device *vdev,
 		return;
 
 	vu_dev->no_vq_suspend = no_vq_suspend;
-	dev_info(&vdev->dev, "%sabled VQ suspend\n",
-		 no_vq_suspend ? "dis" : "en");
+	dev_info(&vdev->dev, "%s VQ suspend\n", str_disabled_enabled(no_vq_suspend));
 }
 
 static void vu_of_conn_broken(struct work_struct *wk)
-- 
2.43.0


