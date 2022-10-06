Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
MIME-Version: 1.0
References: <20221006165346.73159-1-Jason@zx2c4.com> <20221006165346.73159-4-Jason@zx2c4.com>
 <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
In-Reply-To: <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Date: Thu, 6 Oct 2022 11:24:16 -0600
Message-ID: <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
Subject: Re: [PATCH v3 3/5] treewide: use get_random_u32() when possible
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
To: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@lists.linux.dev" <patches@lists.linux.dev>, Andreas Noever <andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?Q?Christoph_B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>

SGkgQ2hyaXN0b3BoZSwKCk9uIFRodSwgT2N0IDYsIDIwMjIgYXQgMTE6MjEgQU0gQ2hyaXN0b3Bo
ZSBMZXJveQo8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90ZToKPiBMZSAwNi8xMC8y
MDIyIMOgIDE4OjUzLCBKYXNvbiBBLiBEb25lbmZlbGQgYSDDqWNyaXQgOgo+ID4gVGhlIHByYW5k
b21fdTMyKCkgZnVuY3Rpb24gaGFzIGJlZW4gYSBkZXByZWNhdGVkIGlubGluZSB3cmFwcGVyIGFy
b3VuZAo+ID4gZ2V0X3JhbmRvbV91MzIoKSBmb3Igc2V2ZXJhbCByZWxlYXNlcyBub3csIGFuZCBj
b21waWxlcyBkb3duIHRvIHRoZQo+ID4gZXhhY3Qgc2FtZSBjb2RlLiBSZXBsYWNlIHRoZSBkZXBy
ZWNhdGVkIHdyYXBwZXIgd2l0aCBhIGRpcmVjdCBjYWxsIHRvCj4gPiB0aGUgcmVhbCBmdW5jdGlv
bi4gVGhlIHNhbWUgYWxzbyBhcHBsaWVzIHRvIGdldF9yYW5kb21faW50KCksIHdoaWNoIGlzCj4g
PiBqdXN0IGEgd3JhcHBlciBhcm91bmQgZ2V0X3JhbmRvbV91MzIoKS4KPiA+Cj4gPiBSZXZpZXdl
ZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+Cj4gPiBBY2tlZC1ieTogVG9r
ZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHRva2UuZGs+ICMgZm9yIHNjaF9jYWtlCj4gPiBB
Y2tlZC1ieTogQ2h1Y2sgTGV2ZXIgPGNodWNrLmxldmVyQG9yYWNsZS5jb20+ICMgZm9yIG5mc2QK
PiA+IFJldmlld2VkLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6PiAjIGZvciBleHQ0Cj4gPiBT
aWduZWQtb2ZmLWJ5OiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4KPiA+IC0t
LQo+Cj4gPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNzLmMgYi9hcmNo
L3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYwo+ID4gaW5kZXggMGZiZGE4OWNkMWJiLi45YzRjMTVh
ZmJiZTggMTAwNjQ0Cj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYwo+ID4g
KysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNzLmMKPiA+IEBAIC0yMzA4LDYgKzIzMDgs
NiBAQCB2b2lkIG5vdHJhY2UgX19wcGM2NF9ydW5sYXRjaF9vZmYodm9pZCkKPiA+ICAgdW5zaWdu
ZWQgbG9uZyBhcmNoX2FsaWduX3N0YWNrKHVuc2lnbmVkIGxvbmcgc3ApCj4gPiAgIHsKPiA+ICAg
ICAgIGlmICghKGN1cnJlbnQtPnBlcnNvbmFsaXR5ICYgQUREUl9OT19SQU5ET01JWkUpICYmIHJh
bmRvbWl6ZV92YV9zcGFjZSkKPiA+IC0gICAgICAgICAgICAgc3AgLT0gZ2V0X3JhbmRvbV9pbnQo
KSAmIH5QQUdFX01BU0s7Cj4gPiArICAgICAgICAgICAgIHNwIC09IGdldF9yYW5kb21fdTMyKCkg
JiB+UEFHRV9NQVNLOwo+ID4gICAgICAgcmV0dXJuIHNwICYgfjB4ZjsKPgo+IElzbid0IHRoYXQg
YSBjYW5kaWRhdGUgZm9yIHByYW5kb21fdTMyX21heCgpID8KPgo+IE5vdGUgdGhhdCBzcCBpcyBk
ZWVtZWQgdG8gYmUgMTYgYnl0ZXMgYWxpZ25lZCBhdCBhbGwgdGltZS4KClllcywgcHJvYmFibHku
IEl0IHNlZW1lZCBub24tdHJpdmlhbCB0byB0aGluayBhYm91dCwgc28gSSBkaWRuJ3QuIEJ1dAps
ZXQncyBzZWUgaGVyZS4uLiBtYXliZSBpdCdzIG5vdCB0b28gYmFkOgoKSWYgUEFHRV9NQVNLIGlz
IGFsd2F5cyB+KFBBR0VfU0laRS0xKSwgdGhlbiB+UEFHRV9NQVNLIGlzCihQQUdFX1NJWkUtMSks
IHNvIHByYW5kb21fdTMyX21heChQQUdFX1NJWkUpIHNob3VsZCB5aWVsZCB0aGUgc2FtZQp0aGlu
Zz8gSXMgdGhhdCBhY2N1cmF0ZT8gQW5kIGhvbGRzIGFjcm9zcyBwbGF0Zm9ybXMgKHRoaXMgY29t
ZXMgdXAgYQpmZXcgcGxhY2VzKT8gSWYgc28sIEknbGwgZG8gdGhhdCBmb3IgYSB2NC4KCkphc29u
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11
bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

