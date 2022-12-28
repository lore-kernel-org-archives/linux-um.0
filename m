Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE43DC5479D
	for <linux-um@archiver.kernel.org>; Wed, 28 Dec 2022 16:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T5EtZEyeaJhyMgTdsdlYzZFBesCsb7GPEbLMTbJx02g=; b=LR0eC+eEI8UUFj
	m18sNmR0URduC9aUQu4FZpL3O+U/YJ6GjIaaBXPhKMAGh4B1Z1QQpSKsZX0t+zpqlf0SklZjY2VWz
	nfyAkddecy85vS15Vtcq2oJw2XHCct/kFlyOB9N9h8pBBptBDd1tABCQ1j1F30HfNkqyeY0fM4yu2
	UUyAfpXLCZO0wFQTKL4CQo7yEtUMLBAa/DU8en3ru6jyUNNk6tSllsYt0fWFkl2lgsagWsuIS5sqx
	e7cy4k+I//vosJ8mI/qHL+U1yVTRbNW6Yb0oG2r6ilGe+wp1e+vhtZcPIwNRCE4ZyOuYmsF3M1PSB
	1oNFabsb4PrRkA3vUp5A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZCn-006KIs-4w; Wed, 28 Dec 2022 16:23:01 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZCj-006KFS-IX
	for linux-um@lists.infradead.org; Wed, 28 Dec 2022 16:22:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1CD33B8171E;
	Wed, 28 Dec 2022 16:22:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEE3FC433D2;
	Wed, 28 Dec 2022 16:22:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1672244574;
	bh=BLOZxcjnEXYR6XvwzCsyfFc30JnGmIUnqT9FcOApdUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=AyB9TxUVC4nxnJ2eZHsZYMl7rhga/NMlBErEyc2pujDhzoWgdGZN2ImqjnReZTDlD
	 Zb3l9oDhx6E4rjr7YKpV1lBD3jBD33Zzan559H+l6lO8ebtca/T3WQgUwZS0iB0Zbo
	 k1fg1rRO2TJl332SdMptxQmRAC2cBJoOPqLtTTOY=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Randy Dunlap <rdunlap@infradead.org>,
	Johannes Berg <johannes@sipsolutions.net>,
	Richard Weinberger <richard@nod.at>,
	linux-um@lists.infradead.org,
	Daniel Vetter <daniel@ffwll.ch>,
	Helge Deller <deller@gmx.de>,
	linux-fbdev@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	Michal Januszewski <spock@gentoo.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.0 0735/1073] fbdev: uvesafb: dont build on UML
Date: Wed, 28 Dec 2022 15:38:43 +0100
Message-Id: <20221228144347.986496644@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221228144328.162723588@linuxfoundation.org>
References: <20221228144328.162723588@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_082257_810775_3A36B967 
X-CRM114-Status: GOOD (  12.70  )
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

RnJvbTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+CgpbIFVwc3RyZWFtIGNv
bW1pdCAzNWI0ZjRkNGE3MjVjZjhmOGMxMDY0OTE2M2NkMTJhZWQ1MDliOTUzIF0KClRoZSB1dmVz
YWZiIGZiZGV2IGRyaXZlciB1c2VzIG1lbW9yeSBtYW5hZ2VtZW50IGluZm9ybWF0aW9uIHRoYXQg
aXMgbm90CmF2YWlsYWJsZSBvbiBBUkNIPXVtLCBzbyBkb24ndCBhbGxvdyB0aGlzIGRyaXZlciB0
byBiZSBidWlsdCBvbiBVTUwuCgpQcmV2ZW50cyB0aGVzZSBidWlsZCBlcnJvcnM6CgouLi9kcml2
ZXJzL3ZpZGVvL2ZiZGV2L3V2ZXNhZmIuYzogSW4gZnVuY3Rpb24g4oCYdXZlc2FmYl92YmVfaW5p
dOKAmToKLi4vZHJpdmVycy92aWRlby9mYmRldi91dmVzYWZiLmM6ODA3OjIxOiBlcnJvcjog4oCY
X19zdXBwb3J0ZWRfcHRlX21hc2vigJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVu
Y3Rpb24pCiAgODA3IHwgICAgICAgICAgICAgICAgIGlmIChfX3N1cHBvcnRlZF9wdGVfbWFzayAm
IF9QQUdFX05YKSB7Ci4uL2RyaXZlcnMvdmlkZW8vZmJkZXYvdXZlc2FmYi5jOjgwNzo0NDogZXJy
b3I6IOKAmF9QQUdFX05Y4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9u
KQogIDgwNyB8ICAgICAgICAgICAgICAgICBpZiAoX19zdXBwb3J0ZWRfcHRlX21hc2sgJiBfUEFH
RV9OWCkgewoKRml4ZXM6IDY4ZjVkM2YzYjY1NCAoInVtOiBhZGQgUENJIG92ZXIgdmlydGlvIGVt
dWxhdGlvbiBkcml2ZXIiKQpTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5sYXBAaW5m
cmFkZWFkLm9yZz4KQ2M6IEpvaGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+
CkNjOiBSaWNoYXJkIFdlaW5iZXJnZXIgPHJpY2hhcmRAbm9kLmF0PgpDYzogbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNoPgpDYzog
SGVsZ2UgRGVsbGVyIDxkZWxsZXJAZ214LmRlPgpDYzogbGludXgtZmJkZXZAdmdlci5rZXJuZWwu
b3JnCkNjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCkNjOiBNaWNoYWwgSmFudXN6
ZXdza2kgPHNwb2NrQGdlbnRvby5vcmc+ClNpZ25lZC1vZmYtYnk6IEhlbGdlIERlbGxlciA8ZGVs
bGVyQGdteC5kZT4KU2lnbmVkLW9mZi1ieTogU2FzaGEgTGV2aW4gPHNhc2hhbEBrZXJuZWwub3Jn
PgotLS0KIGRyaXZlcnMvdmlkZW8vZmJkZXYvS2NvbmZpZyB8IDEgKwogMSBmaWxlIGNoYW5nZWQs
IDEgaW5zZXJ0aW9uKCspCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy92aWRlby9mYmRldi9LY29uZmln
IGIvZHJpdmVycy92aWRlby9mYmRldi9LY29uZmlnCmluZGV4IDk0OTdmZTkyOTE2Mi4uOTc0ZTg2
MmNkMjBkIDEwMDY0NAotLS0gYS9kcml2ZXJzL3ZpZGVvL2ZiZGV2L0tjb25maWcKKysrIGIvZHJp
dmVycy92aWRlby9mYmRldi9LY29uZmlnCkBAIC02MDEsNiArNjAxLDcgQEAgY29uZmlnIEZCX1RH
QQogY29uZmlnIEZCX1VWRVNBCiAJdHJpc3RhdGUgIlVzZXJzcGFjZSBWRVNBIFZHQSBncmFwaGlj
cyBzdXBwb3J0IgogCWRlcGVuZHMgb24gRkIgJiYgQ09OTkVDVE9SCisJZGVwZW5kcyBvbiAhVU1M
CiAJc2VsZWN0IEZCX0NGQl9GSUxMUkVDVAogCXNlbGVjdCBGQl9DRkJfQ09QWUFSRUEKIAlzZWxl
Y3QgRkJfQ0ZCX0lNQUdFQkxJVAotLSAKMi4zNS4xCgoKCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==
