Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lWeVo-007kKH-0H
 for linux-um@lists.infradead.org; Wed, 14 Apr 2021 12:20:53 +0000
From: Florian Weimer <fweimer@redhat.com>
Subject: Re: [PATCH 0/4 POC] Allow executing code and syscalls in another
 address space
References: <20210414055217.543246-1-avagin@gmail.com>
 <87blahb1pr.fsf@oldenburg.str.redhat.com>
 <CAG48ez2z0a4x2GfHv9L0HmO1-uzsKtfOF40erPb8ADR-m+itbg@mail.gmail.com>
Date: Wed, 14 Apr 2021 14:20:48 +0200
In-Reply-To: <CAG48ez2z0a4x2GfHv9L0HmO1-uzsKtfOF40erPb8ADR-m+itbg@mail.gmail.com>
 (Jann Horn's message of "Wed, 14 Apr 2021 13:24:30 +0200")
Message-ID: <874kg99hwf.fsf@oldenburg.str.redhat.com>
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
To: Jann Horn <jannh@google.com>
Cc: Andrei Vagin <avagin@gmail.com>, kernel list <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-um@lists.infradead.org, criu@openvz.org, Andrei Vagin <avagin@google.com>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, Peter Zijlstra <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

KiBKYW5uIEhvcm46Cgo+IE9uIFdlZCwgQXByIDE0LCAyMDIxIGF0IDEyOjI3IFBNIEZsb3JpYW4g
V2VpbWVyIDxmd2VpbWVyQHJlZGhhdC5jb20+IHdyb3RlOgo+Pgo+PiAqIEFuZHJlaSBWYWdpbjoK
Pj4KPj4gPiBXZSBhbHJlYWR5IGhhdmUgcHJvY2Vzc192bV9yZWFkdiBhbmQgcHJvY2Vzc192bV93
cml0ZXYgdG8gcmVhZCBhbmQgd3JpdGUKPj4gPiB0byBhIHByb2Nlc3MgbWVtb3J5IGZhc3RlciB0
aGFuIHdlIGNhbiBkbyB0aGlzIHdpdGggcHRyYWNlLiBBbmQgbm93IGl0Cj4+ID4gaXMgdGltZSBm
b3IgcHJvY2Vzc192bV9leGVjIHRoYXQgYWxsb3dzIGV4ZWN1dGluZyBjb2RlIGluIGFuIGFkZHJl
c3MKPj4gPiBzcGFjZSBvZiBhbm90aGVyIHByb2Nlc3MuIFdlIGNhbiBkbyB0aGlzIHdpdGggcHRy
YWNlIGJ1dCBpdCBpcyBtdWNoCj4+ID4gc2xvd2VyLgo+PiA+Cj4+ID4gPSBVc2UtY2FzZXMgPQo+
Pgo+PiBXZSBhbHNvIGhhdmUgc29tZSB2YWd1ZWx5IHJlbGF0ZWQgd2l0aGluIHRoZSBzYW1lIGFk
ZHJlc3Mgc3BhY2U6IHJ1bm5pbmcKPj4gY29kZSBvbiBhbm90aGVyIHRocmVhZCwgd2l0aG91dCBt
b2RpZnlpbmcgaXRzIHN0YWNrLCB3aGlsZSBpdCBoYXMgc2lnbmFsCj4+IGhhbmRsZXJzIGJsb2Nr
ZWQsIGFuZCB3aXRob3V0IGNhdXNpbmcgc3lzdGVtIGNhbGxzIHRvIGZhaWwgd2l0aCBFSU5UUi4K
Pj4gVGhpcyBjYW4gYmUgdXNlZCB0byBpbXBsZW1lbnQgY2VydGFpbiBraW5kcyBvZiBtZW1vcnkg
YmFycmllcnMuCj4KPiBUaGF0J3Mgd2hhdCB0aGUgbWVtYmFycmllcigpIHN5c2NhbGwgaXMgZm9y
LCByaWdodD8gVW5sZXNzIHlvdSBkb24ndAo+IHdhbnQgdG8gcmVnaXN0ZXIgYWxsIHRocmVhZHMg
Zm9yIGV4cGVkaXRlZCBtZW1iYXJyaWVyIHVzZT8KCm1lbWJhcnJpZXIgaXMgbm90IHN1ZmZpY2ll
bnRseSBwb3dlcmZ1bCBmb3IgcmV2b2tpbmcgYmlhc2VkIGxvY2tzLCBmb3IKZXhhbXBsZS4KCkZv
ciB0aGUgRUlOVFIgaXNzdWUsIDxodHRwczovL2dpdGh1Yi5jb20vZ29sYW5nL2dvL2lzc3Vlcy8z
ODgzNj4gaXMgYW4KZXhhbXBsZS4gIEkgYmVsaWV2ZSBDSUZTIGhhcyBzaW5jZSBzZWVuIGEgZmV3
IGZpeGVzIChhZnRlciBzb21lb25lCnJlcG9ydGVkIHRoYXQgdGFyIG9uIENJRlMgd291bGRuJ3Qg
d29yayBiZWNhdXNlIHRoZSBTSUdDSExEIGNhdXNpbmcKdXRpbWVuc2F0IHRvIGZhaWzigJRhbmQg
dGhlcmUgaXNuJ3QgZXZlbiBhIHNpZ25hbCBoYW5kbGVyIGZvciBTSUdDSExEISksCmJ1dCB0aGUg
dGltZSBpdCB0b29rIHRvIGdldCB0byB0aGlzIHBvaW50IGRvZXNuJ3QgZ2l2ZSBtZSBjb25maWRl
bmNlCnRoYXQgaXQgaXMgc2FmZSB0byBzZW5kIHNpZ25hbHMgdG8gYSB0aHJlYWQgdGhhdCBpcyBy
dW5uaW5nIHVua25vd24KY29kZS4KCkJ1dCBhcyB5b3UgZXhwbGFpbmVkIHJlZ2FyZGluZyB0aGUg
c2V0KmlkIGJyb2FkY2FzdCwgaXQgc2VlbXMgdGhhdCBpZiB3ZQpoYWQgdGhpcyBydW4tb24tYW5v
dGhlci10aHJlYWQgZnVuY3Rpb25hbGl0eSwgd2Ugd291bGQgbGlrZWx5IGVuY291bnRlcgppc3N1
ZXMgc2ltaWxhciB0byB0aG9zZSB3aXRoIFNBX1JFU1RBUlQuICBXZSBkb24ndCBzZWUgdGhlIGlz
c3VlIHdpdGgKc2V0KmlkIHRvZGF5IGJlY2F1c2UgaXQncyBhIHJhcmUgb3BlcmF0aW9uLCBhbmQg
bXVsdGktdGhyZWFkZWQgZmlsZQpzZXJ2ZXJzIHRoYXQgbmVlZCB0byBjaGFuZ2UgY3JlZGVudGlh
bHMgZnJlcXVlbnRseSBvcHQgb3V0IG9mIHRoZSBzZXQqaWQKYnJvYWRjYXN0IGFueXdheS4gIChX
aGF0IEkgaGF2ZSBpbiBtaW5kIGlzIGEgZnV0dXJlIHdvcmxkIHdoZXJlIGFueQpwcmludGYgY2Fs
bCwgYW55IG1hbGxvYyBjYWxsLCBjYW4gdHJpZ2dlciBzdWNoIGEgYnJvYWRjYXN0LikKClRoZSBj
cm9zcy1WTSBDUklVIHNjZW5hcmlvIHdvdWxkIHByb2JhYmx5IHNvbWV3aGVyZSBpbiBiZXR3ZWVu
IChub3QKcXVpdGUgdGhlIHByaW50Zi9tYWxsb2MgbGV2ZWwsIGJ1dCBtb3JlIGZyZXF1ZW50IHRo
YW4gc2V0KmlkKS4KClRoYW5rcywKRmxvcmlhbgoKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0
cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGlu
Zm8vbGludXgtdW0K

