Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4BCDE7D0AB
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 21:02:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Subject:References:
	In-Reply-To:Message-ID:Cc:To:From:Date:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=40GZ8X7r7NctpWZ439KKo5tITcp8y+MH3QaBcVV++Fg=; b=nzQusCLemaKAXLdWG9YAtpYrUq
	azxv67x4IWWFANJD0wpYmzaiAwZheveGQI2YLcANJGhKSSzOkUTR/Nx0ahyb9p7RRnjFbOIGRB9eW
	Oh5uO0PvCiguoYjcCd1GugUgNI3KvgeSbyOOq6zhRDAPqZ4r/q4W/3MzxepjCt8n2Vn8UT6sH9hBF
	4OEmwcoss7DhTsKAvTMb75E5osa63I8UbK3i1WF9YmlblQKSsMzi+q+38jUWKVgALpcyT4AIriB4c
	UTxHav1OTNCsehTLM6qgPmu8tsJj/sCOoDdexMCf0kry+d2Ggm3r7++7n3eyDHn0OUyfOnkdTBl1W
	Wn7gPlig==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjQoS-00795m-0k;
	Thu, 21 Sep 2023 21:02:16 +0000
Received: from lithops.sigma-star.at ([195.201.40.130])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjQoP-00793y-0E
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 21:02:14 +0000
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 64401622F589;
	Thu, 21 Sep 2023 23:02:06 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
	with ESMTP id pC3oIc6GVz-n; Thu, 21 Sep 2023 23:02:05 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
	by lithops.sigma-star.at (Postfix) with ESMTP id 53415622F59F;
	Thu, 21 Sep 2023 23:02:05 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
	by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id 9E3e4zO1iBXj; Thu, 21 Sep 2023 23:02:05 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
	by lithops.sigma-star.at (Postfix) with ESMTP id 2763B622F589;
	Thu, 21 Sep 2023 23:02:05 +0200 (CEST)
Date: Thu, 21 Sep 2023 23:02:04 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>, 
	Johannes Berg <johannes@sipsolutions.net>
Message-ID: <992345997.66924.1695330124883.JavaMail.zimbra@nod.at>
In-Reply-To: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
References: <20230921155522.283582-1-anton.ivanov@cambridgegreys.com>
Subject: Re: [PATCH v4] um: Enable preemption in UML
MIME-Version: 1.0
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Enable preemption in UML
Thread-Index: SJXu9nQvwrm4Mbisr8mjrVA6zpm59w==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_140213_284415_3A1DE5EC 
X-CRM114-Status: UNSURE (   5.13  )
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
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQW46ICJsaW51eC11bSIgPGxpbnV4LXVt
QGxpc3RzLmluZnJhZGVhZC5vcmc+Cj4gQ0M6ICJKb2hhbm5lcyBCZXJnIiA8am9oYW5uZXNAc2lw
c29sdXRpb25zLm5ldD4sICJyaWNoYXJkIiA8cmljaGFyZEBub2QuYXQ+LCAiYW50b24gaXZhbm92
Igo+IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+IEdlc2VuZGV0OiBEb25uZXJz
dGFnLCAyMS4gU2VwdGVtYmVyIDIwMjMgMTc6NTU6MjIKPiBCZXRyZWZmOiBbUEFUQ0ggdjRdIHVt
OiBFbmFibGUgcHJlZW1wdGlvbiBpbiBVTUwKCj4gRnJvbTogQW50b24gSXZhbm92IDxhbnRvbi5p
dmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+IAo+IFByZWVtcHRpb24gcmVxdWlyZXMgc2F2aW5n
L3Jlc3RvcmluZyBGUFUgc3RhdGUuIFRoaXMgcGF0Y2gKPiBhZGRzIHN1cHBvcnQgZm9yIGl0IHVz
aW5nIEdDQyBpbnRyaW5zaWNzLgoKVGhpcyBwYXRjaCB0cmlnZ2VycyBoZXJlIHRoZSBmb2xsb3dp
bmcgc3BsYXQ6Ci0tLS0tLS0tLS0tLVsgY3V0IGhlcmUgXS0tLS0tLS0tLS0tLQpXQVJOSU5HOiBD
UFU6IDAgUElEOiAwIGF0IGluaXQvbWFpbi5jOjk5MiBzdGFydF9rZXJuZWwrMHg1NDEvMHg2YjYK
SW50ZXJydXB0cyB3ZXJlIGVuYWJsZWQgZWFybHkKTW9kdWxlcyBsaW5rZWQgaW46CkNQVTogMCBQ
SUQ6IDAgQ29tbTogc3dhcHBlciBOb3QgdGFpbnRlZCA2LjYuMC1yYzItZ2E3NGQ4Zjg1OTJlNSAj
MTI4ClN0YWNrOgogNjAzODFiOTQgMDAwMDAwMDEgNjA0ZDNkODAgNjAwMmI2ZjYKIDYwNDQ0YmRk
IDAwMDAwMDAxIDYwNGQzZTIwIDYwMzdlY2ZhCiA2MDRkM2RiMCA2MDM4OWIyZiA2MDRkM2RhMCA2
MDM4MWI5NApDYWxsIFRyYWNlOgogWzw2MDM4MWI5ND5dID8gX3ByaW50aysweDAvMHg5NAogWzw2
MDAyMTJiMT5dIHNob3dfc3RhY2srMHgxM2MvMHgxNGIKIFs8NjAzODFiOTQ+XSA/IF9wcmludGsr
MHgwLzB4OTQKIFs8NjAwMmI2ZjY+XSA/IHVtX3NldF9zaWduYWxzKzB4MC8weDNmCiBbPDYwMzdl
Y2ZhPl0gPyBzcHJpbnRmKzB4MC8weDk1CiBbPDYwMzg5YjJmPl0gZHVtcF9zdGFja19sdmwrMHg0
ZC8weDVhCiBbPDYwMzgxYjk0Pl0gPyBfcHJpbnRrKzB4MC8weDk0CiBbPDYwMzg5YjU2Pl0gZHVt
cF9zdGFjaysweDFhLzB4MWMKIFs8NjAwMzNlYmM+XSBfX3dhcm4rMHhkOS8weDEwOQogWzw2MDAz
M2ZiZD5dIHdhcm5fc2xvd3BhdGhfZm10KzB4ZDEvMHhkZgogWzw2MDAzM2VlYz5dID8gd2Fybl9z
bG93cGF0aF9mbXQrMHgwLzB4ZGYKIFs8NjAzODFiOTQ+XSA/IF9wcmludGsrMHgwLzB4OTQKIFs8
NjAwNTBlMmM+XSA/IF9fYmxvY2tpbmdfbm90aWZpZXJfY2hhaW5fcmVnaXN0ZXIrMHgzMy8weDc4
CiBbPDYwMzgxYjk0Pl0gPyBfcHJpbnRrKzB4MC8weDk0CiBbPDYwMDUwZTgzPl0gPyBibG9ja2lu
Z19ub3RpZmllcl9jaGFpbl9yZWdpc3RlcisweDEyLzB4MTQKIFs8NjAwNWZhOTI+XSA/IHJlZ2lz
dGVyX3BtX25vdGlmaWVyKzB4MWQvMHgxZgogWzw2MDAxNTJjOT5dID8gcmFuZG9tX2luaXQrMHhj
Mi8weDEyNgogWzw2MDM4MWI5ND5dID8gX3ByaW50aysweDAvMHg5NAogWzw2MDAwMWM0MD5dIHN0
YXJ0X2tlcm5lbCsweDU0MS8weDZiNgogWzw2MDA0ZGViMD5dID8gcGFyc2VfYXJncysweDAvMHgy
YjkKIFs8NjAwMmI2MDk+XSA/IGJsb2NrX3NpZ25hbHMrMHgwLzB4MTYKIFs8NjAwMDNiOWQ+XSBz
dGFydF9rZXJuZWxfcHJvYysweDQ5LzB4NGQKIFs8NjAwNjE4NjM+XSA/IGttc2dfZHVtcF9yZWdp
c3RlcisweDZkLzB4NzUKIFs8NjAwMWZmZGI+XSBuZXdfdGhyZWFkX2hhbmRsZXIrMHg4MS8weGIy
CiBbPDYwMDAzYjUyPl0gPyBrbXNnX2R1bXBlcl9zdGRvdXRfaW5pdCsweDFhLzB4MWMKIFs8NjAw
MjJlNTI+XSB1bWxfZmluaXNoc2V0dXArMHg1NC8weDU5Ci0tLVsgZW5kIHRyYWNlIDAwMDAwMDAw
MDAwMDAwMDAgXS0tLQoKeDg2XzY0IGRlZmNvbmZpZyArIENPTkZJR19QUkVFTVBUX1ZPTFVOVEFS
WT15CgpUaGFua3MsCi8vcmljaGFyZAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJh
ZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC11bQo=
