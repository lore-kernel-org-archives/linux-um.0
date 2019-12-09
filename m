Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieSFy-000720-Fg
 for linux-um@lists.infradead.org; Mon, 09 Dec 2019 23:16:00 +0000
Date: Tue, 10 Dec 2019 00:15:46 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
In-Reply-To: <20191209230248.227508-1-brendanhiggins@google.com>
References: <20191209230248.227508-1-brendanhiggins@google.com>
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
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
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Johannes Berg <johannes.berg@intel.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, davidgow@google.com, anton ivanov <anton.ivanov@cambridgegreys.com>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIkJyZW5kYW4gSGlnZ2lucyIg
PGJyZW5kYW5oaWdnaW5zQGdvb2dsZS5jb20+Cj4gQW46ICJKZWZmIERpa2UiIDxqZGlrZUBhZGR0
b2l0LmNvbT4sICJyaWNoYXJkIiA8cmljaGFyZEBub2QuYXQ+LCAiYW50b24gaXZhbm92IiA8YW50
b24uaXZhbm92QGNhbWJyaWRnZWdyZXlzLmNvbT4KPiBDQzogIkpvaGFubmVzIEJlcmciIDxqb2hh
bm5lcy5iZXJnQGludGVsLmNvbT4sICJsaW51eC11bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmc+LCAibGludXgta2VybmVsIgo+IDxsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnPiwg
ZGF2aWRnb3dAZ29vZ2xlLmNvbSwgIkJyZW5kYW4gSGlnZ2lucyIgPGJyZW5kYW5oaWdnaW5zQGdv
b2dsZS5jb20+Cj4gR2VzZW5kZXQ6IERpZW5zdGFnLCAxMC4gRGV6ZW1iZXIgMjAxOSAwMDowMjo0
OAo+IEJldHJlZmY6IFtQQVRDSCB2MV0gdW1sOiByZW1vdmUgc3VwcG9ydCBmb3IgQ09ORklHX1NU
QVRJQ19MSU5LCgo+IENPTkZJR19TVEFUSUNfTElOSyBhcHBlYXJzIHRvIGhhdmUgYmVlbiBicm9r
ZW4gc2luY2UgYmVmb3JlIHY0LjIwLiBJdAo+IGRvZXNuJ3QgcGxheSBuaWNlIHdpdGggQ09ORklH
X1VNTF9ORVRfVkVDVE9SPXk6Cj4gCj4gL3Vzci9iaW4vbGQ6IGFyY2gvdW0vZHJpdmVycy92ZWN0
b3JfdXNlci5vOiBpbiBmdW5jdGlvbgo+IGB1c2VyX2luaXRfc29ja2V0X2Zkcyc6IHZlY3Rvcl91
c2VyLmM6KC50ZXh0KzB4NDMwKTogd2FybmluZzogVXNpbmcKPiAnZ2V0YWRkcmluZm8nIGluIHN0
YXRpY2FsbHkgbGlua2VkIGFwcGxpY2F0aW9ucyByZXF1aXJlcyBhdCBydW50aW1lIHRoZQo+IHNo
YXJlZCBsaWJyYXJpZXMgZnJvbSB0aGUgZ2xpYmMgdmVyc2lvbiB1c2VkIGZvciBsaW5raW5nCgpU
aGlzIGlzIG5vdGhpbmcgc2VyaW91cy4KCj4gQW5kIGl0IHNlZW1zIHRvIGJyZWFrIHRoZSBwdHJh
Y2UgY2hlY2s6Cj4gCj4gQ2hlY2tpbmcgdGhhdCBwdHJhY2UgY2FuIGNoYW5nZSBzeXN0ZW0gY2Fs
bCBudW1iZXJzLi4uY2hlY2tfcHRyYWNlIDoKPiBjaGlsZCBleGl0ZWQgd2l0aCBleGl0Y29kZSA2
LCB3aGlsZSBleHBlY3RpbmcgMDsgc3RhdHVzIDB4NjdmCj4gWzFdICAgIDEyNjgyMiBhYm9ydCAg
ICAgIC4vbGludXggbWVtPTI1Nk0KCkRpZG4ndCB3ZSBmaXggdGhhdCBhbHJlYWR5PwoKPiAoQXBw
YXJlbnRseSwgYSBwYXRjaCB3YXMgcmVjZW50bHkgZGlzY3Vzc2VkIHRoYXQgZml4ZXMgdGhpcyAt
IGFyb3VuZAo+IHY1LjUtcmMxWzFdIC0gYnV0IHRoZSBmYWN0IHRoYXQgdGhpcyB3YXMgYnJva2Vu
IGZvciBvdmVyIGEgeWVhcgo+IHJlbWFpbnMuKQo+IAo+IEFjY29yZGluZyB0byBBbnRvbiwgUENB
UCB0aHJvd3MgZXZlbiBtb3JlIHdhcm5pbmdzLCBhbmQgdGhlIHJlc3VsdGluZwo+IGJpbmFyeSBp
c24ndCByZWFsbHkgZXZlbiBzdGF0aWMgYW55d2F5LCBzbyB0aGVyZSBpcyByZWFsbHkgbm8gcG9p
bnQgaW4KPiBrZWVwaW5nIHRoaXMgY29uZmlnIGFyb3VuZFsyXS4KCldoYXQ/CkFudG9uLCBwbGVh
c2UgZXhwbGFpbi4gV2h5IGlzIGl0IG5vdCBzdGF0aWMgd2hlbiBidWlsZCB3aXRoIENPTkZJR19T
VEFUSUNfTElOSz8KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlz
dHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL2xpbnV4LXVtCg==

