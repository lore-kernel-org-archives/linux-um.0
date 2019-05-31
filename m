Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pf1-x442.google.com ([2607:f8b0:4864:20::442])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1hWenl-0004zV-Rm
 for linux-um@lists.infradead.org; Fri, 31 May 2019 10:30:23 +0000
Received: by mail-pf1-x442.google.com with SMTP id x3so423928pff.11
 for <linux-um@lists.infradead.org>; Fri, 31 May 2019 03:30:20 -0700 (PDT)
References: <20190411094944.12245-1-brgl@bgdev.pl>
 <20190411094944.12245-5-brgl@bgdev.pl>
 <CAFLxGvwb8YzNiXCXru8Tw9pxH9qoc7gAO4sk0MXK1Xmp7fm-2g@mail.gmail.com>
 <0e8fbdf3-c40d-e4e8-6235-c744ec7317c3@cambridgegreys.com>
 <684874198.48863.1557299587958.JavaMail.zimbra@nod.at>
 <CAMRc=MdsA7A1DdS1ZJ8NS8xtuCjgc_7WZD1797H3oZ=2w+fOBA@mail.gmail.com>
 <CAMRc=McCxvwHgk-3wYE0e+qxJNoHK0AmpJWjNsOZBmGF2yFT6Q@mail.gmail.com>
 <c5918fa9-ec37-9636-5230-57260f7e8427@cambridgegreys.com>
 <CAMRc=MeOHr0bKJYGgOrhHq4dYFwCnpYvuFAL3jZerwCPvQgC3Q@mail.gmail.com>
From: Dana Johnson <djohns042@gmail.com>
Subject: Re: [RESEND PATCH 4/4] um: irq: don't set the chip for all irqs
Message-ID: <0aa6028b-7b7b-4123-07a3-786f700f3c14@gmail.com>
Date: Fri, 31 May 2019 03:30:16 -0700
MIME-Version: 1.0
In-Reply-To: <CAMRc=MeOHr0bKJYGgOrhHq4dYFwCnpYvuFAL3jZerwCPvQgC3Q@mail.gmail.com>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Reply-To: djohns042@gmail.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Bartosz Golaszewski <brgl@bgdev.pl>, Anton Ivanov <anton.ivanov@cambridgegreys.com>
Cc: Richard Weinberger <richard.weinberger@gmail.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, linux-um@lists.infradead.org, Bartosz Golaszewski <bgolaszewski@baylibre.com>

T24gNS8xMS8xOSA1OjQ4IEFNLCBCYXJ0b3N6IEdvbGFzemV3c2tpIHdyb3RlOgo+IHB0LiwgMTAg
bWFqIDIwMTkgbyAxODoyMiBBbnRvbiBJdmFub3YKPiA8YW50b24uaXZhbm92QGNhbWJyaWRnZWdy
ZXlzLmNvbT4gbmFwaXNhxYIoYSk6Cj4+Cj4+Cj4+IE9uIDEwLzA1LzIwMTkgMTc6MjAsIEJhcnRv
c3ogR29sYXN6ZXdza2kgd3JvdGU6Cj4+PiBwdC4sIDEwIG1haiAyMDE5IG8gMTE6MTYgQmFydG9z
eiBHb2xhc3pld3NraSA8YnJnbEBiZ2Rldi5wbD4gbmFwaXNhxYIoYSk6Cj4+Pj4gxZtyLiwgOCBt
YWogMjAxOSBvIDA5OjEzIFJpY2hhcmQgV2VpbmJlcmdlciA8cmljaGFyZEBub2QuYXQ+IG5hcGlz
YcWCKGEpOgo+Pj4+PiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4+Pj4+Pj4gQ2Fu
IHlvdSBwbGVhc2UgY2hlY2s/Cj4+Pj4+Pj4gVGhpcyBwYXRjaCBpcyBhbHJlYWR5IHF1ZXVlZCBp
biAtbmV4dC4gU28gd2UgbmVlZCB0byBkZWNpZGUgd2hldGhlciB0bwo+Pj4+Pj4+IHJldmVydCBv
ciBmaXggaXQgbm93Lgo+Pj4+Pj4+Cj4+Pj4+PiBJIGFtIGxvb2tpbmcgYXQgaXQuIEl0IHBhc3Nl
ZCB0ZXN0cyBpbiBteSBjYXNlIChJIGRpZCB0aGUgdXN1YWwgcm91bmQpLgo+Pj4+PiBJdCB3b3Jr
cyBoZXJlIHRvby4gVGhhdCdzIHdoeSBJIG5ldmVyIG5vdGljZWQuCj4+Pj4+IFllc3RlcmRheSBJ
IG5vdGljZWQganVzdCBiZWNhdXNlIEkgbG9va2VkIGZvciBzb21ldGhpbmcgZWxzZSBpbiB0aGUg
a2VybmVsIGxvZ3MuCj4+Pj4+Cj4+Pj4+IFRoYW5rcywKPj4+Pj4gLy9yaWNoYXJkCj4+Pj4gSGks
Cj4+Pj4KPj4+PiBzb3JyeSBmb3IgdGhlIGxhdGUgcmVwbHkgLSBJIGp1c3QgY2FtZSBiYWNrIGZy
b20gdmFjYXRpb24uCj4+Pj4KPj4+PiBJIHNlZSBpdCBoZXJlIHRvbywgSSdsbCBjaGVjayBpZiBJ
IGNhbiBmaW5kIHRoZSBjdWxwcml0IGFuZCBmaXggaXQgdG9kYXkuCj4+Pj4KPj4+PiBCYXJ0Cj4+
PiBIaSBSaWNoYXJkLCBBbnRvbiwKPj4+Cj4+PiBJJ20gbm90IHN1cmUgeWV0IHdoYXQgdGhpcyBp
cyBjYXVzZWQgYnkuIEl0IGRvZXNuJ3Qgc2VlbSB0byBicmVhawo+Pj4gYW55dGhpbmcgZm9yIG1l
IGJ1dCBzaW5jZSBpdCdzIGEgbmV3IGVycm9yIG1lc3NhZ2UgSSBndWVzcyBpdCdzIGJlc3QKPj4+
IHRvIHJldmVydCB0aGlzIHBhdGNoIChvdGhlcnMgYXJlIGdvb2QpIGFuZCByZXZpc2l0IGl0IGZv
ciB2NS4zLgo+Pgo+PiBDYW4geW91IHNlbmQgbWUgeW91ciBjb21tYW5kIGxpbmUgYW5kIC5jb25m
aWcgc28gSSBjYW4gdHJ5IHRvIHJlcHJvZHVjZSBpdC4KPj4KPiAKPiBTdXJlLAo+IAo+IHRoZSBj
b21tYW5kIGxpbmUgaXM6Cj4gCj4gLi9saW51eCByb290ZnN0eXBlPWhvc3RmcyByb290ZmxhZ3M9
PHBhdGggdG8gYSByZWd1bGFyIGJ1aWxkcm9vdAo+IHJvb3Rmcz4gcncgbWVtPTQ4TQo+IAo+IFRo
ZSBjb25maWcgaXMgdGhlIHJlZ3VsYXIgeDg2XzY0X2RlZmNvbmZpZyBmcm9tIGFyY2gvdW0uCj4g
Cj4gQmFydAo+IAogCkkgaGl0IHRoaXMgY29tcGlsaW5nIDUuMi4wLXJjMi0wMDAyNC1nYmVjNzU1
MGNjYTEwCgpJIGNhbiB0cmlnZ2VyOgoKVHJ5aW5nIHRvIHJlcmVnaXN0ZXIgSVJRIDExIEZEIDkg
VFlQRSAwIElEIChfX19fcHRydmFsX19fXykKd3JpdGVfc2lnaW9faXJxIDogdW1fcmVxdWVzdF9p
cnEgZmFpbGVkLCBlcnIgPSAtMTYKCmR1cmluZyBib290IHdoZW46CgojIENPTkZJR19VTUxfTkVU
X1ZFQ1RPUiBpcyBub3Qgc2V0CgpMb29raW5nIGF0IHRoZSBjb2RlIHRoZXJlIHNlZW1zIHRvIGJl
IGEgb25lIG9mZiBlcnJvcgppbiB0aGUgTEFTVF9JUlEgY2FsY3VsYXRpb24gd2hlbiBDT05GSUdf
VU1MX05FVF9WRUNUT1IgaXMgZW5hYmxlZC4KSW4gdGhhdCBjYXNlIHRoZSBwYXRjaCBzaG91bGQg
YmUgcmV2ZXJ0ZWQgYW5kIHRoZSBmb2xsb3dpbmcgYXBwbGllZDoKCgpkaWZmIC0tZ2l0IGEvYXJj
aC91bS9pbmNsdWRlL2FzbS9pcnEuaCBiL2FyY2gvdW0vaW5jbHVkZS9hc20vaXJxLmgKaW5kZXgg
NDllZDNlMzViMzVhLi5jZTdhNzhjM2JjZjIgMTAwNjQ0Ci0tLSBhL2FyY2gvdW0vaW5jbHVkZS9h
c20vaXJxLmgKKysrIGIvYXJjaC91bS9pbmNsdWRlL2FzbS9pcnEuaApAQCAtMjMsNyArMjMsNyBA
QAogI2RlZmluZSBWRUNUT1JfQkFTRV9JUlEgICAgICAgICAgICAgICAgMTUKICNkZWZpbmUgVkVD
VE9SX0lSUV9TUEFDRSAgICAgICA4CgotI2RlZmluZSBMQVNUX0lSUSAoVkVDVE9SX0lSUV9TUEFD
RSArIFZFQ1RPUl9CQVNFX0lSUSkKKyNkZWZpbmUgTEFTVF9JUlEgKFZFQ1RPUl9JUlFfU1BBQ0Ug
KyBWRUNUT1JfQkFTRV9JUlEgLSAxKQoKICNlbHNlCgpEYW5hCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgt
dW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL2xpbnV4LXVtCg==

