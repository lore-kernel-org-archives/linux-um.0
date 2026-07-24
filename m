Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08E3DC531D0
	for <linux-um@archiver.kernel.org>; Fri, 24 Jul 2026 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mb/k1F7KuX0RBYyZlKFXkchaH/7jfPMm3RjMjaDny/0=; b=jp46WGajVyXRS+J918s00u5XzO
	1YDSzxH6q05fxdZYKH07woul7/uvGewjeaHy6hAsjmwMec8mNOo0JJfFht22OApqWyl35lKhSSb22
	1pJCcguALf7V2EGVBAJTGKqU8xgo3ec1Q8b/eyU5PcyZiYCNoFcFOqcjXOS5lZeU1jbD1tMfiF8iX
	DG/+Z0HzGpGxLewwZMb1cdpNHpgTI/2XEqFh5rYggfmyoZlVsVirRP/Pa7/wpIhCeWHSOBgs8DaaB
	aKo8qMxbIKFt7VVhleCtySbyt76zhs9j4FWRgjGbvhR23K0R9s8YGFJ1iuseQX6KJIPjyhPALl1Qy
	11R1nNUw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn41n-0000000FJ6y-0U9r;
	Fri, 24 Jul 2026 00:44:39 +0000
Received: from mail-westcentralusazon11013017.outbound.protection.outlook.com ([40.93.201.17] helo=CY3PR05CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wn41j-0000000FJ6c-2kCl
	for linux-um@lists.infradead.org;
	Fri, 24 Jul 2026 00:44:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=MgdTkoI91dwCXKfp+HdM9ILZV+npk5EvZN9MgZKlqL+gZMGa2LzA2g/sg6oEPOVdoLFNI7SyvGlFPUQNS76F8zziGjuqteNkMprmkF+Jc6FT3U5U46dwfw4cVTuTPZzo3oc2kwV9EU6S6F2ZXwX2Ghv94gnNox2UM/J22UoM02Pf7SXkJ0UqDHXxQvq0HwF+631i6BUARRgVUCazajx6dbfNSAjBcMF0ieTRoWa/zO3FGPxInFLqMmX1PedAYxqLuPl1lTNovWQzXH5joIIn63q3Ifg7pMt0qV8lwZ6Gq0Nw3tAKGwXKNUfjG/7k9cK6XENf7ivAENsDMsUQqvs1OQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Mb/k1F7KuX0RBYyZlKFXkchaH/7jfPMm3RjMjaDny/0=;
 b=ev8xedum+Odc8uxMxMMwo6FpObOO8DdYdZx0e7FWiq9FBVE4TIObo/L2Qag9+Gx8F5Bl9sLHFRygy3BaK2Q6kpGxqy3VVdL5WjFkqEAa2CY+gRVP2T+zCor+XeIxwDEILBP8TuJD8k/ezB8nYM/zy1jZPxX9NMwx3pCk6nxIteKJkTGCUhusJpeswKdoJsDn0UK+2aoKR5u+CxDVhig3OmgQeSvXezonxDqsn3nYDgCwU+BNCDoGLIhjR43AnRlixhc7lqDIJ37EvXap16cQLH2qjnpujpZ9wDVdO19Noi3WF5iOnjaC9XsPXBWWDdXnAKDv7HTLInjTinOwrtvgHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Mb/k1F7KuX0RBYyZlKFXkchaH/7jfPMm3RjMjaDny/0=;
 b=48Zs0FH0UxK89MHXCofwhl+h1EziuBJwJrJdMyvefFnWUjRju4lOanzseHCItMU3GzBFxhkQJC0UE2jQOxGwSCQW+a1bIdnshKF21KOSM37l6r4NXh3zbLglZTUNpOHZ0fKTOkJJYZIlqWJmAgi+Bii8o+QTWKSw9LPPN8BjsqM=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by SJ2PR12MB9212.namprd12.prod.outlook.com (2603:10b6:a03:563::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.10; Fri, 24 Jul
 2026 00:44:27 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0245.010; Fri, 24 Jul 2026
 00:44:25 +0000
Message-ID: <13c06f83-ffb9-4834-9112-6da54a93ecbb@amd.com>
Date: Thu, 23 Jul 2026 18:44:24 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: Allow multiple symbol definitions for GCOV builds
To: Johannes Berg <johannes@sipsolutions.net>, richard@nod.at,
 anton.ivanov@cambridgegreys.com, linux-um@lists.infradead.org
Cc: Bhawanpreet.Lakha@amd.com
References: <20260708224006.3405038-1-alex.hung@amd.com>
 <743d1be771381c86c7f264810d88876976cc508f.camel@sipsolutions.net>
 <75f2f98c-78df-46df-9961-6ddf2870d044@amd.com>
 <8b710b01b8117d41281595265da43ab0add10214.camel@sipsolutions.net>
 <313f6cf4-91a1-42e7-8e19-d2883c5c4f73@amd.com>
 <a30db44d0711d41065b1407aa5c20e062fec890c.camel@sipsolutions.net>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <a30db44d0711d41065b1407aa5c20e062fec890c.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0242.namprd04.prod.outlook.com
 (2603:10b6:303:88::7) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|SJ2PR12MB9212:EE_
X-MS-Office365-Filtering-Correlation-Id: 55cd927c-dfa4-4594-1637-08dee91cb615
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|1800799024|23010399003|366016|18002099003|22082099003|11063799006|56012099006|10067099003|4143699003;
X-Microsoft-Antispam-Message-Info: KiMWWWDdr6jCr8RYgmRECzIcPZOIjTcbsuhduRQlt9VqMx34y/6OIEtMZtPyOcyNP7np/lk1nZO+QPP2pHcQNmbsUavIMiarsWbOWhfpXBNve94hFf/SrWadkQv+K47YXAiFKiLL2UTtf4h4llkKaq7ynOfKG294f8raYKf+NuXJ9d82YGHm/C6g1StUrEP5auzrxNQhfTkqmT0N3n+hV4xbkqBCdfn6ul0Pc2GSG7vQPFRo0gshCQtPEY9e7u0SFUTKEBr26eIUm60Op4D8VdRWOeoMP6yh3zG4/Lw0RRIaZk4nwGK1jmUYg2/QAN3jN79JmMyky35Zvaus4TutUhuc/TscXAhkfqe48zcWmrpbx+ObKML8Cu4ry6a5W1zw6DzCAxEtgup4664I0DjIgi0NkPJoX6x1ACp5nzFwaOawNhXObwQbrpAzQ8MPzq9VBXnjcnbiwt0sXFOm73gbemD/Kai4fZrmP8zv5aBPNN42w3e5SxgY0ZuK94LrKD+2WTY+YFCM+jY4MSLkxinTd0V3u8yqf1cI/kfsXwVjg0P34ih1i/MaL9y68jvKjuEEaaRSEB0VV2gAfZQy05cti2MWbRwUvSJBkRlv1jYHUfoftE7jigxF1YeoHfTNXKc7M92T//TNQ3KXkeGcEc84EODJ7HaDc+MfL7jNHLjX4g0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(1800799024)(23010399003)(366016)(18002099003)(22082099003)(11063799006)(56012099006)(10067099003)(4143699003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U2pYb1dNOU45dkV0ZmlUallKUFoxczBPK2NsbWVhVnNEd3A0akNXdXdOYXlw?=
 =?utf-8?B?MjdwczU3aC80ZVQrWUFSYXlZMzYyS1kxdFlabndmaldFVjMyaGh4Qi9INkx6?=
 =?utf-8?B?TWdwMFJzTG5mdGVnR3RaY1JSWmJPdFl3MWErRFpJNDVmU1R1UmlCOXN0REZz?=
 =?utf-8?B?L240UklPbHZvakRZMHVmaXc5amYwMytPRDZLeXNWdjVsQXhobktnanNmaWRt?=
 =?utf-8?B?RzVFY290UmlkK1UrSy9qYm5LR3lhQlV0dGUzWVVFTmlUaWxTZUlwVS8vUXAv?=
 =?utf-8?B?ZnorN29QNm9PQm94eG5qSnMvYXZSU3lJclZMNHltOTZreit5ZHJmMlExNUlu?=
 =?utf-8?B?aHA5S1g2bExuUWwrbVp3L1VzVG83MmZyUHpWN3lEc0ZzUk1SZlNNRjM4SW5t?=
 =?utf-8?B?aFJOSXlOZER5QmtHazJrNDBGamNDRzFRVDhKeWx4UWNOZnc1ZG00Q2V6dkxM?=
 =?utf-8?B?dFdyQXVIbnVZek8vazdOS2lXWHVKMTVjeEh0cEhWcG9nY091eWJHclFqNmFX?=
 =?utf-8?B?bzdyYnhEMmFNYzVoemFCSUFNSUZmdDhoYWQ5b2tkSWQxK2xZM01DOVk4dkEr?=
 =?utf-8?B?WlBrSFN6dHV6ODFLTDBrUlQxOG52TGFQSGNybm9uVWJ5TXpRWXlGS2xmQTcy?=
 =?utf-8?B?UWpkSzFyVXd1bWR5Qmh1NjJXNHVHOEJ2aWUxdSs0Z0dQZWJVanl4S0JxYVNP?=
 =?utf-8?B?a1F0Z3kveGV4SEFOajZwQXQydmt0b01wMDZqeHFoM01IWVV1bFdvMjZ6aUxo?=
 =?utf-8?B?NVNRdyt0NlhEVmd4UzNJQkJLN2dxemswWDFzSCtsS0JuTGtEQzlOOUs3aGNB?=
 =?utf-8?B?M2QwRFROT2N1WEs0SGRXdmxqMitnMkhrbnd2emE5MVFHajljN3hBeGlFeVhN?=
 =?utf-8?B?dFBaT1BFWENTMXhvZjU4OFRUQXU3Yithd1M1amlXd2RxSVRlL3B1UVJ5T1Vx?=
 =?utf-8?B?WUdybHp0dEpaTWpwZGl4a29jMzR0MGtJNmFmWUFSTEtxMFdTY0Iwa3d4ZHBM?=
 =?utf-8?B?RWJ6LzBmWm5vbUJUdzFQZFJYM01vbVh4bUFwY0ZCeU9URmtBWXFiY3hDZzRB?=
 =?utf-8?B?QVpGM2RJc2J6SDAwc2hIaVN1Z05vRU8wa0ZFUDRUUzQ1QXVWTHh5QzhZS01j?=
 =?utf-8?B?UzIvRzRDUmtBOXd0ZjM0N3VzRXpXQ1VPb1paR0k1TEtVZlRVNnNnS3lQYUYy?=
 =?utf-8?B?WUFtZW1uZXY0bW55QWxJL1gxR1JDSW9HeHNwRkxmZ3FxV3BUMGJXYTFLcE9M?=
 =?utf-8?B?SFl0dXl0eVorMW9IR1hQMk5ZelBwUlk3VnBoeVRVTFJFL2dxVWpYMktaaEox?=
 =?utf-8?B?akhGTXR1L2l2ck5iVFJmYVRHbUp6cmVnNHNQWTUwc3pJM1BYc052djcvbjZU?=
 =?utf-8?B?ay8rNSt0QmsvanlrQ2pyalZibkJKMDZTNkorMFU5NHFldnFnM1dtWTE5MENN?=
 =?utf-8?B?cW5vSmVCUCtycE9PTGpxbmVxcTk3WndTMkxSRGVPOWxXT3JYOXREekFPS1Fh?=
 =?utf-8?B?aDFWSUFvUldFZERBbDJBSkhvRVl1NE5hRFcvekxPRzcvQWRiN1l3czY1Mk9G?=
 =?utf-8?B?czRVeWIwUGYzcGpwQy9KMjZPcERBem5MeklHbERPcG1nbWIwRHV2cTUySVYx?=
 =?utf-8?B?S3RYZTY1SVFMNzFDOVd2OFY0Wnl4K2V3YzZhd0dsSFZFcXl6aXVpMENvWVpG?=
 =?utf-8?B?aGJyTXpFM1lQelZFY2NyMy9FVjMyNG9YU1N3d29uTncrVUh0enNsbVpOMDE3?=
 =?utf-8?B?WkQyUFdCK0tSdDRZdGYxZmYzT1NNdEZRSWR6SGxlNldJMTlRR2d1V3diUWxI?=
 =?utf-8?B?Y2RSZ1k4OTJ2N1VqeGh5WmhuT0tpVldLSzFEakVheGQ5eG1IbDl2blRpY1BI?=
 =?utf-8?B?NGxBUWduUlJlYS9uS2NtdkhJbkxUUGJ4ZEVXNWdVRjdRMHhJb2wxMWRSSkQ4?=
 =?utf-8?B?VFlWZDFHa2czd3B4eUJ4RERaRDVrMlF5WDU3ZVJvUzlWa1ZCWjFmRlArVHRq?=
 =?utf-8?B?RDVqMThVNkZWL2VRaEFTenM0b0ZMd2xwbGNHVlBIWFlyeHU4b2pDa0VzUm5u?=
 =?utf-8?B?Y3BuNFB3MVFlWHljWnd2bzRCWXhndFNRUVhtdXEwZk9IaUlnU1FwZjd6ZFAr?=
 =?utf-8?B?VnNhanZ5MGw0WEE2NTNPUnZySzBCZmZuSVVTRGwyUjVzMVhkZUx5b3JNZVlP?=
 =?utf-8?B?QU5RSk5Xenl4bEpia0FNaWx0dXp3Z2dvTVRDdWtpeXhISGJzVDRxUFpKNERG?=
 =?utf-8?B?SFNMMWxJSVJ5VWZnRlhYVDZrRFJ4c1ZGNDgvQUsrUzNndEViNWwreDdFYm9X?=
 =?utf-8?Q?M675akYwD7eK6WT+UH?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55cd927c-dfa4-4594-1637-08dee91cb615
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 Jul 2026 00:44:25.8729
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PYHxY7l0uygRa46tfMkJiK0wnEBoLdE/rufWPT2yli7P9tk+T72kW8lDdj5rewohU08Zj21UAK37isqbyS2fcw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB9212
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260723_174435_702286_7ECDA235 
X-CRM114-Status: GOOD (  17.62  )
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



On 7/22/26 10:14, Johannes Berg wrote:
> On Wed, 2026-07-22 at 10:09 -0600, Alex Hung wrote:
>>
>> On 7/22/26 08:02, Johannes Berg wrote:
>>> Hi,
>>>
>>> On Tue, 2026-07-21 at 16:23 -0600, Alex Hung wrote:
>>>>>
>>>>> I cannot see how that would possibly result in correct behaviour (beyond
>>>>> being able to link)??
>>>
>>>> Good point. --allow-multiple-definition silences the linker error, but
>>>> picking kernel or libgcov's mangle_path() will break the other at runtime.
>>>>
>>>> I saw your previous patch
>>>> (https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06604.html) to rename
>>>> mangle_path() to seq_mangle_path(). How about reviving it to avoid name
>>>> conflicts instead?
>>>
>>> Honestly, I completely forgot about that. Looks like I ran into the
>>> typical "nobody wants to merge it" problem ...
>>>
>>> johannes
>>
>> Is there any concerns or blockers to merge them?
> 
> I don't _think_ so, I guess it ended up mostly procedural, since it was
> across different maintainers etc., and I lost interest because we
> stopped trying to use gcov.
> 
>> I sure want to revive them.
> 
> Sure, sounds reasonable, feel free, of course!
> 
>> The series may also have a solution for the other patch I sent
>> (https://lore.kernel.org/linux-um/eea36454-cbbe-4690-980d-b4ec9423f3a0@amd.com/T/#u).
> 
> That one we should just apply for ARCH=um, seems reasonable to me.
> 
>> I will test the series and report here later.
>>
> 
> Thanks. Please just resend whatever you think should be included, maybe
> first all the UML stuff separately.

Hi Johannes,

I think the two patches are relevant today

   um: fix CONFIG_GCOV for built-in code
   seq_file: rename mangle_path to seq_mangle_path

I will update the patch date and add my SoB, and then send them to 
mailing list, if that's okay.

> 
> johannes


