Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [RFC PATCH v2 1/3] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907180058.64880-2-gerald.schaefer@linux.ibm.com>
 <82fbe8f9-f199-5fc2-4168-eb43ad0b0346@csgroup.eu>
 <70a3dcb5-5ed1-6efa-6158-d0573d6927da@de.ibm.com>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <96b80926-cf5b-1afa-9b7a-949a2188e61f@csgroup.eu>
Date: Tue, 8 Sep 2020 14:40:10 +0200
MIME-Version: 1.0
In-Reply-To: <70a3dcb5-5ed1-6efa-6158-d0573d6927da@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-power <linuxppc-dev@lists.ozlabs.org>, Mike Rapoport <rppt@kernel.org>

CgpMZSAwOC8wOS8yMDIwIMOgIDE0OjA5LCBDaHJpc3RpYW4gQm9ybnRyYWVnZXIgYSDDqWNyaXTC
oDoKPiAKPiAKPiBPbiAwOC4wOS4yMCAwNzowNiwgQ2hyaXN0b3BoZSBMZXJveSB3cm90ZToKPj4K
Pj4KPj4gTGUgMDcvMDkvMjAyMCDDoCAyMDowMCwgR2VyYWxkIFNjaGFlZmVyIGEgw6ljcml0wqA6
Cj4+PiBGcm9tOiBBbGV4YW5kZXIgR29yZGVldiA8YWdvcmRlZXZAbGludXguaWJtLmNvbT4KPj4+
Cj4+PiBDb21taXQgMWE0MjAxMGNkYzI2ICgiczM5MC9tbTogY29udmVydCB0byB0aGUgZ2VuZXJp
YyBnZXRfdXNlcl9wYWdlc19mYXN0Cj4+PiBjb2RlIikgaW50cm9kdWNlZCBhIHN1YnRsZSBidXQg
c2V2ZXJlIGJ1ZyBvbiBzMzkwIHdpdGggZ3VwX2Zhc3QsIGR1ZSB0bwo+Pj4gZHluYW1pYyBwYWdl
IHRhYmxlIGZvbGRpbmcuCj4+Pgo+Pj4gVGhlIHF1ZXN0aW9uICJXaGF0IHdvdWxkIGl0IHJlcXVp
cmUgZm9yIHRoZSBnZW5lcmljIGNvZGUgdG8gd29yayBmb3IgczM5MCIKPj4+IGhhcyBhbHJlYWR5
IGJlZW4gZGlzY3Vzc2VkIGhlcmUKPj4+IGh0dHBzOi8vbGttbC5rZXJuZWwub3JnL3IvMjAxOTA0
MTgxMDAyMTguMGE0YWZkNTFAbXNjaHdpZGVYMQo+Pj4gYW5kIGVuZGVkIHdpdGggYSBwcm9taXNp
bmcgYXBwcm9hY2ggaGVyZQo+Pj4gaHR0cHM6Ly9sa21sLmtlcm5lbC5vcmcvci8yMDE5MDQxOTE1
MzMwNy40ZjI5MTFiNUBtc2Nod2lkZVgxCj4+PiB3aGljaCBpbiB0aGUgZW5kIHVuZm9ydHVuYXRl
bHkgZGlkbid0IHF1aXRlIHdvcmsgY29tcGxldGVseS4KPj4+Cj4+PiBXZSB0cmllZCB0byBtaW1p
YyBzdGF0aWMgbGV2ZWwgZm9sZGluZyBieSBjaGFuZ2luZyBwZ2Rfb2Zmc2V0IHRvIGFsd2F5cwo+
Pj4gY2FsY3VsYXRlIHRvcCBsZXZlbCBwYWdlIHRhYmxlIG9mZnNldCwgYW5kIGRvIG5vdGhpbmcg
aW4gZm9sZGVkIHBYZF9vZmZzZXQuCj4+PiBXaGF0IGhhcyBiZWVuIG92ZXJsb29rZWQgaXMgdGhh
dCBQeERfU0laRS9NQVNLIGFuZCB0aHVzIHBYZF9hZGRyX2VuZCBkbwo+Pj4gbm90IHJlZmxlY3Qg
dGhpcyBkeW5hbWljIGJlaGF2aW91ciwgYW5kIHN0aWxsIGFjdCBsaWtlIHN0YXRpYyA1LWxldmVs
Cj4+PiBwYWdlIHRhYmxlcy4KPj4+Cj4+Cj4+IFsuLi5dCj4+Cj4+Pgo+Pj4gRml4IHRoaXMgYnkg
aW50cm9kdWNpbmcgbmV3IHBYZF9hZGRyX2VuZF9mb2xkZWQgaGVscGVycywgd2hpY2ggdGFrZSBh
bgo+Pj4gYWRkaXRpb25hbCBwWGQgZW50cnkgdmFsdWUgcGFyYW1ldGVyLCB0aGF0IGNhbiBiZSB1
c2VkIG9uIHMzOTAKPj4+IHRvIGRldGVybWluZSB0aGUgY29ycmVjdCBwYWdlIHRhYmxlIGxldmVs
IGFuZCByZXR1cm4gY29ycmVzcG9uZGluZwo+Pj4gZW5kIC8gYm91bmRhcnkuIFdpdGggdGhhdCwg
dGhlIHBvaW50ZXIgaXRlcmF0aW9uIHdpbGwgYWx3YXlzCj4+PiBoYXBwZW4gaW4gZ3VwX3BnZF9y
YW5nZSBmb3IgczM5MC4gTm8gY2hhbmdlIGZvciBvdGhlciBhcmNoaXRlY3R1cmVzCj4+PiBpbnRy
b2R1Y2VkLgo+Pgo+PiBOb3Qgc3VyZSBwWGRfYWRkcl9lbmRfZm9sZGVkKCkgaXMgdGhlIGJlc3Qg
dW5kZXJzdGFuZGFibGUgbmFtZSwgYWxsdGhvdWdoIEkgZG9uJ3QgaGF2ZSBhbnkgYWx0ZXJuYXRp
dmUgc3VnZ2VzdGlvbiBhdCB0aGUgbW9tZW50Lgo+PiBNYXliZSBjb3VsZCBiZSBzb21ldGhpbmcg
bGlrZSBwWGRfYWRkcl9lbmRfZml4dXAoKSBhcyBpdCB3aWxsIGRpc2FwcGVhciBpbiB0aGUgbmV4
dCBwYXRjaCwgb3IgcFhkX2FkZHJfZW5kX2d1cCgpID8KPj4KPj4gQWxzbywgaWYgaXQgaGFwcGVu
cyB0byBiZSBhY2NlcHRhYmxlIHRvIGdldCBwYXRjaCAyIGluIHN0YWJsZSwgSSB0aGluayB5b3Ug
c2hvdWxkIHN3aXRjaCBwYXRjaCAxIGFuZCBwYXRjaCAyIHRvIGF2b2lkIHRoZSBzdGVwIHRocm91
Z2ggcFhkX2FkZHJfZW5kX2ZvbGRlZCgpCj4gCj4gZ2l2ZW4gdGhhdCB0aGlzIGZpeGVzIGEgZGF0
YSBjb3JydXB0aW9uIGlzc3VlLCB3b3VsZG50IGl0IGJlIHRoZSBiZXN0IHRvIGdvIGZvcndhcmQK
PiB3aXRoIHRoaXMgcGF0Y2ggQVNBUCBhbmQgdGhlbiBoYW5kbGUgdGhlIG90aGVyIHBhdGNoZXMg
b24gdG9wIHdpdGggYWxsIHRoZSB0aW1lIHRoYXQKPiB3ZSBuZWVkPwoKSSBoYXZlIG5vIHN0cm9u
ZyBvcGluaW9uIG9uIHRoaXMsIGJ1dCBJIGZlZWwgcmF0aGVyIHRyaWNreSB0byBoYXZlIHRvIApj
aGFuZ2UgZ2VuZXJpYyBwYXJ0IG9mIEdVUCB0byB1c2UgYSBuZXcgZm9uY3Rpb24gdGhlbiByZXZl
cnQgdGhhdCBjaGFuZ2UgCmluIHRoZSBmb2xsb3dpbmcgcGF0Y2gsIGp1c3QgYmVjYXVzZSB5b3Ug
d2FudCB0aGUgZmlyc3QgcGF0Y2ggaW4gc3RhYmxlIAphbmQgbm90IHRoZSBzZWNvbmQgb25lLgoK
UmVnYXJkbGVzcywgSSB3YXMgd29uZGVyaW5nLCB3aHkgZG8gd2UgbmVlZCBhIHJlZmVyZW5jZSB0
byB0aGUgcFhkIGF0IAphbGwgd2hlbiBjYWxsaW5nIHBYZF9hZGRyX2VuZCgpID8KCkNvdWxkbid0
IFMzOTAgcmV0cmlldmUgdGhlIHBYZCBieSB1c2luZyB0aGUgcFhkX29mZnNldCgpIGRhbmNlIHdp
dGggdGhlIApwYXNzZWQgYWRkciA/CgpDaHJpc3RvcGhlCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==

