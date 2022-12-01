Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40A73C4321E
	for <linux-um@archiver.kernel.org>; Thu,  1 Dec 2022 07:58:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=oOrM7RS6aC8qIwmdiJDSX7Gs1rP6oAIe4AT9Soacw6M=; b=m5JtrqqIibk9qY
	gxFIXHRaswXESfMF6LYXzCSXpEpWT/FU0B2M9MW4JLkAHi8VviqZEGHa3HnrkwURR3FzrvxyMYz6q
	ocK6zf7XRrp8FK5QtZyOy3k9ZVW06dbTFdmkczm+6TpwLmezYYiKZgfxO30M6e1GwHwMN9K3LNPHk
	Z0/I8TODxTZGRkuPGCp6GDxG+NCBppe6sHZJL4DH5I4ZjXEFAmda5psCpBCzm/rXU2LTK7o2p68Pq
	FGgAlC9cCzH5y8EMMms1b5t7OnbDFF0zaFmmM21Vk7fKBwAH8uweIHnGDYI8WbEE9wlxIaV58c6K0
	priv3etzF9HJ+I0PEijQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0eSN-005gP6-Gt; Thu, 01 Dec 2022 07:58:07 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0eSL-005gMf-AZ
	for linux-um@bombadil.infradead.org; Thu, 01 Dec 2022 07:58:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:Content-Type
	:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=JFAPuqcwWjdRWHghvojHwi7McW1O9DfKJ+K3EY3dLBA=; b=jqMQkHufR5IxYTaeWUMXDE4xRQ
	MyKzOVShdfGOhi1iI2zzYDhxlcaVvwkrZTUUsHpCbsHjmBMC6aRVVZG10Pwt06W1uNrQ1msMF1+E0
	p1Nn1JnKV7Zp0OfB2W6wKM/4cLWNlU3IQzSSmJtnSqbV7FcRYiUHWxgDtauW27paVcPhvQiI8P3W7
	NKHwBrcOIGeEizau+i10sAgmzqI+UWDYBx3j158BovKKrsVj7FDu2ALPkGYkEkwyECOR11Au6bU/9
	nWMMaTqzQOUHXagwhMz4rz79HIrSSCTpbKdU+oe1EFMHDOFoufqimFkQEy7MgrauhQ+TZOg+uudYk
	j0lOEUfQ==;
Received: from mout.gmx.net ([212.227.17.21])
	by desiato.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p0eSE-006G6b-Ar
	for linux-um@lists.infradead.org; Thu, 01 Dec 2022 07:58:00 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
	t=1669881435; bh=1TG7t7iGxI5iBeZfr7K40KtO8/tCvEl9OlJVEZXqzdw=;
	h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:In-Reply-To;
	b=IXXS/ihDLD5r8o14UFrcAyCArHgi7HmLAv0BnsoiEfOZGjm0P1u5N1fUE2XmKrbTa
	 Q2WMF07+M3Cu6d5qGgtxj7Eh8cqCrg4Kf1x+xLQweirrBP6N5gL0cckat36ref6v+A
	 dH0vLbZ0xBUoMlaBzfd/u+yZi0ZtH9qLljT3UiBT9ww17bxSB5q8dE3DUD4IIjGWA2
	 MLevw/Z8GKp9pblHcEr3SnlT7PZPZZaEDNDGxXioAiaPCaTDiWljB/UR4dnlt4AKZC
	 24GzfmzwAzqSNoIuAe/0WAJ4599Z5CntJSSZkL4N5JvIzd/qRdRiOCMxzTFNB1qAMg
	 9pp7Jh0RefuhA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.60] ([92.116.178.52]) by mail.gmx.net (mrgmx105
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1MNKlu-1pKu2r1YOA-00OmnK; Thu, 01
 Dec 2022 08:57:15 +0100
Message-ID: <a3e1bbd6-9ff8-6cb2-4034-05055f499c6d@gmx.de>
Date: Thu, 1 Dec 2022 08:57:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/2] fbdev: geode: don't build on UML
To: Randy Dunlap <rdunlap@infradead.org>, linux-kernel@vger.kernel.org
Cc: Johannes Berg <johannes@sipsolutions.net>,
 Richard Weinberger <richard@nod.at>, linux-um@lists.infradead.org,
 Daniel Vetter <daniel@ffwll.ch>, linux-fbdev@vger.kernel.org,
 dri-devel@lists.freedesktop.org, Andres Salomon <dilinger@queued.net>,
 linux-geode@lists.infradead.org
References: <20221130215544.28497-1-rdunlap@infradead.org>
Content-Language: en-US
From: Helge Deller <deller@gmx.de>
In-Reply-To: <20221130215544.28497-1-rdunlap@infradead.org>
X-Provags-ID: V03:K1:PpGogZnW6HhwaMr7tc/5/1UjEN/jHdMDXMece1a88p3qFJsxYnH
 pqyNgQ/pEphLd1DIZWkKcguwYgCFIlM/UAVYmmDvU4V/9pMH6vnOOfLlzPzNPwI/kxh0pHP
 szX0goj+isPJtRkSFRy/nL1DAaJSEUTKyyVL8ZeVlTri8IO49fLLLjCX8w0oMQsM7p21wVx
 UZjay3b7hdJqUaQGrFhiQ==
UI-OutboundReport: notjunk:1;M01:P0:5PKJk0yIPzM=;kqh16m3VshbvOOXZdkeQQw4m8pN
 34hBkfxHn/b/W2s3sZWRvyww+JuLDdbgq7wd5S/CedBb9F5snxlzC6c90vOT5v1LCw4wvIRL7
 1CL43JEfPXgGbdEUkAzy17TxIh8YdhnX2LmCVWz0FoRE03GiCczJBKDAamo5TlqlRUhFecgr2
 QrCxSIjn4gFMbAbTjMGUiYqdKI6MOHJzvNgGbXVmxqGxrIEzSv3Ob5XEm3m/auy6jJhhgsdqa
 6/gUSFChG1uyAvfszTwnCeFCRi9WlAdxU1GBLPz+nedkqCvC46eFUhZsvLy7W34ibGd26ASlo
 GHGAPfNiY8HrPbYtNW3Mnca7wFXieyosEWEv2YcqxnMd0AnKDbySkRaIX6Ho2TWfx+zv3VAoz
 I4dmkor/6GgN4N0rq+TVvol2MZbpg2nSadAA/0WP7IBXklp6gAqbfXq5ghJpAeQlmyoCF7QuK
 4P/Do+tVzGxsDTU9mZAnjvoeVFGFvFvtenlWQfTJaqpCyOwYrNZRDjiJ3vcbg7otT1exnogbB
 xyaBOI5VdFVQDwziE7F0iDKWxJarly376Zp0w48+8ZajRLoSiGY/mQfyVHPNs95sTWYbagw5k
 A8lWTojjckEY3wPiK8ORXum4TGEMu4R27hPNRgE5eJaBopcYgmLEmVQBO5UO5FFOp0Y0wGcs3
 cRhlLRrWb3STkYZk3VfRfwymh/dC6rA53NAu0U6FmQTjUJtJwhDLsuUGUbUyxRE1sU7yLTVWy
 CwDvoS69jjogATmheSXUOBThpXfg+cgmFLi+xJ3B9ZLqeutY5XNfXPaKAgN9buh9Ndz7OS0Zn
 U0UT8KY9fWGEETAt46b1h5SiktUpYGwMwpROxvcXD+W2X0hh4Bvcfu/U1ffT/tlIsGSIp7U+C
 aBQDmZsh0aaaaNgqb7kdl3spPh75hba0jk1e+xbn7D4BlngYDPdtxLhtQBSnnuZGzhrvP55UF
 7lXH5zWou3FdKyj4IS80Xh2Zb+k=
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221201_075758_701067_6522888C 
X-CRM114-Status: GOOD (  15.23  )
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

T24gMTEvMzAvMjIgMjI6NTUsIFJhbmR5IER1bmxhcCB3cm90ZToKPiBUaGUgZ2VvZGUgZmJkZXYg
ZHJpdmVyIHVzZXMgc3RydWN0IGNwdWluZm8gZmllbGRzIHRoYXQgYXJlIG5vdCBwcmVzZW50Cj4g
b24gQVJDSD11bSwgc28gZG9uJ3QgYWxsb3cgdGhpcyBkcml2ZXIgdG8gYmUgYnVpbHQgb24gVU1M
Lgo+Cj4gUHJldmVudHMgdGhlc2UgYnVpbGQgZXJyb3JzOgo+Cj4gSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIC4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL29scGMuaDo3OjAsCj4gICAgICAgICAgICAgICAg
ICAgZnJvbSAuLi9kcml2ZXJzL21mZC9jczU1MzUtbWZkLmM6MTc6Cj4gLi4vYXJjaC94ODYvaW5j
bHVkZS9hc20vZ2VvZGUuaDogSW4gZnVuY3Rpb24g4oCYaXNfZ2VvZGVfZ3jigJk6Cj4gLi4vYXJj
aC94ODYvaW5jbHVkZS9hc20vZ2VvZGUuaDoxNjoyNDogZXJyb3I6IOKAmHN0cnVjdCBjcHVpbmZv
X3Vt4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYeDg2X3ZlbmRvcuKAmQo+ICAgIHJldHVybiAo
KGJvb3RfY3B1X2RhdGEueDg2X3ZlbmRvciA9PSBYODZfVkVORE9SX05TQykgJiYKPiAuLi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9nZW9kZS5oOjE2OjM5OiBlcnJvcjog4oCYWDg2X1ZFTkRPUl9OU0Pi
gJkgdW5kZWNsYXJlZCAoZmlyc3QgdXNlIGluIHRoaXMgZnVuY3Rpb24pOyBkaWQgeW91IG1lYW4g
4oCYWDg2X1ZFTkRPUl9BTlnigJk/Cj4gICAgcmV0dXJuICgoYm9vdF9jcHVfZGF0YS54ODZfdmVu
ZG9yID09IFg4Nl9WRU5ET1JfTlNDKSAmJgo+IC4uL2FyY2gveDg2L2luY2x1ZGUvYXNtL2dlb2Rl
Lmg6MTc6MTc6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKAmSBoYXMgbm8gbWVtYmVyIG5h
bWVkIOKAmHg4NuKAmQo+ICAgICAoYm9vdF9jcHVfZGF0YS54ODYgPT0gNSkgJiYKPiAuLi9hcmNo
L3g4Ni9pbmNsdWRlL2FzbS9nZW9kZS5oOjE4OjE3OiBlcnJvcjog4oCYc3RydWN0IGNwdWluZm9f
dW3igJkgaGFzIG5vIG1lbWJlciBuYW1lZCDigJh4ODZfbW9kZWzigJkKPiAgICAgKGJvb3RfY3B1
X2RhdGEueDg2X21vZGVsID09IDUpKTsKPiAuLi9hcmNoL3g4Ni9pbmNsdWRlL2FzbS9nZW9kZS5o
OiBJbiBmdW5jdGlvbiDigJhpc19nZW9kZV9seOKAmToKPiAuLi9hcmNoL3g4Ni9pbmNsdWRlL2Fz
bS9nZW9kZS5oOjIzOjI0OiBlcnJvcjog4oCYc3RydWN0IGNwdWluZm9fdW3igJkgaGFzIG5vIG1l
bWJlciBuYW1lZCDigJh4ODZfdmVuZG9y4oCZCj4gICAgcmV0dXJuICgoYm9vdF9jcHVfZGF0YS54
ODZfdmVuZG9yID09IFg4Nl9WRU5ET1JfQU1EKSAmJgo+IC4uL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2dlb2RlLmg6MjM6Mzk6IGVycm9yOiDigJhYODZfVkVORE9SX0FNROKAmSB1bmRlY2xhcmVkIChm
aXJzdCB1c2UgaW4gdGhpcyBmdW5jdGlvbik7IGRpZCB5b3UgbWVhbiDigJhYODZfVkVORE9SX0FO
WeKAmT8KPiAgICByZXR1cm4gKChib290X2NwdV9kYXRhLng4Nl92ZW5kb3IgPT0gWDg2X1ZFTkRP
Ul9BTUQpICYmCj4gLi4vYXJjaC94ODYvaW5jbHVkZS9hc20vZ2VvZGUuaDoyNDoxNzogZXJyb3I6
IOKAmHN0cnVjdCBjcHVpbmZvX3Vt4oCZIGhhcyBubyBtZW1iZXIgbmFtZWQg4oCYeDg24oCZCj4g
ICAgIChib290X2NwdV9kYXRhLng4NiA9PSA1KSAmJgo+IC4uL2FyY2gveDg2L2luY2x1ZGUvYXNt
L2dlb2RlLmg6MjU6MTc6IGVycm9yOiDigJhzdHJ1Y3QgY3B1aW5mb191beKAmSBoYXMgbm8gbWVt
YmVyIG5hbWVkIOKAmHg4Nl9tb2RlbOKAmQo+ICAgICAoYm9vdF9jcHVfZGF0YS54ODZfbW9kZWwg
PT0gMTApKTsKPgo+IEZpeGVzOiA2OGY1ZDNmM2I2NTQgKCJ1bTogYWRkIFBDSSBvdmVyIHZpcnRp
byBlbXVsYXRpb24gZHJpdmVyIikKPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJkdW5s
YXBAaW5mcmFkZWFkLm9yZz4KPiBDYzogSm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRp
b25zLm5ldD4KPiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KPiBDYzog
bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxA
ZmZ3bGwuY2g+Cj4gQ2M6IEhlbGdlIERlbGxlciA8ZGVsbGVyQGdteC5kZT4KPiBDYzogbGludXgt
ZmJkZXZAdmdlci5rZXJuZWwub3JnCj4gQ2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5v
cmcKPiBDYzogQW5kcmVzIFNhbG9tb24gPGRpbGluZ2VyQHF1ZXVlZC5uZXQ+Cj4gQ2M6IGxpbnV4
LWdlb2RlQGxpc3RzLmluZnJhZGVhZC5vcmcKCmFwcGxpZWQuClRoYW5rcyEKCkhlbGdlCgoKPiAt
LS0KPiAgIGRyaXZlcnMvdmlkZW8vZmJkZXYvZ2VvZGUvS2NvbmZpZyB8ICAgIDEgKwo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspCj4KPiBkaWZmIC0tIGEvZHJpdmVycy92aWRlby9m
YmRldi9nZW9kZS9LY29uZmlnIGIvZHJpdmVycy92aWRlby9mYmRldi9nZW9kZS9LY29uZmlnCj4g
LS0tIGEvZHJpdmVycy92aWRlby9mYmRldi9nZW9kZS9LY29uZmlnCj4gKysrIGIvZHJpdmVycy92
aWRlby9mYmRldi9nZW9kZS9LY29uZmlnCj4gQEAgLTUsNiArNSw3IEBACj4gICBjb25maWcgRkJf
R0VPREUKPiAgIAlib29sICJBTUQgR2VvZGUgZmFtaWx5IGZyYW1lYnVmZmVyIHN1cHBvcnQiCj4g
ICAJZGVwZW5kcyBvbiBGQiAmJiBQQ0kgJiYgKFg4Nl8zMiB8fCAoWDg2ICYmIENPTVBJTEVfVEVT
VCkpCj4gKwlkZXBlbmRzIG9uICFVTUwKPiAgIAloZWxwCj4gICAJICBTYXkgJ1knIGhlcmUgdG8g
YWxsb3cgeW91IHRvIHNlbGVjdCBmcmFtZWJ1ZmZlciBkcml2ZXJzIGZvcgo+ICAgCSAgdGhlIEFN
RCBHZW9kZSBmYW1pbHkgb2YgcHJvY2Vzc29ycy4KCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==
