Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 3/5] treewide: use get_random_u32() when possible
Date: Fri, 7 Oct 2022 04:57:24 +0000
Message-ID: <501b0fc3-6c67-657f-781e-25ee0283bc2e@csgroup.eu>
References: <20221006165346.73159-1-Jason@zx2c4.com>
 <20221006165346.73159-4-Jason@zx2c4.com>
 <848ed24c-13ef-6c38-fd13-639b33809194@csgroup.eu>
 <CAHmME9raQ4E00r9r8NyWJ17iSXE_KniTG0onCNAfMmfcGar1eg@mail.gmail.com>
 <f10fcfbf-2da6-cf2d-6027-fbf8b52803e9@csgroup.eu>
 <6396875c-146a-acf5-dd9e-7f93ba1b4bc3@csgroup.eu>
 <CAHmME9pE4saqnwxhsAwt-xegYGjsavPOGnHCbZhUXD7kaJ+GAA@mail.gmail.com>
In-Reply-To: <CAHmME9pE4saqnwxhsAwt-xegYGjsavPOGnHCbZhUXD7kaJ+GAA@mail.gmail.com>
Content-Language: en-US
Content-ID: <8277F4805BBBC64490B411D5CECB85D7@FRAP264.PROD.OUTLOOK.COM>
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

DQoNCkxlIDA3LzEwLzIwMjIgw6AgMDE6MzYsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBPbiAxMC82LzIyLCBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3Jv
dXAuZXU+IHdyb3RlOg0KPj4NCj4+DQo+PiBMZSAwNi8xMC8yMDIyIMOgIDE5OjMxLCBDaHJpc3Rv
cGhlIExlcm95IGEgw6ljcml0IDoNCj4+Pg0KPj4+DQo+Pj4gTGUgMDYvMTAvMjAyMiDDoCAxOToy
NCwgSmFzb24gQS4gRG9uZW5mZWxkIGEgw6ljcml0IDoNCj4+Pj4gSGkgQ2hyaXN0b3BoZSwNCj4+
Pj4NCj4+Pj4gT24gVGh1LCBPY3QgNiwgMjAyMiBhdCAxMToyMSBBTSBDaHJpc3RvcGhlIExlcm95
DQo+Pj4+IDxjaHJpc3RvcGhlLmxlcm95QGNzZ3JvdXAuZXU+IHdyb3RlOg0KPj4+Pj4gTGUgMDYv
MTAvMjAyMiDDoCAxODo1MywgSmFzb24gQS4gRG9uZW5mZWxkIGEgw6ljcml0IDoNCj4+Pj4+PiBU
aGUgcHJhbmRvbV91MzIoKSBmdW5jdGlvbiBoYXMgYmVlbiBhIGRlcHJlY2F0ZWQgaW5saW5lIHdy
YXBwZXIgYXJvdW5kDQo+Pj4+Pj4gZ2V0X3JhbmRvbV91MzIoKSBmb3Igc2V2ZXJhbCByZWxlYXNl
cyBub3csIGFuZCBjb21waWxlcyBkb3duIHRvIHRoZQ0KPj4+Pj4+IGV4YWN0IHNhbWUgY29kZS4g
UmVwbGFjZSB0aGUgZGVwcmVjYXRlZCB3cmFwcGVyIHdpdGggYSBkaXJlY3QgY2FsbCB0bw0KPj4+
Pj4+IHRoZSByZWFsIGZ1bmN0aW9uLiBUaGUgc2FtZSBhbHNvIGFwcGxpZXMgdG8gZ2V0X3JhbmRv
bV9pbnQoKSwgd2hpY2ggaXMNCj4+Pj4+PiBqdXN0IGEgd3JhcHBlciBhcm91bmQgZ2V0X3JhbmRv
bV91MzIoKS4NCj4+Pj4+Pg0KPj4+Pj4+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29r
QGNocm9taXVtLm9yZz4NCj4+Pj4+PiBBY2tlZC1ieTogVG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu
IDx0b2tlQHRva2UuZGs+ICMgZm9yIHNjaF9jYWtlDQo+Pj4+Pj4gQWNrZWQtYnk6IENodWNrIExl
dmVyIDxjaHVjay5sZXZlckBvcmFjbGUuY29tPiAjIGZvciBuZnNkDQo+Pj4+Pj4gUmV2aWV3ZWQt
Ynk6IEphbiBLYXJhIDxqYWNrQHN1c2UuY3o+ICMgZm9yIGV4dDQNCj4+Pj4+PiBTaWduZWQtb2Zm
LWJ5OiBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4NCj4+Pj4+PiAtLS0NCj4+
Pj4+DQo+Pj4+Pj4gZGlmZiAtLWdpdCBhL2FyY2gvcG93ZXJwYy9rZXJuZWwvcHJvY2Vzcy5jDQo+
Pj4+Pj4gYi9hcmNoL3Bvd2VycGMva2VybmVsL3Byb2Nlc3MuYw0KPj4+Pj4+IGluZGV4IDBmYmRh
ODljZDFiYi4uOWM0YzE1YWZiYmU4IDEwMDY0NA0KPj4+Pj4+IC0tLSBhL2FyY2gvcG93ZXJwYy9r
ZXJuZWwvcHJvY2Vzcy5jDQo+Pj4+Pj4gKysrIGIvYXJjaC9wb3dlcnBjL2tlcm5lbC9wcm9jZXNz
LmMNCj4+Pj4+PiBAQCAtMjMwOCw2ICsyMzA4LDYgQEAgdm9pZCBub3RyYWNlIF9fcHBjNjRfcnVu
bGF0Y2hfb2ZmKHZvaWQpDQo+Pj4+Pj4gICAgIHVuc2lnbmVkIGxvbmcgYXJjaF9hbGlnbl9zdGFj
ayh1bnNpZ25lZCBsb25nIHNwKQ0KPj4+Pj4+ICAgICB7DQo+Pj4+Pj4gICAgICAgICBpZiAoIShj
dXJyZW50LT5wZXJzb25hbGl0eSAmIEFERFJfTk9fUkFORE9NSVpFKSAmJg0KPj4+Pj4+IHJhbmRv
bWl6ZV92YV9zcGFjZSkNCj4+Pj4+PiAtICAgICAgICAgICAgIHNwIC09IGdldF9yYW5kb21faW50
KCkgJiB+UEFHRV9NQVNLOw0KPj4+Pj4+ICsgICAgICAgICAgICAgc3AgLT0gZ2V0X3JhbmRvbV91
MzIoKSAmIH5QQUdFX01BU0s7DQo+Pj4+Pj4gICAgICAgICByZXR1cm4gc3AgJiB+MHhmOw0KPj4+
Pj4NCj4+Pj4+IElzbid0IHRoYXQgYSBjYW5kaWRhdGUgZm9yIHByYW5kb21fdTMyX21heCgpID8N
Cj4+Pj4+DQo+Pj4+PiBOb3RlIHRoYXQgc3AgaXMgZGVlbWVkIHRvIGJlIDE2IGJ5dGVzIGFsaWdu
ZWQgYXQgYWxsIHRpbWUuDQo+Pj4+DQo+Pj4+IFllcywgcHJvYmFibHkuIEl0IHNlZW1lZCBub24t
dHJpdmlhbCB0byB0aGluayBhYm91dCwgc28gSSBkaWRuJ3QuIEJ1dA0KPj4+PiBsZXQncyBzZWUg
aGVyZS4uLiBtYXliZSBpdCdzIG5vdCB0b28gYmFkOg0KPj4+Pg0KPj4+PiBJZiBQQUdFX01BU0sg
aXMgYWx3YXlzIH4oUEFHRV9TSVpFLTEpLCB0aGVuIH5QQUdFX01BU0sgaXMNCj4+Pj4gKFBBR0Vf
U0laRS0xKSwgc28gcHJhbmRvbV91MzJfbWF4KFBBR0VfU0laRSkgc2hvdWxkIHlpZWxkIHRoZSBz
YW1lDQo+Pj4+IHRoaW5nPyBJcyB0aGF0IGFjY3VyYXRlPyBBbmQgaG9sZHMgYWNyb3NzIHBsYXRm
b3JtcyAodGhpcyBjb21lcyB1cCBhDQo+Pj4+IGZldyBwbGFjZXMpPyBJZiBzbywgSSdsbCBkbyB0
aGF0IGZvciBhIHY0Lg0KPj4+Pg0KPj4+DQo+Pj4gT24gcG93ZXJwYyBpdCBpcyBhbHdheXMgKGZy
b20gYXJjaC9wb3dlcnBjL2luY2x1ZGUvYXNtL3BhZ2UuaCkgOg0KPj4+DQo+Pj4gLyoNCj4+PiAg
ICAqIFN1YnRsZTogKDEgPDwgUEFHRV9TSElGVCkgaXMgYW4gaW50LCBub3QgYW4gdW5zaWduZWQg
bG9uZy4gU28gaWYgd2UNCj4+PiAgICAqIGFzc2lnbiBQQUdFX01BU0sgdG8gYSBsYXJnZXIgdHlw
ZSBpdCBnZXRzIGV4dGVuZGVkIHRoZSB3YXkgd2Ugd2FudA0KPj4+ICAgICogKGkuZS4gd2l0aCAx
cyBpbiB0aGUgaGlnaCBiaXRzKQ0KPj4+ICAgICovDQo+Pj4gI2RlZmluZSBQQUdFX01BU0sgICAg
ICAofigoMSA8PCBQQUdFX1NISUZUKSAtIDEpKQ0KPj4+DQo+Pj4gI2RlZmluZSBQQUdFX1NJWkUg
ICAgICAgICgxVUwgPDwgUEFHRV9TSElGVCkNCj4+Pg0KPj4+DQo+Pj4gU28gaXQgd291bGQgd29y
ayBJIGd1ZXNzLg0KPj4NCj4+IEJ1dCB0YWtpbmcgaW50byBhY2NvdW50IHRoYXQgc3AgbXVzdCBy
ZW1haW4gMTYgYnl0ZXMgYWxpZ25lZCwgd291bGQgaXQNCj4+IGJlIGJldHRlciB0byBkbyBzb21l
dGhpbmcgbGlrZSA/DQo+Pg0KPj4gCXNwIC09IHByYW5kb21fdTMyX21heChQQUdFX1NJWkUgPj4g
NCkgPDwgNDsNCj4+DQo+PiAJcmV0dXJuIHNwOw0KPiANCj4gRG9lcyB0aGlzIGFzc3VtZSB0aGF0
IHNwIGlzIGFscmVhZHkgYWxpZ25lZCBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZQ0KPiBmdW5jdGlv
bj8gSSdkIGFzc3VtZSBmcm9tIHRoZSBmdW5jdGlvbidzIG5hbWUgdGhhdCB0aGlzIGlzbid0IHRo
ZQ0KPiBjYXNlPw0KDQpBaCB5b3UgYXJlIHJpZ2h0LCBJIG92ZXJsb29rZWQgaXQuDQoNCkxvb2tp
bmcgaW4gbW9yZSBkZXRhaWxzLCBJIHNlZSB0aGF0IGFsbCBhcmNoaXRlY3R1cmVzIHRoYXQgaW1w
bGVtZW50IGl0IA0KaW1wbGVtZW50IGl0IGFsbW9zdCB0aGUgc2FtZSB3YXkuDQoNCkJ5IHRoZSB3
YXksIHRoZSBjb21tZW50IGluIGFyY2gvdW0va2VybmVsL3Byb2Nlc3MuYyBpcyBvdmVyZGF0ZWQu
DQoNCk1vc3QgYXJjaGl0ZWN0dXJlcyBBTkQgdGhlIHJhbmRvbSB2YWx1ZSB3aXRoIH5QQUdFX01B
U0ssIHg4NiBhbmQgdW0gdXNlIA0KJTgxOTIuIFNlZW1zIGxpa2UgYXQgdGhlIHRpbWUgMi42LjEy
IHdhcyBpbnRyb2R1Y2VkIGludG8gZ2l0LCBvbmx5IGkzODYgDQp4ODZfNjQgYW5kIHVtIGhhZCB0
aGF0IGZ1bmN0aW9uLg0KDQpNYXliZSBpdCBpcyB0aW1lIGZvciBhIGNsZWFudXAgYW5kIGEgcmVm
YWN0b3JpbmcgPyBBcmNoaXRlY3R1cmVzIHdvdWxkIA0KanVzdCBoYXZlIHRvIHByb3ZpZGUgU1RB
Q0tfQUxJR04ganVzdCBsaWtlIGxvb25nYXJjaCBkb2VzIHRvZGF5LCBhbmQgd2UgDQpjb3VsZCBn
ZXQgYSBnZW5lcmljIGFyY2hfYWxpZ25fc3RhY2soKSA/DQoNCkNocmlzdG9waGUKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBs
aXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5v
cmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

