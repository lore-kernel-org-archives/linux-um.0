Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2CFFC4332F
	for <linux-um@archiver.kernel.org>; Sat,  4 Nov 2023 09:34:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:From:References:Cc:To:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=jMP+maHopFhRZPQkOa/741dWx4oNZs93f3VIbv/I6Ec=; b=wXrTyLPNeCtaMv
	PM9tfQJ/RfPdc8xASG0K3Jz+npw+u1z59slaBDVDrQ/L60QhleNb9NdGcKwLxAitX1YZcMQ1Z8B0y
	HAVG6SVTJRo55cn/EsKNRt6F9rtd6ZT0Yz6JjuAAJNL/8W9As76Ld+Jr6ElBZV3xm5+1B61xsJlVp
	bYzIOMAG0nm3tdrMaX5A0j5of1wLfvQFJxpEHi0U88lhgpuj44rYhvdsf/N4uZFx2p8Hpp+zOaP9l
	9Ubqj9GcSN+WvaLojBSDSz9mgHyDEdruboILMEKwoWd+GodRiop1bOl+dtmLs1WYYStcaYB+lpZdb
	Sw8DIP2x5SdStcTCqlQw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qzD3S-00Cyr1-2G;
	Sat, 04 Nov 2023 09:34:58 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qzD3P-00Cypi-0d
	for linux-um@lists.infradead.org;
	Sat, 04 Nov 2023 09:34:57 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qzD3H-005Hsg-R6; Sat, 04 Nov 2023 09:34:48 +0000
Received: from madding.kot-begemot.co.uk ([192.168.3.98])
	by jain.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <anton.ivanov@kot-begemot.co.uk>)
	id 1qzD3C-00AsqC-1V;
	Sat, 04 Nov 2023 09:34:47 +0000
Message-ID: <a55f6941-ddf6-2355-271d-5ed0db5a2a62@kot-begemot.co.uk>
Date: Sat, 4 Nov 2023 09:34:42 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.15.1
Subject: Re: Missing clobber on alternative use on Linux UM 32-bit
To: Nadav Amit <nadav.amit@gmail.com>, Richard Weinberger <richard@nod.at>,
 linux-um@lists.infradead.org
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>
References: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
In-Reply-To: <24BD0906-C6FE-499C-9A4A-00C56E6EE84A@gmail.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231104_023455_230085_8FC5F00A 
X-CRM114-Status: GOOD (  13.37  )
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

T24gMDQvMTEvMjAyMyAwOToyNSwgTmFkYXYgQW1pdCB3cm90ZToKPiBJIHdhcyByZWFkaW5nIChh
Z2FpbikgdGhlIHg4NiBDIG1hY3JvIG9mIOKAnGFsdGVybmF0aXZlKCnigJ0gYW5kIEkgd2FzIGEg
Yml0Cj4gc3VycHJpc2VkIGl0IGRvZXMgY2xvYmJlciB0aGUgZmxhZ3MgKOKAnGNj4oCdKSBhcyBh
IHByZWNhdXRpb24uCj4gCj4gICAgI2RlZmluZSBhbHRlcm5hdGl2ZShvbGRpbnN0ciwgbmV3aW5z
dHIsIGZ0X2ZsYWdzKSBcCj4gCWFzbV9pbmxpbmUgdm9sYXRpbGUgKEFMVEVSTkFUSVZFKG9sZGlu
c3RyLCBuZXdpbnN0ciwgZnRfZmxhZ3MpIDogOiA6ICJtZW1vcnkiKQo+IAo+IEFjdHVhbGx5IHRo
ZXJlIHNlZW1zIHRvIGJlIG9ubHkgb25lIGluc3RhbmNlIG9mIHByb2JsZW1hdGljIGNhc2VzIC0g
aW4gdW0vMzItYml0Ogo+IAo+ICAgICNkZWZpbmUgbWIoKSBhbHRlcm5hdGl2ZSgibG9jazsgYWRk
bCAkMCwwKCUlZXNwKSIsICJtZmVuY2UiLCBYODZfRkVBVFVSRV9YTU0yKQo+ICAgICNkZWZpbmUg
cm1iKCkgYWx0ZXJuYXRpdmUoImxvY2s7IGFkZGwgJDAsMCglJWVzcCkiLCAibGZlbmNlIiwgWDg2
X0ZFQVRVUkVfWE1NMikKPiAgICAjZGVmaW5lIHdtYigpIGFsdGVybmF0aXZlKCJsb2NrOyBhZGRs
ICQwLDAoJSVlc3ApIiwgInNmZW5jZSIsIFg4Nl9GRUFUVVJFX1hNTSkKPiAKPiBQcmVzdW1hYmx5
LCBpZiBYTU0gb3IgWE1NMiBhcmUgbm90IHN1cHBvcnRlZCwgdGhlcmUgd291bGQgYmUgaW5zdGFu
Y2VzIHdoZXJlIGFkZGwKPiB3b3VsZCBiZSBhYmxlIHRvIGNoYW5nZSBlZmxhZ3MgYXJpdGhtZXRp
YyBmbGFncyB3aXRob3V0IHRoZSBjb21waWxlciBiZWluZyBhd2FyZQo+IG9mIGl0Lgo+IAo+IEFz
IGl0IG9ubHkgYWZmZWN0cyAzMi1iaXQgTGludXggVU0gLSBJIGRvbuKAmXQgZWFzaWx5IGhhdmUg
YW4gZW52aXJvbm1lbnQgdG8gdGVzdAo+IHRoZSBmaXguIEFuIGFsdGVybmF0aXZlICh3b3JkLXB1
biB1bmludGVuZGVkKSBpcyB0byBhZGQg4oCcY2PigJ0gYXMgYSBwcmVjYXV0aW9uCj4gdG8gdGhl
IGFsdGVybmF0aXZlIG1hY3JvLgo+IAo+IAo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCj4gbGludXgtdW0gbWFpbGluZyBsaXN0Cj4gbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwo+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlz
dGluZm8vbGludXgtdW0KCkFwcGxpY2F0aW9uIGFsdGVybmF0aXZlcyBpbiB1bSBpcyBwcmVzZW50
bHkgYSBOT1AuIEl0IGFsd2F5cyB1c2VzIHRoZSAKImJsdW50IGFuZCBoZWF2eSBpbnN0cnVtZW50
IiAtIHRoZSBtb3N0IGNvbnNlcnZhdGl2ZSBvcHRpb24uCgpJdCBpcyBvbiB0aGUgVE9ETyBsaXN0
LgoKLS0gCkFudG9uIFIuIEl2YW5vdgpodHRwczovL3d3dy5rb3QtYmVnZW1vdC5jby51ay8KCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBt
YWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5m
cmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
