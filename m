Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from s3.sipsolutions.net ([2a01:4f8:191:4433::2]
 helo=sipsolutions.net)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mzmBx-008Vkk-Eu
 for linux-um@lists.infradead.org; Tue, 21 Dec 2021 20:57:02 +0000
Message-ID: <c48f86ad5d31f7f0cfa08d895bb03a4d92a3ce26.camel@sipsolutions.net>
Subject: Re: [PATCH 0/2] Devicetree support for UML
From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 21 Dec 2021 21:56:50 +0100
In-Reply-To: <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
References: <20211208151123.29313-1-vincent.whitchurch@axis.com>
 <342397676.191011.1640120120622.JavaMail.zimbra@nod.at>
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
To: Richard Weinberger <richard@nod.at>, Vincent Whitchurch <vincent.whitchurch@axis.com>
Cc: Jeff Dike <jdike@addtoit.com>, anton ivanov <anton.ivanov@cambridgegreys.com>, kernel@axis.com, linux-kernel <linux-kernel@vger.kernel.org>, linux-um <linux-um@lists.infradead.org>, devicetree <devicetree@vger.kernel.org>

T24gVHVlLCAyMDIxLTEyLTIxIGF0IDIxOjU1ICswMTAwLCBSaWNoYXJkIFdlaW5iZXJnZXIgd3Jv
dGU6Cj4gVmluY2VudCwKPiAKPiAtLS0tLSBVcnNwcsO8bmdsaWNoZSBNYWlsIC0tLS0tCj4gPiBW
b246ICJWaW5jZW50IFdoaXRjaHVyY2giIDx2aW5jZW50LndoaXRjaHVyY2hAYXhpcy5jb20+Cj4g
PiBBbjogIkplZmYgRGlrZSIgPGpkaWtlQGFkZHRvaXQuY29tPiwgInJpY2hhcmQiIDxyaWNoYXJk
QG5vZC5hdD4sICJhbnRvbiBpdmFub3YiIDxhbnRvbi5pdmFub3ZAY2FtYnJpZGdlZ3JleXMuY29t
Pgo+ID4gQ0M6IGtlcm5lbEBheGlzLmNvbSwgImxpbnV4LWtlcm5lbCIgPGxpbnV4LWtlcm5lbEB2
Z2VyLmtlcm5lbC5vcmc+LCAibGludXgtdW0iIDxsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3Jn
PiwKPiA+ICJkZXZpY2V0cmVlIiA8ZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc+LCAiVmluY2Vu
dCBXaGl0Y2h1cmNoIiA8dmluY2VudC53aGl0Y2h1cmNoQGF4aXMuY29tPgo+ID4gR2VzZW5kZXQ6
IE1pdHR3b2NoLCA4LiBEZXplbWJlciAyMDIxIDE2OjExOjIxCj4gPiBCZXRyZWZmOiBbUEFUQ0gg
MC8yXSBEZXZpY2V0cmVlIHN1cHBvcnQgZm9yIFVNTAo+IAo+ID4gVGhpcyBzZXJpZXMgYWRkIHN1
cHBvcnQgZm9yIHBhc3NpbmcgYSBkZXZpY2V0cmVlIGJsb2IgdG8gVU1MLiAgSXQgY2FuIGJlIHVz
ZWQKPiA+IGZvciB0ZXN0aW5nIGRldmljZSBkcml2ZXJzLgo+IAo+IE5pY2UgZmVhdHVyZS4KPiBD
b2RlIGxvb2tzIGdvb2Qgc28gZmFyLiBCdXQgd2hpbGUgYnVpbGRpbmcgSSdtIGZhY2luZyB0aGlz
IHdhcm5pbmc6Cj4gCj4gV0FSTklORzogdW5tZXQgZGlyZWN0IGRlcGVuZGVuY2llcyBkZXRlY3Rl
ZCBmb3IgT0ZfRUFSTFlfRkxBVFRSRUUKPiAgIERlcGVuZHMgb24gW25dOiBPRiBbPW5dCj4gICBT
ZWxlY3RlZCBieSBbeV06Cj4gICAtIFVNTCBbPXldCj4gCj4gCj4gUGxlYXNlIG5vdGUgdGhhdCBt
eSBVTUwgY29uZmlnIGhhcyBDT05GSUdfT0Y9bi4KPiAKCkhtLiBTbyBtYXliZSB0aGF0IG5lZWRz
IHRvIGJlCgoJc2VsZWN0IE9GX0VBUkxZX0ZMQVRUUkVFIGlmIE9GCgpvciBzbz8KCmpvaGFubmVz
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpsaW51eC11
bSBtYWlsaW5nIGxpc3QKbGludXgtdW1AbGlzdHMuaW5mcmFkZWFkLm9yZwpodHRwOi8vbGlzdHMu
aW5mcmFkZWFkLm9yZy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LXVtCg==

