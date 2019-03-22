Return-Path: <linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org>
Subject: Re: [PATCH v5 1/3] locking/rwsem: Remove arch specific rwsem files
References: <20190322143008.21313-1-longman@redhat.com>
 <20190322143008.21313-2-longman@redhat.com>
 <CAHk-=wikkO-1f1=FEOEzkSnaDg3yJLP=4Vd59UCuLBztFd0KOw@mail.gmail.com>
 <20190322193010.azb7rmmmaclhal35@linux-r8p5>
From: Waiman Long <longman@redhat.com>
Message-ID: <45315aa9-f006-c4ca-705f-71d6c2650508@redhat.com>
Date: Fri, 22 Mar 2019 16:27:26 -0400
MIME-Version: 1.0
In-Reply-To: <20190322193010.azb7rmmmaclhal35@linux-r8p5>
Content-Language: en-US
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+geert.uytterhoeven=gmail.com@lists.infradead.org
To: Davidlohr Bueso <dave@stgolabs.net>, Linus Torvalds <torvalds@linux-foundation.org>
Cc: linux-ia64@vger.kernel.org, Linux-sh list <linux-sh@vger.kernel.org>, Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>, linux-mips@vger.kernel.org, "H. Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org, linux-riscv@lists.infradead.org, linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, linux-c6x-dev@linux-c6x.org, linux-hexagon@vger.kernel.org, the arch/x86 maintainers <x86@kernel.org>, Ingo Molnar <mingo@redhat.com>, uclinux-h8-devel@lists.sourceforge.jp, linux-xtensa@linux-xtensa.org, Arnd Bergmann <arnd@arndb.de>, linux-um@lists.infradead.org, linux-m68k <linux-m68k@lists.linux-m68k.org>, openrisc@lists.librecores.org, Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>, "linux-alpha@vger.kernel.org" <linux-arm-kernel@lists.infradead.org>, linux-parisc@vger.kernel.org, Tim Chen <tim.c.chen@linux.intel.com>, Linux List Kernel Mailing <linux-kernel@vger.kernel.org>, "linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>, nios2-dev@lists.rocketboards.org, Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-um.lists.infradead.org>

T24gMDMvMjIvMjAxOSAwMzozMCBQTSwgRGF2aWRsb2hyIEJ1ZXNvIHdyb3RlOgo+IE9uIEZyaSwg
MjIgTWFyIDIwMTksIExpbnVzIFRvcnZhbGRzIHdyb3RlOgo+PiBTb21lIG9mIHRoZW0gX21pZ2h0
XyBiZSBwZXJmb3JtYW5jZS1jcml0aWNhbC4gVGhlcmUncyB0aGUgb25lIG9uCj4+IG1tYXBfc2Vt
IGluIHRoZSBmYXVsdCBoYW5kbGluZyBwYXRoLCBmb3IgZXhhbXBsZS4gQW5kIHllcywgSSdkIGV4
cGVjdAo+PiB0aGUgbm9ybWFsIGNhc2UgdG8gdmVyeSBtdWNoIGJlICJubyBvdGhlciByZWFkZXJz
IG9yIHdyaXRlcnMiIGZvciB0aGF0Cj4+IG9uZS4KPgo+IFllYWgsIHRoZSBtbWFwX3NlbSBjYXNl
IGluIHRoZSBmYXVsdCBwYXRoIGlzIHJlYWxseSBleHBlY3RpbmcgYW4gdW5sb2NrZWQKPiBzdGF0
ZS4gVG8gdGhlIHBvaW50IHRoYXQgZm91ciBhcmNocyBoYXZlIGFkZGVkIGJyYW5jaCBwcmVkaWN0
aW9ucywgaWU6Cj4KPiA5MjE4MWYxOTBiNiAoeDg2OiBvcHRpbWlzZSB4ODYncyBkb19wYWdlX2Zh
dWx0IChDIGVudHJ5IHBvaW50IGZvciB0aGUKPiBwYWdlIGZhdWx0IHBhdGgpKQo+IGIxNTAyMWQ5
OTRmIChwb3dlcnBjL21tOiBBZGQgYSBidW5jaCBvZiAodW4pbGlrZWx5IGFubm90YXRpb25zIHRv
Cj4gZG9fcGFnZV9mYXVsdCkKPgo+IEFuZCB1c2luZyBQUk9GSUxFX0FOTk9UQVRFRF9CUkFOQ0hF
UyBzaG93cyBwcmV0dHkgY2xlYXJseToKPiAod2l0aG91dCByZXNldHRpbmcgdGhlIGNvdW50ZXJz
KQo+Cj4gY29ycmVjdCBpbmNvcnJlY3TCoCAlwqDCoMKgwqDCoMKgwqAgRnVuY3Rpb27CoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoCBGaWxlwqDCoMKgwqDCoMKgwqDCoMKgIExpbmUKPiAtLS0tLS0t
IC0tLS0tLS0tLcKgIC3CoMKgwqDCoMKgwqDCoCAtLS0tLS0tLcKgwqDCoMKgwqDCoMKgwqDCoMKg
wqDCoMKgIC0tLS3CoMKgwqDCoMKgwqDCoMKgwqAgLS0tLQo+IMKgNDYwMzY4NcKgwqDCoMKgwqDC
oCAzNMKgwqAgMCBkb191c2VyX2FkZHJfZmF1bHTCoMKgwqDCoMKgwqDCoMKgIGZhdWx0LmPCoMKg
wqDCoMKgwqDCoMKgwqAgMTQxNgo+IChib290dXApCj4gMzgyMzI3NzQ1wqDCoMKgwqDCoCA0NDnC
oMKgIDAgZG9fdXNlcl9hZGRyX2ZhdWx0wqDCoMKgwqDCoMKgwqDCoCBmYXVsdC5jwqDCoMKgwqDC
oMKgwqDCoMKgCj4gMTQxNiAoa2VybmVsIGJ1aWxkKQo+IDM5OTQ0NjE1OcKgwqDCoMKgwqAgNDYx
wqDCoCAwIGRvX3VzZXJfYWRkcl9mYXVsdMKgwqDCoMKgwqDCoMKgwqAgZmF1bHQuY8KgwqDCoMKg
wqDCoMKgwqDCoAo+IDE0MTYgKHJlZGlzIGJlbmNobWFyaykKPgo+IEl0IHdvdWxkIHByb2JhYmx5
IHdvdWxkbid0IGhhcm0gZG9pbmcgdGhlIHVubGlrZWx5KCkgZm9yIGFsbCBhcmNocywgb3IKPiBh
bHRlcm5hdGl2ZWx5LCBhZGQgbGlrZWx5KCkgdG8gdGhlIGF0b21pY19sb25nX3RyeV9jbXB4Y2hn
X2FjcXVpcmUgaW4KPiBwYXRjaCAzIGFuZCBkbyBpdCBpbXBsaWNpdGx5IGJ1dCBtYXliZSB0aGF0
IHdvdWxkIGJlIGxlc3MgZmxleGlibGUoPykKPgo+IFRoYW5rcywKPiBEYXZpZGxvaHIKCkkgaGFk
IHVzZWQgdGhlIG15IGxvY2sgZXZlbnQgY291bnRpbmcgY29kZSB0byBjb3VudCB0aGUgbnVtYmVy
IG9mCmNvbnRlbmRlZCBhbmQgdW5jb250ZW5kZWQgdHJ5bG9ja3MuIEkgdGVzdGVkIGJvdGggYm9v
dHVwIGFuZCBrZXJuZWwKYnVpbGQuIEkgdGhpbmsgSSBzYXcgbGVzcyB0aGFuIDElIHdlcmUgY29u
dGVuZGVkLCB0aGUgcmVzdHMgd2VyZSBhbGwKdW5jb250ZW5kZWQuIFRoYXQgaXMgc2ltaWxhciB0
byB3aGF0IHlvdSBnb3QuIEkgdGhvdWdodCBJIGhhZCBzZW50IHRoZQpkYXRhIG91dCBwcmV2aW91
c2x5LCBidXQgSSBjb3VsZG4ndCBmaW5kIHRoZSBlbWFpbC4gVGhhdCB3YXMgdGhlIG1haW4KcmVh
c29uIHdoeSBJIHRvb2sgTGludXMnIHN1Z2dlc3Rpb24gdG8gb3B0aW1pemUgaXQgZm9yIHRoZSB1
bmNvbnRlbmRlZCBjYXNlLgoKVGhhbmtzLApMb25nbWFuCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC1hcm0ta2VybmVsIG1haWxpbmcgbGlzdAps
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVh
ZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1hcm0ta2VybmVsCg==

