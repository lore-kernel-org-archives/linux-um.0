Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B237C53210
	for <linux-um@archiver.kernel.org>; Wed, 28 Dec 2022 16:22:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pF22f4dlkyj3fnySwRmLLNRLr06s/i/jIWLVWqVbTI0=; b=bIEebNZkH2wxBM
	KWASyaKdQYVWdk4mM2rCvPrufAv/RM00lAulPS4jY7/b1luFRdaSm3+Mjvd7N5K/fxyGQDo9a349h
	R0W5DJBs0kbChjZLDBvHEq4hVPCPdYkDWaUdjzwbHomFNfoeaHWIp4p+zAoPpdBUfPMSIJ2g0wA9N
	5keryKEdt+3jAA/h1exdbu8DcUJFFZRfdM4WalqbzqInEpu9k97/3o7YPupwgmMQBJDVMTIffQClA
	UVi5Bktq8l98ZrqMB+c1FJn8fnsh/GWC2dmnJ0RAfoEd5cRAoNHxmUtFLpkfO+Gc4O1+WZCSG0heC
	xDheqpmYu+8vFN/ixKzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZCh-006KEr-R8; Wed, 28 Dec 2022 16:22:55 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pAZCd-006KCT-Ly; Wed, 28 Dec 2022 16:22:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 182BAB816F4;
	Wed, 28 Dec 2022 16:22:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A570C433D2;
	Wed, 28 Dec 2022 16:22:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1672244568;
	bh=l6SZ1o3XablMRreE/05h9qlGf3szz8R5it9zAPOMn0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=wXAUdFOM2Nh6pIocMHZ1Ur7MzWMg28W9WuIAgeToNieGRT65sReAmjT273Mg0vjT+
	 lTjjwiZZNPD2Bw626gAqETbtodeo5stHCce+YZsJhxi60fMD29d5NNqv9z783nydpf
	 gti/00Md91d/uRGOipe47sFN2jD+0u16b5bgHRos=
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
	Andres Salomon <dilinger@queued.net>,
	linux-geode@lists.infradead.org,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.0 0734/1073] fbdev: geode: dont build on UML
Date: Wed, 28 Dec 2022 15:38:42 +0100
Message-Id: <20221228144347.960024744@linuxfoundation.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20221228144328.162723588@linuxfoundation.org>
References: <20221228144328.162723588@linuxfoundation.org>
User-Agent: quilt/0.67
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221228_082252_020414_938FB37B 
X-CRM114-Status: GOOD (  12.36  )
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
bW1pdCA3MWM1M2UxOTIyNmIwMTY2YmEzODdkM2M1OTBkMDUwOWY1NDFhMGExIF0KClRoZSBnZW9k
ZSBmYmRldiBkcml2ZXIgdXNlcyBzdHJ1Y3QgY3B1aW5mbyBmaWVsZHMgdGhhdCBhcmUgbm90IHBy
ZXNlbnQKb24gQVJDSD11bSwgc28gZG9uJ3QgYWxsb3cgdGhpcyBkcml2ZXIgdG8gYmUgYnVpbHQg
b24gVU1MLgoKUHJldmVudHMgdGhlc2UgYnVpbGQgZXJyb3JzOgoKSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIC4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL29scGMuaDo3OjAsCiAgICAgICAgICAgICAgICAg
ZnJvbSAuLi9kcml2ZXJzL21mZC9jczU1MzUtbWZkLmM6MTc6Ci4uL2FyY2gveDg2L2luY2x1ZGUv
YXNtL2dlb2RlLmg6IEluIGZ1bmN0aW9uIOKAmGlzX2dlb2RlX2d44oCZOgouLi9hcmNoL3g4Ni9p
bmNsdWRlL2FzbS9nZW9kZS5oOjE2OjI0OiBlcnJvcjog4oCYc3RydWN0IGNwdWluZm9fdW3igJkg
aGFzIG5vIG1lbWJlciBuYW1lZCDigJh4ODZfdmVuZG9y4oCZCiAgcmV0dXJuICgoYm9vdF9jcHVf
ZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfTlNDKSAmJgouLi9hcmNoL3g4Ni9pbmNsdWRl
L2FzbS9nZW9kZS5oOjE2OjM5OiBlcnJvcjog4oCYWDg2X1ZFTkRPUl9OU0PigJkgdW5kZWNsYXJl
ZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g4oCYWDg2X1ZFTkRP
Ul9BTlnigJk/CiAgcmV0dXJuICgoYm9vdF9jcHVfZGF0YS54ODZfdmVuZG9yID09IFg4Nl9WRU5E
T1JfTlNDKSAmJgouLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9nZW9kZS5oOjE3OjE3OiBlcnJvcjog
4oCYc3RydWN0IGNwdWluZm9fdW3igJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJh4ODbigJkKICAg
KGJvb3RfY3B1X2RhdGEueDg2ID09IDUpICYmCi4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2dlb2Rl
Lmg6MTg6MTc6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKAmSBoYXMgbm8gbWVtYmVyIG5h
bWVkIOKAmHg4Nl9tb2RlbOKAmQogICAoYm9vdF9jcHVfZGF0YS54ODZfbW9kZWwgPT0gNSkpOwou
Li9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9nZW9kZS5oOiBJbiBmdW5jdGlvbiDigJhpc19nZW9kZV9s
eOKAmToKLi4vYXJjaC94ODYvaW5jbHVkZS9hc20vZ2VvZGUuaDoyMzoyNDogZXJyb3I6IOKAmHN0
cnVjdCBjcHVpbmZvX3Vt4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYeDg2X3ZlbmRvcuKAmQog
IHJldHVybiAoKGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX0FNRCkgJiYK
Li4vYXJjaC94ODYvaW5jbHVkZS9hc20vZ2VvZGUuaDoyMzozOTogZXJyb3I6IOKAmFg4Nl9WRU5E
T1JfQU1E4oCZIHVuZGVjbGFyZWQgKGZpcnN0IHVzZSBpbiB0aGlzIGZ1bmN0aW9uKTsgZGlkIHlv
dSBtZWFuIOKAmFg4Nl9WRU5ET1JfQU5Z4oCZPwogIHJldHVybiAoKGJvb3RfY3B1X2RhdGEueDg2
X3ZlbmRvciA9PSBYODZfVkVORE9SX0FNRCkgJiYKLi4vYXJjaC94ODYvaW5jbHVkZS9hc20vZ2Vv
ZGUuaDoyNDoxNzogZXJyb3I6IOKAmHN0cnVjdCBjcHVpbmZvX3Vt4oCZIGhhcyBubyBtZW1iZXIg
bmFtZWQg4oCYeDg24oCZCiAgIChib290X2NwdV9kYXRhLng4NiA9PSA1KSAmJgouLi9hcmNoL3g4
Ni9pbmNsdWRlL2FzbS9nZW9kZS5oOjI1OjE3OiBlcnJvcjog4oCYc3RydWN0IGNwdWluZm9fdW3i
gJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJh4ODZfbW9kZWzigJkKICAgKGJvb3RfY3B1X2RhdGEu
eDg2X21vZGVsID09IDEwKSk7CgpGaXhlczogNjhmNWQzZjNiNjU0ICgidW06IGFkZCBQQ0kgb3Zl
ciB2aXJ0aW8gZW11bGF0aW9uIGRyaXZlciIpClNpZ25lZC1vZmYtYnk6IFJhbmR5IER1bmxhcCA8
cmR1bmxhcEBpbmZyYWRlYWQub3JnPgpDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29s
dXRpb25zLm5ldD4KQ2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+CkNjOiBs
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCkNjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3
bGwuY2g+CkNjOiBIZWxnZSBEZWxsZXIgPGRlbGxlckBnbXguZGU+CkNjOiBsaW51eC1mYmRldkB2
Z2VyLmtlcm5lbC5vcmcKQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IEFu
ZHJlcyBTYWxvbW9uIDxkaWxpbmdlckBxdWV1ZWQubmV0PgpDYzogbGludXgtZ2VvZGVAbGlzdHMu
aW5mcmFkZWFkLm9yZwpTaWduZWQtb2ZmLWJ5OiBIZWxnZSBEZWxsZXIgPGRlbGxlckBnbXguZGU+
ClNpZ25lZC1vZmYtYnk6IFNhc2hhIExldmluIDxzYXNoYWxAa2VybmVsLm9yZz4KLS0tCiBkcml2
ZXJzL3ZpZGVvL2ZiZGV2L2dlb2RlL0tjb25maWcgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlkZW8vZmJkZXYvZ2VvZGUvS2NvbmZp
ZyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvZ2VvZGUvS2NvbmZpZwppbmRleCBhYzljODYwNTkyYWEu
Ljg1YmMxNGI2ZmFmNiAxMDA2NDQKLS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9nZW9kZS9LY29u
ZmlnCisrKyBiL2RyaXZlcnMvdmlkZW8vZmJkZXYvZ2VvZGUvS2NvbmZpZwpAQCAtNSw2ICs1LDcg
QEAKIGNvbmZpZyBGQl9HRU9ERQogCWJvb2wgIkFNRCBHZW9kZSBmYW1pbHkgZnJhbWVidWZmZXIg
c3VwcG9ydCIKIAlkZXBlbmRzIG9uIEZCICYmIFBDSSAmJiAoWDg2XzMyIHx8IChYODYgJiYgQ09N
UElMRV9URVNUKSkKKwlkZXBlbmRzIG9uICFVTUwKIAloZWxwCiAJICBTYXkgJ1knIGhlcmUgdG8g
YWxsb3cgeW91IHRvIHNlbGVjdCBmcmFtZWJ1ZmZlciBkcml2ZXJzIGZvcgogCSAgdGhlIEFNRCBH
ZW9kZSBmYW1pbHkgb2YgcHJvY2Vzc29ycy4KLS0gCjIuMzUuMQoKCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0Cmxp
bnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC11bQo=
