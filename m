Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2016C4321E
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 01:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=Bz0XCEtq4k+aksYb/5diUF70F3kxlmMdgc7UT73sEA0=; b=rvT7VYZn6kwT27
	nKYrG5IBsuSYR2qXmk4vmrytiG+kj4a4z57r4dMWhti4HYXkBoAuBAQENSdUO3eMFsMCkwhxvi/sv
	K3+mXSDF8wIXy3KyZb7HmasVYTcq5CjQHZ55vfIYxlcTtqUoAoDVmMyb0SCLlvK96awJGf2a8hnXc
	OZrq/96J/F0dlaTqo/ql+grOSgKTz6dTg+OGWaL52Rpkj/Myhvyw+IAwPfLrwytuJghzLbQaT+hJf
	Hmf/VvK9KuxRLwt8StfwV86NNDnikpg7l9MaJgJC2ZmCFS9hjZqv/G/Ji3Zqkchg4qYwAke55OWcX
	INfP3OrjxUOB3YmJnWKg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0YKm-003mVj-Ct; Thu, 01 Dec 2022 01:25:52 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0YKl-003mVM-Ex; Thu, 01 Dec 2022 01:25:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=pk5DH7G/x9KTP95IkRi4C5JBQ3WWwGoC+AVueVfHSio=; b=SespthigY8G9VWNCp+UTy0ryA8
	3fxpFCtz3lHm0vPwhJfeb4mvc4aF6+diWFXOfkDxKWlNk2O0ys9mdxqowxrWSBQ/kVCts7+enK/bC
	nIbTSQ9Y9cDyvv97f6pH9MLoh1bsnnGDML80yWMSBYlLD/wJUa3QWe2sgQJe+7VJALZJoPWi9g+Y0
	/Zf5kzR3ouTL8eqMtjQbjpa2DBEm87Jfwi4c9tWu8GfxNZH8NZ+638Ml86KoB/g6jSYNbiztUnT0u
	Ob7M73kMxDoul/3iiFB//OalseT4C8uavkwlY0s8GJphLD50Yg7+/GA+zKgszdVBX3EwK0lXIZ2in
	7D5uOTvg==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0YKo-00FVtG-47; Thu, 01 Dec 2022 01:25:54 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	linux-um@lists.infradead.org,
	Andres Salomon <dilinger@queued.net>,
	linux-geode@lists.infradead.org,
	Lee Jones <lee@kernel.org>
Subject: [PATCH] mfd: cs5535: don't build on UML
Date: Wed, 30 Nov 2022 17:25:41 -0800
Message-Id: <20221201012541.11809-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.38.1
MIME-Version: 1.0
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

VGhlIGNzNTUzNS1tZmQgZHJpdmVyIHVzZXMgQ1BVLXNwZWNpZmljIGRhdGEgdGhhdCBpcyBub3Qg
YXZhaWxhYmxlCmZvciBBUkNIPXVtIGJ1aWxkcywgc28gZG9uJ3QgYWxsb3cgaXQgdG8gYmUgYnVp
bHQgZm9yIFVNTC4KClByZXZlbnRzIHRoZXNlIGJ1aWxkIGVycm9yczoKCkluIGZpbGUgaW5jbHVk
ZWQgZnJvbSAuLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9vbHBjLmg6NywKICAgICAgICAgICAgICAg
ICBmcm9tIC4uL2RyaXZlcnMvbWZkL2NzNTUzNS1tZmQuYzoxNzoKLi4vYXJjaC94ODYvaW5jbHVk
ZS9hc20vZ2VvZGUuaDogSW4gZnVuY3Rpb24g4oCYaXNfZ2VvZGVfZ3jigJk6Ci4uL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2dlb2RlLmg6MTY6MzE6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKA
mSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4Nl92ZW5kb3LigJkKICAgMTYgfCAgICAgICAgIHJl
dHVybiAoKGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX05TQykgJiYKLi4v
YXJjaC94ODYvaW5jbHVkZS9hc20vZ2VvZGUuaDoxNjo0NjogZXJyb3I6IOKAmFg4Nl9WRU5ET1Jf
TlND4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlvdSBt
ZWFuIOKAmFg4Nl9WRU5ET1JfQU5Z4oCZPwogICAxNiB8ICAgICAgICAgcmV0dXJuICgoYm9vdF9j
cHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfTlNDKSAmJgouLi9hcmNoL3g4Ni9pbmNs
dWRlL2FzbS9nZW9kZS5oOjE3OjMxOiBlcnJvcjog4oCYc3RydWN0IGNwdWluZm9fdW3igJkgaGFz
IG5vIG1lbWJlciBuYW1lZCDigJh4ODbigJkKICAgMTcgfCAgICAgICAgICAgICAgICAgKGJvb3Rf
Y3B1X2RhdGEueDg2ID09IDUpICYmCi4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6MTg6
MzE6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKA
mHg4Nl9tb2RlbOKAmQogICAxOCB8ICAgICAgICAgICAgICAgICAoYm9vdF9jcHVfZGF0YS54ODZf
bW9kZWwgPT0gNSkpOwouLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9nZW9kZS5oOiBJbiBmdW5jdGlv
biDigJhpc19nZW9kZV9seOKAmToKLi4vYXJjaC94ODYvaW5jbHVkZS9hc20vZ2VvZGUuaDoyMzoz
MTogZXJyb3I6IOKAmHN0cnVjdCBjcHVpbmZvX3Vt4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCY
eDg2X3ZlbmRvcuKAmQogICAyMyB8ICAgICAgICAgcmV0dXJuICgoYm9vdF9jcHVfZGF0YS54ODZf
dmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EKSAmJgouLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9nZW9k
ZS5oOjIzOjQ2OiBlcnJvcjog4oCYWDg2X1ZFTkRPUl9BTUTigJkgdW5kZWNsYXJlZCAoZmlyc3Qg
dXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYWDg2X1ZFTkRPUl9BTlnigJk/
CiAgIDIzIHwgICAgICAgICByZXR1cm4gKChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2
X1ZFTkRPUl9BTUQpICYmCi4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6MjQ6MzE6IGVy
cm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4NuKA
mQogICAyNCB8ICAgICAgICAgICAgICAgICAoYm9vdF9jcHVfZGF0YS54ODYgPT0gNSkgJiYKLi4v
YXJjaC94ODYvaW5jbHVkZS9hc20vZ2VvZGUuaDoyNTozMTogZXJyb3I6IOKAmHN0cnVjdCBjcHVp
bmZvX3Vt4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYeDg2X21vZGVs4oCZCiAgIDI1IHwgICAg
ICAgICAgICAgICAgIChib290X2NwdV9kYXRhLng4Nl9tb2RlbCA9PSAxMCkpOwoKRml4ZXM6IDY4
ZjVkM2YzYjY1NCAoInVtOiBhZGQgUENJIG92ZXIgdmlydGlvIGVtdWxhdGlvbiBkcml2ZXIiKQpT
aWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KQ2M6IEpv
aGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+CkNjOiBSaWNoYXJkIFdlaW5i
ZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgpDYzogbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpD
YzogQW5kcmVzIFNhbG9tb24gPGRpbGluZ2VyQHF1ZXVlZC5uZXQ+CkNjOiBsaW51eC1nZW9kZUBs
aXN0cy5pbmZyYWRlYWQub3JnCkNjOiBMZWUgSm9uZXMgPGxlZUBrZXJuZWwub3JnPgotLS0KIGRy
aXZlcnMvbWZkL0tjb25maWcgfCAgICAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigr
KQoKZGlmZiAtLSBhL2RyaXZlcnMvbWZkL0tjb25maWcgYi9kcml2ZXJzL21mZC9LY29uZmlnCi0t
LSBhL2RyaXZlcnMvbWZkL0tjb25maWcKKysrIGIvZHJpdmVycy9tZmQvS2NvbmZpZwpAQCAtMTUs
NiArMTUsNyBAQCBjb25maWcgTUZEX0NTNTUzNQogCXRyaXN0YXRlICJBTUQgQ1M1NTM1IGFuZCBD
UzU1MzYgc291dGhicmlkZ2UgY29yZSBmdW5jdGlvbnMiCiAJc2VsZWN0IE1GRF9DT1JFCiAJZGVw
ZW5kcyBvbiBQQ0kgJiYgKFg4Nl8zMiB8fCAoWDg2ICYmIENPTVBJTEVfVEVTVCkpCisJZGVwZW5k
cyBvbiAhVU1MCiAJaGVscAogCSAgVGhpcyBpcyB0aGUgY29yZSBkcml2ZXIgZm9yIENTNTUzNS9D
UzU1MzYgTUZEIGZ1bmN0aW9ucy4gIFRoaXMgaXMKIAkgIG5lY2Vzc2FyeSBmb3IgdXNpbmcgdGhl
IGJvYXJkJ3MgR1BJTyBhbmQgTUZHUFQgZnVuY3Rpb25hbGl0eS4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtdW0K
