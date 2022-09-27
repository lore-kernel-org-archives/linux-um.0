Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odI7x-00CiwR-57
	for linux-um@lists.infradead.org; Tue, 27 Sep 2022 21:28:30 +0000
Date: Tue, 27 Sep 2022 14:28:21 -0700
From: "Paul E. McKenney" <paulmck@kernel.org>
Subject: Re: linux-next: Tree for Sep 27 (uml 64-bit or 32-bit: tinyconfig)
Message-ID: <20220927212821.GX4196@paulmck-ThinkPad-P17-Gen-1>
References: <20220927201053.518736-1-broonie@kernel.org>
 <f1b22431-074d-32f1-b67a-34c51e4d072a@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <f1b22431-074d-32f1-b67a-34c51e4d072a@infradead.org>
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: paulmck@kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: broonie@kernel.org, Linux Next Mailing List <linux-next@vger.kernel.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>

T24gVHVlLCBTZXAgMjcsIDIwMjIgYXQgMDI6MTM6MjlQTSAtMDcwMCwgUmFuZHkgRHVubGFwIHdy
b3RlOgo+IAo+IAo+IE9uIDkvMjcvMjIgMTM6MTAsIGJyb29uaWVAa2VybmVsLm9yZyB3cm90ZToK
PiA+IEhpIGFsbCwKPiA+IAo+ID4gQ2hhbmdlcyBzaW5jZSAyMDIyMDkyMzoKPiA+IAo+IAo+IElu
IGZpbGUgaW5jbHVkZWQgZnJvbSAuLi9pbmNsdWRlL2xpbnV4L25vdGlmaWVyLmg6MTYsCj4gICAg
ICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvbWVtb3J5X2hvdHBsdWcuaDo3LAo+
ICAgICAgICAgICAgICAgICAgZnJvbSAuLi9pbmNsdWRlL2xpbnV4L21tem9uZS5oOjEyNDQsCj4g
ICAgICAgICAgICAgICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvZ2ZwLmg6NywKPiAgICAgICAg
ICAgICAgICAgIGZyb20gLi4vaW5jbHVkZS9saW51eC9zbGFiLmg6MTUsCj4gICAgICAgICAgICAg
ICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvY3J5cHRvLmg6MjAsCj4gICAgICAgICAgICAgICAg
ICBmcm9tIC4uL2FyY2gveDg2L3VtL3NoYXJlZC9zeXNkZXAva2VybmVsLW9mZnNldHMuaDo1LAo+
ICAgICAgICAgICAgICAgICAgZnJvbSAuLi9hcmNoL3VtL2tlcm5lbC9hc20tb2Zmc2V0cy5jOjE6
Cj4gLi4vaW5jbHVkZS9saW51eC9zcmN1Lmg6IEluIGZ1bmN0aW9uIOKAmHNyY3VfcmVhZF9sb2Nr
X25taXNhZmXigJk6Cj4gLi4vaW5jbHVkZS9saW51eC9zcmN1Lmg6MTgxOjI2OiBlcnJvcjogaW1w
bGljaXQgZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYX19zcmN1X3JlYWRfbG9ja19ubWlzYWZl
4oCZOyBkaWQgeW91IG1lYW4g4oCYc3JjdV9yZWFkX2xvY2tfbm1pc2FmZeKAmT8gWy1XZXJyb3I9
aW1wbGljaXQtZnVuY3Rpb24tZGVjbGFyYXRpb25dCj4gICAxODEgfCAgICAgICAgICAgICAgICAg
cmV0dmFsID0gX19zcmN1X3JlYWRfbG9ja19ubWlzYWZlKHNzcCwgdHJ1ZSk7Cj4gICAgICAgfCAg
ICAgICAgICAgICAgICAgICAgICAgICAgXn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+Cj4gICAgICAg
fCAgICAgICAgICAgICAgICAgICAgICAgICAgc3JjdV9yZWFkX2xvY2tfbm1pc2FmZQo+IC4uL2lu
Y2x1ZGUvbGludXgvc3JjdS5oOiBJbiBmdW5jdGlvbiDigJhzcmN1X3JlYWRfdW5sb2NrX25taXNh
ZmXigJk6Cj4gLi4vaW5jbHVkZS9saW51eC9zcmN1Lmg6MjI2OjE3OiBlcnJvcjogaW1wbGljaXQg
ZGVjbGFyYXRpb24gb2YgZnVuY3Rpb24g4oCYX19zcmN1X3JlYWRfdW5sb2NrX25taXNhZmXigJk7
IGRpZCB5b3UgbWVhbiDigJhzcmN1X3JlYWRfdW5sb2NrX25taXNhZmXigJk/IFstV2Vycm9yPWlt
cGxpY2l0LWZ1bmN0aW9uLWRlY2xhcmF0aW9uXQo+ICAgMjI2IHwgICAgICAgICAgICAgICAgIF9f
c3JjdV9yZWFkX3VubG9ja19ubWlzYWZlKHNzcCwgaWR4LCB0cnVlKTsKPiAgICAgICB8ICAgICAg
ICAgICAgICAgICBefn5+fn5+fn5+fn5+fn5+fn5+fn5+fn5+fgo+ICAgICAgIHwgICAgICAgICAg
ICAgICAgIHNyY3VfcmVhZF91bmxvY2tfbm1pc2FmZQoKQ291bGQgeW91IHBsZWFzZSBzZW5kIHlv
dXIgLmNvbmZpZyBvciB0ZWxsIG1lIGhvdyB5b3UgZ2VuZXJhdGVkIGl0PwoKCQkJCQkJCVRoYW54
LCBQYXVsCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

