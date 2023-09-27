Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A33E3E810B2
	for <linux-um@archiver.kernel.org>; Wed, 27 Sep 2023 09:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fAzp+ZCFafOy5/nxA+Zo+CBI0ly9mn2j+Nar0chtwmg=; b=xnD1w2EGQpmQfB
	p2mp5gwCSorKsEgCrXXNi9rdL1hFL/FX8EH4+aaiUE/aUmwU8QWVDOhMAFVokdLJh8cVAlJBt43mK
	JYYeSj+D9fyQlD8ib/ataHpi1MC5gXTxIOXHTRmBDgAXAR1+HNfEPPj4ptOjb1junVtttzlG8VflX
	afO5hOcNc37WodQ91AsNrCjtI8eXTIC21Ccj2yRuqZ5X3F6HSaPvsPaka2PPgXUKvKXjSf0U8Iffa
	n8YJh9Y+5mHTJV4HEPjw8aYqS4uLNVGtgAwNPOjbUlQRDVBQ5tvpOSqCnTPXOxUm6DyrVPpkiV5Ut
	Y2Fuy7CR7nJV69sZWH0w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlRDf-000XGW-10;
	Wed, 27 Sep 2023 09:52:35 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlRDb-000XEZ-2P
	for linux-um@lists.infradead.org;
	Wed, 27 Sep 2023 09:52:33 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qDZQNcuZqFBs8yBD7d4gW3Eh0vZfw7pAKxfbDGn6BQo=;
	t=1695808344; x=1697017944; b=kVysnOg2lJz2k276w+o2CqKkQUx2ZGHqRZISnfAIyQW+OxO
	o2QFEXZSyoGodQjeUuXhJ3Uik2VFs1ljN44hXD1JRHHFDTVMhGc0R/VkltsXJGoHLbPBDX4rYWWge
	GK4Zz9rJQb8NDACCMtWNKbI3zFYzmrVM/xMiGgpA4ytR9BthYe29VshTsAWt9W4cIGa8D/jUVzBHw
	HvPSkPihbyNutMOdSQrobSTX2Lcr5blUQ1LyjTUklrWAbV77mGXF6A81taDh5cGVUfv0V4F9peCxR
	cJ4NK3qh6dLCqhGWg6klW5wnMJoy4hkylOK9IMyLIj5TU80PmNwrVXtBqEML5/Wg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qlRDO-007T3p-2W;
	Wed, 27 Sep 2023 11:52:18 +0200
Message-ID: <300c0b28952b2837efbb5c59f38944b02b7722f2.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>, Anton Ivanov
	 <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org
Date: Wed, 27 Sep 2023 11:52:16 +0200
In-Reply-To: <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
	 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
	 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
	 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
	 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
	 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
	 <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
	 <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_025232_001290_EB4E51C5 
X-CRM114-Status: GOOD (  29.64  )
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

SGksCgpPbiBUdWUsIDIwMjMtMDktMjYgYXQgMTQ6MzggKzAyMDAsIEpvaGFubmVzIEJlcmcgd3Jv
dGU6Cj4gW1NOSVBdCj4gMS4gU3RhcnQgZnJvbSBzY3JhdGNoLCB3aXRob3V0IGNvcHlpbmcsIHdo
aWNoIG15IG90aGVyIHBhdGNoIFsxXSBkaWQuCgpJIHJlYWxseSB0aGluayB3ZSBzaG91bGQgZ28g
YWhlYWQgd2l0aCB0aGF0IGFwcHJvYWNoLiBUaGVuIGZvbGxvdyB1cAp3aXRoIG9wdGltaXphdGlv
bnMuCgo+IFtTTklQXQo+IAo+IEkgdGhpbmsgdGhlIGJldHRlciBhcHByb2FjaCBmb3IgY29ycmVj
dG5lc3MgYW5kIGludGVncmF0aW9uIGludG8gdGhlCj4ga2VybmVsIHdvdWxkIGJlIHRvIGFjdHVh
bGx5IGFkbWl0IHRoYXQgVU1MIGlzIHNwZWNpYWwgYmVjYXVzZSBwYWdlCj4gZmF1bHRzIGFyZSBz
byBleHBlbnNpdmUsIGFuZAo+IAo+IMKgKiBzdGFydCB3aXRoIGEgZnJlc2ggbW0gcHJvY2VzcyBl
dmVyeSB0aW1lCj4gwqAqIGhhdmUgdm1hX25lZWRzX2NvcHkoKSByZXR1cm4gdHJ1ZQo+IMKgKiBj
b21wbGV0ZWx5IGZpbGwgdGhlIG1hcHBpbmdzIGFjY29yZGluZyB0byBvbmx5IHRoZSBuZXcgbW0n
cyBWTUFzCj4gwqDCoCBpbiBhcmNoX2R1cF9tbWFwKCkgb3IgcGVyaGFwcyBsYXRlcgo+IAo+IEkg
ZG9uJ3Qga25vdyBob3cgdGhhdCdkIGJlaGF2ZSB3cnQuIHBlcmZvcm1hbmNlLCB0aG91Z2ggaXQg
bGlrZWx5IGNhbm5vdAo+IGJlIGJldHRlciB0aGFuIHdpdGggdGhlc2UgcGF0Y2hlcywgYnV0IGF0
IGxlYXN0IGl0J2QgYmUgbW9yZSBjb3JyZWN0LAo+IGFuZCBtb3JlIG9idmlvdXNseSBjb3JyZWN0
IHRvbywgZm9yIHN0YXJ0ZXJzLCBiZWNhdXNlIHRoZW4gdGhlIGFjdHVhbAo+IG1hcHBpbmdzIGlu
IHRoZSBVTUwgbW0gcHJvY2VzcyB3b3VsZCBhY3R1YWxseSByZWZsZWN0IHRoZSBQVEVzIHRoYXQK
PiBMaW51eCBrbm93cyBhYm91dC4KClllcywgcGVyZm9ybWFuY2UgbWF5IGRlZ3JhZGUsIGJ1dCB0
aGUgaW1wbGVtZW50YXRpb24gc2hvdWxkIGJlIGNvcnJlY3QKaW4gdGhlIGZpcnN0IHBsYWNlLiBO
b3RlIHRoYXQgZXZlbiB0aG91Z2ggd2UgbG9va2VkIGF0IGl0IChhbmQgZS5nLgpmb3VuZCB0aGF0
IE1NQVBfRE9OVEZPUksgaXMgaW5jb3JyZWN0KSwgd2UgaGF2ZSBub3QgZmlndXJlZCBvdXQgd2h5
IHRoZQpmaXJzdCBhcHByb2FjaCBpcyBzbG93ZXIgY3VycmVudGx5IGFzIGV2ZXJ5dGhpbmcgaW50
ZXJlc3Rpbmcgc2hvdWxkIGJlCmdldHRpbmcgdW5tYXBwZWQgYnkgdGhlIGZvcmNlX2ZsdXNoX2Fs
bC4KCk9uY2Ugd2UgYXJlIHRoZXJlLCB3ZSBjYW4gbG9vayBmb3Igb3B0aW1pemF0aW9ucy4gVGhl
IGZ1bmRhbWVudGFsCnByb2JsZW0gaXMgdGhhdCBwYWdlIGZhdWx0cyAoZXZlbiBtaW5vciBvbmVz
KSBhcmUgZXh0cmVtZWx5IGV4cGVuc2l2ZQpmb3IgdXMuCgpKdXN0IHRocm93aW5nIG91dCBpZGVh
cyBvbiB3aGF0IHdlIGNvdWxkIGRvOgogICAxLiBTRUNDT01QIGFzIHRoYXQgcmVkdWNlcyB0aGUg
YW1vdW50IG9mIGNvbnRleHQgc3dpdGNoZXMuCiAgICAgIChZZXMsIEkga25vdyBJIHNob3VsZCBy
ZXN1Ym1pdCB0aGUgcGF0Y2hzZXQpCiAgIDIuIE1heWJlIHdlIGNhbiBkaXNhYmxlL2NyaXBwbGUg
cGFnZSBhY2Nlc3MgdHJhY2tpbmc/IElmIHdlIGFzc3VtZQogICAgICBpbml0aWFsbHkgbWFyayBh
bGwgcGFnZXMgYXMgYWNjZXNzZWQgYnkgdXNlcnNwYWNlIChpLmUuCiAgICAgIHB0ZV9ta3lvdW5n
KSwgdGhlbiB3ZSBhdm9pZCBhIG1pbm9yIHBhZ2UgZmF1bHQgb24gZmlyc3QgYWNjZXNzLgogICAg
ICBEb2luZyB0aGF0IHdpbGwgbWVzcyB3aXRoIHBhZ2UgZXZpY3Rpb24gdGhvdWdoLgogICAzLiBE
byBEQVggKGRpcmVjdF9hY2Nlc3MpIGZvciBmaWxlcy4gaS5lLiBtbWFwIGZpbGVzIGRpcmVjdGx5
IGluIHRoZQogICAgICBob3N0IGtlcm5lbCByYXRoZXIgdGhhbiB0aHJvdWdoIFVNLgogICAgICBX
aXRoIGEgaG9zdGZzIGxpa2UgZmlsZSBzeXN0ZW0sIG9uZSBzaG91bGQgYmUgYWJsZSB0byBhZGQg
YW4KICAgICAgaW50ZXJtZWRpYXRlIGJsb2NrIGRldmljZSB0aGF0IG1hcHMgaG9zdCBmaWxlcyB0
byBwaHlzaWNhbCBwYWdlcywKICAgICAgdGhlbiBkbyBEQVggaW4gdGhlIEZTLgogICAgICBGb3Ig
ZGlzayBpbWFnZXMsIHRoZSBleGlzdGluZyBpb21lbSBpbmZyYXN0cnVjdHVyZSBzaG91bGQgYmUK
ICAgICAgdXNhYmxlLCB0aGlzIHNob3VsZCB3b3JrIHdpdGggYW55IERBWCBlbmFibGVkIGZpbGVz
eXN0ZW1zIChleHQyLAogICAgICBleHQ0LCB4ZnMsIHZpcnRpb2ZzLCBlcm9mcykuCgpCZW5qYW1p
bgoKPiAKPiA+IDIuIFRoZSBwcmVlbXB0aW9uIHBhdGNoZXMgd29yayBmaW5lIG9uIHRvcCAoYWxs
IDMgY2FzZXMpLiBUaGUKPiA+IHBlcmZvcm1hbmNlIGRpZmZlcmVuY2Ugc3RheXMuCj4gCj4gT0su
Cj4gCj4gPiAzLiBXZSBkbyBub3QgaGF2ZSBhbnl0aGluZyBvZiB2YWx1ZSB0byBhZGQgaW4gdGVy
bSBvZgo+ID4gY29uZF9yZXNjaGVkKCkgdG8gdGhlIGRyaXZlcnMgOigKPiA+IE1vc3QgZHJpdmVy
cyBhcmUgZmFpcmx5IHNpbXBsaXN0aWMgd2l0aCBubyBzYWZlIHBvaW50cyB0byBhZGQgdGhpcy4K
PiAKPiBZZWFoLCBub3Qgc3VycHJpc2VkIGJ5IHRoaXMuCj4gCj4gPiA2LiBEbyB3ZSBzdGlsbCBu
ZWVkIGZvcmNlX2ZsdXNoX2FsbCgpIGluIHRoZSBhcmNoX2R1cF9tbWFwKCk/IFRoaXMKPiA+IHdv
cmtzIHdpdGggYSBub24tZm9yY2VkIHRsYiBmbHVzaAo+ID4gdXNpbmcgZmx1c2hfdGxiX21tKG1t
KTsKPiAKPiBNYXliZSBub3QsIGRvZXMgaXQgbWFrZSBhIGRpZmZlcmVuY2UgdGhvdWdoPwo+IAo+
ID4gNy4gSW4gYWxsIGNhc2VzLCBVTUwgaXMgZG9pbmcgc29tZXRoaW5nIHNpbGx5Lgo+ID4gVGhl
IENQVSB1c2FnZSB3aGlsZSBkb2luZyBmaW5kIC10eXBlIGYgLWV4ZWMgY2F0IHt9ID4gL2Rldi9u
dWxsCj4gPiBtZWFzdXJlZCBmcm9tIG91dHNpZGUgaW4gbm9uLXByZWVtcHRpdmUgYW5kCj4gPiBQ
UkVFTVBUX1ZPTFVOVEFSWSBzdGF5cyBhcm91bmQgOC0xNSUuIFRoZSBVTUwgdGFrZXMgYSBzYWJi
YXRpY2FsCj4gPiBmb3IgdGhlIHJlbWFpbmluZyA4NSBpbnN0ZWFkIG9mIGFjdHVhbGx5Cj4gPiBk
b2luZyB3b3JrLiBQUkVFTVBUIGlzIHNsaWdodGx5IGJldHRlciBhdCA2MCwgYnV0IHN0aWxsIGZh
ciBmcm9tCj4gPiAxMDAlLiBJdCBqdXN0IGtlZXBzIGdvaW5nIGludG8gaWRsZSBhbmQgSQo+ID4g
Y2Fubm90IHVuZGVyc3RhbmQgd2h5Lgo+IAo+IElzIGl0IGp1c3Qgd2FpdGluZyBmb3IgSU8/Cj4g
Cj4gam9oYW5uZXMKPiAKPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwo+IGxpbnV4LXVtIG1haWxpbmcgbGlzdAo+IGxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmcKPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXVtCj4gCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=
