Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-wr1-x436.google.com ([2a00:1450:4864:20::436])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oF0Mk-00BYrZ-PF
	for linux-um@lists.infradead.org; Fri, 22 Jul 2022 21:39:24 +0000
Received: by mail-wr1-x436.google.com with SMTP id g2so99607wru.3
        for <linux-um@lists.infradead.org>; Fri, 22 Jul 2022 14:39:20 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.80.82.1.1\))
Subject: Re: [PATCH v3 2/2] asm-generic: Add new pci.h and use it
From: Jessica Clarke <jrtc27@jrtc27.com>
In-Reply-To: <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
Date: Fri, 22 Jul 2022 22:39:18 +0100
Message-Id: <41B9AC54-DCFE-4055-B950-265B3CBDD842@jrtc27.com>
References: <CAL_Jsq+_5-fhXddhxG2mr-4HD_brcKZExkZqvME1yEpa6dOGGg@mail.gmail.com>
 <mhng-7e3146ca-79b8-4e16-98a9-e354fb6d03ba@palmer-mbp2014>
 <CAL_JsqJHZEcnJi+UHQbYWVoy1okQjHSc9T377P1q8oOJnHBWFw@mail.gmail.com>
 <CAK8P3a2aTS74TG8F+cVHX969hMQHKP3Ai5V0h-m+GeAq6kq5pQ@mail.gmail.com>
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
To: Arnd Bergmann <arnd@arndb.de>
Cc: Rob Herring <robh@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Bjorn Helgaas <bhelgaas@google.com>, "Maciej W. Rozycki" <macro@orcam.me.uk>, Stafford Horne <shorne@gmail.com>, "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Guo Ren <guoren@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>, Albert Ou <aou@eecs.berkeley.edu>, Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>, linux-csky@vger.kernel.org, linux-riscv <linux-riscv@lists.infradead.org>, linux-um <linux-um@lists.infradead.org>, PCI <linux-pci@vger.kernel.org>, "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>

T24gMjIgSnVsIDIwMjIsIGF0IDIwOjU1LCBBcm5kIEJlcmdtYW5uIDxhcm5kQGFybmRiLmRlPiB3
cm90ZToKPiAKPiBPbiBGcmksIEp1bCAyMiwgMjAyMiBhdCA2OjM2IFBNIFJvYiBIZXJyaW5nIDxy
b2JoQGtlcm5lbC5vcmc+IHdyb3RlOgo+PiBPbiBGcmksIEp1bCAyMiwgMjAyMiBhdCA5OjI3IEFN
IFBhbG1lciBEYWJiZWx0IDxwYWxtZXJAZGFiYmVsdC5jb20+IHdyb3RlOgo+PiAKPj4gRnJvbSBm
dTc0MDoKPj4gICAgICAgICAgICAgICAgICAgICAgIHJhbmdlcyA9IDwweDgxMDAwMDAwICAweDAg
MHg2MDA4MDAwMCAgMHgwCj4+IDB4NjAwODAwMDAgMHgwIDB4MTAwMDA+LCAgICAgIC8qIEkvTyAq
Lwo+IC4uLgo+PiBTbyBhZ2FpbiwgaG93IGRvZXMgb25lIGdldCBhIDAgYWRkcmVzcyBoYW5kZWQg
b3V0IHdoZW4gdGhhdCdzIG5vdCBldmVuCj4+IGEgdmFsaWQgcmVnaW9uIGFjY29yZGluZyB0byBE
VD8gSXMgdGhlcmUgc29tZSBsZWdhY3kgc3R1ZmYgdGhhdAo+PiBpZ25vcmVzIHRoZSBicmlkZ2Ug
d2luZG93cz8KPiAKPiBUaGUgUENJLXNpZGUgcG9ydCBudW1iZXIgMHg2MDA4MDAwMCBnZXRzIHR1
cm5lZCBpbnRvIExpbnV4IEkvTyByZXNvdXJjZSAwLAo+IHdoaWNoIEkgdGhpbmsgaXMgd2hhdCBf
X3BjaV9hc3NpZ25fcmVzb3VyY2Ugb3BlcmF0ZXMgb24uCj4gCj4gVGhlIG90aGVyIHF1ZXN0aW9u
IGlzIHdoeSB0aGUgcGxhdGZvcm0gd291bGQgd2FudCB0byBjb25maWd1cmUgdGhlCj4gUENJIGJ1
cyB0byBoYXZlIGEgUENJIEkvTyBzcGFjZSB3aW5kb3cgb2Ygc2l6ZSAweDEwMDAwIGF0IHRoZSBh
ZGRyZXNzCj4gaXQncyBtYXBwZWQgaW50bywgcmF0aGVyIHRoYW4gcHV0dGluZyBpdCBhdCBhZGRy
ZXNzIHplcm8uIElzIHRoaXMgYSBoYXJkd2FyZQo+IGJ1ZywgYSBib290bG9hZGVyIGJ1Zywgb3Ig
anVzdCBiYWRseSBzZXQgdXAgaW4gdGhlIERUPwo+IAo+IFB1dHRpbmcgdGhlIFBDSSBhZGRyZXNz
IG9mIHRoZSBJL08gc3BhY2Ugd2luZG93IGF0IHBvcnQgMCBpcyB1c3VhbGx5Cj4gYmV0dGVyIGJl
Y2F1c2UgaXQgd29ya3Mgd2l0aCBQQ0kgZGV2aWNlcyBhbmQgZHJpdmVycyB0aGF0IGFzc3VtZSB0
aGF0Cj4gcG9ydCBudW1iZXJzIGFyZSBiZWxvdyAweGZmZmZmLCBhbmQgbWFrZXMgdGhlIFBDSSBw
b3J0IG51bWJlciBtYXRjaAo+IHRoZSBMaW51eCBwb3J0IG51bWJlci4KClBvc3NpYmx5IHJlbGF0
ZWQgaXMgdGhlIChoYXJtbGVzcykgd2FybmluZyBzcGV3IHNlZW4gZHVyaW5nIGJvb3Qgb24KRnJl
ZUJTRC4gVGhlIGJyaWRnZSwgYW5kIGFsbCBkb3duc3RyZWFtIG9uZXMsIHJlc2V0IHRvIGhhdmlu
ZyBJL08Kd2luZG93IDB4MC0weGZmZiBhbmQgbWVtb3J5L3ByZWZldGNoIHdpbmRvdyAweDAtMHhm
ZmZmZiAod2hpY2ggRnJlZUJTRAp0cmllcyB0byBhbGxvY2F0ZSwgZmFpbHMgYmVjYXVzZSB0aGF0
4oCZcyBvdXRzaWRlIHRoZSB2YWxpZCByYW5nZXMgYWJvdmUsCnNvIGl0IHRoZW4ganVzdCBwYXZl
cyBvdmVyIHdpdGggYSBzYW5lIGZyZXNoIGNvbmZpZykuIExpbnV4IHJlc2V0cyB0aGUKY29udHJv
bGxlciBvbiBwcm9iZSBzbyB0aGlzIGlzIHRoZSBpbml0aWFsIHN0YXRlIHdoZW4gZW51bWVyYXRp
bmcsIGFuZApwZXJoYXBzIHRoYXTigJlzIG5vdCBoYW5kbGVkIHNvIGdyYWNlZnVsbHkgYXMgb24g
RnJlZUJTRCAod2hpY2ggYWxzbwpyZXNldHMgaW4gZGV2aWNlX2F0dGFjaCwgdGhlIHNlY29uZCBo
YWxmIG9mIHdoYXQgTGludXggY2FsbHMgcHJvYmUpPwoKSmVzcwoKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51
eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxt
YW4vbGlzdGluZm8vbGludXgtdW0K

