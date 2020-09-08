Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9f9acde7-c400-53b0-38ec-ad3e48de5371@csgroup.eu>
Date: Tue, 8 Sep 2020 06:42:50 +0200
MIME-Version: 1.0
In-Reply-To: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
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
To: Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>

CgpMZSAwNy8wOS8yMDIwIMOgIDIwOjAwLCBHZXJhbGQgU2NoYWVmZXIgYSDDqWNyaXTCoDoKPiBU
aGlzIGlzIHYyIG9mIGFuIFJGQyBwcmV2aW91c2x5IGRpc2N1c3NlZCBoZXJlOgo+IGh0dHBzOi8v
bG9yZS5rZXJuZWwub3JnL2xrbWwvMjAyMDA4MjgxNDAzMTQuODU1Ni0xLWdlcmFsZC5zY2hhZWZl
ckBsaW51eC5pYm0uY29tLwo+IAo+IFBhdGNoIDEgaXMgYSBmaXggZm9yIGEgcmVncmVzc2lvbiBp
biBndXBfZmFzdCBvbiBzMzkwLCBhZnRlciBvdXIgY29udmVyc2lvbgo+IHRvIGNvbW1vbiBndXBf
ZmFzdCBjb2RlLiBJdCB3aWxsIGludHJvZHVjZSBzcGVjaWFsIGhlbHBlciBmdW5jdGlvbnMKPiBw
WGRfYWRkcl9lbmRfZm9sZGVkKCksIHdoaWNoIGhhdmUgdG8gYmUgdXNlZCBpbiBwbGFjZXMgd2hl
cmUgcGFnZXRhYmxlIHdhbGsKPiBpcyBkb25lIHcvbyBsb2NrIGFuZCB3aXRoIFJFQURfT05DRSwg
c28gY3VycmVudGx5IG9ubHkgaW4gZ3VwX2Zhc3QuCj4gCj4gUGF0Y2ggMiBpcyBhbiBhdHRlbXB0
IHRvIG1ha2UgdGhhdCBtb3JlIGdlbmVyaWMsIGkuZS4gY2hhbmdlIHBYZF9hZGRyX2VuZCgpCj4g
dGhlbXNlbHZlcyBieSBhZGRpbmcgYW4gZXh0cmEgcFhkIHZhbHVlIHBhcmFtZXRlci4gVGhhdCB3
YXMgc3VnZ2VzdGVkIGJ5Cj4gSmFzb24gZHVyaW5nIHYxIGRpc2N1c3Npb24sIGJlY2F1c2UgaGUg
aXMgYWxyZWFkeSB0aGlua2luZyBvZiBzb21lIG90aGVyCj4gcGxhY2VzIHdoZXJlIGhlIG1pZ2h0
IHdhbnQgdG8gc3dpdGNoIHRvIHRoZSBSRUFEX09OQ0UgbG9naWMgZm9yIHBhZ2V0YWJsZQo+IHdh
bGtzLiBJbiBnZW5lcmFsLCB0aGF0IHdvdWxkIGJlIHRoZSBjbGVhbmVzdCAvIHNhZmVzdCBzb2x1
dGlvbiwgYnV0IHRoZXJlCj4gaXMgc29tZSBpbXBhY3Qgb24gb3RoZXIgYXJjaGl0ZWN0dXJlcyBh
bmQgY29tbW9uIGNvZGUsIGhlbmNlIHRoZSBuZXcgYW5kCj4gZ3JlYXRseSBlbmxhcmdlZCByZWNp
cGllbnQgbGlzdC4KPiAKPiBQYXRjaCAzIGlzIGEgIm5pY2UgdG8gaGF2ZSIgYWRkLW9uLCB3aGlj
aCBtYWtlcyBwWGRfYWRkcl9lbmQoKSBpbmxpbmUKPiBmdW5jdGlvbnMgaW5zdGVhZCBvZiAjZGVm
aW5lcywgc28gdGhhdCB3ZSBnZXQgc29tZSB0eXBlIGNoZWNraW5nIGZvciB0aGUKPiBuZXcgcFhk
IHZhbHVlIHBhcmFtZXRlci4KPiAKPiBOb3Qgc3VyZSBhYm91dCBGaXhlcy9zdGFibGUgdGFncyBm
b3IgdGhlIGdlbmVyaWMgc29sdXRpb24uIE9ubHkgcGF0Y2ggMQo+IGZpeGVzIGEgcmVhbCBidWcg
b24gczM5MCwgYW5kIGhhcyBGaXhlcy9zdGFibGUgdGFncy4gUGF0Y2hlcyAyICsgMyBtaWdodAo+
IHN0aWxsIGJlIG5pY2UgdG8gaGF2ZSBpbiBzdGFibGUsIHRvIGVhc2UgZnV0dXJlIGJhY2twb3J0
cywgYnV0IEkgZ3Vlc3MKPiAibmljZSB0byBoYXZlIiBkb2VzIG5vdCByZWFsbHkgcXVhbGlmeSBm
b3Igc3RhYmxlIGJhY2twb3J0cy4KCklmIG9uZSBkYXkgeW91IGhhdmUgdG8gYmFja3BvcnQgYSBm
aXggdGhhdCByZXF1aXJlcyBwYXRjaCAyIGFuZC9vciAzLCAKanVzdCBtYXJrIGl0ICJkZXBlbmRz
LW9uOiIgYW5kIHRoZSBwYXRjaGVzIHdpbGwgZ28gaW4gc3RhYmxlIGF0IHRoZSAKcmVsZXZhbnQg
dGltZS4KCkNocmlzdG9waGUKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

