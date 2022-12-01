Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD85AC43217
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 09:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=SUMPX+JwUtqoA9lA/o+MJm18nMdaiMLeuBFwjDnZK98=; b=xpPLFYouve5ieH
	pMaEKcouTV5Dl1nHpWSiF59cP+7xFbuaSMO8JnNYp7HKxiTZjP9OGXuWnZ9zAnEaYa1Qotwv1tkBx
	cjbhlDmQWC8br03FZzvV4uuSVRdDWHpo1Bl6J/Xt8+XGc3Z6Rr+QWYiBFm3qyo146ZkeGnqJxFWdd
	uL5vSd3SomQNVnFrSSj14TBMbbHYgTANfIANvR7wb0tvOaWFBpl00aVWDPJ3rkm2ZmJksQ+nPR0Xa
	C2Q3AKwJ9wqx0AudK6FjovSTNiRnos16pe9xaEWwh5QDpvVefgFBaWFvxScUPnUtOBWttrzqTXwZh
	m8jioup16Nb2RJK8kPyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0fnZ-006Jor-By; Thu, 01 Dec 2022 09:24:05 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0fmE-006J4u-So
	for linux-um@lists.infradead.org; Thu, 01 Dec 2022 09:22:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 6902CB81E7D;
	Thu,  1 Dec 2022 09:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FC4C433D7;
	Thu,  1 Dec 2022 09:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669886559;
	bh=EbQEoSBkP4rq4nn7K1JqrZiC11qeUR4OKMOBmxo+YsU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=hBnQ+JpnHiKrLR4z5/n48+eyUysKLHUFm7o0Z+Axi7KExPgLunVQtxraqEUfqJMXi
	 iv0ygBuculcBlEAvw2RZLNVX0kDcwYcoBtEArun/pdfGOxiXwpmvz2m2vuWOr0XLSo
	 /OXiCAxjIIGfsTXkoc52W8jnJ8vftiPGlIb8FLKrel9K2C0qp4/HVYk/1kNgiWSg7w
	 bXl+fzrKnVbYl8rKHoZ9BHgwax6TKREJzTQ9kWVMRgnKMkXBHrVrwzODKL3QoRUBWk
	 yDfuHKtBidWAxCRPfUISLLNQOcSDpVVj4w4fRSs/ivWW6RWmWpRRNCkyQQEoxuk11M
	 J1OeSaqpS/JVw==
Date: Thu, 1 Dec 2022 11:22:35 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 2/2] IB/rdmavt: don't use rdmavt for UML
Message-ID: <Y4hyW6mVer6kk1VX@unreal>
References: <20221130200958.25305-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221130200958.25305-1-rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_012243_373024_7AE9479D 
X-CRM114-Status: GOOD (  19.42  )
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

T24gV2VkLCBOb3YgMzAsIDIwMjIgYXQgMTI6MDk6NThQTSAtMDgwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOgo+IFdoZW4gYnVpbGRpbmcgcmRtYXZ0IGZvciBBUkNIPXVtLCBxcC5jIGhhcyBhIGJ1aWxk
IGVycm9yIG9uIGEgcmVmZXJlbmNlCj4gdG8gdGhlIHg4Ni1zcGVjaWZpYyBjcHVpbmZvIGZpZWxk
ICd4ODZfY2FjaGVfc2l6ZScuCj4gCj4gRml4IHRoZSBidWlsZCBlcnJvcnMgYnkgbWFraW5nIHRo
aXMgZHJpdmVyIGRlcGVuZCBvbiAhVU1MLgo+IAo+IFByZXZlbnRzIHRoZXNlIGJ1aWxkIGVycm9y
czoKPiAKPiAuLi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L3FwLmM6IEluIGZ1bmN0aW9u
IOKAmHJ2dF93c3NfbGxjX3NpemXigJk6Cj4gLi4vZHJpdmVycy9pbmZpbmliYW5kL3N3L3JkbWF2
dC9xcC5jOjg4OjI5OiBlcnJvcjog4oCYc3RydWN0IGNwdWluZm9fdW3igJkgaGFzIG5vIG1lbWJl
ciBuYW1lZCDigJh4ODZfY2FjaGVfc2l6ZeKAmQo+ICAgIDg4IHwgICAgICAgICByZXR1cm4gYm9v
dF9jcHVfZGF0YS54ODZfY2FjaGVfc2l6ZTsKPiAuLi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRt
YXZ0L3FwLmM6IEluIGZ1bmN0aW9uIOKAmGNhY2hlbGVzc19tZW1jcHnigJk6Cj4gLi4vZHJpdmVy
cy9pbmZpbmliYW5kL3N3L3JkbWF2dC9xcC5jOjEwMDo5OiBlcnJvcjogaW1wbGljaXQgZGVjbGFy
YXRpb24gb2YgZnVuY3Rpb24g4oCYX19jb3B5X3VzZXJfbm9jYWNoZeKAmTsgZGlkIHlvdSBtZWFu
IOKAmGNvcHlfdXNlcl9wYWdl4oCZPyBbLVdlcnJvcj1pbXBsaWNpdC1mdW5jdGlvbi1kZWNsYXJh
dGlvbl0KPiAgIDEwMCB8ICAgICAgICAgX19jb3B5X3VzZXJfbm9jYWNoZShkc3QsICh2b2lkIF9f
dXNlciAqKXNyYywgbiwgMCk7Cj4gLi4vZHJpdmVycy9pbmZpbmliYW5kL3N3L3JkbWF2dC9xcC5j
OiBJbiBmdW5jdGlvbiDigJhydnRfd3NzX2xsY19zaXpl4oCZOgo+IC4uL2RyaXZlcnMvaW5maW5p
YmFuZC9zdy9yZG1hdnQvcXAuYzo4OToxOiBlcnJvcjogY29udHJvbCByZWFjaGVzIGVuZCBvZiBu
b24tdm9pZCBmdW5jdGlvbiBbLVdlcnJvcj1yZXR1cm4tdHlwZV0KPiAgICA4OSB8IH0KPiAKPiBG
aXhlczogNjhmNWQzZjNiNjU0ICgidW06IGFkZCBQQ0kgb3ZlciB2aXJ0aW8gZW11bGF0aW9uIGRy
aXZlciIpCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5v
cmc+Cj4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRpYS5jb20+Cj4gQ2M6IExlb24gUm9t
YW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPgo+IENjOiBEZW5uaXMgRGFsZXNzYW5kcm8gPGRlbm5p
cy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbT4KPiBDYzogbGludXgtcmRtYUB2Z2Vy
Lmtlcm5lbC5vcmcKPiBDYzogSmVmZiBEaWtlIDxqZGlrZUBhZGR0b2l0LmNvbT4KPiBDYzogUmlj
aGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KPiBDYzogQW50b24gSXZhbm92IDxhbnRv
bi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+IENjOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5l
c0BzaXBzb2x1dGlvbnMubmV0Pgo+IENjOiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCj4g
LS0tCj4gdjI6IHJlYmFzZSAmIHJlc2VuZAo+IAo+ICBkcml2ZXJzL2luZmluaWJhbmQvc3cvcmRt
YXZ0L0tjb25maWcgfCAgICAyICstCj4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwg
MSBkZWxldGlvbigtKQo+IAo+IGRpZmYgLS0gYS9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0
L0tjb25maWcgYi9kcml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L0tjb25maWcKPiAtLS0gYS9k
cml2ZXJzL2luZmluaWJhbmQvc3cvcmRtYXZ0L0tjb25maWcKPiArKysgYi9kcml2ZXJzL2luZmlu
aWJhbmQvc3cvcmRtYXZ0L0tjb25maWcKPiBAQCAtMiw3ICsyLDcgQEAKPiAgY29uZmlnIElORklO
SUJBTkRfUkRNQVZUCj4gIAl0cmlzdGF0ZSAiUkRNQSB2ZXJicyB0cmFuc3BvcnQgbGlicmFyeSIK
PiAgCWRlcGVuZHMgb24gSU5GSU5JQkFORF9WSVJUX0RNQQo+IC0JZGVwZW5kcyBvbiBYODZfNjQK
PiArCWRlcGVuZHMgb24gWDg2XzY0ICYmICFVTUwKClNhbWUgY29tbWVudCBhcyBmb3IgcGF0Y2gg
IzEuCgo+ICAJZGVwZW5kcyBvbiBQQ0kKPiAgCWhlbHAKPiAgCVRoaXMgaXMgYSBjb21tb24gc29m
dHdhcmUgdmVyYnMgcHJvdmlkZXIgZm9yIFJETUEgbmV0d29ya3MuCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGlu
dXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWls
bWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
