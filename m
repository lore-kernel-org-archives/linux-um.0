Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ams.source.kernel.org ([145.40.68.75])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nUztY-0001Y5-Td
 for linux-um@lists.infradead.org; Thu, 17 Mar 2022 23:51:06 +0000
Date: Thu, 17 Mar 2022 16:51:00 -0700
From: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: mmotm 2022-03-16-17-42 uploaded (uml sub-x86_64, sched/fair, RCU)
Message-Id: <20220317165100.2755c5ae6a3a08b7ecb06181@linux-foundation.org>
In-Reply-To: <917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org>
References: <20220317004304.95F89C340E9@smtp.kernel.org>
 <0f622499-36e1-ea43-ddc3-a8b3bb08d34b@infradead.org>
 <20220316213011.8cac447e692283a4b5d97f3d@linux-foundation.org>
 <917e9ce0-c8cf-61b2-d1ba-ebf25bbd979d@infradead.org>
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
To: Randy Dunlap <rdunlap@infradead.org>
Cc: broonie@kernel.org, mhocko@suse.cz, sfr@canb.auug.org.au, linux-next@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, mm-commits@vger.kernel.org, linux-um <linux-um@lists.infradead.org>, paulmck@kernel.org, Richard Weinberger <richard@nod.at>, Johannes Berg <johannes@sipsolutions.net>

T24gV2VkLCAxNiBNYXIgMjAyMiAyMTo1Mjo0NCAtMDcwMCBSYW5keSBEdW5sYXAgPHJkdW5sYXBA
aW5mcmFkZWFkLm9yZz4gd3JvdGU6Cgo+ID4+IEluIGZpbGUgaW5jbHVkZWQgZnJvbSAuL2FyY2gv
eDg2L2luY2x1ZGUvZ2VuZXJhdGVkL2FzbS9yd29uY2UuaDoxOjAsCj4gPj4gICAgICAgICAgICAg
ICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvY29tcGlsZXIuaDoyNDgsCj4gPj4gICAgICAgICAg
ICAgICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgva2VybmVsLmg6MjAsCj4gPj4gICAgICAgICAg
ICAgICAgICBmcm9tIC4uL2luY2x1ZGUvbGludXgvY3B1bWFzay5oOjEwLAo+ID4+ICAgICAgICAg
ICAgICAgICAgZnJvbSAuLi9pbmNsdWRlL2xpbnV4L2VuZXJneV9tb2RlbC5oOjQsCj4gPj4gICAg
ICAgICAgICAgICAgICBmcm9tIC4uL2tlcm5lbC9zY2hlZC9mYWlyLmM6MjM6Cj4gPj4gLi4vaW5j
bHVkZS9saW51eC9wc2kuaDogSW4gZnVuY3Rpb24g4oCYY2dyb3VwX21vdmVfdGFza+KAmToKPiA+
PiAuLi9pbmNsdWRlL2xpbnV4L3JjdXBkYXRlLmg6NDE0OjM2OiBlcnJvcjogZGVyZWZlcmVuY2lu
ZyBwb2ludGVyIHRvIGluY29tcGxldGUgdHlwZSDigJhzdHJ1Y3QgY3NzX3NldOKAmQo+ID4+ICAj
ZGVmaW5lIFJDVV9JTklUSUFMSVpFUih2KSAodHlwZW9mKCoodikpIF9fZm9yY2UgX19yY3UgKiko
dikKPiA+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+Cj4gPiAKPiA+
IFdvcmtzIEZvciBNZS4gIEkgdHJpZWQgYG1ha2UgeDg2XzY0X2RlZmNvbmZpZycgYW5kIGBtYWtl
IGkzODZfZGVmY29uZmlnJyB0b28uCj4gPiAKPiA+IENhbiB5b3UgcGxlYXNlIHNoYXJlIHRoYXQg
LmNvbmZpZywgb3IgZGVidWcgYSBiaXQ/Cj4gCj4gJCBtYWtlIEFSQ0g9dW0gU1VCQVJDSD14ODZf
NjQgZGVmY29uZmlnCj4gCgpJIHN0aWxsIGNhbid0IHJlcHJvZHVjZSB0aGlzIDooCgo+IFRoaXMg
Zml4ZXMgdGhlIGJ1aWxkIGVycm9yIGZvciBtZSB3aGVuIENPTkZJR19QU0k9bi4KCkkgaGF2ZSBD
T05GSUdfUFNJPW4KCj4gLS0tCj4gIGluY2x1ZGUvbGludXgvcHNpLmggfCAgICAzICsrKwo+ICAx
IGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gCj4gLS0tIG1tb3RtLTIwMjItMDMxNi0x
NzQyLm9yaWcvaW5jbHVkZS9saW51eC9wc2kuaAo+ICsrKyBtbW90bS0yMDIyLTAzMTYtMTc0Mi9p
bmNsdWRlL2xpbnV4L3BzaS5oCj4gQEAgLTUzLDYgKzUzLDkgQEAgc3RhdGljIGlubGluZSBpbnQg
cHNpX2Nncm91cF9hbGxvYyhzdHJ1Ywo+ICBzdGF0aWMgaW5saW5lIHZvaWQgcHNpX2Nncm91cF9m
cmVlKHN0cnVjdCBjZ3JvdXAgKmNncnApCj4gIHsKPiAgfQo+ICsKPiArI2luY2x1ZGUgPGxpbnV4
L2Nncm91cC1kZWZzLmg+Cj4gKwo+ICBzdGF0aWMgaW5saW5lIHZvaWQgY2dyb3VwX21vdmVfdGFz
ayhzdHJ1Y3QgdGFza19zdHJ1Y3QgKnAsIHN0cnVjdCBjc3Nfc2V0ICp0bykKPiAgewo+ICAJcmN1
X2Fzc2lnbl9wb2ludGVyKHAtPmNncm91cHMsIHRvKTsKCk5vdGhpbmcgaW4gLW5leHQgdG91Y2hl
cyBwc2kuaCBzbyBJIGFtIHVuYWJsZSB0byBkZXRlcm1pbmUgd2hpY2ggcGF0Y2gKbmVlZHMgZml4
aW5nIDooCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwps
aW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8v
bGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

