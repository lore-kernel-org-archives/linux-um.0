Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kcbM7-0001g1-K5
 for linux-um@lists.infradead.org; Tue, 10 Nov 2020 21:39:12 +0000
Date: Tue, 10 Nov 2020 22:39:09 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1539736322.290788.1605044349917.JavaMail.zimbra@nod.at>
In-Reply-To: <de2e76d2-6adc-d9e9-7764-5d8ce22536bd@cambridgegreys.com>
References: <20201110163034.22963-1-anton.ivanov@cambridgegreys.com>
 <1098264641.290574.1605039225057.JavaMail.zimbra@nod.at>
 <ee2da9e0-2858-ef9c-b8b9-bdf569ec9bb4@cambridgegreys.com>
 <1253718433.290759.1605043793706.JavaMail.zimbra@nod.at>
 <de2e76d2-6adc-d9e9-7764-5d8ce22536bd@cambridgegreys.com>
Subject: Re: [PATCH] um: allow using glibc string functions instead of generics
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
To: anton ivanov <anton.ivanov@cambridgegreys.com>
Cc: linux-um <linux-um@lists.infradead.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQW46ICJyaWNoYXJkIiA8cmljaGFyZEBu
b2QuYXQ+Cj4gQ0M6ICJsaW51eC11bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+Cj4g
R2VzZW5kZXQ6IERpZW5zdGFnLCAxMC4gTm92ZW1iZXIgMjAyMCAyMjozMzo0OAo+IEJldHJlZmY6
IFJlOiBbUEFUQ0hdIHVtOiBhbGxvdyB1c2luZyBnbGliYyBzdHJpbmcgZnVuY3Rpb25zIGluc3Rl
YWQgb2YgZ2VuZXJpY3MKCj4gT24gMTAvMTEvMjAyMCAyMToyOSwgUmljaGFyZCBXZWluYmVyZ2Vy
IHdyb3RlOgo+PiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4+PiBWb246ICJhbnRv
biBpdmFub3YiIDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29tPgo+Pj4+IE9uIHdoYXQg
d29ya2xvYWQgZGlkIHlvdSBzZWUgc3VjaCBhIGh1Z2UgcGVyZm9ybWFuY2UgaW1wcm92ZW1lbnQ/
Cj4+PiBGaWxlIElPIH4gMSUgb3IgdGhlcmVhYm91dHMsIGlwZXJmIC0gMi00JS4KPj4+Cj4+Pj4g
VGhlIGluLWtlcm5lbCB2YXJpYW50cyBvZiBtZW1jcHkgYW5kIHN1Y2ggYXJlIGFscmVhZHkgd2Vs
bCBvcHRpbWl6ZWQuCj4+PiBVTUwgaGFzIG5vIHN0cmluZy5oIGluIGFzbSB3aGljaCBtZWFucyBp
dCBmYWxscyBiYWNrIHRvCj4+PiBhc20tZ2VuZXJpYy9zdHJpbmcuaCB3aGljaCBpbiB0dXJuIHB1
bGxzIGluIHRoZSBvbmVzIGZyb20gbGliL3N0cmluZy5jCj4+Pgo+Pj4gVGhlc2UgYXJlIG5vdCBv
cHRpbWl6ZWQuCj4+IEhtbW0sIEkgdGhpbmsgaXQgc2hvdWxkIHVzZSB0aGUgaGlnaGx5IG9wdGlt
aXplZCB2YXJpYW50cyBmcm9tIGFyY2gveDg2Lgo+IAo+IFRoYXQgaXMgdGhlIG90aGVyIG9wdGlv
biAtIHRvIGJyaW5nIGluIHN0cmluZzMyLmggYW5kIHN0cmluZzY0LmggZnJvbSB4ODYuCgpZZXMs
IEkgdGhvdWdodCB3ZSBkbyBzbyBhbHJlYWR5LiBJIGZlYXIgd2UgbGlzdCB0aGlzIGZlYXR1cmUg
YWZ0ZXIgc29tZSBjb2RlCmNsZWFudXAgYSBsb25nIHRpbWUgYWdvLgoKSSdtIGhhcHB5IHdpdGgg
ZWl0aGVyIG9wdGlvbi4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1A
bGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL2xpbnV4LXVtCg==

