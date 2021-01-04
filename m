Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwNso-0004Gk-5Y
 for linux-um@lists.infradead.org; Mon, 04 Jan 2021 11:18:43 +0000
Date: Mon, 4 Jan 2021 12:18:31 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1915321888.202504.1609759111591.JavaMail.zimbra@nod.at>
In-Reply-To: <8ea288a9-d482-3295-266b-d00cc315d2c5@collabora.com>
References: <20201221022434.21725-1-thehajime@gmail.com>
 <5f11-5fe1dd00-6d-1cae2c20@60061556>
 <CAFLxGvynAbtSLJweY6-oJ1egu1aSOAMPewsaz0VCrUMWazBZ4A@mail.gmail.com>
 <8ea288a9-d482-3295-266b-d00cc315d2c5@collabora.com>
Subject: Re: [PATCH] um: ubd: fix command line handling of ubd
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
To: Christopher Obbard <chris.obbard@collabora.com>
Cc: linux-um <linux-um@lists.infradead.org>, Hajime Tazaki <thehajime@gmail.com>

CgotLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4gVm9uOiAiQ2hyaXN0b3BoZXIgT2Ji
YXJkIiA8Y2hyaXMub2JiYXJkQGNvbGxhYm9yYS5jb20+Cj4gQW46ICJSaWNoYXJkIFdlaW5iZXJn
ZXIiIDxyaWNoYXJkLndlaW5iZXJnZXJAZ21haWwuY29tPiwgInJpY2hhcmQiIDxyaWNoYXJkQG5v
ZC5hdD4KPiBDQzogIkhhamltZSBUYXpha2kiIDx0aGVoYWppbWVAZ21haWwuY29tPiwgImxpbnV4
LXVtIiA8bGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZz4KPiBHZXNlbmRldDogTW9udGFnLCA0
LiBKYW51YXIgMjAyMSAxMTo1Njo1Mwo+IEJldHJlZmY6IFJlOiBbUEFUQ0hdIHVtOiB1YmQ6IGZp
eCBjb21tYW5kIGxpbmUgaGFuZGxpbmcgb2YgdWJkCgo+IEhpIFJpY2hhcmQsCj4gCj4gT24gMjMv
MTIvMjAyMCAxMDoxOSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+PiBPbiBUdWUsIERlYyAy
MiwgMjAyMCBhdCAxMjo0OSBQTSBDaHJpc3RvcGhlciBPYmJhcmQKPj4gPGNocmlzLm9iYmFyZEBj
b2xsYWJvcmEuY29tPiB3cm90ZToKPj4+Cj4+PiBIaSBIYWppbWUsCj4+Pgo+Pj4gRG9oISBUaGFu
a3MgZm9yIHNvcnRpbmcgb3V0IHRoaXMgcmVncmVzc2lvbiEKPj4+Cj4+PiBPbiBNb25kYXksIDIx
IERlY2VtYmVyLCAyMDIwIDAyOjI0IEdNVCwgSGFqaW1lIFRhemFraSA8dGhlaGFqaW1lQGdtYWls
LmNvbT4KPj4+IHdyb3RlOgo+Pj4+IFRoaXMgY29tbWl0IGZpeGVzIGEgcmVncmVzc2lvbiB0byBo
YW5kbGUgY29tbWFuZCBsaW5lIHBhcmFtZXRlcnMgb2YgdWJkLgo+Pj4+IFdpdGggYSBzaW1wbGUg
bGluZSAiLi9saW51eCB1YmQwPSIuL2Rpc2stZXh0NC5pbWciLCBpdCBmYWlscyBhdAo+Pj4+IHVi
ZF9zZXR1cF9jb21tb24oKS4gIFRoZSBjb21taXQgYWRkcyBhZGRpdGlvbmFsIGNoZWNrcyB0byB0
aGUgdmFyaWFibGVzCj4+Pj4gaW4gb3JkZXIgdG8gcHJvcGVybHkgcGFyc2UgdGhlIHBhcmVtZXRl
cnMgd2hpY2ggcHJldmlvdXNseSB3b3JrZWQuCj4+Pj4KPj4+PiBGaXhlczogZWYzYmE4N2NiN2M5
ICgidW06IHViZDogU2V0IGRldmljZSBzZXJpYWwgYXR0cmlidXRlIGZyb20KPj4+PiBjbWRsaW5l
IikKPj4+PiBDYzogQ2hyaXN0b3BoZXIgT2JiYXJkIDxjaHJpcy5vYmJhcmRAY29sbGFib3JhLmNv
bT4KPj4+PiBTaWduZWQtb2ZmLWJ5OiBIYWppbWUgVGF6YWtpIDx0aGVoYWppbWVAZ21haWwuY29t
Pgo+Pj4KPj4+IEFja2VkLWJ5OiBDaHJpc3RvcGhlciBPYmJhcmQgPGNocmlzLm9iYmFyZEBjb2xs
YWJvcmEuY29tPgo+PiAKPj4gQXBwbGllZCwgdGh4IQo+PiAKPiAKPiBIb3BlIHlvdSBkb24ndCBt
aW5kIHRoZSBleHRyYSBwb2tlIG1lc3NhZ2UgZnJvbSBtZSwgYnV0IGl0IGRpZG4ndCBzZWVtCj4g
bGlrZSB0aGlzIHBhdGNoIHdhcyBhcHBsaWVkIHRvIDUuMTEtcmMyICYgSSBjYW5ub3Qgc2VlIHRo
ZSBwYXRjaCB1bmRlcgo+IHlvdXIgdHJlZSBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9ydy91bWwuZ2l0LwoKSXQgaXMgaW4gbXkgcGF0Y2h3b3JrIGJ1bmRs
ZSBhbmQgbWFya2VkIGFzIGFjY2VwdGVkOgpodHRwczovL3BhdGNod29yay5vemxhYnMub3JnL2J1
bmRsZS9ydy91bWwtNS4xMS1yYzEtZml4ZXMvP3Nlcmllcz0mc3VibWl0dGVyPSZzdGF0ZT0qJnE9
JmFyY2hpdmU9CiAKWG1hcyBoYXBwZW5lZCBiZWZvcmUgSSBjb3VsZCBwdXNoIGl0IG91dCBhbmQg
ZG8gYSBQUi4KClRoYW5rcywKLy9yaWNoYXJkCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpsaW51eC11bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMu
aW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L2xpbnV4LXVtCg==

