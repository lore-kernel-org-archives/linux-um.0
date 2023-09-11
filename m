Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62BADEE7FF4
	for <linux-um@archiver.kernel.org>; Mon, 11 Sep 2023 07:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Content-ID:In-Reply-To:
	References:Message-ID:Date:Subject:CC:To:From:Reply-To:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=EXzH+YPHyhGStMruFRl+DZBYTHvM8vu6ZtPZewFW3n8=; b=DU3u2DY1JZ3CUX
	o7nSNdCBdCRKpAHW3Yau/rOpHNKgpIvRNHCHhtUM60cBaLZ1JrOZVf2pRnKc5kpLH+6kA+x3HiKyn
	DGP0dXZ1+xnCF3kok/CsjYbUabX4MgOI2wZWKvCuWmx6a9PsHjaunyquyUgu+GzbZE3JdLZPO1oNR
	qVCXr7c4N0LXEL0cwfPinRVuaBjKrlZw/XHIiwvgtWn70opxr+RzzsQjoYjr/3DaaoIIDqvfCmBe9
	3T5REBk2Fx5ipFrEuSqaP0aEYVEeEntPRd3zHK/tIVUYkP+79wzVrvonaBN8JnZ7DKnxa66o3KHs7
	/xfd6z4pqwaCz5Ni9eTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbJE-00HPK5-1f;
	Mon, 11 Sep 2023 07:26:12 +0000
Received: from smtp2.axis.com ([195.60.68.18])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qfbJB-00HPIo-2D
	for linux-um@lists.infradead.org;
	Mon, 11 Sep 2023 07:26:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=axis.com; q=dns/txt; s=axis-central1; t=1694417169;
  x=1725953169;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=SRzgu3whToxQprH/a+lTsuIbz30UkQmXZTNxXmYZvVs=;
  b=g8zGCj+l2EbQN6ed7tXuJb8NcsvS5hre1rF4Xl05wHf7JLav0iz2Srgo
   EyV2XUUN/WYd+ViW82MdWqRsOKOMJJy9PRJci6i8BR1QsOzprwr/dRX9G
   Aoi5ySsZaVe6ShC77Se5AwdsGPn8woi0OIZ8vk/Or9HLX5iKwl5sACjOT
   MDCVZnFKD5JnGOtpX8Ly5MqmQuZVds6a/HqOGkdgG4wrMK0DQlQ5zwHg0
   SjzzCx5ZDI9S/qBI84JU/ntvZkm91E8Dh0f1Mkgti7Jp8KRdye/W4qZav
   hhabDbNWO2tVtpzfglM1m/tQ9umxDRTpp5uYAgd3PL26yTpb1cvEtOJ69
   A==;
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mnoaSvjRyeKvacG4VRoaGx18DA7PH4rPnICobChmYN3mj1UCGef88l1oePMsZp9VvGFRazqsDHsnEkXFsppWaDrY6SGLNItSYINjT+NsrJrXbT5StjGXn2Z0bCA1u7Rudvxn4YxdwmXDP1M97nxe+OrDpMJiNfy0hCT3m58PxQkTFrAkR+QarbTw1QvR4gDwNeV9T7iplqniyrbXbrQ2KDfMXz8nNzodseMU2iCaY0IW+YkQgmvQfvNdgijbvwnKpcs+EO1kEcI9637t0bARc6BjhYN8S9J/foqEv//0qZeiLm9DhGHAEV+SC5etwZNF0kCsPTxtK8PQWpdmg0XTVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=SRzgu3whToxQprH/a+lTsuIbz30UkQmXZTNxXmYZvVs=;
 b=YmqzomdOdNcxQWuepWN3wCjQ8Q6iaxuxJaPXPvhMMmW02PPnMTq4f9e7Yyy5GvvLkX3O4SwctDRpzjEJF/my8SEjpKjYXDoMeJQDqDukLzlNN6/UviDqpoZLD+FfMYOgL1g09Sb5oPeJEShhdavMaBSro7EDylrZJKYR1Mhp1l27nMFydAOXESu+umivW2sQ9nArI+KpXmkTgxLl70RyeagfksGVV9zNRRoRmSF0wwIqbwPo6uXmmP8/WG9oElxyCuF+lrTBJABUz91JoEckOQm8Q+tMTgr5keDbegRl8dPhZ6Jz45ySD1AxYSct7hoQstZhD+8Wh4/N8oZZXaKIkw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=axis.com; dmarc=pass action=none header.from=axis.com;
 dkim=pass header.d=axis.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axis.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=SRzgu3whToxQprH/a+lTsuIbz30UkQmXZTNxXmYZvVs=;
 b=fP+UeHy36h/0bYSCEzDWLKAlLhCptRj35ztiPxePUJfRXsB4+T37fEOGrm2KffCyGsttDkpufMNtERw9vSdEqQ9HMj5g+OqVfGmTHgIpDimgtEt2pYdawvJy6PUOEztJRqV0URaKbgGy0z86C4V468RprY+Jpse39oJ//KGQP7o=
From: Vincent Whitchurch <Vincent.Whitchurch@axis.com>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>, "davidgow@google.com"
	<davidgow@google.com>, "x86@kernel.org" <x86@kernel.org>
CC: "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>, kernel
	<kernel@axis.com>, "rafael.j.wysocki@intel.com" <rafael.j.wysocki@intel.com>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	"johannes@sipsolutions.net" <johannes@sipsolutions.net>, "mingo@redhat.com"
	<mingo@redhat.com>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "tglx@linutronix.de" <tglx@linutronix.de>,
	"andreyknvl@gmail.com" <andreyknvl@gmail.com>,
	"anton.ivanov@cambridgegreys.com" <anton.ivanov@cambridgegreys.com>,
	"dvyukov@google.com" <dvyukov@google.com>, "richard@nod.at" <richard@nod.at>,
	"hpa@zytor.com" <hpa@zytor.com>, "peterz@infradead.org"
	<peterz@infradead.org>, "ryabinin.a.a@gmail.com" <ryabinin.a.a@gmail.com>,
	"frederic@kernel.org" <frederic@kernel.org>, "bp@alien8.de" <bp@alien8.de>,
	"glider@google.com" <glider@google.com>, "vincenzo.frascino@arm.com"
	<vincenzo.frascino@arm.com>, "kasan-dev@googlegroups.com"
	<kasan-dev@googlegroups.com>
Subject: Re: [PATCH] x86: Fix build of UML with KASAN
Thread-Topic: [PATCH] x86: Fix build of UML with KASAN
Thread-Index: AQHZmsQx3HM02RYVik+aPUiiZcEw2q+Dtz2AgJIVpwA=
Date: Mon, 11 Sep 2023 07:26:00 +0000
Message-ID: <f11475f922994b88f5adb14d23240716e16d5303.camel@axis.com>
References: <20230609-uml-kasan-v1-1-5fac8d409d4f@axis.com>
	 <CABVgOS=X1=NC9ad+WV4spFFh4MBHLodhcyQ=Ks=6-FpXrbRTdA@mail.gmail.com>
In-Reply-To: <CABVgOS=X1=NC9ad+WV4spFFh4MBHLodhcyQ=Ks=6-FpXrbRTdA@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Evolution 3.38.3-1+deb11u1 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=axis.com;
x-ms-publictraffictype: Email
x-ms-traffictypediagnostic: PAWPR02MB10280:EE_|AM9PR02MB7025:EE_
x-ms-office365-filtering-correlation-id: 61b264f8-e9cc-43c1-9cdd-08dbb2985982
x-ld-processed: 78703d3c-b907-432f-b066-88f7af9ca3af,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: tyQAgTc/SJWWnEdiM6MxNgWcSn26rIicqz1SSz9xYWyimt94Pt3US0vk8+nfCLFupmXeOL1C5E3cp4lPVg4uipeguvZs8WxEb31aiH85K3rHDe/5VppS/8CFnlurEKzYkkgIV1VQP/9hl0ZjYg+xfJfccnC5OkAj2Q4Cw+urxiJ7NDtTdrumRqkTKjOWx5wEGS4HCRrg/BoBIXwWxPfAwCEAkz1GYzjGj9hXGV3PT0oLaeRNY1LPfHpzoEJkxM/q9l/9Wm7UvvXOIwlJRJMoT5Rs3/CwYQkuveCDv2OQ0kFK6aoHruhBerjbOregT6dNde74iAWzdKeaK7CRgqF2W+V0uy6UKRwCdSXAwcmk+Vv2RfIVr2mkY3qcc/LlLNnlZ6bKY0miC+NsXLz6RwnU41yf5Ms3e5Bnsr9Oet2a1x5XPP1uUrq6kaSeXFYU/gEZ4ZlLh3bwBthNy4TGTZ8V/NDbZBWUEv1PEasxU3fTuuoBL+eLDsAuRkjBTZh2uSKIkke07A7phpYRW1sPIqeq9C9b1f9CM7ople/OgiMjy7FpGVFiTcLLfLOUPTPy6O9fctIA3mtL+67glWWBKy/qJzeu3sc7bwhY9qKL5rUsH6VScHzXQgzxjMHNiFkoeihu
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PAWPR02MB10280.eurprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230031)(366004)(346002)(396003)(136003)(376002)(39850400004)(451199024)(1800799009)(186009)(6512007)(36756003)(2906002)(7416002)(5660300002)(316002)(4326008)(8936002)(54906003)(8676002)(41300700001)(64756008)(66946007)(66446008)(76116006)(66476007)(66556008)(6506007)(478600001)(71200400001)(2616005)(38070700005)(122000001)(86362001)(38100700002)(110136005)(91956017)(26005)(6486002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?d3JqMjZsZkVhZ1F2cGE1OTRzVkk2cXQ1Q2VEV0pwd2p2TGdZU0lFRzBXVnhp?=
 =?utf-8?B?RTZ1SjV5UkdLd2tSbUw0akZ1RWFXNlMwd21La2Z3cktZc3R6SStmZFUxekNh?=
 =?utf-8?B?YnpPbi9PTTF6VGNPN0VmeGg0K0diQTB3T2dpK3VJZEFEZFh5dUNaRzlzamdD?=
 =?utf-8?B?ZVJHc2tWd2RSWUhhOEQrVGlkdTRNTnE5NkpYTmROdThDVElxRUdXNnN1eEt0?=
 =?utf-8?B?UkhLbFV5d2VMclB5bHNaM25xWU0zTDJMajE4WFBMQXNVbEZkV3V4R1g4eFo5?=
 =?utf-8?B?dVBaeGN5WnpGbXd1QzJnVWNvMjJ4Q2MwMFlUTkhpVE9kaG4yeXMyUGdyY2tm?=
 =?utf-8?B?Nmt2dlluT2YrcE9jS2xrMHZ3RFB4dHY2VkVONXBxZFJtTXl0WWZIOGFGNTlW?=
 =?utf-8?B?UC9HdndXeTBINjdHajQyT0RaWFRHbU1JeXFTL01hc1FtVCtGZXRkamVlc1NM?=
 =?utf-8?B?Ukt6N2ZhdVZTdnpFUjVYRjNYa0dScVhkUjVmTGZiZEdTdnBFbDJxUGZnU3R0?=
 =?utf-8?B?OExreENhY2x3M25acWE2WWZxMFZ6U29CZWx2eStLbWFwMHI0SnpUTlBnSWcr?=
 =?utf-8?B?ZmtjY2h6OWViMm1yK1JZNldCdjZneEhnTmdtZEhYaGZZa3FwV09wenkvVGdX?=
 =?utf-8?B?YU85QW96WGlvdUV4UEErcHZvTXN1eWRSeGgwRjFvUGVSdUkyWitLTmFKd1hL?=
 =?utf-8?B?czV6Nm1KU2IvUUlITm5KQWROVDhtclFrcXlvUFBtQkVObEt5eHhSV08rMG96?=
 =?utf-8?B?WjltY0FCOHRGSmVJai8va1NoOFgyelhiV0lrTnVnL1Btb1NlSkUrU3llTHBx?=
 =?utf-8?B?bDNENUpKK25NT1lma2hBL0Q3MGVoOHBEU3FuMnVQL3haU1MzemJ2V3h4STZR?=
 =?utf-8?B?a3B4MFJaOVNwMzExaEJhU1lqc0pOWlhoZTNzUnpOWmdJbEtrNW1rUHZVTW9s?=
 =?utf-8?B?ZEhqSzBCaGZYNjA4K1AxRFFYZUxsL1NGTFQ2c3lsOFNkdHFsQlBxcVZCZTNS?=
 =?utf-8?B?T2hJNDRUbEVJaE84RU1HR2JCdldZWnEzT1FtRUZPM0RrZCtrYXdEMlhhZ3U2?=
 =?utf-8?B?bjZFVGVpMk9jNEpRM0tXa2U5MDdnTVRIYTltbjMzd21aWG9SSXc4QWQ0aG1n?=
 =?utf-8?B?cXVJbUw2bDBSenY2czNReFo5WTBGZVg3ZzA3ZVR2QzNuZjZzYW1qSWZESTRP?=
 =?utf-8?B?R2ZGcHRIem9ObHA1empnYTRDMHdqNHFMRjhRSy91OUxaVU9OK2JTN2ZRZXEy?=
 =?utf-8?B?a1gyUU1WeTk2WERYY01pVzRXeGM5YzhkamY4QnZUOVY0a0lQU3ZROVB6eTlO?=
 =?utf-8?B?aXRpREJlbzJHbXdaWXR2endjY25YLzc0dEQyUDF0YlBlSXlBbHJGM2FOSmg5?=
 =?utf-8?B?UEhOMGlnMW0xQkwzd3dqYTdrVVRRSzM1V0hDdk0wTXJINm4rOWNrTmhPM1Bq?=
 =?utf-8?B?em1QMG1lVitycS9YcHppVk9UQVg4bVZPRk5xZFdIZFMrZ1U2TTZQZzlzamVp?=
 =?utf-8?B?eDNVbGFUMUNjckIrU3d3VUxidVg1VmcvV1U1aGFCNzFXTnVnR2lCRFpEZkdC?=
 =?utf-8?B?dGluUVplOHJRNk1FS1lUSGJManBXVEs5eG50cWRRcE9VeTRORTJ5ZlZaU0pF?=
 =?utf-8?B?Y3hITDBDKzVXdTgyNmJPeWZONFpLQ21xZ3JhNmJUbW1keS9WSFVqZ3lUNW0r?=
 =?utf-8?B?WUpVTXBWUHplR2E4VC8vb0loYjlVYWpqZlFsd1hjek9JVzd6dWNhbHpZVU91?=
 =?utf-8?B?SzFxM2FoUFhvQUt2SW12NlNzcEtqTmNwcklvK1pOSk5aeUJFN29ac3ZyZHdo?=
 =?utf-8?B?dStGaFRZUTZ1c2p4WFRpdGp0T1NSbkZxcjNOUnhVZ0R5NWlhSDlLNCtCalRi?=
 =?utf-8?B?Y3lMZ2JrcVptTml4NG9tVWFTSGdERitDTytCSmM5dWQ3L1RRa2hKWnpzNGdV?=
 =?utf-8?B?RUpPU1RPMzFZUml6MWsxektCcWhITURqOEQyZHJQUjVZbytxQUN6aklBRmNW?=
 =?utf-8?B?TEk2eFpCYzBpYW5lenJlb2lpcXY5TkFpM2ptWlZZQjZGV1RRbkF5V3lRMWJV?=
 =?utf-8?B?bjhhN1lqMTBkTkFRZklOc1hvcSt3Z0FsSmlyV0Nnb01LcVJDUnYxZ2NtNWl0?=
 =?utf-8?Q?IaYY0EkAbJsqQAXQk9ioyi+oa?=
Content-ID: <6BCC8F6AFFCD484EBD9947AC06F8E329@eurprd02.prod.outlook.com>
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PAWPR02MB10280.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 61b264f8-e9cc-43c1-9cdd-08dbb2985982
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Sep 2023 07:26:00.9245
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 78703d3c-b907-432f-b066-88f7af9ca3af
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: nk5dOdAUwE3/0v3eSZfZkE4BOvIGu949nbgvPrlgP3LAcKFNLQ1Re3CyskuBXV1H
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM9PR02MB7025
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230911_002610_062159_411ACF2B 
X-CRM114-Status: GOOD (  16.30  )
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

T24gU2F0LCAyMDIzLTA2LTEwIGF0IDE2OjM0ICswODAwLCBEYXZpZCBHb3cgd3JvdGU6DQo+IE9u
IEZyaSwgOSBKdW4gMjAyMyBhdCAxOToxOSwgVmluY2VudCBXaGl0Y2h1cmNoDQo+IDx2aW5jZW50
LndoaXRjaHVyY2hAYXhpcy5jb20+IHdyb3RlOg0KPiA+IA0KPiA+IEJ1aWxkaW5nIFVNTCB3aXRo
IEtBU0FOIGZhaWxzIHNpbmNlIGNvbW1pdCA2OWQ0YzBkMzIxODYgKCJlbnRyeSwga2FzYW4sDQo+
ID4geDg2OiBEaXNhbGxvdyBvdmVycmlkaW5nIG1lbSooKSBmdW5jdGlvbnMiKSB3aXRoIHRoZSBm
b2xsb3dpbmcgZXJyb3JzOg0KPiA+IA0KPiA+IMKgJCB0b29scy90ZXN0aW5nL2t1bml0L2t1bml0
LnB5IHJ1biAtLWtjb25maWdfYWRkIENPTkZJR19LQVNBTj15DQo+ID4gwqAuLi4NCj4gPiDCoGxk
OiBtbS9rYXNhbi9zaGFkb3cubzogaW4gZnVuY3Rpb24gYG1lbXNldCc6DQo+ID4gwqBzaGFkb3cu
YzooLnRleHQrMHg0MCk6IG11bHRpcGxlIGRlZmluaXRpb24gb2YgYG1lbXNldCc7DQo+ID4gwqBh
cmNoL3g4Ni9saWIvbWVtc2V0XzY0Lm86KC5ub2luc3RyLnRleHQrMHgwKTogZmlyc3QgZGVmaW5l
ZCBoZXJlDQo+ID4gwqBsZDogbW0va2FzYW4vc2hhZG93Lm86IGluIGZ1bmN0aW9uIGBtZW1tb3Zl
JzoNCj4gPiDCoHNoYWRvdy5jOigudGV4dCsweDkwKTogbXVsdGlwbGUgZGVmaW5pdGlvbiBvZiBg
bWVtbW92ZSc7DQo+ID4gwqBhcmNoL3g4Ni9saWIvbWVtbW92ZV82NC5vOigubm9pbnN0ci50ZXh0
KzB4MCk6IGZpcnN0IGRlZmluZWQgaGVyZQ0KPiA+IMKgbGQ6IG1tL2thc2FuL3NoYWRvdy5vOiBp
biBmdW5jdGlvbiBgbWVtY3B5JzoNCj4gPiDCoHNoYWRvdy5jOigudGV4dCsweDExMCk6IG11bHRp
cGxlIGRlZmluaXRpb24gb2YgYG1lbWNweSc7DQo+ID4gwqBhcmNoL3g4Ni9saWIvbWVtY3B5XzY0
Lm86KC5ub2luc3RyLnRleHQrMHgwKTogZmlyc3QgZGVmaW5lZCBoZXJlDQo+ID4gDQo+ID4gSWYg
SSdtIHJlYWRpbmcgdGhhdCBjb21taXQgcmlnaHQsIHRoZSAhR0VORVJJQ19FTlRSWSBjYXNlIGlz
IHN0aWxsDQo+ID4gc3VwcG9zZWQgdG8gYmUgYWxsb3dlZCB0byBvdmVycmlkZSB0aGUgbWVtKigp
IGZ1bmN0aW9ucywgc28gdXNlIHdlYWsNCj4gPiBhbGlhc2VzIGluIHRoYXQgY2FzZS4NCj4gPiAN
Cj4gPiBGaXhlczogNjlkNGMwZDMyMTg2ICgiZW50cnksIGthc2FuLCB4ODY6IERpc2FsbG93IG92
ZXJyaWRpbmcgbWVtKigpIGZ1bmN0aW9ucyIpDQo+ID4gU2lnbmVkLW9mZi1ieTogVmluY2VudCBX
aGl0Y2h1cmNoIDx2aW5jZW50LndoaXRjaHVyY2hAYXhpcy5jb20+DQo+ID4gLS0tDQo+IA0KPiBU
aGFua3M6IEkgc3R1bWJsZWQgaW50byB0aGlzIHRoZSBvdGhlciBkYXkgYW5kIHJhbiBvdXQgb2Yg
dGltZSB0byBkZWJ1ZyBpdC4NCj4gDQo+IEkndmUgdGVzdGVkIHRoYXQgaXQgd29ya3MgaGVyZS4N
Cj4gDQo+IFRlc3RlZC1ieTogRGF2aWQgR293IDxkYXZpZGdvd0Bnb29nbGUuY29tPg0KDQpUaGFu
a3MuICBQZXJoYXBzIHNvbWVvbmUgY291bGQgcGljayB0aGlzIHVwPyAgSXQncyBiZWVuIGEgZmV3
IG1vbnRocywNCmFuZCB0aGUgYnVpbGQgcHJvYmxlbSBpcyBzdGlsbCBwcmVzZW50IG9uIHY2LjYt
cmMxLg0KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGlu
dXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xp
c3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
