Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB539C636CC
	for <linux-um@archiver.kernel.org>; Wed, 15 Feb 2023 08:02:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:
	References:Cc:To:Subject:Date:Message-ID:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=W7rp0Npj+t53lfgwioJZ/+gHZ1nj5Biuj5Ra6NYvO1M=; b=xq3sAK82P2NmXsHMlVUT5n7WEf
	uMo4o8fS5nnOESCY22WijvTJEpq4jxNBv3Je/3adWuVdwNuEK6uUiwjv3gnT6fk2lOSsl1RPNBlO9
	GJQxpv4woqNuqlpG4GffjhYxtkPfKYhr6w1innxc3PFANnVZW66NA2v80iOB8h7tA68M8YqhnuDvW
	lWa0Rp2L5VkvXa1CFVdew4ul4SQl34AAEJmvl5ybskppPMDgAxKpdQf3yhOIRMJTjM2rOJb35QlFD
	SNc3zZHqTmMXF1T9oq9EYxupVqmIl3QhNBi9IDIV44pfdU9K6KRg6qJDpeYJiGEfTwYnpTRGztLZI
	vpKpVdQQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCjo-0057cz-DW; Wed, 15 Feb 2023 08:02:00 +0000
Received: from mail-db8eur05on20610.outbound.protection.outlook.com ([2a01:111:f400:7e1a::610] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSCjl-0057bk-4H
	for linux-um@lists.infradead.org; Wed, 15 Feb 2023 08:01:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eJlSZY3e3XK58dutvqen5wOeAQT0dgX+JhscZKmTYipvXwUkNV7CAIi7WJ6+fcmNwa8ix5Bl4KkV6um402wGa1FLiJzPDb8oiPBLJ1WFZV0xF7aPb0EN8joWVc/WAnom8ajzzQgxPFs3QCfpJ9PhLd0rWdR6SxGt/JqwdjJpGjgXyE37XaP16ql8jBBlQ9gJ/bPqey82U3E4HLskbarVBYVhOwROb7/y9qNowSKGx/TCyXP/eWTlhaowfkz7t/swpkr2xg7zeFXtfr6E0eoXitH9N+jKNYn7AtidE9jlOKvrdIjXIXKcc9wDJbz6c2CBr8Ja3ktXu9kNSug8k5suUg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Rej7r1wUPvqPPPTbRyW1Bh7EEkay9Wd10wchiRDy8NE=;
 b=OwoP5jq4pHrOpdUAWU/ui9/xRlZFoaXQp63VS22FBpEs693OnzgVoqliVLAjtHSmA1GUyxZPmVvy2zhIuhToqk9ORdMsIXBnjGbcmxvRBTd1+LZ7VXtVRmayS5bCHUY61pC5jxVx3GHXL1S1XmTRsjKTk0Po0O9B+5jHA7bFVe+YbJOZcSy0O0jaXrFXv+PpqlHJCerpEcLFr11WSpr2JLrzRirXnJI8wnT0DGmBbuO2iAFb1LwVQo9KaeuF/Dm0H/hxJ5+3BHAhWwLxYj1MELr9luvk8iLZFRIlBLCBsOgD89y44ZFNq4RYwU1z20pUWY5houSvGFfQ+gT1jlzaSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=siemens.com; dmarc=pass action=none header.from=siemens.com;
 dkim=pass header.d=siemens.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=siemens.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Rej7r1wUPvqPPPTbRyW1Bh7EEkay9Wd10wchiRDy8NE=;
 b=UefWxJPadRUndsKK0Quo3nZomG1nO3wrsOAccVLnjiHELjxQspu3ckpv87NLwPXeb8blH5BKM6MDhxoFtwaQNcziBK/8flVjJhYqkishdmtoK62s+K7dfg8LYjzgxD4qxpKaG43Lb7cGGEe3emKz9yP4W5gOQTzrtuzBaD9dghjqd2bdZzwaWufS/q8eyswkYEKXJWhuQRtUpsM9Jjem1VP1tz0cWC6tSx5Gz0XPVdQVgeVCbPfoccPC/W1SJU8wZCD7lcT0P+5oN2UvR8EjKj50G03JMBg/o6MW3PKQLk71lu/LkX7MXETstym4L5yBWhCCqHoSSDawuo6XXnnUSA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=siemens.com;
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:588::19)
 by VI1PR10MB7830.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:1cf::7) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6086.24; Wed, 15 Feb
 2023 07:45:52 +0000
Received: from AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5]) by AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 ([fe80::784b:e95b:b855:dcc5%9]) with mapi id 15.20.6086.026; Wed, 15 Feb 2023
 07:45:51 +0000
Message-ID: <31d49cc7-b6a8-8942-016a-9a2793e601c7@siemens.com>
Date: Wed, 15 Feb 2023 08:45:20 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/2] scripts/gdb: Support getting current task struct in
 UML
Content-Language: en-US
To: Glenn Washburn <development@efficientek.com>,
 Kieran Bingham <kbingham@kernel.org>
Cc: linux-um <linux-um@lists.infradead.org>,
 Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
References: <cover.1676416728.git.development@efficientek.com>
 <8c3db2291f583200a9036e83134ba363db492222.1676416728.git.development@efficientek.com>
From: Jan Kiszka <jan.kiszka@siemens.com>
In-Reply-To: <8c3db2291f583200a9036e83134ba363db492222.1676416728.git.development@efficientek.com>
X-ClientProxiedBy: FR0P281CA0037.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:48::19) To AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:20b:588::19)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AS4PR10MB6181:EE_|VI1PR10MB7830:EE_
X-MS-Office365-Filtering-Correlation-Id: 92e7a08e-5cd3-4029-4dd0-08db0f28a94f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 	G0GJM+vqOXIxFRtEc/mIrLNkdjcNVO5G6WjDS0MNLHTgkR13jv5+3vUhqkiBvaZLE1pdNl1/k7jxENPolrNkITCkmXOqWK/6BDU0HCRgYTSkO7bMw9upLgByzS2clkRM4eGE22iFsbE9cR6+slgb1iBHeLPQh9Dy15FNKfVti4Qq/Ng7VPhtWi/MpfbGlwMX6izFEYVqUDyVpFuXyVPuUyr5m4g/IPGLHsDGDdNRHJk7w42Xtqp0qFRyDVCyJzhLNglDKBe5nFVoxadsYl6tpLAQ+HP5HE5EVUz8f1cTZgiUDsa1udChGwPHD87ksN5BhsqW8qf6xJ3xkgoH9B3NO0faAHtNRRKA8fgXV1lq5mjJw97wmi15G4LtnO82n6nwau+oLDvCnWzTFUPPRGPa3w8OaVeqeFz4itqqShuOq/7j6hBl05zMkLJ33DoGKUrvVLoOFY3vbb0xyoGbNm5C6Y3nQy0BI2Iio6QLZ90JHV2lh79ZibW694c4lDNKUc6KgMSD2pSyuVsiqUx+eutVWoGBFUq9CT/XJNHArVo5Zui+1PlllI7eBU365Pu3AxfNizSMdn2ArDHUHjQhrufzFM5mfQ4bNIck6PElTFoB/W4sp0Zq+zNNz+vfq+uX1qIwAk8DkE0/+7PK81FcrEhp7nrLEzeRRr8d4fFJsYNNdmlbB0uxk+5gFDN3BHC8g2Pluery9mT0/NWw+Mw5iD8VSmWmBZwF6fPzlnNG5cDeQSI=
X-Forefront-Antispam-Report: 	CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230025)(4636009)(346002)(376002)(39860400002)(396003)(366004)(136003)(451199018)(4326008)(6506007)(41300700001)(36756003)(6486002)(8676002)(44832011)(478600001)(2616005)(8936002)(83380400001)(66946007)(31696002)(66556008)(5660300002)(6512007)(66476007)(82960400001)(26005)(186003)(86362001)(110136005)(31686004)(38100700002)(54906003)(316002)(6666004)(2906002)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: 	=?utf-8?B?SzdSL0ZzZlloUjNvbVA1ZS8wWUM5Z3NrMFRERVhQZDFzQ2prRkFJSG5oQXZM?=
 =?utf-8?B?R1RacHNhL2pQTURyOU8yYVRaNURkaVBEWWgvb3hhbmE3Y2tVMXdpTzhSVzhr?=
 =?utf-8?B?VTM0cHJMS01yRFBlbjFyVUxXUS9xYmdpaHFFZUJkbW1GT3lIdHluNDN6dzUr?=
 =?utf-8?B?cldERG1iZFRVR3hrSUpGUDcxMDBOcDVyMTJXSXl0c1Y4QmVhVTNXeGhiRkNU?=
 =?utf-8?B?Tk9iUjc2dzk4QUpLK3ZNUWwySlMyeGJ5Rmg0N1l4bXpTaGh4UUw0STkzOWJv?=
 =?utf-8?B?Q05pazlraFh6U1lvdTh0c1Y0akxqV1d5Y1UrZUw3Z3dmVjMyN2phMjhwYWla?=
 =?utf-8?B?ejJHR3p5OTVKTUh5aEJRMVRoSldjWm0ra2tNcmhSck81T3VMbExWL3ArMkRv?=
 =?utf-8?B?Ty9xdFAwakdKRGhDZFlaY01YTGppdmdVT2EzWEFWZkxaUzZDWFJXaG1rQ0lK?=
 =?utf-8?B?RURwU3ZlYWhMUzFVOGR5Q2Z6cm1wbmRXbU5IZytwMkxISmk0UzUzZ2hXOGNy?=
 =?utf-8?B?QzNJQTJLR2cvOVRXS3hBYm1iOUUrQ1JKanFnOTlxUmE5dHRabjg4M2JVYzV1?=
 =?utf-8?B?Wm90TXZxRzN3aWNKQWc1aEVacHVCRWd4elA2Z0xJdW9SSmlnR1J0UnJ5cC9u?=
 =?utf-8?B?Y2ZObzI2N2xrd3N6Nld6eDJ5c2k2UmFXWFFWOHZOOHhBaElud005cXRFc3J4?=
 =?utf-8?B?SU1PWUhUTVhBeXZXdk5MSE9zQ1FoZmtxL1I2N0pNdDdKL3dSK01qVWFHK1Zr?=
 =?utf-8?B?YXRQSWxNQUVVc25KY0ZqdW8yYlQvbFRIaWZ4Z0Jidkd4ZWVSbU9rbHN6azRQ?=
 =?utf-8?B?b1JVeUtYeFBpSnp3ODlEb2xNYzlmMy9vL3JjTldGVlkrM0VSYkoxemVzM2sv?=
 =?utf-8?B?dWxCNm92VmhJNnROZTZXaW5JaWwxZGxsTEhNSHFXRmE5T0R3c042YzErS3o1?=
 =?utf-8?B?YnRsaEVEOHZLeU0rZHhxbTJkTEk5RWduTzk2MnpDaUdkNitDN2JycHA2Q2Nv?=
 =?utf-8?B?NVRIeE4wZkY5ZnRjeEtLNzlFSTdwM2wweG9UaTI1OFRLeGJYd1BtbE9DTElz?=
 =?utf-8?B?RVNXMFFMNnh6bUxwSTFwQUFOVExoWFlRSG40NlM1UnNuSzRBOWNQSU1BSlZ5?=
 =?utf-8?B?cWtYNTVoYnVEUDh4M2dlSlVOZi9GU1IzYnJXdk1xdmF1SXlUOXlVVnlwTTZk?=
 =?utf-8?B?RE5PeWRaNUF4cmlQQVhCTTF1aTRVU2NoQzdxczF2K0VSU3VuL0ZLYmdKVS90?=
 =?utf-8?B?NjdCUFJPREQ1dm1WSjl3OG1QR0pCeVhUZXV6aTduemxGZms1QjlCbXBKY0tL?=
 =?utf-8?B?a3F6UUlJV0hWeE9YNENKZ0tQMzVab3ZGWjJhNUhFK2dIY1h6TXVJYUFXdzJh?=
 =?utf-8?B?dXRGdmMyRm9ybzlsazk2U2Y3Sk1JZ0M3RFI4V2pZNlpkcFprRCtpUUJoRXV3?=
 =?utf-8?B?c3Y3WVBJa2xPeTVBZVZBeEUvcmVvVkI2eVAwYTFRd1VDb3hNblJPTHI5M2xt?=
 =?utf-8?B?OXduMDBoRE14K1p2OWlCclZZV3ZpWXpjK0xiaDY4NlZweVpuYzZYR0VDSzhM?=
 =?utf-8?B?ajRXQ0c1RG1JeDYwR1JCejZEZUZMWUVZdkdNWDZmWjFlbk40Q2s3a1lJcWhr?=
 =?utf-8?B?ZC90ai9ERW9oU3A3eGF2RVRqVlNrRVhneGgycUhya3FJanhJUzhxZllMUUVm?=
 =?utf-8?B?bGU0SDZZaVowRlFPY1hUWnhmd2c3am9xWlIyeStlekZJd2tzbTJrc2R6WkdN?=
 =?utf-8?B?bDFDYzhRczV4NnpYbmlJa1FqZGxyQ0NtR2RBQitYT2NjSm1hbUJSQWVDTTBR?=
 =?utf-8?B?WlMwUktVemhOUDhxSmZoVm16cTYyWkVVdlNoaTNzaGtvVzYwdklNZURzREZi?=
 =?utf-8?B?MWlSZmU4eU1aa0FGajAray9TNDlydVdNVXBsQ29nTGRCZHFYNHJYTk53elBk?=
 =?utf-8?B?UWUzckJPRFpkbkVCSTFyR2tkeEdtU0RZZk53ZjhTOVBOc25OOXY1YjcwUXBC?=
 =?utf-8?B?OUlEOUhFQXhMb2oxWWRPdnhPVFY0SlArRUNPQjVmbUtMdjEzb3RGbm9jd2tv?=
 =?utf-8?B?QUsxV1ZoVE5xQ3JJTTRPRkN1cjhpRmovNFpYZ1l0ZnNoU0RUVXdqUzl4dVpK?=
 =?utf-8?B?QWI5a1RZQ1pQVFA4MXFzVFExOWpFMXJTZitzNGdoTFRXTzRPN2h6V1ZPbkZy?=
 =?utf-8?B?Tnc9PQ==?=
X-OriginatorOrg: siemens.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92e7a08e-5cd3-4029-4dd0-08db0f28a94f
X-MS-Exchange-CrossTenant-AuthSource: AS4PR10MB6181.EURPRD10.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Feb 2023 07:45:51.7649
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 38ae3bcd-9579-4fd4-adda-b42e1495d55a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: mIp/S6eupzi8W4aI662yrjt+VMHdKEJVihq0lDgo9GOneke4VEep62pAGmgLEs9iIkZuWKyQHeklWSlGvD6V3g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR10MB7830
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_000157_538278_0B3EF904 
X-CRM114-Status: GOOD (  16.95  )
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
> A running x86 UML kernel reports with architecture "i386:x86-64" as
> it is a sub-architecture. However, a difference with bare-metal x86
> kernels is in how it manages tasks and the current task struct. To
> identify that the inferior is a UML kernel and not bare-metal, the
> symbol "uml_kmalloc" is checked for. If it exists, then do the UML
> specific way of getting the current task struct.
> 
> Signed-off-by: Glenn Washburn <development@efficientek.com>
> ---
>  scripts/gdb/linux/cpus.py | 8 ++++++--
>  1 file changed, 6 insertions(+), 2 deletions(-)
> 
> diff --git a/scripts/gdb/linux/cpus.py b/scripts/gdb/linux/cpus.py
> index 289f0bf4d2a1..90908653f6c7 100644
> --- a/scripts/gdb/linux/cpus.py
> +++ b/scripts/gdb/linux/cpus.py
> @@ -163,8 +163,12 @@ def get_current_task(cpu):
>      task_ptr_type = task_type.get_type().pointer()
>  
>      if utils.is_target_arch("x86"):
> -        var_ptr = gdb.parse_and_eval("&current_task")
> -        return per_cpu(var_ptr, cpu).dereference()
> +        if gdb.lookup_global_symbol("uml_kmalloc"):
> +            var_ptr = gdb.parse_and_eval("(struct task_struct *)cpu_tasks[0].task")

Can't we use an UML indicator that is related to the topic? Why not
cpu_tasks itself?

> +            return var_ptr.dereference()
> +        else:
> +            var_ptr = gdb.parse_and_eval("&current_task")
> +            return per_cpu(var_ptr, cpu).dereference()
>      elif utils.is_target_arch("aarch64"):
>          current_task_addr = gdb.parse_and_eval("$SP_EL0")
>          if((current_task_addr >> 63) != 0):

Jan

-- 
Siemens AG, Technology
Competence Center Embedded Linux


_______________________________________________
linux-um mailing list
linux-um@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-um
