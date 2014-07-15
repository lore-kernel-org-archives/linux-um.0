Return-Path: <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
MIME-Version: 1.0
In-Reply-To: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
References: <70f331f59e620dc4e66bd3fa095e6f6b744b532b.1405281639.git.luto@amacapital.net>
From: Andy Lutomirski <luto@amacapital.net>
Date: Tue, 15 Jul 2014 07:47:26 -0700
Message-ID: <CALCETrXG6nL4K=Er+kv5-CXBDVa0TLg9yR6iePnMyE2ufXgKkw@mail.gmail.com>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+geert=linux-m68k.org@lists.ozlabs.org>
Subject: Re: [PATCH v3] arm64, ia64, ppc, s390, sh, tile, um, x86,
 mm: Remove default gate area
To: Andy Lutomirski <luto@amacapital.net>
Cc: linux-ia64@vger.kernel.org, linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, "linux-mm@kvack.org" <linux-mm@kvack.org>, Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>, linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Richard Weinberger <richard@nod.at>, X86 ML <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, Fenghua Yu <fenghua.yu@intel.com>, user-mode-linux-devel@lists.sourceforge.net, Will Deacon <will.deacon@arm.com>, Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>, Thomas Gleixner <tglx@linutronix.de>, "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>, Tony Luck <tony.luck@intel.com>, Nathan Lynch <Nathan_Lynch@mentor.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com, linuxppc-dev@lists.ozlabs.org
List-ID: <user-mode-linux-devel.lists.sourceforge.net>

T24gU3VuLCBKdWwgMTMsIDIwMTQgYXQgMTowMSBQTSwgQW5keSBMdXRvbWlyc2tpIDxsdXRvQGFt
YWNhcGl0YWwubmV0PiB3cm90ZToKPiBUaGUgY29yZSBtbSBjb2RlIHdpbGwgcHJvdmlkZSBhIGRl
ZmF1bHQgZ2F0ZSBhcmVhIGJhc2VkIG9uCj4gRklYQUREUl9VU0VSX1NUQVJUIGFuZCBGSVhBRERS
X1VTRVJfRU5EIGlmCj4gIWRlZmluZWQoX19IQVZFX0FSQ0hfR0FURV9BUkVBKSAmJiBkZWZpbmVk
KEFUX1NZU0lORk9fRUhEUikuCj4KPiBUaGlzIGRlZmF1bHQgaXMgb25seSB1c2VmdWwgZm9yIGlh
NjQuICBhcm02NCwgcHBjLCBzMzkwLCBzaCwgdGlsZSwKPiA2NC1iaXQgVU1MLCBhbmQgeDg2XzMy
IGhhdmUgdGhlaXIgb3duIGNvZGUganVzdCB0byBkaXNhYmxlIGl0LiAgYXJtLAo+IDMyLWJpdCBV
TUwsIGFuZCB4ODZfNjQgaGF2ZSBnYXRlIGFyZWFzLCBidXQgdGhleSBoYXZlIHRoZWlyIG93bgo+
IGltcGxlbWVudGF0aW9ucy4KPgo+IFRoaXMgZ2V0cyByaWQgb2YgdGhlIGRlZmF1bHQgYW5kIG1v
dmVzIHRoZSBjb2RlIGludG8gaWE2NC4KPgo+IFRoaXMgc2hvdWxkIHNhdmUgc29tZSBjb2RlIG9u
IGFyY2hpdGVjdHVyZXMgd2l0aG91dCBhIGdhdGUgYXJlYTogaXQncwo+IG5vdyBwb3NzaWJsZSB0
byBpbmxpbmUgdGhlIGdhdGVfYXJlYSBmdW5jdGlvbnMgaW4gdGhlIGRlZmF1bHQgY2FzZS4KCkNh
biBvbmUgb2YgeW91IHB1bGwgdGhpcyBzb21ld2hlcmU/ICBPdGhlcndpc2UgSSBjYW4gcHV0IGl0
IHNvbWV3aGVyZQpzdGFibGUgYW5kIGFzayBmb3IgLW5leHQgaW5jbHVzaW9uLCBidXQgdGhhdCBz
ZWVtcyBsaWtlIG92ZXJraWxsIGZvciBhCnNpbmdsZSBwYXRjaC4KCi0tQW5keQpfX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpMaW51eHBwYy1kZXYgbWFpbGlu
ZyBsaXN0CkxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnCmh0dHBzOi8vbGlzdHMub3psYWJz
Lm9yZy9saXN0aW5mby9saW51eHBwYy1kZXY=

