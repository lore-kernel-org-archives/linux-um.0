Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmL6A-0001Sv-7N
 for linux-um@lists.infradead.org; Mon, 07 Dec 2020 18:18:59 +0000
Subject: Re: [PATCH] um: borrow bitops from the x86 tree
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
References: <20201116144426.8415-1-anton.ivanov@cambridgegreys.com>
 <a5ad1be201a7488bdc317bc72776f1465347504f.camel@sipsolutions.net>
 <d2817ac8-e4a9-5d88-468e-03705e986b6e@cambridgegreys.com>
 <cc3181a27ff19403db94385b42ec4a1feb60a965.camel@sipsolutions.net>
 <cd43d9fd-c1e8-d10d-1b39-d1893eb0cdc3@cambridgegreys.com>
Message-ID: <c20d604f-f26f-aaf7-0d55-57b1c33e4862@cambridgegreys.com>
Date: Mon, 7 Dec 2020 18:18:53 +0000
MIME-Version: 1.0
In-Reply-To: <cd43d9fd-c1e8-d10d-1b39-d1893eb0cdc3@cambridgegreys.com>
Content-Language: en-US
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Johannes Berg <johannes@sipsolutions.net>, linux-um@lists.infradead.org
Cc: richard@nod.at

T24gMTcvMTEvMjAyMCAxMjo1MywgQW50b24gSXZhbm92IHdyb3RlOgo+IE9uIDE3LzExLzIwMjAg
MTI6MTEsIEpvaGFubmVzIEJlcmcgd3JvdGU6Cj4+IE9uIFR1ZSwgMjAyMC0xMS0xNyBhdCAxMTo0
NiArMDAwMCwgQW50b24gSXZhbm92IHdyb3RlOgo+Pj4KPj4+IE15IHVzdWFsIHRlc3QgaXM6Cj4+
Pgo+Pj4gwqDCoCB0aW1lIGJ1c3lib3ggZmluZCAvdXNyL2xpYi8gLXR5cGUgZiAtZXhlYyBjYXQg
e30gPiAvZGV2L251bGwgXDsKPj4+Cj4+PiBJIGRpc2NhcmQgdGhlIGZpcnN0IHJ1biBhbmQgdXNl
IG9ubHkgcnVucyBmcm9tIGZzIGNhY2hlLgo+Pgo+PiBPaC4gSSBkaWRuJ3QgZXZlbiBydW4gdGhl
IHRpbWluZyBpbnNpZGUuIEkgcmFuIGl0ICpvdXRzaWRlKiwgc29tZXRoaW5nCj4+IGxpa2UKPj4K
Pj4gdGltZSAuL2xpbnV4IGFyZ3MuLi4gaW5pdD0vcGF0aC90by90ZXN0LXNjcmlwdC5zaAo+IAo+
IEkgdXN1YWxseSBkbyBhIGZ1bGwgc2V0IG9mIHRlc3RzIG9uIGZzIGFjY2VzcywgZGV2aWNlIElP
IGFjY2VzcyBhbmQgYSAKPiBuZXRwZXJmIGFmdGVyIGVhY2ggcGF0Y2guCj4gCj4gQmFzZWQgb24g
dGhlbSBpdCBsb29rcyBsaWtlIGl0IGlzIHdvcnRoIGl0Lgo+IAo+IFRoZSBtb3JlIGludGVyZXN0
aW5nIHF1ZXN0aW9uIGlzIC0gaXMgdGhpcyB0aGUgcmlnaHQgb3JnYW5pemF0aW9uPwo+IAo+IFdl
IGhhdmUgc3R1ZmYgaW4gbXVsdGlwbGUgcGxhY2VzIG5vdyAtIGFyY2gveDg2L3VtICwgYXJjaC91
bSwgZXRjLgo+IAo+IElNSE8sIHdlIHNob3VsZCBwcm9iYWJseSBsb29rIGF0IGdldHRpbmcgaXQg
b3JnYW5pemVkIHNvIHRoYXQgYWxsIAo+IHN1Yi1hcmNoZXMgYXJlIHVuZGVyIHRoZSB1bSB0cmVl
IGF0IHNvbWUgcG9pbnQuCgoKSW4gdGhlIG1lYW50aW1lLCBhIGJhY2twb3J0IG9mIHRoZXNlIHBh
dGNoc2V0cyAoc3RyaW5nLCBhdG9taWMsIGJpdG9wcywgCnhvciwgZnV0ZXgsIGV0YykgdG8gT3Bl
bldSVC9VTUwgaGFzIGNsb2NrZWQgMTQgZGF5cyBhcyBteSBtYWluIENQRS4KCkkgaGF2ZSBub3Qg
b2JzZXJ2ZWQgYW55IHN0YWJpbGl0eSBpc3N1ZXMgYW5kIHRoZXJlIGlzIHNvbWUgdmlzaWJsZSAK
aW1wcm92ZW1lbnQgaW4gQ1BVIHVzYWdlLgoKCj4gCj4+Cj4+IGpvaGFubmVzCj4+Cj4+Cj4+IF9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCj4+IGxpbnV4LXVt
IG1haWxpbmcgbGlzdAo+PiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCj4+IGh0dHA6Ly9s
aXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0KPj4KPiAKPiAKCgot
LSAKQW50b24gUi4gSXZhbm92CkNhbWJyaWRnZWdyZXlzIExpbWl0ZWQuIFJlZ2lzdGVyZWQgaW4g
RW5nbGFuZC4gQ29tcGFueSBOdW1iZXIgMTAyNzM2NjEKaHR0cHM6Ly93d3cuY2FtYnJpZGdlZ3Jl
eXMuY29tLwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
bGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDov
L2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

