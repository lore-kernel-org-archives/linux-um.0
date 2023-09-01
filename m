Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68A9ACA0FEF
	for <linux-um@archiver.kernel.org>; Fri,  1 Sep 2023 18:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:From:References:Cc:To:
	Subject:Date:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SdWdAjCIytiMstL0weEg77TCU2GGI/h4qizDt5wm16o=; b=K9b9VFYt+eB2VxG3ibTn444hGA
	+ICT7WUV0AseuNg0JGmb05vxrtF7d/nPBo7AbhQuwiUHJi6k75fkRfRkkcWk8MOsqyGo4PNS0XG4z
	GiXd6c/UBwkbbeYwvgPrc0ziwQ5tM8NgDnLgBeMWcEWV6ZjcJ0zNDgQBjtr9rNjxf+XL+AH1B72Nw
	0VuKA3Y46eg8+h/9lg1smDrPiGw6zJGE0y03SebRwwcE9joMq5YWvRWO1ND71hNtt2/s5AszO/4Ce
	VAEti1MJniC5tIixecPaJYllCqOLU0M2Uw/JZrDuHojnBH2C1KXuVSh5ytSJw0KqqoxxbGD7i5zkZ
	BlSptyew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qc8Rz-000GDi-2L;
	Fri, 01 Sep 2023 18:00:55 +0000
Received: from mail-am7eur03on20628.outbound.protection.outlook.com ([2a01:111:f400:7eaf::628] helo=EUR03-AM7-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qc8Rw-000GDF-2x;
	Fri, 01 Sep 2023 18:00:54 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UH42Pg7xVskRIjRUCMfopOszwBXBVVO1Lr6LDjr2I6Wiw2vpY+vwICee31VM9LC6UBma4YGOLPegKnjNynTcc0Hq7HtTUyapSyrJsAkgMFwQG7lZwBJU3Hw0VSLrR9Kz4CNCvS0NeQAt26HMvLvB9ZG01pJKpPARhHwtBV5N1wHFA04AFbZkcDvnq7LAjdwv4kdQ3IGkx0NkEU59Eh+Xdo+74Rr5eEe23RXDXaXUB07gbpRlVBPXCRted1RBPeHJvhhdqGbLji2MCEpAzpd3gKINQWupDSVrN83/BW2/HL7+PFqYCAOZdwZYjB4c3gaV2rWqsSLhktZR3GYSAIXdjg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0x2xyv2ldgVKBrF/v5Np5GXAgsihMax+yTgbqrkZ0vQ=;
 b=iFQwY/rfZwSCDMHeST1kOGKC/KOcpm+hLucRY1dwJGuj1TQkfQeMbvbW62GGOdJ+tGEzKd2rLxV8y1zBTEBAwPLZcn/yZfK0C4KUvFV55EIiwkPxnKBR9Ext3ZDB7dHamPYEGTzsLsvJi8dH92AF/CcEsv6lAJgogIdgHF18u6mz1zjMJ6yG6/+78DMI2JfOCichLv4hYQzUILnUpciOz0lGjFcM7gSWEOIWyJ1AqjG1vGTzPEy9eXgKQz+iQh30WQyZu9w1hKh8+vk2U5KOKZmHnmna62JSQNSHoUI/Y4rmqSbng9iQB+iewXuMUDFArskppWLX0lelyFy+7bbHLw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=suse.com; dmarc=pass action=none header.from=suse.com;
 dkim=pass header.d=suse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0x2xyv2ldgVKBrF/v5Np5GXAgsihMax+yTgbqrkZ0vQ=;
 b=IRM0JN+R/XCusQNydYb6ankdYvBxc4nHyKR32D2JDwg6eO1gOP7/TwMr2peGlxLSeGTcnpHjb0NOuci3wrys724gI1F7bJfn76w46bqhInVGsMyDPMB1XAUu7YssJXv77VlMMaqyoax5sdatkLGCgSN3KKhbSxOii8DzHWGVfp3C2dac8l58jdwHFn2RhaB+nZqKiaucpgW6qkyJynVnM7ZpNdh6tRwAY3u2FQpMqBdjFqnHNUkDx1XOMNiNQ5XvSgIiz1/Exb0npTMkj3/QOf6FumS3bW+aA8YFn3lFLWFqcaBq57O0WRLZGSad7FDJwIZBNJcDNephsRjijx59fQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=suse.com;
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com (2603:10a6:102:cc::8)
 by DUZPR04MB9981.eurprd04.prod.outlook.com (2603:10a6:10:4d8::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6745.21; Fri, 1 Sep
 2023 18:00:36 +0000
Received: from PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361]) by PA4PR04MB7790.eurprd04.prod.outlook.com
 ([fe80::274c:c30b:ac8c:2361%2]) with mapi id 15.20.6745.026; Fri, 1 Sep 2023
 18:00:36 +0000
Message-ID: <20f025f9-35d9-1f35-f21e-38e1bb44b74c@suse.com>
Date: Fri, 1 Sep 2023 21:00:31 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [patch 17/17] x86/fpu: Move FPU initialization into
 arch_cpu_finalize_init()
Content-Language: en-US
To: Guenter Roeck <linux@roeck-us.net>, Thomas Gleixner <tglx@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, x86@kernel.org,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "Ahmed S. Darwish" <darwi@linutronix.de>, Arnd Bergmann <arnd@arndb.de>,
 Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org,
 linux-ia64@vger.kernel.org, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-mips@vger.kernel.org,
 Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker <dalias@libc.org>,
 John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 linux-sh@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org, Richard Weinberger <richard@nod.at>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org,
 Richard Henderson <richard.henderson@linaro.org>,
 "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Chris Zankel <chris@zankel.net>,
 Tom Lendacky <thomas.lendacky@amd.com>, semenzato@google.com
References: <20230613223827.532680283@linutronix.de>
 <20230613224545.902376621@linutronix.de>
 <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
From: Nikolay Borisov <nik.borisov@suse.com>
In-Reply-To: <ba1b11e5-b3f0-457b-8920-d57d470626c3@roeck-us.net>
X-ClientProxiedBy: FR3P281CA0013.DEUP281.PROD.OUTLOOK.COM
 (2603:10a6:d10:1d::18) To PA4PR04MB7790.eurprd04.prod.outlook.com
 (2603:10a6:102:cc::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: PA4PR04MB7790:EE_|DUZPR04MB9981:EE_
X-MS-Office365-Filtering-Correlation-Id: e8681a81-3c6f-4de9-0ebe-08dbab1557e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: jht3jVClxqjO0JxUTW/w6t8wWYH9RswhH3PKRVsc+POZuCkt5/9kSPedrLL4L0P5NEr76V42XUobJZNATMzO4+K9yV8CdKj0EyX6np2sNHdTTZ25zjtTf9iICVxjxnQ8Nz/I+PBgVsEgrconixJtFiIW1gpD/vUL3guwcScEyNrbZPjvUpGW3nGty/37EEwD8JggIvI1aWoX/stIC92wK5au8Ta+ZyUyBoG6Okp6AaRG5uZRzWDjIshOjtIWIIyfRRuSc/vu6HeMHR5lDhD5b8HGyyH7yic0fqSs5pKNUHVia8YKGT4bsfVQLWynYsmiRh+ZUwwxZmHytbfYE+yvLAIRcwQliXx0teD3E7ZftibCcV8H8/mxMyKmkp3cfb1r+1xsymM5UXY2ndjFk4MRIEZI3VBdjiN84L7r01bkIrWPuFfAk5ejDaX96DCJfUf3g756vbUhRiihqYU2n2KU+iVNKwr9rxNPNDdhPg32/6fn8McFLVRHkNqXaHIIIlTRCeHlxBn7bBCunP+9Aq9+Mf49t25hhSJWJsITOXx24TajSVvDAp176m6p017OY16pDIBEQ4fCh8sQytVXuoQN57J6es4gmZHpaH4+JtAcoZwoTZqQ7y2CCecamrBAPacO3U5OBMwDJUWsEl2HU5xE9A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PA4PR04MB7790.eurprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(136003)(346002)(376002)(396003)(39860400002)(186009)(1800799009)(451199024)(31686004)(36756003)(110136005)(66556008)(66946007)(2906002)(66476007)(316002)(5660300002)(54906003)(4326008)(8676002)(8936002)(7416002)(7406005)(41300700001)(6486002)(6512007)(6506007)(26005)(6666004)(478600001)(2616005)(31696002)(86362001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?U3RJMTEyMmxYQ0pFM3RRRW5zR3ZRVWVLOW1HYVh2MnRrN3JRWnFvVFZSTk1V?=
 =?utf-8?B?S0Y0alRtcEVHT0ViM3oremROVnRCSmJiaTR5Vzh2dTZCTFN6VmhSb2U4NXlp?=
 =?utf-8?B?ZlIweDBVakI1N1pmaFlpS3Vqa3JjN0QrUTVXUC9EcGR0T1RISE9zOS9UMzFG?=
 =?utf-8?B?VFVwOUg3WFdPUDM1UlZNL24wa2pYZmUyeC9ydkorR01Ma0psUmF2WEw3cVVt?=
 =?utf-8?B?Yy9wdEE5VTFDMnAzNlhqSTRUMXhBTkpVQ1FPM2tEQnBBeWhmTXY5N3ZnUjVT?=
 =?utf-8?B?WVoyU2FmellVZXhFazF6NEs2bHFQS0RoUnFUd0g1b09ZMEU3UXoyVXdXVUZn?=
 =?utf-8?B?Sk8yUGRoZW5mK0dhUjQrd2wwRTY5bnlmc3VIYVN6YmZ5aGpYOExCMGl1OS81?=
 =?utf-8?B?eGJMaCtDN2JrT2hzZE1kTjQxNGM2bHlwMU9HNlRtMEZTWU9WWThvaEF4ZXJY?=
 =?utf-8?B?VEpDMjdrSjVMTkgrUUlkenZiakpOWldicHVYbS9mVXF5UDY2TEZ3akZVT3JK?=
 =?utf-8?B?b1lFZmRYZVZwclJaRmUxa0hKK3o5VVhsSys3VGFTR0Y1SFFNbG40L3p6L1Fj?=
 =?utf-8?B?WlNobUFUMHFrOUJSeFE0Y3VhZ2RmWmdpN2RaT2kvZm9ETHplMXpEZVhUMWp2?=
 =?utf-8?B?WnJjRGsxYzB0czdCRElxK05ZSS9xdXV5Q0trckJKMWQ4OU84aVBUVzcrdFc1?=
 =?utf-8?B?eXcwdWY0UW5nOUpka3JZeCtNeVJSdE8rdTZ6VG1NU1h1VXphMlhTNmRFMElQ?=
 =?utf-8?B?SVpzRVI4STcwRnhmaHl4dWpYVGlDbkJONlJRQ3p1MjU4WVlKT1NqcXdHYWpX?=
 =?utf-8?B?aTcyZkJjaDhWUWZkWEZCaXZkMVMzQVJmQUJSSytQUUlaalRGYTgxQ1NvZjJS?=
 =?utf-8?B?OGh6VlNtNE9mdTEvSkdQS013QnJvVTVWbTdDcnR5VDlPR1lPOGYvaW9BV0ph?=
 =?utf-8?B?YVovU3hndTl1bHdMTDlrOFczVElCWFhwU3RweVI3V1dseU53SzJlbzlxUVRz?=
 =?utf-8?B?aDVUS2RxY0NtQ2hMdVBHQWNsV05tTzNqanFqK3NqM28zdzVpY2hVbm01SHhC?=
 =?utf-8?B?cGs0Rjk1SzRQNEhjN3NBOXRYWVcrejVMblMwZXNsQjBpSlprWERxTVBVb1c5?=
 =?utf-8?B?bDdwYzQzdDVqVGxBUzk4V3JPOUkvYmN0ZXZhTGtxOUd1V2liWHdNalVBaDNM?=
 =?utf-8?B?MnJobjBkSTl1Vkc1THVGRURJWDJoNWJrenVtUEJhTVhua0JuRC9ORWRBQ2ZH?=
 =?utf-8?B?Yk44Q09FTlJxOW9OeGljT0wxeDBpdmFCQ1NHcGoyUUxVa2lhYm50ZzdrZ3l3?=
 =?utf-8?B?c3hzUmwvV210K3Q1LzY3VytrY1oyc1VGSlNkL2NKZ1c2Rk5oTytudURFeks5?=
 =?utf-8?B?VFF0a3FpdmdxVlY5NDIwTXdPTVZqNTJ1ejN5VWNaNFBmSjNZLzJPV3BvNmF3?=
 =?utf-8?B?V2NvcTV5MTJxdjM4UWZiN3gzRldyWDNUanVKS0g4RlRuclUyR2xxMmJJVnVo?=
 =?utf-8?B?WXpmeTd0VzVoUHBNVkd0d0RsbmFwZDdkcHhzQ041N2dtSmgxcDI3MGdhNkhV?=
 =?utf-8?B?Y3oyNk9LVEhLY3BwNWFlcTFDcW9EYjRpM1ZXcXBQV0RFdnZ1c05oSDU0d094?=
 =?utf-8?B?VStCZVJobVpxWUxVWW5henk5NStZSTgxSStaU1A2OG9vbDlOTUFXVlZiV0Z3?=
 =?utf-8?B?K0VRci9Db3Zsa0ZRMXlqanRaejRvakpaV0dHMlF5TEFZdFlVbDZxejBqMHNs?=
 =?utf-8?B?Sy9lQXRMb2RadGFrdW96dVRGSnRTQTk4Q2QwcWR3KzlmSDMyK05aS0c2dnRE?=
 =?utf-8?B?K2w3QUd1VVBlcXczUDdna2hob3p3VkJKSmlVZEF4bmprdThxTDY3OWtoRjM1?=
 =?utf-8?B?ckw2d1BSNDI0cTMrYlE0SUJyZHFScGhEV0NUV0NQQlB6ejBDME56ZnpJL1FQ?=
 =?utf-8?B?Q1QwSVpuZFNZTkV3NVdHNlRaMFJPaEk5SnpuSVpwMEoweVpwLzZ6elZrdGsy?=
 =?utf-8?B?NW1aNzBEcktvdWdRZ2NRSzNSckNLbmkrZzcrR3J1QTRiWVkwTTFaWWNmcW01?=
 =?utf-8?B?UTJtUjJ0WkhydFluUStyYmFMOFljci9saU9YRnVsVUVQTDNTT2g4MFMzejQy?=
 =?utf-8?Q?mX4fUuvMzgiKhj3Eg/vcteiW+?=
X-OriginatorOrg: suse.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e8681a81-3c6f-4de9-0ebe-08dbab1557e9
X-MS-Exchange-CrossTenant-AuthSource: PA4PR04MB7790.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2023 18:00:36.2129
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f7a17af6-1c5c-4a36-aa8b-f5be247aa4ba
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9+zWrrGn6KFeupWOJlHtp8zeAlrG0zDm6zX39WwF3uE5+jn9RRZWNsHNlMf9+v4h02RfpbE3n5VQufopdlFfGA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DUZPR04MB9981
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230901_110052_961707_A6A56EF0 
X-CRM114-Status: GOOD (  21.84  )
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

CgpPbiAxLjA5LjIzINCzLiAyMDozMCDRhy4sIEd1ZW50ZXIgUm9lY2sgd3JvdGU6Cj4gSGksCj4g
Cj4gT24gV2VkLCBKdW4gMTQsIDIwMjMgYXQgMDE6Mzk6NDZBTSArMDIwMCwgVGhvbWFzIEdsZWl4
bmVyIHdyb3RlOgo+PiBJbml0aWFsaXppbmcgdGhlIEZQVSBkdXJpbmcgdGhlIGVhcmx5IGJvb3Qg
cHJvY2VzcyBpcyBhIHBvaW50bGVzcwo+PiBleGVyY2lzZS4gRWFybHkgYm9vdCBpcyBjb252b2x1
dGVkIGFuZCBmcmFnaWxlIGVub3VnaC4KPj4KPj4gTm90aGluZyByZXF1aXJlcyB0aGF0IHRoZSBG
UFUgaXMgc2V0IHVwIGVhcmx5LiBJdCBoYXMgdG8gYmUgaW5pdGlhbGl6ZWQKPj4gYmVmb3JlIGZv
cmtfaW5pdCgpIGJlY2F1c2UgdGhlIHRhc2tfc3RydWN0IHNpemUgZGVwZW5kcyBvbiB0aGUgRlBV
IHJlZ2lzdGVyCj4+IGJ1ZmZlciBzaXplLgo+Pgo+PiBNb3ZlIHRoZSBpbml0aWFsaXphdGlvbiB0
byBhcmNoX2NwdV9maW5hbGl6ZV9pbml0KCkgd2hpY2ggaXMgdGhlIHBlcmZlY3QKPj4gcGxhY2Ug
dG8gZG8gc28uCj4+Cj4+IE5vIGZ1bmN0aW9uYWwgY2hhbmdlLgo+Pgo+PiBUaGlzIGFsbG93cyB0
byByZW1vdmUgcXVpdGUgc29tZSBvZiB0aGUgY3VzdG9tIGVhcmx5IGNvbW1hbmQgbGluZSBwYXJz
aW5nLAo+PiBidXQgdGhhdCdzIHN1YmplY3QgdG8gdGhlIG5leHQgaW5zdGFsbG1lbnQuCj4+Cj4+
IFNpZ25lZC1vZmYtYnk6IFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJvbml4LmRlPgo+IAo+
IFRoZSBiYWNrcG9ydCBvZiB0aGlzIHBhdGNoIGludG8gY2hyb21lb3MtNS4xMCBhbmQgY2hyb21l
b3MtNS4xNSB2aWEgc3RhYmxlCj4gcmVsYXNlIG1lcmdlcyBpcyBjYXVzaW5nIHZhcmlvdXMgQ2hy
b21lYm9va3MgKG5vdCBhbGwgb2YgdGhlbSkgdG8gY3Jhc2gKPiBlYXJseSBkdXJpbmcgYm9vdC4g
U3Vic2VxdWVudCBmaXhlcyBoYXZlIG5vdCBhZGRyZXNzZWQgdGhlIHByb2JsZW0gZm9yIHVzLAo+
IHNvIHdlIGFscmVhZHkgcmV2ZXJ0ZWQgdGhlIHBhdGNoIGZyb20gY2hyb21lb3MtNS4xNSBhbmQg
d2lsbCByZXZlcnQgaXQKPiBmcm9tIGNocm9tZW9zLTUuMTAgYXMgd2VsbC4KPiAKPiBJIGRvbid0
IGtub3cgaWYgdGhpcyBpcyBhIENocm9tZWJvb2sgc3BlY2lmaWMgcHJvYmxlbSwgb3IgaWYgaXQg
YWZmZWN0cwo+IG1haW5saW5lLCBzbyB0aGlzIGlzIGp1c3QgYSBoZWFkcy11cCBpbiBjYXNlIG90
aGVycyBleHBlcmllbmNlIHNpbWlsYXIKPiBwcm9ibGVtcy4KCgpMb29raW5nIGF0IDUuMTUgdGhl
IGZvbGxvd2luZyBwcmVyZXF1aXNpdGVzIGFyZSBsaWtlbHkgbWlzc2luZzoKCmFmODA2MDI3OTk2
OCAoIm1tOiBNb3ZlIG1tX2NhY2hlcCBpbml0aWFsaXphdGlvbiB0byBtbV9pbml0KCkiKQo1Yjkz
YTgzNjQ5YzcgKCJ4ODYvbW06IEluaXRpYWxpemUgdGV4dCBwb2tpbmcgZWFybGllciIpCgoKQ2Fu
IHlvdSB0ZXN0IHdpdGggdGhvc2UgcGF0Y2hlcyBiYWNrcG9ydGVkIHRvIDUuMTUueSBhbmQgc2Vl
IGlmIGl0IHdvcmtzPwo+IAo+IFRoYW5rcywKPiBHdWVudGVyCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgt
dW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXVtCg==
