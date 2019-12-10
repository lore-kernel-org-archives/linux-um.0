Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pg1-x541.google.com ([2607:f8b0:4864:20::541])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieoBI-0001Ff-Kk
 for linux-um@lists.infradead.org; Tue, 10 Dec 2019 22:40:38 +0000
Received: by mail-pg1-x541.google.com with SMTP id k3so8953947pgc.3
 for <linux-um@lists.infradead.org>; Tue, 10 Dec 2019 14:40:36 -0800 (PST)
MIME-Version: 1.0
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com>
 <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
 <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
 <20191207012108.GA220741@google.com>
 <15f048d3-07ab-61c1-c6e0-0712e626dd33@cambridgegreys.com>
 <CAFd5g448yZ5nSVLnN0gvsv3jLnhWG+dzJgvH1jdV+s2eTq4wxg@mail.gmail.com>
 <1785498655.111829.1575936178298.JavaMail.zimbra@nod.at>
 <87f182c6-82a3-d696-72e4-ddaa781a655b@cambridgegreys.com>
In-Reply-To: <87f182c6-82a3-d696-72e4-ddaa781a655b@cambridgegreys.com>
From: Brendan Higgins <brendanhiggins@google.com>
Date: Tue, 10 Dec 2019 14:40:24 -0800
Message-ID: <CAFd5g46osmFBka0X60A+_mmetpreG+abnh_+GQmVrr+PPxrqxg@mail.gmail.com>
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
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
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, davidgow <davidgow@google.com>

T24gTW9uLCBEZWMgOSwgMjAxOSBhdCAxMToxNCBQTSBBbnRvbiBJdmFub3YKPGFudG9uLml2YW5v
dkBjYW1icmlkZ2VncmV5cy5jb20+IHdyb3RlOgo+Cj4gT24gMTAvMTIvMjAxOSAwMDowMiwgUmlj
aGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+ID4gLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0t
LQo+ID4+IFZvbjogIkJyZW5kYW4gSGlnZ2lucyIgPGJyZW5kYW5oaWdnaW5zQGdvb2dsZS5jb20+
Cj4gPj4+IElNSE8gd2Ugc2hvdWxkIGF0IGxlYXN0IG1hcmsgdGhlbSBhcyAib2Jzb2xldGUiIGFu
ZCBzdGFydCBwcmVwYXJpbmcgdG8KPiA+Pj4gcmVtb3ZlIHRoZW0uCj4gPj4KPiA+PiBBbHJpZ2h0
LCBJIHdpbGwgc2VuZCBhIHBhdGNoIG91dCB3aGljaCBtYXJrcyB0aGUgb3RoZXIgbmV0d29yayBk
cml2ZXJzCj4gPj4gYXMgIm9ic29sZXRlIi4KPiA+Pgo+ID4+IENsYXJpZmljYXRpb246IFNob3Vs
ZCBJIG1hcmsgYWxsIFVNTCBuZXR3b3JrIGRldmljZXMgYXMgIm9ic29sZXRlIgo+ID4+IGV4Y2Vw
dCBmb3IgTkVUX1ZFQ1RPUj8gRGFlbW9uIGFuZCBNQ0FTVCBsb29rZWQgdG8gbWUgKEkgYW0gbm90
IGEKPiA+PiBuZXR3b3JraW5nIGV4cGVydCksIGxpa2UgdGhleSBtaWdodCBub3QgYmUgY292ZXJl
ZCBieSB2ZWN0b3IuCj4gPgo+ID4gTm8uIFdoeT8KPiA+Cj4gPiBUaGFua3MsCj4gPiAvL3JpY2hh
cmQKPiA+Cj4gPiBfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
Xwo+ID4gbGludXgtdW0gbWFpbGluZyBsaXN0Cj4gPiBsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCj4gPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4
LXVtCj4gPgo+IEF0IGxlYXN0IHBjYXAgYW5kIHZkZSBhcmUgbWFpbnRlbmFuY2UgaXNzdWVzLiBU
aGV5IGRvIG5vdCBldmVuIGJ1aWxkIHRvZGF5Lgo+Cj4gT2ZmIHRoZSB0b3Agb2YgbXkgaGVhZCwg
ZGFlbW9uIG5lZWRzIGZpeGVzIHRvIHRoZSBzd2l0Y2ggLSBpdCBoYXMgYW4KPiBPKG4pIHBlcmZv
cm1hbmNlIGhpdCBmb3Igbj0ibnVtYmVyIG9mIHBvcnRzIiBhcyB3ZWxsIGFzIGEgZmV3IG90aGVy
IGlzc3Vlcy4KPgo+IFRhcCBoYXMgYSBmdWxseSBmdW5jdGlvbmFsIHJlcGxhY2VtZW50Cj4KPiBQ
Y2FwIGhhcyBhIGZ1bGx5IGZ1bmN0aW9uYWwgcmVwbGFjZW1lbnQKPgo+IG1jYXN0IGZvciAyIGlu
c3RhbmNlcyBpcyBmdW5jdGlvbmFsbHkgZXF1aXZhbGVudCB0byBydW5uaW5nIGwydHAgb3IgZ3Jl
Cj4gYmFjay10by1iYWNrLgo+Cj4gSU1ITyB3ZSBjYW4gc3RhcnQgbWFya2luZyBzb21lIG9mIHRo
ZW0gYXMgb2Jzb2xldGUuCgpJdCBsb29rZWQgdG8gbWUgbGlrZSB0aGlzIGRpc2N1c3Npb24gaXMg
b25nb2luZzsgaG93ZXZlciwgaXQgc2VlbWVkCmxpa2UgdGhlIGRpc2N1c3Npb24gbWlnaHQgYmUg
Ym9pbGluZyBkb3duIHRvICp3aGljaCogZHJpdmVycyBzaG91bGQgYmUKbWFya2VkIG9ic29sZXRl
LCBzbyBJIGRlY2lkZWQgdG8gZ28gYWhlYWQgYW5kIHNlbmQgYSBwYXRjaCB3aGljaCBtYXJrcwpl
dmVyeXRoaW5nIGFzIGRlcHJlY2F0ZWQuIEkgZmlndXJlZCBpdCB3b3VsZCBtYWtlIGl0IGVhc2ll
ciB0byBmb2N1cwp0aGUgY29udmVyc2F0aW9uIG9uIHdoYXQsIGlmIGFueXRoaW5nLCBzaG91bGQg
YmUgbWFya2VkIG9ic29sZXRlOgoKaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC8yMDE5MTIx
MDIyMzQwMy4yNDQ4NDItMS1icmVuZGFuaGlnZ2luc0Bnb29nbGUuY29tL1QvI3UKCkFsc28sIEFu
dG9uLCBJIGZsYXQgb3V0IHN0b2xlIGEgYnVuY2ggb2YgeW91ciBjb21tZW50cyBvbiB0aGlzIHRo
cmVhZAp0byBtYWtlIG15IGNvbW1pdCBtZXNzYWdlLiBKdXN0IHJlc3BvbmQgd2l0aCB0aGUgYXBw
cm9wcmlhdGUgdGFncwooY28tZGV2ZWxvcGVkLWJ5LCBldGMpIGlmIHlvdSB3YW50IHRvIGJlIGNy
ZWRpdGVkIGZvciB0aGVtLiBBcyBpdCBpcywKSSBtYXJrZWQgeW91IGFzICJzdWdnZXN0ZWQtYnki
LgoKQ2hlZXJzIQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

