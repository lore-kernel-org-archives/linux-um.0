Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C284E810AD
	for <linux-um@archiver.kernel.org>; Wed, 27 Sep 2023 09:59:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:To:Subject:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MQoA2mKIPLUGeVqcsBvZiDmTo/ljcqHjB0TNn8A0aHw=; b=qxKcZ/42jG2fHKo/7v3LNoNjiP
	3/HiDa3kHLQSGyMUFiv/3RN77F38SCuPijZ6JbrsSsLa0w6MAuCQqBKFcXtqmdGR0z0sgNFG+qI90
	DkZ8KjfrWH3anRgaQrc+WQ61GalD7jy5nxtqoeodvH9ONgPEjHZU+ofrjD2ts9tmJ2LLZBSuJQq2D
	ugkWODMpeRxE2md0TDEN/ZLqbkY8HKnCjtsMH2jtWz1VUlaObFqFVWeh2TPwOVHzMZ8Sbsg3Q4y5h
	7Z2AkHJlaJqJatZLhoStF/EuGbc7pc6UlA9gq1KWJIY3neMlWN2LdlLcOILeTsdP1Wj7xxcmbhnhC
	7G4w8QAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qlRKR-000Y4P-1o;
	Wed, 27 Sep 2023 09:59:35 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qlRKO-000Y3t-1J
	for linux-um@lists.infradead.org;
	Wed, 27 Sep 2023 09:59:34 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qlRKI-002ukU-7v; Wed, 27 Sep 2023 09:59:28 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.96)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qlRKC-003GW5-0V;
	Wed, 27 Sep 2023 10:59:25 +0100
Message-ID: <a38bf57b-c11f-7b27-63a3-d5a4bb028819@cambridgegreys.com>
Date: Wed, 27 Sep 2023 10:59:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [RFC PATCH 0/3] um: clean up mm creation - another attempt
Content-Language: en-US
To: Benjamin Berg <benjamin@sipsolutions.net>,
 Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
References: <20230922223737.1206223-4-johannes@sipsolutions.net>
 <bcc1170b-89b9-7c5e-d047-7055f97c1716@cambridgegreys.com>
 <4f79b781db6d5892c86e103733c7c30cda78afdf.camel@sipsolutions.net>
 <4b5764f0-d2c0-12ce-56bb-73c07ab59ebc@cambridgegreys.com>
 <d6ac37b196ebc0443997a942f8efb16a69e424fc.camel@sipsolutions.net>
 <18290c11-2d97-3aec-3fd7-b3dd0d33a88b@cambridgegreys.com>
 <2d041a80-0ba4-d48b-07b1-b1bc835b3e0d@cambridgegreys.com>
 <4d772184b2b39944de8444b0a6f437581297e1d4.camel@sipsolutions.net>
 <300c0b28952b2837efbb5c59f38944b02b7722f2.camel@sipsolutions.net>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
In-Reply-To: <300c0b28952b2837efbb5c59f38944b02b7722f2.camel@sipsolutions.net>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230927_025932_448311_BC8A862A 
X-CRM114-Status: GOOD (  33.62  )
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

CgpPbiAyNy8wOS8yMDIzIDEwOjUyLCBCZW5qYW1pbiBCZXJnIHdyb3RlOgo+IEhpLAo+IAo+IE9u
IFR1ZSwgMjAyMy0wOS0yNiBhdCAxNDozOCArMDIwMCwgSm9oYW5uZXMgQmVyZyB3cm90ZToKPj4g
W1NOSVBdCj4+IDEuIFN0YXJ0IGZyb20gc2NyYXRjaCwgd2l0aG91dCBjb3B5aW5nLCB3aGljaCBt
eSBvdGhlciBwYXRjaCBbMV0gZGlkLgo+IAo+IEkgcmVhbGx5IHRoaW5rIHdlIHNob3VsZCBnbyBh
aGVhZCB3aXRoIHRoYXQgYXBwcm9hY2guIFRoZW4gZm9sbG93IHVwCj4gd2l0aCBvcHRpbWl6YXRp
b25zLgoKKzEKCj4gCj4+IFtTTklQXQo+Pgo+PiBJIHRoaW5rIHRoZSBiZXR0ZXIgYXBwcm9hY2gg
Zm9yIGNvcnJlY3RuZXNzIGFuZCBpbnRlZ3JhdGlvbiBpbnRvIHRoZQo+PiBrZXJuZWwgd291bGQg
YmUgdG8gYWN0dWFsbHkgYWRtaXQgdGhhdCBVTUwgaXMgc3BlY2lhbCBiZWNhdXNlIHBhZ2UKPj4g
ZmF1bHRzIGFyZSBzbyBleHBlbnNpdmUsIGFuZAo+Pgo+PiAgwqAqIHN0YXJ0IHdpdGggYSBmcmVz
aCBtbSBwcm9jZXNzIGV2ZXJ5IHRpbWUKPj4gIMKgKiBoYXZlIHZtYV9uZWVkc19jb3B5KCkgcmV0
dXJuIHRydWUKPj4gIMKgKiBjb21wbGV0ZWx5IGZpbGwgdGhlIG1hcHBpbmdzIGFjY29yZGluZyB0
byBvbmx5IHRoZSBuZXcgbW0ncyBWTUFzCj4+ICDCoMKgIGluIGFyY2hfZHVwX21tYXAoKSBvciBw
ZXJoYXBzIGxhdGVyCj4+Cj4+IEkgZG9uJ3Qga25vdyBob3cgdGhhdCdkIGJlaGF2ZSB3cnQuIHBl
cmZvcm1hbmNlLCB0aG91Z2ggaXQgbGlrZWx5IGNhbm5vdAo+PiBiZSBiZXR0ZXIgdGhhbiB3aXRo
IHRoZXNlIHBhdGNoZXMsIGJ1dCBhdCBsZWFzdCBpdCdkIGJlIG1vcmUgY29ycmVjdCwKPj4gYW5k
IG1vcmUgb2J2aW91c2x5IGNvcnJlY3QgdG9vLCBmb3Igc3RhcnRlcnMsIGJlY2F1c2UgdGhlbiB0
aGUgYWN0dWFsCj4+IG1hcHBpbmdzIGluIHRoZSBVTUwgbW0gcHJvY2VzcyB3b3VsZCBhY3R1YWxs
eSByZWZsZWN0IHRoZSBQVEVzIHRoYXQKPj4gTGludXgga25vd3MgYWJvdXQuCj4gCj4gWWVzLCBw
ZXJmb3JtYW5jZSBtYXkgZGVncmFkZSwgYnV0IHRoZSBpbXBsZW1lbnRhdGlvbiBzaG91bGQgYmUg
Y29ycmVjdAo+IGluIHRoZSBmaXJzdCBwbGFjZS4gTm90ZSB0aGF0IGV2ZW4gdGhvdWdoIHdlIGxv
b2tlZCBhdCBpdCAoYW5kIGUuZy4KPiBmb3VuZCB0aGF0IE1NQVBfRE9OVEZPUksgaXMgaW5jb3Jy
ZWN0KSwgd2UgaGF2ZSBub3QgZmlndXJlZCBvdXQgd2h5IHRoZQo+IGZpcnN0IGFwcHJvYWNoIGlz
IHNsb3dlciBjdXJyZW50bHkgYXMgZXZlcnl0aGluZyBpbnRlcmVzdGluZyBzaG91bGQgYmUKPiBn
ZXR0aW5nIHVubWFwcGVkIGJ5IHRoZSBmb3JjZV9mbHVzaF9hbGwuCj4gCj4gT25jZSB3ZSBhcmUg
dGhlcmUsIHdlIGNhbiBsb29rIGZvciBvcHRpbWl6YXRpb25zLiBUaGUgZnVuZGFtZW50YWwKPiBw
cm9ibGVtIGlzIHRoYXQgcGFnZSBmYXVsdHMgKGV2ZW4gbWlub3Igb25lcykgYXJlIGV4dHJlbWVs
eSBleHBlbnNpdmUKPiBmb3IgdXMuCj4gCj4gSnVzdCB0aHJvd2luZyBvdXQgaWRlYXMgb24gd2hh
dCB3ZSBjb3VsZCBkbzoKPiAgICAgMS4gU0VDQ09NUCBhcyB0aGF0IHJlZHVjZXMgdGhlIGFtb3Vu
dCBvZiBjb250ZXh0IHN3aXRjaGVzLgo+ICAgICAgICAoWWVzLCBJIGtub3cgSSBzaG91bGQgcmVz
dWJtaXQgdGhlIHBhdGNoc2V0KQoKQWN0dWFsbHkuLi4gWUVTLCBZRVMgYW5kIFlFUy4KCkkgd2Fz
IGp1c3QgbG9va2luZyBhdCBhbGwgdGhlIHdvcmthcm91bmQgd2hpY2ggYXJlIGluIHBsYWNlIHRv
IHByZXZlbnQKZ3Vlc3QgcHJvY2Vzc2VzIGRvaW5nIGEgc3lzY2FsbCBvbiB0aGUgaG9zdC4gSWYg
dGhpcyBpcyBwcm9oaWJpdGVkIGF0CmEgaGlnaGVyIGxldmVsIHdlIHNob3VsZCBnZXQgcXVpdGUg
YSBib29zdCBhcyBhbGwgdGhlc2UgUFRSQUNFX1BFRUtzCndpbGwgYmVjb21lIHVubmVjZXNzYXJ5
LgoKPiAgICAgMi4gTWF5YmUgd2UgY2FuIGRpc2FibGUvY3JpcHBsZSBwYWdlIGFjY2VzcyB0cmFj
a2luZz8gSWYgd2UgYXNzdW1lCj4gICAgICAgIGluaXRpYWxseSBtYXJrIGFsbCBwYWdlcyBhcyBh
Y2Nlc3NlZCBieSB1c2Vyc3BhY2UgKGkuZS4KPiAgICAgICAgcHRlX21reW91bmcpLCB0aGVuIHdl
IGF2b2lkIGEgbWlub3IgcGFnZSBmYXVsdCBvbiBmaXJzdCBhY2Nlc3MuCj4gICAgICAgIERvaW5n
IHRoYXQgd2lsbCBtZXNzIHdpdGggcGFnZSBldmljdGlvbiB0aG91Z2guCj4gICAgIDMuIERvIERB
WCAoZGlyZWN0X2FjY2VzcykgZm9yIGZpbGVzLiBpLmUuIG1tYXAgZmlsZXMgZGlyZWN0bHkgaW4g
dGhlCj4gICAgICAgIGhvc3Qga2VybmVsIHJhdGhlciB0aGFuIHRocm91Z2ggVU0uCj4gICAgICAg
IFdpdGggYSBob3N0ZnMgbGlrZSBmaWxlIHN5c3RlbSwgb25lIHNob3VsZCBiZSBhYmxlIHRvIGFk
ZCBhbgo+ICAgICAgICBpbnRlcm1lZGlhdGUgYmxvY2sgZGV2aWNlIHRoYXQgbWFwcyBob3N0IGZp
bGVzIHRvIHBoeXNpY2FsIHBhZ2VzLAo+ICAgICAgICB0aGVuIGRvIERBWCBpbiB0aGUgRlMuCj4g
ICAgICAgIEZvciBkaXNrIGltYWdlcywgdGhlIGV4aXN0aW5nIGlvbWVtIGluZnJhc3RydWN0dXJl
IHNob3VsZCBiZQo+ICAgICAgICB1c2FibGUsIHRoaXMgc2hvdWxkIHdvcmsgd2l0aCBhbnkgREFY
IGVuYWJsZWQgZmlsZXN5c3RlbXMgKGV4dDIsCj4gICAgICAgIGV4dDQsIHhmcywgdmlydGlvZnMs
IGVyb2ZzKS4KCkkgaGFkIHNvbWUgcGxhbnMgdG8gZG8gYSB1YmQgZ2VuIDIgd2hpY2ggdXNlcyBt
bWFwIGFuZC9vciB0aGlzLiBUaGV5IGFyZQpwcmVzZW50bHkgd2F5IG9uIHRoZSBiYWNrYnVybmVy
LiBXZSBjYW4gZG8gc29tZSBvZiB0aGF0IG9uY2Ugd2UgcHVzaAp0aGUgbmV3IFZNIGNoYW5nZXMu
Cgo+IAo+IEJlbmphbWluCj4gCj4+Cj4+PiAyLiBUaGUgcHJlZW1wdGlvbiBwYXRjaGVzIHdvcmsg
ZmluZSBvbiB0b3AgKGFsbCAzIGNhc2VzKS4gVGhlCj4+PiBwZXJmb3JtYW5jZSBkaWZmZXJlbmNl
IHN0YXlzLgo+Pgo+PiBPSy4KPj4KPj4+IDMuIFdlIGRvIG5vdCBoYXZlIGFueXRoaW5nIG9mIHZh
bHVlIHRvIGFkZCBpbiB0ZXJtIG9mCj4+PiBjb25kX3Jlc2NoZWQoKSB0byB0aGUgZHJpdmVycyA6
KAo+Pj4gTW9zdCBkcml2ZXJzIGFyZSBmYWlybHkgc2ltcGxpc3RpYyB3aXRoIG5vIHNhZmUgcG9p
bnRzIHRvIGFkZCB0aGlzLgo+Pgo+PiBZZWFoLCBub3Qgc3VycHJpc2VkIGJ5IHRoaXMuCj4+Cj4+
PiA2LiBEbyB3ZSBzdGlsbCBuZWVkIGZvcmNlX2ZsdXNoX2FsbCgpIGluIHRoZSBhcmNoX2R1cF9t
bWFwKCk/IFRoaXMKPj4+IHdvcmtzIHdpdGggYSBub24tZm9yY2VkIHRsYiBmbHVzaAo+Pj4gdXNp
bmcgZmx1c2hfdGxiX21tKG1tKTsKPj4KPj4gTWF5YmUgbm90LCBkb2VzIGl0IG1ha2UgYSBkaWZm
ZXJlbmNlIHRob3VnaD8KPj4KPj4+IDcuIEluIGFsbCBjYXNlcywgVU1MIGlzIGRvaW5nIHNvbWV0
aGluZyBzaWxseS4KPj4+IFRoZSBDUFUgdXNhZ2Ugd2hpbGUgZG9pbmcgZmluZCAtdHlwZSBmIC1l
eGVjIGNhdCB7fSA+IC9kZXYvbnVsbAo+Pj4gbWVhc3VyZWQgZnJvbSBvdXRzaWRlIGluIG5vbi1w
cmVlbXB0aXZlIGFuZAo+Pj4gUFJFRU1QVF9WT0xVTlRBUlkgc3RheXMgYXJvdW5kIDgtMTUlLiBU
aGUgVU1MIHRha2VzIGEgc2FiYmF0aWNhbAo+Pj4gZm9yIHRoZSByZW1haW5pbmcgODUgaW5zdGVh
ZCBvZiBhY3R1YWxseQo+Pj4gZG9pbmcgd29yay4gUFJFRU1QVCBpcyBzbGlnaHRseSBiZXR0ZXIg
YXQgNjAsIGJ1dCBzdGlsbCBmYXIgZnJvbQo+Pj4gMTAwJS4gSXQganVzdCBrZWVwcyBnb2luZyBp
bnRvIGlkbGUgYW5kIEkKPj4+IGNhbm5vdCB1bmRlcnN0YW5kIHdoeS4KPj4KPj4gSXMgaXQganVz
dCB3YWl0aW5nIGZvciBJTz8KPj4KPj4gam9oYW5uZXMKPj4KPj4gX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KPj4gbGludXgtdW0gbWFpbGluZyBsaXN0Cj4+
IGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKPj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo+Pgo+IAo+IAoKLS0gCkFudG9uIFIuIEl2YW5v
dgpDYW1icmlkZ2VncmV5cyBMaW1pdGVkLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQuIENvbXBhbnkg
TnVtYmVyIDEwMjczNjYxCmh0dHBzOi8vd3d3LmNhbWJyaWRnZWdyZXlzLmNvbS8KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcg
bGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQu
b3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K
