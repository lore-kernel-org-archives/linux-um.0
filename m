Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFCBAC25B48
	for <linux-um@archiver.kernel.org>; Thu, 26 Oct 2023 08:49:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=4BrF7MRDpAlZGLCUxUJsBFBDC0CDI0fPqEfI3dKyKoo=; b=iGxdXWlNYfqK4a
	h9Iezj/mMZdWj9b6EWqmnDuRecDdLk2oI26zHTu23hOVqPfObVIv5sQFcoa49/93Lea0Oo4gGz76g
	R7GYVMuiJjbGlUoCTqaIM8fAR0Dtkh0FZByHKd3xX8sMyYR8n9WHN+l1MHIPiXUVwgyibSgzyphZa
	+Us0nTtc+SZlj3x0OD/wG53hYVYOb5PqLQvE72/SNHuOaKzcjVAy3KHT0R37wz/EGgTJcV51sTHtR
	UmV3y+ppnysig2IOWLGg1w6+zWJ4juCquM/0uphlYJ2XCYLbBrSaXlyfKwttrtTsIy/8yiw+bVloX
	t0/e9+vm1azAN9THzcbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvw3b-00DzmO-1N;
	Thu, 26 Oct 2023 08:49:35 +0000
Received: from mail-dbaeur03on2061d.outbound.protection.outlook.com ([2a01:111:f400:fe1a::61d] helo=EUR03-DBA-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvw3X-00DzlF-2i
	for linux-um@lists.infradead.org;
	Thu, 26 Oct 2023 08:49:33 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=aAZN1ElQgl4pVa8wnBc/VUzUg2hBk6HAhrqoEaI46IELx5M0uZURKlBVGgRWLHxd3X+by4nLUeUatVHytdx6GBupfC3PV9j1Bggb8DwzFMSsIRCvAHJ6iwdcCVtzAeMEYQysOC+RaE99RgbMW9oMx8fxYtrA7e3OREqFmvP7Plda164dVBPju89+UdAZcJen5817fiq4qI6l7v36cuw+la8R9jLJj1rGDbwq3GyPQklfCiybmHGYcGfQXonDHoLckyPfP33LHX/E0XkDLD2k2uerqFse1i0cBW7wIxsfdlnU0J8VLCZj04BCZNiUOfUIyhhzMPJuQJgr5pCRP7sbvA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bcfsViCMcGVrxSfRpi6TB1p5zynu6rVf1Fe+qfXmog4=;
 b=Z7g/hNNTghaJX6i92dMMWDgph+Oj7j0wo7kzt/XJiQGP34fhmZuax9eTfT4TmykUsd/DhHBB1mjNQkSHxHqCCFzwbySnXboPTw6S+1wRViSes8dwI9oiIDsYlp67sZgeT3q5BVgtPmRdZ5e2K0XsmYyzgo+Rw38fmW+URwT40N9kvPTO6Z5lsOFc2l7JdYoS0xdwnxEJ1NWcn8xPJz5K/pX9KDFLd1nNWcQqWnMEnpL8EWhS9kOkQ0ZB757em084Tz0UXfklHeNpItOde68wviLgZQPyOWZa6xqC/VfYK3GPss6vBReCGPV3N32+061u1hdH33W/uk9HCRxy/pDcUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bcfsViCMcGVrxSfRpi6TB1p5zynu6rVf1Fe+qfXmog4=;
 b=e7zPsCFRfEbVxDNIovksKljSfJcoRQMZpg4lmA99P7/zxbNkkmKVU0i/AC6tzADZBc1u+MrNlTCLxvCUzmrU9Jy8H+xjapw8WF9IOyXLCf3zu8sbHlXqzGfjGA6y4b93dZs8AyGe2KKqFs12hXt3ha8ZGFWlvgy2u7dX2csWoss=
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 (2603:10a6:102:34f::18) by VI1PR02MB6240.eurprd02.prod.outlook.com
 (2603:10a6:800:19a::19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 08:49:21 +0000
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::d2f4:cf3d:3090:8aa9]) by PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::d2f4:cf3d:3090:8aa9%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 08:49:21 +0000
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>, Vincent
 Whitchurch <Vincent.Whitchurch@axis.com>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>
Subject: Re: [PATCH v2] um: time-travel: fix time corruption
Thread-Topic: [PATCH v2] um: time-travel: fix time corruption
Thread-Index: AQHaB4QlxExByUl/yUm/hCQO8YHqdbBbq7AAgAAEGwCAABPLAA==
Date: Thu, 26 Oct 2023 08:49:21 +0000
Message-ID: <04afd005c5566fcc6a46549afd7b9136a7cec7a9.camel@axis.com>
References: <20231025224504.7be512cdfeb4.Ia20103ef9899e53311bd671b8cfbca4f057a4668@changeid>
	 <d3beded8a25acced5905c8f251a5e91d0f514185.camel@axis.com>
	 <39b6458f1214022e8a0d00c5cb70101a41296d74.camel@sipsolutions.net>
In-Reply-To: <39b6458f1214022e8a0d00c5cb70101a41296d74.camel@sipsolutions.net>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|VI1PR02MB6240:EE_
x-ms-office365-filtering-correlation-id: da02d5f3-4eba-4dd8-e9a0-08dbd6007265
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IBU3lMPyR41XGzgUwFxYvZyPY4SsHtyYC3CNBQcZWiLWZTPBcWEYGQ9lG2aEgfs0q0iqCgxPGZzNihTFGHUMUccsWt2RkUPqQp+/h23Vj0Co6IIUchDNfNvRxR+XLZOxLrPLRUTZCNMuw5D1JDeAwCUIQ9GpIxWbxI2/kdBL3RATvBoECiEeKfz9gRs3hrFPCsrmIqbnWuv+1iJNeYZP30MqlktGoMT8nUJP7u0QHKGgG5eopnd6ZiAgidE2bKoepPhtuZgXZ2szwCukNmyXWP2RjijQE6tMuEA++yWpI9nCX3uF7B+DeSBl9bPwOPPJIJFkXkZk+9vwC00JKcqZt5ooKr9FoB8T31oxPDGJ9gcW2wAm7FV4VjvGNdkZXoTA30GDtfduM06u1U6aY8RD8xEsa0gED8x/geuz1FH+THMY4VEDEaO5w8CMOX4ipaHEpk/5UBa4IftYWSWgnY0WOsrI098hrCXCq7ucff1FK9wneIudHeTIhX9aIEqk2KiAMNEeRriy38Os4HPHto+Oolf8S2x57yxp/zzsqqrS4dlTH7Yic18RjuuMyeTmZlU+/I6KVmcXVpO4S+S+9EkmFUqJVkpMscBrjZbstxXJPReiJhymrA/5Ty9BnDKiXVle
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(136003)(366004)(346002)(376002)(396003)(39850400004)(230922051799003)(186009)(64100799003)(451199024)(1800799009)(2616005)(4001150100001)(2906002)(316002)(26005)(91956017)(110136005)(6506007)(66446008)(478600001)(76116006)(6512007)(6486002)(71200400001)(83380400001)(66946007)(66476007)(66556008)(122000001)(36756003)(8936002)(5660300002)(41300700001)(38100700002)(8676002)(64756008)(38070700009)(86362001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dWZvNnBRTHM2eXJSWklwUmNWaUlmcUNjbUhPVGpOb2l1Y09Hc3lBZjM0djFh?=
 =?utf-8?B?WHJQZkwzd2ErUGxJOXpNTzd4TDhlQ3hNaWIrQWY1R3Z3TWx2cENZV2ROVXVn?=
 =?utf-8?B?ZFVUZWc4Ri8zeDVzU2hPZnRQYS9ZcElaN1Z2cmcxSFN0bGlKbENBdW05dm5r?=
 =?utf-8?B?dzg1ZFhiM1lQVzJ3aGNoRWtueDJBc0VPUjVScmlTVmhWNXpua1VxM1pSWTdG?=
 =?utf-8?B?V0J2YTBjWG5BSytWUnAveDZBc2NLK1plTUN2RXduQW1QWW5mWHFhRTZycSs4?=
 =?utf-8?B?NkNuUUFDemY5VEFvN2hQUXduak1Ec0t2NkpSdWhBMEUyMXlLSlJHTUFyYmNn?=
 =?utf-8?B?R0dpK2VUREhySkZLS2ZvTHJmcEhpUlJ0dVg0aW5mV0g1OXZZL2pLUmlueWgz?=
 =?utf-8?B?RS9uOHNDcU1aY0pjTXRGYk5IZFlkaDNIbXVKdUg1WW56VzVRVlZSR01EYWlJ?=
 =?utf-8?B?WVhBanhybE1UQndIR25TdHl2S0dCRnhQTFhmYWkwV3Y2K1RQYW5wUDZXUTBh?=
 =?utf-8?B?YTZWUE1ONFpUOTJxUyt6aHJTUmFNcnhCOUVPYlhyMm15dGtlTm1OMm9McWVF?=
 =?utf-8?B?RE9OaitvSFgzZ2hRYmdaQ0ZiZjFScW92VnVJWklRcmwrQmU3czBMb3E4UnBE?=
 =?utf-8?B?V3RTOTc0UTlKNjdBaCs2L2tFWG5FRS9qSlRUTmE0NXJaUWJSMUlpWGxzNWJX?=
 =?utf-8?B?TUQxQXN0YVpDUHA1TzEvNkNqU2x5Uy9GdTZBM1ZPeWtYMlRWZGIwWUNaWURs?=
 =?utf-8?B?YlQ1bkRXb25nL1VQR1Zwam5ka2VuZm5BcHZISWN4a1FaeTJvMnhKUGUxQXNl?=
 =?utf-8?B?anM3aldwdld6YnJQN3J3c1V1eW55dndKaXRnbElUTlRtVUlkWmVyeldLVnor?=
 =?utf-8?B?VldyRXM2NHVNVDMrcFlsbUlpQlREWVRxZ1VWd1lvSzlic3kvRzU3cS9PekNo?=
 =?utf-8?B?VjZ2ZTYwM01tMkxDVmk2UmJoQ2IxRFdrbUN4ejN4L2llRGJkN1V1elBrakdE?=
 =?utf-8?B?RXRCeWJRSXZ6ZWludmFqQ2FQR1llTGVKNUhDTmk3NUlOMzdkSUxrZ3NsYjRT?=
 =?utf-8?B?Yk5NR2RCd0NHNlBqLzN2a2NSdGoxMSszTXJDcmNSTVFxdnFKS2g2RTlGMHhv?=
 =?utf-8?B?Q3J1TWs3ajJPcXlqRTRscVJrOXVTVlBvTVJ0dmNyZ1Vtd2oxSjRXOXgrbWo1?=
 =?utf-8?B?N3VFTEVJaWk0MzRONzNhRGN0MkpCMXFoellMUlNEV2VFMUdQWW80b29tN0Nw?=
 =?utf-8?B?cGZ1d0FqRHRieDk2NStzNjRucXkvRHoxV1NlZUUyY1IyZnlydFM4S0JoeGFJ?=
 =?utf-8?B?Y2x6eUpXYkdPaXFkYjMyQjFPZWprVTZNL1FTc0doMXpQMGVHbEhmNWxYV1lm?=
 =?utf-8?B?ODhrbnZhNyt1c3FZZDAwZXROOVJKN1g2aW4xNVd0MDdxdi90QUlUVXlxcGFH?=
 =?utf-8?B?NFJlODY2N1NHWS9iUlZoWHlobnNkYmxkU2h1cW1XajgvbTVkTWpGVk0raE5m?=
 =?utf-8?B?UVV0YzFVc2lhT2VCL1R4aTBCOWJLUlVtN0pxYTFzalFtRnRXL3Nhc1dWajVs?=
 =?utf-8?B?S2s5MVJkd2wvME9tS3ZqVkdpRUpqaUVoSFFKNElCR1hRajBPSXNQalRMVXp4?=
 =?utf-8?B?MFF2ZEoxNzM1RUh6UTZMeGJ0b25vY2FKZFkxaGtkTEdTenJoR2k4R2Z2MTNv?=
 =?utf-8?B?VVVQVm1rYmp2bEY4OFJiemV4OEVhNmZ6cjZiM0h5RmNIaU4rU05icnZWOUxt?=
 =?utf-8?B?TnVvcXp2enpTSTRiem1iUXI3N2d2V3RkUStPeDhFY28wNnU2RjRUL3RMdEhF?=
 =?utf-8?B?aERENVpJUUZ0QXpXVGViVThDSTM1UnpuS2ZYZDFxbjZuM2tKQTRJbVFzMGhB?=
 =?utf-8?B?SGdTZ2p2a21DWGlWNzdWZWlEWVI2TlF4YmU4QTJpMTZBd3N2VmZ5N1gvVUhQ?=
 =?utf-8?B?K0o2Nk9TMnRpYk80QXdzRW9DU1hrVHR2alV2ODhLRFA4VEJJMjlyOTN3TEFT?=
 =?utf-8?B?L2hBbmU5R0s4Tkh3MXh6RmlGNFJxdEYyWXhrQW90MXJFNExFVENINVEycENa?=
 =?utf-8?B?ZnRhNTBRTWt4NHcxNEhsUUxMaDlXRER5NDUvUkdPTEIwMGlXSTB0aVRRNzZ3?=
 =?utf-8?Q?KkDpHFY/w9Crj5igKf8Jwka9S?=
Content-ID: <782E47D125F4584D8352A96A683B839D@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: da02d5f3-4eba-4dd8-e9a0-08dbd6007265
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 08:49:21.0635
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: wGqJIT4PUJaXhNdwkf/waJyOMmDvGnOPQyBifaFeZw1tZ3WOcQLGNcON7/FHXEkE
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR02MB6240
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_014932_040444_227DBA43 
X-CRM114-Status: GOOD (  25.80  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDA5OjM4ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBPbiBUaHUsIDIwMjMtMTAtMjYgYXQgMDc6MjMgKzAwMDAsIFZpbmNlbnQgV2hpdGNodXJjaCB3
cm90ZToNCj4gPiA+IEBAIC04MzksOSArODYzLDcgQEAgc3RhdGljIHU2NCB0aW1lcl9yZWFkKHN0
cnVjdCBjbG9ja3NvdXJjZSAqY3MpDQo+ID4gPiDCoAkJICovDQo+ID4gPiDCoAkJaWYgKCFpcnFz
X2Rpc2FibGVkKCkgJiYgIWluX2ludGVycnVwdCgpICYmICFpbl9zb2Z0aXJxKCkgJiYNCj4gPiA+
IMKgCQkgICAgIXRpbWVfdHJhdmVsX2V4dF93YWl0aW5nKQ0KPiA+ID4gLQkJCXRpbWVfdHJhdmVs
X3VwZGF0ZV90aW1lKHRpbWVfdHJhdmVsX3RpbWUgKw0KPiA+ID4gLQkJCQkJCVRJTUVSX01VTFRJ
UExJRVIsDQo+ID4gPiAtCQkJCQkJZmFsc2UpOw0KPiA+ID4gKwkJCXRpbWVfdHJhdmVsX3VwZGF0
ZV90aW1lX3JlbChUSU1FUl9NVUxUSVBMSUVSKTsNCj4gPiA+IMKgCQlyZXR1cm4gdGltZV90cmF2
ZWxfdGltZSAvIFRJTUVSX01VTFRJUExJRVI7DQo+ID4gPiDCoAl9DQo+ID4gDQo+ID4gVGhlIHJl
YXNvbiBJIGhlc2l0YXRlZCB3aXRoIHB1dHRpbmcgdGhlIHdob2xlIG9mDQo+ID4gdGltZV90cmF2
ZWxfdXBkYXRlX3RpbWUoKSB1bmRlciBsb2NhbF9pcnFfc2F2ZSgpIGluIG15IGF0dGVtcHQgd2Fz
DQo+ID4gYmVjYXVzZSBJIGRpZG4ndCBxdWl0ZSB1bmRlcnN0YW5kIHRoZSByZWFzb24gZm9yIHRo
ZSAhaXJxc19kaXNhYmxlZCgpDQo+ID4gY29uZGl0aW9uIGhlcmUgYW5kIHRoZSBjb21tZW50IGp1
c3QgYWJvdmUgaXQgYWJvdXQgcmVjdXJzaW9uIGFuZCB0aGluZ3MNCj4gPiBnZXR0aW5nIG1lc3Nl
ZCB1cC4gIElmIGl0J3MgT0sgdG8gZGlzYWJsZSBpbnRlcnJ1cHRzIGFzIHRoaXMgcGF0Y2ggZG9l
cywNCj4gPiBpcyB0aGUgIWlycXNfZGlzYWJsZWQoKSBjb25kaXRpb24gdmFsaWQ/DQo+IA0KPiBI
bW0uIEkgd2FzIGdvaW5nIHRvIHNheSB0aGF0J3MgZGlmZmVyZW50LCBiZWNhdXNlIGl0IHdhbnRz
IHRvIG9ubHkNCj4gcHJldmVudCB1cyBmcm9tIGRvaW5nIHRoaXMgd2hpbGUgd2UncmUgKmFscmVh
ZHkqIGluIElSUSBjb250ZXh0LCBhbmQgdGhlDQo+IGJ1ZyB5b3UgZm91bmQgaXMgY2FsbGluZyB0
aW1lcl9yZWFkKCkgbm90IGluIElSUSBjb250ZXh0LCBidXQgZ2V0dGluZyBhbg0KPiBldmVudCBx
dWV1ZWQgYnkgdGhlIHNpZ25hbC4NCj4gDQo+IEJ1dCAuLi4gbm93IHRoYXQgSSB0aGluayBhYm91
dCBpdCwgSSBoYXZlIGEgZmVlbGluZyB0aGF0IHRoaXMgd2FzIGENCj4gd29ya2Fyb3VuZCBmb3Ig
dGhlIGV4YWN0IHNhbWUgcHJvYmxlbSwgYW5kIEkganVzdCBkaWRuJ3QgdW5kZXJzdGFuZCBpdA0K
PiBhdCB0aGUgdGltZT8gSSBtZWFuLCByZWN1cnNpbmcgaW50byBvdXIgb3duIHByb2Nlc3Npbmcg
aXMgbm93IGltcG9zc2libGUNCj4gaGVyZSBhZnRlciB0aGlzIHBhdGNoIC0gZWl0aGVyIHdlJ3Jl
IHJ1bm5pbmcgbm9ybWFsbHksIG9yIHRoZSBpbnRlcnJ1cHQNCj4gY2Fubm90IGhpdCB0aW1lcl9y
ZWFkKCkgaW4gdGhlIG1pZGRsZSwgc2FtZSBhcyBpdCBjYW5ub3QgaGl0DQo+IHRpbWVfdHJhdmVs
X2hhbmRsZV9yZWFsX2FsYXJtKCkgaW4gdGhlIG1pZGRsZSBub3cuDQo+IA0KPiBSZW1vdmluZyB0
aGF0IHN0aWxsIHNlZW1zIHRvIHdvcmsgd2l0aCB5b3VyIHRlc3QsIGJ1dCBpdCdzIGFsc28gbm90
IGENCj4gZ29vZCB0ZXN0IGZvciB0aGlzLCBzaW5jZSB0aGVyZSBhcmUgbm8gZGV2aWNlcyBldGMu
IHRoYXQgY291bGQgaGF2ZQ0KPiBpbnRlcnJ1cHRzLCBub3Qgc3VyZSBob3cgdG8gdGVzdCBpdCBy
aWdodCBub3c/DQo+IA0KPiBNYXliZSBJJ2xsIGFkZCBhIGNvbW1lbnQgdGhlcmUgc2F5aW5nIHRo
aXMgbWlnaHQgbm8gbG9uZ2VyIGJlIG5lZWRlZD8NCg0KSSB0cmllZCByZW1vdmluZyB0aGUgIWly
cXNfZGlzYWJsZWQoKSBjaGVjayBhbmQgdGhhdCBibGV3IHVwIHByZXR0eQ0KcXVpY2tseSAoYmVs
b3cpIHdoZW4gcnVubmluZyB0aGUgZnVsbCByb2FkdGVzdCBzdWl0ZS4gIEl0IHdvcmtzIGZpbmUN
CndpdGggeW91ciB1bm1vZGlmaWVkIHBhdGNoIHNvIG5vIG5lZWQgdG8gY2hhbmdlIHRoZSBjb21t
ZW50Lg0KDQogS2VybmVsIHBhbmljIC0gbm90IHN5bmNpbmc6IHRpbWUtdHJhdmVsOiB0aW1lIGdv
ZXMgYmFja3dhcmRzIDI2Mzc0NzkwMDAwODY0IC0+IDI2Mzc0NzkwMDAwODUzDQogc2hvd19zdGFj
ay5jb2xkIChhcmNoL3VtL2tlcm5lbC9zeXNycS5jOjU2KSANCiBkdW1wX3N0YWNrX2x2bCAobGli
L2R1bXBfc3RhY2suYzoxMDcgKGRpc2NyaW1pbmF0b3IgNCkpIA0KIGR1bXBfc3RhY2sgKGxpYi9k
dW1wX3N0YWNrLmM6MTE0KSANCiBwYW5pYyAoa2VybmVsL3BhbmljLmM6MjYyIGtlcm5lbC9wYW5p
Yy5jOjM2MSkgDQogdGltZXJfaGFuZGxlci5jb2xkIChhcmNoL3VtL2tlcm5lbC90aW1lLmM6NTEg
YXJjaC91bS9rZXJuZWwvdGltZS5jOjUxMCBhcmNoL3VtL2tlcm5lbC90aW1lLmM6NjM0KSANCiB0
aW1lcl9yZWFsX2FsYXJtX2hhbmRsZXIgKGFyY2gvdW0vb3MtTGludXgvc2lnbmFsLmM6MTA5KSAN
CiB1bmJsb2NrX3NpZ25hbHMgKGFyY2gvdW0vb3MtTGludXgvc2lnbmFsLmM6MzM4KSANCiB0aWNr
X25vaHpfaWRsZV9leGl0IChrZXJuZWwvdGltZS90aWNrLXNjaGVkLmM6MTM2NCkgDQogZG9faWRs
ZSAoa2VybmVsL3NjaGVkL2lkbGUuYzozMTApIA0KIGNwdV9zdGFydHVwX2VudHJ5IChrZXJuZWwv
c2NoZWQvaWRsZS5jOjM3OSAoZGlzY3JpbWluYXRvciAxKSkgDQoga2VybmVsX2luaXQgKGluaXQv
bWFpbi5jOjE0MzUpIA0KIDB4NjAwMDFjZTYgDQogMHg2MDAwMjIwZSANCiAweDYwMDA0OTYxIA0K
IG5ld190aHJlYWRfaGFuZGxlciAoYXJjaC91bS9pbmNsdWRlL2FzbS90aHJlYWRfaW5mby5oOjQ2
IGFyY2gvdW0va2VybmVsL3Byb2Nlc3MuYzoxMzYpIA0KIHVtbF9maW5pc2hzZXR1cCAoYXJjaC91
bS9rZXJuZWwvdW1fYXJjaC5jOjI2OCkgDQoNCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5p
bmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8v
bGludXgtdW0K
