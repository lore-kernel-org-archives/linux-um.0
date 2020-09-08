Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [RFC PATCH v2 2/3] mm: make pXd_addr_end() functions page-table
 entry aware
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-3-gerald.schaefer@linux.ibm.com>
 <31dfb3ed-a0cc-3024-d389-ab9bd19e881f@csgroup.eu>
 <20200908074638.GA19099@oc3871087118.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <5d4f5546-afd0-0b8f-664d-700ae346b9ec@csgroup.eu>
Date: Tue, 8 Sep 2020 10:16:49 +0200
MIME-Version: 1.0
In-Reply-To: <20200908074638.GA19099@oc3871087118.ibm.com>
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
To: Alexander Gordeev <agordeev@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>

CgpMZSAwOC8wOS8yMDIwIMOgIDA5OjQ2LCBBbGV4YW5kZXIgR29yZGVldiBhIMOpY3JpdMKgOgo+
IE9uIFR1ZSwgU2VwIDA4LCAyMDIwIGF0IDA3OjE0OjM4QU0gKzAyMDAsIENocmlzdG9waGUgTGVy
b3kgd3JvdGU6Cj4+IFlvdSBmb3Jnb3QgYXJjaC9wb3dlcnBjL21tL2Jvb2szczY0L3N1YnBhZ2Vf
cHJvdC5jIGl0IHNlZW1zLgo+IAo+IFllcywgYW5kIGFsc28gdHdvIG1vcmUgc291cmNlcyA6Lwo+
IAlhcmNoL3Bvd2VycGMvbW0va2FzYW4vOHh4LmMKPiAJYXJjaC9wb3dlcnBjL21tL2thc2FuL2th
c2FuX2luaXRfMzIuYwo+IAo+IEJ1dCB0aGVzZSB0d28gYXJlIG5vdCBxdWl0ZSBvYnZpb3VzIHdy
dCBwZ2RfYWRkcl9lbmQoKSB1c2VkCj4gd2hpbGUgdHJhdmVyc2luZyBwbWRzLiBDb3VsZCB5b3Ug
cGxlYXNlIGNsYXJpZnkgYSBiaXQ/Cj4gCj4gCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9t
bS9rYXNhbi84eHguYyBiL2FyY2gvcG93ZXJwYy9tbS9rYXNhbi84eHguYwo+IGluZGV4IDI3ODQy
MjQuLjg5YzUwNTMgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9wb3dlcnBjL21tL2thc2FuLzh4eC5jCj4g
KysrIGIvYXJjaC9wb3dlcnBjL21tL2thc2FuLzh4eC5jCj4gQEAgLTE1LDggKzE1LDggQEAKPiAg
IAlmb3IgKGtfY3VyID0ga19zdGFydDsga19jdXIgIT0ga19lbmQ7IGtfY3VyID0ga19uZXh0LCBw
bWQgKz0gMiwgYmxvY2sgKz0gU1pfOE0pIHsKPiAgIAkJcHRlX2Jhc2ljX3QgKm5ldzsKPiAgIAo+
IC0JCWtfbmV4dCA9IHBnZF9hZGRyX2VuZChrX2N1ciwga19lbmQpOwo+IC0JCWtfbmV4dCA9IHBn
ZF9hZGRyX2VuZChrX25leHQsIGtfZW5kKTsKPiArCQlrX25leHQgPSBwbWRfYWRkcl9lbmQoa19j
dXIsIGtfZW5kKTsKPiArCQlrX25leHQgPSBwbWRfYWRkcl9lbmQoa19uZXh0LCBrX2VuZCk7CgpO
bywgSSBkb24ndCB0aGluayBzby4KT24gcG93ZXJwYzMyIHdlIGhhdmUgb25seSB0d28gbGV2ZWxz
LCBzbyBwZ2QgYW5kIHBtZCBhcmUgbW9yZSBvciBsZXNzIAp0aGUgc2FtZS4KQnV0IHBtZF9hZGRy
X2VuZCgpIGFzIGRlZmluZWQgaW4gaW5jbHVkZS9hc20tZ2VuZXJpYy9wZ3RhYmxlLW5vcG1kLmgg
aXMgCmEgbm8tb3AsIHNvIEkgZG9uJ3QgdGhpbmsgaXQgd2lsbCB3b3JrLgoKSXQgaXMgbGlrZWx5
IHRoYXQgdGhpcyBmdW5jdGlvbiBzaG91bGQgaXRlcmF0ZSBvbiBwZ2QsIHRoZW4geW91IGdldCBw
bWQgCj0gcG1kX29mZnNldChwdWRfb2Zmc2V0KHA0ZF9vZmZzZXQocGdkKSkpOwoKPiAgIAkJaWYg
KCh2b2lkICopcG1kX3BhZ2VfdmFkZHIoKnBtZCkgIT0ga2FzYW5fZWFybHlfc2hhZG93X3B0ZSkK
PiAgIAkJCWNvbnRpbnVlOwo+ICAgCj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9tbS9rYXNh
bi9rYXNhbl9pbml0XzMyLmMgYi9hcmNoL3Bvd2VycGMvbW0va2FzYW4va2FzYW5faW5pdF8zMi5j
Cj4gaW5kZXggZmIyOTQwNC4uM2Y3ZDZkYzYgMTAwNjQ0Cj4gLS0tIGEvYXJjaC9wb3dlcnBjL21t
L2thc2FuL2thc2FuX2luaXRfMzIuYwo+ICsrKyBiL2FyY2gvcG93ZXJwYy9tbS9rYXNhbi9rYXNh
bl9pbml0XzMyLmMKPiBAQCAtMzgsNyArMzgsNyBAQCBpbnQgX19pbml0IGthc2FuX2luaXRfc2hh
ZG93X3BhZ2VfdGFibGVzKHVuc2lnbmVkIGxvbmcga19zdGFydCwgdW5zaWduZWQgbG9uZyBrXwo+
ICAgCWZvciAoa19jdXIgPSBrX3N0YXJ0OyBrX2N1ciAhPSBrX2VuZDsga19jdXIgPSBrX25leHQs
IHBtZCsrKSB7Cj4gICAJCXB0ZV90ICpuZXc7Cj4gICAKPiAtCQlrX25leHQgPSBwZ2RfYWRkcl9l
bmQoa19jdXIsIGtfZW5kKTsKPiArCQlrX25leHQgPSBwbWRfYWRkcl9lbmQoa19jdXIsIGtfZW5k
KTsKClNhbWUgaGVyZSBJIGdldCwgaXRlcmF0ZSBvbiBwZ2QgdGhlbiBnZXQgcG1kID0gCnBtZF9v
ZmZzZXQocHVkX29mZnNldChwNGRfb2Zmc2V0KHBnZCkpKTsKCj4gICAJCWlmICgodm9pZCAqKXBt
ZF9wYWdlX3ZhZGRyKCpwbWQpICE9IGthc2FuX2Vhcmx5X3NoYWRvd19wdGUpCj4gICAJCQljb250
aW51ZTsKPiAgIAo+IEBAIC0xOTYsNyArMTk2LDcgQEAgdm9pZCBfX2luaXQga2FzYW5fZWFybHlf
aW5pdCh2b2lkKQo+ICAgCWthc2FuX3BvcHVsYXRlX3B0ZShrYXNhbl9lYXJseV9zaGFkb3dfcHRl
LCBQQUdFX0tFUk5FTCk7Cj4gICAKPiAgIAlkbyB7Cj4gLQkJbmV4dCA9IHBnZF9hZGRyX2VuZChh
ZGRyLCBlbmQpOwo+ICsJCW5leHQgPSBwbWRfYWRkcl9lbmQoYWRkciwgZW5kKTsKPiAgIAkJcG1k
X3BvcHVsYXRlX2tlcm5lbCgmaW5pdF9tbSwgcG1kLCBrYXNhbl9lYXJseV9zaGFkb3dfcHRlKTsK
PiAgIAl9IHdoaWxlIChwbWQrKywgYWRkciA9IG5leHQsIGFkZHIgIT0gZW5kKTsKPiAgIAo+IAoK
Q2hyaXN0b3BoZQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0
cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

