Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AE19E7D0AB
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 21:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=DyCvX09dW/36acy61mxvSqWh6a3l6HLMVJ2ns+Y43is=; b=WSS3AFRaeapvxVCJHEF0tyNFrw
	GivwLC2ytXjqrzIwUcmOwzKN2OVMEJO95oXSqzVtgTeEa2aeNP5SQqpqJa6S9bryHJSsXURsKELGv
	miABM1DjStAK8oJQ3MRlAdiYm6dVvzDpROU0o+M3ddR9BDjcfWOAFtxFQIkbYezlLogA/OjSEkDEQ
	P534Ixiun2TlBIhSGsmX3IGiFmfCLeX0dAlQQ1PuTrWce/VN01RNP/0On7OzqIV0eXGDsgZkOoygX
	3y3g3SYr5hqPJds/pjGxrmCHCbQRl8jyrqKd/aqKFdekHKKeqjHQoPHJ1SilWB5gqJ5R0UJ2Du1V1
	A1r+Ycbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjRdl-007F9A-0O;
	Thu, 21 Sep 2023 21:55:17 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjRdg-007F8P-1R
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 21:55:15 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2E51662348A7;
	Thu, 21 Sep 2023 23:55:09 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id KHPmlyrHkCEf; Thu, 21 Sep 2023 23:55:08 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id B0B0262348B4;
	Thu, 21 Sep 2023 23:55:08 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id YebYlCgVCFer; Thu, 21 Sep 2023 23:55:08 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 8EA1862348A7;
	Thu, 21 Sep 2023 23:55:08 +0200 (CEST)
Date: Thu, 21 Sep 2023 23:55:08 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Message-ID: <1842425402.67064.1695333308356.JavaMail.zimbra@nod.at>
In-Reply-To: <ac09760c-90fd-2209-a85c-5f33380238fc@cambridgegreys.com>
References: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com> <992345997.66924.1695330124883.JavaMail.zimbra@nod.at> <ac09760c-90fd-2209-a85c-5f33380238fc@cambridgegreys.com>
Subject: Re: [PATCH v4] um: Enable preemption in UML
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Enable preemption in UML
Thread-Index: iP2cJGGnHfmGjHHkzpI6bGcEgBpWZQ==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_145512_659175_BA5AC14F 
X-CRM114-Status: UNSURE (   7.40  )
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQW46ICJyaWNoYXJkIiA8cmljaGFyZEBu
b2QuYXQ+Cj4gQ0M6ICJsaW51eC11bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+LCAi
Sm9oYW5uZXMgQmVyZyIgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+Cj4gR2VzZW5kZXQ6IERv
bm5lcnN0YWcsIDIxLiBTZXB0ZW1iZXIgMjAyMyAyMzo0MToxNgo+IEJldHJlZmY6IFJlOiBbUEFU
Q0ggdjRdIHVtOiBFbmFibGUgcHJlZW1wdGlvbiBpbiBVTUwKCj4gT24gMjEvMDkvMjAyMyAyMjow
MiwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+PiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWls
IC0tLS0tCj4+PiBWb246ICJhbnRvbiBpdmFub3YiIDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3Jl
eXMuY29tPgo+Pj4gQW46ICJsaW51eC11bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+
Cj4+PiBDQzogIkpvaGFubmVzIEJlcmciIDxqb2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0PiwgInJp
Y2hhcmQiIDxyaWNoYXJkQG5vZC5hdD4sCj4+PiAiYW50b24gaXZhbm92Igo+Pj4gPGFudG9uLml2
YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4+PiBHZXNlbmRldDogRG9ubmVyc3RhZywgMjEuIFNl
cHRlbWJlciAyMDIzIDE3OjU1OjIyCj4+PiBCZXRyZWZmOiBbUEFUQ0ggdjRdIHVtOiBFbmFibGUg
cHJlZW1wdGlvbiBpbiBVTUwKPj4+IEZyb206IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNh
bWJyaWRnZWdyZXlzLmNvbT4KPj4+Cj4+PiBQcmVlbXB0aW9uIHJlcXVpcmVzIHNhdmluZy9yZXN0
b3JpbmcgRlBVIHN0YXRlLiBUaGlzIHBhdGNoCj4+PiBhZGRzIHN1cHBvcnQgZm9yIGl0IHVzaW5n
IEdDQyBpbnRyaW5zaWNzLgo+PiBUaGlzIHBhdGNoIHRyaWdnZXJzIGhlcmUgdGhlIGZvbGxvd2lu
ZyBzcGxhdDoKPiAKPiBBY2suIEkgd2lsbCBsb29rIGludG8gaXQgdG9tb3Jyb3cuCgpUaHghCkkg
aGFkIGEgYnJpZWYgbG9vaywgVU1MJ3MgaW5pdF9JUlEoKSBzZWVtcyB0byByZXR1cm4gbm93IHdp
dGggaW50ZXJydXB0cyBlbmFibGVkLgpEdW5ubyB3aHksIEkgbmVlZCBzb21lIHNsZWVwIG5vdy4K
Cj4gCj4gVGhlcmUgd2lsbCBiZSBwbGFjZXMgd2hlcmUgaXQgd2lsbCBib21iIG91dC4gRi5FLiBJ
IGFtIGNoYXNpbmcgb25lIGlzCj4gdHJpZ2dlcmVkIGJ5IHRoZSBORlMgc2VydmVyIChpdCBtYXkg
YmUgdGhlIHNhbWUgYXMgaW4gdGhpcyB0cmFjZSAtIGl0Cj4gaGFwcGVucyBhcm91bmQgdGhlIGVu
ZCBvZiB0aGUgaW5pdGlhbCBzZXR1cCkuCj4gCj4gQWxsIGluIGFsbCBpdCBsb29rcyBiZXR0ZXIg
dGhhbiBJIGV4cGVjdGVkLgoKVHJ1ZSB0aGF0ISA6LSkKClRoYW5rcywKLy9yaWNoYXJkCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
