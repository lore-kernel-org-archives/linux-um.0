Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C21C25B48
	for <linux-um@archiver.kernel.org>; Thu, 26 Oct 2023 07:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=g6gR6AnfGIUjFIU0Hf/TDt4mlB+/vaB5up6KtSwC21o=; b=RqYOYHZoTk+JxP
	DftJjxPjYjVGADmP87A+A/PTbXdhrgRJzNl7oeTuW+PnpPqXGnDDdZ3SBjoH2O64uMoUz6CmOluAu
	nLo7+S/Zrl3eqy/W2sLn50yVHcH11e9UjqKye9NT4eh/cSDImuwj9A6gWy0Tm6LaS9RxKUy+Blrdj
	WJeRa0qAhVewZF12xx0orjiFXmVKCUsnQQmGhO38s7iNzK1sqXgap0KMwKVVgIThINY8wDPf0ooNt
	JiuoniBX8WZh0vTeeoQg1cPcVoaWmflMjPpZ7CmfvsxHHNFIbZaa62S1sTz1H4VwjYTik0UbctsEA
	Qsiux9rycUFZll7nH0zg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvuin-00DqKl-23;
	Thu, 26 Oct 2023 07:24:01 +0000
Received: from mail-db8eur05on20611.outbound.protection.outlook.com ([2a01:111:f400:7e1a::611] helo=EUR05-DB8-obe.outbound.protection.outlook.com)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvuij-00DqKG-2x
	for linux-um@lists.infradead.org;
	Thu, 26 Oct 2023 07:24:00 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HVYsz/8ucHOQdKinkysFN+SMQvnnF3ig0fN9SpzZGAbh7ylmWOg2GKB44iGLxylycru/fvagww4IHiICQgyexd5Cz90c0B1i7WmbilO8dmtWdzDwIMNIuNpJ7xNeMrKrwJxLYNWRgrZza+kDfbhRhXuK3vq+xp5cjfCWjZtsEJ0Loxm2PlRXmNnQQ7An8rGYDFpcL/JSp5m3vnCME4DAG2FOvplNCsw6HOPx9Y1HNEcm/ieXdne8Jt35Omp9cZPMzjdU/k+EUWmp6hb8H7gQWLSRWpQNBUanASXjQEAQOQP2IkT6XwBl6+s+0JMN0XgjPdr7BHE+cTAapFlmmiMKDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zatw+l2Iwo68HPVe9Z4AvHuQVVss+KIXde3BjJyIr5s=;
 b=jE+PZuL8UCGGAjzk8xLEWHi32Luia5cPqgI5umSlHaFyDKbwaI2+ijuWTT9mxy4mL0sEXhNdaLuFMJIkCF5oYZTvteyGv/fg1KCx3V42eLWmxtzNG4O3ZxGv+mr8cIiGsambATR4stZeycUe6ZP2uExB+QHMRp2jI/2WKGVxHlZaqnIIU9ySX78/TpJc8bYyp73KbNGFl35QAl6q6uGu+WHGxrUskSnqCJ+BnOA3USuKbESswz4/5QKO22FiZJKGxu1yDuFiqfyK7a71WpIOuugd2irGB2mesvX/L+6V8Dgefmqpu0kgAPRUVv/luTd/vqAIufyBTNinVLme6tcDeQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zatw+l2Iwo68HPVe9Z4AvHuQVVss+KIXde3BjJyIr5s=;
 b=YxZrNqtGGHbxJxFuZyd/k/Qf+bgcZOfAqfrRrFKfddBILo3oczDl52TgE3yZpzlLZZBe7N1YCycLEjgjmu30n/SUXNRGfynJ/Fnwkm0007nRxBs37VsFLGSuLOzIplRaNPNdRIeO6U7Cy9PhtZOv9IxW8jzIeLsXhMB9aMIijwE=
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 (2603:10a6:102:34f::18) by DB8PR02MB5883.eurprd02.prod.outlook.com
 (2603:10a6:10:116::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.6907.33; Thu, 26 Oct
 2023 07:23:49 +0000
Received: from PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::d2f4:cf3d:3090:8aa9]) by PAWPR02MB10280.eurprd02.prod.outlook.com
 ([fe80::d2f4:cf3d:3090:8aa9%3]) with mapi id 15.20.6907.032; Thu, 26 Oct 2023
 07:23:49 +0000
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
	"linux-um@lists.infradead.org" <linux-um@lists.infradead.org>
CC: "johannes.berg@intel.com" <johannes.berg@intel.com>, Vincent Whitchurch
	<Vincent.Whitchurch@axis.com>
Subject: Re: [PATCH v2] um: time-travel: fix time corruption
Thread-Topic: [PATCH v2] um: time-travel: fix time corruption
Thread-Index: AQHaB4QlxExByUl/yUm/hCQO8YHqdbBbq7AA
Date: Thu, 26 Oct 2023 07:23:49 +0000
Message-ID: <d3beded8a25acced5905c8f251a5e91d0f514185.camel@axis.com>
References: <20231025224504.7be512cdfeb4.Ia20103ef9899e53311bd671b8cfbca4f057a4668@changeid>
In-Reply-To: <20231025224504.7be512cdfeb4.Ia20103ef9899e53311bd671b8cfbca4f057a4668@changeid>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|DB8PR02MB5883:EE_
x-ms-office365-filtering-correlation-id: 7a4d5eb8-f0ea-4727-fdae-08dbd5f47f88
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: n5xChFKpgSsUF4rthupzhj4WgkhQuIRt5vHnHbhH3gDyZ/PMAGH64iR/JcTR+Y59TmcMY5HqBxEtgYYWC+W90fmBE7DIAoPQ/HChniBpuytB2b+16JOKvPbNqaVSW5oUuN3aQdcss1DWb5u26jEt+il4TUWiKo+CHXt/Rl8ZYuoSyeXJCxCxUiefPr/4wNMHxRz6MWxWvps+31Fsy7jNsHl/Kqi49lzHGFx1lU79aTBvgIFlrYX92vwsutRDqiKaWHCYDUwJiZu/iuacwyvkOfESSkSFkkcTV5M2wUxp5ZIk7E/ukaq0UTpf40E00W+pDqLhCxRHXkrZfTkUwuGqypRtsyUwNWzHyZoTDpP9I9mlONCcu2qH7z3SDbGvXG9pEYrYzKEAdzid0Y86ZWmOCv2Wa/aacld6eVWCvh0W3gfOzaBjfqIEyJI5Z4pzO3zHB9kNAjtJ4XB5IYWs2yjWlHSVDTYrEF+yu+Yv52TbZkcDeBIIaBTxEQT5zu2oj2/OSXBGqQ/lshxVLv3IclubV8vfwIcxs9cl3BOanzsEZNRxNcRJwHyq7uZKeeksSIlY7AmAVAStpjHfFlZb/P7w36vQb59zd5aK2t8SwGauxBL6YZ2SFNreN9xMtwY1Tcs4
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(376002)(39860400002)(396003)(136003)(230922051799003)(451199024)(1800799009)(64100799003)(186009)(38070700009)(6506007)(2616005)(6512007)(122000001)(38100700002)(36756003)(4326008)(41300700001)(4001150100001)(2906002)(107886003)(66946007)(6486002)(71200400001)(83380400001)(478600001)(86362001)(26005)(8936002)(8676002)(64756008)(5660300002)(316002)(110136005)(66446008)(76116006)(54906003)(91956017)(66476007)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?QnBUZjV4UkpXQ1B5MEI2T08wWmRIZkR4TEdtZ0d6MXNXcVVYN3p5L1JpRllI?=
 =?utf-8?B?QUVFRGhiMTNzcXJKejhnQnFJdUJtVk1BbzAzYWdnR1hDaHBpeG1CTzYrNWYr?=
 =?utf-8?B?R1FjNWJFNExoL3FpVTZsWUlLTjVKNjVkTzFTMUE4TmNOYXlCVFU4TWlFUzdo?=
 =?utf-8?B?Z09JYmREQkdzTzc2SW8zWE16MzBJNVI5S1NZYUNyYWhhSUJ0RUlRM2RnalJF?=
 =?utf-8?B?Wll3UjhGVCtHWEtmZml1YnRWQUhXQk9LbHllSmlMMEovNks1blpJWVB1ZG4y?=
 =?utf-8?B?VlNycGZIYm9wQnRUOWJnT2ZKa2xRZmRVTzBpWkhWdE1zLzd3TWJYa243R1Z1?=
 =?utf-8?B?YjY4RXNOUW56K3ZUY0RTUWJNcUQ3em5PQkRMT3llYUJIZk4wWTF3OUlMWnBj?=
 =?utf-8?B?OEtnaXQ5R2NtVXphMHdBN2JUVGxONzVzWCtMWDM3MzIvYWplMmRSaXpPQjRS?=
 =?utf-8?B?Rzl0V2daTmNuSk9pVXkvcXlTUmlBY1p1K1NzUnZKdm41anpqVmFoMnA5eFBj?=
 =?utf-8?B?WUFob2x1NUFiUWZlZCs3UmRpQTVuRkNydkJNVng1VjVnS0hONTI4UHYwVWxN?=
 =?utf-8?B?a1FYN2h5UkZ1WExiWFE5empPNzd1blg4cHpyUkZCZkxReWJRMngxV0JsLzN5?=
 =?utf-8?B?cHBaMkp0L2lUWW10dVFQT1dWdGp5ZHhnQkNnbnNQYXI5S0R2eVlZc1FPN25I?=
 =?utf-8?B?QVlScU14MUMwcDV5ZXhVU1E2VXdJd0dXYVF0MEhvMS9sU2JOUDhGSW1Jdmt3?=
 =?utf-8?B?YmxJbXFLenhnMW8rUlFYUFU2SEtDQTdwbFFmeER0bTZkOWpzQXR6TFFhNXY5?=
 =?utf-8?B?RjVJMGo4eUdnM0ZPRUlXbTdvd0tUK1RDVFdDY0o4dWl6TXlnY0M5ekUxWXl0?=
 =?utf-8?B?ZFliUUNob2F3U1hsWXBmRWV1RUdlZDZUdytSL3lmQnVOSURNb2ltSkRORnlh?=
 =?utf-8?B?THlyMlg2Y0x0NUtDQU1mcjZzS1dhcGN5ZzUreVd3c1ZLNEFIOUVvbVh0d21s?=
 =?utf-8?B?ZzZ1UU1saEZGWkNtc2gwbzQxYU5Tb3VyR01NNnI1U3ZOdUdIdFBYckRiZis0?=
 =?utf-8?B?bXhaRGt1QlhyQ3Badjd3N09yU3EwRmVzUWVzdlJyVDBoZTJWSUJzZ0lKNndX?=
 =?utf-8?B?MitaSW5laENVZGVkcUU3Q0RyRFIwTkpaTll0Vkp3azF1M2VyOW53bWQ4bnFW?=
 =?utf-8?B?NzVxTW1HWlVEWnVuUllSRkhWcG1rMXZheGhBak10ZzVaWUVCVHI2Y0syemo3?=
 =?utf-8?B?bVVYd040ZWxmSjcrdjZSbWxJWG5UcW53aWxiWUJ0eVFPc0dSVVZpa0NUL05V?=
 =?utf-8?B?aUpzNjZ3RnNjM21hS2FFS3hIMklQRjlUNHhELzF6WDIveko3cjFBSHRIcDF2?=
 =?utf-8?B?VjJWZ1NEVHFlOC83dng2dTdNUFpMSDdEd3BKM0o1VjhiYjZKOGVjYnZFMTl0?=
 =?utf-8?B?S0JxUW5va0s1d2UxT0M2N245aXRKWkhKQkRsM2lNTEt6TlJHQzJGelpMdnJF?=
 =?utf-8?B?SXpJMldSQmVIM1cvVmEvTVFlM2orRDRaZ1BGdkIyRW9iaFE1QjBZSUcxM3Jm?=
 =?utf-8?B?RktJWjlmODg4bUFJcTZibE55THlrUmZVYnAyWG9LV0xNWENzVUVKQzFTOTNG?=
 =?utf-8?B?WjVsYmlYY0d4aEVoOE9MVkRkOWxwdThsMURrY25MV2NndEZvZ1lsTW5oOW1Y?=
 =?utf-8?B?bGFKWXdOSXJMeVg5T1FYd3dSRXZzV1l4V2l1ZjIyZVRXM082OGdoUmdqblBz?=
 =?utf-8?B?U3ZqVmN5a2tLRWxnVHZKYXJXdFo4QVB4U1Q0WCtEd1lTVnJPeVdhbFRRczc3?=
 =?utf-8?B?SnM5S2hkTmFSdzdtQ1hLRm1ZSEVQczNLTFBYWGZhQm4vNTRuZlBGZjRHN1F3?=
 =?utf-8?B?dzlmckowMVFTRjVpTkppNDVpRFVabmdWOWlENXJ4TFpIT3h1cCtsWmIyUUk2?=
 =?utf-8?B?ZkUzVGdQOWtaWFdDMHFJaTUxTE4reTNOaVY0aTQvL3BWbUV4OHVaSm8wb1hW?=
 =?utf-8?B?R0xHWnBlQXBDeDMvWWhndDBJVHhQR2ROZktJOVhDaGNETitCYW81TUpVMXd4?=
 =?utf-8?B?Nm1JNGZyc1c5bXVEejNMY3J5bE5KeUVuY1U0NllSQmdpREhVSFpGZjN6RTVy?=
 =?utf-8?Q?akiNMGuEAKl9qoX3EOBVmzLn8?=
Content-ID: <36D52228CADE404EBD352901E29E3A85@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-OriginatorOrg: axis.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7a4d5eb8-f0ea-4727-fdae-08dbd5f47f88
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Oct 2023 07:23:49.1123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nZylrhJ3nB434R7Qg3aS+orE3e6zasqTezMwW3ukiKctXOioWFi/CDChVB4xYjXV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR02MB5883
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_002358_340708_1CAE56C1 
X-CRM114-Status: GOOD (  27.24  )
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

T24gV2VkLCAyMDIzLTEwLTI1IGF0IDIyOjQ1ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0K
PiBGcm9tOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5lcy5iZXJnQGludGVsLmNvbT4NCj4gDQo+IElu
ICdiYXNpYycgdGltZS10cmF2ZWwgbW9kZSAod2l0aG91dCA9aW5mLWNwdSBvciA9ZXh0KSwgd2UN
Cj4gc3RpbGwgZ2V0IHRpbWVyIGludGVycnVwdHMuIFRoZXNlIGNhbiBoYXBwZW4gYXQgYXJiaXRy
YXJ5DQo+IHBvaW50cyBpbiB0aW1lLCBpLmUuIHdoaWxlIGluIHRpbWVyX3JlYWQoKSwgd2hpY2gg
cHVzaGVzDQo+IHRpbWUgZm9yd2FyZCBqdXN0IGEgbGl0dGxlIGJpdC4gVGhlbiwgaWYgd2UgaGFw
cGVuIHRvIGdldA0KPiB0aGUgaW50ZXJydXB0IGFmdGVyIGNhbGN1bGF0aW5nIHRoZSBuZXcgdGlt
ZSB0byBwdXNoIHRvLA0KPiBidXQgYmVmb3JlIGFjdHVhbGx5IGZpbmlzaGluZyB0aGF0LCB0aGUg
aW50ZXJydXB0IHdpbGwgc2V0DQo+IHRoZSB0aW1lIHRvIGEgdmFsdWUgdGhhdCdzIGluY29tcGF0
aWJsZSB3aXRoIHRoZSBmb3J3YXJkLA0KPiBhbmQgd2UnbGwgY3Jhc2ggYmVjYXVzZSB0aW1lIGdv
ZXMgYmFja3dhcmRzIHdoZW4gd2UgZG8gdGhlDQo+IGZvcndhcmRpbmcuDQo+IA0KPiBGaXggdGhp
cyBieSByZWFkaW5nIHRoZSB0aW1lX3RyYXZlbF90aW1lLCBjYWxjdWxhdGluZyB0aGUNCj4gYWRq
dXN0bWVudCwgYW5kIGRvaW5nIHRoZSBhZGp1c3RtZW50IGFsbCB3aXRoIGludGVycnVwdHMNCj4g
ZGlzYWJsZWQuDQo+IA0KPiBSZXBvcnRlZC1ieTogVmluY2VudCBXaGl0Y2h1cmNoIDxWaW5jZW50
LldoaXRjaHVyY2hAYXhpcy5jb20+DQo+IFNpZ25lZC1vZmYtYnk6IEpvaGFubmVzIEJlcmcgPGpv
aGFubmVzLmJlcmdAaW50ZWwuY29tPg0KDQpUaGFua3MsIHRoaXMgd29ya3MgZm9yIG1lIHRvby4g
IEhvd2V2ZXIsIG9uZSBxdWVzdGlvbiBiZWxvdy4NCg0KPiAtLS0NCj4gdjI6IHJlbW92ZSBzdHJh
eSBkZWJ1ZyBjb2RlDQo+IC0tLQ0KPiDCoGFyY2gvdW0va2VybmVsL3RpbWUuYyB8IDMyICsrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tDQo+IMKgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC91bS9rZXJu
ZWwvdGltZS5jIGIvYXJjaC91bS9rZXJuZWwvdGltZS5jDQo+IGluZGV4IDhmZjQ2YmM4NmQwOS4u
MGMwMTY3NGUxNGQ1IDEwMDY0NA0KPiAtLS0gYS9hcmNoL3VtL2tlcm5lbC90aW1lLmMNCj4gKysr
IGIvYXJjaC91bS9rZXJuZWwvdGltZS5jDQo+IEBAIC01NTEsOSArNTUxLDI5IEBAIHN0YXRpYyB2
b2lkIHRpbWVfdHJhdmVsX3VwZGF0ZV90aW1lKHVuc2lnbmVkIGxvbmcgbG9uZyBuZXh0LCBib29s
IGlkbGUpDQo+IMKgCXRpbWVfdHJhdmVsX2RlbF9ldmVudCgmbmUpOw0KPiDCoH0NCj4gwqANCj4g
DQo+ICtzdGF0aWMgdm9pZCB0aW1lX3RyYXZlbF91cGRhdGVfdGltZV9yZWwodW5zaWduZWQgbG9u
ZyBsb25nIG9mZnMpDQo+ICt7DQo+ICsJdW5zaWduZWQgbG9uZyBmbGFnczsNCj4gKw0KPiArCS8q
DQo+ICsJICogRGlzYWJsZSBpbnRlcnJ1cHRzIGJlZm9yZSBjYWxjdWxhdGluZyB0aGUgbmV3IHRp
bWUgc28NCj4gKwkgKiB0aGF0IGEgcmVhbCB0aW1lciBpbnRlcnJ1cHQgKHNpZ25hbCkgY2FuJ3Qg
aGFwcGVuIGF0DQo+ICsJICogYSBiYWQgdGltZSBlLmcuIGFmdGVyIHdlIHJlYWQgdGltZV90cmF2
ZWxfdGltZSBidXQNCj4gKwkgKiBiZWZvcmUgd2UndmUgY29tcGxldGVkIHVwZGF0aW5nIHRoZSB0
aW1lLg0KPiArCSAqLw0KPiArCWxvY2FsX2lycV9zYXZlKGZsYWdzKTsNCj4gKwl0aW1lX3RyYXZl
bF91cGRhdGVfdGltZSh0aW1lX3RyYXZlbF90aW1lICsgb2ZmcywgZmFsc2UpOw0KPiArCWxvY2Fs
X2lycV9yZXN0b3JlKGZsYWdzKTsNCj4gK30NCj4gKw0KPiDCoHZvaWQgdGltZV90cmF2ZWxfbmRl
bGF5KHVuc2lnbmVkIGxvbmcgbnNlYykNCj4gwqB7DQo+IC0JdGltZV90cmF2ZWxfdXBkYXRlX3Rp
bWUodGltZV90cmF2ZWxfdGltZSArIG5zZWMsIGZhbHNlKTsNCj4gKwkvKg0KPiArCSAqIE5vdCBz
dHJpY3RseSBuZWVkZWQgdG8gdXNlIF9yZWwoKSB2ZXJzaW9uIHNpbmNlIHRoaXMgaXMNCj4gKwkg
KiBvbmx5IHVzZWQgaW4gSU5GQ1BVL0VYVCBtb2RlcywgYnV0IGl0IGRvZXNuJ3QgaHVydCBhbmQN
Cj4gKwkgKiBpcyBtb3JlIHJlYWRhYmxlIHRvby4NCj4gKwkgKi8NCj4gKwl0aW1lX3RyYXZlbF91
cGRhdGVfdGltZV9yZWwobnNlYyk7DQo+IMKgfQ0KPiDCoEVYUE9SVF9TWU1CT0wodGltZV90cmF2
ZWxfbmRlbGF5KTsNCj4gwqANCj4gDQo+IEBAIC02ODcsNyArNzA3LDExIEBAIHN0YXRpYyB2b2lk
IHRpbWVfdHJhdmVsX3NldF9zdGFydCh2b2lkKQ0KPiDCoCNkZWZpbmUgdGltZV90cmF2ZWxfdGlt
ZSAwDQo+IMKgI2RlZmluZSB0aW1lX3RyYXZlbF9leHRfd2FpdGluZyAwDQo+IMKgDQo+IA0KPiAt
c3RhdGljIGlubGluZSB2b2lkIHRpbWVfdHJhdmVsX3VwZGF0ZV90aW1lKHVuc2lnbmVkIGxvbmcg
bG9uZyBucywgYm9vbCByZXRlYXJseSkNCj4gK3N0YXRpYyBpbmxpbmUgdm9pZCB0aW1lX3RyYXZl
bF91cGRhdGVfdGltZSh1bnNpZ25lZCBsb25nIGxvbmcgbnMsIGJvb2wgaWRsZSkNCj4gK3sNCj4g
K30NCj4gKw0KPiArc3RhdGljIGlubGluZSB2b2lkIHRpbWVfdHJhdmVsX3VwZGF0ZV90aW1lX3Jl
bCh1bnNpZ25lZCBsb25nIGxvbmcgb2ZmcykNCj4gwqB7DQo+IMKgfQ0KPiDCoA0KPiANCj4gQEAg
LTgzOSw5ICs4NjMsNyBAQCBzdGF0aWMgdTY0IHRpbWVyX3JlYWQoc3RydWN0IGNsb2Nrc291cmNl
ICpjcykNCj4gwqAJCSAqLw0KPiDCoAkJaWYgKCFpcnFzX2Rpc2FibGVkKCkgJiYgIWluX2ludGVy
cnVwdCgpICYmICFpbl9zb2Z0aXJxKCkgJiYNCj4gwqAJCSAgICAhdGltZV90cmF2ZWxfZXh0X3dh
aXRpbmcpDQo+IC0JCQl0aW1lX3RyYXZlbF91cGRhdGVfdGltZSh0aW1lX3RyYXZlbF90aW1lICsN
Cj4gLQkJCQkJCVRJTUVSX01VTFRJUExJRVIsDQo+IC0JCQkJCQlmYWxzZSk7DQo+ICsJCQl0aW1l
X3RyYXZlbF91cGRhdGVfdGltZV9yZWwoVElNRVJfTVVMVElQTElFUik7DQo+IMKgCQlyZXR1cm4g
dGltZV90cmF2ZWxfdGltZSAvIFRJTUVSX01VTFRJUExJRVI7DQo+IMKgCX0NCg0KVGhlIHJlYXNv
biBJIGhlc2l0YXRlZCB3aXRoIHB1dHRpbmcgdGhlIHdob2xlIG9mDQp0aW1lX3RyYXZlbF91cGRh
dGVfdGltZSgpIHVuZGVyIGxvY2FsX2lycV9zYXZlKCkgaW4gbXkgYXR0ZW1wdCB3YXMNCmJlY2F1
c2UgSSBkaWRuJ3QgcXVpdGUgdW5kZXJzdGFuZCB0aGUgcmVhc29uIGZvciB0aGUgIWlycXNfZGlz
YWJsZWQoKQ0KY29uZGl0aW9uIGhlcmUgYW5kIHRoZSBjb21tZW50IGp1c3QgYWJvdmUgaXQgYWJv
dXQgcmVjdXJzaW9uIGFuZCB0aGluZ3MNCmdldHRpbmcgbWVzc2VkIHVwLiAgSWYgaXQncyBPSyB0
byBkaXNhYmxlIGludGVycnVwdHMgYXMgdGhpcyBwYXRjaCBkb2VzLA0KaXMgdGhlICFpcnFzX2Rp
c2FibGVkKCkgY29uZGl0aW9uIHZhbGlkPw0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC11bQo=
