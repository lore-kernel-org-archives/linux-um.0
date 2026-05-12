Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A83CD343F
	for <linux-um@archiver.kernel.org>; Tue, 12 May 2026 23:29:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YO3r/UtOn2LCmGQt+cIoWB7DR+le8TVxy2g0/WsWqj0=; b=wFBpKbSZr/sANY98rIFxzy8+V2
	Qh1MPZ6Lzablurhe1gr3oSyl0cb//C+cUv0PBeDEUUS85cX56EMNxAmlzskA4UhQIMKwh7gbKx9wy
	XaW4l0KcyjDIWXRdUHJfZe2ezMmihCx23mTkUoEyTX09LCMQpZeYrMN8xQ5oX3H65OFkgnEo9zzWJ
	cfPocu1q6Mt0KK/uXf94qrRWqEDou885Y0vWMeukbVK3dpVEjzwC+JMZp0N5DaMFP+ogXJZ3HsHqT
	q7L9b4JpgWftcUgWKwQT5VtKiiueZ8zTjBpc03uLBwXcDa1AA2npRPveUMfEXHj5/LqhA7znSNEsM
	mCEOYp9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMwXc-00000000hBQ-12cB;
	Tue, 12 May 2026 23:29:32 +0000
Received: from mail-centralusazon11010059.outbound.protection.outlook.com ([52.101.61.59] helo=DM1PR04CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wMwXZ-00000000hAd-3f9s
	for linux-um@lists.infradead.org;
	Tue, 12 May 2026 23:29:31 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=pPJCrEta9xkSR437YVpMbkwsgbdICqMQIxbH0B7E5Utd9+C1OSjlQ4tyuCqaaSlZi/ZH6PEYVSeJkZY+EuoupGfoGiX+jC/7MjDNEyeWMkLfqZzhOiQFR+sUZB+2PE+FPeOj9NLuY2o1wjscutDI18o9eJjaMM0sbTMh/KkhmuRX0A6x4XSsMMFxB6cMh5qF/meYIGoiq3vxhKlFytHD1CxHQSVwzfkx+C+Pu4zznwy3PT5+w9+Hmo4Rsxd1lNOskn8vZRiVO1C9BnqpsRUsRH7tNJJf9F+CrAUZvGZi5vxV3LxCNmt3bDzaOvqLCv95WZoAwOGqSTDGKsOJoYXaPg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YO3r/UtOn2LCmGQt+cIoWB7DR+le8TVxy2g0/WsWqj0=;
 b=R7hqGnnCDK5x8VChxw1+M6GyukUg+q8jy3hsK7HD22qPDB+VEUn+77odn1VAuAWeFqUI72/bBOnWB5Kj4V19iXjLAHvMUQjCew/aRA8Dr5qnSQA1uleTwQRVF9ngapENNYOH7OkDzlSOBVHeXAtaR4M/hsQKdRhzJkQgbMbV+p56UME4LfCgHofKWqD6MyYxgBSS6l4FkmyRBn/l4l3w+UBY2L/ExGTk2skgg91+WsP6R4dJwnMC6f2Jislq5U0SGGnLYspIUxAk8YNNc7e52T5+ZJ+eOHeH8ttzn28MQ/JZjENuipUjx+V/YWPAxvdkJs3f+ZxXH86vfZNNwQzb3Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=nod.at smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YO3r/UtOn2LCmGQt+cIoWB7DR+le8TVxy2g0/WsWqj0=;
 b=HqAS9zWH71j23OXVW4gi2KAeQrj3jAN56ai/zjaVWdjqlstpgoNUgYZQq828k+280itRo+W4Mwia8DnWTVjNH5CAI9CUv9tFgN/ISA+rsY0++AuluAsshOulhzB05+TWodV5cBS9H1N22PhP8PmxkBSuwaNdltqp88CfvsLh/tY=
Received: from MN0P221CA0001.NAMP221.PROD.OUTLOOK.COM (2603:10b6:208:52a::7)
 by DS0PR12MB8563.namprd12.prod.outlook.com (2603:10b6:8:165::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.9913.11; Tue, 12 May
 2026 23:29:19 +0000
Received: from BL6PEPF0001AB55.namprd02.prod.outlook.com
 (2603:10b6:208:52a:cafe::d8) by MN0P221CA0001.outlook.office365.com
 (2603:10b6:208:52a::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.25.17 via Frontend Transport; Tue, 12
 May 2026 23:29:19 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL6PEPF0001AB55.mail.protection.outlook.com (10.167.241.7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.25.13 via Frontend Transport; Tue, 12 May 2026 23:29:18 +0000
Received: from kylin.lan (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 12 May
 2026 18:29:16 -0500
From: Alex Hung <alex.hung@amd.com>
To: <richard@nod.at>, <anton.ivanov@cambridgegreys.com>,
	<johannes@sipsolutions.net>, <nathan@kernel.org>,
	<linux-um@lists.infradead.org>
CC: <alex.hung@amd.com>
Subject: [PATCH 1/1[RFC] um: include .fini_array.* in linker scripts
Date: Tue, 12 May 2026 17:26:40 -0600
Message-ID: <20260512232640.1937941-2-alex.hung@amd.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260512232640.1937941-1-alex.hung@amd.com>
References: <20260512232640.1937941-1-alex.hung@amd.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.180.168.240]
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL6PEPF0001AB55:EE_|DS0PR12MB8563:EE_
X-MS-Office365-Filtering-Correlation-Id: 552003d9-b3c3-4fa1-d5ec-08deb07e49e6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|82310400026|36860700016|376014|1800799024|22082099003|18002099003|56012099003|11063799003;
X-Microsoft-Antispam-Message-Info: 6NwqpylUZGvIre3U4yubXCJF19z/dfrdQjo0Qf+WE2u4iFPO0Sczl08bEnuOvp28HXskiiE1D7xgavQbHg76saTq7mOHZRPSSCsUzJVlXuugF1dY9XZ6o4MpWYEH+VSwnEzqVKiYp0oL7V6SE0zz5wrzQMLXwoWLVRngJmhGLl9OtzROTLyIJLf3kyfmDb2skFEKYh7KzMAl+7OII4uVIqi+IDf+sY0jq1bxamM0wywntq4t2q4h2HqIujkwZPrDVeS0gGjtHQeIAHv5mGRUT1XchcrcV9MzbFdoS4+E5xLPnezf3RTxji5wVwyLl78mbhnuBvNa3Rdq0qCKjc2h2wFdv4OaKUz0pil0J6m8wyCgCZW5oCd8ap4WeK8lIEbiuO09Nr6uVTUS/EpEd2FwFqZNQ/Qr+jeMp5t0yxy2rXknOhtWb+LRGWV7MWL6UcY0je/zMXweCoqWbxIXrC81t8rPSFwE1oBmEX1Nefcd+50FG/VKxj0M8cLYjZStlA60CtizS2R5bY3eQUXI6ALy4+RvzzByACIJevav9fBmvjVpZxx3apyIAYoPzua6HuAS/lfT1KhRZ/yv+tLhr+e9YEug+tG/sS1XEuPd32F4lM/+kiF1IiAtnbPghVqyF7ep9L4RVPAllc0KQ7beMDh88rqHZfhd8cuCRppvv74MYaDkgsUNMI4rAZOSa2KnSkSje/P9luGRyiSPYCXRZ6wdfr4yWlmzzb3UvzA4RNVtdfw=
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(376014)(1800799024)(22082099003)(18002099003)(56012099003)(11063799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: z4FdnxnFJPcyxL3WNW8+QO2sZWrqlFlQyrczBgpiZpe9bW4nbzkPyFWwbs9xEg02DKlFp+rVhiybe/+UUytcRZUtDlf8WkrDN0zpNwYhWgJheLhYITRsICz1Uhg8tFMLP6lJDC9wHa404ZZ3ofd/pbfLx+Jz5vbmYNl5FMEHUrvRxY4YDmyuJUMgumFN42C2DNhmyftDotExl9lFIE0NUggq7bd1pBt/vu5QfjPegvR/AQHLYR9CbSdMFVd/02fiJJlyDGRKwhzlyYYq33I68KwfPNKKmujoe1qkyo8agOj7NdxmAfatYYGEUZMAbTJTPRclqzoyVG4cAIlWVODifuwgPwcrLfXYsy7o+WGnI4regnoG9DIJ+6T1+iFwxUZMCSasClRloxXryUsrvrmvCRAb9GnF5Wnyw3zkUW/3hB6hrx7RKXQnJ9OfPozfa/NT
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 May 2026 23:29:18.5002
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 552003d9-b3c3-4fa1-d5ec-08deb07e49e6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL6PEPF0001AB55.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8563
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260512_162929_911379_D5E20227 
X-CRM114-Status: GOOD (  10.44  )
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

GCC emits per-translation-unit gcov destructors into
.fini_array.NNNNN sections (prioritized). The UML linker
scripts only captured *(.fini_array), silently discarding
all prioritized destructor entries.

As a result, gcov's __gcov_exit never ran at process halt
and no .gcda files were written after KUnit tests completed.

Add *(.fini_array.*) to common.lds.S and dyn.lds.S, mirroring
the existing *(.init_array.*) pattern already present for
constructors.

Signed-off-by: Alex Hung <alex.hung@amd.com>
Assisted-by: Copilot:Claude-Sonnet-4.6
---
 arch/um/include/asm/common.lds.S | 1 +
 arch/um/kernel/dyn.lds.S         | 2 +-
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
index fd481ac371de..336361412b47 100644
--- a/arch/um/include/asm/common.lds.S
+++ b/arch/um/include/asm/common.lds.S
@@ -90,6 +90,7 @@
   }
   .fini_array : {
 	__fini_array_start = .;
+	*(.fini_array.*)
 	*(.fini_array)
 	__fini_array_end = .;
   }
diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
index ad3cefeff2ac..fbd8d559f21f 100644
--- a/arch/um/kernel/dyn.lds.S
+++ b/arch/um/kernel/dyn.lds.S
@@ -113,7 +113,7 @@ SECTIONS
     *(.init_array.*)
     *(.init_array)
   }
-  .fini_array     : { *(.fini_array) }
+  .fini_array     : { *(.fini_array.*) *(.fini_array) }
   .data           : {
     INIT_TASK_DATA(KERNEL_STACK_SIZE)
     DATA_DATA
--
2.43.0


