Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZ52L-005Bbw-6r
 for linux-um@lists.infradead.org; Sat, 09 Oct 2021 05:36:46 +0000
Subject: Re: [PATCH] um: Add missing "FORCE" target when using if_changed
References: <20211008215133.9371-1-rdunlap@infradead.org>
 <CABVgOS=QVysVtN5seB5hp7hHAw5P0yuOaA3rgkRtEyiJu-1H6Q@mail.gmail.com>
 <05939461-793d-2266-8752-1b593bab8eec@infradead.org>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <f0ead035-f05b-73fb-1fd4-48c1eff8bc92@cambridgegreys.com>
Date: Sat, 9 Oct 2021 06:36:36 +0100
MIME-Version: 1.0
In-Reply-To: <05939461-793d-2266-8752-1b593bab8eec@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>, David Gow <davidgow@google.com>
Cc: Masahiro Yamada <masahiroy@kernel.org>, Michal Marek <michal.lkml@markovi.net>, Nick Desaulniers <ndesaulniers@google.com>, linux-kbuild@vger.kernel.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, linux-um <linux-um@lists.infradead.org>, x86@kernel.org

T24gMDkvMTAvMjAyMSAwMTowMSwgUmFuZHkgRHVubGFwIHdyb3RlOgo+IE9uIDEwLzgvMjEgNDoy
MyBQTSwgRGF2aWQgR293IHdyb3RlOgo+PiBPbiBTYXQsIE9jdCA5LCAyMDIxIGF0IDU6NTEgQU0g
UmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+IAo+PiB3cm90ZToKPj4+Cj4+PiAn
bWFrZSBBUkNIPXVtJyBzYXlzOgo+Pj4KPj4+IC4uL2FyY2gveDg2L3VtL01ha2VmaWxlOjQ0OiBG
T1JDRSBwcmVyZXF1aXNpdGUgaXMgbWlzc2luZwo+Pj4KPj4+IGFuZCBhZGRpbmcgIkZPUkNFIiB0
aGVyZSBtYWtlcyBpdCBiZSBxdWlldCwgc28gZG8gaXQuwqAgOikKPj4+Cj4+PiBGaXhlczogZTFm
ODZkN2I0YjJhICgia2J1aWxkOiB3YXJuIGlmIEZPUkNFIGlzIG1pc3NpbmcgZm9yIAo+Pj4gaWZf
Y2hhbmdlZChfZGVwLF9ydWxlKSBhbmQgZmlsZWNoayIpCj4+PiBTaWduZWQtb2ZmLWJ5OiBSYW5k
eSBEdW5sYXAgPHJkdW5sYXBAaW5mcmFkZWFkLm9yZz4KPj4+IENjOiBNYXNhaGlybyBZYW1hZGEg
PG1hc2FoaXJveUBrZXJuZWwub3JnPgo+Pj4gQ2M6IE1pY2hhbCBNYXJlayA8bWljaGFsLmxrbWxA
bWFya292aS5uZXQ+Cj4+PiBDYzogTmljayBEZXNhdWxuaWVycyA8bmRlc2F1bG5pZXJzQGdvb2ds
ZS5jb20+Cj4+PiBDYzogbGludXgta2J1aWxkQHZnZXIua2VybmVsLm9yZwo+Pj4gQ2M6IEplZmYg
RGlrZSA8amRpa2VAYWRkdG9pdC5jb20+Cj4+PiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNo
YXJkQG5vZC5hdD4KPj4+IENjOiBBbnRvbiBJdmFub3YgPGFudG9uLml2YW5vdkBjYW1icmlkZ2Vn
cmV5cy5jb20+Cj4+PiBDYzogbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwo+Pj4gQ2M6IHg4
NkBrZXJuZWwub3JnCj4+PiAtLS0KPj4KPj4gRllJLCB0aGlzIGxvb2tzIGlkZW50aWNhbCB0byAi
dW1sOiB4ODY6IGFkZCBGT1JDRSB0byB1c2VyX2NvbnN0YW50cy5oIjoKPj4gaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvcGlwZXJtYWlsL2xpbnV4LXVtLzIwMjEtU2VwdGVtYmVyLzAwMTc5MS5o
dG1sCj4KPiBPaCwgdGhhbmtzIGZvciB0aGF0Lgo+Cj4gTWFpbnRhaW5lcnM/Li4uCj4KVGhlIHBh
dGNoIGJ5IEpvaGFubmVzIGlzIG5vdCBpbiB0aGUgcGVuZGluZyBsaXN0IGluIHBhdGNod29yaywg
c28gaXQgCmxvb2tzIGxpa2UgUmljaGFyZCBoYXMgcHJvY2Vzc2VkIGl0IGFuZCBpdCB3aWxsIGJl
IGluIHRoZSBuZXh0IHB1bGwgcmVxdWVzdC4KCkJyZ2RzLAoKLS0gCkFudG9uIFIuIEl2YW5vdgpD
YW1icmlkZ2VncmV5cyBMaW1pdGVkLiBSZWdpc3RlcmVkIGluIEVuZ2xhbmQuIENvbXBhbnkgTnVt
YmVyIDEwMjczNjYxCmh0dHBzOi8vd3d3LmNhbWJyaWRnZWdyZXlzLmNvbS8KCgpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxp
c3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

