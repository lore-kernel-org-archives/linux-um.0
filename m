Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n07Kc-00BF5j-Av
 for linux-um@lists.infradead.org; Wed, 22 Dec 2021 19:31:24 +0000
Date: Wed, 22 Dec 2021 20:31:18 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1827544067.194741.1640201478025.JavaMail.zimbra@nod.at>
In-Reply-To: <20211222102356.GA25135@axis.com>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
 <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
 <1446970217.191062.1640121183419.JavaMail.zimbra@nod.at>
 <20211222102356.GA25135@axis.com>
Subject: Re: [PATCH 0/2] Devicetree support for UML
MIME-Version: 1.0
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
To: Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Johannes Berg <johannes@sipsolutions.net>, Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, kernel <kernel@axis.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

VmluY2VudCwKCi0tLS0tIFVyc3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPiBWb246ICJWaW5jZW50
IFdoaXRjaHVyY2giIDx2aW5jZW50LndoaXRjaHVyY2hAYXhpcy5jb20+Cj4gQW46ICJyaWNoYXJk
IiA8cmljaGFyZEBub2QuYXQ+Cj4gQ0M6ICJKb2hhbm5lcyBCZXJnIiA8am9oYW5uZXNAc2lwc29s
dXRpb25zLm5ldD4sICJKZWZmIERpa2UiIDxqZGlrZUBhZGR0b2l0LmNvbT4sICJhbnRvbiBpdmFu
b3YiCj4gPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+LCAia2VybmVsIiA8a2VybmVs
QGF4aXMuY29tPiwgImxpbnV4LWtlcm5lbCIgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+
LAo+ICJsaW51eC11bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+LCAiZGV2aWNldHJl
ZSIgPGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnPgo+IEdlc2VuZGV0OiBNaXR0d29jaCwgMjIu
IERlemVtYmVyIDIwMjEgMTE6MjM6NTcKPiBCZXRyZWZmOiBSZTogW1BBVENIIDAvMl0gRGV2aWNl
dHJlZSBzdXBwb3J0IGZvciBVTUwKCj4gT24gVHVlLCBEZWMgMjEsIDIwMjEgYXQgMTA6MTM6MDNQ
TSArMDEwMCwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+PiAtLS0tLSBVcnNwcsO8bmdsaWNo
ZSBNYWlsIC0tLS0tCj4+ID4gVm9uOiAiSm9oYW5uZXMgQmVyZyIgPGpvaGFubmVzQHNpcHNvbHV0
aW9ucy5uZXQ+Cj4+ID4gR2VzZW5kZXQ6IERpZW5zdGFnLCAyMS4gRGV6ZW1iZXIgMjAyMSAyMTo1
Njo1MAo+PiA+IE9uIFR1ZSwgMjAyMS0xMi0yMSBhdCAyMTo1NSArMDEwMCwgUmljaGFyZCBXZWlu
YmVyZ2VyIHdyb3RlOgo+PiA+PiBXQVJOSU5HOiB1bm1ldCBkaXJlY3QgZGVwZW5kZW5jaWVzIGRl
dGVjdGVkIGZvciBPRl9FQVJMWV9GTEFUVFJFRQo+PiA+PiAgIERlcGVuZHMgb24gW25dOiBPRiBb
PW5dCj4+ID4+ICAgU2VsZWN0ZWQgYnkgW3ldOgo+PiA+PiAgIC0gVU1MIFs9eV0KPj4gPj4gCj4+
ID4+IFBsZWFzZSBub3RlIHRoYXQgbXkgVU1MIGNvbmZpZyBoYXMgQ09ORklHX09GPW4uCj4+ID4+
IAo+PiA+IEhtLiBTbyBtYXliZSB0aGF0IG5lZWRzIHRvIGJlCj4+ID4gCj4+ID4Jc2VsZWN0IE9G
X0VBUkxZX0ZMQVRUUkVFIGlmIE9GCj4+IAo+PiBZZWFoLCBJSVJDIGFybSBhbmQgbWlwcyB1c2Ug
c3VjaCBhIHBhdHRlcm4gdG9vLiAgVmluY2VudCwgd2hhdCBkbyB5b3UKPj4gdGhpbms/Cj4gCj4g
WWVzLCB0aGF0IGxvb2tzIGxpa2UgdGhlIGNvcnJlY3QgZml4LiAgSSd2ZSB0ZXN0ZWQgaXQgYW5k
IGl0IHdvcmtzLiAgRG8KPiB5b3UgcHJlZmVyIHRvIGZpeCBpdCB1cCBsb2NhbGx5IG9yIHNob3Vs
ZCBJIHJlcG9zdD8KCkknbGwgZml4IGl0IG15c2VsZi4gOi0pCgpUaGFua3MsCi8vcmljaGFyZAoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0g
bWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

