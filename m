Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [RFC PATCH v2 3/3] mm: make generic pXd_addr_end() macros inline
 functions
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-4-gerald.schaefer@linux.ibm.com>
 <4c101685-5b29-dace-9dd2-b6f0ae193a9c@csgroup.eu>
 <20200908154859.GA11583@oc3871087118.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <af04f078-4991-6260-8bd5-9d9601105d76@csgroup.eu>
Date: Tue, 8 Sep 2020 19:20:20 +0200
MIME-Version: 1.0
In-Reply-To: <20200908154859.GA11583@oc3871087118.ibm.com>
Content-Language: fr
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>

CgpMZSAwOC8wOS8yMDIwIMOgIDE3OjQ4LCBBbGV4YW5kZXIgR29yZGVldiBhIMOpY3JpdMKgOgo+
IE9uIFR1ZSwgU2VwIDA4LCAyMDIwIGF0IDA3OjE5OjM4QU0gKzAyMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6Cj4gCj4gWy4uLl0KPiAKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3Bn
dGFibGUuaCBiL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oCj4+PiBpbmRleCA2N2ViYzIyY2Y4M2Qu
LmQ5ZTdkMTZjMjI2MyAxMDA2NDQKPj4+IC0tLSBhL2luY2x1ZGUvbGludXgvcGd0YWJsZS5oCj4+
PiArKysgYi9pbmNsdWRlL2xpbnV4L3BndGFibGUuaAo+Pj4gQEAgLTY1NiwzMSArNjU2LDM1IEBA
IHN0YXRpYyBpbmxpbmUgaW50IGFyY2hfdW5tYXBfb25lKHN0cnVjdCBtbV9zdHJ1Y3QgKm1tLAo+
Pj4gICAgKi8KPj4+ICAgI2lmbmRlZiBwZ2RfYWRkcl9lbmQKPj4+IC0jZGVmaW5lIHBnZF9hZGRy
X2VuZChwZ2QsIGFkZHIsIGVuZCkJCQkJCVwKPj4+IC0oewl1bnNpZ25lZCBsb25nIF9fYm91bmRh
cnkgPSAoKGFkZHIpICsgUEdESVJfU0laRSkgJiBQR0RJUl9NQVNLOwlcCj4+PiAtCShfX2JvdW5k
YXJ5IC0gMSA8IChlbmQpIC0gMSk/IF9fYm91bmRhcnk6IChlbmQpOwkJXAo+Pj4gLX0pCj4+PiAr
I2RlZmluZSBwZ2RfYWRkcl9lbmQgcGdkX2FkZHJfZW5kCj4+Cj4+IEkgdGhpbmsgdGhhdCAjZGVm
aW5lIGlzIHBvaW50bGVzcywgdXN1YWxseSB0aGVyZSBpcyBubyBzdWNoICNkZWZpbmUKPj4gZm9y
IHRoZSBkZWZhdWx0IGNhc2UuCj4gCj4gRGVmYXVsdCBwZ2RfYWRkcl9lbmQoKSBnZXRzIG92ZXJy
aWRlbiBvbiBzMzkwIChhcmNoL3MzOTAvaW5jbHVkZS9hc20vcGd0YWJsZS5oKToKPiAKPiAjZGVm
aW5lIHBnZF9hZGRyX2VuZCBwZ2RfYWRkcl9lbmQKPiBzdGF0aWMgaW5saW5lIHVuc2lnbmVkIGxv
bmcgcGdkX2FkZHJfZW5kKHBnZF90IHBnZCwgdW5zaWduZWQgbG9uZyBhZGRyLCB1bnNpZ25lZCBs
b25nIGVuZCkKPiB7Cj4gCXJldHVybiByc3RlX2FkZHJfZW5kX2ZvbGRlZChwZ2RfdmFsKHBnZCks
IGFkZHIsIGVuZCk7Cj4gfQoKWWVzLCB0aGVyZSBpbiBzMzkwIHRoZSAjZGVmaW5lIGlzIG5lZWRl
ZCB0byBoaXQgdGhlICNpZm5kZWYgcGdkX2FkZHJfZW5kIAp0aGF0J3MgaW4gaW5jbHVkZS9saW51
eC9wZ3RhYmxlLmgKCkJ1dCBpbiBpbmNsdWRlL2xpbnV4L3BndGFibGUuaCwgdGhlcmUgaXMgbm8g
bmVlZCBvZiBhbiAjZGVmaW5lIApwZ2RfYWRkcl9lbmQgcGdkX2FkZHJfZW5kIEkgdGhpbmsKCj4g
Cj4+PiArc3RhdGljIGlubGluZSB1bnNpZ25lZCBsb25nIHBnZF9hZGRyX2VuZChwZ2RfdCBwZ2Qs
IHVuc2lnbmVkIGxvbmcgYWRkciwgdW5zaWduZWQgbG9uZyBlbmQpCj4+PiArewl1bnNpZ25lZCBs
b25nIF9fYm91bmRhcnkgPSAoYWRkciArIFBHRElSX1NJWkUpICYgUEdESVJfTUFTSzsKPj4+ICsJ
cmV0dXJuIChfX2JvdW5kYXJ5IC0gMSA8IGVuZCAtIDEpID8gX19ib3VuZGFyeSA6IGVuZDsKPj4+
ICt9CgoKQ2hyaXN0b3BoZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5v
cmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

