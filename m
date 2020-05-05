Return-Path: <Vineet.Gupta1@synopsys.com>
From: Vineet Gupta <Vineet.Gupta1@synopsys.com>
Subject: Re: [PATCH v2 17/20] mm: free_area_init: allow defining max_zone_pfn
 in descending order
Date: Tue, 5 May 2020 17:27:16 +0000
Message-ID: <51b468f8-c05b-a019-f473-429622083045@synopsys.com>
References: <20200429121126.17989-1-rppt@kernel.org>
 <20200429121126.17989-18-rppt@kernel.org>
 <20200503174138.GA114085@roeck-us.net> <20200503184300.GA154219@roeck-us.net>
 <20200504153901.GM14260@kernel.org>
 <ca099c3e-c0bc-cd2f-cdb0-852dfc2c10db@roeck-us.net>
In-Reply-To: <ca099c3e-c0bc-cd2f-cdb0-852dfc2c10db@roeck-us.net>
Content-Language: en-US
Content-Type: text/plain; charset="utf-8"
Content-ID: <71155D187A337740904D5836ABF4A094@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
To: Guenter Roeck <linux@roeck-us.net>, Mike Rapoport <rppt@kernel.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Rich Felker <dalias@libc.org>, "linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>, "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Michal Hocko <mhocko@kernel.org>, "James E.J. Bottomley" <James.Bottomley@hansenpartnership.com>, Max Filippov <jcmvbkbc@gmail.com>, Guo Ren <guoren@kernel.org>, "linux-csky@vger.kernel.org" <linux-csky@vger.kernel.org>, "linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>, "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>, "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>, "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>, Mike Rapoport <rppt@linux.ibm.com>, "Greg" Ungerer" <gerg@linux-m68k.org>, "linux-arch@vger.kernel.org, linux-arch@vger.kernel.org, "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>, "linux-c6x-dev@linux-c6x.org" <linux-c6x-dev@linux-c6x.org>, Baoquan He <bhe@redhat.com>, Jonathan Corbet <corbet@lwn.net>, "linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>, Michael Ellerman <mpe@ellerman.id.au>, Helge Deller <deller@gmx.de>, "x86@kernel.org" <x86@kernel.org>, Russell King <linux@armlinux.org.uk>, Ley Foon Tan <ley.foon.tan@intel.com>, Yoshinori Sato <ysato@users.sourceforge.jp>, Geert Uytterhoeven <geert@linux-m68k.org>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Mark Salter <msalter@redhat.com>, Matt Turner <mattst88@gmail.com>, "linux-snps-arc@lists.infradead.org" <linux-snps-arc@lists.infradead.org>, "uclinux-h8-devel@lists.sourceforge.jp" <uclinux-h8-devel@lists.sourceforge.jp>, "linux-xtensa@linux-xtensa.org" <linux-xtensa@linux-xtensa.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, "linux-um@lists.infradead.org" <linux-um@lists.infradead.org>, "linux-m68k@lists.linux-m68k.org" <linux-m68k@lists.linux-m68k.org>, Tony Luck <tony.luck@intel.com>, Qian Cai <cai@lca.pw>, Greentime Hu <green.hu@gmail.com>, Paul Walmsley <paul.walmsley@sifive.com>, Stafford Horne <shorne@gmail.com>, Guan Xuetao <gxt@pku.edu.cn>, Hoan Tran <Hoan@os.amperecomputing.com>, Michal Simek <monstr@monstr.eu>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, "Brian Cain  <bcain@codeaurora.org>, Nick Hu <nickhu@andestech.com>, linux-mm@kvack.org" <linux-mm@kvack.org>, "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>, "openrisc@lists.librecores.org" <openrisc@lists.librecores.org>, Richard Weinberger <richard@nod.at>, Andrew Morton <akpm@linux-foundation.org>, "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "David S. Miller" <davem@davemloft.net>
List-ID: <linux-um.lists.infradead.org>

T24gNS81LzIwIDY6MTggQU0sIEd1ZW50ZXIgUm9lY2sgd3JvdGU6DQo+IE9uIDUvNC8yMCA4OjM5
IEFNLCBNaWtlIFJhcG9wb3J0IHdyb3RlOg0KPj4gT24gU3VuLCBNYXkgMDMsIDIwMjAgYXQgMTE6
NDM6MDBBTSAtMDcwMCwgR3VlbnRlciBSb2VjayB3cm90ZToNCj4+PiBPbiBTdW4sIE1heSAwMywg
MjAyMCBhdCAxMDo0MTozOEFNIC0wNzAwLCBHdWVudGVyIFJvZWNrIHdyb3RlOg0KPj4+PiBIaSwN
Cj4+Pj4NCj4+Pj4gT24gV2VkLCBBcHIgMjksIDIwMjAgYXQgMDM6MTE6MjNQTSArMDMwMCwgTWlr
ZSBSYXBvcG9ydCB3cm90ZToNCj4+Pj4+IEZyb206IE1pa2UgUmFwb3BvcnQgPHJwcHRAbGludXgu
aWJtLmNvbT4NCj4+Pj4+DQo+Pj4+PiBTb21lIGFyY2hpdGVjdHVyZXMgKGUuZy4gQVJDKSBoYXZl
IHRoZSBaT05FX0hJR0hNRU0gem9uZSBiZWxvdyB0aGUNCj4+Pj4+IFpPTkVfTk9STUFMLiBBbGxv
d2luZyBmcmVlX2FyZWFfaW5pdCgpIHBhcnNlIG1heF96b25lX3BmbiBhcnJheSBldmVuIGl0IGlz
DQo+Pj4+PiBzb3J0ZWQgaW4gZGVzY2VuZGluZyBvcmRlciBhbGxvd3MgdXNpbmcgZnJlZV9hcmVh
X2luaXQoKSBvbiBzdWNoDQo+Pj4+PiBhcmNoaXRlY3R1cmVzLg0KPj4+Pj4NCj4+Pj4+IEFkZCB0
b3AgLT4gZG93biB0cmF2ZXJzYWwgb2YgbWF4X3pvbmVfcGZuIGFycmF5IGluIGZyZWVfYXJlYV9p
bml0KCkgYW5kIHVzZQ0KPj4+Pj4gdGhlIGxhdHRlciBpbiBBUkMgbm9kZS96b25lIGluaXRpYWxp
emF0aW9uLg0KPj4+Pj4NCj4+Pj4+IFNpZ25lZC1vZmYtYnk6IE1pa2UgUmFwb3BvcnQgPHJwcHRA
bGludXguaWJtLmNvbT4NCj4+Pj4gVGhpcyBwYXRjaCBjYXVzZXMgbXkgbWljcm9ibGF6ZWVsIHFl
bXUgYm9vdCB0ZXN0IGluIGxpbnV4LW5leHQgdG8gZmFpbC4NCj4+Pj4gUmV2ZXJ0aW5nIGl0IGZp
eGVzIHRoZSBwcm9ibGVtLg0KPj4+Pg0KPj4+IFRoZSBzYW1lIHByb2JsZW0gaXMgc2VlbiB3aXRo
IHMzOTAgZW11bGF0aW9ucy4NCj4+IFllYWgsIHRoaXMgcGF0Y2ggYnJlYWtzIHNvbWUgb3RoZXJz
IGFzIHdlbGwgOigNCj4+DQo+PiBNeSBhc3N1bXB0aW9uIHRoYXQgbWF4X3pvbmVfcGZuIGRlZmlu
ZXMgYXJjaGl0ZWN0dXJhbCBsaW1pdCBmb3IgbWF4aW1hbA0KPj4gUEZOIHRoYXQgY2FuIGJlbG9u
ZyB0byBhIHpvbmUgd2FzIG92ZXItb3B0aW1pc3RpYy4gU2V2ZXJhbCBhcmNoZXMNCj4+IGFjdHVh
bGx5IGRvIHRoYXQsIGJ1dCBvdGhlcnMgZG8NCj4+DQo+PiAJbWF4X3pvbmVfcGZuW1pPTkVfRE1B
XSA9IE1BWF9ETUFfUEZOOw0KPj4gCW1heF96b25lX3BmbltaT05FX05PUk1BTF0gPSBtYXhfcGZu
Ow0KPj4NCj4+IHdoZXJlIE1BWF9ETUFfUEZOIGlzIGJ1aWxkLXRpbWUgY29uc3RyYWluIGFuZCBt
YXhfcGZuIGlzIHJ1biB0aW1lIGxpbWl0DQo+PiBmb3IgdGhlIGN1cnJlbnQgc3lzdGVtLg0KPj4N
Cj4+IFNvLCB3aGVuIG1heF9wZm4gaXMgbG93ZXIgdGhhbiBNQVhfRE1BX1BGTiwgdGhlIGZyZWVf
aW5pdF9hcmVhKCkgd2lsbA0KPj4gY29uc2lkZXIgbWF4X3pvbmVfcGZuIGFzIGRlc2NlbmRpbmcg
YW5kIHdpbGwgd3JvbmdseSBjYWxjdWxhdGUgem9uZQ0KPj4gZXh0ZW50cy4NCj4+DQo+PiBUaGF0
IHNhaWQsIGluc3RlYWQgb2YgdHJ5aW5nIHRvIGNyZWF0ZSBhIGdlbmVyaWMgd2F5IHRvIHNwZWNp
YWwgY2FzZQ0KPj4gQVJDLCBJIHN1Z2dlc3QgdG8gc2ltcGx5IHVzZSB0aGUgYmVsb3cgcGF0Y2gg
aW5zdGVhZC4NCj4+DQo+IEFzIGEgcmVtaW5kZXIsIEkgcmVwb3J0ZWQgdGhlIHByb2JsZW0gYWdh
aW5zdCBzMzkwIGFuZCBtaWNyb2JsYXplZWwNCj4gKGludGVyZXN0aW5nbHkgZW5vdWdoLCBtaWNy
b2JsYXplIChiaWcgZW5kaWFuKSB3b3JrcyksIG5vdCBhZ2FpbnN0IGFyYy4NCg0KVW5kZXJzdG9v
ZCBhbmQgbXkgY29tbWVudCB3YXMgdG8gcG9pbnQgdG8gYW55IG90aGVyIHByb2JsZW1zIGluIGZ1
dHVyZS4NCg0KVGh4LA0KLVZpbmVldA0K

