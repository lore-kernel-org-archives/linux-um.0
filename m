Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Sat, 25 Jan 2020 16:28:03 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM dependency
Message-ID: <20200125162803.5a2375d7@xps13>
In-Reply-To: <CAFd5g47VLB6zOJsSySAYrJie8hj-OkvOC89-z2b9xMBZ2bxvYA@mail.gmail.com>
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-3-brendanhiggins@google.com>
 <20200109162303.35f4f0a3@xps13>
 <CAFd5g47VLB6zOJsSySAYrJie8hj-OkvOC89-z2b9xMBZ2bxvYA@mail.gmail.com>
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
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Boris Brezillon <bbrezillon@kernel.org>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, linux-mtd@lists.infradead.org, David Gow <davidgow@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Piotr Sroka <piotrs@cadence.com>

SGkgQnJlbmRhbiwKCkJyZW5kYW4gSGlnZ2lucyA8YnJlbmRhbmhpZ2dpbnNAZ29vZ2xlLmNvbT4g
d3JvdGUgb24gRnJpLCAyNCBKYW4gMjAyMAoxODoxMjoxMiAtMDgwMDoKCj4gT24gVGh1LCBKYW4g
OSwgMjAyMCBhdCA3OjIzIEFNIE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5j
b20+IHdyb3RlOgo+ID4KPiA+IEhpIEJyZW5kYW4sCj4gPgo+ID4gQnJlbmRhbiBIaWdnaW5zIDxi
cmVuZGFuaGlnZ2luc0Bnb29nbGUuY29tPiB3cm90ZSBvbiBXZWQsIDExIERlYyAyMDE5Cj4gPiAx
MToyNzozNyAtMDgwMDoKPiA+ICAKPiA+ID4gQ3VycmVudGx5IENPTkZJR19NVERfTkFORF9DQURF
TkNFIGltcGxpY2l0bHkgZGVwZW5kcyBvbgo+ID4gPiBDT05GSUdfSEFTX0lPTUVNPXk7IGNvbnNl
cXVlbnRseSwgb24gYXJjaGl0ZWN0dXJlcyB3aXRob3V0IElPTUVNIHdlIGdldAo+ID4gPiB0aGUg
Zm9sbG93aW5nIGJ1aWxkIGVycm9yOgo+ID4gPgo+ID4gPiBsZDogZHJpdmVycy9tdGQvbmFuZC9y
YXcvY2FkZW5jZS1uYW5kLWNvbnRyb2xsZXIubzogaW4gZnVuY3Rpb24gYGNhZGVuY2VfbmFuZF9k
dF9wcm9iZS5jb2xkLjMxJzoKPiA+ID4gZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZS1uYW5k
LWNvbnRyb2xsZXIuYzoyOTY5OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBkZXZtX3BsYXRmb3Jt
X2lvcmVtYXBfcmVzb3VyY2UnCj4gPiA+IGxkOiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNl
LW5hbmQtY29udHJvbGxlci5jOjI5Nzc6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGRldm1faW9y
ZW1hcF9yZXNvdXJjZScKPiA+ID4KPiA+ID4gRml4IHRoZSBidWlsZCBlcnJvciBieSBhZGRpbmcg
dGhlIHVuc3BlY2lmaWVkIGRlcGVuZGVuY3kuCj4gPiA+Cj4gPiA+IFJlcG9ydGVkLWJ5OiBCcmVu
ZGFuIEhpZ2dpbnMgPGJyZW5kYW5oaWdnaW5zQGdvb2dsZS5jb20+Cj4gPiA+IFNpZ25lZC1vZmYt
Ynk6IEJyZW5kYW4gSGlnZ2lucyA8YnJlbmRhbmhpZ2dpbnNAZ29vZ2xlLmNvbT4KPiA+ID4gLS0t
ICAKPiA+Cj4gPiBTb3JyeSBmb3IgdGhlIGRlbGF5Lgo+ID4KPiA+IEFja2VkLWJ5OiBNaXF1ZWwg
UmF5bmFsIDxtaXF1ZWwucmF5bmFsQGJvb3RsaW4uY29tPiAgCj4gCj4gSXQgbG9va3MgbGlrZSBt
eSBjaGFuZ2UgaGFzIG5vdCBiZWVuIGFwcGxpZWQgdG8gbmFuZC9uZXh0OyBpcyB0aGlzIHRoZQo+
IGJyYW5jaCBpdCBzaG91bGQgYmUgYXBwbGllZCB0bz8gSSBoYXZlIGFsc28gdmVyaWZpZWQgdGhh
dCB0aGlzIHBhdGNoCj4gaXNuJ3QgaW4gbGludXgtbmV4dCBhcyBvZiBKYW4gMjR0aC4KPiAKPiBJ
cyBtdGQvbGludXggdGhlIGNvcnJlY3QgdHJlZSBmb3IgdGhpcz8gT3IgZG8gSSBuZWVkIHRvIHJl
YWNoIG91dCB0bwo+IHNvbWVvbmUgZWxzZT8KCldoZW4gSSBzZW50IG15IEFja2VkLWJ5IEkgc3Vw
cG9zZWQgc29tZW9uZSBlbHNlIHdvdWxkIHBpY2sgdGhlIHBhdGNoLApidXQgdGhlcmUgaXMgYWN0
dWFsbHkgbm8gZGVwZW5kZW5jeSB3aXRoIGFsbCB0aGUgb3RoZXIgcGF0Y2hlcyBzbyBJCmRvbid0
IGtub3cgd2h5IEkgZGlkIGl0Li4uIFNvcnJ5IGFib3V0IHRoYXQuIEknbGwgdGFrZSBpdCBhbnl3
YXkgaW4gbXkKUFIgZm9yIDUuNi4KClRoYW5rcywKTWlxdcOobAoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4
LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1h
bi9saXN0aW5mby9saW51eC11bQo=

