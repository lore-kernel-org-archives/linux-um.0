Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6AB2C43458
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 22:41:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=36mINZlsU92vyrWSy4WakfbBlQSXKD1mmnYDq7oZZns=; b=DkBx2q9ABfrUSCGOAJltywmTCS
	Lx7bZ8GZ5nv85fD7Se4qQd1b0TOKELHEbLTSPLgX48pbHCDwsQAiUwFkmLoWKq+s6X6YSDPzH29w4
	nGxhcKYayl+J98Q9o6yTu85Lw7/+epergrrgbG9jYtUrHJsLvlex6CcO4/MEYlfgkk2CdiPTivpDF
	xlMuZNujP6Lkt6ceflH/dgfELZb1TkqaLqMAYybEg6Ukq8Br6UXzvW9AcymrQTcYiq4BBUPT3omg4
	88ch17x8g98tp91m57+QYB3u5Q6nRQj//i7R/4b0D38C1pe7Pw9Y+SXvkPlEcIkYyB2cobA19LeGH
	Kjj8sRBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whaxL-00000000Y8I-2Oub;
	Wed, 08 Jul 2026 22:41:27 +0000
Received: from mail-eastus2azlp170100001.outbound.protection.outlook.com ([2a01:111:f403:c110::1] helo=BN1PR04CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1whaxI-00000000Y7r-2kiX
	for linux-um@lists.infradead.org;
	Wed, 08 Jul 2026 22:41:26 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SwtDqCoesl1ItUojy7zn0qDKfP7HgEvByR5YSSpNHjIR4aaUOxvoSMrSFpS5y68xluLG8hiKdQGwD6nRV8OptA57BHtfRs0m/kPZxPCBHL1OX0g2EvAIG0705a7q/m42AHnbVh4jkE7cZ8CEa+na/p5EII8TpIdgrwi4g1gJHT+93lSpXfNnGATYsVzSi1QEV3pJ1pYThwUM826NL1Lg/VXgfDm2a2pyx7UPWfsr0jF0CrrCs0q5k/qdRBycIKC3Lazmp7LicUWl+4gj8PEHELgelQYhhx6/QdtmHjsR1pRww/F7/4dOSi2PH6MPH+LHgN8CAOYpLswmSWHUQ4wpVA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=36mINZlsU92vyrWSy4WakfbBlQSXKD1mmnYDq7oZZns=;
 b=bSbPwiPnJkKL9m0Go73In8KXckdGi+ymlE2/49iEItVkiWJYgA11PBMIgbnTRufrB17rl7jmeLFyUES9z24wdndnVZj+4q4J4JgmQtl+NoSXeZh5a2CEKdB++RQ+Ks2HPDmrQLl8uBSY0DmWgs5KMox8RvTHwPOI0J+Ov7Ks+fbBKJRIQiwnZWf/QCvMFQlyqrX/pM8mHDCqwznt6XeK/cMaUX8yavUSmJBns5cZ0AyLgz5gzpHwFLDT0AuyxpEddmf+O3ELy1J4BfuaAUPKymnUDBxAZbl1ybKD+zt1HN1Rqm2+GxMbVxJoIqbjsoIpQToY0TUAeIJagKOEM1pU4g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nod.at smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=36mINZlsU92vyrWSy4WakfbBlQSXKD1mmnYDq7oZZns=;
 b=u/qNQcFk13ECOgMDz433VE9Het+xqUTJcOB7OX2ImV15HIDeeOvRi8vFkiCbIZZ850OiGvPesw++jQX+S7JkMmasnPSB1Xc6xHpaOCnLG3tMsRoyS03zD/BCpSj3YvN/rU+l2FkVNitcXl7VuhMWPQI4wfetBzKAH1IwVdRkV1w=
Received: from SJ0PR13CA0076.namprd13.prod.outlook.com (2603:10b6:a03:2c4::21)
 by IA4PR12MB9811.namprd12.prod.outlook.com (2603:10b6:208:54e::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.8; Wed, 8 Jul 2026
 22:41:17 +0000
Received: from SJ5PEPF000001EA.namprd05.prod.outlook.com
 (2603:10b6:a03:2c4:cafe::6f) by SJ0PR13CA0076.outlook.office365.com
 (2603:10b6:a03:2c4::21) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.3 via Frontend Transport; Wed, 8
 Jul 2026 22:41:17 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SJ5PEPF000001EA.mail.protection.outlook.com (10.167.242.198) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 22:41:16 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Wed, 8 Jul
 2026 17:41:14 -0500
From: Alex Hung <alex.hung@amd.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <linux-um@lists.infradead.org>
CC: <alex.hung@amd.com>, <Bhawanpreet.Lakha@amd.com>
Subject: [PATCH] um: Allow multiple symbol definitions for GCOV builds
Date: Wed, 8 Jul 2026 16:40:06 -0600
Message-ID: <20260708224006.3405038-1-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: SJ5PEPF000001EA:EE_|IA4PR12MB9811:EE_
X-MS-Office365-Filtering-Correlation-Id: d3af8ee5-5478-49bf-22ce-08dedd4205b9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|1800799024|82310400026|36860700016|11063799006|56012099006|18002099003;
X-Microsoft-Antispam-Message-Info: y+Dop1RzsfWLFQBTOpdcjA1n9FTqaAYEemfKkh419s3aOrZB0PH8xwGkDjtfWSItKTrXjLv6JEX8mUPP06i7AH86cmGlXGGDmV31vIaMr7x7bYmUYSRdbPjfHVMINqGaTN1MLm5gsrFggw8dQ5nEkQzbyIxFJCJCj5HExEJJEMtNS+jO3VFpEjYj+7t9ped5+k+n/OpMJ4DU1W6szWIqrvt70rQwYUdfy9aLihGJFkpdJddonUmbzxGxfZFXfu3ycjeLM/zOd9JSjituKCsSZSZ0XhMtrKvFGASpFb3DMKBwcT+LNUKfNxNuVj0JJ8HuouhcGQRDDLG1v6QfmZ3SxfNiPQ7YCyxtIVss+sRhPZTGH9FIL1vKZUGNs4kZzHPbsYNB8BPLHlbzr1nFaixFJWWNN5qNMI8AS2ZE78JDYq0YNtAzm7PWCp/EbEX05e1ioURgUvQSNCNymM+HHVAUQUddKz5Xjrdtm31QdvfP7ikyrX3UTLI+u1t5X2IvRh3qRt/bGHzhbZfB+Yb4yYmncZuI2fxGxXvAEFtN6LHrWvTI2rIPszFz3HdzKS5W/fb01cx6/omeO1QxFwCWXFDaY/TjaRfLkY/Z4I/Y9F1NztfY5BEYqaS0+tQAF0iq+YAEWgvWXZvA8ayuw1TH8d5ou+E/6USW9Z8GLImDTNLjuB16YKGyUiXhUesMOI7IgHl36SIUVYkI9VQDPNmzVdRq0g==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(82310400026)(36860700016)(11063799006)(56012099006)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: tV0fY0WJeXaX1Khzjpxz0qtLM5r79WFq0omlSQHDLiahOUN4gLWAE+roYmtbSgSQl5Br0bJ84c5sRrVv+J2aw0fjO+oWvbPMqbA8cFkZc3EVmWVH7Lhy3eo0PaVLKvHvhSAKBDZXS2a4fNArhsv93WaCSglzcw1HiN6xCdQGDC0SY8KOu6bwZU9Gcls4RYL0ZBNMMtMqkbLks5jn7k7yJMUcNi2rCq7LpD5pma0jEGSW4/alIR5UPbcPhngMhH8xejxTynMDI23OT3bb/nOL79FuZXItt2ocTDSTqPFPTBU+lhCvzyOteOcj4kmujs2/vtvGSa5vCRPVN5X9S3f0+195VWSTfy93KrPimJB2/EeMUgsKgjFqcWgEWts6rSAHlT10zgaGm5lF2vH93H0023/Qv4pnB2VRT5BWwSzY6IBdO/ZaFv92vxkuDZbKaLUG
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 22:41:16.5672
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: d3af8ee5-5478-49bf-22ce-08dedd4205b9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: SJ5PEPF000001EA.namprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA4PR12MB9811
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_154124_842181_1E520BFA 
X-CRM114-Status: GOOD (  10.67  )
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

GCOV-enabled UML builds link GCC's libgcov into the final vmlinux
image. libgcov provides helper symbols such as mangle_path(), which
collide with kernel symbols of the same name (for example the one in
fs/seq_file.o). This makes the link fail:

  ld: libgcov.a(_gcov.o): in function `mangle_path':
  multiple definition of `mangle_path';
  fs/seq_file.o: first defined here

Pass --allow-multiple-definition to the linker when CONFIG_GCOV is set
so the final UML link succeeds while keeping the kernel-provided
definition.

Assisted-by: Copilot:Claude-Opus-4.8
Signed-off-by: Alex Hung <alex.hung@amd.com>
---
 arch/um/Makefile | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/arch/um/Makefile b/arch/um/Makefile
index 721b652ffb65..09c8354c8b65 100644
--- a/arch/um/Makefile
+++ b/arch/um/Makefile
@@ -137,6 +137,13 @@ ifeq ($(CONFIG_LD_IS_BFD),y)
 LDFLAGS_EXECSTACK += $(call ld-option,--no-warn-rwx-segments)
 endif
 
+# GCC's libgcov defines symbols that can collide with UML kernel code, such as
+# mangle_path(). Allow the final link to keep the kernel definitions when GCOV
+# pulls in libgcov.
+ifdef CONFIG_GCOV
+	KBUILD_LDFLAGS += --allow-multiple-definition
+endif
+
 LD_FLAGS_CMDLINE = $(foreach opt,$(KBUILD_LDFLAGS) $(LDFLAGS_EXECSTACK),-Wl,$(opt))
 
 # Used by link-vmlinux.sh which has special support for um link
-- 
2.43.0


