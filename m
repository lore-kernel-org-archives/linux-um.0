Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mk1ou-00G27W-Et
 for linux-um@lists.infradead.org; Mon, 08 Nov 2021 10:24:10 +0000
Message-ID: <129beb0a860102ba7970ab7497a5a83fe2041e68.camel@sipsolutions.net>
Subject: Re: [PATCH v0 25/42] arch/um: Check notifier registration return value
From: Johannes Berg <johannes@sipsolutions.net>
Date: Mon, 08 Nov 2021 11:23:59 +0100
In-Reply-To: <20211108101157.15189-26-bp@alien8.de>
References: <20211108101157.15189-1-bp@alien8.de>
 <20211108101157.15189-26-bp@alien8.de>
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
To: Borislav Petkov <bp@alien8.de>, LKML <linux-kernel@vger.kernel.org>
Cc: linux-um@lists.infradead.org

T24gTW9uLCAyMDIxLTExLTA4IGF0IDExOjExICswMTAwLCBCb3Jpc2xhdiBQZXRrb3Ygd3JvdGU6
Cj4gRnJvbTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPgo+IAo+IEF2b2lkIGhvbWVncm93
biBub3RpZmllciByZWdpc3RyYXRpb24gY2hlY2tzLgo+IAo+IE5vIGZ1bmN0aW9uYWwgY2hhbmdl
cy4KPiAKPiBTaWduZWQtb2ZmLWJ5OiBCb3Jpc2xhdiBQZXRrb3YgPGJwQHN1c2UuZGU+Cj4gQ2M6
IGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKPiAtLS0KPiDCoGFyY2gvdW0vZHJpdmVycy9t
Y29uc29sZV9rZXJuLmMgfCA2ICsrKystLQo+IMKgYXJjaC91bS9rZXJuZWwvdW1fYXJjaC5jICAg
ICAgICB8IDUgKysrLS0KPiDCoDIgZmlsZXMgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA0IGRl
bGV0aW9ucygtKQo+IAo+IGRpZmYgLS1naXQgYS9hcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vy
bi5jIGIvYXJjaC91bS9kcml2ZXJzL21jb25zb2xlX2tlcm4uYwo+IGluZGV4IDZlYWQxZTI0MDQ1
Ny4uY2VlYTk0MGMwYWEwIDEwMDY0NAo+IC0tLSBhL2FyY2gvdW0vZHJpdmVycy9tY29uc29sZV9r
ZXJuLmMKPiArKysgYi9hcmNoL3VtL2RyaXZlcnMvbWNvbnNvbGVfa2Vybi5jCj4gQEAgLTg1Niw4
ICs4NTYsMTAgQEAgc3RhdGljIHN0cnVjdCBub3RpZmllcl9ibG9jayBwYW5pY19leGl0X25vdGlm
aWVyID0gewo+IMKgCj4gCj4gwqBzdGF0aWMgaW50IGFkZF9ub3RpZmllcih2b2lkKQo+IMKgewo+
IC0JYXRvbWljX25vdGlmaWVyX2NoYWluX3JlZ2lzdGVyKCZwYW5pY19ub3RpZmllcl9saXN0LAo+
IC0JCQkmcGFuaWNfZXhpdF9ub3RpZmllcik7Cj4gKwlpZiAoYXRvbWljX25vdGlmaWVyX2NoYWlu
X3JlZ2lzdGVyKCZwYW5pY19ub3RpZmllcl9saXN0LAo+ICsJCQkJCSAgICZwYW5pY19leGl0X25v
dGlmaWVyKSkKPiArCQlwcl93YXJuKCJVTSBjb25zb2xlIHBhbmljIG5vdGlmaWVyIGFscmVhZHkg
cmVnaXN0ZXJlZFxuIik7Cj4gKwo+IMKgCXJldHVybiAwOwoKTWF5YmUgaXQgc2hvdWxkIGp1c3Qg
cmV0dXJuIGl0PyBJIGRvbid0IHNlZSBob3cgdGhpcyBpcyBldmVyIHBvc3NpYmxlLApzaW5jZSBp
dCdzIGFuIGluaXRjYWxsLgoKam9oYW5uZXMKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXVtCg==

