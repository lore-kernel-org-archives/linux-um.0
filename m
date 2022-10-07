Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 7 Oct 2022 08:07:58 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v3 3/5] treewide: use get_random_u32() when possible
Message-ID: <Y0Ayvov/KQmrIwTS@zx2c4.com>
References: <20221006165346.73159-1-Jason@zx2c4.com>
 <20221006165346.73159-4-Jason@zx2c4.com>
 <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
 <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
 <f10fcfbf-2da6-cf2d-6027-fbf8b52803e9@csgroup.eu>
 <6396875c-146a-acf5-dd9e-7f93ba1b4bc3@csgroup.eu>
 <CAHmME9pE4saqnwxhsAwt-xegYGjsavPOGnHCbZhUXD7kaJ+GAA@mail.gmail.com>
 <501b0fc3-6c67-657f-781e-25ee0283bc2e@csgroup.eu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <501b0fc3-6c67-657f-781e-25ee0283bc2e@csgroup.eu>
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
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@lists.linux.dev" <patches@lists.linux.dev>, Andreas Noever <andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>

T24gRnJpLCBPY3QgMDcsIDIwMjIgYXQgMDQ6NTc6MjRBTSArMDAwMCwgQ2hyaXN0b3BoZSBMZXJv
eSB3cm90ZToKPiAKPiAKPiBMZSAwNy8xMC8yMDIyIMOgIDAxOjM2LCBKYXNvbiBBLiBEb25lbmZl
bGQgYSDDqWNyaXTCoDoKPiA+IE9uIDEwLzYvMjIsIENocmlzdG9waGUgTGVyb3kgPGNocmlzdG9w
aGUubGVyb3lAY3Nncm91cC5ldT4gd3JvdGU6Cj4gPj4KPiA+Pgo+ID4+IExlIDA2LzEwLzIwMjIg
w6AgMTk6MzEsIENocmlzdG9waGUgTGVyb3kgYSDDqWNyaXQgOgo+ID4+Pgo+ID4+Pgo+ID4+PiBM
ZSAwNi8xMC8yMDIyIMOgIDE5OjI0LCBKYXNvbiBBLiBEb25lbmZlbGQgYSDDqWNyaXQgOgo+ID4+
Pj4gSGkgQ2hyaXN0b3BoZSwKPiA+Pj4+Cj4gPj4+PiBPbiBUaHUsIE9jdCA2LCAyMDIyIGF0IDEx
OjIxIEFNIENocmlzdG9waGUgTGVyb3kKPiA+Pj4+IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAu
ZXU+IHdyb3RlOgo+ID4+Pj4+IExlIDA2LzEwLzIwMjIgw6AgMTg6NTMsIEphc29uIEEuIERvbmVu
ZmVsZCBhIMOpY3JpdCA6Cj4gPj4+Pj4+IFRoZSBwcmFuZG9tX3UzMigpIGZ1bmN0aW9uIGhhcyBi
ZWVuIGEgZGVwcmVjYXRlZCBpbmxpbmUgd3JhcHBlciBhcm91bmQKPiA+Pj4+Pj4gZ2V0X3JhbmRv
bV91MzIoKSBmb3Igc2V2ZXJhbCByZWxlYXNlcyBub3csIGFuZCBjb21waWxlcyBkb3duIHRvIHRo
ZQo+ID4+Pj4+PiBleGFjdCBzYW1lIGNvZGUuIFJlcGxhY2UgdGhlIGRlcHJlY2F0ZWQgd3JhcHBl
ciB3aXRoIGEgZGlyZWN0IGNhbGwgdG8KPiA+Pj4+Pj4gdGhlIHJlYWwgZnVuY3Rpb24uIFRoZSBz
YW1lIGFsc28gYXBwbGllcyB0byBnZXRfcmFuZG9tX2ludCgpLCB3aGljaCBpcwo+ID4+Pj4+PiBq
dXN0IGEgd3JhcHBlciBhcm91bmQgZ2V0X3JhbmRvbV91MzIoKS4KPiA+Pj4+Pj4KPiA+Pj4+Pj4g
UmV2aWV3ZWQtYnk6IEtlZXMgQ29vayA8a2Vlc2Nvb2tAY2hyb21pdW0ub3JnPgo+ID4+Pj4+PiBB
Y2tlZC1ieTogVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHRva2UuZGs+ICMgZm9yIHNj
aF9jYWtlCj4gPj4+Pj4+IEFja2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2ZXJAb3JhY2xl
LmNvbT4gIyBmb3IgbmZzZAo+ID4+Pj4+PiBSZXZpZXdlZC1ieTogSmFuIEthcmEgPGphY2tAc3Vz
ZS5jej4gIyBmb3IgZXh0NAo+ID4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBBLiBEb25lbmZl
bGQgPEphc29uQHp4MmM0LmNvbT4KPiA+Pj4+Pj4gLS0tCj4gPj4+Pj4KPiA+Pj4+Pj4gZGlmZiAt
LWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvcHJvY2Vzcy5jCj4gPj4+Pj4+IGIvYXJjaC9wb3dl
cnBjL2tlcm5lbC9wcm9jZXNzLmMKPiA+Pj4+Pj4gaW5kZXggMGZiZGE4OWNkMWJiLi45YzRjMTVh
ZmJiZTggMTAwNjQ0Cj4gPj4+Pj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvcHJvY2Vzcy5j
Cj4gPj4+Pj4+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvcHJvY2Vzcy5jCj4gPj4+Pj4+IEBA
IC0yMzA4LDYgKzIzMDgsNiBAQCB2b2lkIG5vdHJhY2UgX19wcGM2NF9ydW5sYXRjaF9vZmYodm9p
ZCkKPiA+Pj4+Pj4gICAgIHVuc2lnbmVkIGxvbmcgYXJjaF9hbGlnbl9zdGFjayh1bnNpZ25lZCBs
b25nIHNwKQo+ID4+Pj4+PiAgICAgewo+ID4+Pj4+PiAgICAgICAgIGlmICghKGN1cnJlbnQtPnBl
cnNvbmFsaXR5ICYgQUREUl9OT19SQU5ET01JWkUpICYmCj4gPj4+Pj4+IHJhbmRvbWl6ZV92YV9z
cGFjZSkKPiA+Pj4+Pj4gLSAgICAgICAgICAgICBzcCAtPSBnZXRfcmFuZG9tX2ludCgpICYgflBB
R0VfTUFTSzsKPiA+Pj4+Pj4gKyAgICAgICAgICAgICBzcCAtPSBnZXRfcmFuZG9tX3UzMigpICYg
flBBR0VfTUFTSzsKPiA+Pj4+Pj4gICAgICAgICByZXR1cm4gc3AgJiB+MHhmOwo+ID4+Pj4+Cj4g
Pj4+Pj4gSXNuJ3QgdGhhdCBhIGNhbmRpZGF0ZSBmb3IgcHJhbmRvbV91MzJfbWF4KCkgPwo+ID4+
Pj4+Cj4gPj4+Pj4gTm90ZSB0aGF0IHNwIGlzIGRlZW1lZCB0byBiZSAxNiBieXRlcyBhbGlnbmVk
IGF0IGFsbCB0aW1lLgo+ID4+Pj4KPiA+Pj4+IFllcywgcHJvYmFibHkuIEl0IHNlZW1lZCBub24t
dHJpdmlhbCB0byB0aGluayBhYm91dCwgc28gSSBkaWRuJ3QuIEJ1dAo+ID4+Pj4gbGV0J3Mgc2Vl
IGhlcmUuLi4gbWF5YmUgaXQncyBub3QgdG9vIGJhZDoKPiA+Pj4+Cj4gPj4+PiBJZiBQQUdFX01B
U0sgaXMgYWx3YXlzIH4oUEFHRV9TSVpFLTEpLCB0aGVuIH5QQUdFX01BU0sgaXMKPiA+Pj4+IChQ
QUdFX1NJWkUtMSksIHNvIHByYW5kb21fdTMyX21heChQQUdFX1NJWkUpIHNob3VsZCB5aWVsZCB0
aGUgc2FtZQo+ID4+Pj4gdGhpbmc/IElzIHRoYXQgYWNjdXJhdGU/IEFuZCBob2xkcyBhY3Jvc3Mg
cGxhdGZvcm1zICh0aGlzIGNvbWVzIHVwIGEKPiA+Pj4+IGZldyBwbGFjZXMpPyBJZiBzbywgSSds
bCBkbyB0aGF0IGZvciBhIHY0Lgo+ID4+Pj4KPiA+Pj4KPiA+Pj4gT24gcG93ZXJwYyBpdCBpcyBh
bHdheXMgKGZyb20gYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BhZ2UuaCkgOgo+ID4+Pgo+ID4+
PiAvKgo+ID4+PiAgICAqIFN1YnRsZTogKDEgPDwgUEFHRV9TSElGVCkgaXMgYW4gaW50LCBub3Qg
YW4gdW5zaWduZWQgbG9uZy4gU28gaWYgd2UKPiA+Pj4gICAgKiBhc3NpZ24gUEFHRV9NQVNLIHRv
IGEgbGFyZ2VyIHR5cGUgaXQgZ2V0cyBleHRlbmRlZCB0aGUgd2F5IHdlIHdhbnQKPiA+Pj4gICAg
KiAoaS5lLiB3aXRoIDFzIGluIHRoZSBoaWdoIGJpdHMpCj4gPj4+ICAgICovCj4gPj4+ICNkZWZp
bmUgUEFHRV9NQVNLICAgICAgKH4oKDEgPDwgUEFHRV9TSElGVCkgLSAxKSkKPiA+Pj4KPiA+Pj4g
I2RlZmluZSBQQUdFX1NJWkUgICAgICAgICgxVUwgPDwgUEFHRV9TSElGVCkKPiA+Pj4KPiA+Pj4K
PiA+Pj4gU28gaXQgd291bGQgd29yayBJIGd1ZXNzLgo+ID4+Cj4gPj4gQnV0IHRha2luZyBpbnRv
IGFjY291bnQgdGhhdCBzcCBtdXN0IHJlbWFpbiAxNiBieXRlcyBhbGlnbmVkLCB3b3VsZCBpdAo+
ID4+IGJlIGJldHRlciB0byBkbyBzb21ldGhpbmcgbGlrZSA/Cj4gPj4KPiA+PiAJc3AgLT0gcHJh
bmRvbV91MzJfbWF4KFBBR0VfU0laRSA+PiA0KSA8PCA0Owo+ID4+Cj4gPj4gCXJldHVybiBzcDsK
PiA+IAo+ID4gRG9lcyB0aGlzIGFzc3VtZSB0aGF0IHNwIGlzIGFscmVhZHkgYWxpZ25lZCBhdCB0
aGUgYmVnaW5uaW5nIG9mIHRoZQo+ID4gZnVuY3Rpb24/IEknZCBhc3N1bWUgZnJvbSB0aGUgZnVu
Y3Rpb24ncyBuYW1lIHRoYXQgdGhpcyBpc24ndCB0aGUKPiA+IGNhc2U/Cj4gCj4gQWggeW91IGFy
ZSByaWdodCwgSSBvdmVybG9va2VkIGl0LgoKU28gSSB0aGluayB0byBzdGF5IG9uIHRoZSBzYWZl
IHNpZGUsIEknbSBnb2luZyB0byBnbyB3aXRoCmBwcmFuZG9tX3UzMl9tYXgoUEFHRV9TSVpFKWAu
IFNvdW5kIGdvb2Q/CgpKYXNvbgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVh
ZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11
bQo=

