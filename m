Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [PATCH v2] drm/r128: fix build for UML
References: <20211011080006.31081-1-rdunlap@infradead.org>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <95f6d5b9-1aa8-9093-4356-df3f79c41faf@infradead.org>
Date: Mon, 11 Oct 2021 01:02:16 -0700
MIME-Version: 1.0
In-Reply-To: <20211011080006.31081-1-rdunlap@infradead.org>
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
To: linux-kernel@vger.kernel.org
Cc: David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org, Sam Ravnborg <sam@ravnborg.org>

T24gMTAvMTEvMjEgMTowMCBBTSwgUmFuZHkgRHVubGFwIHdyb3RlOgo+IEZpeCBhIGJ1aWxkIGVy
cm9yIG9uIENPTkZJR19VTUwsIHdoaWNoIGRvZXMgbm90IHN1cHBvcnQgKHByb3ZpZGUpCj4gd2Jp
bnZkKCkuIFVNTCBjYW4gdXNlIHRoZSBnZW5lcmljIG1iKCkgaW5zdGVhZC4KPiAKPiAuLi9kcml2
ZXJzL2dwdS9kcm0vcjEyOC9hdGlfcGNpZ2FydC5jOiBJbiBmdW5jdGlvbiDigJhkcm1fYXRpX3Bj
aWdhcnRfaW5pdOKAmToKPiAuLi9kcml2ZXJzL2dwdS9kcm0vcjEyOC9hdGlfcGNpZ2FydC5jOjIx
ODoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYd2JpbnZk4oCZ
IFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgIHdiaW52ZCgpOwo+
ICAgIF5+fn5+fgo+IAo+IEZpeGVzOiA2OGY1ZDNmM2I2NTQgKCJ1bTogYWRkIFBDSSBvdmVyIHZp
cnRpbyBlbXVsYXRpb24gZHJpdmVyIikKPiBTaWduZWQtb2ZmLWJ5OiBSYW5keSBEdW5sYXAgPHJk
dW5sYXBAaW5mcmFkZWFkLm9yZz4KPiBDYzogRGF2aWQgQWlybGllIDxhaXJsaWVkQGxpbnV4Lmll
Pgo+IENjOiBEYW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+Cj4gQ2M6IGRyaS1kZXZlbEBs
aXN0cy5mcmVlZGVza3RvcC5vcmcKPiBDYzogSmVmZiBEaWtlIDxqZGlrZUBhZGR0b2l0LmNvbT4K
PiBDYzogUmljaGFyZCBXZWluYmVyZ2VyIDxyaWNoYXJkQG5vZC5hdD4KPiBDYzogQW50b24gSXZh
bm92IDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+IENjOiBsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCj4gQ2M6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4KPiAt
LS0KPiB2MjogdXBkYXRlIEZpeGVzOiB0YWcgKEpvaGFubmVzKQo+ICAgICAgVXNlIHNpbXBsZSBD
T05GSUdfWDg2IGluc3RlYWQgb2YgYSBtb3JlIGNvbXBsaWNhdGVkIGV4cHJlc3Npb24uIChTYW0p
Cj4gCgpPb3BzLCBhcHBhcmVudGx5IEkgY2FuJ3QgY291bnQgYW5kIHRoaXMgaXMgdjMuLi4gOigK
Cj4gICBkcml2ZXJzL2dwdS9kcm0vcjEyOC9hdGlfcGNpZ2FydC5jIHwgICAgMiArLQo+ICAgMSBm
aWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gLS0tIGxpbnV4
LW5leHQtMjAyMTEwMDcub3JpZy9kcml2ZXJzL2dwdS9kcm0vcjEyOC9hdGlfcGNpZ2FydC5jCj4g
KysrIGxpbnV4LW5leHQtMjAyMTEwMDcvZHJpdmVycy9ncHUvZHJtL3IxMjgvYXRpX3BjaWdhcnQu
Ywo+IEBAIC0yMTUsNyArMjE1LDcgQEAgaW50IGRybV9hdGlfcGNpZ2FydF9pbml0KHN0cnVjdCBk
cm1fZGV2aQo+ICAgCX0KPiAgIAlyZXQgPSAwOwo+ICAgCj4gLSNpZiBkZWZpbmVkKF9faTM4Nl9f
KSB8fCBkZWZpbmVkKF9feDg2XzY0X18pCj4gKyNpZmRlZiBDT05GSUdfWDg2Cj4gICAJd2JpbnZk
KCk7Cj4gICAjZWxzZQo+ICAgCW1iKCk7Cj4gCgoKLS0gCn5SYW5keQoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0Cmxp
bnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC11bQo=

