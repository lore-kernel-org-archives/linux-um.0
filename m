Return-Path: <linux-mtd-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 3/5] treewide: use get_random_u32() when possible
Date: Thu, 6 Oct 2022 17:21:27 +0000
Message-ID: <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
References: <20221006165346.73159-1-Jason@zx2c4.com>
 <20221006165346.73159-4-Jason@zx2c4.com>
In-Reply-To: <20221006165346.73159-4-Jason@zx2c4.com>
Content-Language: en-US
Content-ID: <B07B745AE1A6904EBF61E3986BE3C1D1@FRAP264.PROD.OUTLOOK.COM>
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Cc: Andreas Noever <andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin  <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller" <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>
List-ID: <linux-um.lists.infradead.org>

DQoNCkxlIDA2LzEwLzIwMjIgw6AgMTg6NTMsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBUaGUgcHJhbmRvbV91MzIoKSBmdW5jdGlvbiBoYXMgYmVlbiBhIGRlcHJlY2F0ZWQgaW5s
aW5lIHdyYXBwZXIgYXJvdW5kDQo+IGdldF9yYW5kb21fdTMyKCkgZm9yIHNldmVyYWwgcmVsZWFz
ZXMgbm93LCBhbmQgY29tcGlsZXMgZG93biB0byB0aGUNCj4gZXhhY3Qgc2FtZSBjb2RlLiBSZXBs
YWNlIHRoZSBkZXByZWNhdGVkIHdyYXBwZXIgd2l0aCBhIGRpcmVjdCBjYWxsIHRvDQo+IHRoZSBy
ZWFsIGZ1bmN0aW9uLiBUaGUgc2FtZSBhbHNvIGFwcGxpZXMgdG8gZ2V0X3JhbmRvbV9pbnQoKSwg
d2hpY2ggaXMNCj4ganVzdCBhIHdyYXBwZXIgYXJvdW5kIGdldF9yYW5kb21fdTMyKCkuDQo+IA0K
PiBSZXZpZXdlZC1ieTogS2VlcyBDb29rIDxrZWVzY29va0BjaHJvbWl1bS5vcmc+DQo+IEFja2Vk
LWJ5OiBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gPHRva2VAdG9rZS5kaz4gIyBmb3Igc2NoX2Nh
a2UNCj4gQWNrZWQtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiAjIGZv
ciBuZnNkDQo+IFJldmlld2VkLWJ5OiBKYW4gS2FyYSA8amFja0BzdXNlLmN6PiAjIGZvciBleHQ0
DQo+IFNpZ25lZC1vZmYtYnk6IEphc29uIEEuIERvbmVuZmVsZCA8SmFzb25AengyYzQuY29tPg0K
PiAtLS0NCg0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNzLmMgYi9h
cmNoL3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYw0KPiBpbmRleCAwZmJkYTg5Y2QxYmIuLjljNGMx
NWFmYmJlOCAxMDA2NDQNCj4gLS0tIGEvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNzLmMNCj4g
KysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNzLmMNCj4gQEAgLTIzMDgsNiArMjMwOCw2
IEBAIHZvaWQgbm90cmFjZSBfX3BwYzY0X3J1bmxhdGNoX29mZih2b2lkKQ0KPiAgIHVuc2lnbmVk
IGxvbmcgYXJjaF9hbGlnbl9zdGFjayh1bnNpZ25lZCBsb25nIHNwKQ0KPiAgIHsNCj4gICAJaWYg
KCEoY3VycmVudC0+cGVyc29uYWxpdHkgJiBBRERSX05PX1JBTkRPTUlaRSkgJiYgcmFuZG9taXpl
X3ZhX3NwYWNlKQ0KPiAtCQlzcCAtPSBnZXRfcmFuZG9tX2ludCgpICYgflBBR0VfTUFTSzsNCj4g
KwkJc3AgLT0gZ2V0X3JhbmRvbV91MzIoKSAmIH5QQUdFX01BU0s7DQo+ICAgCXJldHVybiBzcCAm
IH4weGY7DQoNCklzbid0IHRoYXQgYSBjYW5kaWRhdGUgZm9yIHByYW5kb21fdTMyX21heCgpID8N
Cg0KTm90ZSB0aGF0IHNwIGlzIGRlZW1lZCB0byBiZSAxNiBieXRlcyBhbGlnbmVkIGF0IGFsbCB0
aW1lLg0KDQoNCkNocmlzdG9waGUKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fCkxpbnV4IE1URCBkaXNjdXNzaW9uIG1haWxpbmcgbGlzdApodHRw
Oi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LW10ZC8K

