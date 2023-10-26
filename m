Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4BF5BC25B48
	for <linux-um@archiver.kernel.org>; Thu, 26 Oct 2023 09:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=nvx5uwt1nIZPGv/R2pUIbyizoNRPpbySHNvrq7oUZng=; b=N/y6+9DHJAzAG8
	5AxGgjIfGm7oyFNx5aQO6Mi/wPKQINQ5/w0KILJqUfU3lwGGkMZRLIRth3o9Pv+BfI6FF8Hf0pRGR
	sb6RM+yFsEvYaNu9IfwefsuOIpbhbo87g13v7OxiH0EBDs5xZk2IpKqUOhw1BEQLFENRbhxTfmFIU
	yJTrQlQ7tsfZz1o+MKbwz7y7T+VEIWslEx/qRWE+bODr2EMkB5jd0k5xH0pYQHrG2vyHNnuffTc7h
	Vfpdgf8ZksyKyX5SFc8JTwv0WJezGSPeRwLr6DM/RQQEK8TiygDgvpxDZ5rBK0fSZql4PdbFxvsKn
	0UboRnzrCeBMCviqOq2A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qvwNZ-00E2z2-16;
	Thu, 26 Oct 2023 09:10:13 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qvwNW-00E2y0-0S
	for linux-um@lists.infradead.org;
	Thu, 26 Oct 2023 09:10:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=pkpRkhrnUDMQQDvLnnZKdZgVQJGQrSRTEUN5+bnqErk=;
	t=1698311406; x=1699521006; b=eXStVjJfyieKiKx+eVIpjX5ezKJ32m2gL3Y9r5gSjyPR2a4
	KORXv9m+ZHXcyiP0QqRrzothbngHtDgGYSsaTLw3UvPSBzRod8WoIdDFwQMg9LNYuqn+oPcAzy0f0
	Qkw887m5NtmPnl7IzNH701TaC4RaGcXe3Xakf/WliEAIV2yEzf+q0iKmnjUBYEvGCZUyuQcmdG6kM
	rIG1bwtymVuBSOXloh6POL/tvoX9byDccK420NhwCvaaum/B0dB8BXcA/V9ek8SUoN4sL7SwlmRou
	gBuFodmF18+dh7JY89eiP2H3wKfHKrSqNAcW5IpTjz7MbbF1LhwWM02eyAUZ43AA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97-RC1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1qvwNQ-00000003ZJA-1WGl;
	Thu, 26 Oct 2023 11:10:04 +0200
Message-ID: <a2a6c524ddb897d3c3b640d0f7262b506e51d983.camel@sipsolutions.net>
Subject: Re: [PATCH v2] um: time-travel: fix time corruption
From: Johannes Berg <johannes@sipsolutions.net>
To: Vincent Whitchurch <Vincent.Whitchurch@axis.com>, 
	"linux-um@lists.infradead.org"
	 <linux-um@lists.infradead.org>
Date: Thu, 26 Oct 2023 11:10:03 +0200
In-Reply-To: <04afd005c5566fcc6a46549afd7b9136a7cec7a9.camel@axis.com>
References: <20231025224504.7be512cdfeb4.Ia20103ef9899e53311bd671b8cfbca4f057a4668@changeid>
	 <d3beded8a25acced5905c8f251a5e91d0f514185.camel@axis.com>
	 <39b6458f1214022e8a0d00c5cb70101a41296d74.camel@sipsolutions.net>
	 <04afd005c5566fcc6a46549afd7b9136a7cec7a9.camel@axis.com>
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231026_021010_205682_E1D9E00F 
X-CRM114-Status: GOOD (  27.45  )
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

T24gVGh1LCAyMDIzLTEwLTI2IGF0IDA4OjQ5ICswMDAwLCBWaW5jZW50IFdoaXRjaHVyY2ggd3Jv
dGU6Cj4gT24gVGh1LCAyMDIzLTEwLTI2IGF0IDA5OjM4ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdy
b3RlOgo+ID4gT24gVGh1LCAyMDIzLTEwLTI2IGF0IDA3OjIzICswMDAwLCBWaW5jZW50IFdoaXRj
aHVyY2ggd3JvdGU6Cj4gPiA+ID4gQEAgLTgzOSw5ICs4NjMsNyBAQCBzdGF0aWMgdTY0IHRpbWVy
X3JlYWQoc3RydWN0IGNsb2Nrc291cmNlICpjcykKPiA+ID4gPiDCoAkJICovCj4gPiA+ID4gwqAJ
CWlmICghaXJxc19kaXNhYmxlZCgpICYmICFpbl9pbnRlcnJ1cHQoKSAmJiAhaW5fc29mdGlycSgp
ICYmCj4gPiA+ID4gwqAJCSAgICAhdGltZV90cmF2ZWxfZXh0X3dhaXRpbmcpCj4gPiA+ID4gLQkJ
CXRpbWVfdHJhdmVsX3VwZGF0ZV90aW1lKHRpbWVfdHJhdmVsX3RpbWUgKwo+ID4gPiA+IC0JCQkJ
CQlUSU1FUl9NVUxUSVBMSUVSLAo+ID4gPiA+IC0JCQkJCQlmYWxzZSk7Cj4gPiA+ID4gKwkJCXRp
bWVfdHJhdmVsX3VwZGF0ZV90aW1lX3JlbChUSU1FUl9NVUxUSVBMSUVSKTsKPiA+ID4gPiDCoAkJ
cmV0dXJuIHRpbWVfdHJhdmVsX3RpbWUgLyBUSU1FUl9NVUxUSVBMSUVSOwo+ID4gPiA+IMKgCX0K
PiA+ID4gCj4gPiA+IFRoZSByZWFzb24gSSBoZXNpdGF0ZWQgd2l0aCBwdXR0aW5nIHRoZSB3aG9s
ZSBvZgo+ID4gPiB0aW1lX3RyYXZlbF91cGRhdGVfdGltZSgpIHVuZGVyIGxvY2FsX2lycV9zYXZl
KCkgaW4gbXkgYXR0ZW1wdCB3YXMKPiA+ID4gYmVjYXVzZSBJIGRpZG4ndCBxdWl0ZSB1bmRlcnN0
YW5kIHRoZSByZWFzb24gZm9yIHRoZSAhaXJxc19kaXNhYmxlZCgpCj4gPiA+IGNvbmRpdGlvbiBo
ZXJlIGFuZCB0aGUgY29tbWVudCBqdXN0IGFib3ZlIGl0IGFib3V0IHJlY3Vyc2lvbiBhbmQgdGhp
bmdzCj4gPiA+IGdldHRpbmcgbWVzc2VkIHVwLiAgSWYgaXQncyBPSyB0byBkaXNhYmxlIGludGVy
cnVwdHMgYXMgdGhpcyBwYXRjaCBkb2VzLAo+ID4gPiBpcyB0aGUgIWlycXNfZGlzYWJsZWQoKSBj
b25kaXRpb24gdmFsaWQ/Cj4gPiAKPiA+IEhtbS4gSSB3YXMgZ29pbmcgdG8gc2F5IHRoYXQncyBk
aWZmZXJlbnQsIGJlY2F1c2UgaXQgd2FudHMgdG8gb25seQo+ID4gcHJldmVudCB1cyBmcm9tIGRv
aW5nIHRoaXMgd2hpbGUgd2UncmUgKmFscmVhZHkqIGluIElSUSBjb250ZXh0LCBhbmQgdGhlCj4g
PiBidWcgeW91IGZvdW5kIGlzIGNhbGxpbmcgdGltZXJfcmVhZCgpIG5vdCBpbiBJUlEgY29udGV4
dCwgYnV0IGdldHRpbmcgYW4KPiA+IGV2ZW50IHF1ZXVlZCBieSB0aGUgc2lnbmFsLgo+ID4gCj4g
PiBCdXQgLi4uIG5vdyB0aGF0IEkgdGhpbmsgYWJvdXQgaXQsIEkgaGF2ZSBhIGZlZWxpbmcgdGhh
dCB0aGlzIHdhcyBhCj4gPiB3b3JrYXJvdW5kIGZvciB0aGUgZXhhY3Qgc2FtZSBwcm9ibGVtLCBh
bmQgSSBqdXN0IGRpZG4ndCB1bmRlcnN0YW5kIGl0Cj4gPiBhdCB0aGUgdGltZT8gSSBtZWFuLCBy
ZWN1cnNpbmcgaW50byBvdXIgb3duIHByb2Nlc3NpbmcgaXMgbm93IGltcG9zc2libGUKPiA+IGhl
cmUgYWZ0ZXIgdGhpcyBwYXRjaCAtIGVpdGhlciB3ZSdyZSBydW5uaW5nIG5vcm1hbGx5LCBvciB0
aGUgaW50ZXJydXB0Cj4gPiBjYW5ub3QgaGl0IHRpbWVyX3JlYWQoKSBpbiB0aGUgbWlkZGxlLCBz
YW1lIGFzIGl0IGNhbm5vdCBoaXQKPiA+IHRpbWVfdHJhdmVsX2hhbmRsZV9yZWFsX2FsYXJtKCkg
aW4gdGhlIG1pZGRsZSBub3cuCj4gPiAKPiA+IFJlbW92aW5nIHRoYXQgc3RpbGwgc2VlbXMgdG8g
d29yayB3aXRoIHlvdXIgdGVzdCwgYnV0IGl0J3MgYWxzbyBub3QgYQo+ID4gZ29vZCB0ZXN0IGZv
ciB0aGlzLCBzaW5jZSB0aGVyZSBhcmUgbm8gZGV2aWNlcyBldGMuIHRoYXQgY291bGQgaGF2ZQo+
ID4gaW50ZXJydXB0cywgbm90IHN1cmUgaG93IHRvIHRlc3QgaXQgcmlnaHQgbm93Pwo+ID4gCj4g
PiBNYXliZSBJJ2xsIGFkZCBhIGNvbW1lbnQgdGhlcmUgc2F5aW5nIHRoaXMgbWlnaHQgbm8gbG9u
Z2VyIGJlIG5lZWRlZD8KPiAKPiBJIHRyaWVkIHJlbW92aW5nIHRoZSAhaXJxc19kaXNhYmxlZCgp
IGNoZWNrIGFuZCB0aGF0IGJsZXcgdXAgcHJldHR5Cj4gcXVpY2tseSAoYmVsb3cpIHdoZW4gcnVu
bmluZyB0aGUgZnVsbCByb2FkdGVzdCBzdWl0ZS4gIEl0IHdvcmtzIGZpbmUKPiB3aXRoIHlvdXIg
dW5tb2RpZmllZCBwYXRjaCBzbyBubyBuZWVkIHRvIGNoYW5nZSB0aGUgY29tbWVudC4KPiAKCkhh
aCwgT0suIFNvIG1heWJlIHdoZW4vaWYgSSByZW1lbWJlciB3aGF0IGhhcHBlbnMgdGhlcmUgb3Ig
Y2FuIGZpZ3VyZSBpdApvdXQgYWdhaW4sIEkgY2FuIHVwZGF0ZSB0aGUgY29tbWVudCA6KQoKam9o
YW5uZXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxp
bnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
