Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 187ACC4321E
	for <linux-um@archiver.kernel.org>; Wed, 30 Nov 2022 21:55:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=DYHg5RQexEkK8r8o/AvD5n62zzoRl3jJcWOjCmbT5PA=; b=t+He0cgG3aNIAN
	I3a1NmGSdjBmZgnbigkLjb7Qfttr+6Owr25q93K/h4Y/1EvRDLaVQwVr/vGg0j6/0LykxT+VnUi1Q
	atCyf4VAvtEYTkLFe1TcxPc5NWBWAB/EMN9rnvihr6NNdiH0hwnFYTYYF5n7j+ePrz8MVQ/qY8tBB
	doaIvOK5hhgNmiphBavRUtZm/oCEeyJUfDRXQfMeBGFqtvaFIDxeNGi6W5gbm4InlBo1oqAS3SuN+
	3m7moK+b3ZVIsM39yY8OeuUM2f3/LZYDiHlMMtddsLphJ8Us7mUFfRyaYUA2vJ/kgHaRzW+80zgjk
	LKxoAe/LByzkrNoyeM1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0V3b-002uR3-96; Wed, 30 Nov 2022 21:55:55 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0V3Z-002uPT-Pf; Wed, 30 Nov 2022 21:55:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=IYRKxi+onLBFbh4zY0bg9jQRkT3TX2p808M3H7FEIdk=; b=goeggzxiVtspFRe1gCJYV2AjAY
	3Ien6lK0K0BV9wiAGtv//wzGWz+O8fXUKPwpErcqh4Hc6va6uoVte449UkPeVtdFBUyvgfz1CBA3h
	WupqZvb7OgIQcJ3wjHdpYFVenXpiwYuYrQ+l9BRsQqbZjWQRJaptQaYsgH3WqLWeiWEJnPLEOBcE2
	cJfLGab+Am3K/zwPuvgF/nkLtN1lnsFmdyi5fSWpGDDKkM3523z4ASMf/QcQ+tuiXzAprfodEI+Qf
	Ix0WXRT0AG4kIZnHJnSzyVCRWbLkmAZlngq3lZ4WCsNSzwoV9vtu2K8SizYZkDWZe/Wb0iRRc0qh2
	qVUd31gA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0V3d-00FKCY-3n; Wed, 30 Nov 2022 21:55:57 +0000
From: Randy Dunlap <rdunlap@infradead.org>
To: linux-kernel@vger.kernel.org
Cc: Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	linux-um@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Andres Salomon <dilinger@queued.net>,
	linux-geode@lists.infradead.org
Subject: [PATCH 1/2] fbdev: geode: don't build on UML
Date: Wed, 30 Nov 2022 13:55:44 -0800
Message-Id: <20221130215544.28497-1-rdunlap@infradead.org>
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

VGhlIGdlb2RlIGZiZGV2IGRyaXZlciB1c2VzIHN0cnVjdCBjcHVpbmZvIGZpZWxkcyB0aGF0IGFy
ZSBub3QgcHJlc2VudApvbiBBUkNIPXVtLCBzbyBkb24ndCBhbGxvdyB0aGlzIGRyaXZlciB0byBi
ZSBidWlsdCBvbiBVTUwuCgpQcmV2ZW50cyB0aGVzZSBidWlsZCBlcnJvcnM6CgpJbiBmaWxlIGlu
Y2x1ZGVkIGZyb20gLi4vYXJjaC94ODYvaW5jbHVkZS9hc20vb2xwYy5oOjc6MCwKICAgICAgICAg
ICAgICAgICBmcm9tIC4uL2RyaXZlcnMvbWZkL2NzNTUzNS1tZmQuYzoxNzoKLi4vYXJjaC94ODYv
aW5jbHVkZS9hc20vZ2VvZGUuaDogSW4gZnVuY3Rpb24g4oCYaXNfZ2VvZGVfZ3jigJk6Ci4uL2Fy
Y2gveDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6MTY6MjQ6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5m
b191beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4Nl92ZW5kb3LigJkKICByZXR1cm4gKChi
b290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRPUl9OU0MpICYmCi4uL2FyY2gveDg2
L2luY2x1ZGUvYXNtL2dlb2RlLmg6MTY6Mzk6IGVycm9yOiDigJhYODZfVkVORE9SX05TQ+KAmSB1
bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhY
ODZfVkVORE9SX0FOWeKAmT8KICByZXR1cm4gKChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0g
WDg2X1ZFTkRPUl9OU0MpICYmCi4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6MTc6MTc6
IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4
NuKAmQogICAoYm9vdF9jcHVfZGF0YS54ODYgPT0gNSkgJiYKLi4vYXJjaC94ODYvaW5jbHVkZS9h
c20vZ2VvZGUuaDoxODoxNzogZXJyb3I6IOKAmHN0cnVjdCBjcHVpbmZvX3Vt4oCZIGhhcyBubyBt
ZW1iZXIgbmFtZWQg4oCYeDg2X21vZGVs4oCZCiAgIChib290X2NwdV9kYXRhLng4Nl9tb2RlbCA9
PSA1KSk7Ci4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6IEluIGZ1bmN0aW9uIOKAmGlz
X2dlb2RlX2x44oCZOgouLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9nZW9kZS5oOjIzOjI0OiBlcnJv
cjog4oCYc3RydWN0IGNwdWluZm9fdW3igJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJh4ODZfdmVu
ZG9y4oCZCiAgcmV0dXJuICgoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1Jf
QU1EKSAmJgouLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9nZW9kZS5oOjIzOjM5OiBlcnJvcjog4oCY
WDg2X1ZFTkRPUl9BTUTigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24p
OyBkaWQgeW91IG1lYW4g4oCYWDg2X1ZFTkRPUl9BTlnigJk/CiAgcmV0dXJuICgoYm9vdF9jcHVf
ZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EKSAmJgouLi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9nZW9kZS5oOjI0OjE3OiBlcnJvcjog4oCYc3RydWN0IGNwdWluZm9fdW3igJkgaGFzIG5v
IG1lbWJlciBuYW1lZCDigJh4ODbigJkKICAgKGJvb3RfY3B1X2RhdGEueDg2ID09IDUpICYmCi4u
L2FyY2gveDg2L2luY2x1ZGUvYXNtL2dlb2RlLmg6MjU6MTc6IGVycm9yOiDigJhzdHJ1Y3QgY3B1
aW5mb191beKAmSBoYXMgbm8gbWVtYmVyIG5hbWVkIOKAmHg4Nl9tb2RlbOKAmQogICAoYm9vdF9j
cHVfZGF0YS54ODZfbW9kZWwgPT0gMTApKTsKCkZpeGVzOiA2OGY1ZDNmM2I2NTQgKCJ1bTogYWRk
IFBDSSBvdmVyIHZpcnRpbyBlbXVsYXRpb24gZHJpdmVyIikKU2lnbmVkLW9mZi1ieTogUmFuZHkg
RHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+CkNjOiBKb2hhbm5lcyBCZXJnIDxqb2hhbm5l
c0BzaXBzb2x1dGlvbnMubmV0PgpDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5h
dD4KQ2M6IGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKQ2M6IERhbmllbCBWZXR0ZXIgPGRh
bmllbEBmZndsbC5jaD4KQ2M6IEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT4KQ2M6IGxpbnV4
LWZiZGV2QHZnZXIua2VybmVsLm9yZwpDYzogZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9y
ZwpDYzogQW5kcmVzIFNhbG9tb24gPGRpbGluZ2VyQHF1ZXVlZC5uZXQ+CkNjOiBsaW51eC1nZW9k
ZUBsaXN0cy5pbmZyYWRlYWQub3JnCi0tLQogZHJpdmVycy92aWRlby9mYmRldi9nZW9kZS9LY29u
ZmlnIHwgICAgMSArCiAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKCmRpZmYgLS0gYS9k
cml2ZXJzL3ZpZGVvL2ZiZGV2L2dlb2RlL0tjb25maWcgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L2dl
b2RlL0tjb25maWcKLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9nZW9kZS9LY29uZmlnCisrKyBi
L2RyaXZlcnMvdmlkZW8vZmJkZXYvZ2VvZGUvS2NvbmZpZwpAQCAtNSw2ICs1LDcgQEAKIGNvbmZp
ZyBGQl9HRU9ERQogCWJvb2wgIkFNRCBHZW9kZSBmYW1pbHkgZnJhbWVidWZmZXIgc3VwcG9ydCIK
IAlkZXBlbmRzIG9uIEZCICYmIFBDSSAmJiAoWDg2XzMyIHx8IChYODYgJiYgQ09NUElMRV9URVNU
KSkKKwlkZXBlbmRzIG9uICFVTUwKIAloZWxwCiAJICBTYXkgJ1knIGhlcmUgdG8gYWxsb3cgeW91
IHRvIHNlbGVjdCBmcmFtZWJ1ZmZlciBkcml2ZXJzIGZvcgogCSAgdGhlIEFNRCBHZW9kZSBmYW1p
bHkgb2YgcHJvY2Vzc29ycy4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
