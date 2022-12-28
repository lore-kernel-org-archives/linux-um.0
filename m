Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D85DC4167B
	for <linux-um@archiver.kernel.org>; Wed, 28 Dec 2022 16:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=T5EtZEyeaJhyMgTdsdlYzZFBesCsb7GPEbLMTbJx02g=; b=AGVE6TP7+LPe+D
	p0k+UkDSYb1ShuIXhB91z0JLMwmI46zuNgzRptwYxCwJ8zLI6svSnBH4KtJ4VN0bQ1LwaXnx9+VvF
	0/pLpmw4NsI0DB9KKqlskx6V8GGM5LEdGBlHrkaUgBz6uTXH+7pb5f5VqDHZBFt4SyJVvBUsNIZNr
	v+oQdDA+FRWuHcEvDctKdFJbC2pTBBEYhGFLFHuWQvMddLhp6YFOWHJMdQYrBBaoWzDyWu1iuDLhF
	+A+LgFhFPhTgWg3NS+mj9PsBk4oBLypAyLx1QxGQQ4InRU4UuW9pEN1XnfYuJjbwMR6REwUJ0YIJT
	5HoayLRyCeWcIc8yCu5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZIA-006MCv-HT; Wed, 28 Dec 2022 16:28:34 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZI7-006MAM-K3
	for linux-um@lists.infradead.org; Wed, 28 Dec 2022 16:28:33 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 45C99B816F4;
	Wed, 28 Dec 2022 16:28:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6705FC433EF;
	Wed, 28 Dec 2022 16:28:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1672244908;
	bh=BLOZxcjnEXYR6XvwzCsyfFc30JnGmIUnqT9FcOApdUQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=m4UhiSuqZsyC3QCpMi57FYqQ9DsKaqI4FEJfzqfYVdIVaiIzGJ/v/t/7etd227iso
	 UtSxOU006pnmgNt0xTG8GUE2apCRAEVQui4Zt7C4f6vnp37L/Rfh8hhi2tWaM15q8i
	 epiC/H1hLSj1biLdQN7QvCzbvJQCsAKeN+1wDAnA=
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
Subject: [PATCH 6.1 0760/1146] fbdev: uvesafb: dont build on UML
Date: Wed, 28 Dec 2022 15:38:19 +0100
Message-Id: <20221228144350.786064866@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221228144330.180012208@linuxfoundation.org>
References: <20221228144330.180012208@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_082831_882546_6B306913 
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
