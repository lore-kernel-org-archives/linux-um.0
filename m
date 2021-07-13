Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m3QfY-00BRa3-4F
 for linux-um@lists.infradead.org; Tue, 13 Jul 2021 22:14:26 +0000
Date: Wed, 14 Jul 2021 00:14:20 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <756593647.23483.1626214460129.JavaMail.zimbra@nod.at>
In-Reply-To: <CABqSeARhjVWwX3YnaUZtvn1-8a6c46oxCj6BnpDirVMP9jjEgA@mail.gmail.com>
References: <a6188b0422c2a8fe1b5e9f164bfa1796@codeaurora.org>
 <675205198.21885.1626185036367.JavaMail.zimbra@nod.at>
 <5a30a105b004c98186883182e7e4f56a@codeaurora.org>
 <66cdf3de4a10308be633b1dc40567857c55df9aa.camel@sipsolutions.net>
 <5a402bd444a2c9926f9b3945beb4b5a2@codeaurora.org>
 <f6a53d9531996a10d29aaae16ecda60afd290769.camel@sipsolutions.net>
 <ca337f4b5e3e60fc0701be00f6546f2e@codeaurora.org>
 <CABqSeARhjVWwX3YnaUZtvn1-8a6c46oxCj6BnpDirVMP9jjEgA@mail.gmail.com>
Subject: Re: UML kernel panic on initialization
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
To: YiFei Zhu <zhuyifei1999@gmail.com>
Cc: subashab <subashab@codeaurora.org>, Johannes Berg <johannes@sipsolutions.net>, anton ivanov <anton.ivanov@cambridgegreys.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, stranche <stranche@codeaurora.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogIllpRmVpIFpodSIgPHpodXlp
ZmVpMTk5OUBnbWFpbC5jb20+Cj4gQW46ICJzdWJhc2hhYiIgPHN1YmFzaGFiQGNvZGVhdXJvcmEu
b3JnPgo+IENDOiAiSm9oYW5uZXMgQmVyZyIgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+LCAi
cmljaGFyZCIgPHJpY2hhcmRAbm9kLmF0PiwgImFudG9uIGl2YW5vdiIKPiA8YW50b24uaXZhbm92
QGNhbWJyaWRnZWdyZXlzLmNvbT4sICJKZWZmIERpa2UiIDxqZGlrZUBhZGR0b2l0LmNvbT4sICJs
aW51eC11bSIgPGxpbnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmc+LAo+ICJzdHJhbmNoZSIgPHN0
cmFuY2hlQGNvZGVhdXJvcmEub3JnPgo+IEdlc2VuZGV0OiBEaWVuc3RhZywgMTMuIEp1bGkgMjAy
MSAyMjo1Mjo0Mwo+IEJldHJlZmY6IFJlOiBVTUwga2VybmVsIHBhbmljIG9uIGluaXRpYWxpemF0
aW9uCgo+IE9uIFR1ZSwgSnVsIDEzLCAyMDIxIGF0IDM6MDAgUE0gPHN1YmFzaGFiQGNvZGVhdXJv
cmEub3JnPiB3cm90ZToKPj4KPj4gPiBXYXNuJ3QgY29tcGF0aWJsZSB3aXRoIG15IHN5c3RlbSAu
Li4gY2FuIHlvdSBkZXNjcmliZSB0aGUgaG9zdCBzeXN0ZW0/Cj4+ID4KPj4gPiBqb2hhbm5lcwo+
Pgo+PiBJdHMgYW4gSW50ZWwgOHRoIGdlbiBpNyB3aXRoIFVidW50dSAxNi4wNCBMVFMuCj4+IEtl
cm5lbCB2ZXJzaW9uIGlzIDQuMTUuMC03MC1nZW5lcmljLgo+PiBnY2MgdmVyc2lvbiBpcyA1LjQu
Cj4gCj4gRldJVywgZm9yIG1lLCBjb21waWxpbmcgVU1MIHdpdGggZGVmY29uZmlnIGluc2lkZSBh
IFVidW50dSAxNi4wNAo+IGRvY2tlciBpcyBlbm91Z2ggdG8gcHJvZHVjZSBhIGJpbmFyeSB0aGF0
IGNvdWxkIHRyaWdnZXIgYSBjcmFzaCBldmVuCj4gb3V0c2lkZSBkb2NrZXIsIHVzaW5nIGhvc3Rm
cyByb290IG1vdW50IChzbyBubyBzcGVjaWFsIGxkLnNvKS4KPiAKPiBUaGlzIGlzIHNvbWUgc29y
dCBvZiBjb21waWxlciBkaWZmZXJlbmNlLgoKRXhhY3RseS4gOi0pClBsZWFzZSBzZWUgSm9oYW5u
ZXMnIHBhdGNoOgpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9waXBlcm1haWwvbGludXgtdW0v
MjAyMS1KdWx5LzAwMTU3MS5odG1sCgpUaGFua3MsCi8vcmljaGFyZAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0Cmxp
bnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC11bQo=

