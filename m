Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E769E7D0AB
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 21:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=sA0KqB61APE28iY04+ePrzEwBfR8Y6jkyFzoESjmnAc=; b=GUBTkGjK4KD4KV
	btZ5TP1SV1Ojm8HmOrtZZr/TIKNcba8s+GFEfU4x2gQW6qfHxEznPeCHZ8X5qN07YagvIE2VJJXN0
	oXs+JsG1roVRYPyUY/O5hQN6LAxYcWBnZ7J3f5RdQtCH5bQnJHQsBJQcNh498xpxI2iKIBu4FCzUu
	Qab/g65Nqb5k1eK0r4b9g1IDCEnBgs9Dzlrq0pXGMDr8B++Albyrx1u+jEAZMG2CHZvt0U+GP6Gmx
	2o4DijSnLQZ0RynkMDDg7X+t19XQm+PdvRZN3tsfPEPRL8BWHbtI9H/3hI4RZukJWEYqZUdDm42Rp
	rpnEbB56Wbh3Gieqjt7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjRQM-007DRj-2s;
	Thu, 21 Sep 2023 21:41:26 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjRQI-007DR9-3A
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 21:41:25 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjRQF-002ZkI-Hy; Thu, 21 Sep 2023 21:41:19 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjRQC-001W01-TY; Thu, 21 Sep 2023 22:41:19 +0100
Message-ID: <ac09760c-90fd-2209-a85c-5f33380238fc@cambridgegreys.com>
Date: Thu, 21 Sep 2023 22:41:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v4] um: Enable preemption in UML
To: Richard Weinberger <richard@nod.at>
Cc: linux-um <linux-um@lists.infradead.org>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
 <992345997.66924.1695330124883.JavaMail.zimbra@nod.at>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Organization: Cambridge Greys
In-Reply-To: <992345997.66924.1695330124883.JavaMail.zimbra@nod.at>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_144123_021299_6F028B1B 
X-CRM114-Status: GOOD (  12.78  )
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

T24gMjEvMDkvMjAyMyAyMjowMiwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IC0tLS0tIFVy
c3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPj4gVm9uOiAiYW50b24gaXZhbm92IiA8YW50b24uaXZh
bm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPj4gQW46ICJsaW51eC11bSIgPGxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmc+Cj4+IENDOiAiSm9oYW5uZXMgQmVyZyIgPGpvaGFubmVzQHNpcHNvbHV0
aW9ucy5uZXQ+LCAicmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0PiwgImFudG9uIGl2YW5vdiIKPj4g
PGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4+IEdlc2VuZGV0OiBEb25uZXJzdGFn
LCAyMS4gU2VwdGVtYmVyIDIwMjMgMTc6NTU6MjIKPj4gQmV0cmVmZjogW1BBVENIIHY0XSB1bTog
RW5hYmxlIHByZWVtcHRpb24gaW4gVU1MCj4+IEZyb206IEFudG9uIEl2YW5vdiA8YW50b24uaXZh
bm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPj4KPj4gUHJlZW1wdGlvbiByZXF1aXJlcyBzYXZpbmcv
cmVzdG9yaW5nIEZQVSBzdGF0ZS4gVGhpcyBwYXRjaAo+PiBhZGRzIHN1cHBvcnQgZm9yIGl0IHVz
aW5nIEdDQyBpbnRyaW5zaWNzLgo+IFRoaXMgcGF0Y2ggdHJpZ2dlcnMgaGVyZSB0aGUgZm9sbG93
aW5nIHNwbGF0OgoKQWNrLiBJIHdpbGwgbG9vayBpbnRvIGl0IHRvbW9ycm93LgoKVGhlcmUgd2ls
bCBiZSBwbGFjZXMgd2hlcmUgaXQgd2lsbCBib21iIG91dC4gRi5FLiBJIGFtIGNoYXNpbmcgb25l
IGlzIAp0cmlnZ2VyZWQgYnkgdGhlIE5GUyBzZXJ2ZXIgKGl0IG1heSBiZSB0aGUgc2FtZSBhcyBp
biB0aGlzIHRyYWNlIC0gaXQgCmhhcHBlbnMgYXJvdW5kIHRoZSBlbmQgb2YgdGhlIGluaXRpYWwg
c2V0dXApLgoKQWxsIGluIGFsbCBpdCBsb29rcyBiZXR0ZXIgdGhhbiBJIGV4cGVjdGVkLgoKZGVm
Y29uZmlnICsgdmVjdG9yICsgbmZzIGNsaWVudMKgICsgQ09ORklHX1BSRUVNUFQgLSBJIGhhZCB0
aGUga2VybmVsIApidWlsZCB3aXRob3V0IGFueSBpc3N1ZXMgZnJvbSBhIHNvdXJjZSB0cmVlIG9u
IE5GUyBhbmQgd2l0aCByZWFzb25hYmxlIApwZXJmb3JtYW5jZSB0b28uCgo+IC0tLS0tLS0tLS0t
LVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQo+IFdBUk5JTkc6IENQVTogMCBQSUQ6IDAgYXQgaW5p
dC9tYWluLmM6OTkyIHN0YXJ0X2tlcm5lbCsweDU0MS8weDZiNgo+IEludGVycnVwdHMgd2VyZSBl
bmFibGVkIGVhcmx5Cj4gTW9kdWxlcyBsaW5rZWQgaW46Cj4gQ1BVOiAwIFBJRDogMCBDb21tOiBz
d2FwcGVyIE5vdCB0YWludGVkIDYuNi4wLXJjMi1nYTc0ZDhmODU5MmU1ICMxMjgKPiBTdGFjazoK
PiAgIDYwMzgxYjk0IDAwMDAwMDAxIDYwNGQzZDgwIDYwMDJiNmY2Cj4gICA2MDQ0NGJkZCAwMDAw
MDAwMSA2MDRkM2UyMCA2MDM3ZWNmYQo+ICAgNjA0ZDNkYjAgNjAzODliMmYgNjA0ZDNkYTAgNjAz
ODFiOTQKPiBDYWxsIFRyYWNlOgo+ICAgWzw2MDM4MWI5ND5dID8gX3ByaW50aysweDAvMHg5NAo+
ICAgWzw2MDAyMTJiMT5dIHNob3dfc3RhY2srMHgxM2MvMHgxNGIKPiAgIFs8NjAzODFiOTQ+XSA/
IF9wcmludGsrMHgwLzB4OTQKPiAgIFs8NjAwMmI2ZjY+XSA/IHVtX3NldF9zaWduYWxzKzB4MC8w
eDNmCj4gICBbPDYwMzdlY2ZhPl0gPyBzcHJpbnRmKzB4MC8weDk1Cj4gICBbPDYwMzg5YjJmPl0g
ZHVtcF9zdGFja19sdmwrMHg0ZC8weDVhCj4gICBbPDYwMzgxYjk0Pl0gPyBfcHJpbnRrKzB4MC8w
eDk0Cj4gICBbPDYwMzg5YjU2Pl0gZHVtcF9zdGFjaysweDFhLzB4MWMKPiAgIFs8NjAwMzNlYmM+
XSBfX3dhcm4rMHhkOS8weDEwOQo+ICAgWzw2MDAzM2ZiZD5dIHdhcm5fc2xvd3BhdGhfZm10KzB4
ZDEvMHhkZgo+ICAgWzw2MDAzM2VlYz5dID8gd2Fybl9zbG93cGF0aF9mbXQrMHgwLzB4ZGYKPiAg
IFs8NjAzODFiOTQ+XSA/IF9wcmludGsrMHgwLzB4OTQKPiAgIFs8NjAwNTBlMmM+XSA/IF9fYmxv
Y2tpbmdfbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIrMHgzMy8weDc4Cj4gICBbPDYwMzgxYjk0Pl0g
PyBfcHJpbnRrKzB4MC8weDk0Cj4gICBbPDYwMDUwZTgzPl0gPyBibG9ja2luZ19ub3RpZmllcl9j
aGFpbl9yZWdpc3RlcisweDEyLzB4MTQKPiAgIFs8NjAwNWZhOTI+XSA/IHJlZ2lzdGVyX3BtX25v
dGlmaWVyKzB4MWQvMHgxZgo+ICAgWzw2MDAxNTJjOT5dID8gcmFuZG9tX2luaXQrMHhjMi8weDEy
Ngo+ICAgWzw2MDM4MWI5ND5dID8gX3ByaW50aysweDAvMHg5NAo+ICAgWzw2MDAwMWM0MD5dIHN0
YXJ0X2tlcm5lbCsweDU0MS8weDZiNgo+ICAgWzw2MDA0ZGViMD5dID8gcGFyc2VfYXJncysweDAv
MHgyYjkKPiAgIFs8NjAwMmI2MDk+XSA/IGJsb2NrX3NpZ25hbHMrMHgwLzB4MTYKPiAgIFs8NjAw
MDNiOWQ+XSBzdGFydF9rZXJuZWxfcHJvYysweDQ5LzB4NGQKPiAgIFs8NjAwNjE4NjM+XSA/IGtt
c2dfZHVtcF9yZWdpc3RlcisweDZkLzB4NzUKPiAgIFs8NjAwMWZmZGI+XSBuZXdfdGhyZWFkX2hh
bmRsZXIrMHg4MS8weGIyCj4gICBbPDYwMDAzYjUyPl0gPyBrbXNnX2R1bXBlcl9zdGRvdXRfaW5p
dCsweDFhLzB4MWMKPiAgIFs8NjAwMjJlNTI+XSB1bWxfZmluaXNoc2V0dXArMHg1NC8weDU5Cj4g
LS0tWyBlbmQgdHJhY2UgMDAwMDAwMDAwMDAwMDAwMCBdLS0tCj4KPiB4ODZfNjQgZGVmY29uZmln
ICsgQ09ORklHX1BSRUVNUFRfVk9MVU5UQVJZPXkKPgo+IFRoYW5rcywKPiAvL3JpY2hhcmQKPgoK
LS0gCkFudG9uIFIuIEl2YW5vdgpDYW1icmlkZ2VncmV5cyBMaW1pdGVkLiBSZWdpc3RlcmVkIGlu
IEVuZ2xhbmQuIENvbXBhbnkgTnVtYmVyIDEwMjczNjYxCmh0dHBzOi8vd3d3LmNhbWJyaWRnZWdy
ZXlzLmNvbS8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
