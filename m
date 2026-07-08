Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 382BCC43458
	for <linux-um@archiver.kernel.org>; Wed,  8 Jul 2026 21:42:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:References:To:From:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jEdA8xqQzVpf+aIuSUY52aK04YvS96S2UmcvGrU/h6A=; b=HF+12KcksYvTx6IT+CKmeHZfKX
	I23gjypEeL156w79047dG+kHtPGSUGpvzWvnW+4wiHDpbUA39WzsNCopBrVda4T0/o/nbcxwEwRiG
	bQN1nF+OlJRGkewFTX55sxVaNwUiIK8Qf3sc1QtE4dYhKMrlhcrCUj5W9CKAfxybfp/XgNGq5/UmT
	gFGGTnYDvaLLjHQL5ZCY9xfVydS4rXcUdTzpwUyDo4XeJ6Q7tvebbb7DBeFLvSJxOiHDYtPldDkNW
	/3+pE6GSyPpf26/JbbIbLqOAQb3mjkvARwvnttAKkeUpJNWyeyNO6XP1VOZHb/w8m4dz7tn7E++3w
	7csWNLNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wha2C-00000000SlL-1skr;
	Wed, 08 Jul 2026 21:42:24 +0000
Received: from mail-eastus2azon11011015.outbound.protection.outlook.com ([52.101.57.15] helo=BN8PR05CU002.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wha29-00000000Sks-2fYy
	for linux-um@lists.infradead.org;
	Wed, 08 Jul 2026 21:42:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=HhRPVEXcTXG+MPRA8s250g9uQT/JqLpvo3qBWeYaaMKC20V6iMoFpfbkND+b757KosngsF1pubQia9kqDA7M+tVtBwjeYvkrXO0dCGRQio8ulYOd/o6xQ0iakdbaXXv0x4S2K+BSfE0RwTuL1bcVmgrMz0qOkP3ptD8lA/IJLE3CK3LZBjOnilSkSpkPICPuNcBaNR03+lNQD5Fpm/jheNRmdZ4gM67d1LQDdXQH1VOtREKgAq4LYxqWncHESMi1yY9r6hLyLTNn1FC3VZ8mu5vskHuSZVuOW6/DfbtSdv6VcPPPruvPYfsIkpbfRfQ11xLIWE2/1hAszHzC0c5RVg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jEdA8xqQzVpf+aIuSUY52aK04YvS96S2UmcvGrU/h6A=;
 b=UxFhsNfMqlMtef2SaYlHneiQmpGXr+yQyU85rZNOb4r3CRYy7f1VzsHPjjmCdYtgJmEPV6oVHDpCoo/A6KIx/WSN7DJFidCDOPoC5048HvEDqIGLznF7gWnad48lN50F2moZ+6QmvwkDFmzhJwek5z7OxnSClUxOrfNEJD03lpuacCEs3K3VNYxtSmTF2gPEUvbg/yDXTKWGyFhobKRW8lR+fh3eJ+nnrnCuJitvzpxBozL/DROs786Vki1CQgYTJA0UhPFrC3FM6sgozWfSkc41qs5NQcUx/WDWrmTrURHMSnitIlNjZrE2Cr6jcfETZJ1EC5SaN08rQMV+IIWtvw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jEdA8xqQzVpf+aIuSUY52aK04YvS96S2UmcvGrU/h6A=;
 b=lCOvOlTMY8/sflhecBsV1EffJmSrhVpGkR+pdbc61EnW9KyI8nwWmdCvLteQD3518ZJu6r27FVtdlLV+LhGvpZQnV0HVxzsDIRbSf+JwkYbM0Nof15sj2YmstK9kRPhc6ODyq9hZxvAwVRxa3k63Xnp+A+ETClroPAsuXLGNnSc=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by MN2PR12MB4239.namprd12.prod.outlook.com (2603:10b6:208:1d2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.14; Wed, 8 Jul
 2026 21:42:13 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0181.009; Wed, 8 Jul 2026
 21:42:13 +0000
Message-ID: <eea36454-cbbe-4690-980d-b4ec9423f3a0@amd.com>
Date: Wed, 8 Jul 2026 15:42:11 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1[RFC] um: include .fini_array.* in linker scripts
From: Alex Hung <alex.hung@amd.com>
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, nathan@kernel.org, linux-um@lists.infradead.org
References: <20260512232640.1937941-1-alex.hung@amd.com>
 <20260512232640.1937941-2-alex.hung@amd.com>
 <a497ca92-9157-4ab1-982b-4dab4cab2de1@amd.com>
Content-Language: en-US
In-Reply-To: <a497ca92-9157-4ab1-982b-4dab4cab2de1@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4P220CA0002.NAMP220.PROD.OUTLOOK.COM
 (2603:10b6:303:115::7) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|MN2PR12MB4239:EE_
X-MS-Office365-Filtering-Correlation-Id: 23896d24-01dc-4347-e8a5-08dedd39c59a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|376014|366016|1800799024|22082099003|18002099003|6133799003|4143699003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info: dlscKlp+Y+5o6MN3Mt2Vq6rre3Uq9x4Ub0082bMgrykqVaIyAQAgrTqtUWFoaXonv2OwWbhWeVAnIBY2+ZacnAaG99gBxcPc5EPQrOmytPp3J4EyNMf5NMKeIGREVcJJrwYtEpyweO3/9+iZCFiJm86fHgVQi/xMXrwK0F5x7Yrjd/55r75T41O0Liehbod5GgWEHO2uuFOb1h1RftDQ83s0bpVeHeGMSi7ADF2yo6o7V8yH9r9Dk3QKgxqncVd653KsF0Q00f07cSsG8psVSHeJ6Nl+VhvKELMSyC+8vL/M2AwSAjuCWjyU9kBRkwVZNFjmdlaYwnt9Va7YtyN4aEOcdCTnt/ltbbscey5zr/mB9RD2CVfxxonYu4kuxZxix1wJ5PG2sURFFQZ4a/lvAUtHoibUpGm0SpgDO3LJyACnt1QxSKX2PLGZ9Z4nIiQgtEKIhjlSgpqZbc2ELyoODl1/fJDCHBbgwUV7I5J4m+b2D148orP2R84WllC8GKf+GTgR5+qn+YsYIRVARBSDTVakrYc97MX79w3/kyq+XkcZCpBWe6nuyVvSK41LZnsBJ1TJ6Ph2cFO5nxPtzK+dDdd5v8hranmtrrb5+aHHZ3bWrxrSqhdxkZ06zvnZLVt7dNB4tN4vWmnYjBU+5XgLJOQObIXtiRgUVdwy7qyJ1kk=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(376014)(366016)(1800799024)(22082099003)(18002099003)(6133799003)(4143699003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?SXlTdUNmL3FIWks1dktIK3hPQlVKTFREdXd0dm0yMUIwYjFxcTVNQ1FpTFJY?=
 =?utf-8?B?cTdOV052bGp6Y2w3YWs2K0M1d2NqcVQwRWdZejU5bnVuS25Pd0dyK3ltY04x?=
 =?utf-8?B?RS9acUlNL1NZSFllengrMnMyZEJGUUNYSjVmRE1EN056V0R3TnZDTHlSQlRT?=
 =?utf-8?B?ZXJUa0d4eWZNTTA3MCtJKzdOUmsrdmI4SDhNS05BMTNsRUJRTTllT0lJcVdB?=
 =?utf-8?B?WG1HVW5rNkp4aWtObDNPUGhSaUtXR0hHY25lK0hZc0NjdnByQ3lnZkV5eFVQ?=
 =?utf-8?B?VjRqZVd4emk4cXlEWGtHd2djWDJlNEhxU1dRK28xRFIvd0RDeHFjT01HcnBO?=
 =?utf-8?B?dld5RXdyaS9kNjZEUkp3WjZ0azZJUXVBQ1dEbEhFMElDZG5HbkhkM1hqeEFT?=
 =?utf-8?B?bXpURzVSeXFoakFwWUJEU0NsR3FBQXlMeW8wWlNuU3VZbFdHcTgydXpndlpL?=
 =?utf-8?B?S1RvRkdza3VjMjd6bnVyYVUvaUxuU29jWnFsdk9VTk81eG5ONkpLV1BGUmJ2?=
 =?utf-8?B?Y0NBTTRpalA2TmxWUXptZ3RDczB1VUlFNmZJNjVENFg3S0ZOZjQ0VzVvMCt1?=
 =?utf-8?B?c0VLZjBFbm9oUVcvWHdFVHhxZjJHbHVacmp6alZrT1VXNEpSWXNzZS9FSmV3?=
 =?utf-8?B?VEJHdFcybERVNHE2K3BhMlczUWFyWnRndFBoK3VLVkJ5VmRFK29EWVhxWlQ2?=
 =?utf-8?B?MmdYZUU0UnQyM2RNVTFXQ2dhYlhIVnF0U3FlYzNrUi80MkdjTDU3R092dmIv?=
 =?utf-8?B?MVd0Qjg0RjJXa1p1c1k4MDNLUVZLZHVEUUQ3WUJvRFFCb2R2OUpoOStkaXNr?=
 =?utf-8?B?bFVWZHNzdENnQ0w2cS9IamZ1dlZMWm8zNHliZmtlRHVraGZZSzUyeFk4THFj?=
 =?utf-8?B?R2VVdzFUdHZ6NHNkcDcxNjdKNlNleVhtcU1YUHhSZFhLaFZCQndhRk04cG5z?=
 =?utf-8?B?RVVLUnJSaUpOM1laTzlhTEpFTnhTZUc5azYxam56K0dZQUVTL0ZOMkY2dGdB?=
 =?utf-8?B?d2xlL1RNdFczTEg3d2ViaVlFU3JXQVRuZEpkYyt2Nk45WVRVYm42N3BnWTFH?=
 =?utf-8?B?OWRhaWhpTEw4cytSeUV2WjF5SkRKZDRKRVJuYWVKQ2VEMVpza3hsc3I2VlNF?=
 =?utf-8?B?S0JvTWNjN1dFZlpZbFJCYlFzYVArL21RSng3YXk4QVBCTWVWcnhiTGVNTjVK?=
 =?utf-8?B?OXQxclZYR0Y1bGRmMnB2Q3U1VFBuRk1JVE9OemNrL1VhcS83TlVGd1BOdWpC?=
 =?utf-8?B?VU43M0xGQ0VTVXpYbmJxaSsxdFkyeWowV0NqNU1qNlhsdUgrdDZrUU5zRlBY?=
 =?utf-8?B?YXZpRDdLam8zcGlFV3pnOU8rdmRFc1hXNkorNHJuYVdISmJZZDd2cFRHWE5Y?=
 =?utf-8?B?ZGM4NEJvWHNDbUNyN3NFcndtaXhDcmNOM004VWRzdnZUcGgvS0x4eEp5bWtw?=
 =?utf-8?B?VDJ5eTVpNXBsWGFoN0s2VVZOWWJ3Z0tlWmhzNThBQWdTeDhMeklRSUxyclZw?=
 =?utf-8?B?aG5oemtWdXVIWERMaXliMFdPRzNIZ2hZbmwzcjRDTVhocXEyWEJVWjZwZTdF?=
 =?utf-8?B?R1dkeVd5Q0lvRC80TXlBREpySGlKU3hWOXovaC9LS01FdVdCSlNZL1Rxb09M?=
 =?utf-8?B?eGpoQWF5VkJMcFIyRnlpZkJhSkNUM25DUS9yUmVHSW1YQVR0SU8rQ3QxL2d4?=
 =?utf-8?B?S1JkUzJCMmJpYWoyWkZmcU84d3RVQlhsY3R5OWZzOEtINnJpcmZBNzF4c1lu?=
 =?utf-8?B?aU5PbW9nS2VSOXRhSDZOd0JnVjhWdThaMlkwbkx6aElPNnl5SjAzUjNJTllP?=
 =?utf-8?B?RTdRR0xzWlM2cVJJMGNtL0YwaEtaNTErWGNUMmFhaU1nVXNDSmpocExGanBi?=
 =?utf-8?B?S0tZVWFCdEhFdVBwOFVZOWpYS1pTREZJWDB5TVQrSFYrenR1dFJrYVpmOUlq?=
 =?utf-8?B?ZndGcGdaV2VBeG8rVVVTQzNiUjMxSWJUZFBDYXdSd013YmVlNGdxZUNzZlNF?=
 =?utf-8?B?Q0ZqREM4NVNrcjUwUEg1T1NJcXd6ZWNWSjg1Z3daYnhrUS9OQVpFYVNVbmpK?=
 =?utf-8?B?Zk1LOU83RjZBaXpacW1TZmNMUUlEYXl4c2piQ1h1TW81a29Pc1lLakRZRE9l?=
 =?utf-8?B?cXJHMUNkUU0yUHVLWnFjaTZteVdNRFBQWS9iSW9mdVhMVExuQmhucVIxejY2?=
 =?utf-8?B?c3BOcDFtMlBPZUE5OXBBUDVITEc3eFprYVY4bVhvZlladnlpT0liSXVScDQw?=
 =?utf-8?B?dTNhbXJleDV1Y0dXUGJBRE0vWnRSdW9zeTdtNVZXb09uMzRjL0xYQ3Zzd0pE?=
 =?utf-8?Q?Vd5Nd3tcOKOInkcHVt?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23896d24-01dc-4347-e8a5-08dedd39c59a
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 21:42:13.6034
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: NmGxdIjny4aX5E5t3unM/KARq49GYpL7fYd+3QeNL10tHKRqLYITc9fhNqP1cQSwlhQcs580SroqnKvsWN1raA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4239
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260708_144221_699073_C098398E 
X-CRM114-Status: GOOD (  14.44  )
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

Ping for comments again.

I found a similar patch from 2021 by Johannes Berg: 
https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06608.html

Is there a reason that this or previous patch has concerns and cannot be 
included in kernel?

Cheers,
Alex

On 6/2/26 18:19, Alex Hung wrote:
> Hi,
> 
> Are there any concerns or comments on this patch?
> 
> On 5/12/26 17:26, Alex Hung wrote:
>> GCC emits per-translation-unit gcov destructors into
>> .fini_array.NNNNN sections (prioritized). The UML linker
>> scripts only captured *(.fini_array), silently discarding
>> all prioritized destructor entries.
>>
>> As a result, gcov's __gcov_exit never ran at process halt
>> and no .gcda files were written after KUnit tests completed.
>>
>> Add *(.fini_array.*) to common.lds.S and dyn.lds.S, mirroring
>> the existing *(.init_array.*) pattern already present for
>> constructors.
>>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>> Assisted-by: Copilot:Claude-Sonnet-4.6
>> ---
>>   arch/um/include/asm/common.lds.S | 1 +
>>   arch/um/kernel/dyn.lds.S         | 2 +-
>>   2 files changed, 2 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/ 
>> common.lds.S
>> index fd481ac371de..336361412b47 100644
>> --- a/arch/um/include/asm/common.lds.S
>> +++ b/arch/um/include/asm/common.lds.S
>> @@ -90,6 +90,7 @@
>>     }
>>     .fini_array : {
>>       __fini_array_start = .;
>> +    *(.fini_array.*)
>>       *(.fini_array)
>>       __fini_array_end = .;
>>     }
>> diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
>> index ad3cefeff2ac..fbd8d559f21f 100644
>> --- a/arch/um/kernel/dyn.lds.S
>> +++ b/arch/um/kernel/dyn.lds.S
>> @@ -113,7 +113,7 @@ SECTIONS
>>       *(.init_array.*)
>>       *(.init_array)
>>     }
>> -  .fini_array     : { *(.fini_array) }
>> +  .fini_array     : { *(.fini_array.*) *(.fini_array) }
>>     .data           : {
>>       INIT_TASK_DATA(KERNEL_STACK_SIZE)
>>       DATA_DATA
>> -- 
>> 2.43.0
>>
> 


