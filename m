Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C135C04AB8
	for <linux-um@archiver.kernel.org>; Wed, 20 Sep 2023 17:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:To:Subject:From:MIME-Version:
	Date:Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CUlR17XHAubjsFbRijl7s7Uy/i+flQmeLkR1ewc7W9w=; b=SxounqqlVnzbCIJjYU8e8Qc3iI
	UUEyIiF6VoS0PRUNV6/RSQ8Qtg2vstnVUORtpuUQ86M+Y+V4cXXJXbBt+4vDBwNF7xeN0JOyFfuev
	6FmFfErDWXUfALHXYpCbJ/Q1gDPLSNUqwZVLcVAXZFt6xtrImY8P8glE3viohgmZptjFdH0HjBuN7
	7KVAffwEWAqmINP5ScPh8I43c86UhYDdcT7oQdVGFbYSCEMbtekq64nVPvXu7HnYX42EW6r1M3UeL
	hTkgpsneGKiOFSdYaYL1rBLnA71HyKOJl/9DBcL+tacRVa/r0ALmyLEtKNDNrP+ubJbh3vgZdvRYZ
	sYgqKIww==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qj1BB-003lLP-3A;
	Wed, 20 Sep 2023 17:40:02 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qj1B8-003lKS-0U
	for linux-um@lists.infradead.org;
	Wed, 20 Sep 2023 17:39:59 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qj1B5-002WIG-2M
	for linux-um@lists.infradead.org; Wed, 20 Sep 2023 17:39:55 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qj1B2-00HY7Z-BU
	for linux-um@lists.infradead.org; Wed, 20 Sep 2023 18:39:54 +0100
Message-ID: <2ff833ca-51bf-e8a1-9c68-7a02b7b0d83b@kot-begemot.co.uk>
Date: Wed, 20 Sep 2023 18:39:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Subject: Re: Boots and seems to work with PREEMPT enabled
To: User Mode Linux <linux-um@lists.infradead.org>
References: <6eb21cc7-05d5-c9be-6abd-07bdda64dcb6@kot-begemot.co.uk>
 <d1d9054e-197c-18b1-bb2d-ef7f5737495f@kot-begemot.co.uk>
Content-Language: en-US
In-Reply-To: <d1d9054e-197c-18b1-bb2d-ef7f5737495f@kot-begemot.co.uk>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230920_103958_206800_1B1C63F7 
X-CRM114-Status: GOOD (  22.39  )
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

Ck9uIDIwLzA5LzIwMjMgMTM6MzAsIEFudG9uIEl2YW5vdiB3cm90ZToKPgo+Cj4gT24gMjAvMDkv
MjAyMyAxMjoxNCwgQW50b24gSXZhbm92IHdyb3RlOgo+PiBBZGRlZCBzdXBwb3J0IGZvciBrZXJu
ZWwgc2lkZSBmcHUgc3RvcmUvcmVzdG9yZSBhbmQgcmVhbCAKPj4ga2VybmVsX2ZwdV9iZWdpbi9r
ZXJuZWxfZnB1X2VuZCB1c2luZyBnY2MgaW50cmluc2ljcy4gRW5hYmxlZCBQUkVFTVBULgo+Pgo+
PiBJdCBib290cyBhbmQgc2VlbXMgdG8gYmUgYWxpdmUgYW5kIGtpY2tpbmcuIEkgZG8gbm90IG5v
dGljZSBhbnkgCj4+IHNpZ25pZmljYW50IGVmZmVjdCBvbiBwZXJmb3JtYW5jZSBlaXRoZXIuCj4+
Cj4KPiBJIHRha2UgbXkgd29yZHMgYmFjayAtIEkgd2FzIHRlc3Rpbmcgd2l0aCBWT0xVTlRBUlkg
d2hpY2ggc2VlbXMgdG8gCj4gcHJvdmlkZSBhIGRpZmZlcmVuY2Ugd2l0aGluZyB0aGUgbWFyZ2lu
IG9mIGVycm9yLgo+Cj4gRW5hYmxpbmcgZm9yY2VkIHByZWVtcHRpb24gZHJvcHMgdGhlIHRpbWUg
Zm9yCj4KPiBmaW5kIC91c3IgLXR5cGUgZiAtZXhlYyBjYXQge30gPiAvZGV2L251bGwgXDsKPgo+
IGZyb20KPgo+IHJlYWzCoMKgwqAgMTltMTEuMjA3cwo+IHVzZXLCoMKgwqAgMG0wLjE4MHMKPiBz
eXPCoMKgwqAgMm00MS4xNjBzCj4KPiB0bwo+Cj4gcmVhbMKgwqDCoCAzbTEzLjY0N3MKPiB1c2Vy
wqDCoMKgIDBtMC4wMDBzCj4gc3lzwqDCoMKgIDJtNTguMjcwcwo+Cj4gQW5kIGJvb3QgdGltZSBm
cm9tIDExLjVzIHRvIDZzLgo+Cj4gSXQgZGlkIGNvbXBsYWluIG9uIHNodXRkb3duIHRob3VnaCB3
aXRoIHNvbWUgdHJhY2VzLiBOb3RoaW5nIHdoaWxlIAo+IHJ1bm5pbmcuCgpUaGlzIGlzIGZpeGVk
IGJ5IGFkZGluZyBhIHByZWVtcHRfZW5hYmxlL2Rpc2FibGUgYXJvdW5kIHRoZSBpbnRlcnJ1cHQg
CmxvdyBsZXZlbC4gV2Ugd2VyZSBxdWl0ZSBvYnZpb3VzbHkgbWlzc2luZyBpdC4KCj4KPiBUaGUg
cGF0Y2ggd2lsbCBoaXQgdGhlIG1haWxpbmcgbGlzdCBzaG9ydGx5LgoKSSB3aWxsIHJldmlzZSB0
aGUgcGF0Y2ggYW5kIGFkZHJlc3MgdGhlIGJ1ZyByZXBvcnQgb24gdGhlIGNvbmZpZy5kZWJ1Zy4K
Cj4KPgo+PiBIb3cgZG8gSSB0ZXN0IGl0IGZyb20gaGVyZSBvbndhcmRzPwo+Cj4gVGhlIHF1ZXN0
aW9uIHN0aWxsIHN0YW5kcy4gQ2FuIHdlIHVzZSBhbnl0aGluZyBhcyBhIHNwZWNpZmljIHRlc3Qg
Cj4gc3VpdGU/IEl0IGlzIG5vdCBhbiBhcmVhIEkgYW0gZmFtaWxpYXIgd2l0aCwgc28gYW55IHBv
aW50ZXJzIHdpbGwgYmUgCj4gd2VsY29tZS4KPgo+Pgo+PiBJIGFtIGhhcHB5IHRvIHRocm93IHRo
ZSBwYXRjaGVzIG9uIHRoZSBsaXN0IGFzIGFuIFJGQywgdGhvdWdoIEkgd291bGQgCj4+IHByZWZl
ciB0byB0ZXN0IGZpcnN0IDopCj4+Cj4KSG93ZXZlciwgdGhpcyBpcyBhYm91dCBhcyBtdWNoIHBy
ZWVtcHRpb24gYXMgd2UgY2FuIGVuYWJsZS4KClRyeWluZyB0byBkbyB3aGF0IGlzIHN1Z2dlc3Rl
ZCBieSBQZXRlciBaaWpsc3RyYSBpbiB0aGUgbWFpbiBQUkVNUFQgbWFpbCAKdGhyZWFkIG9uIExL
TSBkb2VzIG5vdCB3b3JrIGZvciBVTUwuIEF0IGFsbC4KCkhpcyBzdWdnZXN0aW9uIGlzIHRvIGFk
ZCBwcmVlbXB0X3NjaGVkdWxlX2lycSgpIGluIHRoZSBJUlEgZXhpdCBjb2RlLiBPbiAKVU1MIHRo
YXQgY29kZSBpcyBtaXhlZCB3aXRoIGhvc3Qgc2lnbmFsIGhhbmRsaW5nIGFuZCB5b3UgY2Fubm90
IGRvIHRoYXQsIApiZWNhdXNlIHRoZSBpcnFfZW5hYmxlL2Rpc2FibGUgaW4gdGhhdCBmdW5jdGlv
biB0b3VjaCB0aGUgc2lnbmFsIG1hc2suIApUaGlzIG1ha2VzIGEgaGFzaCBvZiB0aGUgc2lnbmFs
IGhhbmRsaW5nLiBJbiBhZGRpdGlvbiB0byB0aGF0LCB3ZSBoYXZlIAptaXNzaW5nIHByZWVtcHRf
ZW5hYmxlL2Rpc2FibGUgYW5kL29yIGd1YXJkcyBhcm91bmQgdGhpcyBwYXJ0LiBJdCBoYXMgCnNv
bWUgaGlzdG9yaWNhbCBsZXZlbCBvZiAicmVpbnZvY2F0aW9uIiBhbmQgInJlZW50cmFuY3kiIGJl
aGF2aW91ciBhbmQgCml0IGdldHMgaW4gdGhlIHdheS4gVGhhdCB3aWxsIG5lZWQgdG8gYmUgdW50
YW5nbGVkLCBmaXhlZCB0byBtYXRjaCAKcHJlZW1wdCBzZW1hbnRpY3MgYW5kIG1hZGUgdG8gd29y
ay4gSSdsbCBiZSBob25lc3QgLSBJIGhhdmUgbm8gY2x1ZSBob3cgCmxvbmcgdGhpcyB3aWxsIHRh
a2UuCgpNeSBzdWdnZXN0aW9uIGlzIHRoYXQgd2UgdGFrZSB0aGUgcmVzdCB3aXRoIHJlbGV2YW50
IGZwdSByZWdpc3RlciAKc3RvcmUvcmVzdG9yZSBmaXhlcyBhbmQgdGhlIGltcHJvdmVtZW50cyBp
dCBwcm92aWRlcyBhbmQgbGVhdmUgdGhlIApwcmVlbXB0X3NjaGVkdWxlX2lycSgpIHBhcnQgZm9y
IGxhdGVyLgoKLS0gCkFudG9uIFIuIEl2YW5vdgpodHRwczovL3d3dy5rb3QtYmVnZW1vdC5jby51
ay8KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51
eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlz
dHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
