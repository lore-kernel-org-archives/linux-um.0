Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1ieayV-0007JV-Bd
 for linux-um@lists.infradead.org; Tue, 10 Dec 2019 08:34:33 +0000
Date: Tue, 10 Dec 2019 09:34:28 +0100 (CET)
From: Richard Weinberger <richard@nod.at>
Message-ID: <392256369.112046.1575966868218.JavaMail.zimbra@nod.at>
In-Reply-To: <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
References: <20191209230248.227508-1-brendanhiggins@google.com>
 <1406826345.111805.1575933346955.JavaMail.zimbra@nod.at>
 <2eecf4dc-eb96-859a-a015-1a4f388b57a2@cambridgegreys.com>
 <346757c8-c111-f6cf-21d2-b0bffd41b8a8@cambridgegreys.com>
Subject: Re: [PATCH v1] uml: remove support for CONFIG_STATIC_LINK
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
Cc: Johannes Berg <johannes.berg@intel.com>, Brendan Higgins <brendanhiggins@google.com>, Jeff Dike <jdike@addtoit.com>, linux-um <linux-um@lists.infradead.org>, linux-kernel <linux-kernel@vger.kernel.org>, davidgow <davidgow@google.com>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4+IExJQkMgaXRzZWxmIHRyaWVzIHRvIGR5
bmFtaWMgbG9hZCBzdHVmZiBpbnRlcm5hbGx5Lgo+PiAKPj4gSXQgaXMgYmV5b25kIG91ciBjb250
cm9sIGFuZCBpdCBjbGFpbXMgdGhhdCBpdCB3aWxsIHdvcmsgb25seSBvbiBFWEFDVExZCj4+IHRo
ZSBzYW1lIHZlcnNpb24gb2YgbGliYyBsaWJyYXJ5IGFzIHRoZSBvbmUgdXNlZCBmb3Igc3RhdGlj
IGxpbmsuCj4+IAo+PiBTbyB5b3UgZ2V0IGEgbm90LWV4YWN0bHkgc3RhdGljIGJpbmFyeSB3aGlj
aCBpcyBub3QgcHJvcGVybHkgbW92ZWFibGUKPj4gYmV0d2VlbiBzeXN0ZW1zLgo+PiAKPj4gVGhp
cyBpcyBzcGVjaWZpY2FsbHkgaW4gdGhlIG5hbWUgcmVzb2x1dGlvbiwgZXRjIHBhcnRzIG9mIGxp
YmMgd2hpY2ggYWxsCj4+IG9mOiBwY2FwLCB2ZWN0b3IsIHZkZSwgZXRjIHJlbHkgb24uCj4+IAo+
PiBBbm90aGVyIGFsdGVybmF0aXZlIGlzIHRvIHR1cm4gb2ZmIHN0YXRpYyBzcGVjaWZpY2FsbHkg
Zm9yIHRob3NlLgo+PiAKPj4gRnVydGhlciB0byB0aGlzIC0gYW55IHByb3Blcmx5IHdyaXR0ZW4g
cGllY2Ugb2YgbmV0d29ya2luZyBjb2RlIHdoaWNoCj4+IHVzZXMgdGhlIG5ld2VyIGZ1bmN0aW9u
cyBmb3IgbmFtZS9zZXJ2aWNlIHJlc29sdXRpb24gd2lsbCBoYXZlIHRoZSBzYW1lCj4+IHByb2Js
ZW0uIFlvdSBjYW4gYmUgc3RhdGljIG9ubHkgaWYgeW91IGRvIGV2ZXJ5dGhpbmcgIm1hbnVhbGx5
IiB0aGUgb2xkCj4+IHdheS4KPiAKPiBUaGUgb2ZmZW5kaW5nIHBpZWNlIG9mIGNvZGUgaXMgdGhl
IGdsaWJjIGltcGxlbWVudGF0aW9uIG9mIGdldGFkZHJpbmZvKCkuCj4gCj4gSWYgeW91IHVzZSBp
dCBhbmQgbGluayBzdGF0aWMgdGhlIHJlc3VsdGluZyBiaW5hcnkgaXMgbm90IHJlYWxseSBzdGF0
aWMuCgpnbGliYyB0cmllcyB0byBsb2FkIE5TUyBhbmQgTklTIHN0dWZmLCB5ZXMuIEJ1dCB3aGF0
IGlzIHRoZSBwcm9ibGVtPwoKVGhlIGdvYWwgb2YgQ09ORklHX1NUQVRJQ19MSU5LIGlzIHRoYXQg
eW91IGNhbiBydW4gVU1MIHdpdGhvdXQgZGVwZW5kZW5jaWVzLAp0aGlzIHVzZWQgdG8gd29yayBz
aW5jZSBldmVyLiBMYXRlbHkgaXQgYnJva2UsIGJ1dCBoZXksIGxldCdzIGZpeCBpdC4KSSBoYXZl
IHRvbnMgb2Ygb2xkIHN0YXRpY2FsbHkgbGlua2VkIFVNTCBzeXN0ZW1zIG9uIG15IGRpc2sgd2hp
Y2ggSSBjYW4KanVzdCBydW4gYmVjYXVzZSB0aGV5IGRvbid0IGRlcGVuZCBvbiBzcGVjaWZpYyBs
aWJzLgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZy
YWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGlu
dXgtdW0K

