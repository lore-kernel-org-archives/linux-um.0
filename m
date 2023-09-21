Return-Path: <linux-um-bounces+linux-um=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454A0E7070F
	for <linux-um@archiver.kernel.org>; Thu, 21 Sep 2023 10:33:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:References:Cc:To:From:Subject:
	MIME-Version:Date:Message-ID:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Bu7S79myLn176YfJlkLgzz6AWuulRijmkWvnvcRmST4=; b=CqLSOhN7/UapzQ
	JpsZr1aEj7lS9z3CGCCrKe7isHgN/o6dVd400mXLTmaMo5nls/r/HIGbZOl31tQ/4PGW1ZZz/wUio
	rdaRPZpOiFO3USr84tO73tsKkKD6tQdA7LAcwzWpepTiZOKctb70IzqiaaGr+V1hKO5UxwC749XJr
	R2FbObNbRcJ9e803BACejfp09kzrrpTo/1EKRodup1zv2AtHCou9ttAhSZtw3/p3j9KURZUzdhYUT
	cUdWDpdBf2uIIYxhWW+OpuRuYivZWqW0Su0BQFydjQb9ZMagIRlTtxj1whdsUh133LnGtMQx3rgZv
	q9PAMQ+gFQyMehkT7egw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qjGzT-005kav-1R;
	Thu, 21 Sep 2023 10:32:59 +0000
Received: from ns1.kot-begemot.co.uk ([217.160.28.25] helo=www.kot-begemot.co.uk)
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qjGzP-005kWF-30
	for linux-um@lists.infradead.org;
	Thu, 21 Sep 2023 10:32:57 +0000
Received: from [192.168.17.6] (helo=jain.kot-begemot.co.uk)
	by www.kot-begemot.co.uk with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjGzI-002YQx-4a; Thu, 21 Sep 2023 10:32:50 +0000
Received: from jain.kot-begemot.co.uk ([192.168.3.3])
	by jain.kot-begemot.co.uk with esmtp (Exim 4.94.2)
	(envelope-from <anton.ivanov@cambridgegreys.com>)
	id 1qjGzF-000rU8-Dk; Thu, 21 Sep 2023 11:32:47 +0100
Message-ID: <4813bff8-02be-161c-6d10-3af0b861c80b@cambridgegreys.com>
Date: Thu, 21 Sep 2023 11:32:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] um: Enable preemption in UML
Content-Language: en-US
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at
References: <20230921092836.190291-1-anton.ivanov@cambridgegreys.com>
 <15376711a221bbeaf45a278f56b944dcc9b6f2cc.camel@sipsolutions.net>
 <ef73ff84-545a-b073-fcd5-87492828280a@cambridgegreys.com>
In-Reply-To: <ef73ff84-545a-b073-fcd5-87492828280a@cambridgegreys.com>
X-Clacks-Overhead: GNU Terry Pratchett
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230921_033255_970953_E97FC00C 
X-CRM114-Status: GOOD (  24.69  )
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

CgpPbiAyMS8wOS8yMDIzIDEwOjQyLCBBbnRvbiBJdmFub3Ygd3JvdGU6Cj4gCj4gCj4gT24gMjEv
MDkvMjAyMyAxMDozNSwgSm9oYW5uZXMgQmVyZyB3cm90ZToKPj4gSGksCj4+Cj4+IEhhdmVuJ3Qg
Y2hpbWVkIGluIGhlcmUgYmVmb3JlLCBidXQgdGhhbmtzIGZvciBsb29raW5nIGF0IHRoaXMhIEkK
Pj4gYWN0dWFsbHkgcmVhbGx5IHdhbnRlZCBhdCBsZWFzdCB0aGUgdGhpbmdzIHlvdSBnZXQgZm9y
IGRlYnVnIGZyb20gdGhpcwo+PiBpbiB0aGUgcGFzdCwgc28gbXVjaCBhcHByZWNpYXRlZC4KPj4K
Pj4gSSB0aGluayBJIGFjdHVhbGx5IHRyaWVkIGEgc2ltcGxlciBhcHByb2FjaCBhbmQgaXQga2lu
ZCBvZiBldmVuIHdvcmtlZCwKPj4gYnV0IG15IHVzZXJzcGFjZSBsaWtlbHkgaGFzIHZlcnkgbGl0
dGxlIEZQVSB1c2FnZS4KPj4KPj4KPj4+ICsvKiBVTUwga25vd3MgYWJvdXQgMzg3IGZlYXR1cmVz
IHVwIHRvIGFuZCBpbmNsdWRpbmcgQVZYNTEyLCB0aWxlLCBldGMgYXJlIG5vdCB5ZXQKPj4+ICsg
KiBzdXBwb3J0ZWQuCj4+PiArICovCj4+Cj4+IERvIHlvdSBlbnN1cmUgdGhhdCBzb21laG93PyBX
YXJuIGlmIGl0J3MgdGhlcmUgYXQgbGVhc3Q/IEkgbWF5IGhhdmUKPj4gbWlzc2VkIHRoYXQuCj4g
Cj4gV2UgY2FuIGlmIHdlIHdhbnQuIFdlIGNhbiBqdXN0IGN1dC1vZmYgZmVhdHVyZSByZWZsZWN0
aW9uIGludG8gdGhlIGtlcm5lbCBpbiB0aGUKPiBzZXR1cC4gUHJlc2VudGx5IGl0IHJlZmxlY3Rz
IGFsbCBmZWF0dXJlcy4gVGhhdCBjYW4gYmUgZmlsdGVyZWQgaWYgd2Ugd2FudCB0by4KPiBGb3Ig
ZXhhbXBsZSAtIHg4NiBoYXMgYm9vdCBmbGFncyB0byBkaXNhYmxlIHhyZXN0b3JlIGFuZCB4cmVz
dG9yZW9wdAo+IAo+Pgo+PiBPciBpcyBpdCBqdXN0IGZvciB0aGUgc2F2aW5nPyBCdXQgd2hhdCBp
ZiB5b3UgZG9uJ3Qgc2F2ZSBlbm91Z2ggYW5kIHRoZQo+PiBob3N0IENQVSBoYXMgbW9yZT8KPiAK
PiBUaGlzIGlzIGp1c3QgZm9yIHRoZSBzYXZpbmcuIEFGQUlLIG5vIGxpbnV4IG1vZHVsZSB0b3Vj
aGVzIF9USUxFIGFuZCB0aGUgb3RoZXIgcmVjZW50Cj4gZmFuY3kgc3R1ZmYuIFRoZSBob3N0IGtl
cm5lbCBzb3VyY2UgbG9va3MgdGhhdCB3YXkuCgpUaGlzIGJyaW5ncyBiYWNrIHRoZSBxdWVzdGlv
biBvZgoKMS4gQWx0ZXJuYXRpdmVzICh0aGlzIGhhcyBiZWNvbWUgZXZlbiBtb3JlIG5pZ2h0bWFy
aXNoIHNpbmNlIEkgbGFzdCBsb29rZWQgYXQgaXQpCjIuIFN0YXRpYyBicmFuY2ggYnkga2V5IC0g
dGhpcyBhY3R1YWxseSBsb29rcyBkb2FibGUgYW5kIGlzIHVzZWQgYnkgbmVhcmx5IGFsbApjcnlw
dG8sIEkgbWF5IGxvb2sgYXQgaXQgd2hlbiBJIGhhdmUgc29tZSBmcmVlIHRpbWUuCgo+IAo+Pgo+
Pgo+Pj4gK3ZvaWQga2VybmVsX2ZwdV9iZWdpbih2b2lkKQo+Pj4gK3sKPj4+ICsjaWYgZGVmaW5l
ZChQUkVFTVBUKSB8fCBkZWZpbmVkKFBSRUVNUFRfVk9MVU5UUkFSWSkKPj4KPj4gbWF5YmUgbGVh
dmUgaXQgYXMgYW4gaW5saW5lIGluIGNhc2UgaXQnZCBiZSBlbXB0eSwgaS5lLiBuZWl0aGVyIG9m
IHRoZXNlCj4+IGFyZSBkZWZpbmVkPwo+Pgo+Pj4gK8KgwqDCoCBwcmVlbXB0X2Rpc2FibGUoKTsK
Pj4+ICsKPj4+ICvCoMKgwqAgV0FSTl9PTih0aGlzX2NwdV9yZWFkKGluX2tlcm5lbF9mcHUpKTsK
Pj4+ICsKPj4+ICvCoMKgwqAgdGhpc19jcHVfd3JpdGUoaW5fa2VybmVsX2ZwdSwgdHJ1ZSk7Cj4+
PiArCj4+PiArI2lmZGVmIENPTkZJR182NEJJVAo+Pj4gK8KgwqDCoCBpZiAobGlrZWx5KGNwdV9o
YXMoJmJvb3RfY3B1X2RhdGEsIFg4Nl9GRUFUVVJFX1hTQVZFT1BUKSkpCj4+PiArwqDCoMKgwqDC
oMKgwqAgX19idWlsdGluX2lhMzJfeHNhdmVvcHQ2NCgmY3VycmVudC0+dGhyZWFkLmZwdSwgS05P
V05fMzg3X0ZFQVRVUkVTKTsKPj4+ICvCoMKgwqAgZWxzZSB7Cj4+PiArwqDCoMKgwqDCoMKgwqAg
aWYgKGNwdV9oYXMoJmJvb3RfY3B1X2RhdGEsIFg4Nl9GRUFUVVJFX1hTQVZFKSkKPj4+ICvCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgIF9fYnVpbHRpbl9pYTMyX3hzYXZlNjQoJmN1cnJlbnQtPnRocmVh
ZC5mcHUsIEtOT1dOXzM4N19GRUFUVVJFUyk7Cj4+PiArwqDCoMKgwqDCoMKgwqAgZWxzZQo+Pj4g
K8KgwqDCoMKgwqDCoMKgwqDCoMKgwqAgX19idWlsdGluX2lhMzJfZnhzYXZlNjQoJmN1cnJlbnQt
PnRocmVhZC5mcHUpOwo+Pj4gK8KgwqDCoCB9Cj4+Cj4+IG5pdDogeW91IGNvdWxkIG1ha2UgYWxs
IG9mIHRoZXNlIGVsc2UgaWYgY2hhaW5zLCBhbmQgYXZvaWQgdGhlIGJyYWNlczoKPj4KPj4gaWYg
KGxpa2VseSguLi4pKQo+PiDCoMKgwqDCoC4uLgo+PiBlbHNlIGlmIChjcHVfaGFzKC4uLikpCj4+
IMKgwqDCoMKgLi4uCj4+IGVsc2UKPj4gwqDCoMKgwqAuLi4KPj4KPj4KPj4+ICt2b2lkIGtlcm5l
bF9mcHVfZW5kKHZvaWQpCj4+Cj4+IHNhbWUgY29tbWVudHMgYXMgYWJvdmUgYXBwbHkgaGVyZS4K
Pj4KPj4KPj4+IMKgIHZvaWQgc2lnaW9faGFuZGxlcihpbnQgc2lnLCBzdHJ1Y3Qgc2lnaW5mbyAq
dW51c2VkX3NpLCBzdHJ1Y3QgdW1sX3B0X3JlZ3MgKnJlZ3MpCj4+PiDCoCB7Cj4+PiArwqDCoMKg
IHByZWVtcHRfZGlzYWJsZSgpOwo+Pj4gwqDCoMKgwqDCoCBfc2lnaW9faGFuZGxlcihyZWdzLCBp
cnFzX3N1c3BlbmRlZCk7Cj4+PiArwqDCoMKgIHByZWVtcHRfZW5hYmxlKCk7Cj4+Pgo+Pgo+PiBJ
IG1heSBoYXZlIHRvIGxvb2sgYXQgdGhvc2UgdGltZS10cmF2ZWwgYml0cyBoZXJlIDopCj4gCj4g
WWVzLiBJIHdhcyBnb2luZyB0byBhc2sgeW91IHRvIGRvdWJsZSBjaGVjayBpZiB0aGV5IGFsbCB3
b3JrIGFzIGludGVuZGVkLgo+IAo+IEJhc2ljIHVzZSBzZWVtcyB3aXRob3V0IHR0IHNlZW1zIE9L
Lgo+IAo+Pgo+PiBUaGFua3MsCj4+IGpvaGFubmVzCj4+Cj4+IF9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGxpbnV4LXVtIG1haWxpbmcgbGlzdAo+PiBs
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCj4+IGh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtdW0KPj4KPiAKCi0tIApBbnRvbiBSLiBJdmFub3YKQ2Ft
YnJpZGdlZ3JleXMgTGltaXRlZC4gUmVnaXN0ZXJlZCBpbiBFbmdsYW5kLiBDb21wYW55IE51bWJl
ciAxMDI3MzY2MQpodHRwczovL3d3dy5jYW1icmlkZ2VncmV5cy5jb20vCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QK
bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==
