Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mx2.smtp.larsendata.com ([91.221.196.228])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mZygf-00AAbF-2d
 for linux-um@lists.infradead.org; Mon, 11 Oct 2021 17:02:06 +0000
Date: Mon, 11 Oct 2021 19:02:00 +0200
From: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH v2] drm/r128: fix build for UML
Message-ID: <YWRuCCkBOhQ5gN+b@ravnborg.org>
References: <20211011080006.31081-1-rdunlap@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20211011080006.31081-1-rdunlap@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-kernel@vger.kernel.org, David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>, dri-devel@lists.freedesktop.org, Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-um@lists.infradead.org

T24gTW9uLCBPY3QgMTEsIDIwMjEgYXQgMDE6MDA6MDZBTSAtMDcwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOgo+IEZpeCBhIGJ1aWxkIGVycm9yIG9uIENPTkZJR19VTUwsIHdoaWNoIGRvZXMgbm90IHN1
cHBvcnQgKHByb3ZpZGUpCj4gd2JpbnZkKCkuIFVNTCBjYW4gdXNlIHRoZSBnZW5lcmljIG1iKCkg
aW5zdGVhZC4KPiAKPiAuLi9kcml2ZXJzL2dwdS9kcm0vcjEyOC9hdGlfcGNpZ2FydC5jOiBJbiBm
dW5jdGlvbiDigJhkcm1fYXRpX3BjaWdhcnRfaW5pdOKAmToKPiAuLi9kcml2ZXJzL2dwdS9kcm0v
cjEyOC9hdGlfcGNpZ2FydC5jOjIxODoyOiBlcnJvcjogaW1wbGljaXQgZGVjbGFyYXRpb24gb2Yg
ZnVuY3Rpb24g4oCYd2JpbnZk4oCZIFstV2Vycm9yPWltcGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0
aW9uXQo+ICAgd2JpbnZkKCk7Cj4gICBefn5+fn4KPiAKPiBGaXhlczogNjhmNWQzZjNiNjU0ICgi
dW06IGFkZCBQQ0kgb3ZlciB2aXJ0aW8gZW11bGF0aW9uIGRyaXZlciIpCj4gU2lnbmVkLW9mZi1i
eTogUmFuZHkgRHVubGFwIDxyZHVubGFwQGluZnJhZGVhZC5vcmc+Cj4gQ2M6IERhdmlkIEFpcmxp
ZSA8YWlybGllZEBsaW51eC5pZT4KPiBDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
Pgo+IENjOiBkcmktZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4gQ2M6IEplZmYgRGlrZSA8
amRpa2VAYWRkdG9pdC5jb20+Cj4gQ2M6IFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2Qu
YXQ+Cj4gQ2M6IEFudG9uIEl2YW5vdiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4K
PiBDYzogbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwo+IENjOiBTYW0gUmF2bmJvcmcgPHNh
bUByYXZuYm9yZy5vcmc+CgpBcHBsaWVkIHRvIGRybS1taXNjLWZpeGVzLiBJIHdhcyBub3Qgc3Vy
ZSBpZiB0aGlzIHdhcyB1cmdlbnQgZW5vdWdoIGZvcgpmaXhlcyBidXQgc2luY2UgaXQgZml4ZXMg
dGhlIFVNIGJ1aWxkIEkgZW5kZWQgdXAgZmFzdCB0cmFja2luZyBpdCB0bwptYXN0ZXIuCgoJU2Ft
Cgo+IC0tLQo+IHYyOiB1cGRhdGUgRml4ZXM6IHRhZyAoSm9oYW5uZXMpCj4gICAgIFVzZSBzaW1w
bGUgQ09ORklHX1g4NiBpbnN0ZWFkIG9mIGEgbW9yZSBjb21wbGljYXRlZCBleHByZXNzaW9uLiAo
U2FtKQo+IAo+ICBkcml2ZXJzL2dwdS9kcm0vcjEyOC9hdGlfcGNpZ2FydC5jIHwgICAgMiArLQo+
ICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPiAKPiAtLS0g
bGludXgtbmV4dC0yMDIxMTAwNy5vcmlnL2RyaXZlcnMvZ3B1L2RybS9yMTI4L2F0aV9wY2lnYXJ0
LmMKPiArKysgbGludXgtbmV4dC0yMDIxMTAwNy9kcml2ZXJzL2dwdS9kcm0vcjEyOC9hdGlfcGNp
Z2FydC5jCj4gQEAgLTIxNSw3ICsyMTUsNyBAQCBpbnQgZHJtX2F0aV9wY2lnYXJ0X2luaXQoc3Ry
dWN0IGRybV9kZXZpCj4gIAl9Cj4gIAlyZXQgPSAwOwo+ICAKPiAtI2lmIGRlZmluZWQoX19pMzg2
X18pIHx8IGRlZmluZWQoX194ODZfNjRfXykKPiArI2lmZGVmIENPTkZJR19YODYKPiAgCXdiaW52
ZCgpOwo+ICAjZWxzZQo+ICAJbWIoKTsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K

