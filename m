Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E011C5DF94
	for <linux-um@archiver.kernel.org>; Fri, 21 Aug 2026 15:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0b2mZpjtKB4Zjq3lb5uZ7pGhm14/S2HyekZjUpYMYq4=; b=OyWsUrDNuPvIiMKvdqKVOsAUoJ
	+us2avybw0T0Jzp8Rx8jaKlRGmzP4MJt18bMboo55lfwqlAr8Hs8Nz/vFY+Mqcy0FYoOHCjVw0t5s
	jT37l6g8L8UoCfjt4tPpR9LJFboqUS+JEpsWq+zzO3U9SoRnu1WVYV/Ve2MxTZiVvQGEcgO60C8xN
	I4U4cD3ZUj1ogrr+UZQ+M7C+NOZdmXorcLmmwUdqwDNfsKiIkkF+FVuCIABjNPmzNbdPYRdtLx3nR
	/tOgwflDcADxm2YG9fA6zFv8XYMEZMxJ6za/wM1YPp5RVnkcvkG0dC1+3Nq4ut+vjDQYx0xh9DX3l
	2Iz+MZGg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxR8B-0000000Dg4Q-1S8v;
	Fri, 21 Aug 2026 15:26:07 +0000
Received: from mail-southcentralusazlp170110003.outbound.protection.outlook.com ([2a01:111:f403:c10d::3] helo=SN4PR0501CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wxR88-0000000Dg31-053k
	for linux-um@lists.infradead.org;
	Fri, 21 Aug 2026 15:26:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=xTF14BekxX0XzAmSCAtjWoJuMAIno4xCklWjTfvbHyaNhwmdeTvXARv0gqfknEhNnW7hfj0gefg0cgPh8Byag0EEqAiYKVyG/lfNiJl1uyDjGdXgONC+P9+6MepSxNKWUlo4c2VBXZGwIlFoumcq/alc7yfdrdlFZ9Z5gSX3bcK4gLjOMMhaaxiNKfyOOZ22xW/6fwcccr5miODHd8JFCzAu9UIn5v8dtT/Kh/O1QjTy9xdDG4NVefDBe/dkGYTCDP7j1X2sreTs5+yIIyUgZeSz2d8kzT46jbSbOoa/rzS5bro5brNIRX+uusrHmNXohGU2rXl3aE6ZGzip+7GsjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0b2mZpjtKB4Zjq3lb5uZ7pGhm14/S2HyekZjUpYMYq4=;
 b=WeS4QNf5KYVmnECU9kwjAmJrmZCbjGPjADH794qDmELC6o3+0sRXlinFrhd9teBVm8vX/9GjMO9HZx2kJmtXnJ9dfg5t+JE6A5YR/6DBtev2pluho9pF1dI4MtgG8ukoUs+/BKajh4iaSyX9TPS97t/c5I80GifOUXcLExXZV8cbyq1QfXanSMQWZxGWmzRU5QRDV0MVFLSkzNfIM0gALx+MGq3NzgTCbnBZh8kj99VqmyHZZ00HjzKJeygcaM5tuVkviXTmCHkct/vukak7PMZYyp5y9sNm7PhfRURji9UBbW4OWCHdGQI5veq34aitxRPROvqEazjLfUwhKzhCrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0b2mZpjtKB4Zjq3lb5uZ7pGhm14/S2HyekZjUpYMYq4=;
 b=ijXcz1Hqexyr23w3ZxFCA8j8ZP1+iFy4sqdqGExPOKtb5uPCpbBv7bb2R98IkckD95LRrZR0usuwLB5AbUVYQaP2TVMh3gkWTH7oVZDKi599+nOUgG9JUmfPukPI7kO/40dm/tocAP+dBywe8sCzOwfA16Qs6sfPlWpnmuDYaQA=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA1PR12MB7541.namprd12.prod.outlook.com (2603:10b6:208:42f::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.11; Fri, 21 Aug
 2026 15:25:56 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0339.010; Fri, 21 Aug 2026
 15:25:55 +0000
Message-ID: <0d3aa5ae-7c1e-425c-b386-12e605f1c983@amd.com>
Date: Fri, 21 Aug 2026 09:25:53 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: fix CONFIG_GCOV for built-in code
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, linux-um@lists.infradead.org
References: <20260727195515.2306731-1-alex.hung@amd.com>
 <a77a9f06-fa26-4687-9722-1e54dc771fce@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <a77a9f06-fa26-4687-9722-1e54dc771fce@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: MW4PR03CA0303.namprd03.prod.outlook.com
 (2603:10b6:303:dd::8) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA1PR12MB7541:EE_
X-MS-Office365-Filtering-Correlation-Id: 61e0c1c0-8906-45d4-fd9b-08deff987e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|23010399003|1800799024|366016|376014|10067099003|56012099006|18002099003|22082099003|11063799006|4143699003;
X-Microsoft-Antispam-Message-Info: aveMLNKGZyzSsPnmCcCcP+7a8TQ7gbMHPzPM2c/kuoaa6R0xRtHqDL4sST10rUo9Nriy00Inv+plApvQlBgLX9Cjwocja06uWalCGrcGHzHseLIzveX3Izc5ECV8YmMhUn7RoLnDQdNYIUbhndir5j6I76L0ZrjJ8AAZh8vvdaEKVh7aTFGwD0dAImizNw6U0MuSq8Sa003hMHzZWhUiyIAJ8FhnLPLHvUqFyI0kPnOR2ICJUEkaFgxjqKwVn4qEUsrx9szN70iz5hzn/wiyz1U8OQ6zdB62cBupD24+jU2CxWlvkfmJQ4E5n8u0jXOA974cEOoCPt2gwIyRtEmycQ563nfb2J6+DCd8tqIeuGLDwUal3tnTo0UVngECWcreaBShlxlFjl31Z0EvCOQ0BcuhLcM37JWhO7VsICBgHMM4Jf7JDCTRM4d2HJfJPLETKi/fUinm9ngrzkmEGWDmaviQTwvW1YBkjLPstFUwTpsqrPBcwb1OLcewx5/w3YY8/KFVJV4efYzeWsDVYd3IzOLRkMb8G8kaMDT4hrN76AUBTzBfIVgBEU/0Odg85IOc6y/pthsSVSAyT46vq1Yof2EfI99uAulT4kj3Q/6u9zJ73z4pymqr8fjaiy7QZAS8b1E6H6NymyRdq3OBkPNdZnfOo0lnjxhDeuIu+TPWXeM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(23010399003)(1800799024)(366016)(376014)(10067099003)(56012099006)(18002099003)(22082099003)(11063799006)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?czNJRXZ4UnJnR0VsNEZBVzYwTHp0aXBPbWNHM29qMFF4Z1VvSXRPWkp2bm91?=
 =?utf-8?B?QjNGOEhFTjFYRTFIWlltNnZoNWtFcjNrYVhaVTJRUTczVkNqWjVjVW16d1pj?=
 =?utf-8?B?dndzUHR4U0x1bnpyYmM2OW1GMGpsU0RJOHdVSEQ1L2szSUZkd2puSW9hMFI4?=
 =?utf-8?B?V25KMENOaGlsR3NtVTg4cU5UK0R6RXA2MFczbVFBSUEyakdGM1dsbjZrQUw5?=
 =?utf-8?B?aG0yNXQ5eVhUVG82VnRzaVdPcWNRVFhnc0wvZngwbmFDdE5valJFQVBmMUxT?=
 =?utf-8?B?elVQNHJ3R09BdDh0QUlNNm9Ed256b1RCS0MxczdWbm03TktrcktGVjRQNk5G?=
 =?utf-8?B?NjE0NWtKQlY2eGRkb2gra2VsYUs0K1hYUXJCYkhsYkVrOUEvYzA0SHNZdElm?=
 =?utf-8?B?bmF3Rkw1WUZ2eEROZGlaUmdDUE5nRXpsSnpnQUNOTEZ5QnFxK2t3eHlqV2RB?=
 =?utf-8?B?MHZJV1NUYU42OUZTTlJOemllYlBEMjNNa3ZUVU9yM3lJTkRxZDRPTm56ekNW?=
 =?utf-8?B?Mm1JUEJpOGQxU3U1b082RCtENzFLZmZHYms5d1djeWx4SW9QNVVsdFZ6NFNJ?=
 =?utf-8?B?dHljRmowd1dGRWJqUjFvT25aaFZtK3ErN0ZpMnU3bEFxUUNnMHpDaHVTaDRJ?=
 =?utf-8?B?MG9vMndhVU14dldmY1Q3RnRycXEyS1FlYU1jKzJnSDZPMm1oSVBacFNBQVFZ?=
 =?utf-8?B?a1ZWUHRjZVJBM04xR09WUmF5Y3MwTGl2dTlwdjFiK2ErU0RURGNSaUVXVFV2?=
 =?utf-8?B?VXJ6YXZtZ2pEL0NlcXM2cGFUTkxTMW83SG5GU3pqUm5mZ09UTVorTi8wa0M5?=
 =?utf-8?B?VlZKcU41SGlkUE42ZzZDWjJGcmYrVEIzcWpDY3VwOCtTaDVjMGl3WmROTERD?=
 =?utf-8?B?clJRREM0V0Z1WnlGb0ljVkRQWDg1Q2NsRmJOOWF3aFhPcHhCOEI1U0Rqc0tX?=
 =?utf-8?B?ZWJoOXY0d0ltMHdzaVN5TS9wajBFU2xaZjVqc1FlbnVqU0pqaUZDRFdOTGg2?=
 =?utf-8?B?NFJLaU5ha2ZBTXRzSXp0b0xXdFR1QzJqSlVPSkZWV3JiekZ0OVNIQlh4U0VC?=
 =?utf-8?B?ZkY4U1hxVWNYNVZ3SGo0WmFMbDEweTJteDVyUDJvZGs4MFhsTDhBK2luRmt5?=
 =?utf-8?B?bm4zaDhwTVFqNGZKRko4RmxrMnE0eTI1RlFwcmxlKzF5cUs1dE5XYmNoT3Z6?=
 =?utf-8?B?cE5DZm4wMEptVUdsSHFBNExhWnRTU0x0M0F1L1luWWVMbGNPS2F5dFFrRGJZ?=
 =?utf-8?B?QitOR1BOaVlPY08rM3JHRGtiZitJQm5OOXVNbjVzVWNtQ29QRWdWV3hnbHQr?=
 =?utf-8?B?MjRDTlBjbk5mRDhibndTVW1tbTNUa2hpeVFGakM2SlAyMWJHWHhVSndkVzEw?=
 =?utf-8?B?QTNJSi9YL2UrWTVNR0wyM3lJVVNranBOM1BzcjZzQUozUEtmM2t1bGxTZ3Z5?=
 =?utf-8?B?YmxHOUJXVzM4RW1YejRxZVIvbUtFem5QTisxUDlKVWM4eGJ5bFdtTVY4MzdG?=
 =?utf-8?B?WllzWnFJRkxuejN2V0FKRVZRbGRmVjJPRmgwK1hwWWJDVG5VTEJrWE4raWly?=
 =?utf-8?B?aFppcXlyNzdxcFZBTFpTUTkwbC9FamU1VkIyZDQ3MnNrSk05TmpxZ3ZtdGs4?=
 =?utf-8?B?Yy9acG1maVFsT3BGVzJNL2lVRVBmdlJqNWp6Y1VYb1BnY1BaQnBZMkNOcGVP?=
 =?utf-8?B?UVk3eEZOOElIMGkvK3U2Z055VmlLZGZnek81VVliQitVdjFrcjIyTVJEdlg3?=
 =?utf-8?B?OUd3bjJ0ZW42bCs3SlpienZKTHN3VjVYVlEwb0EvRFBZYnRTb3dwVTdUaWZZ?=
 =?utf-8?B?OGVtRVR4MHpyNC9HdGt3VjVhektoeU5YUnhxdUdYS2EzcXF3ZE1NZk94NWlj?=
 =?utf-8?B?cTNTUVRzLzVjWUc5eWJCZEpwTHY5YW1uTi9RTWppZm9yVmRueG05VG1UNklG?=
 =?utf-8?B?eXJwbnJ2ZVFOU2pSSUNaUGFNandBVDFwdU9RZ1BlQWtRVTMwUkppMWIvT2dj?=
 =?utf-8?B?b0luNjhUOGM5UnM3RjRYQzMwMUExQ2JtYnMrNStQZmM2NmsrV0lqLzlZWDVU?=
 =?utf-8?B?VEF4eElRS2N3b0JhWTVCMHdHcGl1bE10dlBNeWJ6NXhTZ0FxWXA2aWpnQWph?=
 =?utf-8?B?MU56TnVJK2RSYTh3VzMzUDhSQ1hBbjEyN0RrU00ya0Zjc054QUxhTE43bWZQ?=
 =?utf-8?B?SmlLelhaRGZ3dWtPMjQ4SGh4UW1hTGxlZnZtM29QcHF0WERkVFVzbkNNK3Yz?=
 =?utf-8?B?V2g0K21RWlBva1lJajBUejR1aG9xeFJyQ1IzeGpzWFAwVFVuVFJ4UUZKQVRm?=
 =?utf-8?B?OWhXZzc4dmU1R3BVTzhCZndJUisxdStPYzlOMkJqV09OTDRMOVdRUT09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61e0c1c0-8906-45d4-fd9b-08deff987e13
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 15:25:55.2284
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HWIv5x45ZmTdzSodPLbL9QGt5VJwUrDVAZL6kwezzYwi88hQQ02Aj78R+Y4oSknQWeec7inr1xRhSsgvVteTEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7541
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260821_082604_062311_CCDF302D 
X-CRM114-Status: GOOD (  16.35  )
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

Ping for comments for this patch. Is it possible to merge for kernel 7.3 
if there are no concerns?

On 8/10/26 07:51, Alex Hung wrote:
> Hi,
> 
> Any comments or concerns on this patch? Is it ready to be merged?
> 
> On 7/27/26 13:55, Alex Hung wrote:
>> From: Johannes Berg <johannes@sipsolutions.net>
>>
>> With contemporary toolchains, CONFIG_GCOV doesn't work because
>> gcov now relies on both init and exit handlers, but those are
>> discarded from the binary. Fix the linker scripts to keep them
>> instead, so that CONFIG_GCOV can work again.
>>
>> Note that this does not make it work in modules yet, since we
>> don't call their exit handlers.
>>
>> Note: the .init_array.* wildcard and the RUNTIME_DISCARD_EXIT
>> define are already present in this tree; only the matching
>> .fini_array.* wildcard remained to be added.
>>
>> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
>> Signed-off-by: Alex Hung <alex.hung@amd.com>
>> ---
>>
>> This is a revived patch. The original can be found at
>> https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06608.html
>>
>>   arch/um/include/asm/common.lds.S | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/ 
>> common.lds.S
>> index fd481ac371de..2ed213913afe 100644
>> --- a/arch/um/include/asm/common.lds.S
>> +++ b/arch/um/include/asm/common.lds.S
>> @@ -91,6 +91,7 @@
>>     .fini_array : {
>>       __fini_array_start = .;
>>       *(.fini_array)
>> +    *(.fini_array.*)
>>       __fini_array_end = .;
>>     }
>>
>> -- 
>> 2.43.0
>>
> 


