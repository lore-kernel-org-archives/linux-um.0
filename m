Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJBZF-0003Dp-2w
 for linux-um@lists.infradead.org; Tue, 31 Mar 2020 07:44:14 +0000
Message-ID: <19cf82d3c3d76ad62a47beee162fa9ff768a3a01.camel@sipsolutions.net>
Subject: Re: [PATCH] UML: add support for KASAN under x86_64
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 31 Mar 2020 09:43:59 +0200
In-Reply-To: <CABVgOSnz2heYvXytvhwA3RO_3dX=8vKrC+b8a6GLZV8eD3Fcow@mail.gmail.com>
 (sfid-20200331_081511_061239_730E62F6)
References: <20200226004608.8128-1-trishalfonso@google.com>
 <CAKFsvULd7w21T_nEn8QiofQGMovFBmi94dq2W_-DOjxf5oD-=w@mail.gmail.com>
 <4b8c1696f658b4c6c393956734d580593b55c4c0.camel@sipsolutions.net>
 <674ad16d7de34db7b562a08b971bdde179158902.camel@sipsolutions.net>
 <CACT4Y+bdxmRmr57JO_k0whhnT2BqcSA=Jwa5M6=9wdyOryv6Ug@mail.gmail.com>
 <ded22d68e623d2663c96a0e1c81d660b9da747bc.camel@sipsolutions.net>
 <CACT4Y+YzM5bwvJ=yryrz1_y=uh=NX+2PNu4pLFaqQ2BMS39Fdg@mail.gmail.com>
 <2cee72779294550a3ad143146283745b5cccb5fc.camel@sipsolutions.net>
 <CACT4Y+YhwJK+F7Y7NaNpAwwWR-yZMfNevNp_gcBoZ+uMJRgsSA@mail.gmail.com>
 <a51643dbff58e16cc91f33273dbc95dded57d3e6.camel@sipsolutions.net>
 <CABVgOSnz2heYvXytvhwA3RO_3dX=8vKrC+b8a6GLZV8eD3Fcow@mail.gmail.com>
 (sfid-20200331_081511_061239_730E62F6)
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
To: David Gow <davidgow@google.com>
Cc: Patricia Alfonso <trishalfonso@google.com>, Richard Weinberger <richard@nod.at>, Jeff Dike <jdike@addtoit.com>, Brendan Higgins <brendanhiggins@google.com>, LKML <linux-kernel@vger.kernel.org>, kasan-dev <kasan-dev@googlegroups.com>, linux-um <linux-um@lists.infradead.org>, Andrey Ryabinin <aryabinin@virtuozzo.com>, Dmitry Vyukov <dvyukov@google.com>, Anton Ivanov <anton.ivanov@cambridgegreys.com>

T24gTW9uLCAyMDIwLTAzLTMwIGF0IDIzOjE0IC0wNzAwLCBEYXZpZCBHb3cgd3JvdGU6Cj4gCj4g
SSBzcGVudCBhIGxpdHRsZSB0aW1lIHBsYXlpbmcgYXJvdW5kIHdpdGggdGhpcywgYW5kIHdhcyBh
YmxlIHRvIGdldAo+IG1hYzgwMjExIAoKbWFjODAyMTEsIG9yIG1hYzgwMjExLWh3c2ltPyBJIGNh
biBsb2FkIGEgZmV3IG1vZHVsZXMsIGJ1dCB0aGVuIGl0CmNyYXNoZXMgb24gc2F5IHRoZSB0aGly
ZCAodXN1YWxseSwgYnV0IHdobyBrbm93cyB3aGF0IHRoaXMgZGVwZW5kcyBvbikuCgo+IGxvYWRp
bmcgaWYgSSBmb3JjZS1lbmFibGVkIENPTkZJR19LQVNBTl9WTUFMTE9DIChhbG9uZ3NpZGUKPiBi
dW1waW5nIHVwIHRoZSBzaGFkb3cgbWVtb3J5IGFkZHJlc3MpLgoKTm90IHN1cmUgSSB0cmllZCB0
aGF0IGNvbWJpbmF0aW9uIHRob3VnaC4KCj4gVGhlIHRlc3QtYnBmIG1vZHVsZSB3YXMgc3RpbGwg
ZmFpbGluZywgdGhvdWdoIOKAlCB3aGljaCBtYXkgb3IgbWF5IG5vdAo+IGhhdmUgYmVlbiByZWxh
dGVkIHRvIGhvdyBicGYgdXNlcyB2bWFsbG9jKCkuCgpJIHRoaW5rIEkgZ290IHNvbWUgdHJvdWJs
ZSBhbHNvIHdpdGgganVzdCBzdGFjayB1bndpbmRpbmcgYW5kIG90aGVyCnJhbmRvbSB0aGluZ3Mg
ZmF1bHRpbmcgaW4gdGhlIHZtYWxsb2MgYW5kL29yIHNoYWRvdyBzcGFjZSAuLi4KCj4gSSBkbyBs
aWtlIHRoZSBpZGVhIG9mIHRyeWluZyB0byBwdXNoIHRoZSBzaGFkb3cgbWVtb3J5IGFsbG9jYXRp
b24KPiB0aHJvdWdoIFVNTCdzIFBURSBjb2RlLCBidXQgY29uZmVzcyB0byBub3QgdW5kZXJzdGFu
ZGluZyBpdAo+IHBhcnRpY3VsYXJseSB3ZWxsLiAKCk1lIG5laXRoZXIuIEkganVzdCBub3RpY2Vk
IHRoYXQgYWxsIHRoZSB2bWFsbG9jIGFuZCBrYXNhbi12bWFsbG9jIGRvIGFsbAp0aGUgUFRFIGhh
bmRsaW5nLCBzbyB0aGluZ3MgbWlnaHQgZWFzaWx5IGNsYXNoIGlmIHlvdSBoYXZlCkNPTkZJR19L
QVNBTl9WTUFMTE9DLCB3aGljaCB3ZSBkbyB3YW50IGV2ZW50dWFsbHkuCgo+IEkgaW1hZ2luZSBp
dCdkIHJlcXVpcmUgcHVzaGluZyB0aGUgS0FTQU4KPiBpbml0aWFsaXNhdGlvbiBiYWNrIHVudGls
IGFmdGVyIGluaXRfcGh5c21lbSwgYW5kIGhhdmluZyB0aGUgc2hhZG93Cj4gbWVtb3J5IGJlIGJh
Y2tlZCBieSB0aGUgcGh5c21lbSBmaWxlPyBVbmxlc3MgdGhlcmUncyBhIGNsZXZlciB3YXkgb2YK
PiBhbGxvY2F0aW5nIHRoZSBzaGFkb3cgbWVtb3J5IGVhcmx5LCBhbmQgdGhlbiBob29raW5nIGl0
IGludG8gdGhlIHBhZ2UKPiB0YWJsZXMvZXRjIHdoZW4gdGhvc2UgYXJlIGluaXRpYWxpc2VkIChh
a2luIHRvIGhvdyBvbiB4ODYgdGhlcmUncyBhCj4gc2VwYXJhdGUgZWFybHkgc2hhZG93IG1lbW9y
eSBzdGFnZSB3aGlsZSB0aGluZ3MgYXJlIHN0aWxsIGJlaW5nIHNldAo+IHVwLCBtYXliZT8pCgpQ
cmV0dHkgc3VyZSB3ZSBzaG91bGQgYmUgYWJsZSB0byBob29rIGl0IHVwIGxhdGVyLCBidXQgSSBo
YXZlbid0IHJlYWxseQpkdWcgZGVlcGx5IHlldC4KCmpvaGFubmVzCgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0Cmxp
bnV4LXVtQGxpc3RzLmluZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFp
bG1hbi9saXN0aW5mby9saW51eC11bQo=

