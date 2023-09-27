Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7719CE810C1
	for <linux-um@archiver.kernel.org>; Wed, 27 Sep 2023 10:42:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Date:To:From:Subject:Message-ID:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=fKIfbwGFUFzdo+QY0oo5cRDH4GyiYOIfKQeV1m2J+9E=; b=slDmZBwrHPZEHZ
	Pge2a20vNw75gIA9LGpAxSqO0A2vhySmlOqBt8kC98pXCT1zTrfVBhIyMGMZUCdNvbh9SjbXn66Z+
	099SwlWxYTrHnYeQqGl4sonxnVJfB6FgdZIHyM1BJeNu9SNx3sUwxB49u4nNDb2d8R2uZ528s+f7e
	sSt+GhkLqFzv3OjFWej4pgy/1aBPMyVjz31xjmePou6iabAYK4SwnnKtU/+9dRalhRDQ1gVK5kVWt
	ddJ4SEEY6zmq0vWs9WeJY7eOEJvOxMzq9mI+LDb0vBFUVH1bdQV7jX4/ZznxJyz0WQeH8EcpfND96
	d6UAdkPkE29K72KAk8Tg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlS03-000kB9-39;
	Wed, 27 Sep 2023 10:42:36 +0000
Received: from s3.sipsolutions.net ([2a01:4f8:242:246e::2] helo=sipsolutions.net)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlS00-000k8E-2P
	for linux-um@lists.infradead.org;
	Wed, 27 Sep 2023 10:42:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rHKUV9jNwFjyuFZBbyOmijjobvmNOuocsHJX3Q1Wdlo=;
	t=1695811352; x=1697020952; b=eEcjvJM5pN+PU3/R2llOKoj1TfMUzZS5nejynZORCpcjJIs
	AVQBZdQUeG0JMBMyKHwoRc9PSiDdbWN6o80JdMFBbgcDlP1zwOTAHZrYZJA0uvNG1MzJDlmhwsQ3i
	iejVGlO5DdpD0gCMrWsXJ5zQfaar0rJWZ2J+/Sp5iqRz54wJAUSLueBX3p+V3Tbf74Mb33qVg0xlW
	3CpN4IdEX+7Pqg1dqHl3F9V/5ULLvk2a+BQXN/7l2Qtv0Tf9pbMGDF0q+aXDdrgIr955NIyWxragK
	iLwvo6qeyx/dT++FpUx129Ehj01txRGqvhQzvDILv5t7VL6W9CPZ7LWnSd3tLesA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.96)
	(envelope-from <benjamin@sipsolutions.net>)
	id 1qlRzv-007WPI-29;
	Wed, 27 Sep 2023 12:42:27 +0200
Message-ID: <54b803469e63dd23d90a70fa2f356124cc230be6.camel@sipsolutions.net>
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
From: Benjamin Berg <benjamin@sipsolutions.net>
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg
	 <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Date: Wed, 27 Sep 2023 12:42:26 +0200
In-Reply-To: <a38bf57b-c11f-7b27-63a3-d5a4bb028819@cambridgegreys.com>
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
	 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
	 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
	 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
	 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
	 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
	 <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
	 <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
	 <300c0b28952b2837efbb5c59f38944b02b7722f2.camel@sipsolutions.net>
	 <a38bf57b-c11f-7b27-63a3-d5a4bb028819@cambridgegreys.com>
User-Agent: Evolution 3.46.4 (3.46.4-1.fc37) 
MIME-Version: 1.0
X-malware-bazaar: not-scanned
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_034232_781118_B8A7EB7C 
X-CRM114-Status: GOOD (  30.19  )
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

SGksCgpPbiBXZWQsIDIwMjMtMDktMjcgYXQgMTA6NTkgKzAxMDAsIEFudG9uIEl2YW5vdiB3cm90
ZToKPiBbU05JUF0KPiAKPiBJIHdhcyBqdXN0IGxvb2tpbmcgYXQgYWxsIHRoZSB3b3JrYXJvdW5k
IHdoaWNoIGFyZSBpbiBwbGFjZSB0bwo+IHByZXZlbnQgZ3Vlc3QgcHJvY2Vzc2VzIGRvaW5nIGEg
c3lzY2FsbCBvbiB0aGUgaG9zdC4gSWYgdGhpcyBpcwo+IHByb2hpYml0ZWQgYXQgYSBoaWdoZXIg
bGV2ZWwgd2Ugc2hvdWxkIGdldCBxdWl0ZSBhIGJvb3N0IGFzIGFsbCB0aGVzZQo+IFBUUkFDRV9Q
RUVLcyB3aWxsIGJlY29tZSB1bm5lY2Vzc2FyeS4KCkFyZSB5b3UgbWF5YmUgbG9va2luZyBhdCB0
aGUgZmFsbGJhY2sgY29kZSBpZiAibG9jYWxfdXNpbmdfc3lzZW11IiBpcwpub3Qgc2V0PyBUaGF0
IGNvZGUgc2hvdWxkIGJlIGRyb3BwZWQgZWl0aGVyIHdheSwgd2UgY2FuIGFzc3VtZQpQVFJBQ0Vf
U1lTRU1VIHN1cHBvcnQgdGhlc2UgZGF5cywgc28gdGhlIGNvZGUgaW4gZS5nLiBoYW5kbGVfdHJh
cCBjYW4KYmUgcmVtb3ZlZC4gSSBoYWQgYSBwYXRjaCBmb3IgdGhhdCBhbHJlYWR5LgoKQmVuamFt
aW4KCj4gCj4gPiDCoMKgwqAgMi4gTWF5YmUgd2UgY2FuIGRpc2FibGUvY3JpcHBsZSBwYWdlIGFj
Y2VzcyB0cmFja2luZz8gSWYgd2UKPiA+IGFzc3VtZQo+ID4gwqDCoMKgwqDCoMKgIGluaXRpYWxs
eSBtYXJrIGFsbCBwYWdlcyBhcyBhY2Nlc3NlZCBieSB1c2Vyc3BhY2UgKGkuZS4KPiA+IMKgwqDC
oMKgwqDCoCBwdGVfbWt5b3VuZyksIHRoZW4gd2UgYXZvaWQgYSBtaW5vciBwYWdlIGZhdWx0IG9u
IGZpcnN0Cj4gPiBhY2Nlc3MuCj4gPiDCoMKgwqDCoMKgwqAgRG9pbmcgdGhhdCB3aWxsIG1lc3Mg
d2l0aCBwYWdlIGV2aWN0aW9uIHRob3VnaC4KPiA+IMKgwqDCoCAzLiBEbyBEQVggKGRpcmVjdF9h
Y2Nlc3MpIGZvciBmaWxlcy4gaS5lLiBtbWFwIGZpbGVzIGRpcmVjdGx5Cj4gPiBpbiB0aGUKPiA+
IMKgwqDCoMKgwqDCoCBob3N0IGtlcm5lbCByYXRoZXIgdGhhbiB0aHJvdWdoIFVNLgo+ID4gwqDC
oMKgwqDCoMKgIFdpdGggYSBob3N0ZnMgbGlrZSBmaWxlIHN5c3RlbSwgb25lIHNob3VsZCBiZSBh
YmxlIHRvIGFkZCBhbgo+ID4gwqDCoMKgwqDCoMKgIGludGVybWVkaWF0ZSBibG9jayBkZXZpY2Ug
dGhhdCBtYXBzIGhvc3QgZmlsZXMgdG8gcGh5c2ljYWwKPiA+IHBhZ2VzLAo+ID4gwqDCoMKgwqDC
oMKgIHRoZW4gZG8gREFYIGluIHRoZSBGUy4KPiA+IMKgwqDCoMKgwqDCoCBGb3IgZGlzayBpbWFn
ZXMsIHRoZSBleGlzdGluZyBpb21lbSBpbmZyYXN0cnVjdHVyZSBzaG91bGQgYmUKPiA+IMKgwqDC
oMKgwqDCoCB1c2FibGUsIHRoaXMgc2hvdWxkIHdvcmsgd2l0aCBhbnkgREFYIGVuYWJsZWQgZmls
ZXN5c3RlbXMKPiA+IChleHQyLAo+ID4gwqDCoMKgwqDCoMKgIGV4dDQsIHhmcywgdmlydGlvZnMs
IGVyb2ZzKS4KPiAKPiBJIGhhZCBzb21lIHBsYW5zIHRvIGRvIGEgdWJkIGdlbiAyIHdoaWNoIHVz
ZXMgbW1hcCBhbmQvb3IgdGhpcy4gVGhleQo+IGFyZQo+IHByZXNlbnRseSB3YXkgb24gdGhlIGJh
Y2tidXJuZXIuIFdlIGNhbiBkbyBzb21lIG9mIHRoYXQgb25jZSB3ZSBwdXNoCj4gdGhlIG5ldyBW
TSBjaGFuZ2VzLgo+IAo+ID4gCj4gPiBCZW5qYW1pbgo+ID4gCj4gPiA+IAo+ID4gPiA+IDIuIFRo
ZSBwcmVlbXB0aW9uIHBhdGNoZXMgd29yayBmaW5lIG9uIHRvcCAoYWxsIDMgY2FzZXMpLiBUaGUK
PiA+ID4gPiBwZXJmb3JtYW5jZSBkaWZmZXJlbmNlIHN0YXlzLgo+ID4gPiAKPiA+ID4gT0suCj4g
PiA+IAo+ID4gPiA+IDMuIFdlIGRvIG5vdCBoYXZlIGFueXRoaW5nIG9mIHZhbHVlIHRvIGFkZCBp
biB0ZXJtIG9mCj4gPiA+ID4gY29uZF9yZXNjaGVkKCkgdG8gdGhlIGRyaXZlcnMgOigKPiA+ID4g
PiBNb3N0IGRyaXZlcnMgYXJlIGZhaXJseSBzaW1wbGlzdGljIHdpdGggbm8gc2FmZSBwb2ludHMg
dG8gYWRkCj4gPiA+ID4gdGhpcy4KPiA+ID4gCj4gPiA+IFllYWgsIG5vdCBzdXJwcmlzZWQgYnkg
dGhpcy4KPiA+ID4gCj4gPiA+ID4gNi4gRG8gd2Ugc3RpbGwgbmVlZCBmb3JjZV9mbHVzaF9hbGwo
KSBpbiB0aGUgYXJjaF9kdXBfbW1hcCgpPwo+ID4gPiA+IFRoaXMKPiA+ID4gPiB3b3JrcyB3aXRo
IGEgbm9uLWZvcmNlZCB0bGIgZmx1c2gKPiA+ID4gPiB1c2luZyBmbHVzaF90bGJfbW0obW0pOwo+
ID4gPiAKPiA+ID4gTWF5YmUgbm90LCBkb2VzIGl0IG1ha2UgYSBkaWZmZXJlbmNlIHRob3VnaD8K
PiA+ID4gCj4gPiA+ID4gNy4gSW4gYWxsIGNhc2VzLCBVTUwgaXMgZG9pbmcgc29tZXRoaW5nIHNp
bGx5Lgo+ID4gPiA+IFRoZSBDUFUgdXNhZ2Ugd2hpbGUgZG9pbmcgZmluZCAtdHlwZSBmIC1leGVj
IGNhdCB7fSA+IC9kZXYvbnVsbAo+ID4gPiA+IG1lYXN1cmVkIGZyb20gb3V0c2lkZSBpbiBub24t
cHJlZW1wdGl2ZSBhbmQKPiA+ID4gPiBQUkVFTVBUX1ZPTFVOVEFSWSBzdGF5cyBhcm91bmQgOC0x
NSUuIFRoZSBVTUwgdGFrZXMgYQo+ID4gPiA+IHNhYmJhdGljYWwKPiA+ID4gPiBmb3IgdGhlIHJl
bWFpbmluZyA4NSBpbnN0ZWFkIG9mIGFjdHVhbGx5Cj4gPiA+ID4gZG9pbmcgd29yay4gUFJFRU1Q
VCBpcyBzbGlnaHRseSBiZXR0ZXIgYXQgNjAsIGJ1dCBzdGlsbCBmYXIKPiA+ID4gPiBmcm9tCj4g
PiA+ID4gMTAwJS4gSXQganVzdCBrZWVwcyBnb2luZyBpbnRvIGlkbGUgYW5kIEkKPiA+ID4gPiBj
YW5ub3QgdW5kZXJzdGFuZCB3aHkuCj4gPiA+IAo+ID4gPiBJcyBpdCBqdXN0IHdhaXRpbmcgZm9y
IElPPwo+ID4gPiAKPiA+ID4gam9oYW5uZXMKPiA+ID4gCj4gPiA+IF9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4gPiA+IGxpbnV4LXVtIG1haWxpbmcgbGlz
dAo+ID4gPiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCj4gPiA+IGh0dHA6Ly9saXN0cy5p
bmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0KPiA+ID4gCj4gPiAKPiA+IAo+
IAoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4
LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0
cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
