Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x443.google.com ([2607:f8b0:4864:20::443])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1idOmb-0003Xn-Hr
 for linux-um@lists.infradead.org; Sat, 07 Dec 2019 01:21:19 +0000
Received: by mail-pf1-x443.google.com with SMTP id d199so4229023pfd.11
 for <linux-um@lists.infradead.org>; Fri, 06 Dec 2019 17:21:14 -0800 (PST)
Date: Fri, 6 Dec 2019 17:21:08 -0800
From: Brendan Higgins <brendanhiggins@google.com>
Subject: Re: [RFC v1 1/2] um: drivers: remove support for UML_NET_PCAP
Message-ID: <20191207012108.GA220741@google.com>
References: <20191206020153.228283-1-brendanhiggins@google.com>
 <20191206020153.228283-2-brendanhiggins@google.com>
 <f217945d-ab64-10cc-bb12-3a4d810ff25a@cambridgegreys.com>
 <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CAFd5g45cSKATfw4GKPw6QdhQKDNi=0gcDRjQ7N0T1XrdtSTPrg@mail.gmail.com>
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
To: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: johannes.berg@intel.com, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, David Gow <davidgow@google.com>

T24gRnJpLCBEZWMgMDYsIDIwMTkgYXQgMDQ6MzI6MzRQTSAtMDgwMCwgQnJlbmRhbiBIaWdnaW5z
IHdyb3RlOgo+IE9uIFRodSwgRGVjIDUsIDIwMTkgYXQgMTE6MjMgUE0gQW50b24gSXZhbm92Cj4g
PGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+IHdyb3RlOgo+IFsuLi5dCj4gPiAxLiBU
aGVyZSBpcyBhIHByb3Bvc2VkIHBhdGNoIGZvciB0aGUgYnVpbGQgc3lzdGVtIHRvIGZpeCBpdC4K
ClNvIEkganVzdCB0cmllZCB0aGUgcGF0Y2ggeW91IGxpbmtlZCBvbiB0aGUgY292ZXIgbGV0dGVy
WzFdLCBhbmQgSSBhbQpzdGlsbCBnZXR0aW5nIHRoZSBidWlsZCBlcnJvciBkZXNjcmliZWQgYWJv
dmU6CgphcmNoL3VtL2RyaXZlcnMvcGNhcF91c2VyLmM6MzU6MTI6IGVycm9yOiBjb25mbGljdGlu
ZyB0eXBlcyBmb3Ig4oCYcGNhcF9vcGVu4oCZCiBzdGF0aWMgaW50IHBjYXBfb3Blbih2b2lkICpk
YXRhKQogICAgICAgICAgICBefn5+fn5+fn4KSW4gZmlsZSBpbmNsdWRlZCBmcm9tIC91c3IvaW5j
bHVkZS9wY2FwLmg6NDMsCiAgICAgICAgICAgICAgICAgZnJvbSBhcmNoL3VtL2RyaXZlcnMvcGNh
cF91c2VyLmM6NzoKL3Vzci9pbmNsdWRlL3BjYXAvcGNhcC5oOjg1OToxODogbm90ZTogcHJldmlv
dXMgZGVjbGFyYXRpb24gb2Yg4oCYcGNhcF9vcGVu4oCZIHdhcyBoZXJlCiBQQ0FQX0FQSSBwY2Fw
X3QgKnBjYXBfb3Blbihjb25zdCBjaGFyICpzb3VyY2UsIGludCBzbmFwbGVuLCBpbnQgZmxhZ3Ms
CgpMb29raW5nIGF0IHRoZSBwYXRjaCwgSSB3b3VsZG4ndCBleHBlY3QgaXQgdG8gc29sdmUgdGhp
cyBwcm9ibGVtLgoKQXJlIHRoZXJlIG1heWJlIGRpZmZlcmVudCBjb25mbGljdGluZyBsaWJwY2Fw
LWRldiBsaWJyYXJpZXMgYW5kIEkgaGF2ZQp0aGUgd3Jvbmcgb25lPyBPciBpcyB0aGlzIGp1c3Qg
c3RpbGwgYnJva2VuPwoKPiA+IDIuIFdlIHNob3VsZCBiZSByZW1vdmluZyBhbGwgb2xkIGRyaXZl
cnMgYW5kIHJlcGxhY2luZyB0aGVtIHdpdGggdGhlCj4gPiB2ZWN0b3Igb25lcy4KPiAKPiBIbW0u
Li5kb2VzIHRoaXMgbWVhbiB5b3Ugd291bGQgZW50ZXJ0YWluIGEgcGF0Y2ggcmVtb3ZpbmcgYWxs
IHRoZQo+IG5vbi12ZWN0b3IgVU1MIG5ldHdvcmsgZHJpdmVycz8gSSB3b3VsZCBiZSBoYXBweSB0
byBzZWUgVkRFIGdvIGFzCj4gd2VsbC4KPiAKPiBJbiBhbnkgZXZlbnQsIGl0IHNvdW5kcyBsaWtl
IEkgc2hvdWxkIHByb2JhYmx5IGRyb3AgdGhpcyBwYXRjaCBhcyBpdAo+IGlzIGN1cnJlbnRseS4K
PiAKPiBUaGFua3MhCgpbMV0gaHR0cHM6Ly9idWdzLmRlYmlhbi5vcmcvY2dpLWJpbi9idWdyZXBv
cnQuY2dpP2J1Zz05Mzg5NjIjNzkKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRl
YWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgt
dW0K

