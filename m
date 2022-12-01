Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 999C1C47088
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 07:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jY52gMdhdx9CqtzCxiQ32rWPzvxmhVzSBu9/LpWN6cE=; b=vMYBt2USQSL89y
	o+eQL5A51GOYGIwgvU20l434rvkcMGC/8u9pQNLYu8rOr1g8aIlSxdOGTJtAoFWduUhRxC809Tg9n
	TRGb94jhj2RvO8038KyDX8WZjVcpu7tR02lwV3Kw5hv6ZlsUeDH+X4ZodW7gJo7nB83HJnBzj488V
	df2Dfy9EV3OOlp6oALcO2n4wX/IzlGjlvIxmpR4U8U99jSJfkP5RLIwmd1KH8B4lRIm3JIkJXPJ0l
	xgk3xei2Ul/FWGCGU5kXIEFW5QPeoJRvObyAKg+ooYGStCRuAa+JmMtcsjx2nYjI3A5vhYomMA9mx
	M7I8pg6FjO5I2mxhaKWg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0eSC-005gJu-Po; Thu, 01 Dec 2022 07:57:56 +0000
Received: from mout.gmx.net ([212.227.17.20])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0eS9-005gHX-GQ
	for linux-um@lists.infradead.org; Thu, 01 Dec 2022 07:57:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1669881451; bh=5lj8vIDyBwi7A84crvGtUsrnfkuqUwlP8Sc8sKuHUnA=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=oeDYOI4NcYQuPxomBZOpIos8ctSu/YlWeW/cPAoaZYlQi1wW+G4FcXX8MWr6eNE0C
	 XdIsa1pZWpoAmGd8gJYeTuO6OQ6HABPtAy3AjTbERmqAn5xe19SJyoE926DLyRcCet
	 RtPNK2elZ+WqrYpFGdUbvga7xS3XfYMqoOic5wBQT5X00g/FTKgwRWaaWMufdPNAGM
	 HS16n5FcutBPImHh9dg8ZsXw/hKAz2whGS1LwOBbXITmYTP00wOxIWBePq1h8DuSPl
	 EValiiX3b5wrpZfIFu+p64bhpqtSPS6Pm7hisAmM+LnLSOwGMrw3DkZk4zW0pTsdv6
	 58Ns04jX5e1ZA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.178.52]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1N95iR-1oyG0y1t0Z-0166gC; Thu, 01
 Dec 2022 08:57:31 +0100
Message-ID: <ee9cb30e-6a38-ee27-c6e6-bcc21f470c8e@gmx.de>
Date: Thu, 1 Dec 2022 08:57:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 2/2] fbdev: uvesafb: don't build on UML
Content-Language: en-US
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Michal Januszewski <spock@gentoo.org>
References: <20221130215559.28969-1-rdunlap@infradead.org>
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20221130215559.28969-1-rdunlap@infradead.org>
X-Provags-ID: V03:K1:ZksNENsIBlY8zmacmvPxeuE6AT4K0leodsrZiYiq7mTIKVSfSVH
 0jp0Au8+7ohKaM6vvryTb+zUZEjOaqB86Du98BstOzTIE5YUH6acAbVxW33uK0sb3MwnJew
 9E8gyJfUgueWkREmRnf5+rEGAEAEtxW3qsPdG70qdfo8XJXamtuPcd0tfYsE8UxaJYmm1BZ
 rhacJlkm6FIx64Y6ixXnA==
UI-OutboundReport: notjunk:1;M01:P0:wz3wAo12j3U=;l30nBJ9gyV0KH2nJFRy6ACIHqrr
 595JwtYcyKQn569+9vllPc2oaWd1WTR5bKeonkgZIWrh/LAVdloPZlwvdqDA/8WgR+bgJox9b
 mfTHuWIkqelJqGIZNzQUCURIjpRunCMx6xWoA1bQF9S3rhXRQGr1MLcJBRzB8WKgW5pKgPX+V
 LvZrVJovSRZf/dUyJvRqv2XGEqAiPLdSH9YQB3Gupx9bshsQVpRs+LCogeiLp+LsZnTyXhvhO
 pDdvQsSap4VU2CnD0bSZI9urromBMxg12aGLu02xHR6xSzDV6ZmyViIFozDrCq38mTINVCWaC
 4mR41JzjHAAOopBTFejP6FUw7eMOPiRNWdXyLEQWW1pv+Ba4HRyWWvurdvcVJe5yZ86295a2q
 NnaeaSCohCG6aSW+iLO6gIn2igbrtZNdlxHoxdsPl7S+DfC5Z/oSOcZAnMEBz0DintchB/HKx
 Gwy7EvawoPvNu3NC8sJavjDU8oL2PjPppDzDfdJmfoxdxNQXIjbe2winZmbjZpB+1dYaryDhz
 LS5PLPZHh0ztnI3CwDj0BdH3LvvnND3OH8bVuBYIEFvDuXDs8z7KsHkuGZ7JRS0FWjbm56wuV
 ZkPioMdYauyBQdQP1mGPVuGwR8fcXN/hop0ZMi3jiKL8/v4gos6BNKs5NyZbcw2uM0TvgsTU2
 8otH/0UTj6mgP42vzlWTi4oSmw/bn0v3fmNO+Zh3DTKByAjV9yzASsP8yFG4IKRITresl1XnV
 Xfu7FkHqjOyI0eX8w5VkWm1RfATHEndcL6dUv6Rbo2OOJ36PaBia/DRb4kjW6sc/UvfFRBlSF
 kF2cTwZsgljvi5tUEnvOC3N3zA6KV7NF8NVRdrGSUlniqwMc7azWC7RX96eWImnDweMjxwUyA
 0fzBSMC86P/FtuYOlLplK5Dr75iyylEHEdNX1mHXALr4p0w3Bw8VvF56ivZe8KTjdvm+hp5pv
 Pvnxj27jekGKs6yrw+kDfuxjRJg=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221130_235753_831525_3F8475EA 
X-CRM114-Status: GOOD (  14.41  )
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

T24gMTEvMzAvMjIgMjI6NTUsIFJhbmR5IER1bmxhcCB3cm90ZToKPiBUaGUgdXZlc2FmYiBmYmRl
diBkcml2ZXIgdXNlcyBtZW1vcnkgbWFuYWdlbWVudCBpbmZvcm1hdGlvbiB0aGF0IGlzIG5vdAo+
IGF2YWlsYWJsZSBvbiBBUkNIPXVtLCBzbyBkb24ndCBhbGxvdyB0aGlzIGRyaXZlciB0byBiZSBi
dWlsdCBvbiBVTUwuCj4KPiBQcmV2ZW50cyB0aGVzZSBidWlsZCBlcnJvcnM6Cj4KPiAuLi9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L3V2ZXNhZmIuYzogSW4gZnVuY3Rpb24g4oCYdXZlc2FmYl92YmVfaW5p
dOKAmToKPiAuLi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3V2ZXNhZmIuYzo4MDc6MjE6IGVycm9yOiDi
gJhfX3N1cHBvcnRlZF9wdGVfbWFza+KAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBm
dW5jdGlvbikKPiAgICA4MDcgfCAgICAgICAgICAgICAgICAgaWYgKF9fc3VwcG9ydGVkX3B0ZV9t
YXNrICYgX1BBR0VfTlgpIHsKPiAuLi9kcml2ZXJzL3ZpZGVvL2ZiZGV2L3V2ZXNhZmIuYzo4MDc6
NDQ6IGVycm9yOiDigJhfUEFHRV9OWOKAmSB1bmRlY2xhcmVkIChmaXJzdCB1c2UgaW4gdGhpcyBm
dW5jdGlvbikKPiAgICA4MDcgfCAgICAgICAgICAgICAgICAgaWYgKF9fc3VwcG9ydGVkX3B0ZV9t
YXNrICYgX1BBR0VfTlgpIHsKPgo+IEZpeGVzOiA2OGY1ZDNmM2I2NTQgKCJ1bTogYWRkIFBDSSBv
dmVyIHZpcnRpbyBlbXVsYXRpb24gZHJpdmVyIikKPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5s
YXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KPiBDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNA
c2lwc29sdXRpb25zLm5ldD4KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5h
dD4KPiBDYzogbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBEYW5pZWwgVmV0dGVy
IDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT4KPiBD
YzogbGludXgtZmJkZXZAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVl
ZGVza3RvcC5vcmcKPiBDYzogTWljaGFsIEphbnVzemV3c2tpIDxzcG9ja0BnZW50b28ub3JnPgoK
CmFwcGxpZWQuClRoYW5rcyEKCkhlbGdlCgo+IC0tLQo+ICAgZHJpdmVycy92aWRlby9mYmRldi9L
Y29uZmlnIHwgICAgMSArCj4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKykKPgo+IGRp
ZmYgLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L0tjb25maWcgYi9kcml2ZXJzL3ZpZGVvL2ZiZGV2
L0tjb25maWcKPiAtLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L0tjb25maWcKPiArKysgYi9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L0tjb25maWcKPiBAQCAtNjA5LDYgKzYwOSw3IEBAIGNvbmZpZyBGQl9U
R0EKPiAgIGNvbmZpZyBGQl9VVkVTQQo+ICAgCXRyaXN0YXRlICJVc2Vyc3BhY2UgVkVTQSBWR0Eg
Z3JhcGhpY3Mgc3VwcG9ydCIKPiAgIAlkZXBlbmRzIG9uIEZCICYmIENPTk5FQ1RPUgo+ICsJZGVw
ZW5kcyBvbiAhVU1MCj4gICAJc2VsZWN0IEZCX0NGQl9GSUxMUkVDVAo+ICAgCXNlbGVjdCBGQl9D
RkJfQ09QWUFSRUEKPiAgIAlzZWxlY3QgRkJfQ0ZCX0lNQUdFQkxJVAoKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K
