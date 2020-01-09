Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Thu, 9 Jan 2020 16:23:03 +0100
From: Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v1 2/7] mtd: rawnand: add unspecified HAS_IOMEM dependency
Message-ID: <20200109162303.35f4f0a3@xps13>
In-Reply-To: <20191211192742.95699-3-brendanhiggins@google.com>
References: <20191211192742.95699-1-brendanhiggins@google.com>
 <20191211192742.95699-3-brendanhiggins@google.com>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-mtd/>
List-Post: <mailto:linux-mtd@lists.infradead.org>
List-Help: <mailto:linux-mtd-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-mtd>,
 <mailto:linux-mtd-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-mtd" <linux-mtd-bounces@lists.infradead.org>
Errors-To: linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org
To: Brendan Higgins <brendanhiggins@google.com>
Cc: Vignesh Raghavendra <vigneshr@ti.com>, Boris Brezillon <bbrezillon@kernel.org>, richard@nod.at, jdike@addtoit.com, linux-um@lists.infradead.org, linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org, davidgow@google.com, anton.ivanov@cambridgegreys.com, Piotr Sroka <piotrs@cadence.com>
List-ID: <linux-um.lists.infradead.org>

SGkgQnJlbmRhbiwKCkJyZW5kYW4gSGlnZ2lucyA8YnJlbmRhbmhpZ2dpbnNAZ29vZ2xlLmNvbT4g
d3JvdGUgb24gV2VkLCAxMSBEZWMgMjAxOQoxMToyNzozNyAtMDgwMDoKCj4gQ3VycmVudGx5IENP
TkZJR19NVERfTkFORF9DQURFTkNFIGltcGxpY2l0bHkgZGVwZW5kcyBvbgo+IENPTkZJR19IQVNf
SU9NRU09eTsgY29uc2VxdWVudGx5LCBvbiBhcmNoaXRlY3R1cmVzIHdpdGhvdXQgSU9NRU0gd2Ug
Z2V0Cj4gdGhlIGZvbGxvd2luZyBidWlsZCBlcnJvcjoKPiAKPiBsZDogZHJpdmVycy9tdGQvbmFu
ZC9yYXcvY2FkZW5jZS1uYW5kLWNvbnRyb2xsZXIubzogaW4gZnVuY3Rpb24gYGNhZGVuY2VfbmFu
ZF9kdF9wcm9iZS5jb2xkLjMxJzoKPiBkcml2ZXJzL210ZC9uYW5kL3Jhdy9jYWRlbmNlLW5hbmQt
Y29udHJvbGxlci5jOjI5Njk6IHVuZGVmaW5lZCByZWZlcmVuY2UgdG8gYGRldm1fcGxhdGZvcm1f
aW9yZW1hcF9yZXNvdXJjZScKPiBsZDogZHJpdmVycy9tdGQvbmFuZC9yYXcvY2FkZW5jZS1uYW5k
LWNvbnRyb2xsZXIuYzoyOTc3OiB1bmRlZmluZWQgcmVmZXJlbmNlIHRvIGBkZXZtX2lvcmVtYXBf
cmVzb3VyY2UnCj4gCj4gRml4IHRoZSBidWlsZCBlcnJvciBieSBhZGRpbmcgdGhlIHVuc3BlY2lm
aWVkIGRlcGVuZGVuY3kuCj4gCj4gUmVwb3J0ZWQtYnk6IEJyZW5kYW4gSGlnZ2lucyA8YnJlbmRh
bmhpZ2dpbnNAZ29vZ2xlLmNvbT4KPiBTaWduZWQtb2ZmLWJ5OiBCcmVuZGFuIEhpZ2dpbnMgPGJy
ZW5kYW5oaWdnaW5zQGdvb2dsZS5jb20+Cj4gLS0tCgpTb3JyeSBmb3IgdGhlIGRlbGF5LgoKQWNr
ZWQtYnk6IE1pcXVlbCBSYXluYWwgPG1pcXVlbC5yYXluYWxAYm9vdGxpbi5jb20+CgpUaGFua3Ms
Ck1pcXXDqGwKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpMaW51eCBNVEQgZGlzY3Vzc2lvbiBtYWlsaW5nIGxpc3QKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tdGQvCg==

