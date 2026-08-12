Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEBD6C5B572
	for <linux-um@archiver.kernel.org>; Wed, 12 Aug 2026 13:20:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:CC:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8DHCEDBErF1D1EW8S1AgvnN4skuEBB1iUgfTYIbU8dg=; b=3ttDxLnjfsmaXmoW6tETH7G92R
	4HXotrM/GLjv+nqjZO4Hg5Fxb/Kqpivnrwf8PObkBT3qaZ9xdfW6poGAlwTdkrfCyo1GybgZzTfJ1
	9pH5UEIl1s58G0hAI/IL/c36xnEg794uQJ5IMRDM9Y+xbJWg2emLY5rH8zaNcLtRYAIqXx5yj+ROY
	a1q2OCCWQZcmzmfAv4HKPRbcPJmwntDBhfZ4YAf5kHt1GLIuSyG1dgWKw83zo9ivMkWUGX8g1vhAD
	SA4HG8EG2m8/tBmeWHCqM8sQ2nz+a+vT8MToUHTcISojLyeHuZf4P69WBcXrfIIQKihAbaNskhKKW
	xETqArTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu8sz-0000000GGcI-44i2;
	Wed, 12 Aug 2026 13:20:49 +0000
Received: from mail-southcentralusazon11013019.outbound.protection.outlook.com ([40.93.196.19] helo=SA9PR02CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wu8sw-0000000GGbq-2nol
	for linux-um@lists.infradead.org;
	Wed, 12 Aug 2026 13:20:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=a6iqBAcsUigCZQAR4FD9reMQCvbGBWzF9ux4CmcDdJOlyC4s2TrMdd97VaChTEYjQf50gSvxIAhyk6bYFRlOe7xoTio+q3TWLZ0i1/n7mF9YYQB26x1CF/TjZ6pbwVXk7h5fm8/TdJASsElcia3eg9PFSEPfoKYUhLC1K/Veu1AFlWjeZyOA2Z/8Lasi0fRqr0dSGQzXiP8Hr3sOcqVpmDdbothbwizUzhAYoDGE4t0ilzLTKadWjNRowu2u436ZlvRgIZCCdSVWSYalSdqXrvfnmyXZPSxlBNGQlR44B1HW2Jcip2hDIYAAbRMUxfeLISYmWegaXKjdqZhF26SdLQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8DHCEDBErF1D1EW8S1AgvnN4skuEBB1iUgfTYIbU8dg=;
 b=nkrqGt27O/WKIJkKYiz+sj5ni83S/t/31toQy56v/EXq9t0tVJq5S5fTZqMZEk4pvhED+09NAPEDomJOJD+CcKLD6RpXfM6VnhgZyYhf6akgwl/xXlM1/6rZoYZKC0ZvFudw4Xol2/kHQny1Igs5IQ90+2glude4p5WsGiR49MltQMfF1u+MxHZThfPRmwEYO/ZjvDCJF6FVW3GZ7SxYs9mCHo4ums5H9PhYp0PMUtQtV2+g3iwuLaFjeaUCy8/apfKOi9an4B6Z3cQXC+1Ypz1CQ014zdYDwUXvVSUabm1FO3fNQqkumxKjELU6L3WjyVSiRL60RSGCG+wJV+s59w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=suse.de smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8DHCEDBErF1D1EW8S1AgvnN4skuEBB1iUgfTYIbU8dg=;
 b=ErFaPugiWpSwt43b9mc9PCPRKBbDZ6WXa1Budb8k1zDHBunss6jfrqTQjMpuE9D4Hk5bNwevPFdshU/bfm3i35iwBQlE2hrMJfa/bqj3gNMrTuE6evFnesaY7FSKs/siM/aT0Pq+ViXf7xydhcE+GQimsIm806BK+uHYDDI7+Ls=
Received: from IA4P220CA0012.NAMP220.PROD.OUTLOOK.COM (2603:10b6:208:558::17)
 by PH7PR12MB6419.namprd12.prod.outlook.com (2603:10b6:510:1fd::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.19; Wed, 12 Aug
 2026 13:20:33 +0000
Received: from BL02EPF0001A0FC.namprd03.prod.outlook.com
 (2603:10b6:208:558:cafe::23) by IA4P220CA0012.outlook.office365.com
 (2603:10b6:208:558::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.315.14 via Frontend Transport; Wed,
 12 Aug 2026 13:20:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BL02EPF0001A0FC.mail.protection.outlook.com (10.167.242.103) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.315.6 via Frontend Transport; Wed, 12 Aug 2026 13:20:32 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Wed, 12 Aug
 2026 08:20:32 -0500
Received: from [10.252.195.98] (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.45 via Frontend
 Transport; Wed, 12 Aug 2026 08:20:21 -0500
Message-ID: <e5311d9c-d086-4681-a470-f8b79ade27f5@amd.com>
Date: Wed, 12 Aug 2026 18:50:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 9/9] x86: re-enable EXECMEM_ROX support
To: Pedro Falcato <pfalcato@suse.de>
CC: <rppt@kernel.org>, <akpm@linux-foundation.org>,
	<anton.ivanov@cambridgegreys.com>, <bp@alien8.de>,
	<brendan.higgins@linux.dev>, <da.gomez@samsung.com>, <danielt@kernel.org>,
	<dave.hansen@linux.intel.com>, <davidgow@google.com>,
	<dianders@chromium.org>, <hpa@zytor.com>, <jason.wessel@windriver.com>,
	<jikos@kernel.org>, <joe.lawrence@redhat.com>, <johannes@sipsolutions.net>,
	<jpoimboe@kernel.org>, <kgdb-bugreport@lists.sourceforge.net>,
	<kirill.shutemov@linux.intel.com>, <kunit-dev@googlegroups.com>,
	<linux-kernel@vger.kernel.org>, <linux-kselftest@vger.kernel.org>,
	<linux-mm@kvack.org>, <linux-modules@vger.kernel.org>,
	<linux-trace-kernel@vger.kernel.org>, <linux-um@lists.infradead.org>,
	<live-patching@vger.kernel.org>, <lorenzo.stoakes@oracle.com>,
	<luto@kernel.org>, <mark.rutland@arm.com>, <mbenes@suse.cz>,
	<mcgrof@kernel.org>, <mhiramat@kernel.org>, <mingo@redhat.com>,
	<peterz@infradead.org>, <petr.pavlu@suse.com>, <pmladek@suse.com>,
	<richard@nod.at>, <rmoar@google.com>, <rostedt@goodmis.org>,
	<samitolvanen@google.com>, <shuah@kernel.org>, <song@kernel.org>,
	<tglx@linutronix.de>, <x86@kernel.org>, <bharata@amd.com>,
	<ananth.narayan@amd.com>
References: <20250126074733.1384926-10-rppt@kernel.org>
 <20260812063316.21371-1-nikunj@amd.com> <anxa3VjtukAkY4Cl@pedro-suse>
Content-Language: en-US
From: "Nikunj A. Dadhania" <nikunj@amd.com>
In-Reply-To: <anxa3VjtukAkY4Cl@pedro-suse>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BL02EPF0001A0FC:EE_|PH7PR12MB6419:EE_
X-MS-Office365-Filtering-Correlation-Id: 5bb03f0a-4f55-4dce-2e70-08def8747ce6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|82310400026|376014|7416014|36860700016|23010399003|11063799006|10067099003|56012099006|18002099003|22082099003|4143699003;
X-Microsoft-Antispam-Message-Info: ZoKC0kyZYWdpGI8twWDSDDwTu998XtttPGzTOOY35QPQqCCcG65RhHQDRNhAxbecIiAiEYlOVrXzVTvUxpLCy2jrUYz3NJnBaNXOuhhy4bgoJ9jtPUfQlNnjgP6+xUkFeT3hrRZ4SnJL23gmrIpQ2+xHItGYdyq25lvhbhQDh4gh5SaXFVUrVlU+LpnbGeFw83zVAW6m85cFBWkHWFH1awW/0jZEq/IQs3/M/hzDK9jNMVTb+dKzidC2LbiQgnEq1ssOphNrQwe8tLqHF2AlryWfCAHXrN3agc4d0A3f4lxtnj3GFda+zQ+EVDepKYUbVM+Omb/osh5CgJm15svIx69ZgruAlDrlw1sOd+C/7apO1j1b+psKbxs4azSr3zHxJ5M/ZZoUpWMCXZp2xbI8HEMI9QwLIriEI2/ofS70JaYaGrLQ2B+um+/LnCuHJ7MICazpiCu2rnn/rnrVdpq/Q2qtqEjmmD6+QCn430aYyqyZAtr9bnfCcr7q9IUMR67NRwfzVXhQzF4razDSko3B18NBb5OQ2/0R03SoxNs/Fs+FnkUYAjLIBGvSis+HsSgKdEfs5V/WBYPKV8FVwL7rGk5/EZj77A+LV6i8hKihloc5JpimCwsdaTf2YeQdQGw7rUdouFro5xo43EVAuMxd/2WoN9Q9FedohT5HoOIauYmnmlqfuOsskrEcY1zFzhPAGkbar35sww1GNuszhny/xQ==
X-Forefront-Antispam-Report: CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(7416014)(36860700016)(23010399003)(11063799006)(10067099003)(56012099006)(18002099003)(22082099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: S12wl5c9reU3Sw613S69LgE05fnqEQN8C8JUj1kFiJfCAuVa1XJyYTUaDrhqPPTRn1tzcfQ0XCOtxsc6fnQC+VwH/QVJgzpoF3dGGiQHMRFpVrUpn3BHQ8UEYHYmzuieuy86o7gv7Gghs3WGJzz4Jwe83FRvMj2ogFSq8SR0F+sbIXTg+VEZ+RFqH8MIotktIaWyYCPInYCymxZTk2JwCF6v9qLPXBQV4XJdMn1MIdCmPho8Q4b9UTMVMjgm7cm3vfPNPmBOIUfntLdmNtHJ6MNdODuvxcUF8EsdIjp5dpqWWV5WK9GmevaKcmCLpyRAIQE6ubz8EFpoLG3DyWS570e5S5v88LRC46K/dZlqtHknzpdvr0KoPUuepV2GXhwFUb0Hn5umiBkbbkPKufrB7krAXWDycSGn8IpNhTmYpIzlYS3Rv2BbqHVUFCqqAHwU
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 12 Aug 2026 13:20:32.8107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5bb03f0a-4f55-4dce-2e70-08def8747ce6
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource: BL02EPF0001A0FC.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR12MB6419
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260812_062046_716901_C1D2E2DF 
X-CRM114-Status: UNSURE (   6.79  )
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



On 8/12/2026 5:08 PM, Pedro Falcato wrote:
> 
> https://lore.kernel.org/linux-mm/anCK3eWFMwZqq5ka@pedro-suse/

Yes, this is the same issue. Thanks for the pointer.

Will get back with test results on the above thread.

Regards,
Nikunj


