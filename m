Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E31A3CDB47E
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 10:33:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:To:From:References:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/VGfsA2ieiRm45ltJMdEnl2d2Q2RFq/ncugMLLiIbrg=; b=WjAnZWvkV0mZ3XM4kRCoxDwOcS
	HHl2kXhtuPy2n7EJEf/GcRhyQLd495O1i3gOp507byz7jY8laqrlVLLLp4f2/p0WkA47B5i9Oei77
	CCP7oP/XYd99HkYPgbG/08x7OY1rfmhMvU+V5Lu3zE02859dBBHsLvm60RtG8jofiHlB/bDyb+pkP
	E5Qy1EZD/yctr8Qj1JiESTBsToUc8b0a1XCBjFO3J7CDNhaG8qfS8shnztMOHnxncQpqSf+z1Mwc2
	C1H8wyK36uT60ve7RdKcvny59j0ZXRn60zPvFiiI4Gu84bO3S7ZMtCV+CFaigjA6FUPuceYMFEJoU
	eXIsF/Hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtmpK-001mnc-1k;
	Fri, 20 Oct 2023 10:33:58 +0000
Received: from mx1.uni-rostock.de ([139.30.22.71])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtmpH-001mml-0Z
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 10:33:57 +0000
Received: from 139.30.22.84 by mx1.uni-rostock.de (Tls12, Aes256, Sha384,
 DiffieHellmanEllipticKey384); Fri, 20 Oct 2023 10:33:43 GMT
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmze; 
 t=1697798023; bh=OGOi/yyMrQ24L1je85WHTJox7EyJiKqrYFgRD78Vkxc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=ed25519-sha256; b=
 oTg1RZ2YtclTW9RKoRpuKGfOenT8CZSfIsD0dQEDSDjOSsusml/tt8NoUerqnOOSA2nS06ck67NYXKGbAlExBg==
DKIM-Signature: v=1; c=relaxed/relaxed; d=uni-rostock.de; s=itmz; 
 t=1697798023; bh=OGOi/yyMrQ24L1je85WHTJox7EyJiKqrYFgRD78Vkxc=; h=
 Subject:Subject:From:From:Date:Date:ReplyTo:ReplyTo:Cc:Cc:Message-Id:Message-Id; 
 a=rsa-sha256; b=
 HSDi8fxP+Ec4+5p/iKXQxxUVfgtzJ/EfW7+fnLWhmDAkvz/f1DzjhqF1O31jIs2PsSsb30rYnS50RuYXlk9XW+HHpmLl61KXsNTXVkj4kpBfCZUyAA/hMyq2Xjricoic+rMLQ5MgVOGg8pjv07OvI29pJkUuS2zY10QdvRr9QvM=
Received: from [139.30.201.32] (139.30.201.32) by mail1.uni-rostock.de
 (139.30.22.84) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.39; Fri, 20 Oct
 2023 12:33:42 +0200
Message-ID: <c6c035d9-06fc-4250-ac64-0e3d07289917@uni-rostock.de>
Date: Fri, 20 Oct 2023 12:33:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
Content-Language: de-DE
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
 <7f172f42-38bf-c2be-15b4-0710f50b372e@kot-begemot.co.uk>
From: Benjamin Beichler <benjamin.beichler@uni-rostock.de>
To: <linux-um@lists.infradead.org>
In-Reply-To: <7f172f42-38bf-c2be-15b4-0710f50b372e@kot-begemot.co.uk>
X-Originating-IP: [139.30.201.32]
X-ClientProxiedBy: email3.uni-rostock.de (139.30.22.83) To
 mail1.uni-rostock.de (139.30.22.84)
X-TM-SNTS-SMTP: 1DA037A68A006C74A9B2F40A3D2383C81FAA926C51B55D348C077218741EAFF22000:8
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_033355_520122_053BC755 
X-CRM114-Status: GOOD (  13.22  )
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

QW0gMjAuMTAuMjAyMyB1bSAxMToyNiBzY2hyaWViIEFudG9uIEl2YW5vdjoKCj4+IEkgYWxzbyBu
b3RpY2VkIHRoaXMgcHJvYmxlbSwgYnV0IGFmdGVyIGEgZGlzY3Vzc2lvbiB3aXRoIEpvaGFubmVz
IEJlcmcgCj4+IGFib3V0IHRoaXMsIHdlIGNvbWUgdG8gdGhlIGNvbmNsdXNpb24sIHRoYXQgYWxs
IGRyaXZlcnMgd2l0aCAKPj4gaW50ZXJydXB0cyBuZWVkIHRvIGRlYWwgd2l0aCB0aW1lIHRyYXZl
bCBtb2RlIHZpYSB0aGVpciBvd24gdGltZSAKPj4gdHJhdmVsIGhhbmRsZXIuIFdoYXQgSSBhY3R1
YWxseSBkaWQsIHdhcyB0byB3cml0ZSBhIHRyaXZpYWwgaGFuZGxlciAKPj4gZm9yIGUuZy4sIHRo
ZSBzZXJpYWwgbGluZSwgd2hpY2ggc2ltcGx5IG9ubHkgY2FsbCAKPj4gdGltZV90cmF2ZWxfYWRk
X2lycV9ldmVudChldikuCj4+Cj4+IEknbSBub3QgZW50aXJlbHkgc3VyZSwgd2hhdCB0aGUgcmln
aHQgd2F5IHRvIGRvIGl0LCBhbHRob3VnaCB0aGUgCj4+IG91dGNvbWUgc2VlbXMgdG8gYmUgdGhl
IHNhbWUsIGFzIHdpdGggbm8gdGltZSBhZHZhbmNlIHRoZSBhY3R1YWwgCj4+IHNpbXVsYXRpb24g
dGltZSwgd2hlbiB0aGUgaW50ZXJydXB0IGlzIGhhbmRsZWQgaXMgdGhlIHNhbWUuCj4gCj4gQWRk
IGFuIGV4dHJhIHJlZ2lzdHJhdGlvbiBmbGFnIGZvciB1bV9yZWdpc3Rlcl9pcnE/Cj4gCj4gCj4g
ZW51bSB1bV9pcnFfdHlwZSB7Cj4gIMKgwqDCoMKgSVJRX1JFQUQsCj4gIMKgwqDCoMKgSVJRX1dS
SVRFLAo+ICDCoMKgwqDCoElSUV9IQVZFX1RUX0hBTkRMRVIsCj4gIMKgwqDCoMKgTlVNX0lSUV9U
WVBFUywKPiB9Owo+IAo+IE9uZXMgdGhhdCBkbyBub3QgcmVnaXN0ZXIgZ2V0IHRoZSBkZWZhdWx0
IG9uZSB3aGljaCBhZHZhbmNlcyB0aGUgdGltZS4gCj4gT25lcyB0aGF0IGRvIC0gaGF2ZSBpdCBs
ZWZ0IHRvIHRoZW0gYW5kIGRvIHdpdGggdGltZSB3aGF0ZXZlciB0aGV5IG5lZWQuCj4gClRoZXJl
IGlzIGFscmVhZHkgbWVjaGFuaWNzIGZvciBpdCwgYXMgd2UgaGF2ZSB1bV9yZXF1ZXN0X2lycV90
dCBhbmQgCnVtX3JlcXVlc3RfaXJxLiBJIGRvbid0IHRoaW5rIGFuIGFkZGl0aW9uYWwgdHlwZSBl
bmhhbmNlIHRoZSBzZW1hbnRpY3MuCgoKPj4KPj4gSSBhY3R1YWxseSBhbHNvIGhhdmUgc29tZSBv
dGhlciBzaWduaWZpY2FudCBidWcgZml4ZXMgb24gdGltZSB0cmF2ZWwgCj4+IGluIG15IHRyZWUs
IGJ1dCBJIHdhcyB0b28gbGF6eSB0byBzZW5kIHRoZW0gaGVyZSwgYXJlIHlvdSBpbnRlcmVzdGVk
IAo+PiBpbiB0YWtpbmcgYSBsb29rIGF0IHRoZW0/Cj4+CgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9s
aXN0aW5mby9saW51eC11bQo=
