Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jbMdI-0003mp-Hw
 for linux-um@lists.infradead.org; Wed, 20 May 2020 11:11:34 +0000
Date: Wed, 20 May 2020 20:11:26 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 13/20] maccess: always use strict semantics for
 probe_kernel_read
Message-Id: <20200520201126.f37d3b1e46355199216404e2@kernel.org>
In-Reply-To: <20200519134449.1466624-14-hch@lst.de>
References: <20200519134449.1466624-1-hch@lst.de>
 <20200519134449.1466624-14-hch@lst.de>
Mime-Version: 1.0
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
To: Christoph Hellwig <hch@lst.de>
Cc: linux-parisc@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org, x86@kernel.org, linux-um@lists.infradead.org, Alexei Starovoitov <ast@kernel.org>, linux-kernel@vger.kernel.org, linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>, Linus Torvalds <torvalds@linux-foundation.org>, bpf@vger.kernel.org

T24gVHVlLCAxOSBNYXkgMjAyMCAxNTo0NDo0MiArMDIwMApDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGxzdC5kZT4gd3JvdGU6Cgo+IGRpZmYgLS1naXQgYS9rZXJuZWwvdHJhY2UvdHJhY2Vfa3Byb2Jl
LmMgYi9rZXJuZWwvdHJhY2UvdHJhY2Vfa3Byb2JlLmMKPiBpbmRleCAyZjY3MzdjYzUzZTZjLi44
MmRhMjBlNzEyNTA3IDEwMDY0NAo+IC0tLSBhL2tlcm5lbC90cmFjZS90cmFjZV9rcHJvYmUuYwo+
ICsrKyBiL2tlcm5lbC90cmFjZS90cmFjZV9rcHJvYmUuYwo+IEBAIC0xMjA4LDcgKzEyMDgsMTMg
QEAgZmV0Y2hfc3RvcmVfc3RybGVuKHVuc2lnbmVkIGxvbmcgYWRkcikKPiAgCXU4IGM7Cj4gIAo+
ICAJZG8gewo+IC0JCXJldCA9IHByb2JlX2tlcm5lbF9yZWFkKCZjLCAodTggKilhZGRyICsgbGVu
LCAxKTsKPiArCQlpZiAoSVNfRU5BQkxFRChDT05GSUdfQVJDSF9IQVNfTk9OX09WRVJMQVBQSU5H
X0FERFJFU1NfU1BBQ0UpICYmCj4gKwkJICAgICh1bnNpZ25lZCBsb25nKWFkZHIgPCBUQVNLX1NJ
WkUpIHsKPiArCQkJcmV0ID0gcHJvYmVfdXNlcl9yZWFkKCZjLAo+ICsJCQkJKF9fZm9yY2UgdTgg
X191c2VyICopYWRkciArIGxlbiwgMSk7Cj4gKwkJfSBlbHNlIHsKPiArCQkJcmV0ID0gcHJvYmVf
a2VybmVsX3JlYWQoJmMsICh1OCAqKWFkZHIgKyBsZW4sIDEpOwo+ICsJCX0KPiAgCQlsZW4rKzsK
PiAgCX0gd2hpbGUgKGMgJiYgcmV0ID09IDAgJiYgbGVuIDwgTUFYX1NUUklOR19TSVpFKTsKClRv
IGF2b2lkIHJlZHVuZGFudCBjaGVjayBpbiB0aGUgbG9vcCwgd2UgY2FuIHVzZSBzdHJubGVuX3Vz
ZXJfbm9mYXVsdCgpIG91dCBvZgp0aGUgbG9vcC4gU29tZXRoaW5nIGxpa2UgYmVsb3cuCgouLi4K
CXU4IGM7CgoJaWYgKElTX0VOQUJMRUQoQ09ORklHX0FSQ0hfSEFTX05PTl9PVkVSTEFQUElOR19B
RERSRVNTX1NQQUNFKSAmJgoJICAgICh1bnNpZ25lZCBsb25nKWFkZHIgPCBUQVNLX1NJWkUpIHsK
CQlyZXR1cm4gc3Rybmxlbl91c2VyX25vZmF1bHQoKF9fZm9yY2UgdTggX191c2VyICopYWRkciwg
TUFYX1NUUklOR19TSVpFKTsKCglkbyB7CgkJcmV0ID0gcHJvYmVfa2VybmVsX3JlYWQoJmMsICh1
OCAqKWFkZHIgKyBsZW4sIDEpOwoJCWxlbisrOwoJfSB3aGlsZSAoYyAmJiByZXQgPT0gMCAmJiBs
ZW4gPCBNQVhfU1RSSU5HX1NJWkUpOwouLi4KClRoaXMgbXVzdCB3b3JrIGJlY2F1c2Ugd2UgbXVz
dCBub3QgaGF2ZSBhIHN0cmluZyB0aGF0IGNvbnRpbnVlcyBhY3Jvc3MKa2VybmVs44CAc3BhY2Ug
YW5kIHVzZXIgc3BhY2UuCgpUaGFuayB5b3UsCgoKLS0gCk1hc2FtaSBIaXJhbWF0c3UgPG1oaXJh
bWF0QGtlcm5lbC5vcmc+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9y
ZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

