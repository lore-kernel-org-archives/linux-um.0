Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3B63EC64ED8
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 16:19:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=yPrYJt1/wmRvjvzCQU0oXSN9XEa6KXB5/FVLOJlROe8=; b=AuOfX7UJatT38/lrmQWAlVIvBZ
	RmkDl6xTNj0xRbGzNl5/zrS8d07aNpfNcTTWodkOdBwi1QMPGuAzDcMp+3EBbZ31l6RaJYIk+OyIT
	wBV0ZZXoUgzWsj3KabsHiw6PenXU+4DSJaYhcVz11KsliTnVv7RRIjWf4E5YsMVZHtTOWl3LxaDgD
	1N4zQryVe8ObQiLQRaeO/tdwobH5hxbV6yf7Pk1PVtUjKuFiixVyCMgSp5arIg8x5eWhlI0DNl2Qo
	JW3GqxH4uyk/Zb0ltjT3B/EOsign7MmPUxMKGUcxiCfcn79Xz1R48GX2IsgswdNlqFeCt5QhMwZn+
	OHw4p35w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSKVA-006WQx-6y; Wed, 15 Feb 2023 16:19:24 +0000
Received: from mail-dbaeur03on20606.outbound.protection.outlook.com ([2a01:111:f400:fe1a::606] helo=EUR03-DBA-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSKV6-006WPS-SK
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 16:19:22 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Gvwi4mIVrRX4bmK50qVfdfpP29PHh1yvKOi2UgoqpgKbU8V2yrAj4wMeUkIPzpX5qvha7Q2khuF+Tm/uZ19q1cv6Fe3zH3EcO73spd1n1/vJZY0ygAHQvl3TJlt3KkJZK0VhxFORo3dX9YN4Xzawhc8XIFK1W/X/VxdWcZpcKC/Q1MrY1Cw4jC4sVBnAiRgPpu67Vz9amgKcDWmwd3IGAO/VgW1d+3FX0s7spEJfOX1Qc9E8JZ5qUXNhSGQIIqfwBYeRgxWB4KlHM3fGauN5VgOR46R1ZE6e1v4CZwYyT02fZafp2cpVGKGWGwFend2CpVzTXlmpwgyW+muqLdaItg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zjyCNMRA7m160LUUPieRb4M45MrZ/IECY8zx1sMInMY=;
 b=frSz47yY7VF02cG1SqJMFuYx1GzlaCeDx7KQJbaK99cXaCIm+0E3uNqb441FxpYPb+mu3iNuQ22PYTLIlvs9rWY2jdVkvbjP4l4WnGZfZK58i6xmsm3OQ4a8M8Jv+9y8/E0PjI7ZqLTQC9rgCEwAi9XVnXALjk03jQ3quAD3jPKntNOzNAUlv39P+qqH+Dj1qBxjU4lPpXvl86Fwx7IPMeXgfZ8H/tHBtJyTt4W+OalIuJZzrDzhN1+24DI8WvVC1FX/7BziPRkXS+BQ2IBqOBwg45dUn6Llzzvka0sFe/D5mOkZrpNVgiMpEVmrG0bSEkzov3jOF13A767Dxebzwg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zjyCNMRA7m160LUUPieRb4M45MrZ/IECY8zx1sMInMY=;
 b=hBnbQFXYoA8GUn6rBGkQVSU1zC2A+gHKjWz5wKb42rCNdBtTN/YOqMSUkZNZp5BqCG8kC8N5qooRlyUqNiLFv7zaWna/a/8UQ/DBfGSs5FR8VddZmIHH5FcEirjaWwe098PMji9jVdWAcWX4yW4ws3QuzEe0QWbHvCfFLifXWZjuRHXEyX3sI18eE7bpX8NiI6z0aqRsXS6/CrkU+issYNXX6a9/DoztFAE5Y33UXYerm79RylTi53zhGzAlXfaLluGz7A5gEMXHhO2ZUse+eQBQN86L8W/qxAeMGemK0dR4psn6C+0SLuQ+mAdSOJiuiD8T+nC3jK54YUmaotVw/w==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by AS2PR10MB7850.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:649::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.26; Wed, 15 Feb
 2023 16:04:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 16:04:15 +0000
Message-ID: <fc3417a6-f09e-4dc8-e684-ac0dbf59fa4c@siemens.com>
Date: Wed, 15 Feb 2023 17:04:13 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] scripts/gdb: Support getting current task struct in
 UML
Content-Language: en-US
To: development@efficientek.com
Cc: Kieran Bingham <kbingham@kernel.org>,
 linux-um <linux-um@lists.infradead.org>, Richard Weinberger
 <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>,
 Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
References: <cover.1676416728.git.development@efficientek.com>
 <8c3db2291f583200a9036e83134ba363db492222.1676416728.git.development@efficientek.com>
 <31d49cc7-b6a8-8942-016a-9a2793e601c7@siemens.com>
 <20230215095529.169f7b0e@crass-HP-ZBook-15-G2>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <20230215095529.169f7b0e@crass-HP-ZBook-15-G2>
X-ClientProxiedBy: FR2P281CA0136.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:9e::18) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|AS2PR10MB7850:EE_
X-MS-Office365-Filtering-Correlation-Id: b9297f02-77b7-465c-60d6-08db0f6e491b
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	1nVy1OnUynSIrR4A0H1Pw4tQVrMu+eqdOrWPdIiUFuatSX7cjRjPdpDWSE/Qg12gbGoQnMkyTCxsKkLxuyqHkHL+LLgYVSPZvF//QX2eJbI/2ODGnLTCsLkiPc+K1IbKfDQb+gdjfWCeCPxf8/mq++NqRmQwrxfjiftDYpVgf8OpbnkWLttYfmW87umwUuk/DM9iD/Ldq6953MGozKFg0jvhg+Agr3Fb1MatvQ5SW5hjD4PQm0MrsE4BuBkYn1akPnjkvIkoCCUpuU2U7SkmoQWUswrDSSZCZtbI0ZnVOr65Nd6uR4h9oGMRK+tMm3hs2A74qMOzzssxZebMPK+EAxrewMf3blGt0cm1o4oX03FkKqYo4hhHvG1bCNtovYKG8a6sij2L9SauE7+7FS3UReQYYEivL7Pem+deH42gvuK95jR0V/AVLe2OWIo5486Fkv/NQdlvzaD41nOBW9Zpa9c8u9ZbAqVTmyYrcTD2+mARQpmwL9+ws3rcS46eRPLvXwnkcbKuntTVJroZpRV+oZyXLPSoI/jvVNItdKOP83TjahRNXesUIQ6SAuj46LsuV5BDFos18Z2hzIXq9UA1xP4N8Cv/Ji46cdHgB13a2oc8bL4PgMAuZhbdKvyGJW6Rs6TMWXVHA5fyfd7qj1EmAHz9qxWacVD+2fs4hb54ScADnp0JsdVuWd3232zy3G2nN0Ikh0Zs9dIFDFAEmrEYI5JRPIFQNkOCZ2gy2H+JIiGWfauzi6VRuHz5tRf9jAr8Qvxpntw/AJ4Ngr8cr/UrOvLTscrhagw21IF0HzLu7As=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(136003)(346002)(396003)(39860400002)(366004)(376002)(451199018)(31686004)(36756003)(82960400001)(38100700002)(86362001)(6486002)(83380400001)(2616005)(53546011)(6512007)(6506007)(31696002)(186003)(478600001)(26005)(66476007)(66556008)(66946007)(8676002)(4326008)(44832011)(316002)(54906003)(5660300002)(2906002)(6916009)(41300700001)(8936002)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?aDNUZm8vdjdoNDRaZ1hhcVRDclFOQXJrUmFIOHh4bUNQR0FzVWM1WGVDSlMv?=
 =?utf-8?B?MUNqZSsyb1NXQ1JGekdwb0N6RUxoblVHOCtMTlFlQWZNMm1ncDZMNElZb2Ew?=
 =?utf-8?B?RkxpRi9BZ3RKZ083eGdxSlBzMU9nNjZVQjA2NVUzZDJMcFYzS0o3cW1mUFVP?=
 =?utf-8?B?dE9BL0NuVVY1WjBjWlRVRzFXZFU1N25RWkhXTW1mVW1NVjRrVFhCc0UwR1NR?=
 =?utf-8?B?a1dIcTBFbGZDRzR1OVZDNFVDQVAvcnBDMkZvSlJYYkNDa2hVckdTbVR3U3k2?=
 =?utf-8?B?aGVPQzRNelYrZEJ6U2psY0F4OU5OSUw5WmVZTDZkcUwramEwMjhzUGdHaFo3?=
 =?utf-8?B?RWttRVNTNksyYjNWVU84SGF6bi81VmMxeURjRXU2MW5YYll4a3AyNFVXYVFV?=
 =?utf-8?B?Q1pjZXJnKzVDYk9Jc2VhZmo4emkyYnhpa2ZmQ1ZBcWVES0c3Q00xSEw3dDlC?=
 =?utf-8?B?MG1LT0tEbndjQ2VjUWJJVHBrdFQ4cC9ZRWMzSmF0WHpkYjIrL1hrdlZpRzEw?=
 =?utf-8?B?aXdVVVBOMURjTnhoWVNRd2R0Qmt4Y0JQK0RhR1V3N0lHMXMxTDhTY0d6N25u?=
 =?utf-8?B?OXNsWFNzN2c4eE1JaUFaZ3dvQkFpYXlxVTYrY0ZZRGlYZEs1NDV5Vy9QL0Fn?=
 =?utf-8?B?aHJkc0NacGVXcjBPclNlbmZBUENCYldzNjRXOG5UdWQ2SEZZTUlUWkU1ZnU4?=
 =?utf-8?B?am5HRXVKdllGU0pEZERPaUxMUWNsdUZJVXdYLzVJaGVzQkpYdlYzdXZPa0ZK?=
 =?utf-8?B?Y05KNUxJV1VsdmMrRXlodHJFeUxOb3JrV3FUczJ2aHllZHBjNDQ3ckVFekk4?=
 =?utf-8?B?aTA2RFVWTHA5SkFaZ3R6R2VDTW9IWXcySU5ISDlWbzRDY0VrM3psMkVZTENa?=
 =?utf-8?B?OWRLMGhDRUZMNndpenlqcGM0WExSWVFUbjgxemVLbTF3R0VzN3VJYzNCR21X?=
 =?utf-8?B?QXNyblMrelNmcHRnU3VmZnl4bndVWVQ2WHJtYlEzNjRhdDJNVkpnVE5sMjQ2?=
 =?utf-8?B?Y2VDVWpCc3Q5cU9MWk42Y2pZczEvNEZsRHo2cHNSbGIwT0RPWXFmZ2N3byt0?=
 =?utf-8?B?NXNtRy9ibU1pRTRxdG9ySjBpTmxhbnIzbzJydTdjbDI0bDBBQWRNY0g4UHVX?=
 =?utf-8?B?cS9mWUxGNFNDWVlJeHA2R29wNXlIUkozK2VTTDJiVFVNOWdYVGFRQ1NaMzFr?=
 =?utf-8?B?WDFKWUxVTzZjUnFsdjAreis3MzdpaUU2cGVzR0dyTk1Pc0Q3b3oyVVFoMWoy?=
 =?utf-8?B?azlRNklYdHRvYWxqWThsWElvQW04YzBxL1dQSDQ4OEl1L0ozSGU0ZnFmSzBs?=
 =?utf-8?B?UFpVQnpYM29TRkp3aVNGaUVSbDNCT1oxOW9uUmp2NytUcWFHbVFSY0JINUx1?=
 =?utf-8?B?T1ljdjFmS2lDWUJaWlBBaUZzWWp4OFptSmh5L2h3VGQvdldtR1NwVDJhREFK?=
 =?utf-8?B?MktyYnZoMkJtNXFTVHJnMjRlRVc4dUxtUE9La0hrWkwvUlVrUzNEd0JXaEFI?=
 =?utf-8?B?dm02MnZpeEloTFRLR004bGRhYWVlSUhKTGpPVjV0K0UraFZZVytQcVNjcjVE?=
 =?utf-8?B?V2ZzMlhnNWkyT0I0UmtiemJnVG1NQ2YxK216NDhSbEo2eGlhb2dLUmpUYUlP?=
 =?utf-8?B?STk1cjMvWVFXWHk0MEl5a08zeTBCYnFhUnk1UUF1T1pjN1RPa2NNbmNvL1A0?=
 =?utf-8?B?dFJLRWtJSHdJRzBkc1V3Zno1WE4rOHZBOWFLdUlpYk4wejEwUTdSb2x3Ylli?=
 =?utf-8?B?alVtaUdJbGRKODV2QTQxOERCZHhVazdOenVSeWJnaFp5ZXNEck9rT0kzSkQz?=
 =?utf-8?B?NFJLQWlRUysrS1VneVJMMkI1cmZrRU54MHV6YUZ0RWtpTUpubHo0SkVQSjc3?=
 =?utf-8?B?RzNnWXU2Q0VBaktOVnZWMTZBRGhKQmVlT21MSzJ3bFlsNitxWG5wa1BBbklB?=
 =?utf-8?B?V3hRRU4xUC8wMTFHTDZoWmNRVllUejhzUC9XN216QTdxUTZmSnRWM0M4bHk4?=
 =?utf-8?B?dEZ5ZFpWK2g5disrNkFKbUoxa3Eyb3ZwVWUySUZ2eTY0dHJxVmdKcGNFdkxD?=
 =?utf-8?B?UnJDYlZyN0lqQ1lEMDRZcWtJZWYvdXI2ZHFyZ0hpVExybzIyUVZkWldqTndi?=
 =?utf-8?B?cnRUaHlXVTlGMktabXdGNDM5eWtMMkVyKzhiQWZCQ0tDY3VzV244blpwZ0No?=
 =?utf-8?B?MEE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b9297f02-77b7-465c-60d6-08db0f6e491b
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 16:04:15.1500
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: z2IfLD/i5HPF2nvfYabGSlwcN024x/nF77Ks3AxBVyOeWXdcBiNhm9pzMrOc+0hji21d3WOnXwDZ2bvluWt08g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS2PR10MB7850
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_081921_180029_1D9417EB 
X-CRM114-Status: GOOD (  18.45  )
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

On 15.02.23 16:55, Glenn Washburn wrote:
> On Wed, 15 Feb 2023 08:45:20 +0100
> Jan Kiszka <jan.kiszka@siemens.com> wrote:
> 
>> On 15.02.23 00:35, Glenn Washburn wrote:
>>> A running x86 UML kernel reports with architecture "i386:x86-64" as
>>> it is a sub-architecture. However, a difference with bare-metal x86
>>> kernels is in how it manages tasks and the current task struct. To
>>> identify that the inferior is a UML kernel and not bare-metal, the
>>> symbol "uml_kmalloc" is checked for. If it exists, then do the UML
>>> specific way of getting the current task struct.
>>>
>>> Signed-off-by: Glenn Washburn <development@efficientek.com>
>>> ---
>>>  scripts/gdb/linux/cpus.py | 8 ++++++--
>>>  1 file changed, 6 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
>>> index 289f0bf4d2a1..90908653f6c7 100644
>>> --- a/scripts/gdb/linux/cpus.py
>>> +++ b/scripts/gdb/linux/cpus.py
>>> @@ -163,8 +163,12 @@ def get_current_task(cpu):
>>>      task_ptr_type = task_type.get_type().pointer()
>>>  
>>>      if utils.is_target_arch("x86"):
>>> -        var_ptr = gdb.parse_and_eval("&current_task")
>>> -        return per_cpu(var_ptr, cpu).dereference()
>>> +        if gdb.lookup_global_symbol("uml_kmalloc"):
>>> +            var_ptr = gdb.parse_and_eval("(struct task_struct
>>> *)cpu_tasks[0].task")
>>
>> Can't we use an UML indicator that is related to the topic? Why not
>> cpu_tasks itself?
> 
> Yes, I like that idea, and makes a lot of sense seeing as then we're
> sure cpu_tasks exists right before using it. The one thing that I like
> about using a symbol with a "uml_" prefix is that it makes it obvious
> that this branch is for UML kernels. I ultimately decided against a
> comment because using uml_kmalloc seemed self-documenting. Do you think
> a comment is warranted if I make the suggested change?

"uml" is clear, "kmalloc" is not so much again. No perfect fit, but I
would leave a commit in any case.

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
