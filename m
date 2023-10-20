Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B7F7C001DF
	for <linux-um@archiver.kernel.org>; Fri, 20 Oct 2023 12:58:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=UWPAaw+4tKx6fNg4h0iCSdT3yk0BO5FzKwbeEkDOfeA=; b=GLnnDuSuWWEcna
	7YBLimxAUiqNu7e2/H3zA9mvMn9UV4Nuy4YkvNk5TO96CCsJk2RtA9sxYCyISaOX8RaEgt6RHIlkf
	ihTf4Lg3XfenSpQDgYcueQHE2bEMZnFRspbSfciTNSrpUfh/+lsv5ZN3EqIjqkO5ep8ynDtHDd96n
	ZJCJnbjwgU0t9JxOJen4oEWDOLmEVMiLShEo9BqpsUfhx9uM37YjgiKO/ttmldAyyruD7z2bfFIbA
	uU+X9woHWF8EyS+T0iuO55sbgrIdrhHhGO26hD7zoUaVjKxj5OgbtLFrSd0U57Ke18rsPzIkCTuHL
	BYN4GWyvi2jne2DN6fNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qtp4q-002I97-0f;
	Fri, 20 Oct 2023 12:58:08 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qtp4n-002I7w-1S
	for linux-um@lists.infradead.org;
	Fri, 20 Oct 2023 12:58:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=PlTM0J86TYodca7NfAdckhjmiEIu5xXmirhM+80DKFY=;
	t=1697806684; x=1699016284; b=NjKjnB4+dcaaTga6HX8RWUjo+b4tbNqhZdQ7aVV5TNAz2A5
	hA0ESL/o9q8xWremEazXnWEM21V7te6zoLg04Las+/LTJ7KPCyOcrip7NMiAUGjsySKyq4GMyByEI
	9kK2R5GFECdVZB5LT4gPlKtiiiIwM9SmQlHpNtQufBIsHeqMtHLDaxDo7cAn9ji3pZkXpYjPj9+8l
	0nW/HJAI96u9LKPlxmERsw29CCWrBgPIi9L8A2J/fzupW2VMEb8RBAUc6iUCSrUiPN0kXk66qtdOt
	3a+aAvw+jJ/2+XmEQb29agCTVLbUA1Wcn3xufBjKR9+0/Gfwm0TQAn1WBIwRIEdA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qtp4j-0000000EYL0-1T9B;
	Fri, 20 Oct 2023 14:58:01 +0200
Message-ID: <7be4403e56526035e334b217c370f511060802fc.camel@sipsolutions.net>
Subject: Re: [PATCH 1/4] um: irqs: process outstanding IRQs when unblocking
 signals
From: Johannes Berg <johannes@sipsolutions.net>
To: Benjamin Beichler <Benjamin.Beichler@uni-rostock.de>, 
	linux-um@lists.infradead.org
Date: Fri, 20 Oct 2023 14:58:00 +0200
In-Reply-To: <9768bf43-5a73-4eba-ae4b-532b952f9e04@uni-rostock.de>
References: <20231018123643.1255813-1-benjamin@sipsolutions.net>
	 <6082036a-c7f9-4bd5-8234-14957ed9953d@uni-rostock.de>
	 <11ab4d47dd8fdcdc2148e00618cc496866016883.camel@sipsolutions.net>
	 <549de9c0-05f8-437e-8460-5b013b0cd87b@uni-rostock.de>
	 <348de3de5cbd6df96ac51bb07d6e485b2ecc5cc8.camel@sipsolutions.net>
	 <d77b66af-249d-4dd1-b78f-730d252bcf84@uni-rostock.de>
	 <10c4e61c2e62ba12cf88ddecd84271c5788c1e6b.camel@sipsolutions.net>
	 <76ebb80dd7fca6ef2ed7108a541d3ea3c764a3d5.camel@sipsolutions.net>
	 <9768bf43-5a73-4eba-ae4b-532b952f9e04@uni-rostock.de>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231020_055805_505983_79BC1F04 
X-CRM114-Status: GOOD (  16.86  )
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

T24gRnJpLCAyMDIzLTEwLTIwIGF0IDE0OjQzICswMjAwLCBCZW5qYW1pbiBCZWljaGxlciB3cm90
ZToKPiA+ID4gWWVzIGJ1dCB5b3UgbmVlZCB0byBzY2hlZHVsZSBmb3IgdGhlIGludGVycnVwdCwg
YW5kIHlvdSBkb24ndAo+ID4gPiBuZWNlc3NhcmlseSBrbm93IHdoYXQgJ2N1cnJlbnQgdGltZScg
aXMgYXQgaW50ZXJydXB0IHRpbWUuCj4gPiA+IAo+ID4gPiBTbyBsZXQncyBzYXkgeW91IGhhdmUg
InNvbWV0aGluZyIgdGhhdCdzIHNjaGVkdWxlZCB0byBydW4gYXQgdGltZXMKPiA+ID4gwqDCoC0g
MTAwMAo+ID4gPiDCoMKgLSAyMDAwCj4gPiA+IMKgwqAtIDMwMDAKPiA+ID4gCj4gPiA+IGFuZCBm
cmVlLXVudGlsIGlzIDEwMDAwIG9yIHNvbWV0aGluZyBoaWdoLgo+ID4gPiAKPiA+IEl0IGNhbiBh
bHNvIGhhcHBlbiB3aXRob3V0IGZyZWUtdW50aWwsIHRoZW4gaXQganVzdCBkZXBlbmRzIHdoaWNo
IG9uZSBvZgo+ID4gdGhlIHR3byAtIHRoZXkncmUgcnVubmluZyBpbiBwYXJhbGxlbCBub3cgKGxp
bnV4IGRvaW5nIHRpbWUtdHJhdmVsCj4gPiBpbnRlcnJ1cHQgaGFuZGxpbmcgYW5kIGFkZGluZyB0
aGUgZXZlbnQsIHRoZSBvdGhlciB0aGluZyBjb250aW51aW5nIHRvCj4gPiBzY2hlZHVsZSBhbmQg
ZG9pbmcgdGhlIG5leHQgZW50cnkpICAtIGFza3MgdGhlIGNvbnRyb2xsZXIgZmlyc3QuCj4gCj4g
U2luY2UgdGhleSBoYXBwZW4gYXQgdGhlIHNhbWUgdGltZSwgbW9zdCBkaXNjcmV0ZSBldmVudCBz
aW11bGF0aW9ucyBtYWtlIAo+IHRoZSBhc3N1bXB0aW9uLCB0aGF0IHRoZSBhY3R1YWwgb3JkZXIg
b2YgZXhlY3V0aW9uIHNob3VsZCBub3QgYmUgcGFydCBvZiAKPiB0aGUgc2VtYW50aWNzLgo+IAoK
V2VsbCwgZmFpciwgYnV0IHRoZXkgY2FuIGJvdW5jZSBtb3JlIG1lc3NhZ2VzIGFyb3VuZCB0aGVt
LCBhbmQgdGhhdApzaG91bGQgY2hhbmdlIHRoaW5ncy4gSSBkb24ndCB0aGluayB3ZSd2ZSBidWls
dCBhIHNpbXVsYXRpb24gc3lzdGVtIGhlcmUKdGhhdCBjYW4gc3RyaWN0bHkgYXNzdW1lIHRoaXMg
aXMgdHJ1ZS4KCkluIGFueSBjYXNlLCBpdCBjYW4gZ2V0IHdvcnNlIC0gaWYgaGUgc2VuZGVyIHBy
b2Nlc3MgYWN0dWFsbHkgdXBkYXRlZAp0aGUgY29udHJvbGxlciB0byAyMDAwIGJ5IHRoZSB0aW1l
IHRoZSBsaW51eCBhY3R1YWxseSBjYWxscwp0aW1lX3RyYXZlbF9hZGRfaXJxX2V2ZW50KCksIHRo
ZSBsaW51eCBldmVudCB3aWxsIHJ1biBhdCAyMDAwIGluc3RlYWQgb2YKMTAwMC4KCkFsbCB0aGlz
IGlzIHdoeSB3ZSBoYXZlIHRoZSB2aG9zdC11c2VyIGV4dGVuc2lvbnMgZm9yIEFDSyBtZXNzYWdl
cyBldGMuCgpqb2hhbm5lcwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
