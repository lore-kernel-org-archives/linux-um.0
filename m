Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C4ADCD4F2B
	for <linux-um@archiver.kernel.org>; Fri, 22 Sep 2023 07:29:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=pZ0QBJ4nyz2bqtuKuSgK8Ls2AYkAK8JAnPxsSZPg27Q=; b=2hse5L4+FL1q0P
	1hXLTdSr5sh3GjWtNR9mKEWh/IrorvL/oFlI9x27J1m8hgRaU0PFsXuMWPUQNkVR+LmY/WmCypsPl
	SDX1G9esI3abxfOQJfSHwoTJpi2hXtTS9nUKvmCM5sM+nVfRl1kVH2jS6RpYeWvkMce4eQgIdHVhU
	827xbrrsq77/HTBDLhLewdh0Q6cOfqZbmo9+6JT9iuJ+4U9Vf+WUwImmqi6oTgN5RlQI3Jun4xzIb
	DpenWW/nJw2VLmDN83AgGNImg7Y8FkdWyRa3hI1ZlgaJdo2U5JxAZrIxbOgVZnVUM4MmKCCKCCfut
	NIaQsRaCbfZpAPCD+KEA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjabf-008C6w-0S;
	Fri, 22 Sep 2023 07:29:43 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjabc-008C6Q-1E
	for linux-um@lists.infradead.org;
	Fri, 22 Sep 2023 07:29:41 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjaba-002b3E-Ih; Fri, 22 Sep 2023 07:29:38 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjabX-0024SV-VE; Fri, 22 Sep 2023 08:29:38 +0100
Message-ID: <08f8c6f6-d6c2-4d05-f22f-fb5effd98be6@cambridgegreys.com>
Date: Fri, 22 Sep 2023 08:29:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5] um: Enable preemption in UML
Content-Language: en-US
To: Richard Weinberger <richard@nod.at>
Cc: linux-um <linux-um@lists.infradead.org>,
 Johannes Berg <johannes@sipsolutions.net>
References: <20230922065212.484385-1-anton.ivanov@cambridgegreys.com>
 <1938743835.68560.1695367643504.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <1938743835.68560.1695367643504.JavaMail.zimbra@nod.at>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230922_002940_435351_21B7D14D 
X-CRM114-Status: GOOD (  13.75  )
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

Ck9uIDIyLzA5LzIwMjMgMDg6MjcsIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToKPiAtLS0tLSBV
cnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4+IFZvbjogImFudG9uIGl2YW5vdiIgPGFudG9uLml2
YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4+IEFuOiAibGludXgtdW0iIDxsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnPgo+PiBDQzogIkpvaGFubmVzIEJlcmciIDxqb2hhbm5lc0BzaXBzb2x1
dGlvbnMubmV0PiwgInJpY2hhcmQiIDxyaWNoYXJkQG5vZC5hdD4sICJhbnRvbiBpdmFub3YiCj4+
IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+PiBHZXNlbmRldDogRnJlaXRhZywg
MjIuIFNlcHRlbWJlciAyMDIzIDA4OjUyOjEyCj4+IEJldHJlZmY6IFtQQVRDSCB2NV0gdW06IEVu
YWJsZSBwcmVlbXB0aW9uIGluIFVNTAo+PiBGcm9tOiBBbnRvbiBJdmFub3YgPGFudG9uLml2YW5v
dkBjYW1icmlkZ2VncmV5cy5jb20+Cj4+Cj4+IFByZWVtcHRpb24gcmVxdWlyZXMgc2F2aW5nL3Jl
c3RvcmluZyBGUFUgc3RhdGUuIFRoaXMgcGF0Y2gKPj4gYWRkcyBzdXBwb3J0IGZvciBpdCB1c2lu
ZyBHQ0MgaW50cmluc2ljcy4KPiBDYW4geW91IHBsZWFzZSBzdGF0ZSBpbiBmdXR1cmUgcGF0Y2hl
cyB3aGF0IHlvdSBoYXZlIGNoYW5nZWQgc2luY2UgdGhlIGxhc3Qgb25lPwoKQWNrLiBTb3JyeS4K
ClRoaXMgb25lIGFkZHMgZ3VhcmRzIGFyb3VuZCB0aGUgY3JpdGljYWwgc2VjdGlvbnMgaW4gdGhl
IFRMQi4KCkFzIGEgcmVzdWx0IEkgbm8gbG9uZ2VyIHNlZSBhbnkgYmFyZnMgb24gc3RhcnR1cCBp
biB0aGUgY29uZmlndXJhdGlvbiB3aGVyZSBJIHdhcyBvYnNlcnZpbmcgdGhlbSAobmZzIGtlcm5l
bCBzZXJ2ZXIpLgoKQm90aCBwcmVlbXB0IGFuZCB2b2x1bnRhcnkgbm93IGJvb3Qgd2l0aG91dCBp
c3N1ZXMgaW4gdGhhdCBjb25maWcuCgo+ICAgCj4+IFNpZ25lZC1vZmYtYnk6IEFudG9uIEl2YW5v
diA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPj4gZGlmZiAtLWdpdCBhL2FyY2gv
dW0va2VybmVsL3RsYi5jIGIvYXJjaC91bS9rZXJuZWwvdGxiLmMKPj4gaW5kZXggN2QwNTBhYjBm
NzhhLi4zNGVjOGU2NzdmYjkgMTAwNjQ0Cj4+IC0tLSBhL2FyY2gvdW0va2VybmVsL3RsYi5jCj4+
ICsrKyBiL2FyY2gvdW0va2VybmVsL3RsYi5jCj4+IEBAIC0zNjIsNiArMzYyLDkgQEAgc3RhdGlj
IGludCBmbHVzaF90bGJfa2VybmVsX3JhbmdlX2NvbW1vbih1bnNpZ25lZCBsb25nCj4+IHN0YXJ0
LCB1bnNpZ25lZCBsb25nIGVuZCkKPj4KPj4gCW1tID0gJmluaXRfbW07Cj4+IAlodmMgPSBJTklU
X0hWQyhtbSwgZm9yY2UsIHVzZXJzcGFjZSk7Cj4+ICsKPj4gKyAgICBwcmVlbXB0X2Rpc2FibGUo
KTsKPj4gKwo+IERvZXMgdGhpcyBhZGRyZXNzIHRoZSBib290dXAgc3BsYXQgSSd2ZSByZXBvcnRl
ZCB5ZXN0ZXJkYXk/Cj4KPgo+IFRoYW5rcywKPiAvL3JpY2hhcmQKPgotLSAKQW50b24gUi4gSXZh
bm92CkNhbWJyaWRnZWdyZXlzIExpbWl0ZWQuIFJlZ2lzdGVyZWQgaW4gRW5nbGFuZC4gQ29tcGFu
eSBOdW1iZXIgMTAyNzM2NjEKaHR0cHM6Ly93d3cuY2FtYnJpZGdlZ3JleXMuY29tLwoKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxp
bmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRl
YWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
