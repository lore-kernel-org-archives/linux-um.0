Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-lj1-x233.google.com ([2a00:1450:4864:20::233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1lxuqb-008muE-Dv
 for linux-um@lists.infradead.org; Mon, 28 Jun 2021 17:15:02 +0000
Received: by mail-lj1-x233.google.com with SMTP id k8so26754341lja.4
 for <linux-um@lists.infradead.org>; Mon, 28 Jun 2021 10:14:59 -0700 (PDT)
MIME-Version: 1.0
References: <20210414055217.543246-1-avagin@gmail.com>
 <20210414055217.543246-3-avagin@gmail.com>
 <CAG48ez3UrzPE8rkucTgCu8ggcTEjx_h3Gj2FES1qM-uv2KD8bQ@mail.gmail.com>
 <f64f960b-d978-4022-9e56-0d9d9a3c0ebc@www.fastmail.com>
In-Reply-To: <f64f960b-d978-4022-9e56-0d9d9a3c0ebc@www.fastmail.com>
From: Jann Horn <jannh@google.com>
Date: Mon, 28 Jun 2021 19:14:31 +0200
Message-ID: <CAG48ez1d3abHEekh_fYoXdAe85RG+c--G7sEyMYhiKEsns3uog@mail.gmail.com>
Subject: Re: [PATCH 2/4] arch/x86: implement the process_vm_exec syscall
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
To: Andy Lutomirski <luto@kernel.org>
Cc: Andrei Vagin <avagin@gmail.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux API <linux-api@vger.kernel.org>, linux-um@lists.infradead.org, criu@openvz.org, avagin@google.com, Andrew Morton <akpm@linux-foundation.org>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, Christian Brauner <christian.brauner@ubuntu.com>, Dmitry Safonov <0x7f454c46@gmail.com>, Ingo Molnar <mingo@redhat.com>, Jeff Dike <jdike@addtoit.com>, Mike Rapoport <rppt@linux.ibm.com>, Michael Kerrisk <mtk.manpages@gmail.com>, Oleg Nesterov <oleg@redhat.com>, "Peter Zijlstra (Intel)" <peterz@infradead.org>, Richard Weinberger <richard@nod.at>, Thomas Gleixner <tglx@linutronix.de>

T24gTW9uLCBKdW4gMjgsIDIwMjEgYXQgNjozMCBQTSBBbmR5IEx1dG9taXJza2kgPGx1dG9Aa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4gT24gTW9uLCBKdW4gMjgsIDIwMjEsIGF0IDk6MTMgQU0sIEphbm4g
SG9ybiB3cm90ZToKPiA+IE9uIFdlZCwgQXByIDE0LCAyMDIxIGF0IDc6NTkgQU0gQW5kcmVpIFZh
Z2luIDxhdmFnaW5AZ21haWwuY29tPiB3cm90ZToKPiA+ID4gVGhpcyBjaGFuZ2UgaW50cm9kdWNl
cyB0aGUgbmV3IHN5c3RlbSBjYWxsOgo+ID4gPiBwcm9jZXNzX3ZtX2V4ZWMocGlkX3QgcGlkLCBz
dHJ1Y3Qgc2lnY29udGV4dCAqdWN0eCwgdW5zaWduZWQgbG9uZyBmbGFncywKPiA+ID4gICAgICAg
ICAgICAgICAgIHNpZ2luZm9fdCAqIHVpbmZvLCBzaWdzZXRfdCAqc2lnbWFzaywgc2l6ZV90IHNp
emVtYXNrKQo+ID4gPgo+ID4gPiBwcm9jZXNzX3ZtX2V4ZWMgYWxsb3dzIHRvIGV4ZWN1dGUgdGhl
IGN1cnJlbnQgcHJvY2VzcyBpbiBhbiBhZGRyZXNzCj4gPiA+IHNwYWNlIG9mIGFub3RoZXIgcHJv
Y2Vzcy4KPiA+IFsuLi5dCj4gPgo+ID4gSSBzdGlsbCB0aGluayB0aGF0IHRoaXMgd2hvbGUgQVBJ
IGlzIGZ1bmRhbWVudGFsbHkgdGhlIHdyb25nIGFwcHJvYWNoCj4gPiBiZWNhdXNlIGl0IHRyaWVz
IHRvIHNob2Vob3JuIG11bHRpcGxlIHVzZWNhc2VzIHdpdGggZGlmZmVyZW50Cj4gPiByZXF1aXJl
bWVudHMgaW50byBhIHNpbmdsZSBBUEkuIEJ1dCB0aGF0IGFzaWRlOgo+ID4KPiA+ID4gK3N0YXRp
YyB2b2lkIHN3YXBfbW0oc3RydWN0IG1tX3N0cnVjdCAqcHJldl9tbSwgc3RydWN0IG1tX3N0cnVj
dCAqdGFyZ2V0X21tKQo+ID4gPiArewo+ID4gPiArICAgICAgIHN0cnVjdCB0YXNrX3N0cnVjdCAq
dHNrID0gY3VycmVudDsKPiA+ID4gKyAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICphY3RpdmVfbW07
Cj4gPiA+ICsKPiA+ID4gKyAgICAgICB0YXNrX2xvY2sodHNrKTsKPiA+ID4gKyAgICAgICAvKiBI
b2xkIG9mZiB0bGIgZmx1c2ggSVBJcyB3aGlsZSBzd2l0Y2hpbmcgbW0ncyAqLwo+ID4gPiArICAg
ICAgIGxvY2FsX2lycV9kaXNhYmxlKCk7Cj4gPiA+ICsKPiA+ID4gKyAgICAgICBzeW5jX21tX3Jz
cyhwcmV2X21tKTsKPiA+ID4gKwo+ID4gPiArICAgICAgIHZtYWNhY2hlX2ZsdXNoKHRzayk7Cj4g
PiA+ICsKPiA+ID4gKyAgICAgICBhY3RpdmVfbW0gPSB0c2stPmFjdGl2ZV9tbTsKPiA+ID4gKyAg
ICAgICBpZiAoYWN0aXZlX21tICE9IHRhcmdldF9tbSkgewo+ID4gPiArICAgICAgICAgICAgICAg
bW1ncmFiKHRhcmdldF9tbSk7Cj4gPiA+ICsgICAgICAgICAgICAgICB0c2stPmFjdGl2ZV9tbSA9
IHRhcmdldF9tbTsKPiA+ID4gKyAgICAgICB9Cj4gPiA+ICsgICAgICAgdHNrLT5tbSA9IHRhcmdl
dF9tbTsKPiA+Cj4gPiBJJ20gcHJldHR5IHN1cmUgeW91J3JlIG5vdCBjdXJyZW50bHkgYWxsb3dl
ZCB0byBvdmVyd3JpdGUgdGhlIC0+bW0KPiA+IHBvaW50ZXIgb2YgYSB1c2Vyc3BhY2UgdGhyZWFk
LiBGb3IgZXhhbXBsZSwgemFwX3RocmVhZHMoKSBhc3N1bWVzIHRoYXQKPiA+IGFsbCB0aHJlYWRz
IHJ1bm5pbmcgdW5kZXIgYSBwcm9jZXNzIGhhdmUgdGhlIHNhbWUgLT5tbS4gKEFuZCBpZiB5b3Un
cmUKPiA+IGZpZGRsaW5nIHdpdGggLT5tbSBzdHVmZiwgeW91IHNob3VsZCBwcm9iYWJseSBDQyBs
aW51eC1tbUAuKQo+Cj4gZXhlY19tbWFwKCkgZG9lcyBpdCwgc28gaXQgY2Fu4oCZdCBiZSBlbnRp
cmVseSBpbXBvc3NpYmxlLgoKWWVhaCwgdHJ1ZSwgZXhlY3ZlIGNhbiBkbyBpdCAtIEkgZ3Vlc3Mg
dGhlIHRoaW5nIHRoYXQgbWFrZXMgdGhhdApzcGVjaWFsIGlzIHRoYXQgaXQncyBydW5uaW5nIGFm
dGVyIGRlX3RocmVhZCgpLCBzbyBpdCdzIGd1YXJhbnRlZWQgdG8KYmUgc2luZ2xlLXRocmVhZGVk
PwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgt
dW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3Rz
LmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC11bQo=

