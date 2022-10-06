Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Message-ID: <6396875c-146a-acf5-dd9e-7f93ba1b4bc3@csgroup.eu>
Date: Thu, 6 Oct 2022 19:42:55 +0200
MIME-Version: 1.0
Subject: Re: [PATCH v3 3/5] treewide: use get_random_u32() when possible
Content-Language: fr-FR
From: Christophe Leroy <christophe.leroy@csgroup.eu>
References: <20221006165346.73159-1-Jason@zx2c4.com>
 <20221006165346.73159-4-Jason@zx2c4.com>
 <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
 <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
 <f10fcfbf-2da6-cf2d-6027-fbf8b52803e9@csgroup.eu>
In-Reply-To: <f10fcfbf-2da6-cf2d-6027-fbf8b52803e9@csgroup.eu>
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@lists.linux.dev" <patches@lists.linux.dev>, Andreas Noever <andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgens?= =?UTF-8?Q?en?= <toke@toke.dk>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>

CgpMZSAwNi8xMC8yMDIyIMOgIDE5OjMxLCBDaHJpc3RvcGhlIExlcm95IGEgw6ljcml0wqA6Cj4g
Cj4gCj4gTGUgMDYvMTAvMjAyMiDDoCAxOToyNCwgSmFzb24gQS4gRG9uZW5mZWxkIGEgw6ljcml0
wqA6Cj4+IEhpIENocmlzdG9waGUsCj4+Cj4+IE9uIFRodSwgT2N0IDYsIDIwMjIgYXQgMTE6MjEg
QU0gQ2hyaXN0b3BoZSBMZXJveQo+PiA8Y2hyaXN0b3BoZS5sZXJveUBjc2dyb3VwLmV1PiB3cm90
ZToKPj4+IExlIDA2LzEwLzIwMjIgw6AgMTg6NTMsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3Jp
dCA6Cj4+Pj4gVGhlIHByYW5kb21fdTMyKCkgZnVuY3Rpb24gaGFzIGJlZW4gYSBkZXByZWNhdGVk
IGlubGluZSB3cmFwcGVyIGFyb3VuZAo+Pj4+IGdldF9yYW5kb21fdTMyKCkgZm9yIHNldmVyYWwg
cmVsZWFzZXMgbm93LCBhbmQgY29tcGlsZXMgZG93biB0byB0aGUKPj4+PiBleGFjdCBzYW1lIGNv
ZGUuIFJlcGxhY2UgdGhlIGRlcHJlY2F0ZWQgd3JhcHBlciB3aXRoIGEgZGlyZWN0IGNhbGwgdG8K
Pj4+PiB0aGUgcmVhbCBmdW5jdGlvbi4gVGhlIHNhbWUgYWxzbyBhcHBsaWVzIHRvIGdldF9yYW5k
b21faW50KCksIHdoaWNoIGlzCj4+Pj4ganVzdCBhIHdyYXBwZXIgYXJvdW5kIGdldF9yYW5kb21f
dTMyKCkuCj4+Pj4KPj4+PiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1
bS5vcmc+Cj4+Pj4gQWNrZWQtYnk6IFRva2UgSMO4aWxhbmQtSsO4cmdlbnNlbiA8dG9rZUB0b2tl
LmRrPiAjIGZvciBzY2hfY2FrZQo+Pj4+IEFja2VkLWJ5OiBDaHVjayBMZXZlciA8Y2h1Y2subGV2
ZXJAb3JhY2xlLmNvbT4gIyBmb3IgbmZzZAo+Pj4+IFJldmlld2VkLWJ5OiBKYW4gS2FyYSA8amFj
a0BzdXNlLmN6PiAjIGZvciBleHQ0Cj4+Pj4gU2lnbmVkLW9mZi1ieTogSmFzb24gQS4gRG9uZW5m
ZWxkIDxKYXNvbkB6eDJjNC5jb20+Cj4+Pj4gLS0tCj4+Pgo+Pj4+IGRpZmYgLS1naXQgYS9hcmNo
L3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYyAKPj4+PiBiL2FyY2gvcG93ZXJwYy9rZXJuZWwvcHJv
Y2Vzcy5jCj4+Pj4gaW5kZXggMGZiZGE4OWNkMWJiLi45YzRjMTVhZmJiZTggMTAwNjQ0Cj4+Pj4g
LS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNzLmMKPj4+PiArKysgYi9hcmNoL3Bvd2Vy
cGMva2VybmVsL3Byb2Nlc3MuYwo+Pj4+IEBAIC0yMzA4LDYgKzIzMDgsNiBAQCB2b2lkIG5vdHJh
Y2UgX19wcGM2NF9ydW5sYXRjaF9vZmYodm9pZCkKPj4+PiDCoMKgIHVuc2lnbmVkIGxvbmcgYXJj
aF9hbGlnbl9zdGFjayh1bnNpZ25lZCBsb25nIHNwKQo+Pj4+IMKgwqAgewo+Pj4+IMKgwqDCoMKg
wqDCoCBpZiAoIShjdXJyZW50LT5wZXJzb25hbGl0eSAmIEFERFJfTk9fUkFORE9NSVpFKSAmJiAK
Pj4+PiByYW5kb21pemVfdmFfc3BhY2UpCj4+Pj4gLcKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBz
cCAtPSBnZXRfcmFuZG9tX2ludCgpICYgflBBR0VfTUFTSzsKPj4+PiArwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgIHNwIC09IGdldF9yYW5kb21fdTMyKCkgJiB+UEFHRV9NQVNLOwo+Pj4+IMKgwqDC
oMKgwqDCoCByZXR1cm4gc3AgJiB+MHhmOwo+Pj4KPj4+IElzbid0IHRoYXQgYSBjYW5kaWRhdGUg
Zm9yIHByYW5kb21fdTMyX21heCgpID8KPj4+Cj4+PiBOb3RlIHRoYXQgc3AgaXMgZGVlbWVkIHRv
IGJlIDE2IGJ5dGVzIGFsaWduZWQgYXQgYWxsIHRpbWUuCj4+Cj4+IFllcywgcHJvYmFibHkuIEl0
IHNlZW1lZCBub24tdHJpdmlhbCB0byB0aGluayBhYm91dCwgc28gSSBkaWRuJ3QuIEJ1dAo+PiBs
ZXQncyBzZWUgaGVyZS4uLiBtYXliZSBpdCdzIG5vdCB0b28gYmFkOgo+Pgo+PiBJZiBQQUdFX01B
U0sgaXMgYWx3YXlzIH4oUEFHRV9TSVpFLTEpLCB0aGVuIH5QQUdFX01BU0sgaXMKPj4gKFBBR0Vf
U0laRS0xKSwgc28gcHJhbmRvbV91MzJfbWF4KFBBR0VfU0laRSkgc2hvdWxkIHlpZWxkIHRoZSBz
YW1lCj4+IHRoaW5nPyBJcyB0aGF0IGFjY3VyYXRlPyBBbmQgaG9sZHMgYWNyb3NzIHBsYXRmb3Jt
cyAodGhpcyBjb21lcyB1cCBhCj4+IGZldyBwbGFjZXMpPyBJZiBzbywgSSdsbCBkbyB0aGF0IGZv
ciBhIHY0Lgo+Pgo+IAo+IE9uIHBvd2VycGMgaXQgaXMgYWx3YXlzIChmcm9tIGFyY2gvcG93ZXJw
Yy9pbmNsdWRlL2FzbS9wYWdlLmgpIDoKPiAKPiAvKgo+ICDCoCogU3VidGxlOiAoMSA8PCBQQUdF
X1NISUZUKSBpcyBhbiBpbnQsIG5vdCBhbiB1bnNpZ25lZCBsb25nLiBTbyBpZiB3ZQo+ICDCoCog
YXNzaWduIFBBR0VfTUFTSyB0byBhIGxhcmdlciB0eXBlIGl0IGdldHMgZXh0ZW5kZWQgdGhlIHdh
eSB3ZSB3YW50Cj4gIMKgKiAoaS5lLiB3aXRoIDFzIGluIHRoZSBoaWdoIGJpdHMpCj4gIMKgKi8K
PiAjZGVmaW5lIFBBR0VfTUFTS8KgwqDCoMKgwqAgKH4oKDEgPDwgUEFHRV9TSElGVCkgLSAxKSkK
PiAKPiAjZGVmaW5lIFBBR0VfU0laRcKgwqDCoMKgwqDCoMKgICgxVUwgPDwgUEFHRV9TSElGVCkK
PiAKPiAKPiBTbyBpdCB3b3VsZCB3b3JrIEkgZ3Vlc3MuCgpCdXQgdGFraW5nIGludG8gYWNjb3Vu
dCB0aGF0IHNwIG11c3QgcmVtYWluIDE2IGJ5dGVzIGFsaWduZWQsIHdvdWxkIGl0IApiZSBiZXR0
ZXIgdG8gZG8gc29tZXRoaW5nIGxpa2UgPwoKCXNwIC09IHByYW5kb21fdTMyX21heChQQUdFX1NJ
WkUgPj4gNCkgPDwgNDsKCglyZXR1cm4gc3A7CgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K

