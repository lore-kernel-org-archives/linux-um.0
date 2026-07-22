Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ACB74C44532
	for <linux-um@archiver.kernel.org>; Wed, 22 Jul 2026 16:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0VVeVyywSfaplQcRimd2hELDSp+7w9Fl4zqqzpOdXxs=; b=U8B5pI25hzax9fecMj/oph3Cnc
	EiCFgV8l7St1p/JHAgpdumYSGNd8+BmfxuCg3d2I91rm8DIzw7ad+KKLZHt7y6d8yP9ipYG699pKu
	CsBq9VrUm9qjdHd+Zn4UTW/R3f3n0mlledwJ5SVUCLDoxeVVVT1ArOdNyIG8ILj5nqRlHuokfrzAu
	5Q9vZpTF/7jQ6pQGkcn6n22MbIdQ8jNYHhITLq3mmnkYaV6PKqicgxakfSK4ciGEi85pO6qcXbz/N
	FCBX03Eq7aMDY4xCKYQLCNLFb663MO0pdB5oqeQlRH7ESiiFSqJ5iOfXTIbl8ExupJdood11oyYj0
	5dyb3iRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZVX-0000000CHyq-0yT0;
	Wed, 22 Jul 2026 16:09:19 +0000
Received: from mail-westusazon11010010.outbound.protection.outlook.com ([52.101.85.10] helo=BYAPR05CU005.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wmZVT-0000000CHyU-3JkH
	for linux-um@lists.infradead.org;
	Wed, 22 Jul 2026 16:09:17 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=zKvesGIjDnZv5AeFhDUeMOBZrQgtUKmzLQ+0N7S45rQJimNKt5Z+0MprdEAEJY5nbWILPBjDRBifD2zs0B8DCj4CsPPKQd8S1J6gNHMtZAwS01WUdgf3t2M8tydoSCE9fuYO5WtH6UNFszqgldUhisxnr5NvZNMNYcN94d/tiWjd7PuHlkj204wACfoOTo3TqZibEl4MG52ae/ZbdgQXXhaWJpdLqmcW3SX5zkzXsmuzZDy/uG/wq57tWQUxkUdWXIgakDQDrAyTaYcnYACmkn3DEBKPBSI9ICDK+Lor4JpKKBgiQqGudmZrCnND4zWs62SJkCvEJg+zEVPZ7nCXrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0VVeVyywSfaplQcRimd2hELDSp+7w9Fl4zqqzpOdXxs=;
 b=J6L+WSK4EuDMGUJQWxFakqAw6MArkwUjX7YjvEIN5sdjTU984LrsLeH3vv3mSUSmMivjZoSR5BWla4PhRD09/MJUF+Q68AJEIcvElPM6sNiZMlNDCvOu/CAEV1vCOf049G/9C6MBN/6DMUk2O18xBKnyPWeMtgHqCu15AQYQuNDrBds1FTlyoCAUwAjGTCik6TCgBH6dsCuVnEhdfJJCjYdBWFo2CC4iRg6vViRPQhIzxAxumvhhAMe+cNpxdHNklsp3W5AdRE/B/QpPZU2QLAfhShcIih8zN1FDl7jBScGLQaxgVy/rTZZziBVz74/oNnBfbBGETkFRFzNv52jkiw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0VVeVyywSfaplQcRimd2hELDSp+7w9Fl4zqqzpOdXxs=;
 b=EkW3LekjuZOCwmnX6fZC19BgRUL+LfTT8TmlJ7z7rbl5o9chEwu5/YoB7/YISppIGsPPjAB7THiKVI0q1jfUa/oBVi+CPcIxUKexqyNNqT62zAWCLlDkQDUiVE4Dm+I83voOMr5sxSjAijqZqXyibQSAmDNzk857cZbJAxRpvuY=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by PH8PR12MB7181.namprd12.prod.outlook.com (2603:10b6:510:22a::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Wed, 22 Jul
 2026 16:09:08 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.009; Wed, 22 Jul 2026
 16:09:08 +0000
Message-ID: <313f6cf4-91a1-42e7-8e19-d2883c5c4f73@amd.com>
Date: Wed, 22 Jul 2026 10:09:06 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Allow multiple symbol definitions for GCOV builds
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: Bhawanpreet.Lakha@amd.com
References: <20260708224006.3405038-1-alex.hung@amd.com>
 <743d1be771381c86c7f264810d88876976cc508f.camel@sipsolutions.net>
 <75f2f98c-78df-46df-9961-6ddf2870d044@amd.com>
 <8b710b01b8117d41281595265da43ab0add10214.camel@sipsolutions.net>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <8b710b01b8117d41281595265da43ab0add10214.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0226.namprd03.prod.outlook.com
 (2603:10b6:303:b9::21) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|PH8PR12MB7181:EE_
X-MS-Office365-Filtering-Correlation-Id: 7161c957-ee45-40e9-25be-08dee80b8f33
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|1800799024|366016|23010399003|376014|18002099003|22082099003|4143699003|56012099006|10067099003|11063799006;
X-Microsoft-Antispam-Message-Info: aw3bEAbzgiSvLZxrNmdkx9imLQj8rROPnfOvve6s5fpjW8Qo5IcQp9+RjIezqUGR1kYcxWE0bUPsdgiby7AY14i7D9mQv4QbcltHvAmXJ71sVs9JdDc07tZHnQ9YRIQihT9Hj7tSM/6HrbaF3GscmGfMNobdJm4LyW1DZOX/BVXPBDvcbK/lAsFNEkRM8M2pF2DBErVAMz42/NPFdmsXspzCd32Gg7ZDG9Zsp9/Oc7faXb4VDv/AHiXzlO491XojYX1cG3t10Nqvt6r398qxffJaMCgTjpQBdHgwrlqpB5hSJhUlZUW04XHXGj7l5HwIItzvoJQb0WNnRl2ZgC5R7HAujpFBPro/R8rAiyDxItMQ0WKoiuIvQplHoJVvxByUe/GyHKpkBr0aP5WINEjGWnwaCkV//BFAG+/2v2jn2Ekdm6xD5qUrmrQBcOqIaPgipWD66czSTJcfF2RK/i7H/ZylQna6ZtWu8VKpbK++MdsIbnyHg7RRXAI3cSfVKXYU0NByspZiboLXrwQ+eJkyAEthANtNyJH7EVIYAxhTwnqRdW2o8uDacXaYrPH4xAw1RDLbZ3NXSmvkUaf27EpE1hRX/WkZh7fsdv8eE9ZlvLRsw8COnT3nV+WZiKfELrvTqQUlJieijBIN+KvRKfAUNVL8SBtIxltlWoqbMrq7n6Q=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(1800799024)(366016)(23010399003)(376014)(18002099003)(22082099003)(4143699003)(56012099006)(10067099003)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?UllwOThKVkRUTGxkaXBTcU9nQUVtdTB2TjFTMzRTMXBRemlrY2t3YStlYlpo?=
 =?utf-8?B?WTVGNWdBQVp1ZmVWbllWMWZVd21ybWZsOUxqTld5QUpiNDZDQUdkUzV3TTN2?=
 =?utf-8?B?QytFSUNFR1d5M21HOUowSE5NRjU5S3M0Skk0bmVObHpOdmlpTlhwbVNKRjdh?=
 =?utf-8?B?TTd1UkxNWlpBeXhyZ0JzRk95bzFSMVRKa3F2ZzdMaFYvdlZRS2w5RXFqQ1F4?=
 =?utf-8?B?YW5ibjEvdnRNMzlPVVZyM1dWcUVydnRxWE1JUDdtNmh4a1YwNUZEVzBrZkZV?=
 =?utf-8?B?ZXFRbnJKZkpJektycHNzVUFpdjRsQlljeHdDNUZrc3B4U3hlTllnS25GRGRs?=
 =?utf-8?B?dThyUEl6VGpJbHVCSXczYktDYmZIUXBPSFY3VzNQSGdFcmEzT09ucENLVU80?=
 =?utf-8?B?NzMxYzdpclhYb3RVSjFiQ2pwRmtmMDNuTjZrbWFuNEtDSXRGbGdFdnRXT091?=
 =?utf-8?B?TUFmQXFpTEZSZHo5anBwVFhQcWdKY0ZpeS91aUdtNTZKNW1ZUUN6blk2YTRn?=
 =?utf-8?B?YXB3ODRtelhrYXlaNkxHcE9uL2hKY0hlK3ZNVnJVM1RzS1picW4yQ2NMOVZW?=
 =?utf-8?B?dTh3ZDdFU2ZmZVpuNm4zU1RMamNpVE94SWRRNmZWL2JmcDVKTGlFdzRWb3Bs?=
 =?utf-8?B?R08zMFpLOE5PbFI1ZlFLaVR0YUNIditVbUJseXlUZnlPcmMrWmIydzNLbmdo?=
 =?utf-8?B?aHpKdyt6YTFrdlROS0lxOHVCM0RiS0tNOHg3YUZ1VWErVi9JSjBNNVpZWUZP?=
 =?utf-8?B?S0NhYUJRVVdzbCtVb3RlUnZpMDRNbE1oRXZRK1RVMGFYZDRCcmZtdjZZUVd0?=
 =?utf-8?B?a0VrUHdRZElYRjh3eTNUYjNJSlBHc3lSTkN5WmZ3eVJUcjhva2ZaN3JlZUJh?=
 =?utf-8?B?V2RYZERYVFFDRXBXdldWMVhVREpMS0tXcnM5NXlzQXFYaDNwNnJSMW80Szdj?=
 =?utf-8?B?bjZtZTBJVnVZTWcxc3hmQkR1QURIWHM5dHQyMTBaU29ZYlBqd0FldHlFZ1ZI?=
 =?utf-8?B?aTl6dGVLait4WUtjSW1LaklJR2VYVDZNcUU3RjdwOThvSHcySkxVTmRpRGNF?=
 =?utf-8?B?QXdvS0VnM2JTWFVta1pnTXlJU1krcHVSQ0NiaEsyakdXbWRLMXE4ejRCUFpB?=
 =?utf-8?B?RVo2UDJvQVQrWVJLcHJTQzBOS3B3TldIYVltTTY2OWdJZkpUc1BWS3g5KzJN?=
 =?utf-8?B?V2JkVWQzWHNtL2RzbzBJVE9XSndoeHMrUmJhcFNzbElwdVk5Mml5VDlQMUo4?=
 =?utf-8?B?YVF5L3VCUEtOZEhHTGhBUDlHdWZVcDNZUkpzM2dkQ29pZTNSUE5TR2UzNnNo?=
 =?utf-8?B?T1RsUEE0ZmZjNGY3ZGRXbTVGOGxja2xabFViZHd1M1ZONXJIZ2J2UGhNSHQw?=
 =?utf-8?B?aHQ5UkxETDNaMWJjNjg2Q0VQcG15RnBmU2diUThldWQ0Y2FYOGVNd1FUcnlB?=
 =?utf-8?B?L0hTNnRkSWlTK0Q5SWlyRVkxdGdBR2FsZXluVUN4ZktTb3lQK0ozNk9kcnZq?=
 =?utf-8?B?TmdqSFhiZ0hmYjFZd2ZScGdMWGI5SXJWWElEWnh2dE9ydE9aYXdEV0l6Tnh0?=
 =?utf-8?B?aTVvd2NsQnlyUk1GRG5wemlKWUxuZVFVdlpWejlYYWdmd1pTM0d2TzNLSjBz?=
 =?utf-8?B?eCtGZnFWaUR5WVRadnQ1UmQ0a1FPSDBKb3Uzb0JOTGQxZzN6VHFPcWtSNVFr?=
 =?utf-8?B?bXZ2NlpKTnE0UFFUR0FEVWlnWkxKZzNFeUQ5eFFtdnpPUURmL0RBYXVUd053?=
 =?utf-8?B?V0R0aTV3QkYxMG5VQ0Jzdm4zQ090WlBhZHkvVTc2Y20xZ2tiVzZ1SytQTnh0?=
 =?utf-8?B?Uzh0c3ZBNElYQnNsK3ozTGJlNDdxWkNiQVRDZGdNNWplVVVLVEZTTUI1bThG?=
 =?utf-8?B?cXVVZEJibnBWc1k0WkNpRlBZdjNoL2ErOW00QklDWEgwMDJMTWpSNk0xbDhJ?=
 =?utf-8?B?U1Ntb24yNmY4Wk1UMitHSlF1WFdzNmhSTmk2NW5oZE9QbWpEQVp2ZDIyY3lm?=
 =?utf-8?B?UHVQc1lQVGo2WjM1QzZnRS9BU2dpRDFrYnpNYTBVc3VKQTMxKytVMTAvVncx?=
 =?utf-8?B?TEgvS3JHd3ZMTS9jVHlkdWJCUEZYb0xNTUNFd2NqOXNmTjU3anlod0d6T0E5?=
 =?utf-8?B?VjVQUm12cjdDcDdZTkhwTS8yZWhpUmFCQlRFQndzMERBOVBYVUcrZ0FxeUJQ?=
 =?utf-8?B?MjY1eHF3MUJ6MDFsWWhnWmE5NldPZ0VMWWtxeis2SHM4bWNTd2YwTlF0UVZX?=
 =?utf-8?B?VU1HSGMwVTQ1YmtQOFUvd1pmaUVENmhncFlZb09Ka0ROUExWcUQvcWN5WnJ2?=
 =?utf-8?Q?GSGkSmr2pZWu47gzKk?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7161c957-ee45-40e9-25be-08dee80b8f33
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Jul 2026 16:09:07.9912
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nRrifzxzlx6PfWTeW7ltm5YjSu6EjIMp1/TqWYgKoByf2ywC6Mj095jDk2RbXrlSDbsXWr8qPRqH38iVP9CejA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7181
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260722_090915_854361_0BB08FAC 
X-CRM114-Status: GOOD (  12.20  )
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



On 7/22/26 08:02, Johannes Berg wrote:
> Hi,
> 
> On Tue, 2026-07-21 at 16:23 -0600, Alex Hung wrote:
>>>
>>> I cannot see how that would possibly result in correct behaviour (beyond
>>> being able to link)??
> 
>> Good point. --allow-multiple-definition silences the linker error, but
>> picking kernel or libgcov's mangle_path() will break the other at runtime.
>>
>> I saw your previous patch
>> (https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06604.html) to rename
>> mangle_path() to seq_mangle_path(). How about reviving it to avoid name
>> conflicts instead?
> 
> Honestly, I completely forgot about that. Looks like I ran into the
> typical "nobody wants to merge it" problem ...
> 
> johannes

Is there any concerns or blockers to merge them? I sure want to revive them.

The series may also have a solution for the other patch I sent 
(https://lore.kernel.org/linux-um/eea36454-cbbe-4690-980d-b4ec9423f3a0@amd.com/T/#u).

I will test the series and report here later.



