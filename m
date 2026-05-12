Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 172A5CD4F21
	for <linux-um@archiver.kernel.org>; Tue, 12 May 2026 23:29:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0FsowloDEgwyjTKW4wA+TmEXalrWBK9D2CV5Nb2YW1o=; b=mT+yzYUb6loTeBWRn7vHZ5uCCk
	AFg1udT+n0abdC7EaR02PFZ0EtW07ZsLf9MZ3ZNtb5K/Vv2KBnkZAe0gvsDVRccLD6G0s0hlreuKA
	zjavYs6TdDziKaKRqlNJPjlmNyzZWZcfgCv31ELEx7h3cMIEglx7xu4I/DlP3fbGcmvBEfSo1Wo8N
	yNW0Mla0OwWfKaQRMUuuQDbyC9EmJRkKkp/S3MJwHmbux1Kt8eZr8qxlD2PEM70C2fPVQPMlitPQO
	OlwNYmt/v3jIziKcumN58ARj3j0Ko/KyszMwCVWGgRUrf1iCg1QF1MHS4jPISTfz3Nef1wS3X5zlY
	Md+GxGwA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMwXL-00000000h8W-0kBM;
	Tue, 12 May 2026 23:29:15 +0000
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMwXH-00000000h8D-2CrJ
	for linux-um@lists.infradead.org;
	Tue, 12 May 2026 23:29:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=dSDPrtES5fg+q7gT0NeKnbgbpTZQf6D4KcRFbFVySaxLCkyhpdpI91XmBvr85eVB5bGY/hwHPXTaSKKWYS20ZrYUB2G8fScMa8yLcwuOF1X4DZUUyc0JsmBnTicAeKOtpd6VghutG9kfcsbt/2+sagtFPz9TGbycM2wAtrzyHpCHYdqqD+UJyM+b7WsXAgbllIYms2nV7G7P6zKLTnlyf4Pa7Dh4GeS2/Q/fHZlP9+7AF9Yq2yKnwyn+Yib4mcc17v8WDkf+rHcAcGjfGjiZFix1Oj6jYTzAOw5SzHjgf+vbqQCY8Kdm9dDAvpGKTF9BKFNhl+P6znnXg91N2JXpqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0FsowloDEgwyjTKW4wA+TmEXalrWBK9D2CV5Nb2YW1o=;
 b=h+NyFSHTcls6g6y8Nt4szdPPJve7iZNmRSxIrditqi9V5I65dAyuMotgqd49bVR4H5tY0j/njqd1PoArYrwaDQBouwY3eU5Dcduew9T8TRvmSzhRN8hqxYK79NJ8luOuLq6aZ4qowXkctI40XyVVJ8rO9dvnZl1tcI4drrlNZ7sIFRNf9HtsCklFh2mabuGNCg9HdEKbOO9O2d2up4e4GhWbb/m74xZs4zFL/a2bEuuERYvzcigEerJf3SLlRZl61RJpQk5jAvYEO/q0xI2loOGHocxV0wTxS5zZmG/ZO/2Rpqp5u1xZVqFjVI6hIZRAuUduModhJ6zj5Pg142w8/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nod.at smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0FsowloDEgwyjTKW4wA+TmEXalrWBK9D2CV5Nb2YW1o=;
 b=5Qx7s/EDzG0uUKj70qGrN/IAi8bXrTXDZk5T7s79PeC1/Fk3NE1jXPcBb7BsRPopzgzNLvbUfPRqPNzNhLzYDZew8NWP+sbszMtLKivIVJCb5S/24S2xgaQ0CPRlPNR1XcQnovC7rpZsyPzKpUM2dvt5R+SeVWLoJDLlJVIYy8k=
Received: from BL1P223CA0039.NAMP223.PROD.OUTLOOK.COM (2603:10b6:208:5b6::10)
 by MN2PR12MB4301.namprd12.prod.outlook.com (2603:10b6:208:1d4::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 23:29:05 +0000
Received: from BL6PEPF0001AB52.namprd02.prod.outlook.com
 (2603:10b6:208:5b6:cafe::45) by BL1P223CA0039.outlook.office365.com
 (2603:10b6:208:5b6::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.20.9913.12 via Frontend Transport; Tue,
 12 May 2026 23:29:05 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB52.mail.protection.outlook.com (10.167.241.4) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 23:29:05 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 18:29:04 -0500
From: Alex Hung <alex.hung@amd.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <nathan@kernel.org>,
	<linux-um@lists.infradead.org>
CC: <alex.hung@amd.com>
Subject: [PATCH 0/1][RFC] Fix no gcda files with kunit.py
Date: Tue, 12 May 2026 17:26:39 -0600
Message-ID: <20260512232640.1937941-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB52:EE_|MN2PR12MB4301:EE_
X-MS-Office365-Filtering-Correlation-Id: fbb2ad05-5639-4842-7345-08deb07e41fb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|82310400026|36860700016|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: xB73p77CZouhLxADGIPzBVnmh9BcZrPsysWxyjzK7nklrpLPPosOXkYW1X2WOmExoa1OrnvCgJw48wyv7eAS2PVXTDrZSyaf86iRk0MNPAKM0c2wdcY0aEPFw0kyDFmfieXNeYBt5Yu1SUMVJkIWyTtJLlmwjsd4ZK1MVgR+4vmPm3KDGPI2wGZX9xfpw3PjyPIfI0ckVTCZQppICuGi2FLsmZ7zYKSj7W53yxuSkgkMWzvtJbqXRwR7MTJUkg6s5YxUi+0+GysqCGNld1gsKJuYe6S65uZJzY+sPj4LYZDubRKTbVzkBF75iKlr0sehnPYYOz8DuyJVInB31Ssx/M4d6xIlF8N0c+oOKyelu+yCB458weGbO9mmYmHp1iM4L9LCa/3mVATXjulGoCnOf7fbsj/LgDvoQfzFztjx8Gc1N7INrt8iBZb7oRJWfSW6XCSS6XISU5ZLH7VzkgAx7BsdOlCm8z9DtkesKchf7rhCcuKA0czabsEiximwnP/GYMqM+21AZudk4cSfHfiQT85vtw0WGkW8fR6TnYge4MUUdd9dtKff3C85VjawjSiU/+2D7/itt/mpUc+yX4cXBQAdwXRrsATgcCQ+UOWJ5h97y1R6Ce+Mz7fOGKocNAT7nEEZBlrKOwiAe2njYi/h0/VFp9i60KmVdVaCzO6ixzPsnFex1D59g9f005TaYpEW1oMBX2LzFEBHaKo9L4k9QUMeQgmMV55zTKtP5Wyvzto=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(1800799024)(82310400026)(36860700016)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: nQciln9FWRwi/0dnyvOtrTo1oNZ0UWn61vwGLtmhZ3/NuMWaGgxhx42dFn7wlDE0SKfWGVJZmBhCEPuZ7QfNvOBSOg+VI4bcix6jTXzh2ani/LdhAo/ncBR86/f2kzAShnBGrOTalgDIRdehdolXMpDqzY1kRkobNp1qi9pMprf6BehX/huHTJ+3YUEKWoHiam3ri7qCcZNpc7zZo6JEgAqG+0oL2QJEDerhtZrGipiV4J4tq5W5D1o3X0CUKgAbpj7x1rA/mdSf78VxwoB0a4KEeNQ1dqwJZDWYcfWDiO7dAUbLD/0Dd0U6/B/1pk78szQ0rXCM3pZsC4ASKdaLEet5QtBfzu57CBPk2Zne0ofabpG1V+2AxqseOabm9oXi/C77IREeIFYZhtcyxjzQUmxXzgy45YNG4NR3uEsJtPYGNr+UeBKlGmSf1aL9b0fu
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 23:29:05.2125
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: fbb2ad05-5639-4842-7345-08deb07e41fb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB52.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4301
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_162911_613757_886916E4 
X-CRM114-Status: UNSURE (   9.31  )
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

This patch is generated by Claude Sonnet and it is outside my knowledge
domain. Any comments or solutions are appreciated.

Command: CC="ccache gcc" ./tools/testing/kunit/kunit.py run --kunitconfig drivers/gpu/drm/amd/display/amdgpu_dm/tests/.kunitconfig

Without this patch, the error messages is shown with some WIP kunit
patches by lcov command:

Found gcov version: 13.3.0
Using intermediate gcov format
Writing temporary data to /tmp/geninfo_dat9yJO
Scanning .kunit/drivers/gpu/drm/amd/display/amdgpu_dm for .gcda files ...
geninfo: ERROR: no .gcda files found in .kunit/drivers/gpu/drm/amd/display/amdgpu_dm\
...

With this fix, it shows

Found gcov version: 13.3.0
Using intermediate gcov format
Writing temporary data to /tmp/geninfo_datLqI9
Scanning .kunit/drivers/gpu/drm/amd/display/amdgpu_dm for .gcda files ...
Found 25 data files in .kunit/drivers/gpu/drm/amd/display/amdgpu_dm
Processing .kunit/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_psr.gcda
...

Alex Hung (1):
  um: include .fini_array.* in linker scripts

 arch/um/include/asm/common.lds.S | 1 +
 arch/um/kernel/dyn.lds.S         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

--
2.43.0


