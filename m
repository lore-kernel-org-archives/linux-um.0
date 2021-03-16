Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lMHJ0-001uQD-VC
 for linux-um@lists.infradead.org; Tue, 16 Mar 2021 21:32:48 +0000
Message-ID: <56af0e44c846f4b079256ec997c56119964be402.camel@sipsolutions.net>
Subject: Re: [RFC v8 19/20] um: lkl: add block device support of UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 16 Mar 2021 22:32:45 +0100
In-Reply-To: <m25z1rc2ux.wl-thehajime@gmail.com>
 (sfid-20210316_021905_632656_6C735A12)
References: <cover.1611103406.git.thehajime@gmail.com>
 <b3b73864dbb738d0de7c49a6df5a5f53a358ec93.1611103406.git.thehajime@gmail.com>
 <2b649bc5165c7ff4547abd72f7e03e7491980138.camel@sipsolutions.net>
 <m25z1rc2ux.wl-thehajime@gmail.com> (sfid-20210316_021905_632656_6C735A12)
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
To: Hajime Tazaki <thehajime@gmail.com>
Cc: linux-um@lists.infradead.org, jdike@addtoit.com, richard@nod.at, anton.ivanov@cambridgegreys.com, tavi.purdila@gmail.com, linux-kernel-library@freelists.org, linux-arch@vger.kernel.org, retrage01@gmail.com

T24gVHVlLCAyMDIxLTAzLTE2IGF0IDEwOjE5ICswOTAwLCBIYWppbWUgVGF6YWtpIHdyb3RlOgo+
IAo+ID4gPiAtLS0gYS9hcmNoL3VtL0tjb25maWcKPiA+ID4gKysrIGIvYXJjaC91bS9LY29uZmln
Cj4gPiA+IEBAIC0yOSw2ICsyOSwxMCBAQCBjb25maWcgVU1NT0RFX0xJQgo+ID4gPiDCoAlzZWxl
Y3QgVUFDQ0VTU19NRU1DUFkKPiA+ID4gwqAJc2VsZWN0IEFSQ0hfVEhSRUFEX1NUQUNLX0FMTE9D
QVRPUgo+ID4gPiDCoAlzZWxlY3QgQVJDSF9IQVNfU1lTQ0FMTF9XUkFQUEVSCj4gPiA+ICsJc2Vs
ZWN0IFZGQVRfRlMKPiA+ID4gKwlzZWxlY3QgTkxTX0NPREVQQUdFXzQzNwo+ID4gPiArCXNlbGVj
dCBOTFNfSVNPODg1OV8xCj4gPiA+ICsJc2VsZWN0IEJUUkZTX0ZTCj4gPiAKPiA+IFRoYXQgZG9l
c24ndCByZWFsbHkgc2VlbSB0byBtYWtlIHNlbnNlIC0gdGhlIHNhbXBsZSBtaWdodCBuZWVkIGl0
LCBidXQKPiA+IGdlbmVyYWxseSBMS0wgZG9lc24ndC9zaG91bGRuJ3Q/Cj4gCj4gSSdtIHRyeWlu
ZyB0byB1bmRlcnN0YW5kIHlvdXIgY29tbWVudDsKPiBEbyB5b3UgbWVhbiB0aGF0IGVuYWJsaW5n
IHRob3NlIG9wdGlvbnMgaW4gS2NvbmZpZyBkb2Vzbid0IG1ha2Ugc2Vuc2UgPwoKSSBtZWFuICph
bHdheXMqIGVuYWJsaW5nIHRoZW0gZG9lc24ndCBtYWtlIHNlbnNlLiBXaHkgc2hvdWxkbid0IHNv
bWVib2R5CmJlIGFsbG93ZWQgdG8gYnVpbGQgVU1NT0RFX0xJQiAqd2l0aG91dCogYnRyZnM/IElm
IHRoZXkgaGF2ZSBubyBuZWVkIGZvcgpidHJmcywgd2h5IHNob3VsZCBpdCBzZWxlY3QgaXQ/CgpJ
IGNhbiB1bmRlcnN0YW5kIHRoYXQgeW91ciBzYW1wbGUgY29kZSB3YW50cyBidHJmcyBqdXN0IHRv
IHNob3cgd2hhdCBpdApjYW4gZG8sIGJ1dCBJTUhPIGl0IGRvZXNuJ3QgbWFrZSBzZW5zZSB0byAq
YWx3YXlzKiBlbmFibGUgaXQuCgo+IGFuZCBpZiB5b3UgbWVhbiB0aGUgc2FtcGxlIGFzIHNhbXBs
ZSBjb2RlLCBpcyB0aGUgYWRkZWQgdGVzdCBjYXNlCj4gKGUuZy4sIHRvb2xzL3Rlc3Rpbmcvc2Vs
ZnRlc3RzL3VtL2Rpc2suYywgd2hpY2ggaXMgaW5jbHVkZWQgaW4gdGhlCj4gc2FtZSBwYXRjaCkg
Zm9yIHRoaXMgcHVycG9zZSA/Cgp5ZXMsIHRoYXQncyB3aGF0IEkgbWVhbiBieSAic2FtcGxlIGNv
ZGUiCgpqb2Fobm5lcwoKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
Cmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

