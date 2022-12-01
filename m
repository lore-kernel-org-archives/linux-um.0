Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B525FC43217
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 09:23:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=F5wKxfzUDBFtXshfJA9DlCPdOSckG60yxh5NcUC8ILY=; b=LwPUtgEby+2iJd
	W1DVbHHVHfaIq02TLes5e3rPL3mnEoewecIbEU+k2ODfmAfeFsyQVO0jtz0vpZdGQHH96BDyU0BFw
	5difiOs/dK3+NfT23gX1jdN/Ts9UsITclufU01AXBuFkqttuCWFlESZeShJXatsw4fk+8AOYTmWKi
	u6cD4d2A7egH6313kHEiob/UhXm/JwGXW1PXD+GPHJDdO7zgxKlCqceT6q2rtOMvQ+vLp3zWjR5kw
	ouKPKqi1sAnSFpVvO75C0QgQGWq3FgKXXQFYn6CUlOYUCiXlZ5+anQtO2Q00cglfjhyAAhprIN7TT
	0HHdN7XfUwvSjBIXLTGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0fnO-006JcZ-22; Thu, 01 Dec 2022 09:23:54 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0flk-006Img-CJ
	for linux-um@lists.infradead.org; Thu, 01 Dec 2022 09:22:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 2D411B81E79;
	Thu,  1 Dec 2022 09:22:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39C89C433D7;
	Thu,  1 Dec 2022 09:22:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1669886528;
	bh=/YadyfgemSRHO9+7Uo4Gf+Xn86JmQFwcdEvy7RUitZo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Drfuwxdv5m4E7Px5rg9iKHJEemwE2KPax8QGb7FkJEigL47BELovgknedwsxGOvpj
	 mKPyDkMDu8pNnFDMMBfmKMEXKld6AkE7P/AghkLLd2tdaApusq7uZlKLnBfMKzY2UD
	 tezcYIkLyIMZzXnmu/bamy8bU5nqHxFlWjtBKlHYtzDwHVtAOJyfEFbBPrxlrdIrpj
	 f4siW+XAdhSVj79lA99O2vH1/fbvtI97oWLp/cUvAuTNpFf3sUW65S7clxbjyB8XBc
	 V27IoFna46w+cCRJmUOuMvdb3KZMmqfaZePQlduzAsnOeUY7RztR2yDg/JGunMKklT
	 SxDIt0qyEv9Qw==
Date: Thu, 1 Dec 2022 11:22:04 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@nvidia.com>,
	Dennis Dalessandro <dennis.dalessandro@cornelisnetworks.com>,
	linux-rdma@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-um@lists.infradead.org
Subject: Re: [PATCH 1/2 v2] IB/qib: don't use qib_wc_x86_64 for UML
Message-ID: <Y4hyPPzyQiI3i9jh@unreal>
References: <20221130200945.24459-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20221130200945.24459-1-rdunlap@infradead.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_012212_766306_67EB41C5 
X-CRM114-Status: GOOD (  23.04  )
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

T24gV2VkLCBOb3YgMzAsIDIwMjIgYXQgMTI6MDk6NDVQTSAtMDgwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOgo+IFdoZW4gYnVpbGRpbmcgcWliX3djX3g4Nl82NC5jIG9uIEFSQ0g9dW0sIHJlZmVyZW5j
ZXMgdG8gc29tZSBjcHVpbmZvCj4gZmllbGRzIGNhdXNlIGJ1aWxkIGVycm9ycyBzaW5jZSBjcHVp
bmZvIGRvZXMgbm90IGNvbnRhaW4geDg2LXNwZWNpZmljCj4gZmllbGRzLgo+IAo+IEZpeCB0aGUg
YnVpbGQgZXJyb3JzIGJ5IG1ha2luZyB0aGlzIGRyaXZlciBkZXBlbmQgb24gIVVNTC4KPiAKPiBQ
cmV2ZW50cyB0aGVzZSBidWlsZCBlcnJvcnM6Cj4gCj4gLi4vZHJpdmVycy9pbmZpbmliYW5kL2h3
L3FpYi9xaWJfd2NfeDg2XzY0LmM6IEluIGZ1bmN0aW9uIOKAmHFpYl91bm9yZGVyZWRfd2PigJk6
Cj4gLi4vZHJpdmVycy9pbmZpbmliYW5kL2h3L3FpYi9xaWJfd2NfeDg2XzY0LmM6MTQ5OjI5OiBl
cnJvcjog4oCYc3RydWN0IGNwdWluZm9fdW3igJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJh4ODZf
dmVuZG9y4oCZCj4gICAxNDkgfCAgICAgICAgIHJldHVybiBib290X2NwdV9kYXRhLng4Nl92ZW5k
b3IgIT0gWDg2X1ZFTkRPUl9BTUQ7Cj4gLi4vZHJpdmVycy9pbmZpbmliYW5kL2h3L3FpYi9xaWJf
d2NfeDg2XzY0LmM6MTQ5OjQ0OiBlcnJvcjog4oCYWDg2X1ZFTkRPUl9BTUTigJkgdW5kZWNsYXJl
ZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYWDg2X1ZFTkRP
Ul9BTlnigJk/Cj4gICAxNDkgfCAgICAgICAgIHJldHVybiBib290X2NwdV9kYXRhLng4Nl92ZW5k
b3IgIT0gWDg2X1ZFTkRPUl9BTUQ7Cj4gLi4vZHJpdmVycy9pbmZpbmliYW5kL2h3L3FpYi9xaWJf
d2NfeDg2XzY0LmM6MTQ5OjQ0OiBub3RlOiBlYWNoIHVuZGVjbGFyZWQgaWRlbnRpZmllciBpcyBy
ZXBvcnRlZCBvbmx5IG9uY2UgZm9yIGVhY2ggZnVuY3Rpb24gaXQgYXBwZWFycyBpbgo+IC4uL2Ry
aXZlcnMvaW5maW5pYmFuZC9ody9xaWIvcWliX3djX3g4Nl82NC5jOjE1MDoxOiBlcnJvcjogY29u
dHJvbCByZWFjaGVzIGVuZCBvZiBub24tdm9pZCBmdW5jdGlvbiBbLVdlcnJvcj1yZXR1cm4tdHlw
ZV0KPiAgIDE1MCB8IH0KPiAKPiBGaXhlczogNjhmNWQzZjNiNjU0ICgidW06IGFkZCBQQ0kgb3Zl
ciB2aXJ0aW8gZW11bGF0aW9uIGRyaXZlciIpCj4gU2lnbmVkLW9mZi1ieTogUmFuZHkgRHVubGFw
IDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4gQ2M6IEphc29uIEd1bnRob3JwZSA8amdnQG52aWRp
YS5jb20+Cj4gQ2M6IExlb24gUm9tYW5vdnNreSA8bGVvbkBrZXJuZWwub3JnPgo+IENjOiBEZW5u
aXMgRGFsZXNzYW5kcm8gPGRlbm5pcy5kYWxlc3NhbmRyb0Bjb3JuZWxpc25ldHdvcmtzLmNvbT4K
PiBDYzogbGludXgtcmRtYUB2Z2VyLmtlcm5lbC5vcmcKPiBDYzogSmVmZiBEaWtlIDxqZGlrZUBh
ZGR0b2l0LmNvbT4KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KPiBD
YzogQW50b24gSXZhbm92IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+IENjOiBK
b2hhbm5lcyBCZXJnIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IENjOiBsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnCj4gLS0tCj4gdjI6IHJlYmFzZSAmIHJlc2VuZAo+IAo+ICBkcml2
ZXJzL2luZmluaWJhbmQvaHcvcWliL0tjb25maWcgfCAgICAxICsKPiAgMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCj4gCj4gZGlmZiAtLSBhL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIv
S2NvbmZpZyBiL2RyaXZlcnMvaW5maW5pYmFuZC9ody9xaWIvS2NvbmZpZwo+IC0tLSBhL2RyaXZl
cnMvaW5maW5pYmFuZC9ody9xaWIvS2NvbmZpZwo+ICsrKyBiL2RyaXZlcnMvaW5maW5pYmFuZC9o
dy9xaWIvS2NvbmZpZwo+IEBAIC0zLDYgKzMsNyBAQCBjb25maWcgSU5GSU5JQkFORF9RSUIKPiAg
CXRyaXN0YXRlICJJbnRlbCBQQ0llIEhDQSBzdXBwb3J0Igo+ICAJZGVwZW5kcyBvbiA2NEJJVCAm
JiBJTkZJTklCQU5EX1JETUFWVAo+ICAJZGVwZW5kcyBvbiBQQ0kKPiArCWRlcGVuZHMgb24gIVVN
TAoKSSB3b3VsZCBhZHZvY2F0ZSB0byBhZGQgdGhpcyBsaW5lIHRvIHdob2xlIGRyaXZlcnMvaW5m
aW5pYmFuZC4KTm9uZSBvZiBSRE1BIGNvZGUgbWFrZXMgc2Vuc2UgZm9yIFVNTC4KClRoYW5rcwoK
PiAgCWhlbHAKPiAgCVRoaXMgaXMgYSBsb3ctbGV2ZWwgZHJpdmVyIGZvciBJbnRlbCBQQ0llIFFM
RSBJbmZpbmlCYW5kIGhvc3QKPiAgCWNoYW5uZWwgYWRhcHRlcnMuICBUaGlzIGRyaXZlciBkb2Vz
IG5vdCBzdXBwb3J0IHRoZSBJbnRlbAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K
