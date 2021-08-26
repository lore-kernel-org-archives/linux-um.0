Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab7.miniserver.com ([37.128.132.42]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mJMg3-00AuaZ-6W
 for linux-um@lists.infradead.org; Thu, 26 Aug 2021 21:12:51 +0000
Subject: Re: [PATCH, RFC] um: remove set_fs
References: <20210709133836.3821559-1-hch@lst.de>
 <b7b4f02385c2b103d66eadb1dfcff607a28a82b2.camel@sipsolutions.net>
 <20210823070426.GA22184@lst.de>
 <169368f3-1651-8b5c-d979-6ec9e060f6ca@cambridgegreys.com>
 <20210823121741.GA12605@lst.de>
 <e159919a-7401-580a-412c-1185701e7398@cambridgegreys.com>
 <1583675106.6324.1630005333356.JavaMail.zimbra@nod.at>
From: Anton Ivanov <anton.ivanov@cambridgegreys.com>
Message-ID: <50ef0553-6b9f-32b4-3ee9-20464c01d634@cambridgegreys.com>
Date: Thu, 26 Aug 2021 22:12:32 +0100
MIME-Version: 1.0
In-Reply-To: <1583675106.6324.1630005333356.JavaMail.zimbra@nod.at>
Content-Language: en-US
List-Id: <linux-um.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-um/>
List-Post: <mailto:linux-um@lists.infradead.org>
List-Help: <mailto:linux-um-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-um>,
 <mailto:linux-um-request@lists.infradead.org?subject=subscribe>
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Sender: "linux-um" <linux-um-bounces@lists.infradead.org>
Errors-To: linux-um-bounces+geert=linux-m68k.org@lists.infradead.org
To: Richard Weinberger <richard@nod.at>
Cc: hch <hch@lst.de>, Johannes Berg <johannes@sipsolutions.net>, linux-um <linux-um@lists.infradead.org>

T24gMjYvMDgvMjAyMSAyMDoxNSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IC0tLS0tIFVy
c3Byw7xuZ2xpY2hlIE1haWwgLS0tLS0KPj4+IEluIG90aGVyIHdvcmRzIC0gdmVyeSBsaXR0bGUg
Z2VuZXJhdGVkIGNvZGUgYWN0dWFsbHkgY2hhbmdlcyB3aXRoCj4+PiB0aGlzIHBhdGNoLCBleGNl
cHQgZm9yIHRoZSBjb250ZXh0IHN3aXRjaCBwYXRoLCB3aGljaCBnZXRzIHNpbXBsaWZpZWQuCj4+
Cj4+IEkgYW0gZ29pbmcgdG8gdGVzdCBpdCBhbmQgcGxheSB3aXRoIGl0IGxhdGVyLgo+IAo+IERp
ZCBpdCBzdXJ2aXZlIHlvdXIgdGVzdGluZz8KPiBUaGUgY2hhbmdlcyBsb29rIHNhbmUgdG8gbWUu
Cj4gCj4gVGhhbmtzLAo+IC8vcmljaGFyZAo+IAoKRG9lcyBub3QgY3Jhc2gsIGRvZXMgbm90IHNo
b3cgYW55IHN1YnN0YW50aWFsIGRpZmZlcmVuY2VzIGluIHBlcmZvcm1hbmNlLgoKSSBhbSBPSyB3
aXRoIGl0LgoKLS0gCkFudG9uIFIuIEl2YW5vdgpDYW1icmlkZ2VncmV5cyBMaW1pdGVkLiBSZWdp
c3RlcmVkIGluIEVuZ2xhbmQuIENvbXBhbnkgTnVtYmVyIDEwMjczNjYxCmh0dHBzOi8vd3d3LmNh
bWJyaWRnZWdyZXlzLmNvbS8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fCmxpbnV4LXVtIG1haWxpbmcgbGlzdApsaW51eC11bUBsaXN0cy5pbmZyYWRlYWQu
b3JnCmh0dHA6Ly9saXN0cy5pbmZyYWRlYWQub3JnL21haWxtYW4vbGlzdGluZm8vbGludXgtdW0K

