Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jSGVI-0003aV-D8
 for linux-um@lists.infradead.org; Sat, 25 Apr 2020 08:49:43 +0000
Date: Sat, 25 Apr 2020 10:49:28 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <557123184.155536.1587804568614.JavaMail.zimbra@nod.at>
In-Reply-To: <b86f5469f9b888942b7a6f9862ec98c909121375.camel@sipsolutions.net>
References: <20200425042814.132920-1-davidgow@google.com>
 <b86f5469f9b888942b7a6f9862ec98c909121375.camel@sipsolutions.net>
Subject: Re: [PATCH] um: Fix "time-internal.h" include in xor.h
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
Cc: linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, davidgow <davidgow@google.com>, anton ivanov <anton.ivanov@cambridgegreys.com>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkpvaGFubmVzIEJlcmciIDxq
b2hhbm5lc0BzaXBzb2x1dGlvbnMubmV0Pgo+IEFuOiAiZGF2aWRnb3ciIDxkYXZpZGdvd0Bnb29n
bGUuY29tPiwgImFudG9uIGl2YW5vdiIgPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+
LCAicmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0Pgo+IENDOiAibGludXgtdW0iIDxsaW51eC11bUBs
aXN0cy5pbmZyYWRlYWQub3JnPiwgImxpbnV4LWtlcm5lbCIgPGxpbnV4LWtlcm5lbEB2Z2VyLmtl
cm5lbC5vcmc+Cj4gR2VzZW5kZXQ6IFNhbXN0YWcsIDI1LiBBcHJpbCAyMDIwIDEwOjI2OjA0Cj4g
QmV0cmVmZjogUmU6IFtQQVRDSF0gdW06IEZpeCAidGltZS1pbnRlcm5hbC5oIiBpbmNsdWRlIGlu
IHhvci5oCgo+IE9uIEZyaSwgMjAyMC0wNC0yNCBhdCAyMToyOCAtMDcwMCwgRGF2aWQgR293IHdy
b3RlOgo+PiBJdCBsb29rcyBsaWtlIHRoZSB3cm9uZyBoZWFkZXIgd2FzIGluY2x1ZGVkIGluIHhv
ci5oLCBicmVha2luZyBtYWtlCj4+IGFsbHllc2NvbmZpZyBvbiBVTUwgKG9yLCBtb3JlIHNwZWNp
ZmljYWxseSwga3VuaXQucHkgcnVuIC0tYWxsdGVzdHMpLgo+PiAKPj4gLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLQo+PiBJbiBmaWxlIGluY2x1ZGVkIGZyb20gY3J5cHRvL3hvci5jOjE3Ogo+PiAuL2Fy
Y2gvdW0vaW5jbHVkZS9hc20veG9yLmg6MzoxMDogZmF0YWwgZXJyb3I6IHNoYXJlZC90aW1lci1p
bnRlcm5hbC5oOiBObyBzdWNoCj4+IGZpbGUgb3IgZGlyZWN0b3J5Cj4+ICAgICAzIHwgI2luY2x1
ZGUgPHNoYXJlZC90aW1lci1pbnRlcm5hbC5oPgo+PiAgICAgICB8ICAgICAgICAgIF5+fn5+fn5+
fn5+fn5+fn5+fn5+fn5+fn4KPj4gLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+PiAKPj4gUmVwbGFj
aW5nIHRoaXMgd2l0aCAibGludXgvdGltZS1pbnRlcm5hbC5oIiBidWlsZHMgZmluZS4KPj4gCj4+
IEZpeGVzOiBkNjUxOTdhZDUyNDkgKCJ1bTogZml4IHRpbWUtdHJhdmVsPWluZi1jcHUgd2l0aCB4
b3IvcmFpZDYiKQo+IAo+IFllYWgsIHNvcnJ5IGFib3V0IHRoYXQuIFNvbWUgcGF0Y2hlcyBvdmVy
bGFwcGVkIGhlcmUsIGkuZS4gd2VyZSBwZW5kaW5nCj4gZnJvbSBzZXBhcmF0ZSBicmFuY2hlcyBJ
IGhhZC4KPiAKPiBJIHNlbnQgUmljaGFyZCBhIGZpeCBxdWl0ZSBhYm91dCB0aHJlZSB3ZWVrcyBh
Z286Cj4gCj4gaHR0cHM6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wcm9qZWN0L2xpbnV4LXVtL3Bh
dGNoLzIwMjAwNDA1MjEzMzU3LmI2Y2UxMDI0YjI3Ni5JN2MzNzBlMjA1ODBkMzEyMmM1OGRmNTcy
N2VlMmQ2ZmI1MzU0NTU3NkBjaGFuZ2VpZC8KPiAKPiBidXQgSSBndWVzcyBoZSBoYXNuJ3QgYXBw
bGllZCBpdCB5ZXQuCgpUaGF0J3MgcmlnaHQuIEknbGwgcHJlcGFyZSBhIFBSIHdpdGggZml4ZXMg
c29vbi4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5m
cmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xp
bnV4LXVtCg==

