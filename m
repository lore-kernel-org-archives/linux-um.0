Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: Re: [PATCH v3 4/5] treewide: use get_random_bytes when possible
Date: Thu, 6 Oct 2022 17:22:41 +0000
Message-ID: <0eea033d-7018-c777-f3e8-2239916aed9b@csgroup.eu>
References: <20221006165346.73159-1-Jason@zx2c4.com>
 <20221006165346.73159-5-Jason@zx2c4.com>
In-Reply-To: <20221006165346.73159-5-Jason@zx2c4.com>
Content-Language: en-US
Content-ID: <944C3E8CB2B01D44B74BB4038DDFEDBA@FRAP264.PROD.OUTLOOK.COM>
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
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "patches@lists.linux.dev" <patches@lists.linux.dev>
Cc: Andreas Noever <andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, =?utf-8?B?Q2hyaXN0b3BoIELDtmhtd2FsZGVy?= <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin  <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller" <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>, "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>, "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>, "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>, "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>, "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>, "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "loongarch@lists.linux.dev" <loongarch@lists.linux.dev>, "netdev@vger.kernel.org" <netdev@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "x86@kernel.org" <x86@kernel.org>

DQoNCkxlIDA2LzEwLzIwMjIgw6AgMTg6NTMsIEphc29uIEEuIERvbmVuZmVsZCBhIMOpY3JpdMKg
Og0KPiBUaGUgcHJhbmRvbV9ieXRlcygpIGZ1bmN0aW9uIGhhcyBiZWVuIGEgZGVwcmVjYXRlZCBp
bmxpbmUgd3JhcHBlciBhcm91bmQNCj4gZ2V0X3JhbmRvbV9ieXRlcygpIGZvciBzZXZlcmFsIHJl
bGVhc2VzIG5vdywgYW5kIGNvbXBpbGVzIGRvd24gdG8gdGhlDQo+IGV4YWN0IHNhbWUgY29kZS4g
UmVwbGFjZSB0aGUgZGVwcmVjYXRlZCB3cmFwcGVyIHdpdGggYSBkaXJlY3QgY2FsbCB0bw0KPiB0
aGUgcmVhbCBmdW5jdGlvbi4NCj4gDQo+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29r
QGNocm9taXVtLm9yZz4NCj4gU2lnbmVkLW9mZi1ieTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNv
bkB6eDJjNC5jb20+DQoNClJldmlld2VkLWJ5OiBDaHJpc3RvcGhlIExlcm95IDxjaHJpc3RvcGhl
Lmxlcm95QGNzZ3JvdXAuZXU+IChQb3dlcnBjIHBhcnQpDQoNCj4gLS0tDQo+ICAgYXJjaC9wb3dl
cnBjL2NyeXB0by9jcmMtdnBtc3VtX3Rlc3QuYyAgICAgICB8ICAyICstDQo+IA0KPiBkaWZmIC0t
Z2l0IGEvYXJjaC9wb3dlcnBjL2NyeXB0by9jcmMtdnBtc3VtX3Rlc3QuYyBiL2FyY2gvcG93ZXJw
Yy9jcnlwdG8vY3JjLXZwbXN1bV90ZXN0LmMNCj4gaW5kZXggYzFjMWVmOTQ1N2ZiLi4yNzNjNTI3
ODY4ZGIgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvcG93ZXJwYy9jcnlwdG8vY3JjLXZwbXN1bV90ZXN0
LmMNCj4gKysrIGIvYXJjaC9wb3dlcnBjL2NyeXB0by9jcmMtdnBtc3VtX3Rlc3QuYw0KPiBAQCAt
ODIsNyArODIsNyBAQCBzdGF0aWMgaW50IF9faW5pdCBjcmNfdGVzdF9pbml0KHZvaWQpDQo+ICAg
DQo+ICAgCQkJaWYgKGxlbiA8PSBvZmZzZXQpDQo+ICAgCQkJCWNvbnRpbnVlOw0KPiAtCQkJcHJh
bmRvbV9ieXRlcyhkYXRhLCBsZW4pOw0KPiArCQkJZ2V0X3JhbmRvbV9ieXRlcyhkYXRhLCBsZW4p
Ow0KPiAgIAkJCWxlbiAtPSBvZmZzZXQ7DQo+ICAgDQo+ICAgCQkJY3J5cHRvX3NoYXNoX3VwZGF0
ZShjcmN0MTBkaWZfc2hhc2gsIGRhdGErb2Zmc2V0LCBsZW4pOwpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgt
dW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXVtCg==

