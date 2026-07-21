Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5892C4452B
	for <linux-um@archiver.kernel.org>; Tue, 21 Jul 2026 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=czLQazxhEchsmNL1kB4tEkRv5CnOaXy0U8xRLUIOwvo=; b=BiRpW4cCuMy7sPsLrx+LiVH4EQ
	vP3fvMvra8YQ407QwGShIcWTc3MYyAr8Tu0LEqqI0ygrCSNUI0CIsuBoWi2Ju9G8/mTEj57bkOiEX
	TEiE+pX19xxNkmPsYReyAg+Q1bQhI9P/zAgxdBpznOnGyEIheQi4m9u07OStnFl6og0RthILtgGEB
	cqirxQsnE4GHDO5BYYIAs9q0MdOdnane/N1VFzcUMepgOqLygH7mlrjKNzzF8dwud3kx9vtrIOrR3
	hFYKzMlFRXmZMDG+8ooie7Olveu8xZOyJZ6Tstv3LQ6ECuvBMqkCLS+fOnBVjeQKLwRW5EyiixrHi
	2wZMNZ5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmIsd-0000000AWBK-3GbF;
	Tue, 21 Jul 2026 22:24:03 +0000
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmIsa-0000000AWAd-2C6X
	for linux-um@lists.infradead.org;
	Tue, 21 Jul 2026 22:24:02 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=SVfrSl0NMq4f24B2Wd/VghQmWazm97c32MPcczQTT1odOYVHxP7LiGlgYKOx3Kf+JbK/wYG7yo8PV/lE3OkLh38U9myKQWE+njY/799nbYTP+RwJvckcG5bG2/iVNTu00dKTIo6l1cUdDLxWWSjCPGsfu5F5JavxgLFJnVmd65v3BI3kxfQnodILD174mlWo9WO7sxdSr+dcCJJjdQ+I2scDclmsvj7rddstW/Pc7chOzV/ROMuXCihRWtRFv4Yy9FxI3ts6y4p9ZWaTKoi6C3htcoBvXSvr6kqUJaz0lH4X749EVw94KsmOpRovuN4C/z5Ga9liwswJKq/HVa6avw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=czLQazxhEchsmNL1kB4tEkRv5CnOaXy0U8xRLUIOwvo=;
 b=ssiVTecWwWIoON4RkFBy3Bh7NBldMa5i/noF6xAFi6E/WlknSqtJlzhGnczFmZjlBhc9aANAP34acY0OECTiVKTX+v4KDB6BSRBHsknjrcLiYxRv+lmfP3edI6ckN34mI27aYB9mmXrqM1b4Vz6DuOC9KfWzTurj6BVm0jpwJRFezdHqq2y4kNucj19duJuQd1smA2Qx/Q3SB5r59hnC/YMAcAdSoS+POR/xUi0LXlPbGFMam1XfzeUrSyCo3ajRFSTSyHTShUWpsACWzKbobchlVWdzoo5DXKed7+BVorN6XZowV8JXOVIFQY0fCQhMwMzjRhK2GJciol8cWZh9jQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=czLQazxhEchsmNL1kB4tEkRv5CnOaXy0U8xRLUIOwvo=;
 b=jhzisCduVBgzyKYxXmQm2jwV8W57SsNUrAn1ogDpCO+yXcMkTtCGvCCstaJ7UfRX5tckyF1bZDzAZbpBKuQWM4m0Dhll6UUtIOOmiz0z6E65ZLwdRRFyrqw8FkTZ1TZkesc3/k9UaeNiZlIcfRIHbuihdkBbfM8hhx/57dNtyPE=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MN0PR12MB6296.namprd12.prod.outlook.com (2603:10b6:208:3d3::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.18; Tue, 21 Jul
 2026 22:23:53 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.009; Tue, 21 Jul 2026
 22:23:53 +0000
Message-ID: <75f2f98c-78df-46df-9961-6ddf2870d044@amd.com>
Date: Tue, 21 Jul 2026 16:23:51 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Allow multiple symbol definitions for GCOV builds
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: Bhawanpreet.Lakha@amd.com
References: <20260708224006.3405038-1-alex.hung@amd.com>
 <743d1be771381c86c7f264810d88876976cc508f.camel@sipsolutions.net>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <743d1be771381c86c7f264810d88876976cc508f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0298.namprd03.prod.outlook.com
 (2603:10b6:303:b5::33) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MN0PR12MB6296:EE_
X-MS-Office365-Filtering-Correlation-Id: a506509a-3be2-4246-ac64-08dee776bf63
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|23010399003|366016|1800799024|10067099003|4143699003|11063799006|56012099006|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: MjMlXXyJ0Q8/mDur7GHFVo1oxMzwTniah/9iGaTQ6FFNSDI3BGQPFlvByTBo5IMb5Q9BCHbtR+KA0FMXXjUtrNLK1EEB/uYmpGpq79+m2vzbrVA1kr+lKLpJ0yC0FllMr+zmTjPP1aRl24lVvIRMy0oEfGo85JOke7EWexwNfkEsah+6I/E2b8pTOtteA7j9DZuE+yKkmrYgDOpt7tpM02jRx9nujyJiWtQ841LAHlnBPNLeMT4sTUle+Z0YZZW6kGaBtM6m/ArVqTmmWx37nWPRS+zk+7CX9vwaSiqD5onOyJKt+tJvnTvshoN5pabQLJpIbITQ1owsocv9fD4w/IUX89q44H5PG2zkJllGG40gFeFyKrDxgF68iDEINBphqidfKr/QUMYVAYJxhfLIK7OpO9auLqbRrGFNnFcaZqnBFhsrN3fCAVil2cnpuXeJxpVivgggpDbmbGpdl+71YFDVRuSepMo2uNTtGKYyh6gf46FeAlTpZTEQj9OMKW+DfS3bHCtkrOfiNkvtlEBed2Dgi2Pw/9NDrqmcpRGVLMg9N1qDU1Nh7fLYVF82hiT3cvqKPVyPX63OFhNDXDoLdTg5Gb5zyvIKgsP9NCoofA4c1j9JX+ykI2IXvVsHyZiDa0F0XQcjB/hewHjQeFt/47XjUszQo26lLdwiWb/d9Ls=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(23010399003)(366016)(1800799024)(10067099003)(4143699003)(11063799006)(56012099006)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UDl0dXlmWEh1UStCTHErWkl5cUMrZzlsZDF0ZE9GbG1mNnZ2dzRVK1FnS0Jo?=
 =?utf-8?B?QTI5enJMOThBVVRQQkliTnlRSVFtRXNaRmNvcEZsN05FODlzQ2Q4K1JEK1VR?=
 =?utf-8?B?MkFqYWoraEVEWWc4MWc5NHdrdm5LSWM4RWFnRmkxcFJjSEdZc3VXYjU5TXFj?=
 =?utf-8?B?SExhT0hTbHNEUXVMQXRnSXJ5aklpWkxCUExMMUU0ZzArMnczUHRhV25FaWZO?=
 =?utf-8?B?WE56Q212Ym1BOTVVY0ZNTlp1ZDNYbjJyYkdpeGt4L2VLS0d2K3A5UEt5S2l6?=
 =?utf-8?B?N1EwVm9VU1g3eDVuUmJRbFgwa0psVU13aGd6TUZMYlcwankyUzJIbmRrOVFW?=
 =?utf-8?B?emN6aE92RG8yTWIwTFdvY0RmUXF4UHh2RDFabTlHRTY4OFJnTytOTmk2dVhT?=
 =?utf-8?B?VXR1ckExUTJod2dyb3hIYUlTVGNNcU53RjFsc0V3YUNJT2RNbS9rd0VkRlpi?=
 =?utf-8?B?cTZQT1VLd3I2VGZRZzR2dUxsclNxZFVGK1FNY0trOUhkWW9RVi83ZzZVRjJT?=
 =?utf-8?B?ZkQwSzBFQmlsazFvT1FNTHB6L3pYVFJ5eTVDV29sMko3dGlYbW9IWmVvQWty?=
 =?utf-8?B?elp0am9kR3dUR09YcmxRTXAwUUg2YzJqTUJjM2orSW1Ta3N2eWs5aGlxWUx5?=
 =?utf-8?B?bFBwQnZaUmZRbGYvV00zd0RaVWQzbXhzb2pxUE5CUWRmakt4cDM2Nkx6Zlhr?=
 =?utf-8?B?Y1pWWFg0SWEyWGhjd3hKdjdiUDl5VnBRSllGcVVXeDI1K08yU1RselZCOEgw?=
 =?utf-8?B?UUZsREtGaVBEa3lVWndSanI4bGlmYk5CUzd4bEZJWVFSbWJxWldUWG43T2lp?=
 =?utf-8?B?UkUwc0dsWjhQMEVzbVJsMlIrRXl1M2RUMlZud3dYWlRNSVJKZ1VyOHhXZHZm?=
 =?utf-8?B?NzlTVERBK3E1VkpocEFBV0NCZkNZcVRJSEFwMUNpalo1NnBDQ1podWs2Qnd1?=
 =?utf-8?B?RlNVSWFRT2JyMFQxSnhaL29POGNYYW9xZmxwUGl1TlQzaGplY2VQUllseE9F?=
 =?utf-8?B?UUxnSS83NzAweTNwU0RhZFZqYXlkc0tuZ0o4WDFrbGYzOG5LSi9yOVJjNmF6?=
 =?utf-8?B?ZzYwajJnR20wVk8vWSsvalBUSElPVEd2Uk5MYU1wM3dZakhucVFLZjlYMDNT?=
 =?utf-8?B?R2dWWTVNN3BFVzlJM0pwQ29XeGhENFRDWlFxNEhWK1NCbVhldkZYbXFpdm9Y?=
 =?utf-8?B?Wm1WVFFFR2R4OVZvTlBjV2RwZ0JWbHIyOHpMRFRWakNzOTNLbkJOMVpVZmNB?=
 =?utf-8?B?ckFqZXo1TWkrSHpKZ2VqYkpDZ2lLK0hFWlk0S0VYTU1kVHl4NVFTOFpWdE5u?=
 =?utf-8?B?eWJCbGpQWlRqM0IwOWY5MnFONmpFRGFnTU12NlRkSXUwSzcrRk5Bc1UrK28x?=
 =?utf-8?B?dWVPYzJidHRuVGFoeXFkVWh1NEZsd1d4YmdzdHF2b0lMUnlsU3lHYnJCR0JB?=
 =?utf-8?B?TUxQaVlzWDlxM2JoSHMwK01KdEtEa2pOWFhXNTJmb1U2TmFSdU05d1VGK3Bq?=
 =?utf-8?B?QWZ2bTIvbHRIaGt3aGZ2MFBXd08rRWdUSldsVmVyQlk4OWdhV2hQbUtnWndk?=
 =?utf-8?B?NnFIeEpsNjczYTBjVGlhYWZNem9VR3pMYW1YcEZKL0xNZ0FlcDhnVitBOWJk?=
 =?utf-8?B?VGZHQllibnRpZHFzU0RobCtqQzh5VnRjaThvYlQ5K1FDYVM4YktKb2NIZXJo?=
 =?utf-8?B?VVBFNGFqWE91Y29qRFJsVklpVUd2eXd6NE9LUitKVWcwa21FQmQ4NXI0WklE?=
 =?utf-8?B?ZVNMcnIvZDllNU5YOE05S2tOVHhOaCtYUjNMSGE1cURlS05CakNGNHp5VFZm?=
 =?utf-8?B?Q2VDY2w1dTlBR0NaNWpUNnlTL0drNmF0bGFNcHhnS0VYV0pqbUpXUzhjYXdW?=
 =?utf-8?B?a3FVMGYvOWdCYzQ3S3FuWGhHT0hRWm1yWWp1Z3llTGtiT2NnZ0xLczE5MTVY?=
 =?utf-8?B?MzA0M2FjY1QzNnB3clhmdE8waW1HZ3EyOTgyUTVrN1pRWXB1V2hxZE8wdG9B?=
 =?utf-8?B?SUY5NUY3aXhaWnd6S2JVRU9RckxuWGtwdU5reWNlcG13cVB1RGR3MVlKWC80?=
 =?utf-8?B?c2J4M2xDeUg3U00zK2hDSG83VnNtVDFmOGl6bnNCd3pFcnU5N1J0aURpVjB6?=
 =?utf-8?B?UUZwaENkYk9QZ1hHeEsweHVZb1VuVFZYMCtyR2YrZktpMWs1akZucTRFaW0x?=
 =?utf-8?B?SUFIMW4yTEZpbjhFdjJFcXY5TUw0d3dHMXM5cWNXa1lZbFBjeVZqQUp5eWxr?=
 =?utf-8?B?Yk4xdlFaSm0vR2ljZVg1MUlOMkZQajFpbGdFdHhpV1U4RTVCZzJ2Y2lUQVRv?=
 =?utf-8?Q?GFlDpD0VYLKhk0U2+C?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a506509a-3be2-4246-ac64-08dee776bf63
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 22:23:53.7717
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2QDFNbILrfsy0GuccMVIvQxlzXNrHX7qKpgxYhEP1qWYXBL9roJi7+6xa7jDfT0BW8aJOfd5eoqduDiZryVFHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6296
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260721_152400_604749_8CCE8113 
X-CRM114-Status: UNSURE (   9.97  )
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



On 7/21/26 15:58, Johannes Berg wrote:
> On Wed, 2026-07-08 at 16:40 -0600, Alex Hung wrote:
>> GCOV-enabled UML builds link GCC's libgcov into the final vmlinux
>> image. libgcov provides helper symbols such as mangle_path(), which
>> collide with kernel symbols of the same name (for example the one in
>> fs/seq_file.o). This makes the link fail:
>>
>>    ld: libgcov.a(_gcov.o): in function `mangle_path':
>>    multiple definition of `mangle_path';
>>    fs/seq_file.o: first defined here
>>
>> Pass --allow-multiple-definition to the linker when CONFIG_GCOV is set
>> so the final UML link succeeds while keeping the kernel-provided
>> definition.
>>
> 
> I cannot see how that would possibly result in correct behaviour (beyond
> being able to link)??


Hi Johannes,

Good point. --allow-multiple-definition silences the linker error, but 
picking kernel or libgcov's mangle_path() will break the other at runtime.

I saw your previous patch 
(https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06604.html) to rename 
mangle_path() to seq_mangle_path(). How about reviving it to avoid name 
conflicts instead?

Alex

> 
> johannes


