Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Date: Fri, 7 Oct 2022 19:28:59 -0600
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
Subject: Re: [PATCH v4 2/6] treewide: use prandom_u32_max() when possible
Message-ID: <Y0DSW4AAX/yA3CdI@zx2c4.com>
References: <20221007180107.216067-1-Jason@zx2c4.com>
 <20221007180107.216067-3-Jason@zx2c4.com>
 <Y0CXYjV8qMpJxxBa@magnolia>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <Y0CXYjV8qMpJxxBa@magnolia>
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
To: "Darrick J. Wong" <djwong@kernel.org>
Cc: linux-kernel@vger.kernel.org, patches@lists.linux.dev, Andreas Noever <andreas.noever@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christoph =?utf-8?Q?B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>, Christoph Hellwig <hch@lst.de>, Christophe Leroy <christophe.leroy@csgroup.eu>, Daniel Borkmann <daniel@iogearbox.net>, Dave Airlie <airlied@redhat.com>, Dave Hansen <dave.hansen@linux.intel.com>, "David S . Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, Florian Westphal <fw@strlen.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "H . Peter Anvin" <hpa@zytor.com>, Heiko Carstens <hca@linux.ibm.com>, Helge Deller <deller@gmx.de>, Herbert Xu <herbert@gondor.apana.org.au>, Huacai Chen <chenhuacai@kernel.org>, Hugh Dickins <hughd@google.com>, Jakub Kicinski <kuba@kernel.org>, "James E . J . Bottomley" <jejb@linux.ibm.com>, Jan Kara <jack@suse.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jens Axboe <axboe@kernel.dk>, Johannes Berg <johannes@sipsolutions.net>, Jonathan Corbet <corbet@lwn.net>, Jozsef Kadlecsik <kadlec@netfilter.org>, KP Singh <kpsingh@kernel.org>, Kees Cook <keescook@chromium.org>, Marco Elver <elver@google.com>, Mauro Carvalho Chehab <mchehab@kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Pablo Neira Ayuso <pablo@netfilter.org>, Paolo Abeni <pabeni@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Russell King <linux@armlinux.org.uk>, Theodore Ts'o <tytso@mit.edu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Thomas Graf <tgraf@suug.ch>, Ulf Hansson <ulf.hansson@linaro.org>, Vignesh Raghavendra <vigneshr@ti.com>, WANG Xuerui <kernel@xen0n.name>, Will Deacon <will@kernel.org>, Yury Norov <yury.norov@gmail.com>, dri-devel@lists.freedesktop.org, kasan-dev@googlegroups.com, kernel-janitors@vger.kernel.org, linux-arm-kernel@lists.infradead.org, linux-block@vger.kernel.org, linux-crypto@vger.kernel.org, linux-doc@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-media@vger.kernel.org, linux-mips@vger.kernel.org, linux-mm@kvack.org, linux-mmc@vger.kernel.org, linux-mtd@lists.infradead.org, linux-nvme@lists.infradead.org, linux-parisc@vger.kernel.org, linux-rdma@vger.kernel.org, linux-s390@vger.kernel.org, linux-um@lists.infradead.org, linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, netdev@vger.kernel.org, sparclinux@vger.kernel.org, x86@kernel.org, Jan Kara <jack@suse.cz>

T24gRnJpLCBPY3QgMDcsIDIwMjIgYXQgMDI6MTc6MjJQTSAtMDcwMCwgRGFycmljayBKLiBXb25n
IHdyb3RlOgo+IE9uIEZyaSwgT2N0IDA3LCAyMDIyIGF0IDEyOjAxOjAzUE0gLTA2MDAsIEphc29u
IEEuIERvbmVuZmVsZCB3cm90ZToKPiA+IFJhdGhlciB0aGFuIGluY3VycmluZyBhIGRpdmlzaW9u
IG9yIHJlcXVlc3RpbmcgdG9vIG1hbnkgcmFuZG9tIGJ5dGVzIGZvcgo+ID4gdGhlIGdpdmVuIHJh
bmdlLCB1c2UgdGhlIHByYW5kb21fdTMyX21heCgpIGZ1bmN0aW9uLCB3aGljaCBvbmx5IHRha2Vz
Cj4gPiB0aGUgbWluaW11bSByZXF1aXJlZCBieXRlcyBmcm9tIHRoZSBSTkcgYW5kIGF2b2lkcyBk
aXZpc2lvbnMuCj4gPiAKPiA+IFJldmlld2VkLWJ5OiBLZWVzIENvb2sgPGtlZXNjb29rQGNocm9t
aXVtLm9yZz4KPiA+IFJldmlld2VkLWJ5OiBLUCBTaW5naCA8a3BzaW5naEBrZXJuZWwub3JnPgo+
ID4gUmV2aWV3ZWQtYnk6IENocmlzdG9waCBCw7ZobXdhbGRlciA8Y2hyaXN0b3BoLmJvZWhtd2Fs
ZGVyQGxpbmJpdC5jb20+ICMgZm9yIGRyYmQKPiA+IFJldmlld2VkLWJ5OiBKYW4gS2FyYSA8amFj
a0BzdXNlLmN6PiAjIGZvciBleHQyLCBleHQ0LCBhbmQgc2JpdG1hcAo+ID4gU2lnbmVkLW9mZi1i
eTogSmFzb24gQS4gRG9uZW5mZWxkIDxKYXNvbkB6eDJjNC5jb20+Cj4gPiAtLS0KPiAKPiA8c25p
cCwgc2tpcCB0byB0aGUgeGZzIHBhcnQ+Cj4gCj4gPiBkaWZmIC0tZ2l0IGEvZnMveGZzL2xpYnhm
cy94ZnNfYWxsb2MuYyBiL2ZzL3hmcy9saWJ4ZnMveGZzX2FsbG9jLmMKPiA+IGluZGV4IGUyYmRm
MDg5YzBhMy4uNjI2MTU5OWJiMzg5IDEwMDY0NAo+ID4gLS0tIGEvZnMveGZzL2xpYnhmcy94ZnNf
YWxsb2MuYwo+ID4gKysrIGIvZnMveGZzL2xpYnhmcy94ZnNfYWxsb2MuYwo+ID4gQEAgLTE1MjAs
NyArMTUyMCw3IEBAIHhmc19hbGxvY19hZ192ZXh0ZW50X2xhc3RibG9jaygKPiA+ICAKPiA+ICAj
aWZkZWYgREVCVUcKPiA+ICAJLyogUmFuZG9tbHkgZG9uJ3QgZXhlY3V0ZSB0aGUgZmlyc3QgYWxn
b3JpdGhtLiAqLwo+ID4gLQlpZiAocHJhbmRvbV91MzIoKSAmIDEpCj4gPiArCWlmIChwcmFuZG9t
X3UzMl9tYXgoMikpCj4gCj4gSSB3b25kZXIgaWYgdGhlc2UgdXNlY2FzZXMgKHBpY2tpbmcgMCBv
ciAxIHJhbmRvbWx5KSBvdWdodCB0byBoYXZlIGEKPiB0cml2aWFsIHdyYXBwZXIgdG8gbWFrZSBp
dCBtb3JlIG9idmlvdXMgdGhhdCB3ZSB3YW50IGJvb2xlYW4gc2VtYW50aWNzOgo+IAo+IHN0YXRp
YyBpbmxpbmUgYm9vbCBwcmFuZG9tX2Jvb2wodm9pZCkKPiB7Cj4gCXJldHVybiBwcmFuZG9tX3Uz
Ml9tYXgoMik7Cj4gfQo+IAo+IAlpZiAocHJhbmRvbV9ib29sKCkpCj4gCQl1c2VfY3JhenlfYWxn
b3JpdGhtKC4uLik7Cj4gCgpZZWEsIEkndmUgaGFkIGEgbG90IG9mIHNpbWlsYXIgaWRlYXMgdGhl
cmUuIFBhcnQgb2YgZG9pbmcgdGhpcyAoaW5pdGlhbCkKcGF0Y2hzZXQgaXMgdG8gZ2V0IGFuIGlu
dHVpdGl2ZSBzZW5zZSBvZiB3aGF0J3MgYWN0dWFsbHkgdXNlZCBhbmQgaG93Cm9mdGVuLiBPbiBt
eSBsaXN0IGZvciBpbnZlc3RpZ2F0aW9uIGFyZSBhIGdldF9yYW5kb21fdTMyX21heCgpIHRvIHJl
dHVybgp1bmlmb3JtIG51bWJlcnMgYnkgcmVqZWN0aW9uIHNhbXBsaW5nIChwcmFuZG9tX3UzMl9t
YXgoKSBkb2Vzbid0IGRvCnRoYXQgdW5pZm9ybWx5KSBhbmQgYWRkaW5nIGEgZnVuY3Rpb24gZm9y
IGJvb2xlYW5zIG9yIGJpdHMgPCA4LiBQb3NzaWJsZQppZGVhcyBmb3IgdGhlIGxhdHRlciBpbmNs
dWRlOgoKICAgYm9vbCBnZXRfcmFuZG9tX2Jvb2wodm9pZCk7CiAgIGJvb2wgZ2V0X3JhbmRvbV9i
b29sKHVuc2lnbmVkIGludCBwcm9iYWJpbGl0eSk7CiAgIGJvb2wgZ2V0X3JhbmRvbV9iaXRzKHU4
IGJpdHNfbGVzc190aGFuX2VpZ2h0KTsKCldpdGggdGhlIGNvcmUgb2YgYWxsIG9mIHRob3NlIGlu
dm9sdmluZyB0aGUgc2FtZSBiYXRjaGluZyBhcyB0aGUgY3VycmVudApnZXRfcmFuZG9tX3V7OCwx
NiwzMiw2NH0oKSBmdW5jdGlvbnMsIGJ1dCBhbHNvIGJ1ZmZlcmluZyB0aGUgbGF0ZXN0IGJ5dGUK
YW5kIG1hbmFnaW5nIGhvdyBtYW55IGJpdHMgYXJlIGxlZnQgaW4gaXQgdGhhdCBoYXZlbid0IGJl
ZW4gc2hpZnRlZCBvdXQKeWV0LgoKU28gQVBJLXdpc2UsIHRoZXJlIGFyZSBhIGZldyB3YXlzIHRv
IGdvLCBzbyBob3BlZnVsbHkgdGhpcyBzZXJpZXMgd2lsbApzdGFydCB0byBnaXZlIGEgZ29vZCBw
aWN0dXJlIG9mIHdoYXQncyBuZWVkZWQuCgpPbmUgdGhpbmcgSSd2ZSBub3RpY2VkIGlzIHRoYXQg
bW9zdCBvZiB0aGUgcHJhbmRvbV91MzJfbWF4KDIpCmludm9jYXRpb25zIGFyZSBpbiBkZWJ1ZyBv
ciB0ZXN0IGNvZGUsIHNvIHRoYXQgZG9lc24ndCBuZWVkIHRvIGJlCm9wdGltaXplZC4gQnV0IGtm
ZW5jZSBkb2VzIHRoYXQgdG9vIGluIGl0cyBob3QgcGF0aCwgc28gYQpnZXRfcmFuZG9tX2Jvb2wo
KSBmdW5jdGlvbiB0aGVyZSB3b3VsZCBpbiB0aGVvcnkgbGVhZCB0byBhbiA4eCBzcGVlZC11cC4K
QnV0IEkgZ3Vlc3MgSSBqdXN0IGhhdmUgdG8gdHJ5IHNvbWUgdGhpbmdzIGFuZCBzZWUuCgpBbnl3
YXksIHRoYXQgaXMgYSBsb25nIHdheSB0byBzYXksIEkgc2hhcmUgeW91IGN1cmlvc2l0eSBvbiB0
aGUgbWF0dGVyCmFuZCBJJ20gbG9va2luZyBpbnRvIGl0LgoKSmFzb24KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdAps
aW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21h
aWxtYW4vbGlzdGluZm8vbGludXgtdW0K

