Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from lithops.sigma-star.at ([195.201.40.130])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJNU0-00AzKN-0j
 for linux-um@lists.infradead.org; Thu, 26 Aug 2021 22:04:25 +0000
Date: Fri, 27 Aug 2021 00:04:20 +0200 (CEST)
From: Richard Weinberger <richard@nod.at>
Message-ID: <1948049684.7020.1630015460699.JavaMail.zimbra@nod.at>
In-Reply-To: <50ef0553-6b9f-32b4-3ee9-20464c01d634@cambridgegreys.com>
References: <20210709133836.3821559-1-hch@lst.de>
 <b7b4f02385c2b103d66eadb1dfcff607a28a82b2.camel@sipsolutions.net>
 <20210823070426.GA22184@lst.de>
 <169368f3-1651-8b5c-d979-6ec9e060f6ca@cambridgegreys.com>
 <20210823121741.GA12605@lst.de>
 <e159919a-7401-580a-412c-1185701e7398@cambridgegreys.com>
 <1583675106.6324.1630005333356.JavaMail.zimbra@nod.at>
 <50ef0553-6b9f-32b4-3ee9-20464c01d634@cambridgegreys.com>
Subject: Re: [PATCH, RFC] um: remove set_fs
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
Cc: hch <hch@lst.de>, Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>

LS0tLS0gVXJzcHLDvG5nbGljaGUgTWFpbCAtLS0tLQo+IFZvbjogImFudG9uIGl2YW5vdiIgPGFu
dG9uLml2YW5vdkBjYW1icmlkZ2VncmV5cy5jb20+Cj4gQW46ICJyaWNoYXJkIiA8cmljaGFyZEBu
b2QuYXQ+Cj4gQ0M6ICJoY2giIDxoY2hAbHN0LmRlPiwgIkpvaGFubmVzIEJlcmciIDxqb2hhbm5l
c0BzaXBzb2x1dGlvbnMubmV0PiwgImxpbnV4LXVtIiA8bGludXgtdW1AbGlzdHMuaW5mcmFkZWFk
Lm9yZz4KPiBHZXNlbmRldDogRG9ubmVyc3RhZywgMjYuIEF1Z3VzdCAyMDIxIDIzOjEyOjMyCj4g
QmV0cmVmZjogUmU6IFtQQVRDSCwgUkZDXSB1bTogcmVtb3ZlIHNldF9mcwoKPiBPbiAyNi8wOC8y
MDIxIDIwOjE1LCBSaWNoYXJkIFdlaW5iZXJnZXIgd3JvdGU6Cj4+IC0tLS0tIFVyc3Byw7xuZ2xp
Y2hlIE1haWwgLS0tLS0KPj4+PiBJbiBvdGhlciB3b3JkcyAtIHZlcnkgbGl0dGxlIGdlbmVyYXRl
ZCBjb2RlIGFjdHVhbGx5IGNoYW5nZXMgd2l0aAo+Pj4+IHRoaXMgcGF0Y2gsIGV4Y2VwdCBmb3Ig
dGhlIGNvbnRleHQgc3dpdGNoIHBhdGgsIHdoaWNoIGdldHMgc2ltcGxpZmllZC4KPj4+Cj4+PiBJ
IGFtIGdvaW5nIHRvIHRlc3QgaXQgYW5kIHBsYXkgd2l0aCBpdCBsYXRlci4KPj4gCj4+IERpZCBp
dCBzdXJ2aXZlIHlvdXIgdGVzdGluZz8KPj4gVGhlIGNoYW5nZXMgbG9vayBzYW5lIHRvIG1lLgo+
PiAKPj4gVGhhbmtzLAo+PiAvL3JpY2hhcmQKPj4gCj4gCj4gRG9lcyBub3QgY3Jhc2gsIGRvZXMg
bm90IHNob3cgYW55IHN1YnN0YW50aWFsIGRpZmZlcmVuY2VzIGluIHBlcmZvcm1hbmNlLgoKU291
bmRzIGxpa2UgYSBkZWNlbnQgcGF0Y2guIDotKQogCj4gSSBhbSBPSyB3aXRoIGl0LgoKU28sIGxl
dCdzIGJlIGtlZW4gYW5kIG1lcmdlIGl0LgoKVGhhbmtzLAovL3JpY2hhcmQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlz
dApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQub3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3Jn
L21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

