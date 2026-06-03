Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74B5ECD6E5D
	for <linux-um@archiver.kernel.org>; Wed,  3 Jun 2026 00:19:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:Subject
	:Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZZgokyf1VTjbQBbek1ydc6Z9L/X5uQIzQMXtA6Nc3kM=; b=QD1J1Mj7VG+fzN1MRdZFo+/kBw
	/UfqXu8/Hs7ogZwPVWCaf+9E5v/YfyeuUJKQoQDVJx7VjJCNob9KQNFCZ23jsx1pIo8Q5yFJAXnVY
	FeSAMsqpJVW5lQ0vuvPGNO4QO2wcRcxDHnwSbc82dQ6EhcjDXCdLI/tgKjTQez13yaf3ZHrTv4SdW
	dCzvpDXeIFo24T96JoNEEAE71+mZd+oZnJLh3emoun5BTzsShsWpJ5WfID/5lWmE8zz6nrTAgeJrt
	0YbC3Zys6R/AvRYvTBOWj5TGf4PfUdg17DJMy7G2SOdR50ReqVH7BO2Lpi0d81k0sXouO/MSdvoDm
	0CGoYl6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUZKV-0000000DzY8-0dxQ;
	Wed, 03 Jun 2026 00:19:31 +0000
Received: from mail-westus3azlp170100009.outbound.protection.outlook.com ([2a01:111:f403:c107::9] helo=PH7PR06CU001.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wUZKR-0000000DzXJ-3Gwf
	for linux-um@lists.infradead.org;
	Wed, 03 Jun 2026 00:19:29 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=gGXsSd78Vq7MK6CWDEbwNHE71UH+I2iXKlMVdc0+fzDi5SwFbwkA91vmlNlrOVEp0T4nsmqGr7gmZ75G0CJMIlckv2EdSsQX/w4Amu8zIIF7s1hY5E3+0UYJJSqWPHkRmw6T7dkkcs9jODYsn7rpdvXmM5pt56uLM0xQY0nA5JxtSaczgDR2C+JcZG7IgXBgZ9oqlGgziu9chad11zPZeUoaeBhKrcnjLH0f33BQxk0sHL7MvrHOnsBeigsOM8dqnlcHD3DcnoWMm3dGxzsPpSSEfi/8hCqcLKjYwUEkwDi7Do9V1Uh+3yMzt3A8V2clW1PwJ9yOTb3KzDZBbvv48w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZZgokyf1VTjbQBbek1ydc6Z9L/X5uQIzQMXtA6Nc3kM=;
 b=KjEv+eGosoUnt4qOFq4PZO38BebMjRhScBWJ1ojTt+IAHZ4EPyBo0TLVbTWPn2tKeYYJ+ovpe87Vx+kOyD8qOG4WAGhzmFxn0W/9PN7Oj5Dm8e2wPaQLDmU5ASVyVZQveG8W2uvXb2Jpl15gscaLWsp/jWgWltqFx3eyRXScREbQPhUOnubgvkTpsB5q5L6gM9cF6fFn2JCXuOgyekDuf/vTkyrTZK3aYjYxtZOfqJiTIaggA9Ov7UYrHwOinrQmatBTQhKtknoOGniujU8jDlMv8/7g9pNnqgr/uFw9FK5xEccEMkJDU+wt+/M+jMtY5j+cYU4/yu0pSQ+nvYwt3w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZZgokyf1VTjbQBbek1ydc6Z9L/X5uQIzQMXtA6Nc3kM=;
 b=yt6o/ZVrPlG93DTAkyPGTqAbu7yYP2WhcxU5OcIdRzW5bOiDA+o7pfG5Vzdgg4xaoUn9J0wzVvZsQvfV6POBOae9oPyYMP33Apa5f2M8J9pktxSALA66khI/IGYNkRuPyVqLTRZPIgxmCwDUEqyN5q1MV3uanhED02veiIymoe8=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from DM4PR12MB8476.namprd12.prod.outlook.com (2603:10b6:8:17e::15)
 by DS0PR12MB8575.namprd12.prod.outlook.com (2603:10b6:8:164::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.92.7; Wed, 3 Jun 2026
 00:19:22 +0000
Received: from DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8]) by DM4PR12MB8476.namprd12.prod.outlook.com
 ([fe80::2d79:122f:c62b:1cd8%6]) with mapi id 15.21.0092.006; Wed, 3 Jun 2026
 00:19:22 +0000
Message-ID: <a497ca92-9157-4ab1-982b-4dab4cab2de1@amd.com>
Date: Tue, 2 Jun 2026 18:19:20 -0600
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/1[RFC] um: include .fini_array.* in linker scripts
To: richard@nod.at, anton.ivanov@cambridgegreys.com,
 johannes@sipsolutions.net, nathan@kernel.org, linux-um@lists.infradead.org
References: <20260512232640.1937941-1-alex.hung@amd.com>
 <20260512232640.1937941-2-alex.hung@amd.com>
Content-Language: en-US
From: Alex Hung <alex.hung@amd.com>
In-Reply-To: <20260512232640.1937941-2-alex.hung@amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: MW4PR04CA0250.namprd04.prod.outlook.com
 (2603:10b6:303:88::15) To DM4PR12MB8476.namprd12.prod.outlook.com
 (2603:10b6:8:17e::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DM4PR12MB8476:EE_|DS0PR12MB8575:EE_
X-MS-Office365-Filtering-Correlation-Id: 79e11234-d4bd-4cf4-846c-08dec105c2c0
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;ARA:13230040|366016|1800799024|376014|22082099003|6133799003|18002099003|4143699003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info: vDwNqRUmZkNw/9v1/y5Ko8Sw7SVeNNrRtqZ2UU8zSl/y0xgrqui7hsBk6ohHnBXXTgsfS0qFxRzmQEQOCVKchaLP3ABYJvLieswOf2SzWIGxxEW0k5kD/ElgB4JEiRJpjxhE3cWXgN4hWnhzWI5eqWVnl70mKWPEYKPuXH8AQfBwo3mM+0X2wxqqXGalUOaUIusW3lkx/vDWm1rlR7pcpkEX+zt5T2wkPfk5i+ilCaJ3i5fBhgkC4TzR7ORTc5kJ5B+0dMFhPe71GPmKMDmXBKHQ0pMKWqenLwaJVzNdYryvboy3e4WMefoxY8/8cqML7T9Ynf8hQNfzr4mdeYMqt5QwXd/8vRIv5Spf2BaUXs8cCDLYTuq5QNVP/Vy4Im+ysbSIQkJSG/1GtnGk/UmzFyhl4LcD+1ORtU5N15lgRAfeeiXWhjoxbwgK6yg1CS8Nk+Or6+FZKY21PdJbQ65RhFiZ2hUJxFv62GQEXxTIWxWdlEXNeXSmsz1QEa0Si8Wzp8ROBq66vi3a2ZNcHJp26AuAtlklQA/jIHMCAP/f8chW0xPF12Mf9Rk2FzXp73RuhNzKUQJ52QTx8GHuOwbsvaL19smxUMh1X0cDbV+bvt7XRCGKP6ij+wybb5inKT1Rfv7BODG0kIzYnH80+pj7SMXhNucSj4b2uS1xjae6jESEDQ9vqoE/3IDcQHVojOYo
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR12MB8476.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(1800799024)(376014)(22082099003)(6133799003)(18002099003)(4143699003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?TTBUK25GRllNWnJlanJhQ2pkbWVwQ05JL29xL21CYktMV0NYWkNpblhOODBE?=
 =?utf-8?B?bTlVQmt5R1JQV3A3dW5hOCtRZ2FYcERyMG0zOE4xdVJGd3pKekFVbzh0VStn?=
 =?utf-8?B?b2lqK2hJaDlTcjVvcE5kbjMwS3VERCtZdDJkbEVqbEJ3MUt5UFlhYVNWZEly?=
 =?utf-8?B?aE5TYkFiRkRST2F0T3ltcnp1NGhQN2hlRXFyM01GTEplNmk2R2hVaVpzK1Qr?=
 =?utf-8?B?THlLb3FNQ1JSOUV3c25rY0F2czk4REJ0VXpONTBwVktpbkM2c0RLSWl0WFlq?=
 =?utf-8?B?TGIrTFZjL1cxa096N2psb3FOMXgyVmRBRUsvUjVKYThLUTc4N2RCeDNTL05n?=
 =?utf-8?B?VUdyME44SDNkREFKMEM1OEcySllXNGxYNStiZmlyQ1FiZTZjZDBZSDc5Zk9p?=
 =?utf-8?B?eUFYVXhWNXp6UjhaU1M4OWloMkZTRWtoOEVBOTUzUE1NMitLelZxWE0vbXpq?=
 =?utf-8?B?TFhBbnZNSEUyRm9DUCt0bUgrditPTXJ2YzltcFRGanhFb1NtUEhWa0J0TFRH?=
 =?utf-8?B?RkZLTHhvekxMOHhXbDRGZ3Bvc1RqbVRMQUQvN3lLK2Fsa293d2tUMCt0WDB1?=
 =?utf-8?B?QnJTTS9adHVkZXlnZjdJSjZ0SUpmdG1VSFFSeHExcHJkc3lZQW5oWmZpeGl4?=
 =?utf-8?B?SnRpZ085b2FWU3ZVVDEvZGQxcmxOc3BDdzQwMURibm5TS1hCbzNUTjlUSFlQ?=
 =?utf-8?B?MVE5eGdSYmJVK0Z3cVBXNmZUV3V0YmVZVGlXUVFVOG1VelpHOUR0bXhDU0tF?=
 =?utf-8?B?c1p5cmxRY214RU1LVlNWNzRFNk1SalJhYzhzWWllbGpoNUJQTTZ0QjFJNHRO?=
 =?utf-8?B?Y0kyanpVZTlGcndQWmJsa0tzdWhxMjdHQWtiaEhFMXNGaUxhTDNZRTB4eDc1?=
 =?utf-8?B?TU5wcGNkTU1qUTh1ZXJha20yNmtyT0M1YUI2RFBYYzFha3hmU1NFZzA0czJs?=
 =?utf-8?B?SCtzTXRDTjFCZzNVdG1rYmg3M216dzMvTlpwbnJyanJBZlU5MnREK3h1cGFx?=
 =?utf-8?B?ajhyTDZqZGIzWXpFTE1CZ01lUjZVT3d1bFlYRVR1V2Zha2JVVlJHb3N1ZFRq?=
 =?utf-8?B?eHBuQno4MEJBMU9qdHM0L2FSVHZuM0RxMkpFVlJZZjBNZWxKcTV2aXJZQVIr?=
 =?utf-8?B?eHk0d243M2F1YTltSGlLdWJtd09jY1BVQTN6SHUzeHExWUYyMUNkbDRIRzBZ?=
 =?utf-8?B?MjdHSW9SQWhjejVIaHRMMXpqajlJcUVSclVFYnFIaUlHRkJCVnlnNmZYUlhX?=
 =?utf-8?B?SGVMelltYUNMN1VPaXNuYjdtb3JsR3BxV1QvcDJlZi9lT28rMk5vTFhwR251?=
 =?utf-8?B?cDJZV3ZrT1dHcjhpZ3c4L1A5ai90dnUxRHZPSGJocTgvdWNFVXVqOEhjc2hL?=
 =?utf-8?B?NFFaeVR6NHBMT0RwS0VvaFJKbVM5anJWaytCLzR5SzFlVzZUM0lBMStzdzQ0?=
 =?utf-8?B?MDBsZG9ZVDFIb08rdjJhbDVzT2pTN2lYY2tUTkF2QW9SdnliVjN3K2hhVGto?=
 =?utf-8?B?cTdsK001Y1EwRC9QRVE4NXZGVWh5eTNrbThZQ1kxdUorcjVLWGxuL0lKSWRI?=
 =?utf-8?B?M2R5WWx4UDRKOUFOUFVIa0JROE1McjR2aWp0dmNZWUd6MG9WalQwRXBJcFFk?=
 =?utf-8?B?RktJNW1GZEJaMFp3VEZsOWlPSmhPN0JDNFNQOHhUWVAvUHNQSEo1MVp1L096?=
 =?utf-8?B?YTdDL3ZkdnY1S1ZpN3pKamRCeHdKR282NWwyQ2syRHdNeDlETjVQZko5N09l?=
 =?utf-8?B?MlM3UDVBbk9Zcll4YVF0b3o2bU9IRjF1Sm9rcXJVYjBuSWVvOFBHMmtzNUd5?=
 =?utf-8?B?YzhIZlVkYTRwS3VFSXpsVUM5Rmg0RzBDR2VoWWoxMkRvZTM1eXJuNjZtZnNO?=
 =?utf-8?B?ZkUyTWxFaFFtQmQxZGNpMG43YkxsMUdhM3NyaHF5NUF0WlBpTTRxQW0yazZU?=
 =?utf-8?B?cUdKUDY2eCtmMU1aWVJyQWVRNEU1Q3VyVituUDhxN2Z2c0hSdWw1K05kOTE5?=
 =?utf-8?B?MEZsbXhtdkpSYWNOSVEvZEl1RFYzVThpNk12YnU2VDBLSW13aG53Ym1CMnIx?=
 =?utf-8?B?RW45M3VrUVdMOHg1eDJ3NHdQUHVDelhPRjVGOW11Y2sxQ3RGV1htTlhMT0xJ?=
 =?utf-8?B?TlZwZkhQRUNVemZ2cTZ4SVgwQ3pHa0lnZzZnODFWSTN2STRIYi96SjJYTjB1?=
 =?utf-8?B?ZzA0RkNSNTZ6dGJ0MitZS2VZSlNneStZYi8xNUZWek83QkExYTFMRFJoZ0Nn?=
 =?utf-8?B?MnVUMmppamUxdnVJVHN5VFdMdVhtQzhrQkxPZkJzNnMyNENIS0JBNmprZldq?=
 =?utf-8?B?ZUozRkhSczRheDV1SGVybHhKOGZHdTZMOHh3empyOUNjWDNhNEdCdz09?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 79e11234-d4bd-4cf4-846c-08dec105c2c0
X-MS-Exchange-CrossTenant-AuthSource: DM4PR12MB8476.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Jun 2026 00:19:22.1799
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: KQp4FPxPO+DdhnZMPqPk+gXQ/XUerbsXNQS80Rq1nDYip62uA7v1ytMOT6uSDKsKjkjX3b+gWZ1EUtraw6r25A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB8575
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260602_171927_874512_00168170 
X-CRM114-Status: GOOD (  14.20  )
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

Are there any concerns or comments on this patch?

On 5/12/26 17:26, Alex Hung wrote:
> GCC emits per-translation-unit gcov destructors into
> .fini_array.NNNNN sections (prioritized). The UML linker
> scripts only captured *(.fini_array), silently discarding
> all prioritized destructor entries.
> 
> As a result, gcov's __gcov_exit never ran at process halt
> and no .gcda files were written after KUnit tests completed.
> 
> Add *(.fini_array.*) to common.lds.S and dyn.lds.S, mirroring
> the existing *(.init_array.*) pattern already present for
> constructors.
> 
> Signed-off-by: Alex Hung <alex.hung@amd.com>
> Assisted-by: Copilot:Claude-Sonnet-4.6
> ---
>   arch/um/include/asm/common.lds.S | 1 +
>   arch/um/kernel/dyn.lds.S         | 2 +-
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/um/include/asm/common.lds.S b/arch/um/include/asm/common.lds.S
> index fd481ac371de..336361412b47 100644
> --- a/arch/um/include/asm/common.lds.S
> +++ b/arch/um/include/asm/common.lds.S
> @@ -90,6 +90,7 @@
>     }
>     .fini_array : {
>   	__fini_array_start = .;
> +	*(.fini_array.*)
>   	*(.fini_array)
>   	__fini_array_end = .;
>     }
> diff --git a/arch/um/kernel/dyn.lds.S b/arch/um/kernel/dyn.lds.S
> index ad3cefeff2ac..fbd8d559f21f 100644
> --- a/arch/um/kernel/dyn.lds.S
> +++ b/arch/um/kernel/dyn.lds.S
> @@ -113,7 +113,7 @@ SECTIONS
>       *(.init_array.*)
>       *(.init_array)
>     }
> -  .fini_array     : { *(.fini_array) }
> +  .fini_array     : { *(.fini_array.*) *(.fini_array) }
>     .data           : {
>       INIT_TASK_DATA(KERNEL_STACK_SIZE)
>       DATA_DATA
> --
> 2.43.0
> 


