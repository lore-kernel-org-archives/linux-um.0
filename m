Return-Path: <linux-um-bounces+geert=linux-m68k.org@lists.infradead.org>
Received: from ivanoab5.miniserver.com ([78.31.111.25]
 helo=www.kot-begemot.co.uk)
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1g5rhj-0001Fl-Ja
 for linux-um@lists.infradead.org; Fri, 28 Sep 2018 12:17:09 +0000
Subject: Re: Question about process.c
References: <e58ff1a0-df76-7213-08d5-1f796a6a3956@cambridgegreys.com>
 <1708862.d7yAjbcJLQ@blindfold>
 <40d875d4-8071-85e1-bad9-83995c9ebf8b@cambridgegreys.com>
 <4362422.B3hMBL5bEi@blindfold>
 <d5c5b0e3-2794-6599-744a-7ca9e87df56e@kot-begemot.co.uk>
 <CAFLxGvwGOv7gBTK35o6=2yjo1Ao5U0e0KSuqfONJ0YqubnugnQ@mail.gmail.com>
From: Anton Ivanov <anton.ivanov@kot-begemot.co.uk>
Message-ID: <186bd74d-7dc2-117a-6a6e-4886b9589e50@kot-begemot.co.uk>
Date: Fri, 28 Sep 2018 13:16:52 +0100
MIME-Version: 1.0
In-Reply-To: <CAFLxGvwGOv7gBTK35o6=2yjo1Ao5U0e0KSuqfONJ0YqubnugnQ@mail.gmail.com>
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
To: Richard Weinberger <richard.weinberger@gmail.com>
Cc: linux-um@lists.infradead.org

Ck9uIDUvMS8xOCAxMDozMyBQTSwgUmljaGFyZCBXZWluYmVyZ2VyIHdyb3RlOgo+IEFudG9uLAo+
Cj4gT24gVHVlLCBNYXkgMSwgMjAxOCBhdCA0OjQzIFBNLCBBbnRvbiBJdmFub3YKPiA8YW50b24u
aXZhbm92QGtvdC1iZWdlbW90LmNvLnVrPiB3cm90ZToKPj4gT0suCj4+Cj4+IEkgd2lsbCBwYXJr
IGl0IHVudGlsIEkgaGF2ZSBhIGxhcmdlIHRpbWVzbG90IHRvIHBsYXkgd2l0aCBpdCBhbmQgYW5h
bHl6ZQo+PiBpdCBwcm9wZXJseS4KPiBDYW4geW91IHBsZWFzZSB1c2UgcmVwbHktYWxsIGFuZCBu
b3QgdG9wLXBvc3Q/Cj4KPiBJIGRpZCBzb21lIHJlc2VhcmNoLgo+IFRoZSBmb3JjZSBmbHVzaCBo
YXMgaXRzIHJvb3RzIGluIHVtbC1wYXRjaC0yLjQuOS00LCBpbiBmb3JtIG9mCj4gZmx1c2hfdGxi
X2tlcm5lbF92bSgpLgo+IFdlIGhhdmUga2luZCBvZiBhIGNoYW5nZWxvZzoKPiBodHRwOi8vdXNl
ci1tb2RlLWxpbnV4LnNvdXJjZWZvcmdlLm5ldC9vbGQvY2hhbmdlbG9nLXVtbC1wYXRjaC0yLjQu
OS00LmJ6Mi5odG1sCj4gIkZpeGVkIHRoZSBwcm9jZXNzIHNlZ2ZhdWx0cyB0aGF0IGhhcHBlbmVk
IHdoZW4gdGhlIHN5c3RlbSB3YXMgc3dhcHBpbmciCj4KPiBJbiB1bWwtcGF0Y2gtMi40LjktOCBp
dCBnYWluZWQgZnVydGhlciBjaGFuZ2VzLgo+ICJGaXhlZCBhbmQgY2xlYW5lZCB1cCB0aGUgdGxi
IGZsdXNoIGNvZGUiLgo+Cj4gSSB0aGluayBpdCBpcyBoaWdoIG5vb24gdG8gcmV2aWV3L3JldGhp
bmsgdGhhdCBjb2RlLi4uCj4KSSBoYXZlIHJldmlld2VkIGFuZCByZXRlc3RlZCBpdC4gVW5mb3J0
dW5hdGVseSwgdGhlIG9yaWdpbmFsIGlzc3VlIGlzIApzdGlsbCB0aGVyZSBzbyB0aGUgdGxiIGhh
cyB0byBoYXZlIGEgZm9yY2UgZmx1c2ggaWYgc3dhcCBpcyBwcmVzZW50LgoKVGhhdCwgaG93ZXZl
ciwgbWVhbnMgdGhhdCB3ZSBjYW4gc3RpY2sgYW4KCiNpZmRlZiBDT05GSUdfU1dBUAojZGVmaW5l
IEZPUktfTU1fRk9SQ0UgMQojZWxpZgojZGVmaW5lIEZPUktfTU1fRk9SQ0UgMAojZW5kaWYKCklu
IHRoZSBiZWdpbm5pbmcgb2YgdGxiLmMuSWYgd2UgdGhlbiBtYWtlIHRoZSBmb3JjZV9mbHVzaCBj
b25kaXRpb25hbCBvbiAKU1dBUAoKdm9pZCBmb3JjZV9mbHVzaF9hbGwodm9pZCkKewogwqDCoMKg
IHN0cnVjdCBtbV9zdHJ1Y3QgKm1tID0gY3VycmVudC0+bW07CiDCoMKgwqAgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0ICp2bWEgPSBtbS0+bW1hcDsKCiDCoMKgwqAgd2hpbGUgKHZtYSAhPSBOVUxMKSB7
CiDCoMKgwqAgwqDCoMKgIGZpeF9yYW5nZShtbSwgdm1hLT52bV9zdGFydCwgdm1hLT52bV9lbmQs
IEZPUktfTU1fRk9SQ0UpOwogwqDCoMKgIMKgwqDCoCB2bWEgPSB2bWEtPnZtX25leHQ7CiDCoMKg
wqAgfQp9CgpXZSBnaXZlIDEwJSsgcGVyZm9ybWFuY2UgYm9vc3QgdG8gdGhvc2Ugd2hvIHdvdWxk
IHdhbnQgdG8gZm9yZ28gc3dhcC4KCkEuCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KbGludXgtdW0gbWFpbGluZyBsaXN0CmxpbnV4LXVtQGxpc3RzLmlu
ZnJhZGVhZC5vcmcKaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9s
aW51eC11bQo=

