Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lg60t-008kin-W5
 for linux-um@lists.infradead.org; Mon, 10 May 2021 13:32:01 +0000
Received: by mail-pj1-x102d.google.com with SMTP id md17so9765737pjb.0
 for <linux-um@lists.infradead.org>; Mon, 10 May 2021 06:31:57 -0700 (PDT)
Date: Mon, 10 May 2021 21:31:50 +0800
From: "lambertdev@gmail.com" <lambertdev@gmail.com>
Subject: Re: Re: [PATCH v2] init/gcov: allow CONFIG_CONSTRUCTORS on UML to fix
 module gcov
References: <e386f13f8496330cd42e93c6d48a25b9a57a6792.camel@sipsolutions.net>, 
 <20210120172041.c246a2cac2fb.I1358f584b76f1898373adfed77f4462c8705b736@changeid>,
 <ee3bc3bf-9582-d278-5b7a-d9fa27b17800@linux.ibm.com>, 
 <tencent_99073B61C8137C88B76C231139F94EFB3805@qq.com>, 
 <2a46ca787df9a44c8b4fbc17ab6b69247ab38400.camel@sipsolutions.net>
Mime-Version: 1.0
Message-ID: <2021051021314677744820@gmail.com>
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
To: Johannes Berg <johannes@sipsolutions.net>, Peter Oberparleiter <oberpar@linux.ibm.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>, Arnd Bergmann <arnd@arndb.de>, Jessica Yu <jeyu@kernel.org>, linux-um <linux-um@lists.infradead.org>

SGkgSm9oYW5uZXMsCgpNeSBvcmlnaW5hbCBFbWFpbCBhZGRyZXNzIGlzIGJsb2NrZWQgYnkgdGhl
IHNlcnZlciBvZiBrZXJuZWwub3JnLCAKc28gSSBoYXZlIHRvIGNoYW5nZSBhbiBFbWFpbCBhZGRy
ZXNzLiBQbGVhc2Ugc2VlIG15IHJlcGx5IGlubGluZS4KCj5IaSwKCgo+CgoKCj4+IEhpIEpvaGFu
bmVzIGFuZCBQZXRlciwgc29ycnkgdG8gYm90aGVyIGJ1dCBJIGhhdmUgb25lIHF1ZXN0aW9uIAoK
Cgo+PiBvbiB0aGlzIGNoYW5nZS4gVGhlIGRvX2N0b3JzKCkgd29u4oCZdCBiZSBleGVjdXRlZCBm
b3IgVU1MIAoKCgo+PiBiZWNhdXNlwqAgKnRoZSBjb25zdHJ1Y3RvcnMgaGF2ZSBhbHJlYWR5IGJl
ZW4gY2FsbGVkIGZvciBFTEYqLiAKCgoKPj4gCgoKCj4+ICpfX2N0b3JzX3N0YXJ0KsKgIGFuZMKg
ICpfX2N0b3JzX2VuZCogc3ltYm9scy4gU2VlIGxpbms6CgoKCj4+IGh0dHBzOi8vZWxpeGlyLmJv
b3RsaW4uY29tL2xpbnV4L3Y1LjEyLjIvc291cmNlL2luY2x1ZGUvYXNtLWdlbmVyaWMvdm1saW51
eC5sZHMuaCNMNjc2CgoKCj4+IAoKCgo+PiBJbiBteSBlbnZpcm9ubWVudCwgVU1MK0dDQyAxMCwg
SSBjYW4ndCBmaW5kIF9fZ2Nvdl9pbml0IGV4ZWN1dGVkIAoKCgo+PiBiZWZvcmUga2VybmVsIHN0
YXJ0cy4gU28gSSBkaWQgc29tZSB0cmFjZSBhbmQgZm91bmQgZ2xpYmMKCgoKPj4gX19saWJjX2Nz
dV9pbml0IAoKCgo+PiB3aWxsIG9ubHkgZXhlY3V0ZSBjb25zdHJ1Y3RvcnMgYmV0d2VlbiAqX19p
bml0X2FycmF5X3N0YXJ0KmFuZAoKCgo+PiAqX19pbml0X2FycmF5X2VuZCouwqAgCgoKCj4+IFdo
aWNoIG1lYW5zIGlmIGRvX2N0b3JzKCkgaXMgbm90IGV4ZWN1dGVkIGZvciBVTUwsIG5vIGVsc2V3
aGVyZSB3aWxsIAoKCgo+PiB0aGUgY29uc3RydWN0b3JzIGJlIGV4ZWN1dGVkLgoKCgo+PiAKCgoK
Pj4gU2hhbGwgd2UgcmVtb3ZlIHRoZSAqIWRlZmluZWQoQ09ORklHX1VNTCkqIGZvciBHQ0MsIG9y
IEkganVzdCBtaXNzZWQgCgoKCj4+IHNvbWUgc3RlcHMgdG8gbWFrZSB0aGUgR0NPViB3b3JrIGZv
ciBVTUw/IAoKCgo+CgoKCj5ObywgdGhhdCBkb2Vzbid0IHNlZW0gbGlrZSB0aGUgcmlnaHQgc29s
dXRpb24uCgoKPgoKCgo+UGVyaGFwcyB0aGVuIHdpdGggdGhhdCB0b29sY2hhaW4gKG9yIGNvbmZp
Z3VyYXRpb24gdGhlcmVvZikgd2UgbmVlZCB0bwoKCgo+cHJvdmlkZSBfX2luaXRfYXJyYXlfc3Rh
cnQvZW5kIGxhYmVscz8KCgpZZXMsIHRoYXQncyBob3cgSSB3b3JrZWQgYXJvdW5kICBpbiBteSBs
b2NhbCBlbnZpcm9ubWVudCAKKGNoYW5nZSBsaW5rZXIgc2NyaXB0IHRvIGFkZCBfaW5pdF9hcnJh
eV9zdGFydC9lbmQgbGFiZWxzKS4KU28gdGhlIF9fZ2Nvdl9pbml0IGlzIGNhbGxlZCBiZWZvcmUg
c3RhcnRfa2VybmVsLgoKCj4KCgoKPk9yIC4uLiBtYXliZSB0aGF0IGFjdHVhbGx5IGp1c3QgbmVl
ZHMgdG8gYmUgcmVtb3ZlZCwgc28gdGhhdCB0aGUKCgoKPnRvb2xjaGFpbiBnZXRzIHRvIGNob29z
ZT8KCgoKPgoKCgo+SG1tLiBQcmV0dHkgc3VyZSBpdCB3b3JrZWQgZm9yIG1lLCBJIHRoaW5rIGFs
c28gd2l0aCBnY2MgMTAsIGJ1dCBub3QKCgoKPnN1cmUgZXhhY3RseSB3aGVyZSBJIHRlc3RlZC4K
CgpJIHdpbGwgbWFrZSBzdXJlIG15IGVudmlyb25tZW50IGlzIGNsZWFuIGFuZCB0cnkgYWdhaW4u
IApDb3VsZCB5b3UgcGxlYXNlIHVzZSBnZGIgdG8gY2hlY2sgd2hlbiBfX2djb3ZfaW5pdCBpcyBj
YWxsZWQgaW4geW91ciBzZXR1cD8KZS5nLgooMSkgZ2RiICp5b3VyIHVtbCBlbGYqIAooMikgYiBf
X2djb3ZfaW5pdAooMykgcgooNCkgd2hlbiB0aGUgZXhlY3V0aW9uIGlzIGJyZWFrZWQsIHVzZSAn
YnQnIHRvIGNoZWNrIHRoZSBjYWxsIHN0YWNrClRoYW5rcwoKTGFtYmVydAoKPgoKCgo+am9oYW5u
ZXMKCgoKPgoKCgo+CgoKCj4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVt
Cg==

