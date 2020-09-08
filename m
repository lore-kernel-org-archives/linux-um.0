Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Subject: Re: [RFC PATCH v2 0/3] mm/gup: fix gup_fast with dynamic page table
 folding
References: <20200907180058.64880-1-gerald.schaefer@linux.ibm.com>
 <20200907201256.GC1976319@kernel.org>
From: Christophe Leroy <christophe.leroy@csgroup.eu>
Message-ID: <9bde9857-fdfd-e384-ea27-a14e5a06f1e6@csgroup.eu>
Date: Tue, 8 Sep 2020 07:22:39 +0200
MIME-Version: 1.0
In-Reply-To: <20200907201256.GC1976319@kernel.org>
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
To: Mike Rapoport <rppt@kernel.org>, Gerald Schaefer <gerald.schaefer@linux.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Catalin Marinas <catalin.marinas@arm.com>, Dave Hansen <dave.hansen@linux.intel.com>, linux-mm <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, linux-sparc <sparclinux@vger.kernel.org>, Alexander Gordeev <agordeev@linux.ibm.com>, Claudio Imbrenda <imbrenda@linux.ibm.com>, Will Deacon <will@kernel.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Vasily Gorbik <gor@linux.ibm.com>, Jason Gunthorpe <jgg@ziepe.ca>, Richard Weinberger <richard@nod.at>, linux-x86 <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Christian Borntraeger <borntraeger@de.ibm.com>, Ingo Molnar <mingo@redhat.com>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Jeff Dike <jdike@addtoit.com>, Arnd Bergmann <arnd@arndb.de>, John Hubbard <jhubbard@nvidia.com>, Heiko Carstens <hca@linux.ibm.com>, linux-um <linux-um@lists.infradead.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm <linux-arm-kernel@lists.infradead.org>, Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, Andrew Morton <akpm@linux-foundation.org>, linux-power <linuxppc-dev@lists.ozlabs.org>

CgpMZSAwNy8wOS8yMDIwIMOgIDIyOjEyLCBNaWtlIFJhcG9wb3J0IGEgw6ljcml0wqA6Cj4gT24g
TW9uLCBTZXAgMDcsIDIwMjAgYXQgMDg6MDA6NTVQTSArMDIwMCwgR2VyYWxkIFNjaGFlZmVyIHdy
b3RlOgo+PiBUaGlzIGlzIHYyIG9mIGFuIFJGQyBwcmV2aW91c2x5IGRpc2N1c3NlZCBoZXJlOgo+
PiBodHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzIwMjAwODI4MTQwMzE0Ljg1NTYtMS1nZXJh
bGQuc2NoYWVmZXJAbGludXguaWJtLmNvbS8KPj4KPj4gUGF0Y2ggMSBpcyBhIGZpeCBmb3IgYSBy
ZWdyZXNzaW9uIGluIGd1cF9mYXN0IG9uIHMzOTAsIGFmdGVyIG91ciBjb252ZXJzaW9uCj4+IHRv
IGNvbW1vbiBndXBfZmFzdCBjb2RlLiBJdCB3aWxsIGludHJvZHVjZSBzcGVjaWFsIGhlbHBlciBm
dW5jdGlvbnMKPj4gcFhkX2FkZHJfZW5kX2ZvbGRlZCgpLCB3aGljaCBoYXZlIHRvIGJlIHVzZWQg
aW4gcGxhY2VzIHdoZXJlIHBhZ2V0YWJsZSB3YWxrCj4+IGlzIGRvbmUgdy9vIGxvY2sgYW5kIHdp
dGggUkVBRF9PTkNFLCBzbyBjdXJyZW50bHkgb25seSBpbiBndXBfZmFzdC4KPj4KPj4gUGF0Y2gg
MiBpcyBhbiBhdHRlbXB0IHRvIG1ha2UgdGhhdCBtb3JlIGdlbmVyaWMsIGkuZS4gY2hhbmdlIHBY
ZF9hZGRyX2VuZCgpCj4+IHRoZW1zZWx2ZXMgYnkgYWRkaW5nIGFuIGV4dHJhIHBYZCB2YWx1ZSBw
YXJhbWV0ZXIuIFRoYXQgd2FzIHN1Z2dlc3RlZCBieQo+PiBKYXNvbiBkdXJpbmcgdjEgZGlzY3Vz
c2lvbiwgYmVjYXVzZSBoZSBpcyBhbHJlYWR5IHRoaW5raW5nIG9mIHNvbWUgb3RoZXIKPj4gcGxh
Y2VzIHdoZXJlIGhlIG1pZ2h0IHdhbnQgdG8gc3dpdGNoIHRvIHRoZSBSRUFEX09OQ0UgbG9naWMg
Zm9yIHBhZ2V0YWJsZQo+PiB3YWxrcy4gSW4gZ2VuZXJhbCwgdGhhdCB3b3VsZCBiZSB0aGUgY2xl
YW5lc3QgLyBzYWZlc3Qgc29sdXRpb24sIGJ1dCB0aGVyZQo+PiBpcyBzb21lIGltcGFjdCBvbiBv
dGhlciBhcmNoaXRlY3R1cmVzIGFuZCBjb21tb24gY29kZSwgaGVuY2UgdGhlIG5ldyBhbmQKPj4g
Z3JlYXRseSBlbmxhcmdlZCByZWNpcGllbnQgbGlzdC4KPj4KPj4gUGF0Y2ggMyBpcyBhICJuaWNl
IHRvIGhhdmUiIGFkZC1vbiwgd2hpY2ggbWFrZXMgcFhkX2FkZHJfZW5kKCkgaW5saW5lCj4+IGZ1
bmN0aW9ucyBpbnN0ZWFkIG9mICNkZWZpbmVzLCBzbyB0aGF0IHdlIGdldCBzb21lIHR5cGUgY2hl
Y2tpbmcgZm9yIHRoZQo+PiBuZXcgcFhkIHZhbHVlIHBhcmFtZXRlci4KPj4KPj4gTm90IHN1cmUg
YWJvdXQgRml4ZXMvc3RhYmxlIHRhZ3MgZm9yIHRoZSBnZW5lcmljIHNvbHV0aW9uLiBPbmx5IHBh
dGNoIDEKPj4gZml4ZXMgYSByZWFsIGJ1ZyBvbiBzMzkwLCBhbmQgaGFzIEZpeGVzL3N0YWJsZSB0
YWdzLiBQYXRjaGVzIDIgKyAzIG1pZ2h0Cj4+IHN0aWxsIGJlIG5pY2UgdG8gaGF2ZSBpbiBzdGFi
bGUsIHRvIGVhc2UgZnV0dXJlIGJhY2twb3J0cywgYnV0IEkgZ3Vlc3MKPj4gIm5pY2UgdG8gaGF2
ZSIgZG9lcyBub3QgcmVhbGx5IHF1YWxpZnkgZm9yIHN0YWJsZSBiYWNrcG9ydHMuCj4gCj4gSSBh
bHNvIHRoaW5rIHRoYXQgYWRkaW5nIHBYZCBwYXJhbWV0ZXIgdG8gcFhkX2FkZHJfZW5kKCkgaXMg
YSBjbGVhbmVyCj4gd2F5IGFuZCB3aXRoIHRoaXMgcGF0Y2ggMSBpcyBub3QgcmVhbGx5IHJlcXVp
cmVkLiBJIHdvdWxkIGV2ZW4gbWVyZ2UKPiBwYXRjaGVzIDIgYW5kIDMgaW50byBhIHNpbmdsZSBw
YXRjaCBhbmQgdXNlIG9ubHkgaXQgYXMgdGhlIGZpeC4KCldoeSBub3QgbWVyZ2luZyBwYXRjaGVz
IDIgYW5kIDMsIGJ1dCBJIHdvdWxkIGtlZXAgcGF0Y2ggMSBzZXBhcmF0ZSBidXQgCmFmdGVyIHRo
ZSBnZW5lcmljIGNoYW5nZXMsIHNvIHRoYXQgd2UgZmlyc3QgZG8gdGhlIGdlbmVyaWMgY2hhbmdl
cywgdGhlbiAKd2UgZG8gdGhlIHNwZWNpZmljIFMzOTAgdXNlIG9mIGl0LgoKQ2hyaXN0b3BoZQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0g
bWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmlu
ZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

