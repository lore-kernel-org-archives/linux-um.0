Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 158DCC531D0
	for <linux-um@archiver.kernel.org>; Mon, 27 Jul 2026 19:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:To:From:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=6VHFNnQTuj7EqYdhb88Rb9Nn2anxs8ZyC14JwvphDew=; b=yySOEeCQIpCQgk
	uTYibA9KsLQyA1xmPQa8ipb1O9rqrCrEQ79rsGzaz0pEzLQzJL/KYP0fFqUUlgu8Lz85O95d8M/zl
	iBA7ZqcdrpgjM82dCOk2fT4Yn4w0YIhWJ8Hhbh10ES/3k8h/9LnwGOwVdKuePLFvZMFWNqLCddmCx
	dUWTAB08gkWmoEmXtTDId9iYoNDir50sPWlRxo7ET1tE4eC0iOlrDJTNAEFhCf1k5YE93A0UPBiXy
	jXnPOlxpCrWBZdsS3ubZ/vNXbve8yU0v+luI3GPJWVWsMnPM9bla7Mv3rCexxniABQaWycTrYL/l4
	VTXvF1AOrDraIUigF7Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRQf-00000003nTN-11hd;
	Mon, 27 Jul 2026 19:56:01 +0000
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woRQa-00000003nT0-39wM
	for linux-um@lists.infradead.org;
	Mon, 27 Jul 2026 19:55:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Npr/zEVCBAu8yV7FgfDmhhPdkDIhqpKUhF79hn4XaM8bMNNWxLoCpbrOSSH+PGykKZ5mQ/52rcEHPRJepdc7zi0kmV967YlH2FTkXR2zi/y/vxBa625zmGbS1RyxjfS3hlGH8EVdbpUb5v1MWmxKCJb9zNO0/0lD0xylCU01Vt5bCH4OvyHtrjEanG6zZ2Hzycp301wosU2pmWw+VoqB5YrzXcy2UUxfBBG7z7ciyN0MaxRFXVsvNSR2cvuKcymedqjGjUvn2dI8LXG6QIi8P6K3d7NWo4js+YQlDhZIIhn9Udq962jxRN8dgggob0B+fU1F75GaVsyJjhSVAUkdhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6VHFNnQTuj7EqYdhb88Rb9Nn2anxs8ZyC14JwvphDew=;
 b=gUilngbwREwQxca2IXz1C2lwaVMpbEl7oYxPhZW18fWycFvT5xTyBMuDHmQBFSyBa/WGGuTk4y4A/F7GD/4mkGqTQ35c93K/qspWEWAv5eXfXUkgQF8rwdsZZ7a9pEHVdk+jn456BHOQST6MATTiKtcTv4DixDkVbPsQtDJW7ZuBpGOLpO2941/O8UwXPdWY7hmGKGpimuY9VSLP39QAPc32/buK8m3KcVk/R3Iic+ASzr7kEXjgNyJ5olSMAoY4skcxtoWUIM1+V7xFV2mgXIsM3ZwaHhNL26rY+YDBnU0mBdbZT3tt7NPxZ5OXEO+71DGIfjBFXerKt7O6Icztdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nod.at smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6VHFNnQTuj7EqYdhb88Rb9Nn2anxs8ZyC14JwvphDew=;
 b=dStbrW2viBuw5PgvXvc+oxfGdIFhLyXomcahY7uYYEMRcws2FQxQspc0xEva6tLuWy+LsgQFnMePQQu0VhmdhEKh3Y78lKVQ+CqOb3FoNB7j9JlyB6MvHaQeq8LAYqdj+pe9l21Q/yT0eyRVwqpTec76KUNx7aU7GS7m99fB89U=
Received: from SJ0PR13CA0001.namprd13.prod.outlook.com (2603:10b6:a03:2c0::6)
 by DM6PR12MB4074.namprd12.prod.outlook.com (2603:10b6:5:218::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.13; Mon, 27 Jul
 2026 19:55:47 +0000
Received: from SJ1PEPF00001CE8.namprd03.prod.outlook.com
 (2603:10b6:a03:2c0:cafe::ab) by SJ0PR13CA0001.outlook.office365.com
 (2603:10b6:a03:2c0::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.270.12 via Frontend Transport; Mon,
 27 Jul 2026 19:55:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ1PEPF00001CE8.mail.protection.outlook.com (10.167.242.24) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Mon, 27 Jul 2026 19:55:46 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 27 Jul
 2026 14:55:44 -0500
From: Alex Hung <alex.hung@amd.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <alex.hung@amd.com>,
	<linux-um@lists.infradead.org>
Subject: [PATCH] um: fix CONFIG_GCOV for built-in code
Date: Mon, 27 Jul 2026 13:55:15 -0600
Message-ID: <20260727195515.2306731-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ1PEPF00001CE8:EE_|DM6PR12MB4074:EE_
X-MS-Office365-Filtering-Correlation-Id: d52b6210-96c6-4924-a78a-08deec190cb2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|36860700016|82310400026|1800799024|376014|23010399003|13003099007|18002099003|10067099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: h/Qb68VNZrpjj7hZECTxG65nHQ7CFwKWLCpxTM8h4AGW86FLUvTOZX993Vwuoa3A67OHZW0jO/BMIFfWlgjuID8eIdEEWCQWhpezVMcXirI+RErnyWON6U/HRC3yJb0bwRG5ByOl1W/NmA0yZNv8wtEEUYWEEKvAf4arTBcUF9YGlQadtriQZH73H5WKCsjcjBDY0cz5VzgU9x8E0jOz7nQRTIrZuONvqOvG1TNnKh59a197STiCZDRQDTFGtnZS/+erIrF6nSl8knzR6PFDhP/HFDYHaAYasRtJ342Jhpm/JpKiwHdcgqVdHoOjAQ3uCRHNZN6pOquCEgvqkd5UpIGgBeT+BRKkk3pxayPCXEqxXDsu+Iqjj34GkiFsGuFXhIvl7IRtwB5bNcQWiUSTlwHgdjtpcPCccQh8SllwHKnygH7d5hH5jPoyIWjkNcLgqB81qLATlzc2hcs8jz5bN5NZuMUZ7kgLihw4ATXpyAI9I2x0JofiRjr1XLXZgtN1lRsRzsFSSb5TBBWAB/oYR2vKaW3SN4w+KuhGF6cJ7rGxyeVaJku9zVc6FGmkYgB6m0tLAllshoJL4Wa++jm4xomWHKx/qh6Fj4d1/+wQ5PgbI5T4g7dS78DDNoYoeoW2MG76Vmu88zh3XQcIeP5k7qwQupDuF/GL3afYK8++s9IZLsp1EAKKTJThdGmN4KvM7sWh7vU5wRX9ynWbn/xsjw==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(1800799024)(376014)(23010399003)(13003099007)(18002099003)(10067099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: fbOUWsCmXGeUJCjEsrQUqPhWzhk3OVLtWmOacR3NPcAnXL3woS2cv3jbEOPdTzprjyRWu9qLO3QG2rUY7qYHYqBcHWdZyVjYiPBKqNWq1TPjLFNOxtfvulvsEZVhUkbGc+44dNRNUtl8iyMN0F/27CihBFvkG4bEFktyYXN0Jn6FPJARf2pU+O5ZogQ+OHqNd+PuhTfjWwD+buX1r1guG68/lVtNoBmoU1Ha3w226WzUOFJfpHYLq41kdMExLUKvKXscYOf1g80neRuOG1BpWmAaispZrDjwt2avWE72Ys6MkiuqdOdnW6hyqP7Kw16oBzudXbjD2apizfula0kd4FZ+bSdbxjo2VddAdMmf7VgF6StfzlIrtxguLNGYCCr6m8doccYreDGd/7pMuXg4gUEiFNZWWe+fkGMD1AUEXd3+IIcZukpJb8E8WYUdmBTi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Jul 2026 19:55:46.3300
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d52b6210-96c6-4924-a78a-08deec190cb2
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ1PEPF00001CE8.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB4074
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_125556_795257_B8BB75A5 
X-CRM114-Status: GOOD (  10.90  )
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

From: Johannes Berg <johannes@sipsolutions.net>

With contemporary toolchains, CONFIG_GCOV doesn't work because
gcov now relies on both init and exit handlers, but those are
discarded from the binary. Fix the linker scripts to keep them
instead, so that CONFIG_GCOV can work again.

Note that this does not make it work in modules yet, since we
don't call their exit handlers.

Note: the .init_array.* wildcard and the RUNTIME_DISCARD_EXIT
define are already present in this tree; only the matching
.fini_array.* wildcard remained to be added.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Signed-off-by: Alex Hung <alex.hung@amd.com>
---

This is a revived patch. The original can be found at
https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06608.html

 arch/um/include/asm/common.lds.S | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index fd481ac371de..2ed213913afe 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -91,6 +91,7 @@
   .fini_array : {
 	__fini_array_start = .;
 	*(.fini_array)
+	*(.fini_array.*)
 	__fini_array_end = .;
   }

--
2.43.0


