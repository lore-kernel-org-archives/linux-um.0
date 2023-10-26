Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A7ACC25B48
	for <linux-um@archiver.kernel.org>; Thu, 26 Oct 2023 07:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=zDvGw02RG4z1O702O5zddAzFahy/+N9ndhTL0Ku4Trw=; b=JQ2mYJI3hnmIvG
	i0yJnX6GZi4SgxBlgtpbRepae1Hyl0S6nUltbwm51A1k8C+0rvKR2AM4qJUKRRvLWk7D02inPo1Ik
	pB3y73AQEMweIb2L/2gHm+mm1HY3X4CWMQW3kAAKg0EQel6MqIhUG+U1i7joyTT9fWNYoRVhvD8sS
	0q/JOT8iYVa4w2SpyAnbncfBUgHlKE+Hx4ZzULeLwpscwBEx1TdcLsrvHwaoO3yp0/Ccz5CGgUqpb
	HkV0JN9xm5yBH5/80tKYIqIjm4iYavrSHUrtmsl8XQAtVUr7OEddL2PCh8fGDdNdzKe8g9VJIW+bk
	ZdW02BwYWIubpabaiFsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvuwx-00DrrZ-1B;
	Thu, 26 Oct 2023 07:38:39 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvuwu-00DrqS-0y
	for linux-um@lists.infradead.org;
	Thu, 26 Oct 2023 07:38:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Q7g53B2bTxgZZQeNU6y4V7IOU5C5VxZ8uo0O5A614xk=;
	t=1698305913; x=1699515513; b=p/qRWOTBVB6DJaJgy3QhSLVv8zS4P0OL8qtVoJRtK3if+fU
	fhc03luw9atOg8v88B7UA9qDmx9MFxZCpyEPe1joGsny9lEZZ+8DeOh6JdzHZImAz+1Ol6TmgMqcO
	SdGYl4reqzAVIJT97pqlVtBdd5iTO6/LxAUdNQeSFwjBpu9cFFV7euPjyEO6zlsa9jvc+ZCoH2PHz
	+DmCWQw1nuO1+waInHZj+9RKgbyzNY6b/Xn+XsQNXZoDKPEt/SVtyANsi5SHU682aTl9mJKAz1Ldb
	mMvvqUmYpwMQg/JJDFsEc9A+lAqQW9NEsAjkwoGsTQz0aDPrf22YqxSyp98GK0EA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvuwp-00000003XNX-36DI;
	Thu, 26 Oct 2023 09:38:31 +0200
Message-ID: <39b6458f1214022e8a0d00c5cb70101a41296d74.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: time-travel: fix time corruption
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>, 
	"linux-um@lists.infradead.org"
	 <linux-um@lists.infradead.org>
Date: Thu, 26 Oct 2023 09:38:30 +0200
In-Reply-To: <d3beded8a25acced5905c8f251a5e91d0f514185.camel@axis.com>
References: <20231025224504.7be512cdfeb4.Ia20103ef9899e53311bd671b8cfbca4f057a4668@changeid>
	 <d3beded8a25acced5905c8f251a5e91d0f514185.camel@axis.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_003836_575116_A85B9FB3 
X-CRM114-Status: GOOD (  16.08  )
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

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDA3OjIzICswMDAwLCBWaW5jZW50IFdoaXRjaHVyY2ggd3Jv
dGU6Cj4gPiBAQCAtODM5LDkgKzg2Myw3IEBAIHN0YXRpYyB1NjQgdGltZXJfcmVhZChzdHJ1Y3Qg
Y2xvY2tzb3VyY2UgKmNzKQo+ID4gwqAJCSAqLwo+ID4gwqAJCWlmICghaXJxc19kaXNhYmxlZCgp
ICYmICFpbl9pbnRlcnJ1cHQoKSAmJiAhaW5fc29mdGlycSgpICYmCj4gPiDCoAkJICAgICF0aW1l
X3RyYXZlbF9leHRfd2FpdGluZykKPiA+IC0JCQl0aW1lX3RyYXZlbF91cGRhdGVfdGltZSh0aW1l
X3RyYXZlbF90aW1lICsKPiA+IC0JCQkJCQlUSU1FUl9NVUxUSVBMSUVSLAo+ID4gLQkJCQkJCWZh
bHNlKTsKPiA+ICsJCQl0aW1lX3RyYXZlbF91cGRhdGVfdGltZV9yZWwoVElNRVJfTVVMVElQTElF
Uik7Cj4gPiDCoAkJcmV0dXJuIHRpbWVfdHJhdmVsX3RpbWUgLyBUSU1FUl9NVUxUSVBMSUVSOwo+
ID4gwqAJfQo+IAo+IFRoZSByZWFzb24gSSBoZXNpdGF0ZWQgd2l0aCBwdXR0aW5nIHRoZSB3aG9s
ZSBvZgo+IHRpbWVfdHJhdmVsX3VwZGF0ZV90aW1lKCkgdW5kZXIgbG9jYWxfaXJxX3NhdmUoKSBp
biBteSBhdHRlbXB0IHdhcwo+IGJlY2F1c2UgSSBkaWRuJ3QgcXVpdGUgdW5kZXJzdGFuZCB0aGUg
cmVhc29uIGZvciB0aGUgIWlycXNfZGlzYWJsZWQoKQo+IGNvbmRpdGlvbiBoZXJlIGFuZCB0aGUg
Y29tbWVudCBqdXN0IGFib3ZlIGl0IGFib3V0IHJlY3Vyc2lvbiBhbmQgdGhpbmdzCj4gZ2V0dGlu
ZyBtZXNzZWQgdXAuICBJZiBpdCdzIE9LIHRvIGRpc2FibGUgaW50ZXJydXB0cyBhcyB0aGlzIHBh
dGNoIGRvZXMsCj4gaXMgdGhlICFpcnFzX2Rpc2FibGVkKCkgY29uZGl0aW9uIHZhbGlkPwoKSG1t
LiBJIHdhcyBnb2luZyB0byBzYXkgdGhhdCdzIGRpZmZlcmVudCwgYmVjYXVzZSBpdCB3YW50cyB0
byBvbmx5CnByZXZlbnQgdXMgZnJvbSBkb2luZyB0aGlzIHdoaWxlIHdlJ3JlICphbHJlYWR5KiBp
biBJUlEgY29udGV4dCwgYW5kIHRoZQpidWcgeW91IGZvdW5kIGlzIGNhbGxpbmcgdGltZXJfcmVh
ZCgpIG5vdCBpbiBJUlEgY29udGV4dCwgYnV0IGdldHRpbmcgYW4KZXZlbnQgcXVldWVkIGJ5IHRo
ZSBzaWduYWwuCgpCdXQgLi4uIG5vdyB0aGF0IEkgdGhpbmsgYWJvdXQgaXQsIEkgaGF2ZSBhIGZl
ZWxpbmcgdGhhdCB0aGlzIHdhcyBhCndvcmthcm91bmQgZm9yIHRoZSBleGFjdCBzYW1lIHByb2Js
ZW0sIGFuZCBJIGp1c3QgZGlkbid0IHVuZGVyc3RhbmQgaXQKYXQgdGhlIHRpbWU/IEkgbWVhbiwg
cmVjdXJzaW5nIGludG8gb3VyIG93biBwcm9jZXNzaW5nIGlzIG5vdyBpbXBvc3NpYmxlCmhlcmUg
YWZ0ZXIgdGhpcyBwYXRjaCAtIGVpdGhlciB3ZSdyZSBydW5uaW5nIG5vcm1hbGx5LCBvciB0aGUg
aW50ZXJydXB0CmNhbm5vdCBoaXQgdGltZXJfcmVhZCgpIGluIHRoZSBtaWRkbGUsIHNhbWUgYXMg
aXQgY2Fubm90IGhpdAp0aW1lX3RyYXZlbF9oYW5kbGVfcmVhbF9hbGFybSgpIGluIHRoZSBtaWRk
bGUgbm93LgoKUmVtb3ZpbmcgdGhhdCBzdGlsbCBzZWVtcyB0byB3b3JrIHdpdGggeW91ciB0ZXN0
LCBidXQgaXQncyBhbHNvIG5vdCBhCmdvb2QgdGVzdCBmb3IgdGhpcywgc2luY2UgdGhlcmUgYXJl
IG5vIGRldmljZXMgZXRjLiB0aGF0IGNvdWxkIGhhdmUKaW50ZXJydXB0cywgbm90IHN1cmUgaG93
IHRvIHRlc3QgaXQgcmlnaHQgbm93PwoKTWF5YmUgSSdsbCBhZGQgYSBjb21tZW50IHRoZXJlIHNh
eWluZyB0aGlzIG1pZ2h0IG5vIGxvbmdlciBiZSBuZWVkZWQ/Cgpqb2hhbm5lcwoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
