Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DECBC636CC
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 07:44:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=MVYmOw4owgQ49IY+hqwNEBMKwjO083XzECWBRFqdUMA=; b=bSiZtziZOVe3cADDu67lPV2D91
	JhZ9GA6kY6GpJPGjDFKDPfr9xULMqdceflvHE+Js0kYZhGYlvBCwseQHBAKPh0HgH8kw5/WAp1+0k
	ytO1xKmtmnqxG17zibCuWrbFVcgrlaVSBZzlaQ4IiM+slaEDHGZBHW4Emxahec37tUlndUqA2ttt7
	i0XNc2I+LF1zcyVBhIgL+bFSmWVwGgwFI2n6ZGPDyII0yq/Z1cnZgmozdiXpv11qTLFywdSQ8Ods0
	WyrK63ArXZnnAceaPmM48OOlY3xfX7PGNM2ENGt34XPWOh88hVx3GfxHOro8vz4iq5uPXNLQtmcq/
	CghZ16XQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCSm-0055Bx-QP; Wed, 15 Feb 2023 07:44:24 +0000
Received: from mail-ve1eur01on0607.outbound.protection.outlook.com ([2a01:111:f400:fe1f::607] helo=EUR01-VE1-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCSk-0055BA-01
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 07:44:23 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XAYT3MKokl3++9s5HwuQzFmXv9yLWbg9d/fQfJvE29IZXccYFSfrt327AWdS43meTJjBiHFZRUvgK5hdsi9OFSQK8MADOmiHogNumsPBhfJpQA3JkO8yUSlf25d2gNN+3v2cNQalcITgCpWcuIp6pcNeSmuY1K6HtkB09n2aETwEraigSvWoVvOxbrT/QCiXAG4oLLbsmmZWTgryR1TxLQZaBVximwQlrDrWkdcou9HS16sARpkbiI3KDb/b+GX6xnHhJuoENbzfP5RHX8BTxZdsdXyoCEVXcmKXgCwTkYie3TJtcFq/ldDzcIWD4vTt9iUbgdozQk0DHLdmdSEj4Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wPk7f7ws1ZsxeoGg0o4Yp2iLPyC4MOV9FbLV2blu74Q=;
 b=e8RFr3MQWW3AonFfFYPV+Jd5RUwD3jkWbJ4mamCG5iHKcZirqrCJy9bFh7KHyEOWeSbfTqkGLdPjejmT5HxV0ZnN8JRlbkQzJPEB5MsgJ9oCrzmCeWhUrbo0SvPCzgnjjAecDyv7J7n7hzkUe8U3oIIDq/svU4YwbfyM+F3eLt4iKtBQ4pWZK4UhWGOU0pPVEDPcrvkf3CrLsLfiovhM5jgusl0j+CVvl4Z9NDIJcZJrjNg9yXN5AJVIc5ydciLcqNudqxfktCGa59ayjtEjD6Fd37OFsbUW/abebYxZ6ufFAlg4oMn6ASABNlhMXirZVCTdlfIHr+xfuMo1RLEpRw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wPk7f7ws1ZsxeoGg0o4Yp2iLPyC4MOV9FbLV2blu74Q=;
 b=KJ0zwTFdncwTEnYvMvbwiWY9ClHbsGgKCRL1Xe4X2qXfTVjC12oZ/byYLNPxGktHgIul1r58sl8TbftPqadUjvrPto3VZObkdqnvuEx8SFjJ17iEa/JKwT5CqkFGjrWWzE7MqSTSrLkuIfV4QibGpyvjHLkTBr4gMV57MPe/IKfJTP5ZjlCgDkwHJxi0jxljYuQ5+7LM7+WzPnsNZWh+/DvRjYkX/vcUFGKFqa/JsDoBtJaKE28c41O/7zy5W4K5LSh32cM1SIbxmTSMcUJVk4shU6PKmnRdp5mc79VLRePc8w+daF7SoPwsxpJepasbEhhvhTuA43/Yr4q0unkJmA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by GV1PR10MB6098.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:9d::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 07:44:15 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 07:44:15 +0000
Message-ID: <76578d08-0faa-59b5-9a51-444446125c4a@siemens.com>
Date: Wed, 15 Feb 2023 08:44:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] scripts/gdb: Correct indentation in get_current_task
Content-Language: en-US
To: Glenn Washburn <development@efficientek.com>,
 Kieran Bingham <kbingham@kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>,
 Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
References: <cover.1676416728.git.development@efficientek.com>
 <f33ebe524590314238b48fe620c9af717b1db096.1676416728.git.development@efficientek.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <f33ebe524590314238b48fe620c9af717b1db096.1676416728.git.development@efficientek.com>
X-ClientProxiedBy: FR0P281CA0049.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::15) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|GV1PR10MB6098:EE_
X-MS-Office365-Filtering-Correlation-Id: 5369e419-aeeb-48d0-eea6-08db0f286f66
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	3hMZfg64CNRsG6Osj9Wgx0BhDYqIc2DJWFKZn2Q6wU/VzbkK3ribSKTg+O9Xjs0/R2KM+o+7sGjQvKP3X1v7YjWRtJ+rGIvT/AsCu7Zdvdg1dBn9hMmBP7PFTov8HKomndSkRJegx/qmGsK6by6QZA/AqWgCp6zmCTa/76II1lP4vSECqQzX2AyzpArArCsFUJZ2hUBp9866sgSrSqNCSgCfQPj4tzKqLiO6kZi+S+050N3he/A2AD1UH6zsmL+sXplIiUFXOTf1sXgB9bYNTt5npJ9gwiWeT+bHND2GHjVU2JKhTECoyEAyS5ja4yj6Hp/7ESkIhG1lXUdLrKgX2X9xcsAdRzmbQRS6WM2Xxd2G8u3+8kmIe77rPUYNfj9l/YnhVIgso+LEuyUESLgVJUMxVmfjnQChnqIbRUiGYwecEqg/6d17MBeaUappn/96rRE9oCcgwYYDiF1qC55HcPbldPs6MK7UNDsXZgsi8fIsG/AdCnsdM9qIjMGFmPZKHgYOiwcW2Qv7ax030psv/9JA6TJI6yRZQfnJobLeaRGJqjp2CcOKaSIy6SYbfGV3ZSqfEHd8zRXwf43gfpvymS3wCppy98sndqM5gl11yKKEHURNFE3nRtiMSExKBwzIUYFqIjEhscaVjH5B5MaP7cb6fQj3qRKg3qTvQD0Swo6MFJGUzR7xnkk9kZoLa4Hk2Wu3UQttoiULmJrbzYnSUtK8RT1ssG4p7bhprUgQjfE=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(376002)(366004)(39860400002)(346002)(396003)(136003)(451199018)(478600001)(31686004)(6512007)(186003)(26005)(2906002)(82960400001)(53546011)(44832011)(6506007)(38100700002)(5660300002)(2616005)(31696002)(6666004)(8936002)(41300700001)(86362001)(316002)(4326008)(6486002)(8676002)(66476007)(83380400001)(66556008)(66946007)(110136005)(36756003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?azI5VGVYaGVROWJGUGdweHI1OG5ZY3BNeWNrdFdyU1NMNGJpd29hNng1TlRt?=
 =?utf-8?B?UmptalM5ZCsyaWNZaWJNbXJ3bEl4OHJ0clY2bGVncGEvRFlnTUhtM3VEOXVv?=
 =?utf-8?B?eXlMUWhOejUvdlc1NGFRVUUrT25ZMjVsUXlzSm9jcEpiZmd5Y09zVlYxTmN5?=
 =?utf-8?B?dFdVUkxFK3BZc2RyMGVGNWtkeUgyTnh1eUNwOCtOc1IxKytrQUpvNkVtZkZE?=
 =?utf-8?B?K25RbnNxejB0ZzJjZDBLUUFJRmFlYzFPajgrcE45YXNTbEc3WEhHMkI3WElI?=
 =?utf-8?B?U3NXalZOV0xxV0VVdFh3Rjcxb1lDVUtQNTFGTjhoZlBvWURjUVZsQUI0WXYy?=
 =?utf-8?B?RmtSNzdwbCtta2JBdE1TYjVBQWVaYVpReHlnUUE0V2k3M1RvS3RaYmlvbmVo?=
 =?utf-8?B?UFdZVWJRV2FJZlplanJ4TDlCMmhvZ0Raa1JnVStya3dINWg4MEsraWEzLzFK?=
 =?utf-8?B?ZzJTN0tsKzlSaGM3RDdZaXdscUlOb25TY001Umh5TUJjYVpCWUlOY2lWZ1lT?=
 =?utf-8?B?RTA5dDlpeG9pMlQyV25uQ3o2RUo1dmIvakdHSTlkbCtHVDhGVnRIdisxTVh5?=
 =?utf-8?B?Ymx3ZXhhNlV3ZFVjdm9lNVUxdVhJQ2QwbWphSEx0aFlSV3NFb2hKLzdWRXVH?=
 =?utf-8?B?V1dnYVBBQVJadEhJOWFla1oyek4zQ1h3c0s2cFZzaGMvaVRxTmc3Q3YwcjdX?=
 =?utf-8?B?cUVJb05pV0M1QjVSMWxmaThuSmNTTzdYTkNZZ25Mbk11TlpLSnFyMXljK20y?=
 =?utf-8?B?M29KQ1UxT0tBS3BwMHNScWZtNTNYdHZPMGRuWXJmeEtTZEdvMGc1MjdNYlFa?=
 =?utf-8?B?bmk4dUZDOFNOd0tDQmt0ZFRWT3pXZ3pYRmdTZVl0bUF6RTZLZ1l6aXFsWHdP?=
 =?utf-8?B?cGQyQTNYTndqVk1FZWtYazgrbzQyY21BVkZyRlNKY0pBRzlOK2RtT0I1ZDFQ?=
 =?utf-8?B?MFU4bnQ4MkR0dmRBcVVlWExyWlRLRjlmemVDTXZtUnZlTU5jWmlEcG9nNHA3?=
 =?utf-8?B?SzZSQmZWUTVwUGFHTVZTeDMvSTdyNlo1ZHNrZCs5MmdBaHBGdUE3ZzgxNGhx?=
 =?utf-8?B?bWZHaExveUtEY0ZjOVQ1aUhDNEFGV2l4WS9nbndPMitacFNMbmZQMjRCSFM1?=
 =?utf-8?B?eThFUW9zVytKSlRWZThOY2E2ZS9aekgva1hOaWF5eGdVTWJyUTcwWFFhbGhY?=
 =?utf-8?B?Nzg0NDBSK1lxMDZ4b3IvQVZTTzdnOStEVVh1U0tvM3BaNDVRYVk3ejdIZEg4?=
 =?utf-8?B?ZHVRQm11em5kYUsxRmNndUZ4cWowa05LY3N4elZrMlorNFZ5bGI5SUMxYjV3?=
 =?utf-8?B?UGQyQjZyWnhxLzl3bHJGeFlURy92S1pWajFLYWNGNG9FUHhid29GT2JSdURT?=
 =?utf-8?B?cE9kQndjK25BRTFvVm80UWI1Qk5zNXBIL2hzTU1MRTV5Y29EWXJXWERPQ3FI?=
 =?utf-8?B?cWJaMW0rMGJnTmJJVmtNeVZER0o4UG9LUlhGMHBjODBjcWExcEdlQVNoVE12?=
 =?utf-8?B?SW5DNmJ6T21ic2VoV2l3Z2RVR0pyRXd0SUlzMXY4ZjNEZDZoaFJ0UlBmeklZ?=
 =?utf-8?B?ZWF0bGFQQ3JjRmhBT3d1SzljaXRBcW5zbk9QOWdTZU1xQnM2RHVzZVk1Mi82?=
 =?utf-8?B?bnphOGJuYzZqdnhPeWF4Rit3VmRiOTVKWEVEMzJLVmdPREpHWjBtamxXekgy?=
 =?utf-8?B?aW5JZG5NTDczbGdHTE1YbkdCYVFvRkNTcDI3djQrdzY2Z0lWT1c5YmJMYUll?=
 =?utf-8?B?V1EwKzlBaVNnSDAvUjgvdC9FM0FrdkNxTTVmYkx6RWU3WE9WUHd2UTl3TUpP?=
 =?utf-8?B?bnl4ckNLRnB1VDJwSFZHc2NTK3VBSnowa0g5MDRXN2Q2L2lFZGQvWGdMbDRn?=
 =?utf-8?B?aXlHOEZLRVVESC9hWXRGRCs4bkxVNjk2WEN6TWtMdFhNYzZWUHhEK2dTU0pE?=
 =?utf-8?B?OVpUaytGVjNkeGIrV01Da3hpM2U4Sy9kWUR1Z25DWGh0aTN1blNrTWIySEI1?=
 =?utf-8?B?Zm1QRitTbmQ3THdjL3lpSVNrOWdzQW9tWHJnVlJJVnczcis1M0Nlai9VVkxW?=
 =?utf-8?B?ekovTWU2T2FTSmtBVlpvRFBjc0hDNzVmeEFRaGJkK29lakkrRTRmU09qaGNs?=
 =?utf-8?B?akdQektiOHZhM3M1ckt6UTViZkNCbk05b09IaHRsQVBDbVhDWWtCa3BpeXlE?=
 =?utf-8?B?UFE9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5369e419-aeeb-48d0-eea6-08db0f286f66
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 07:44:14.6119
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mOZy0rcFSYzoTjpvsyCIAFrcKovrmRwAR/gNTBonBCvFEVcm0uLePGcJ4++hJicwcxFa6g0ap/bkdsdMdEVkcg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV1PR10MB6098
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230214_234422_475186_C4771E01 
X-CRM114-Status: GOOD (  14.19  )
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

On 15.02.23 00:35, Glenn Washburn wrote:
> There is an extra space in a couple blocks in get_current_task.
> Though python does not care, let's make the spacing consistent.
> 
> Signed-off-by: Glenn Washburn <development@efficientek.com>
> ---
>  scripts/gdb/linux/cpus.py | 18 +++++++++---------
>  1 file changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 15fc4626d236..289f0bf4d2a1 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -163,16 +163,16 @@ def get_current_task(cpu):
>      task_ptr_type = task_type.get_type().pointer()
>  
>      if utils.is_target_arch("x86"):
> -         var_ptr = gdb.parse_and_eval("&current_task")
> -         return per_cpu(var_ptr, cpu).dereference()
> +        var_ptr = gdb.parse_and_eval("&current_task")
> +        return per_cpu(var_ptr, cpu).dereference()
>      elif utils.is_target_arch("aarch64"):
> -         current_task_addr = gdb.parse_and_eval("$SP_EL0")
> -         if((current_task_addr >> 63) != 0):
> -             current_task = current_task_addr.cast(task_ptr_type)
> -             return current_task.dereference()
> -         else:
> -             raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
> -                                "while running in userspace(EL0)")
> +        current_task_addr = gdb.parse_and_eval("$SP_EL0")
> +        if((current_task_addr >> 63) != 0):

At this chance: "if (current_task_addr >> 63) != 0:"

> +            current_task = current_task_addr.cast(task_ptr_type)
> +            return current_task.dereference()
> +        else:
> +            raise gdb.GdbError("Sorry, obtaining the current task is not allowed "
> +                               "while running in userspace(EL0)")
>      else:
>          raise gdb.GdbError("Sorry, obtaining the current task is not yet "
>                             "supported with this arch")

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
