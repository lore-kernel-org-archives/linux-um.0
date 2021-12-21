Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzmRW-008Wpp-BY
 for linux-um@lists.infradead.org; Tue, 21 Dec 2021 21:13:07 +0000
Date: Tue, 21 Dec 2021 22:13:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1446970217.191062.1640121183419.JavaMail.zimbra@nod.at>
In-Reply-To: <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
 <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
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
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Vincent Whitchurch <vincent.whitchurch@axis.com>, Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, kernel <kernel@axis.com>, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkpvaGFubmVzIEJlcmciIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IEFuOiAicmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0
PiwgIlZpbmNlbnQgV2hpdGNodXJjaCIgPHZpbmNlbnQud2hpdGNodXJjaEBheGlzLmNvbT4KPiBD
QzogIkplZmYgRGlrZSIgPGpkaWtlQGFkZHRvaXQuY29tPiwgImFudG9uIGl2YW5vdiIgPGFudG9u
Lml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+LCAia2VybmVsIiA8a2VybmVsQGF4aXMuY29tPiwK
PiAibGludXgta2VybmVsIiA8bGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZz4sICJsaW51eC11
bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+LCAiZGV2aWNldHJlZSIKPiA8ZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc+Cj4gR2VzZW5kZXQ6IERpZW5zdGFnLCAyMS4gRGV6ZW1iZXIg
MjAyMSAyMTo1Njo1MAo+IEJldHJlZmY6IFJlOiBbUEFUQ0ggMC8yXSBEZXZpY2V0cmVlIHN1cHBv
cnQgZm9yIFVNTAoKPiBPbiBUdWUsIDIwMjEtMTItMjEgYXQgMjE6NTUgKzAxMDAsIFJpY2hhcmQg
V2VpbmJlcmdlciB3cm90ZToKPj4gVmluY2VudCwKPj4gCj4+IC0tLS0tIFVyc3Byw7xuZ2xpY2hl
IE1haWwgLS0tLS0KPj4gPiBWb246ICJWaW5jZW50IFdoaXRjaHVyY2giIDx2aW5jZW50LndoaXRj
aHVyY2hAYXhpcy5jb20+Cj4+ID4gQW46ICJKZWZmIERpa2UiIDxqZGlrZUBhZGR0b2l0LmNvbT4s
ICJyaWNoYXJkIiA8cmljaGFyZEBub2QuYXQ+LCAiYW50b24gaXZhbm92Igo+PiA+IDxhbnRvbi5p
dmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+PiA+IENDOiBrZXJuZWxAYXhpcy5jb20sICJsaW51
eC1rZXJuZWwiIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwgImxpbnV4LXVtIgo+PiA+
IDxsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnPiwKPj4gPiAiZGV2aWNldHJlZSIgPGRldmlj
ZXRyZWVAdmdlci5rZXJuZWwub3JnPiwgIlZpbmNlbnQgV2hpdGNodXJjaCIKPj4gPiA8dmluY2Vu
dC53aGl0Y2h1cmNoQGF4aXMuY29tPgo+PiA+IEdlc2VuZGV0OiBNaXR0d29jaCwgOC4gRGV6ZW1i
ZXIgMjAyMSAxNjoxMToyMQo+PiA+IEJldHJlZmY6IFtQQVRDSCAwLzJdIERldmljZXRyZWUgc3Vw
cG9ydCBmb3IgVU1MCj4+IAo+PiA+IFRoaXMgc2VyaWVzIGFkZCBzdXBwb3J0IGZvciBwYXNzaW5n
IGEgZGV2aWNldHJlZSBibG9iIHRvIFVNTC4gIEl0IGNhbiBiZSB1c2VkCj4+ID4gZm9yIHRlc3Rp
bmcgZGV2aWNlIGRyaXZlcnMuCj4+IAo+PiBOaWNlIGZlYXR1cmUuCj4+IENvZGUgbG9va3MgZ29v
ZCBzbyBmYXIuIEJ1dCB3aGlsZSBidWlsZGluZyBJJ20gZmFjaW5nIHRoaXMgd2FybmluZzoKPj4g
Cj4+IFdBUk5JTkc6IHVubWV0IGRpcmVjdCBkZXBlbmRlbmNpZXMgZGV0ZWN0ZWQgZm9yIE9GX0VB
UkxZX0ZMQVRUUkVFCj4+ICAgRGVwZW5kcyBvbiBbbl06IE9GIFs9bl0KPj4gICBTZWxlY3RlZCBi
eSBbeV06Cj4+ICAgLSBVTUwgWz15XQo+PiAKPj4gCj4+IFBsZWFzZSBub3RlIHRoYXQgbXkgVU1M
IGNvbmZpZyBoYXMgQ09ORklHX09GPW4uCj4+IAo+IAo+IEhtLiBTbyBtYXliZSB0aGF0IG5lZWRz
IHRvIGJlCj4gCj4Jc2VsZWN0IE9GX0VBUkxZX0ZMQVRUUkVFIGlmIE9GCgpZZWFoLCBJSVJDIGFy
bSBhbmQgbWlwcyB1c2Ugc3VjaCBhIHBhdHRlcm4gdG9vLgpWaW5jZW50LCB3aGF0IGRvIHlvdSB0
aGluaz8KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==

