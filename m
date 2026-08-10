Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515B7C5AE49
	for <linux-um@archiver.kernel.org>; Mon, 10 Aug 2026 13:52:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:Cc:References:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RrI+kRipRj7C4vF4iqOOxSlDYY0k8izykR9CgZAJJck=; b=dPhuIZdMtaqPMtDsx5UwzBpjky
	N6bs0R8qD10lStTtdy7dA+6UIexKuJX4AK+Iv6mjbe3leG5iSunnxrQueOIz+eQbHYTEm/LL6jE+Z
	X6xMl6eEvRhnrt9D6zI7ZoFRPRHjf6v7usuMiN+3F5Le83LM+XwZZQj7LWHfygYd5bgY3/A5SmjOI
	mZxBIat7gl/zUSVmSBtJvHxGqdEX3VSZQ0RmXXigVESr/Z04EtWFfe93baxtok0W3MqSUxQOi0CW7
	GJ+SmHZTzg/oprP6eLkQENhFuJ0yKWtKMlzXxkDwb3hESvMrypPH9NQWQOxK/BjMBCB166u8b5qOY
	Htr4PZqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQQC-0000000Bw0F-0sqe;
	Mon, 10 Aug 2026 13:52:08 +0000
Received: from mail-eastusazlp17011000f.outbound.protection.outlook.com ([2a01:111:f403:c100::f] helo=BL2PR02CU003.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wtQQ9-0000000Bvzf-0qhp
	for linux-um@lists.infradead.org;
	Mon, 10 Aug 2026 13:52:07 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Yv221gkj1jimO9hXvRS1GcyuOj3+pZBdcoIZV/B/19sqfQYXevnF54N0w9eueMNTf9pOgYFccuwtwVCFVo9fYCUFcx2m7T/FrHM8QL/kh3nthfjGMOJ0qKhjCLteH1f3o21QDiYwzbP9r6G8LGFDUT2+CsU4QP7vi3WtGQP/KFXwuCodWwulBRwxj2oKQz8iyQPybqZQQPLncpwl9QlM6Nc7zmm1zdBdgRQQXnrWsS82qeMxYCf4XZNseaqZJgl6DNg6u/JEyqj61MddjHmIf27grWrhe3B1V9a0skGgimYnj4824WFajZD2Y9QhjrvUG56ApPi7FBF2GDKRku+PUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=RrI+kRipRj7C4vF4iqOOxSlDYY0k8izykR9CgZAJJck=;
 b=XA0QRMZWwW+KvABOFeUd7jiTpn5i3jiNU84vCYZouidtxNmDC2YBZAmBlaKUYuZOn3RjiBEvb79sodH/vNmHNWxC8HJb/tk7Vlw6m29NSs+0LEiKEWxItqnT2lF9+jxoN7TcYBSw12MgWQjJrArL9tSiZRAE0tmixpBfJY4fH45Ua9LqIw2/cveCsdMg4ZaDHt/DXaX9eO2Q/UffSnSRilRzvLOx2t6cM4TD31+a2GQrjt1t8PAJkhyo4UKKq2WY6ZQQxN8AHixJaxcquB/oRqQ7FjPw65sh2XHtwwwhUu8CGyj19SJfDPjChBphPVp0KgJi9qI/qT390k/0FyBdNA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=RrI+kRipRj7C4vF4iqOOxSlDYY0k8izykR9CgZAJJck=;
 b=4GD40R5XTQunZy+6JRNbI3qmsi0pqne/ywQTxqX16aEF+ZTV8HFCGv9QxRlEN+ElzAt+Xqh8TmjYvncQ/MtBWm+dNun/4T27Rp7g2ChIGOlDoSy8tZ62EC2Xoo08qtQYZDcPtuOrtoj+gJUZe9Cz4HfdZaYxzpqPHMWeLplFHZ0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by IA1PR12MB7709.namprd12.prod.outlook.com (2603:10b6:208:423::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.292.25; Mon, 10 Aug
 2026 13:51:58 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0292.024; Mon, 10 Aug 2026
 13:51:58 +0000
Message-ID: <a77a9f06-fa26-4687-9722-1e54dc771fce@amd.com>
Date: Mon, 10 Aug 2026 07:51:56 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] um: fix CONFIG_GCOV for built-in code
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, linux-um@lists.infradead.org
References: <20260727195515.2306731-1-alex.hung@amd.com>
Content-Language: en-US
Cc: alex.hung@amd.com
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260727195515.2306731-1-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR03CA0048.namprd03.prod.outlook.com
 (2603:10b6:303:8e::23) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|IA1PR12MB7709:EE_
X-MS-Office365-Filtering-Correlation-Id: 0b121f79-fe59-4ef8-dd3a-08def6e68bbe
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|376014|366016|1800799024|23010399003|11063799006|56012099006|10067099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info: 7kTaZnD3bKPkXUccPg2zYDhc2+DDkabzi7HF7scHezmtFiAe+WJAaQnFOnpzCBjHO0s2yVpHgnzwU/dfyuBmbw3EqzlHW9c3EVsqYd7XNj+lqtiidIIQ5BXDlhxtypPYm/m10eSbVO8qGxujqN7HUL+bIa7pfBtvO/DEWF1I3YFrk/+Ub3dHUbA5zebzBMIl0wLVdR6ZJhj78VJc2zA5w1Fx8sfpbb5RxMerWjUo1vCnjpPLRJ7STTjf6VA4jurSXesty/V4de5Yh/4iaPKcvuniqlZkjtTzUhqmd2ljsPu8ogItgF+bGEImZclnS8iHjAl5LxhmSl7TFgEkMz6TG7qMDckeZi5+LvVKkoWP+oB1YFt/I7HArZfCVHHLZB2ov1u2naEVwxz7O4k68kdfof1hIaIQ6i4P1NW97u7PnLTTgCTVj2F7ck3R2EYsvaGiGi0h1jW8U7eXuE8ITMtsTHWpDhv+4YinT/xoiIh7bw4fUOyN4CHnTglVhLMUrMtVvyFF/Dd/sQyZs9z4U4uA7xQKsRo5VFY2m2xmoXsB7bN7VG2nLKoBW0rmB1WgzMAEg26jduX3udOs2MPtUwbr56IXDXgTuG694NHdKJ/kqKby0ro4ctZJuI7isL8Uf79+lNAjNwaeJWZdme+UyssaPqF+07UnQlj/J6Gf7mjG3y0=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(376014)(366016)(1800799024)(23010399003)(11063799006)(56012099006)(10067099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?MWdRT2tnQ0VpckovZnBqS3ZGL1A0SUVsbjdsbWYvLytvc3J1dDR3bHV3Mjlh?=
 =?utf-8?B?MC8zWlVhbUljMzBQQ0dOTTViQU9SQVUycGJUTi93cSsrOFJBQ0pZLzJJWE9O?=
 =?utf-8?B?L1QyNEhibmhUc0J3VVpVWjd3cWJNZmgzc2FSYjNPSnBXSUJ0N0JyRFc3RVFM?=
 =?utf-8?B?RVZUL2ZaU0ljZTBieHpYNVpmbWt2dTA5b0IrckppMU9UbkYxRi80eTZkZFFl?=
 =?utf-8?B?VFVwZmwxWk42WENnaG45Wkx0NjFZcGNXd2xSZUFHNWY0SEdaYmRFWWs1Qlho?=
 =?utf-8?B?blRUVnpvMURqa0hrQXZKR09ueVNyTWhBN01wZ0NaRVVzUjFJakRXTy9CeDZD?=
 =?utf-8?B?OUF1OXJURWg3S1ZRQlptRUtnUjk2NHJnVTJsbXRhbTVqRDM0U1ZnTHRZZFdX?=
 =?utf-8?B?L1RnNTc5N0FYRW9YSE82aDZTZkh1c1hFajBFZkdzS0psL1ozbkFmMXBQT0lu?=
 =?utf-8?B?UW5OQnlvd1RxWWVsdzJrNzVIY0I3UVJaTGhyTXV6NlhwbjV1ZTRESTlSc0ds?=
 =?utf-8?B?WXNKbXF0eU1DQVZoeG52M25UWDNiQkU2YTcxSEx4M2ZVTzd0cVNqL3BQKzIw?=
 =?utf-8?B?NE1Va1BNRmJ6NS9zdHFpbWRyUXVoZkYydWhZTlJZMjRUQ1BWTnROV25tM3Uv?=
 =?utf-8?B?NmJkQVJQYUExWm9hbk1tc055UzdwMlorSzRRWU82QUZaV3pGM1pqeTg2Z3dw?=
 =?utf-8?B?OEs0aXZNZ0xhUWtBMjBoK1lSdnc0Y1Y4eDFiei9uWnBjZkY1WlZGb2Ywa0xG?=
 =?utf-8?B?RWF1MXpWQ3R3Y3ArbXN0bHlZWjM2SWdGa3pTdlMwTEc0Kzh3M0pONUxiS3NL?=
 =?utf-8?B?d0VpeWMzNE8vZkFnVGJlZFBmU1R1aEYzVmRYNkFvWmM5c0VtK0JEdWg3VlRl?=
 =?utf-8?B?Q1lUL0ordHJaMzNLMW84WkwvOS81WTVzeU5LeEw3QzluQi9vc2IvcWxBTldC?=
 =?utf-8?B?NTFqSkpzTDBPVGVCOGgxRStYc2k1TjZld1JzeXYyYzFTTWl5MzNCQ3NVbmJJ?=
 =?utf-8?B?NnNBUEg3WFYrdWRGYlV2U045SzFjVzNyQWl2a0pVWmJWVlVqVnRPRlNjNWxp?=
 =?utf-8?B?UW85OUR2L2RsZTZ6RGsyR1l1N3R2QjJjWDZMaUV3MG9NcjR4NzRWbk1GOHBF?=
 =?utf-8?B?ZUgyV3Z3OEtBSk5mL2VmSVgzYjlHQ1VqaUZRanlXaVU5cUpwbGp5aG1XT1M1?=
 =?utf-8?B?cDlLRUVXTXZNNnlNWld3c1NRUmxmalh3ZHVVWU9meE5sVGRoVnBpdmNQTjJ2?=
 =?utf-8?B?bWdLWld4UGpsWUpRbVFGejBWdk5neFdJZXE2US9RQXVhU0NKV2hqUUVDUXBJ?=
 =?utf-8?B?dnFUZmxYYmh3Q01EREdmazZTRlpodWlpUitEQ0tsQktYYTk0ZXluTVdMOFNr?=
 =?utf-8?B?bEZzMGdiZ3d5SklUY1lkNjRjNmRmb3lrV3FwMitoNjNLVWNWVEpQQXNjZVZh?=
 =?utf-8?B?T2ZiSUFSancvY2hWa1lMRjJ2NitGMXVCTlY2U0xPdDlEZHVoODM3SjlZWngv?=
 =?utf-8?B?VUh0THcrQ254S0FxMXFRa3QyQVJscDdzb3Avd2pPNXlsZS9kVXh2Z01ZUUxJ?=
 =?utf-8?B?NWF1NEs1bGl6Q3RxWFJpQnVUbldKSTZKdzNkY0dUMkdacXpQbm5XSEFGampL?=
 =?utf-8?B?U0U3T1M0a2c2WkVOZG5jZUdHVWdxdGpMV3RDb0E5SlZINTRsWG1KK282MEw1?=
 =?utf-8?B?ZUNuSWlVUG13Z3AyUW5YSW1XaTVydFZlNnlYSnl2a2w3VDBNcHRESTZaSEIz?=
 =?utf-8?B?WmNOMHVHYzZvNDJqMXYvS0xWQzdOWWJ6TjIwT0FJUnZHODVxb1dIVjlMY0R1?=
 =?utf-8?B?c3RQNHJjNzdzU2M2UW5PclFJOFFLUUFHMy84ZnZzRmJwamg1MFVpdEc4aXdZ?=
 =?utf-8?B?RnZVZk9jRmNjS3UxeldSZTVLQWFwNG9MR0NjRXNEU0pDUmFIRmlFKzI2bzcz?=
 =?utf-8?B?Q081L3FuSWh0enpkcEJ2Qks2Z3lqWGpiL3N3cG5yaUtxNW9LUWRVQ051UjBm?=
 =?utf-8?B?dU9SNm0yRU43WXA0RWVTUmx3ZmpOTlE5bG9JWUV1enExd3hDMlJZRFJqN0Z3?=
 =?utf-8?B?d1A1ZytVUHRteWUxY01hZkMxVDY4WGExQjUvSkdXWk8vVjJNTDJtWG96OVJ4?=
 =?utf-8?B?K3BSUHRvOTUyNXFHbDEzc3hZdjNiY29QcEFFTkpuSkhmRTkvTnh6Y3RUbVV5?=
 =?utf-8?B?ejduYmUyWCtaMHZKdUlBQ2ZDTXJIeDJXUVV6U3BkT3FpaDhNOGhwTUVVSkt5?=
 =?utf-8?B?TXdHZkFiMnU3b3k2WjdqMUcrMjlDdUF3R1NCMmJpVWJYQW1NR3NjREZHMjlV?=
 =?utf-8?Q?flEPwiyzVnLmY0jPBK?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0b121f79-fe59-4ef8-dd3a-08def6e68bbe
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Aug 2026 13:51:58.3024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: JoFhx7LogU5GPPhR7jMwH/E3zcj8v94jDH/XDp6L7wwaltJpTYxDmilL09Cqx7XZKZ+sXMSgcqplfA0f37tWEg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: IA1PR12MB7709
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260810_065205_255197_731F6C36 
X-CRM114-Status: GOOD (  18.47  )
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

Hi,

Any comments or concerns on this patch? Is it ready to be merged?

On 7/27/26 13:55, Alex Hung wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> 
> With contemporary toolchains, CONFIG_GCOV doesn't work because
> gcov now relies on both init and exit handlers, but those are
> discarded from the binary. Fix the linker scripts to keep them
> instead, so that CONFIG_GCOV can work again.
> 
> Note that this does not make it work in modules yet, since we
> don't call their exit handlers.
> 
> Note: the .init_array.* wildcard and the RUNTIME_DISCARD_EXIT
> define are already present in this tree; only the matching
> .fini_array.* wildcard remained to be added.
> 
> Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> ---
> 
> This is a revived patch. The original can be found at
> https://lkml.iu.edu/hypermail/linux/kernel/2103.1/06608.html
> 
>   arch/um/include/asm/common.lds.S | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
> index fd481ac371de..2ed213913afe 100644
> --- a/arch/um/include/asm/common.lds.S
> +++ b/arch/um/include/asm/common.lds.S
> @@ -91,6 +91,7 @@
>     .fini_array : {
>   	__fini_array_start = .;
>   	*(.fini_array)
> +	*(.fini_array.*)
>   	__fini_array_end = .;
>     }
> 
> --
> 2.43.0
> 


