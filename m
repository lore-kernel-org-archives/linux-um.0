Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1n04uK-00AvgT-2L
 for linux-um@lists.infradead.org; Wed, 22 Dec 2021 16:56:06 +0000
Date: Wed, 22 Dec 2021 17:55:59 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <689476797.194605.1640192159613.JavaMail.zimbra@nod.at>
In-Reply-To: <YcMuW88cOBNXAdb/@zn.tnic>
References: <20211215165612.554426-1-hch@lst.de>
 <1202521211.191037.1640120703350.JavaMail.zimbra@nod.at>
 <20211222081753.GB22041@lst.de> <YcMuW88cOBNXAdb/@zn.tnic>
Subject: Re: remove set_fs for UML
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
To: bp <bp@alien8.de>
Cc: hch <hch@lst.de>, anton ivanov <anton.ivanov@cambridgegreys.com>, x86 <x86@kernel.org>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>

Qm9yaXMsCgotLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4gVm9uOiAiYnAiIDxicEBh
bGllbjguZGU+Cj4gQW46ICJoY2giIDxoY2hAbHN0LmRlPgo+IENDOiAicmljaGFyZCIgPHJpY2hh
cmRAbm9kLmF0PiwgImFudG9uIGl2YW5vdiIgPGFudG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5j
b20+LCAieDg2IiA8eDg2QGtlcm5lbC5vcmc+LCAibGludXgtdW0iCj4gPGxpbnV4LXVtQGxpc3Rz
LmluZnJhZGVhZC5vcmc+LCAibGludXgta2VybmVsIiA8bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz4KPiBHZXNlbmRldDogTWl0dHdvY2gsIDIyLiBEZXplbWJlciAyMDIxIDE0OjU1OjM5Cj4g
QmV0cmVmZjogUmU6IHJlbW92ZSBzZXRfZnMgZm9yIFVNTAoKPiBPbiBXZWQsIERlYyAyMiwgMjAy
MSBhdCAwOToxNzo1M0FNICswMTAwLCBoY2ggd3JvdGU6Cj4+IE9uIFR1ZSwgRGVjIDIxLCAyMDIx
IGF0IDEwOjA1OjAzUE0gKzAxMDAsIFJpY2hhcmQgV2VpbmJlcmdlciB3cm90ZToKPj4gPiBTbyBm
YXIgVU1MIHNlZW1zIHRvIHdvcmsgd2l0aCB0aGVzZSBjaGFuZ2VzIGFwcGxpZWQuIDotKQo+PiA+
IEkgaGF2ZSBhcHBsaWVkIGJvdGggcGF0Y2hlcyB0byBteSBVTUwgdHJlZSBmb3Igbm93LCBJIGFz
c3VtZSB4ODYgbWFpbnRhaW5lcnMgYXJlCj4+ID4gZmluZSB3aXRoCj4+ID4gcGF0Y2ggMS8yPwo+
PiAKPj4gTG9va3MgbGlrZSBwYXRjaCAxIG5lZWRzIHRoaXMgZml4dXAgZm9yIHNvbWUgY29uZmln
dXJhdGlvbnMsIHdoZXJlCj4+IHBjaS5oIGRvZXNuJ3QgZ2V0IHB1bGxlZCBpbnRvIGt2bSBieSBv
dGhlciBtZWFucy4KPj4gCj4+IEJ1dCB3ZSBwcm9iYWJseSB3YW50IGFuIEFDSyBmcm9tIHRoZSB4
ODYgbWFpbnRhaW5lcnMgdG8gYmUgc3VyZSBhbnl3YXkuLgo+IAo+IEkgZG9uJ3Qgc2VlIHdoeSBu
b3Qgc28KPiAKPiBBY2tlZC1ieTogQm9yaXNsYXYgUGV0a292IDxicEBzdXNlLmRlPgo+IAo+IFNo
b3VsZCBJIHRha2UgdGhlIGZpcnN0IG9uZSBhbG9uZyB3aXRoIHRoaXMgaHVuayBiZWxvdz8KCldv
dWxkIGJlIGdyZWF0IQpXaGVuIEknbGwgZHJvcCAieDg2L210cnI6IHJlbW92ZSB0aGUgbXRycl9i
cF9pbml0IHN0dWIiIGZyb20gdGhlIFVNTCB0cmVlLgogClRoYW5rcywKLy9yaWNoYXJkCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWls
aW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFk
ZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

