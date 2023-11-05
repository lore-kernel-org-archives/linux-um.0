Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9E195C4332F
	for <linux-um@archiver.kernel.org>; Sun,  5 Nov 2023 15:47:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xm/y6kPDbgyPhQa89GCO2j6ToW90ryhFif+EinmoHUQ=; b=TgPmqHeKvPTDs3
	KR4c8witBSkhhC9n2/DsmjRy2einzKTkJhe4kkmHliTGLIccFn7bdGBMEhbvhvlUOt1XRY4YDvpWi
	7f1W4Hc1qVAb2H/UUhae+atSQMjwNxjTGPVij7kHsGznUwNYrofxdFCeB3zpx7Jxm90C1klHbxD0N
	xJMD2vNTGiItjMSNtVQpQPdvSv99KSB4v4tGGaZtmrrtohjFSCQaAkqayQTa3b1jRojfMyYTim1pK
	5T7aHDs4gm+DfbIjfplMCNbhpa2bWg9jsQB6Gt4ogRtMZXD93jpyTrG9XXhrDbPadxP9bGgaTP96q
	2RKvvIMk5LVup8f/drXg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qzfLU-00F7XV-17;
	Sun, 05 Nov 2023 15:47:28 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qzfLR-00F7WB-1O
	for linux-um@lists.infradead.org;
	Sun, 05 Nov 2023 15:47:27 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-311-k3HE-6c7MEyLMT7ytN7A-A-1; Sun, 05 Nov 2023 15:47:20 +0000
X-MC-Unique: k3HE-6c7MEyLMT7ytN7A-A-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 5 Nov
 2023 15:47:19 +0000
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 5 Nov 2023 15:47:19 +0000
From: David Laight <David.Laight@ACULAB.COM>
To: 'Nadav Amit' <nadav.amit@gmail.com>, Anton Ivanov
	<anton.ivanov@kot-begemot.co.uk>
CC: Richard Weinberger <richard@nod.at>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, Thomas Gleixner <tglx@linutronix.de>, "Linux
 Kernel Mailing List" <linux-kernel@vger.kernel.org>, Peter Zijlstra
	<peterz@infradead.org>
Subject: RE: Missing clobber on alternative use on Linux UM 32-bit
Thread-Topic: Missing clobber on alternative use on Linux UM 32-bit
Thread-Index: AQHaDwMKcQHyK5uteEWVVs9ePUP5ubBr4G4Q
Date: Sun, 5 Nov 2023 15:47:19 +0000
Message-ID: <41cac2e7ad9341259f356e1b3cf5f418@AcuMS.aculab.com>
References: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
 <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
 <1616BF59-5C18-46C7-86AB-92604B683652@gmail.com>
In-Reply-To: <1616BF59-5C18-46C7-86AB-92604B683652@gmail.com>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231105_074725_735627_25B0444F 
X-CRM114-Status: GOOD (  17.15  )
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

RnJvbTogTmFkYXYgQW1pdA0KPiBTZW50OiAwNCBOb3ZlbWJlciAyMDIzIDA5OjQxDQo+IA0KPiA+
IE9uIE5vdiA0LCAyMDIzLCBhdCAxMTozNCBBTSwgQW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZA
a290LWJlZ2Vtb3QuY28udWs+IHdyb3RlOg0KPiA+DQo+ID4gT24gMDQvMTEvMjAyMyAwOToyNSwg
TmFkYXYgQW1pdCB3cm90ZToNCj4gPj4NCj4gPj4gSSB3YXMgcmVhZGluZyAoYWdhaW4pIHRoZSB4
ODYgQyBtYWNybyBvZiDigJxhbHRlcm5hdGl2ZSgp4oCdIGFuZCBJIHdhcyBhIGJpdA0KPiA+PiBz
dXJwcmlzZWQgaXQgZG9lcyBjbG9iYmVyIHRoZSBmbGFncyAo4oCcY2PigJ0pIGFzIGEgcHJlY2F1
dGlvbi4NCj4gPj4NCj4gPj4gICNkZWZpbmUgYWx0ZXJuYXRpdmUob2xkaW5zdHIsIG5ld2luc3Ry
LCBmdF9mbGFncykgXA0KPiA+PiAJYXNtX2lubGluZSB2b2xhdGlsZSAoQUxURVJOQVRJVkUob2xk
aW5zdHIsIG5ld2luc3RyLCBmdF9mbGFncykgOiA6IDogIm1lbW9yeSIpDQo+ID4+DQo+ID4+IEFj
dHVhbGx5IHRoZXJlIHNlZW1zIHRvIGJlIG9ubHkgb25lIGluc3RhbmNlIG9mIHByb2JsZW1hdGlj
IGNhc2VzIC0gaW4gdW0vMzItYml0Og0KPiA+Pg0KPiA+PiAgI2RlZmluZSBtYigpIGFsdGVybmF0
aXZlKCJsb2NrOyBhZGRsICQwLDAoJSVlc3ApIiwgIm1mZW5jZSIsIFg4Nl9GRUFUVVJFX1hNTTIp
DQo+ID4+ICAjZGVmaW5lIHJtYigpIGFsdGVybmF0aXZlKCJsb2NrOyBhZGRsICQwLDAoJSVlc3Ap
IiwgImxmZW5jZSIsIFg4Nl9GRUFUVVJFX1hNTTIpDQo+ID4+ICAjZGVmaW5lIHdtYigpIGFsdGVy
bmF0aXZlKCJsb2NrOyBhZGRsICQwLDAoJSVlc3ApIiwgInNmZW5jZSIsIFg4Nl9GRUFUVVJFX1hN
TSkNCj4gPj4NCj4gPj4gUHJlc3VtYWJseSwgaWYgWE1NIG9yIFhNTTIgYXJlIG5vdCBzdXBwb3J0
ZWQsIHRoZXJlIHdvdWxkIGJlIGluc3RhbmNlcyB3aGVyZSBhZGRsDQo+ID4+IHdvdWxkIGJlIGFi
bGUgdG8gY2hhbmdlIGVmbGFncyBhcml0aG1ldGljIGZsYWdzIHdpdGhvdXQgdGhlIGNvbXBpbGVy
IGJlaW5nIGF3YXJlDQo+ID4+IG9mIGl0Lg0KPiA+Pg0KPiA+PiBBcyBpdCBvbmx5IGFmZmVjdHMg
MzItYml0IExpbnV4IFVNIC0gSSBkb27igJl0IGVhc2lseSBoYXZlIGFuIGVudmlyb25tZW50IHRv
IHRlc3QNCj4gPj4gdGhlIGZpeC4gQW4gYWx0ZXJuYXRpdmUgKHdvcmQtcHVuIHVuaW50ZW5kZWQp
IGlzIHRvIGFkZCDigJxjY+KAnSBhcyBhIHByZWNhdXRpb24NCj4gPj4gdG8gdGhlIGFsdGVybmF0
aXZlIG1hY3JvLg0KPiA+Pg0KPiA+IEFwcGxpY2F0aW9uIGFsdGVybmF0aXZlcyBpbiB1bSBpcyBw
cmVzZW50bHkgYSBOT1AuIEl0IGFsd2F5cyB1c2VzIHRoZSAiYmx1bnQgYW5kIGhlYXZ5IGluc3Ry
dW1lbnQiIC0NCj4gdGhlIG1vc3QgY29uc2VydmF0aXZlIG9wdGlvbi4NCj4gPg0KPiA+IEl0IGlz
IG9uIHRoZSBUT0RPIGxpc3QuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBxdWljayByZXNwb25zZS4g
QnV0IEkgZG9u4oCZdCBzZWUgaG93IGl0IHByZXZlbnRzIHRoZSBwcm9ibGVtDQo+IChpdCBhY3R1
YWxseSBtYWtlcyBpdCB3b3JzZSAtIGFmZmVjdGluZyBYTU0vWE1NMiBDUFVzIGFzIHdlbGwpIHNp
bmNlIHlvdQ0KPiBrZWVwIHRoZSDigJxsb2NrOyBhZGRsICQwLDAoJSVlc3Ap4oCdIGluIHRoZSBy
dW5uaW5nIGNvZGUsIGFmZmVjdGluZyBlZmxhZ3MNCj4gd2l0aG91dCB0ZWxsaW5nIHRoZSBjb21w
aWxlciB0aGF0IHlvdSBkbyBzbyB0aHJvdWdoIGEg4oCcY2PigJ0gY2xvYmJlci4NCg0KZ2NjIGFs
d2F5cyBhc3N1bWVzIHRoYXQgaW5saW5lIGFzbSBjaGFuZ2VzICJjYyIgLSB0aGVyZSBpcyBubyBu
ZWVkDQp0byBhZGQgYSAnY2xvYmJlcicgZm9yIGl0Lg0KDQoJRGF2aWQNCg0KLQ0KUmVnaXN0ZXJl
ZCBBZGRyZXNzIExha2VzaWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXlu
ZXMsIE1LMSAxUFQsIFVLDQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0KX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGlu
ZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
