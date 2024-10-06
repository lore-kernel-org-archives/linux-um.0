Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27C4DCFB424
	for <linux-um@archiver.kernel.org>; Sun,  6 Oct 2024 18:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:In-Reply-To:References:Message-ID:Date:Subject:CC:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aZwIzvlOJcv/ji8nAJdTx51gC2Ws1xeuOlP3sOSFvS0=; b=2zxy029Lsm8avUjaovH22a6lKn
	hRqX4XT/t+Adi06E4abA1LYFSmqjXe8Rbd/0rB9DIrIM+XrUHH82Z7LJXMacA+kGDvjGS/rEMDTxE
	G9lYH7ZvJF106IKX8OI56JAFeYVeRQkwuNEgJ+h+qoB4m+7q/sxZnX1arT7m9LhIRMBfYpHX0UIj8
	nbAPPqBbBkNIP0LQVj/hQH+RRAM3y4TRQndxnO/xBf5pVs4urOT3L35fIPbGNdUpeCUz7crfueG/g
	w9PO7s9wfOMJNP4lLP9J01aKTMkszhh4tkLwP5eRAYGdcN1rKXumPMvzupG7i6P7XdPYNMYpW2JdV
	vI2y4FXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sxWM9-00000000RaG-3BLZ;
	Sun, 06 Oct 2024 18:51:49 +0000
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.85.151])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sxWM6-00000000RY4-2mZT
	for linux-um@lists.infradead.org;
	Sun, 06 Oct 2024 18:51:48 +0000
Received: from AcuMS.aculab.com (156.67.243.121 [156.67.243.121]) by
 relay.mimecast.com with ESMTP with both STARTTLS and AUTH (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 uk-mta-136-9bgpC3x0OgWrMeD0Qb2vqQ-1; Sun, 06 Oct 2024 19:51:42 +0100
X-MC-Unique: 9bgpC3x0OgWrMeD0Qb2vqQ-1
Received: from AcuMS.Aculab.com (10.202.163.4) by AcuMS.aculab.com
 (10.202.163.4) with Microsoft SMTP Server (TLS) id 15.0.1497.48; Sun, 6 Oct
 2024 19:50:48 +0100
Received: from AcuMS.Aculab.com ([::1]) by AcuMS.aculab.com ([::1]) with mapi
 id 15.00.1497.048; Sun, 6 Oct 2024 19:50:48 +0100
From: David Laight <David.Laight@ACULAB.COM>
To: 'Richard Henderson' <richard.henderson@linaro.org>, Julian Vetter
	<jvetter@kalrayinc.com>, Arnd Bergmann <arnd@arndb.de>, Russell King
	<linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, "Will
 Deacon" <will@kernel.org>, Guo Ren <guoren@kernel.org>, Huacai Chen
	<chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, Andrew Morton
	<akpm@linux-foundation.org>, Geert Uytterhoeven <geert@linux-m68k.org>, "Ivan
 Kokshaysky" <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>,
	"James E . J . Bottomley" <James.Bottomley@hansenpartnership.com>, "Helge
 Deller" <deller@gmx.de>, Yoshinori Sato <ysato@users.sourceforge.jp>, "Rich
 Felker" <dalias@libc.org>, John Paul Adrian Glaubitz
	<glaubitz@physik.fu-berlin.de>, Richard Weinberger <richard@nod.at>, "Anton
 Ivanov" <anton.ivanov@cambridgegreys.com>, Johannes Berg
	<johannes@sipsolutions.net>
CC: "linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>, "linux-csky@vger.kernel.org"
	<linux-csky@vger.kernel.org>, "loongarch@lists.linux.dev"
	<loongarch@lists.linux.dev>, "linux-m68k@lists.linux-m68k.org"
	<linux-m68k@lists.linux-m68k.org>, "linux-alpha@vger.kernel.org"
	<linux-alpha@vger.kernel.org>, "linux-parisc@vger.kernel.org"
	<linux-parisc@vger.kernel.org>, "linux-sh@vger.kernel.org"
	<linux-sh@vger.kernel.org>, "linux-um@lists.infradead.org"
	<linux-um@lists.infradead.org>, "linux-arch@vger.kernel.org"
	<linux-arch@vger.kernel.org>, Yann Sionneau <ysionneau@kalrayinc.com>
Subject: RE: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
Thread-Topic: [PATCH v7 01/10] Consolidate IO memcpy/memset into iomap_copy.c
Thread-Index: AQHbFbPJWS6K2t1cH0OJGabOTiBjIbJ6FaUQ
Date: Sun, 6 Oct 2024 18:50:48 +0000
Message-ID: <5bbdbf01d4584a14ae1e16281eb95837@AcuMS.aculab.com>
References: <20240930132321.2785718-1-jvetter@kalrayinc.com>
 <20240930132321.2785718-2-jvetter@kalrayinc.com>
 <a4f85184-73d4-44e4-bddd-0c1775ed9f50@linaro.org>
In-Reply-To: <a4f85184-73d4-44e4-bddd-0c1775ed9f50@linaro.org>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: base64
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241006_115147_004476_DEF58E06 
X-CRM114-Status: UNSURE (   8.03  )
X-CRM114-Notice: Please train this message.
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

RnJvbTogUmljaGFyZCBIZW5kZXJzb24NCj4gU2VudDogMDMgT2N0b2JlciAyMDI0IDE3OjQ3DQo+
IA0KPiBPbiA5LzMwLzI0IDA2OjIzLCBKdWxpYW4gVmV0dGVyIHdyb3RlOg0KPiA+ICt2b2lkIG1l
bXNldF9pbyh2b2xhdGlsZSB2b2lkIF9faW9tZW0gKmRzdCwgaW50IGMsIHNpemVfdCBjb3VudCkN
Cj4gPiArew0KPiA+ICsJdWludHB0cl90IHFjID0gKHU4KWM7DQo+IA0KPiBNaXNzZWQgb25lIGNo
YW5nZSB0byAnbG9uZycNCj4gDQo+ID4gKw0KPiA+ICsJcWMgfD0gcWMgPDwgODsNCj4gPiArCXFj
IHw9IHFjIDw8IDE2Ow0KPiA+ICsNCj4gPiArI2lmZGVmIENPTkZJR182NEJJVA0KPiA+ICsJcWMg
fD0gcWMgPDwgMzI7DQo+ID4gKyNlbmRpZg0KPiANCj4gQ291bGQgYmUgJ3FjICo9IC0xdWwgLyAw
eGZmOycNCg0KCXFjICo9IH4wdWwgLyAweGZmOw0KDQp3b3VsZCBiZSBzbGlnaHRseSBiZXR0ZXIu
DQoNCglEYXZpZA0KDQo+IA0KPiANCj4gcn4NCg0KLQ0KUmVnaXN0ZXJlZCBBZGRyZXNzIExha2Vz
aWRlLCBCcmFtbGV5IFJvYWQsIE1vdW50IEZhcm0sIE1pbHRvbiBLZXluZXMsIE1LMSAxUFQsIFVL
DQpSZWdpc3RyYXRpb24gTm86IDEzOTczODYgKFdhbGVzKQ0K


