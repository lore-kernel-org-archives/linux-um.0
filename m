Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg4Ei-008d1W-CM
 for linux-um@lists.infradead.org; Mon, 10 May 2021 11:38:11 +0000
Message-ID: <2a46ca787df9a44c8b4fbc17ab6b69247ab38400.camel@sipsolutions.net>
Subject: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix
 module gcov
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 10 May 2021 13:37:53 +0200
In-Reply-To: <tencent_99073B61C8137C88B76C231139F94EFB3805@qq.com>
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>
 <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>
 <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>
 <tencent_99073B61C8137C88B76C231139F94EFB3805@qq.com>
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
To: Lambert <lambertdev@qq.com>, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch@vger.kernel.org, linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>, linux-um@lists.infradead.org, "Lambert." <lambertdev@foxmail.com>

SGksCgo+IEhpIEpvaGFubmVzIGFuZCBQZXRlciwgc29ycnkgdG8gYm90aGVyIGJ1dCBJIGhhdmUg
b25lIHF1ZXN0aW9uIAo+IG9uIHRoaXMgY2hhbmdlLiBUaGUgZG9fY3RvcnMoKSB3b27igJl0IGJl
IGV4ZWN1dGVkIGZvciBVTUwgCj4gYmVjYXVzZSAgKnRoZSBjb25zdHJ1Y3RvcnMgaGF2ZSBhbHJl
YWR5IGJlZW4gY2FsbGVkIGZvciBFTEYqLiAKPiAKPiAqX19jdG9yc19zdGFydCogIGFuZCAgKl9f
Y3RvcnNfZW5kKiBzeW1ib2xzLiBTZWUgbGluazoKPiBodHRwczovL2VsaXhpci5ib290bGluLmNv
bS9saW51eC92NS4xMi4yL3NvdXJjZS9pbmNsdWRlL2FzbS1nZW5lcmljL3ZtbGludXgubGRzLmgj
TDY3Ngo+IAo+IEluIG15IGVudmlyb25tZW50LCBVTUwrR0NDIDEwLCBJIGNhbid0IGZpbmQgX19n
Y292X2luaXQgZXhlY3V0ZWQgCj4gYmVmb3JlIGtlcm5lbCBzdGFydHMuIFNvIEkgZGlkIHNvbWUg
dHJhY2UgYW5kIGZvdW5kIGdsaWJjCj4gX19saWJjX2NzdV9pbml0IAo+IHdpbGwgb25seSBleGVj
dXRlIGNvbnN0cnVjdG9ycyBiZXR3ZWVuICpfX2luaXRfYXJyYXlfc3RhcnQqYW5kCj4gKl9faW5p
dF9hcnJheV9lbmQqLiAgCj4gV2hpY2ggbWVhbnMgaWYgZG9fY3RvcnMoKSBpcyBub3QgZXhlY3V0
ZWQgZm9yIFVNTCwgbm8gZWxzZXdoZXJlIHdpbGwgCj4gdGhlIGNvbnN0cnVjdG9ycyBiZSBleGVj
dXRlZC4KPiAKPiBTaGFsbCB3ZSByZW1vdmUgdGhlICohZGVmaW5lZChDT05GSUdfVU1MKSogZm9y
IEdDQywgb3IgSSBqdXN0IG1pc3NlZCAKPiBzb21lIHN0ZXBzIHRvIG1ha2UgdGhlIEdDT1Ygd29y
ayBmb3IgVU1MPyAKCk5vLCB0aGF0IGRvZXNuJ3Qgc2VlbSBsaWtlIHRoZSByaWdodCBzb2x1dGlv
bi4KClBlcmhhcHMgdGhlbiB3aXRoIHRoYXQgdG9vbGNoYWluIChvciBjb25maWd1cmF0aW9uIHRo
ZXJlb2YpIHdlIG5lZWQgdG8KcHJvdmlkZSBfX2luaXRfYXJyYXlfc3RhcnQvZW5kIGxhYmVscz8K
Ck9yIC4uLiBtYXliZSB0aGF0IGFjdHVhbGx5IGp1c3QgbmVlZHMgdG8gYmUgcmVtb3ZlZCwgc28g
dGhhdCB0aGUKdG9vbGNoYWluIGdldHMgdG8gY2hvb3NlPwoKSG1tLiBQcmV0dHkgc3VyZSBpdCB3
b3JrZWQgZm9yIG1lLCBJIHRoaW5rIGFsc28gd2l0aCBnY2MgMTAsIGJ1dCBub3QKc3VyZSBleGFj
dGx5IHdoZXJlIEkgdGVzdGVkLgoKam9oYW5uZXMKCgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxp
c3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0
aW5mby9saW51eC11bQo=

