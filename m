Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F6ECC636CC
	for <linux-um@archiver.kernel.org>; Thu, 16 Feb 2023 08:24:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=HSXbMcpRxJjVPU1V5uz88KoUNfK/Ok4o+Vw0gNMNhk0=; b=eAa0/HA2vXUTOFzs6aUg5juAHP
	QiLXUU19I5JocNgEKRuqRge5XsVeNqyrI0dZrmDnQKpAVp9COqvc9YdBQl4tMV0gOqb/uXWu0DtD/
	IGvq3c/hbBtHfwPV1n8lZOBjLRSnWQyvMVMiAogr7zcsMBg5W1dTTsMOFqFIXDkWWZYqernyh36yC
	BXjL+A4P7CXvOyauG4DQIySQX8g5/WgNaRL0cy0em6TEOlYsT1vT1Rql3LQ87+EUSEjkdbjVhYoFp
	fMp2vDPb2597inCkkTc42KhbJSBkrtQ9paFhDyWnSLRwLw8gMXErMHilDHz7jiR013oW6QYmBo806
	3EZfqb0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSZZT-00904T-Fn; Thu, 16 Feb 2023 08:24:51 +0000
Received: from mail-am7eur03on20628.outbound.protection.outlook.com ([2a01:111:f400:7eaf::628] helo=EUR03-AM7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSZYX-008zh2-O9
	for linux-um@lists.infradead.org; Thu, 16 Feb 2023 08:23:55 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Am3FwkEK1FT//Qp15Kh2PHYLixf7sih5Qy/EKMcgdnioEnoSfXC9LvuXNonw4MmpJBLMF0J5KmCk3xK4pgT4mCT8yQ2NciGNA6J474gccnmE/IOwGZsfsi/uRkgcP46WUoCYHTzSwmJ3qBnYr9poevMQm1LI3GUZFSq+JXLQhtE2obnSFkl8lcwd2u3x6ZgMLHXjTFIph03aD8ol0ZYesuTRpJOOMF7xhxpRtBPY5lZtRFxVgK6zdx8FUPnlh4nz1VdJA/We4RxashqEYxtsPHbaf7ivi1ASwjB1uj8Qg7Sy/onVBVRdEtqowvCTj/V6DB2OmiM9HibInWROZ6w2Cg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D5v25+AIGjM0FzVoJJjTz1oFd5EqzD2nKT4okHOKlBk=;
 b=FwNTTmABy/lITokYXp/7Bdf/9cbAoS88WM2/AE1ue1szNUddbmQqpXg0oI1v/PRxaTdWTQQbG7dSa+TQ393C8BWlQHSUdggoebgM9jHJLXLTJUpW0vyLJsXM2AHTSAxzk10uiARfQi/jzdqmTR1Z/FMF8+sT1QzMO3xQJs6vUbvvEyww4RvUi8yWxRMF0GjBMoGHmoEqCWU3UnW9GLcGBQvVnAlvAqyZRo1LpNML72YT/RMLgbe+2xmI+C51qyG+nbM6Y1VM9jsapk26X8MRTBh5I5DtppMxDGxsHP6Qk5fBpGrwSsMSwQLCzkuYfrt/WXTXHmCfM6nJXebuhmDPTA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=D5v25+AIGjM0FzVoJJjTz1oFd5EqzD2nKT4okHOKlBk=;
 b=oLuLsMExlaCZUrXbbL+WPHyGvOQmQZglsDh8+8qUb/N2py1Bvjsc23XQXy42PA8JaqO6yEOniEGj3pQbH8uvbusy8WJ1JAAGNRj8TIBA2o4/PMb1XYzLkoD8yoNyRuUBIrvCy9FN76Dwd1nIEkEtUUkD1nO7B5v2jMrcQ01YWLttLtzuaJjxb5vtbjAtgT9FP4Ba7QFqjAoagjDfngXipq01acnhppAOEivf9jnjmjfpNqeQctldaWpeab28YEWn3hamrgS/4a7Nqicw37owi6b/yi4/cFUKwMHwu2JL54jaRWnB6c6U/lNtM+DTxMtaNDemXYOko22DHqTeJV+TVA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VE1PR10MB3870.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:149::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6111.13; Thu, 16 Feb
 2023 07:51:55 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Thu, 16 Feb 2023
 07:51:55 +0000
Message-ID: <8a22d84e-5cf4-bf41-220e-dc5e48fb2fc3@siemens.com>
Date: Thu, 16 Feb 2023 08:51:52 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 0/2] GDB: Support getting current task struct in UML
Content-Language: en-US
To: Glenn Washburn <development@efficientek.com>,
 Kieran Bingham <kbingham@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-um <linux-um@lists.infradead.org>,
 Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
References: <cover.1676532759.git.development@efficientek.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <cover.1676532759.git.development@efficientek.com>
X-ClientProxiedBy: FRYP281CA0006.DEUP281.PROD.OUTLOOK.COM (2603:10a6:d10::16)
 To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VE1PR10MB3870:EE_
X-MS-Office365-Filtering-Correlation-Id: de1acf45-f9f2-4401-d4b4-08db0ff2ac68
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	g/3jLe6MiHUSaKPT8Lg9xgS++tG89P2jrpGWJaRH4mjQmxzirX/XHADgmP2p0xJS1CK8GcRQPGgELiSHGTsase6kFTqtsPv54KJGTA8AIS0unKgtyEJ7FyqqhTbrcrZ0+dSTnQDkZqNa/gVkmNlLP4r/uNWJo7cjd7X6b1pRN/OnS0+sT8VdDouNUpByEY/Ccd+ous/yFaWjUhfd+UDmriM3w/NC4Tydzc0uS/P2MIicYe0ERJGIxrg8VUoP+yxcL9Qd6MKWQcH175206vdURhK02XZCsBeUf23Nw5DQ+fZHWCcNLDFtjSAK30Dn5yhUjG/d/Xwf69FBeQtdIZG4sF9VDP7+vv2SCBMgNYlJzmca6S68mh54lFbNk9E4tZ/Oq9vpRyA86PIyark/0H7HEvGRT2viNYhjOfzWr+XlnfJpyYojxc5fAqzipg4wXjZQRT4EnfcnfLFV0gst+B793krNvAhohv/z/pfZr0OLrasIbiY0H0z6ZfZoFOnxgSPNEawlawabpR5uXDK5vJW07oCH+EPecY4RQb/IpCxZdE74xavrw3+f4csiuwdDc15XkBmErUb1iwGjDgA61ShFM1a5sYuyd6w73rUwC3Pp/6zz687Q5yjbXEIS3iNV7d75BXCBhk8FVUhWHqReYyjIm9lDp5HLJ7JFSgMARu893mOEIoXmDNTlyJ7U7CN3CqyZozuiOoD9eUTxQhAk8gXntXNduX+6torf2qxYqP4bmgc=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(366004)(346002)(396003)(136003)(39860400002)(376002)(451199018)(83380400001)(44832011)(8936002)(86362001)(4326008)(31696002)(8676002)(41300700001)(5660300002)(54906003)(316002)(110136005)(66476007)(36756003)(82960400001)(66946007)(66556008)(38100700002)(6666004)(31686004)(6512007)(26005)(186003)(6506007)(53546011)(478600001)(6486002)(2906002)(2616005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?NTRJb0ZxUExDM0F5U25GWjN2UGJiRFBaK3liRUNmeXM0TXk5bVdlK1Q1UFJX?=
 =?utf-8?B?YkZGejBlUFdSc2d5RXRyUnJsZkp1NUQ4aW1ObW94c0pCeHFXclVuN0h3aTF0?=
 =?utf-8?B?ZVBiOGpwcjFLcS9iYVYrdHpvL1V4ZnB5TElISUZ0cldRK3hmZHhwQjJlU3dU?=
 =?utf-8?B?WmdKVXFjeHloZWd4RHpvNGRkMTFJcWhJckJpdGZVZllPQmJMOENCMnI4aGtJ?=
 =?utf-8?B?akVvOS8rVkQ3L2p5bUVYeE1LUXdQdmtiVStUVmNFMlhoUG55VkhHenhSQVU2?=
 =?utf-8?B?WmJHMitNaktRN3FoQ3F2TkhqZTFzUXpyc1FZVGE0U0V3Q3lLTmN3ZGh0UVVn?=
 =?utf-8?B?NDcxZ1NSSFI0RytSOCthS0pYeUlvem93VWFKNkQvdEowQ0ZPZTVWSXV6SEZr?=
 =?utf-8?B?WVYyMmtWVTVlOWE4WjBQRVI1UldaTEllVUVOc3laQksydVpYSGowbTVXWmhi?=
 =?utf-8?B?UzNiVUV4Y2N3czd6UHJyamVLYi9wRkdkd3BEVmw1WTQzN0Z5SGJDa3dVNTdW?=
 =?utf-8?B?ZmxDM2VvNC9QYkpZcFpWbVlDdkJCY1JJdUpyV25ra3E5cGU4UzNrYXFaK3dI?=
 =?utf-8?B?dHpLdjJKK0VyaUh1T0tud24wNzJ5T1U0OEJ6SytTQngwRUxLRVNGakl6dG5i?=
 =?utf-8?B?blNxd0o4elE0L0tkV2JPQ3l2VUxhaThicGtEc3htRUxxUDA1YlJxVW54NzJ1?=
 =?utf-8?B?SHpLSTdlUmloS3M0QXlnRTcwaDNPY280c2Fzb1hYMHdUdHBQUjNWWC9abE1q?=
 =?utf-8?B?NkR1WC8wZGtHVHZoSDk5WWI5bXJZcnFBQzEwVk9QTlpQbGlNaWJ6d1pTL3Vk?=
 =?utf-8?B?MW4wZElnWkFOWWdEWXN0ZlpSMTJpK0JveXNPQVhIajNKVU9aZjF6RlZ1Z1JN?=
 =?utf-8?B?USt0emE4L2V1VTBKTURhRUFnZGIxMWpKdDlwb3BqcmNOUzMxb3FTM3FqZVh6?=
 =?utf-8?B?SERXNkVhWHNwSWhCSnM0ZnBSdFAzWmtvd2RNdWNEZU4rTkJkRFhOaWQrT0F2?=
 =?utf-8?B?cUhqV24yTkh6MVFyeFU2QXJlVklROWtXVEwwa1pTRVlNM1g2cTZCbDQyRGlj?=
 =?utf-8?B?dUdZWXZxTk90R0NtRW4rVktlOG5Gd1NKNFBXbHpnSnRUMTNOUFd6TkQ1b0w1?=
 =?utf-8?B?MFZSVnF4MXh6UjBoOE05d0wveEFLVVV6UmN1ZzM1Z2VFVnFmNXRFMVhTTk8y?=
 =?utf-8?B?SzlhSmR2S1ZkM2NLaXhabFJRclRoVUlibE12V3VMYnN0R3FoQ08yZ3JCRnJK?=
 =?utf-8?B?eUZMZ1RmK2NqdVBsd0ZzOG9ySGsrUm5iTFhtZ05wTnBuZjdkenFUaG5jWHRj?=
 =?utf-8?B?dU8rYThqNUVLMnpBK2lrQ0kranZRYldWT2VUUDFVVUU1ckhmZjdORmYzd1dD?=
 =?utf-8?B?NzRIY3U3QjQ4Mk04SlhMV2RPdUJEWU5WNFljYmFvck03cVV5R25Od3g2a3FV?=
 =?utf-8?B?Tm52a1g4aXg3ZlZNbE9lOXI4aG1URGJ1VGtDbTh6SUk5NVNTRWhMS0xtYzRG?=
 =?utf-8?B?eFE5bHV6ZlRxb1FGUGQrek1pK1VxeFMxOGJ5ejVBZ3BqN0RDRTA1ZW1NMFM0?=
 =?utf-8?B?S0s4amZEeWJyazM2VGpSbm41ajM5ZEh6Z2txVXZja3A3aE1JTHI1SXRCRXhV?=
 =?utf-8?B?UmVrTWFBZDV3UFd4Rkk5RG5BbkU5MHBkbUhFQ2s1N1pCL2NwbW5ZZ1d2dGg5?=
 =?utf-8?B?dHRhZ25vWWlUVHpTSXdWcFRUenp3ZGtxei82M3BPaHRJZDc0bHpINGhtTVgy?=
 =?utf-8?B?N3kyY2M1UzJHbFFKcW11QSsvRnVCeGNVN1hHRnNSVHE0U0ZiL3pLajZ5Qmg1?=
 =?utf-8?B?QjVvMjNTZXRZN0xna2ZSdHF0RlA1SjRVbEV3cXh1NktnYUdaM25jc3F1NnNn?=
 =?utf-8?B?UU51Znk1NmJlTjA4Z3lFSDBsVGdaZnFvNmdiSk4yU0lxQm5PNk96Z1lrV1Fy?=
 =?utf-8?B?TEtyRmdRbnZlVklZRVEzS3hQaFFkaCtsUDFndXZyUzUzWFo5U0hIRkhYT2xZ?=
 =?utf-8?B?U1g2M20rd0N3dU1vdzJlVzY1a1BJOS8rcWd1Qnp2MEVUcDdzRHArTUhSM3Np?=
 =?utf-8?B?RjF6NUVmaW5XRWtDZ3NTTmFVVmM3M3VINmlwUlcwV1c1NUVHRUx4Q0pPZ2lQ?=
 =?utf-8?B?SmpNRmhkcTJuUVFiTGJ3NzVQNitaNkcvOVBlQXlFU0s1MEoyNVRmSXpIYTE5?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: de1acf45-f9f2-4401-d4b4-08db0ff2ac68
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Feb 2023 07:51:55.3048
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: b6G8QcQwUVAGisYZVsaA5qjOAxfDKP2H5O2nqy59ubmwut9SKTHJmTN/1ajrZMcQJp8OSoaFVDsGBQcVp+9pIw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VE1PR10MB3870
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230216_002354_277628_EB92ABB8 
X-CRM114-Status: GOOD (  18.24  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

On 16.02.23 08:37, Glenn Washburn wrote:
> Added suggestions from Jan.
> 
> Glenn
> 
> Glenn Washburn (2):
>   scripts/gdb: Correct indentation in get_current_task
>   scripts/gdb: Support getting current task struct in UML
> 
>  scripts/gdb/linux/cpus.py | 24 +++++++++++++++---------
>  1 file changed, 15 insertions(+), 9 deletions(-)
> 
> Range-diff against v1:
> 1:  f33ebe524590 ! 1:  c5a916e094d9 scripts/gdb: Correct indentation in get_current_task
>     @@ Commit message
>      
>          There is an extra space in a couple blocks in get_current_task.
>          Though python does not care, let's make the spacing consistent.
>     +    Also, format better an if expression, removing unneeded parenthesis.
>      
>       ## scripts/gdb/linux/cpus.py ##
>      @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
>     @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
>      -             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
>      -                                "while running in userspace(EL0)")
>      +        current_task_addr = gdb.parse_and_eval("$SP_EL0")
>     -+        if((current_task_addr >> 63) != 0):
>     ++        if (current_task_addr >> 63) != 0:
>      +            current_task = current_task_addr.cast(task_ptr_type)
>      +            return current_task.dereference()
>      +        else:
> 2:  8c3db2291f58 ! 2:  683d10e752cd scripts/gdb: Support getting current task struct in UML
>     @@ Commit message
>          A running x86 UML kernel reports with architecture "i386:x86-64" as
>          it is a sub-architecture. However, a difference with bare-metal x86
>          kernels is in how it manages tasks and the current task struct. To
>     -    identify that the inferior is a UML kernel and not bare-metal, the
>     -    symbol "uml_kmalloc" is checked for. If it exists, then do the UML
>     -    specific way of getting the current task struct.
>     +    identify that the inferior is a UML kernel and not bare-metal, check
>     +    for the existence of the UML specific symbol "cpu_tasks" which
>     +    contains the current task struct.
>      
>       ## scripts/gdb/linux/cpus.py ##
>      @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
>     @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
>           if utils.is_target_arch("x86"):
>      -        var_ptr = gdb.parse_and_eval("&current_task")
>      -        return per_cpu(var_ptr, cpu).dereference()
>     -+        if gdb.lookup_global_symbol("uml_kmalloc"):
>     ++        if gdb.lookup_global_symbol("cpu_tasks"):
>     ++            # This is a UML kernel, which stores the current task
>     ++            # differently than other x86 sub architectures
>      +            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")
>      +            return var_ptr.dereference()
>      +        else:
>     @@ scripts/gdb/linux/cpus.py: def get_current_task(cpu):
>      +            return per_cpu(var_ptr, cpu).dereference()
>           elif utils.is_target_arch("aarch64"):
>               current_task_addr = gdb.parse_and_eval("$SP_EL0")
>     -         if((current_task_addr >> 63) != 0):
>     +         if (current_task_addr >> 63) != 0:

Reviewed-by: Jan Kiszka <jan.kiszka@siemens.com>

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
