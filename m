Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DE52D75E39
	for <linux-um@archiver.kernel.org>; Fri, 22 Nov 2024 12:49:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:MIME-Version:
	Content-Transfer-Encoding:Content-ID:Content-Type:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=J09WOsve7gqtq2CGWFqrKzYODgeWH4wXOS6p40XtJ6I=; b=Zls/vHLT1RkHSOA09xR3uJGvP8
	mjOW1VDlpOFSvpR1/5k63BUeEvSGNiFreeWBra5XBt0Z0T7Dfg/9k6dG8CpRAwq0Ltaj9kUh7ek76
	FeUMYKNw6/eTTag/yKqhao7ZS1YJ5V7BrcpM8+nxt6GoaE1pjZn4ehFapYZ30LQmCo+7ydwHdcsKq
	2YmvD22MU7wH9puDzp2GnCO1Ywyt6eB7p4gQfOdbFull0OMS0M6kF+boEwZC1m5hvJMXLqurHCbz+
	x2JMMuyQDcgC4ZgjIofwr1gkfxCPihpAikhNlqnU1w8WtYGFrzyNLKhOEHgE97wNYIEi6VZu13rVl
	CWhxEb8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tET6g-00000002UHZ-3bDe;
	Fri, 22 Nov 2024 12:49:54 +0000
Received: from esa3.hgst.iphmx.com ([216.71.153.141])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tET6d-00000002UH0-2wYa
	for linux-um@lists.infradead.org;
	Fri, 22 Nov 2024 12:49:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1732279791; x=1763815791;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=J09WOsve7gqtq2CGWFqrKzYODgeWH4wXOS6p40XtJ6I=;
  b=qwuXQZB/N+rfE3XPXRZS+YXScBjE2Y1nX2ZxHFPKnP9h3ms3mjeAbBf7
   ZAq7/BIVXlqHYBKO1PkZdXH7qnuZhZfUbky6msikFJ9HNxk+mkks/PMlC
   eUhiVOjFy/BDwWVk2EAXHaKhnOIyLUQ1hmBNqQW+4zv/Gy2ppw9cL79Ct
   h85GbDaAICJ3zA9P7lS4BFcvZZzRMimw7hX7hEEKTCyEzIOR9AoXP1PF+
   s7Sn1GeBm2JGW4vQ5lNlGvAmebt4DvToB/GzGviTLHwp4H7tVvvzlg+yL
   I+Vxav6BJ6x4Lda1uV9HOPApgDfn3q+T4TNGds9/0vMPobGwcOSs5QX3t
   g==;
X-CSE-ConnectionGUID: 0aVr8sWnRj+6oupOjgeQ7A==
X-CSE-MsgGUID: eU9EfuYpQF+onD8rRM2ZtA==
X-IronPort-AV: E=Sophos;i="6.12,175,1728921600"; 
   d="scan'208";a="32192882"
Received: from mail-westcentralusazlp17010004.outbound.protection.outlook.com (HELO CY4PR05CU001.outbound.protection.outlook.com) ([40.93.6.4])
  by ob1.hgst.iphmx.com with ESMTP; 22 Nov 2024 20:49:49 +0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=jdlCJXGJFHPG2RaVumMO4dVnWJONugPCl1Hu3M5tfamstwF1O6U6As7UWAYQlL8bzB5aLQnxq/z3Xw3FMjoWW3xUnEZeR0Z2UlH+/takjNTu1AKcscCfHOUVa8RpZaHLDrbFggr1d/IlybxXUU95cibm+TKeJNCAak2kzp6d1dn6CtDC5BJ2SqHLC6P3Wda4rkh3JJA7Jq3IGFckiDBPgRdUD85vZq//kunMlExBux/o4ay3QDBI03J+z3hv6lyqYWWHiNRVwjVS7N1hON2UDCnPwkqZJgWKJLca35pCIlVGBiuKpqodsd7PSxvD4gcMQ4TNKfFBbbijckm0n7zdwg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=J09WOsve7gqtq2CGWFqrKzYODgeWH4wXOS6p40XtJ6I=;
 b=ml96a4xNAeUtuISibRY0b1cD9+mp92mhKlv8eEt7/FDQ+zoMg7h4DKsMVOCXhYOtbJPCYVaoU0/wjslriRFcWyd/UDw1qtsAF5xWTex88tr2B3aLh+eywEvM4f1dvSWyOaak9AuD7ipTtq1RJSj4o0YaqqZVfX3xHpSUTJF+KFL43FkOCaWZ7AGczF1oDJAL4p96rBXDv/dKPmQQ1uKc0Qqb1yC3vJRKjbsyiwurPs2zDSxdTxrgVEJo/p9WRZcjAZrb1lSxAd9enlbgSkl5rB3dmR2Es4XzOgF6zK0nHCaOG7dTX3SJz+k1EvtdfbnpNLt+X5SXPGSm4Bdx3sngMQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=wdc.com; dmarc=pass action=none header.from=wdc.com; dkim=pass
 header.d=wdc.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sharedspace.onmicrosoft.com; s=selector2-sharedspace-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=J09WOsve7gqtq2CGWFqrKzYODgeWH4wXOS6p40XtJ6I=;
 b=o8ulJnsSFlhgthFYkIkihNN71jRxTdspETwoz9+stWt4iKwTa4Wx2Yn9CDdhBu8BoxcomTkH0c1J+zNMUpUe9hOuCgNkGYw857KO8MKpODQNtFU/gZ6EjfLb+FhhxmeYcLDJCt7gtmnofgZbLjme+8JxdaX10i5HCRwhDP21WDo=
Received: from DM6PR04MB7081.namprd04.prod.outlook.com (2603:10b6:5:244::21)
 by CO6PR04MB8315.namprd04.prod.outlook.com (2603:10b6:303:136::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.8158.27; Fri, 22 Nov
 2024 12:49:46 +0000
Received: from DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::5d8f:c611:2b14:4e48]) by DM6PR04MB7081.namprd04.prod.outlook.com
 ([fe80::5d8f:c611:2b14:4e48%5]) with mapi id 15.20.8158.024; Fri, 22 Nov 2024
 12:49:46 +0000
From: Damien Le Moal <Damien.LeMoal@wdc.com>
To: hch <hch@lst.de>, Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
CC: Johannes Berg <johannes@sipsolutions.net>, Hajime Tazaki
	<thehajime@gmail.com>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "ricarkol@google.com" <ricarkol@google.com>,
	"Liam.Howlett@oracle.com" <Liam.Howlett@oracle.com>, "vbabka@suse.cz"
	<vbabka@suse.cz>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Jann Horn
	<jannh@google.com>
Subject: Re: [RFC PATCH v2 00/13] nommu UML
Thread-Topic: [RFC PATCH v2 00/13] nommu UML
Thread-Index: AQHbPMRkfn5aT+ekB0iGXDePHPkkp7LDN7oAgAAB7ICAAAOzgIAAAyGA
Date: Fri, 22 Nov 2024 12:49:45 +0000
Message-ID: <639c273e-0652-4d25-8385-fdddd7d1de78@wdc.com>
References: <cover.1729770373.git.thehajime@gmail.com>
 <cover.1731290567.git.thehajime@gmail.com>
 <77ab71c7-3608-4636-a618-3044c2316a92@lucifer.local>
 <0930a0fa8e28ecaf92727229e6633278399409e7.camel@sipsolutions.net>
 <20241122121826.GA26024@lst.de>
 <d28480cc-2200-43bd-adb2-01bbcd8adb1c@lucifer.local>
 <20241122123833.GA26432@lst.de>
In-Reply-To: <20241122123833.GA26432@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla Thunderbird
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=wdc.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: DM6PR04MB7081:EE_|CO6PR04MB8315:EE_
x-ms-office365-filtering-correlation-id: 1d3c7e86-f88e-40f0-2113-08dd0af424b0
x-ld-processed: b61c8803-16f3-4c35-9b17-6f65f441df86,ExtAddr
wdcipoutbound: EOP-TRUE
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;ARA:13230040|366016|7416014|10070799003|1800799024|376014|38070700018;
x-microsoft-antispam-message-info: =?utf-8?B?b2I5ZUxDRTFtazlGc0Z2VHRzNm5YZ2RnN0RQd2g5RG4zenpNVmliQkY0MHpw?=
 =?utf-8?B?TTN2WkZ0d1BmVmRRWUU0WnNxOVBjK2FlZ01oR2tmQ0FHL1JCSXhpL2d0NEtT?=
 =?utf-8?B?ZWRnNUVVbXdWRWNwR0V3ejJqbTZoalpVWDJNb3F5LzAzSzNKcWVLM0FnWGs2?=
 =?utf-8?B?c202VG1UTlpkeHhiTUU2UUJ1WTVIS3J2eFFVY0Q5MXpjbVRPNFBWbWpMMDdD?=
 =?utf-8?B?VmFKbXhBQTBYd1RLOXVCblJqSzBBVTJ2Nkp5K2ZVQXFuNWVHZnhxS09hVllm?=
 =?utf-8?B?TXlSNVZLSUtNcG95VDZNU0R5djhVbHc5aC9QYy9KejJhdWtkMGhySHo2ekZr?=
 =?utf-8?B?czdzWVRacUlPRXBoa1NNckgvOFQxdFVxZ01pK1hDMU5rU2lxMWVDSGMxKzAx?=
 =?utf-8?B?TFN2cmpqQ2ptN0xpeDZsNjlxK1NYTU8wV1hERllHVTRMS3BsMmVBT2t6RWxR?=
 =?utf-8?B?T0M2MVhOS1pudlpwVjYwZXBKUGZZS1pxRzAwUktPSlBrTlhjMVBGdUVPV2E2?=
 =?utf-8?B?VEh2RFZKd2d4N0gveGNyYkRnN0taazhLc25OUHlKdUc1Nm5WWDMrcUdJOG1v?=
 =?utf-8?B?R2VoaGk2a2VXWmNETzluVGVMMTNEdy9BZVl5b1ZwMmNLRlhTQVhDam1pdlNN?=
 =?utf-8?B?bGlpYVB1UUw3YzlQWUdTUTU4d1VINGg0SkdseWg4V1lyYU5rUVcwV1h0Qksy?=
 =?utf-8?B?TG1ZTHk3UGJqdlJHNVF4L3Qxbm9iMXZoUjYvcEl0dlRuNWhpUWVWWlp4dXlJ?=
 =?utf-8?B?ekt1djMzUlBmdUszak5RVGduNHhyLzM0NWpjVzdXMjZHbGd5ZytvR25IRXVR?=
 =?utf-8?B?R2o1WjZUR1YxOVRJWUh1YXNxeFVERUFBYXN0QW9QelFTcXF6MjFSNStCMTdp?=
 =?utf-8?B?dEM2UFlNaVVaNGd0Zm0vVk1mMkxReC81ZTN2KzA3WjlZOFpIaHljVWthb0Vx?=
 =?utf-8?B?bitZdVU2bTVFK2dqRFU3QkpBVU5KZjJjNmxuU0pOSW5UNWprR3ZIWkVhL3JV?=
 =?utf-8?B?QTR2ZnFTZXg4RXZtZTNMejVtekkwZlIwZjlUcXprZk9QOXYwWWc4YTFFVlhi?=
 =?utf-8?B?Sk55WldIYTM1dXdwaXhHWXB5bi9NSmtLUkhWK2toOUtPbzdrOW12T2hFWC91?=
 =?utf-8?B?bWxyRStoUDFqajJKTE5OZnZ6ZW1wUzVXcGNCMHdBYUxQaGZzTHB5eHZyTU90?=
 =?utf-8?B?elhQNWdoRjFNUmV5aE1xRlRyRHc3bGYxcHVveTJiR3JFYnZiS01zN1hwYmVO?=
 =?utf-8?B?dEJwSk9DdWZsRjJEL0M0bzhvOTNjUjVWWHZxZ2x1VHkyTkYzQng2MFRwalZK?=
 =?utf-8?B?MkdQR2hzcnEyWUlZMDJ0TW9zUU4zQm5uZ2tnMmF3K0svMlJKWS9xL3NsK3V2?=
 =?utf-8?B?RHppQTFwYWRISUhuOUs5T05XNWorZUxBTmVibUl4MmRoMGhHNzlsSzE2MEQ5?=
 =?utf-8?B?Y3N1SUtkbzhWcjlhMCtYQkZ6N1BJc2Q3MmxseTRDRkJlNStoOWJ3d1JuV1VF?=
 =?utf-8?B?SHZEbDFhRWRKL2dJMzBxUWxFZXVhMEQ1SGkvb0pqZTZzSEtNQWtDRVpLaDBm?=
 =?utf-8?B?d0FabWF1TmVrRjlvVmdnTmdOSENON295eERmbUpHMENzVVYzY2lqZFp2VkZt?=
 =?utf-8?B?TXlkRHpPZFJEdUovbDFwMyticlVvVU5NZGhNaTU5V2R2N3hySnpsUHZPSzNj?=
 =?utf-8?B?VEU1WkhzTnRoN201VDlJY3dsTkhwRUZTdXlQb0hNQU8xYU9KSi8zSnpNMHlk?=
 =?utf-8?B?SkZkUzRramFOOEtZdTdZMzZDWElBczROWk5McTNaVVg0WFY5Rm1hZGJJc2NN?=
 =?utf-8?Q?stToqX1JPy7HJlItniG7DhgxUDlrfDWU2nqoQ=3D?=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR04MB7081.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230040)(366016)(7416014)(10070799003)(1800799024)(376014)(38070700018);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eW5NMHpUclBLa3hqbXArcDllN09kSlRPMDR6Nk1hNXJyajRSWmpGaHdmYnRQ?=
 =?utf-8?B?OXM5M0ZRL2h2V2U2Z1NjRFdveFlsVlFOU3ByY0RyQ1pXenk1Q0lEVVFWYU5L?=
 =?utf-8?B?aUp0R21uWDcwOVdlNXJ6N0hmR3ViYVdjazkrZEdHNm44UWxXcmp2RG40V0tZ?=
 =?utf-8?B?ck1SYkpFcW1NZXFxNVdTTk5FTUp3ekxVTnlKQjdsb3Z6SFM0QnlLWnBwV2xM?=
 =?utf-8?B?b09FelAvbmR5cWRUQi9lOVQ1OEM1NDJMUUlpa2REeTBrY3pidTRxN3gvb3Av?=
 =?utf-8?B?L0d2QTFEWkFwd01MVWVvS1lTdGh3ckRvVW1JejN6NE5aVWdPajMwcHBHQjdo?=
 =?utf-8?B?a25rc3ByL29tRzRPbEkvYnFCTFI0dWRqZlR3eHJ4VUxRLzBTUlIvb0ZXK1JE?=
 =?utf-8?B?K29RN1BkS2ZoSVBMS0d3MnVzT1J1cE5KUjJkWkpMUVQ4Zk1MY0FDMzdIOVJ6?=
 =?utf-8?B?VkZ5VExOSEc0dnNscTAyZzRpc2d2aFB6WEV2NjFzcGFJYnd5RHpLdmVteERU?=
 =?utf-8?B?dE1XaDU0a3Y5RnFCcThsczNrKzZkZkhWays5UUdtRVpURCs0V1hQQnBCejhk?=
 =?utf-8?B?VXBnOTdqaFNybGQ1algzUVNJS2R0NGpORHBnU1pjaXRJaklxZFRrSDd1cVAy?=
 =?utf-8?B?b2F3c0FHYzM3dkl5aDJ1YWcrUHBDYXNFYTI2ZFYyOTI2OWRiWk41dUd4NURS?=
 =?utf-8?B?SXJMaTlGeG1yK215YWp1ckRqaFFkWFVMSVltcDFhem0zeG9QMTlXRkpxUUJT?=
 =?utf-8?B?VGZhSndJZ3NmaUljQUp1R0lsT2VtZlJ6bjRRdFRhM21vMGVQNllIc1JIWGw5?=
 =?utf-8?B?a0NmQ0VtNU5HUTF6UjJoU2pMYXMvNWtvMVF0dFpBdWxCQjMwdllvWmJadkFF?=
 =?utf-8?B?QVlEWHdXR2k5NldtdTlkdGNSV0NLUUNOekVkUTFyT2k5TStteiswc0dUaHBZ?=
 =?utf-8?B?YWtTNkZhSTdvNUE2b0FTNlJUYk1GL3dqMmd0blZFbHZ1UXd2VnFoUDNPYnhs?=
 =?utf-8?B?b1QyWVVMTW1BUDNpNENhQnRuNDNQbE9IemZVakVEbzZLVWREV050UXUzbXFr?=
 =?utf-8?B?NlRTSzcxNE8zZGM1c3o5Y0FlVy8zREtkZHVQRE5TTEpUYnFvUy9HZ1E0RFly?=
 =?utf-8?B?R2tYc1JubWlKalQ1YjAwS05wZEorbEcxc3RuS2k2Um5ucjlaUEIzSmRGK1NF?=
 =?utf-8?B?bi9QM3RQdU9ibWhTNlJ4aGZjZVBsU0JWdm9ER0s2K0wrQUs0WmpibXN0VEw5?=
 =?utf-8?B?aEl4bVRLdHdnUlQ0d0xtcDQ2Y2F3c3dGeEYySjAwM2xDYWs1SnZSaE1rUDUv?=
 =?utf-8?B?VHluSjRjVllnb2taWDdsUHFNZlBQWFljZXl5Ry8vY3Jzek9nYzVyVEwzRVpE?=
 =?utf-8?B?dEJNbHlQb1dSTVpWTzRSNys4YXR2aXFiZnJha2o0WUpwSzIxNGRCMFNtU0kr?=
 =?utf-8?B?MmpkQitUWkZUR2lvN2NoYnI3YzFrZnZIOGNrRE00empIcXZKM1Fwcng3OU5x?=
 =?utf-8?B?TDNjTDZvWFA2eXRnNlpHT2l5eEh2V2FyS1doWkp3ZklsbXBJZWpSSGV2SC9N?=
 =?utf-8?B?Sk9Jc1hENlZoMnJaT1ZKOWxHYm0rU3U4OEpIbG5zeWZHK2FHYkxFcEtRdEVW?=
 =?utf-8?B?Q0tYdWxML0V1aWx4MnRuKzVZakFBY3V6MnNNRlVxRElYQU5RK0V6VXliSlN2?=
 =?utf-8?B?VDBjUlg3bjVxdVV1b3F4am82dUFBVmZETzF0V25KcWU2V01LNVE1Z0FqZXFv?=
 =?utf-8?B?dFYzQ2pyaklNNFJXcGE5SWNiTWg3VFdMYjRXV0UzS21qTGxGQTZsYmNGeDhO?=
 =?utf-8?B?bExGNWUvbjAyNFMyM1VEQUlnSUlJcU80dHRlL3NyRlZSSEY2WjZ3VUtLdjdl?=
 =?utf-8?B?ZU5GNlVFa3VMNDJYc1ExNGtFclcwYThCeGpOWVpBMHdyNjJYbi9IWitvOUI4?=
 =?utf-8?B?a2hOTHZ6bUdTYXVXU2U1OFJpV2lraTgrOUpQdGRRU3E5cGRMc2JkekhReklD?=
 =?utf-8?B?b01hSnRRQ2FYTkQzVWY1T0tXbU1YNmVLV0c2elRJdy9PNG9uaWt0UVB2OUxL?=
 =?utf-8?B?dWVmazZJYWttSUg5bzIwQjRucGZMM2d2enMwRlkwTmJCSEpmNzhEalRUREht?=
 =?utf-8?B?VXMrV1VoekRxV2lVbkwzWng2N01rSFRRVERDbm5UU2VQZnZNRkw3MUlQY3RU?=
 =?utf-8?B?NUNEaklZSHdLV1Y2NmpKL0JYL2JvUlZEbFJRZkNaNnpkbFB2VDNPNDgyRXo2?=
 =?utf-8?B?WkdBcTI5TWJYWkFMOThhcE1jVXl3PT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <588B7F829BB4C64D9AC282841781AD5F@namprd04.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-ExternalHop-MessageData-0: 6NRZhlSWANCJgP69FDhB1mfJZYGjABuPhnyTniK+JkR+AAsh6KmqSZYNgr+0HKSR+EaeUdaBUs+k0bArEAis2Iyse+7Z/05pdwHJkzTamrBEGhmYD8GGEiZJatVy3GVUmJ3Y3ELg2cPqxosWryd2NlP2xZiDSb3AFumoaY3wQVjh9+GzUbH/Cu3iF0SYLpxaskHLpsPLq5Lnd07pNsDOFhTPP8asJDe00sTVUdI8l/Alba/sTgT9HH6chh+Exj6tK6vhVvkoMwgUNzVM3XdXqlildBhLHtAH3iTx8LbvM/nOxvQQ6HW/rt7AZuJowAl1fnd8BNxW8VvLTMvzgKt/zrHEyhkChySXXUXz3jRuqJzn5tqV0O9ON9AcHZ6abpfhHCBeu0MjI7Yw01fdC9uCrf+5Vw8uK9LrnRu4E66Pjekzw8MN7hdjv8JT+wVVbD4J/Xp33FRgX5YX+qBXjcCdHD2cie+6q+/zgkJbqOTvL14mxD2QsfXEG/9WHpKVe9sygKBDRYVIgf1VqcSrE9DUGM7FOcACVA559mfz3PgX5VyFvfxx021LzqyfEztUHo1VqfG5WZHvvpRgznbG83IA+n1GKmES9VKzHLCRnqEWENl/bKwRrAORUqyoxyjepOkQ
X-OriginatorOrg: wdc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR04MB7081.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1d3c7e86-f88e-40f0-2113-08dd0af424b0
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 Nov 2024 12:49:46.0184
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: b61c8803-16f3-4c35-9b17-6f65f441df86
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qhd5Qrik5R22sjp0WZQrUgAyegMS99ZxeH+K9cB65uln1HIxEHHblWi0Djpp2usSqUO9b2lg+afU04Ctm5OEjQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO6PR04MB8315
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241122_044951_767502_048F68CD 
X-CRM114-Status: GOOD (  15.90  )
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

T24gMTEvMjIvMjQgMjE6MzgsIENocmlzdG9waCBIZWxsd2lnIHdyb3RlOg0KPiBPbiBGcmksIE5v
diAyMiwgMjAyNCBhdCAxMjoyNToxOVBNICswMDAwLCBMb3JlbnpvIFN0b2FrZXMgd3JvdGU6DQo+
PiBJdCdzIGFuIG9uZ29pbmcgbWFpbnRlbmFuY2UgYnVyZGVuLCBkaXNjdXNzaW9ucyBhYm91dCBz
ZWVpbmcgd2hldGhlciBpdCdzDQo+PiBmZWFzaWJsZSB0byByZW1vdmUgaXQgaGF2ZSBiZWVuIGhh
ZCBpbiBtdWx0aXBsZSBwbGFjZXMuDQo+Pg0KPj4gSSBoYXZlIHBlcnNvbmFsbHkgcnVuIGludG8g
aXNzdWVzIGhhdmluZyB0byBhY2NvbW1vZGF0ZSBpdCBvbiBudW1lcm91cw0KPj4gb2NjYXNpb25z
LCBhcyBoYXZlIG1hbnkgb3RoZXJzLg0KPj4NCj4+IEknZCBiZSBpbnRlcmVzdGVkIHRvIGtub3cg
d2hpY2ggcHJvZHVjdHMgc3BlY2lmaWNhbGx5IHNoaXAgdGhpcyBhbmQgYWxzbw0KPj4gcmVxdWly
ZSB0aXAga2VybmVsLCBwZXJoYXBzIHRoaXMgaXMganVzdCBhIGNhc2Ugb2YgbXkgbm90IGJlaW5n
IGF3YXJlIG9mDQo+PiBjZXJ0YWluIGFyY2hpdGVjdHVyZXM/DQo+IA0KPiBJIGNhbid0IHRlbGwg
eW91IHRoZSBwcm9kdWN0cyBJIGtub3cgb24gY29tbWVyY2lhbCBiYXNpcy4gIE1vc3Qgb2YgdGhl
bQ0KPiBhcmUgYXJtIGJhc2VkLCBidXQgSSBhbHNvIGtub3cgYWJvdXQgYXQgbGVhc3Qgb25lIFJJ
U0MtViBvbmUuICAgIFRoZXkNCj4gYWxsIHVzZWQgdGhlIGxhdGVzdCBsb25nIHRlcm0gc3RhYmxl
IGF0IHRoZSB0aW1lIG9mIHJlbGVhc2UgYW5kIHRlbmQNCj4gdG8gc3RheSBvbiB0aGF0LiAgQW5k
IHRoZSBpbnZvbHZlZCB2ZW5kb3JzIGtlZXAgc3Bpbm5pbmcgb3V0IG5ldyB2ZXJzaW9ucw0KPiBv
ZiB0aGVzZSBldmVyeSBmZXcgeWVhcnMuDQoNClRvIGFkZCB0byB0aGlzLCB3ZSBoYWQgYSBkaXNj
dXNzaW9uIGF0IHRoZSBSSVNDLVYgTUMgYXQgcGx1bWJlcnMgbGFzdCB5ZWFyIChJDQp0aGluayBp
dCB3YXMpIGFib3V0IHJlbW92aW5nIHRoZSBLMjEwIFJJU0MtViBTb0MgYW5kIGFzc29jaWF0ZWQg
UklTQy1WIE5PTU1VDQpzdXBwb3J0LiBCdXQgc2V2ZXJhbCBwZW9wbGUgY29tcGxhaW5lZCBhYm91
dCB0aGF0IGJlY2F1c2Ugc2V2ZXJhbCBGUEdBcw0KaW1wbGVtZW50aW5nIFJJU0MtViBjb3JlcyBh
cmUgTk9NTVUgKGZvciBvYnZpb3VzIHJlYXNvbnMgZm9yIHRoZSBGUEdBIGNhc2UpLiBTbw0KTk9N
TVUgaXMgYmVpbmcgdXNlZCBvdXQgdGhlcmUuDQoNCi0tIA0KRGFtaWVuIExlIE1vYWwNCldlc3Rl
cm4gRGlnaXRhbCBSZXNlYXJjaA0K

