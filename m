Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzmJm-008WSc-BY
 for linux-um@lists.infradead.org; Tue, 21 Dec 2021 21:05:07 +0000
Date: Tue, 21 Dec 2021 22:05:03 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
In-Reply-To: <20211215165612.554426-1-hch@lst.de>
References: <20211215165612.554426-1-hch@lst.de>
Subject: Re: remove set_fs for UML
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
To: hch <hch@lst.de>
Cc: anton ivanov <anton.ivanov@cambridgegreys.com>, x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

Q2hyaXN0b3BoLAoKLS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImhjaCIg
PGhjaEBsc3QuZGU+Cj4gQW46ICJyaWNoYXJkIiA8cmljaGFyZEBub2QuYXQ+LCAiYW50b24gaXZh
bm92IiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBDQzogIng4NiIgPHg4NkBr
ZXJuZWwub3JnPiwgImxpbnV4LXVtIiA8bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZz4sICJs
aW51eC1rZXJuZWwiIDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPgo+IEdlc2VuZGV0OiBN
aXR0d29jaCwgMTUuIERlemVtYmVyIDIwMjEgMTc6NTY6MTAKPiBCZXRyZWZmOiByZW1vdmUgc2V0
X2ZzIGZvciBVTUwKCj4gSGkgUmljaGFyZCBhbmQgQW50b24sCj4gCj4gdGhpcyBzZXJpZXMgcmVt
b3ZlcyBhZGRyZXNzIHNwYWNlIG92ZXJyaWRlcyB1c2luZyBzZXRfZnMgZm9yIFVNTC4KPiAKPiBE
aWZmc3RhdDoKPiB1bS9LY29uZmlnICAgICAgICAgICAgICAgICAgIHwgICAgMSAtCj4gdW0vaW5j
bHVkZS9hc20vdGhyZWFkX2luZm8uaCB8ICAgIDQgLS0tLQo+IHVtL2luY2x1ZGUvYXNtL3VhY2Nl
c3MuaCAgICAgfCAgIDIxICsrKysrKysrKysrKysrKysrKystLQo+IHVtL2tlcm5lbC9za2FzL3Vh
Y2Nlc3MuYyAgICAgfCAgIDI1IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiB4ODYvaW5jbHVk
ZS9hc20vbXRyci5oICAgICAgIHwgICAgOCArLS0tLS0tLQo+IHg4Ni9rZXJuZWwvc2V0dXAuYyAg
ICAgICAgICAgfCAgICA3ICsrKysrKy0KPiB4ODYvdW0vYXNtL3NlZ21lbnQuaCAgICAgICAgIHwg
ICAgOCAtLS0tLS0tLQo+ICA3IGZpbGVzIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDQ4IGRl
bGV0aW9ucygtKQoKU28gZmFyIFVNTCBzZWVtcyB0byB3b3JrIHdpdGggdGhlc2UgY2hhbmdlcyBh
cHBsaWVkLiA6LSkKSSBoYXZlIGFwcGxpZWQgYm90aCBwYXRjaGVzIHRvIG15IFVNTCB0cmVlIGZv
ciBub3csIEkgYXNzdW1lIHg4NiBtYWludGFpbmVycyBhcmUgZmluZSB3aXRoCnBhdGNoIDEvMj8K
ClRoYW5rcy4KLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==

