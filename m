Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 3/5] treewide: use get_random_u32() when possible
Date: Thu, 6 Oct 2022 17:31:03 +0000
Message-ID: <f10fcfbf-2da6-cf2d-6027-fbf8b52803e9@csgroup.eu>
References: <20221006165346.73159-1-Jason@zx2c4.com>
 <20221006165346.73159-4-Jason@zx2c4.com>
 <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
 <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
In-Reply-To: <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
Content-Language: en-US
Content-ID: <3A4B84F46BBE6042B54970B24A722C5C@FRAP264.PROD.OUTLOOK.COM>
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@lists.linux.dev" <patches@lists.linux.dev>, Andreas Noever <andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J . Bottomley  <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe" <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>, =?utf-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, Chuck Lever <chuck.lever@oracle.com>, Jan Kara <jack@suse.cz>

DQoNCkxlIDA2LzEwLzIwMjIgw6AgMTk6MjQsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBIaSBDaHJpc3RvcGhlLA0KPiANCj4gT24gVGh1LCBPY3QgNiwgMjAyMiBhdCAxMToyMSBB
TSBDaHJpc3RvcGhlIExlcm95DQo+IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3Rl
Og0KPj4gTGUgMDYvMTAvMjAyMiDDoCAxODo1MywgSmFzb24gQS4gRG9uZW5mZWxkIGEgw6ljcml0
IDoNCj4+PiBUaGUgcHJhbmRvbV91MzIoKSBmdW5jdGlvbiBoYXMgYmVlbiBhIGRlcHJlY2F0ZWQg
aW5saW5lIHdyYXBwZXIgYXJvdW5kDQo+Pj4gZ2V0X3JhbmRvbV91MzIoKSBmb3Igc2V2ZXJhbCBy
ZWxlYXNlcyBub3csIGFuZCBjb21waWxlcyBkb3duIHRvIHRoZQ0KPj4+IGV4YWN0IHNhbWUgY29k
ZS4gUmVwbGFjZSB0aGUgZGVwcmVjYXRlZCB3cmFwcGVyIHdpdGggYSBkaXJlY3QgY2FsbCB0bw0K
Pj4+IHRoZSByZWFsIGZ1bmN0aW9uLiBUaGUgc2FtZSBhbHNvIGFwcGxpZXMgdG8gZ2V0X3JhbmRv
bV9pbnQoKSwgd2hpY2ggaXMNCj4+PiBqdXN0IGEgd3JhcHBlciBhcm91bmQgZ2V0X3JhbmRvbV91
MzIoKS4NCj4+Pg0KPj4+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9taXVt
Lm9yZz4NCj4+PiBBY2tlZC1ieTogVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2VuIDx0b2tlQHRva2Uu
ZGs+ICMgZm9yIHNjaF9jYWtlDQo+Pj4gQWNrZWQtYnk6IENodWNrIExldmVyIDxjaHVjay5sZXZl
ckBvcmFjbGUuY29tPiAjIGZvciBuZnNkDQo+Pj4gUmV2aWV3ZWQtYnk6IEphbiBLYXJhIDxqYWNr
QHN1c2UuY3o+ICMgZm9yIGV4dDQNCj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBBLiBEb25lbmZl
bGQgPEphc29uQHp4MmM0LmNvbT4NCj4+PiAtLS0NCj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2FyY2gv
cG93ZXJwYy9rZXJuZWwvcHJvY2Vzcy5jIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNzLmMN
Cj4+PiBpbmRleCAwZmJkYTg5Y2QxYmIuLjljNGMxNWFmYmJlOCAxMDA2NDQNCj4+PiAtLS0gYS9h
cmNoL3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYw0KPj4+ICsrKyBiL2FyY2gvcG93ZXJwYy9rZXJu
ZWwvcHJvY2Vzcy5jDQo+Pj4gQEAgLTIzMDgsNiArMjMwOCw2IEBAIHZvaWQgbm90cmFjZSBfX3Bw
YzY0X3J1bmxhdGNoX29mZih2b2lkKQ0KPj4+ICAgIHVuc2lnbmVkIGxvbmcgYXJjaF9hbGlnbl9z
dGFjayh1bnNpZ25lZCBsb25nIHNwKQ0KPj4+ICAgIHsNCj4+PiAgICAgICAgaWYgKCEoY3VycmVu
dC0+cGVyc29uYWxpdHkgJiBBRERSX05PX1JBTkRPTUlaRSkgJiYgcmFuZG9taXplX3ZhX3NwYWNl
KQ0KPj4+IC0gICAgICAgICAgICAgc3AgLT0gZ2V0X3JhbmRvbV9pbnQoKSAmIH5QQUdFX01BU0s7
DQo+Pj4gKyAgICAgICAgICAgICBzcCAtPSBnZXRfcmFuZG9tX3UzMigpICYgflBBR0VfTUFTSzsN
Cj4+PiAgICAgICAgcmV0dXJuIHNwICYgfjB4ZjsNCj4+DQo+PiBJc24ndCB0aGF0IGEgY2FuZGlk
YXRlIGZvciBwcmFuZG9tX3UzMl9tYXgoKSA/DQo+Pg0KPj4gTm90ZSB0aGF0IHNwIGlzIGRlZW1l
ZCB0byBiZSAxNiBieXRlcyBhbGlnbmVkIGF0IGFsbCB0aW1lLg0KPiANCj4gWWVzLCBwcm9iYWJs
eS4gSXQgc2VlbWVkIG5vbi10cml2aWFsIHRvIHRoaW5rIGFib3V0LCBzbyBJIGRpZG4ndC4gQnV0
DQo+IGxldCdzIHNlZSBoZXJlLi4uIG1heWJlIGl0J3Mgbm90IHRvbyBiYWQ6DQo+IA0KPiBJZiBQ
QUdFX01BU0sgaXMgYWx3YXlzIH4oUEFHRV9TSVpFLTEpLCB0aGVuIH5QQUdFX01BU0sgaXMNCj4g
KFBBR0VfU0laRS0xKSwgc28gcHJhbmRvbV91MzJfbWF4KFBBR0VfU0laRSkgc2hvdWxkIHlpZWxk
IHRoZSBzYW1lDQo+IHRoaW5nPyBJcyB0aGF0IGFjY3VyYXRlPyBBbmQgaG9sZHMgYWNyb3NzIHBs
YXRmb3JtcyAodGhpcyBjb21lcyB1cCBhDQo+IGZldyBwbGFjZXMpPyBJZiBzbywgSSdsbCBkbyB0
aGF0IGZvciBhIHY0Lg0KPiANCg0KT24gcG93ZXJwYyBpdCBpcyBhbHdheXMgKGZyb20gYXJjaC9w
b3dlcnBjL2luY2x1ZGUvYXNtL3BhZ2UuaCkgOg0KDQovKg0KICAqIFN1YnRsZTogKDEgPDwgUEFH
RV9TSElGVCkgaXMgYW4gaW50LCBub3QgYW4gdW5zaWduZWQgbG9uZy4gU28gaWYgd2UNCiAgKiBh
c3NpZ24gUEFHRV9NQVNLIHRvIGEgbGFyZ2VyIHR5cGUgaXQgZ2V0cyBleHRlbmRlZCB0aGUgd2F5
IHdlIHdhbnQNCiAgKiAoaS5lLiB3aXRoIDFzIGluIHRoZSBoaWdoIGJpdHMpDQogICovDQojZGVm
aW5lIFBBR0VfTUFTSyAgICAgICh+KCgxIDw8IFBBR0VfU0hJRlQpIC0gMSkpDQoNCiNkZWZpbmUg
UEFHRV9TSVpFCQkoMVVMIDw8IFBBR0VfU0hJRlQpDQoNCg0KU28gaXQgd291bGQgd29yayBJIGd1
ZXNzLg0KDQpDaHJpc3RvcGhlCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

