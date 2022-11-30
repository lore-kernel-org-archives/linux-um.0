Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3731C4321E
	for <linux-um@archiver.kernel.org>; Wed, 30 Nov 2022 21:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:Cc
	:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=yb9D898J1gY+RGlGrbvCI9JXj1fZ2a064KreEgp74m0=; b=U+tunPd+IOIwtY
	AbyGCS7SsRhGE1KvYYOtV/ppNxSgvupxVfqRPGsdu/uwp4MvlUqBS/I7Y51Bdo3GhZSW1R7wvjMA4
	ypmj+rrAYLB0XN0gnXd/Yi9QyzRd9WltMp5CrlsRzDDd7yeYLWPNlB5K+0V4YAn5QKwqznnV7utWv
	H05n/BmkI14MzM0ubbrNzc39wluUJHd+gW51VpvAmIV26KEtIPYewAtiJmLwx9Fiu3K2gdEJwD5fk
	uDelAuR31fv8lISIa729iGHtI5eu2YUNP7Gu08MnDnPSu+Uh1ZloawJmxR/RjqqHuI/6ELA+s1EuN
	XuycQu7XAwYu+GaU//Aw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0V3p-002uTn-1M; Wed, 30 Nov 2022 21:56:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0V3n-002uTG-Mv; Wed, 30 Nov 2022 21:56:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=9ue0uGD9yX/1sJHyqmcNOU+aIhb/LFzhG5X5H+uhnGw=; b=eYuFdnVEKQN3qRV/BGXQG0Mxyd
	fFwZQ1O+epwDYpg5jkS8lEjMUV9QQCveIntrqBrGceCtOokWuJOQw2se3juK0d2RzfVaLpfJgu0PD
	7NsUelo2lxiHlGAnjkd3/kEFelkcxhp5ddwK6gP829fPi4D1YqYB6Ev3V6hBjHb4b5ldwXLjzcWpR
	M8wcPUQ+bwxU2jyd/KRF6uC7yaYmuBGnOi6HMeJnKkhe2JcBV75ccO/KiDnymTY/62qqZeGZWLsGB
	G5IIKQxENka/H3M061749bTb0qfMQGufCDpR9NraJM9CGU+5/+zMiTSa3BXAPujRHFFsYmtQY3nks
	TB2gcCQA==;
Received: from [2601:1c2:d80:3110::a2e7] (helo=casper.infradead.org)
	by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0V3s-00FKDQ-Io; Wed, 30 Nov 2022 21:56:13 +0000
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
	Michal Januszewski <spock@gentoo.org>
Subject: [PATCH 2/2] fbdev: uvesafb: don't build on UML
Date: Wed, 30 Nov 2022 13:55:59 -0800
Message-Id: <20221130215559.28969-1-rdunlap@infradead.org>
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

VGhlIHV2ZXNhZmIgZmJkZXYgZHJpdmVyIHVzZXMgbWVtb3J5IG1hbmFnZW1lbnQgaW5mb3JtYXRp
b24gdGhhdCBpcyBub3QKYXZhaWxhYmxlIG9uIEFSQ0g9dW0sIHNvIGRvbid0IGFsbG93IHRoaXMg
ZHJpdmVyIHRvIGJlIGJ1aWx0IG9uIFVNTC4KClByZXZlbnRzIHRoZXNlIGJ1aWxkIGVycm9yczoK
Ci4uL2RyaXZlcnMvdmlkZW8vZmJkZXYvdXZlc2FmYi5jOiBJbiBmdW5jdGlvbiDigJh1dmVzYWZi
X3ZiZV9pbml04oCZOgouLi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3V2ZXNhZmIuYzo4MDc6MjE6IGVy
cm9yOiDigJhfX3N1cHBvcnRlZF9wdGVfbWFza+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4g
dGhpcyBmdW5jdGlvbikKICA4MDcgfCAgICAgICAgICAgICAgICAgaWYgKF9fc3VwcG9ydGVkX3B0
ZV9tYXNrICYgX1BBR0VfTlgpIHsKLi4vZHJpdmVycy92aWRlby9mYmRldi91dmVzYWZiLmM6ODA3
OjQ0OiBlcnJvcjog4oCYX1BBR0VfTljigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMg
ZnVuY3Rpb24pCiAgODA3IHwgICAgICAgICAgICAgICAgIGlmIChfX3N1cHBvcnRlZF9wdGVfbWFz
ayAmIF9QQUdFX05YKSB7CgpGaXhlczogNjhmNWQzZjNiNjU0ICgidW06IGFkZCBQQ0kgb3ZlciB2
aXJ0aW8gZW11bGF0aW9uIGRyaXZlciIpClNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8cmR1
bmxhcEBpbmZyYWRlYWQub3JnPgpDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRp
b25zLm5ldD4KQ2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+CkNjOiBsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwu
Y2g+CkNjOiBIZWxnZSBEZWxsZXIgPGRlbGxlckBnbXguZGU+CkNjOiBsaW51eC1mYmRldkB2Z2Vy
Lmtlcm5lbC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IE1pY2hh
bCBKYW51c3pld3NraSA8c3BvY2tAZ2VudG9vLm9yZz4KLS0tCiBkcml2ZXJzL3ZpZGVvL2ZiZGV2
L0tjb25maWcgfCAgICAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlmZiAt
LSBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvS2NvbmZpZyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvS2Nv
bmZpZwotLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L0tjb25maWcKKysrIGIvZHJpdmVycy92aWRl
by9mYmRldi9LY29uZmlnCkBAIC02MDksNiArNjA5LDcgQEAgY29uZmlnIEZCX1RHQQogY29uZmln
IEZCX1VWRVNBCiAJdHJpc3RhdGUgIlVzZXJzcGFjZSBWRVNBIFZHQSBncmFwaGljcyBzdXBwb3J0
IgogCWRlcGVuZHMgb24gRkIgJiYgQ09OTkVDVE9SCisJZGVwZW5kcyBvbiAhVU1MCiAJc2VsZWN0
IEZCX0NGQl9GSUxMUkVDVAogCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUEKIAlzZWxlY3QgRkJfQ0ZC
X0lNQUdFQkxJVAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
