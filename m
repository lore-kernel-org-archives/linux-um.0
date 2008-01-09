Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sc8-sf-mx1-b.sourceforge.net ([10.3.1.91]
	helo=mail.sourceforge.net)
	by sc8-sf-list1-new.sourceforge.net with esmtp (Exim 4.43)
	id 1JCiYd-0000NA-Ch for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 13:33:55 -0800
Received: from smtp6.pp.htv.fi ([213.243.153.40])
	by mail.sourceforge.net with esmtp (Exim 4.44) id 1JCiYY-0002Vk-Ra
	for user-mode-linux-devel@lists.sourceforge.net;
	Wed, 09 Jan 2008 13:33:55 -0800
Date: Wed, 9 Jan 2008 23:33:06 +0200
From: Adrian Bunk <bunk@kernel.org>
Message-ID: <20080109213305.GC4394@does.not.exist>
References: <E1JCi3M-0006hO-7i@pomaz-ex.szeredi.hu>
	<p734pdmput0.fsf@bingen.suse.de>
	<E1JCiLx-0006lI-HR@pomaz-ex.szeredi.hu>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <E1JCiLx-0006lI-HR@pomaz-ex.szeredi.hu>
Subject: Re: [uml-devel] uml and -regparm=3
List-Id: The user-mode Linux development list
	<user-mode-linux-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=user-mode-linux-devel>
List-Post: <mailto:user-mode-linux-devel@lists.sourceforge.net>
List-Help: <mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/user-mode-linux-devel>,
	<mailto:user-mode-linux-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Sender: user-mode-linux-devel-bounces@lists.sourceforge.net
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: user-mode-linux-devel@lists.sourceforge.net, jdike@addtoit.com, linux-kernel@vger.kernel.org, andi@firstfloor.org, akpm@linux-foundation.org, harvey.harrison@gmail.com

T24gV2VkLCBKYW4gMDksIDIwMDggYXQgMTA6MjA6NDlQTSArMDEwMCwgTWlrbG9zIFN6ZXJlZGkg
d3JvdGU6Cj4gPiBNaWtsb3MgU3plcmVkaSA8bWlrbG9zQHN6ZXJlZGkuaHU+IHdyaXRlczoKPiA+
IAo+ID4gPiBGQVNUQ0FMTCBpcyBkZWZpbmVkIGVtcHR5IGluIC1tbSwgYnV0IFVNTCBpcyBub3Qg
Y29tcGlsZWQgd2l0aAo+ID4gPiAtbXJlZ3Bhcm09MyBhbmQgc28gdGhpcyBicmVha3MgdGhpbmdz
IChJIG5vdGljZWQgcHJvYmxlbXMgd2l0aAo+ID4gPiByd3NlbV9kb3duX3dyaXRlX2ZhaWxlZCku
Cj4gPiA+Cj4gPiA+IFRyaWVkIHJlY29tcGlsaW5nIFVNTCB3aXRoIC1tcmVncGFybT0zLCBidXQg
dGhhdCByZXN1bHRlZCBpbiBhIHN0cmFuZ2UKPiA+ID4gZmFpbHVyZSBpbW1lZGlhdGVseSBhZnRl
ciBzdGFydHVwOgo+ID4gPgo+ID4gPiB8JUfDr8K/wr0lQDogSW52YWxpZCBhcmd1bWVudAo+ID4g
Pgo+ID4gPiBXaGF0J3MgdXA/Cj4gPiAKPiA+IFVNTCBsaW5rcyB3aXRoIGdsaWJjIGFuZCB0aGF0
IGRvZXMgbm90IHVzZSAtbXJlZ3Bhcm0uIAo+ID4gCj4gPiBZb3UgY2FuIG9ubHkgdXNlIC1tcmVn
cGFybSBpbiB1c2VyIHNwYWNlIGlmIHlvdSByZWNvbXBpbGUKPiA+IGFsbCBsaWJyYXJpZXMgdG9v
Lgo+IAo+IEFoLCByaWdodC4gIEkgZGlkbid0IHRoaW5rIG9mIHRoYXQuCj4gCj4gRG9lcyB0aGF0
IG1lYW4gdGhhdCBGQVNUQ0FMTCByZW1vdmFscyB3aWxsIGhhdmUgdG8gYmUgdW5kb25lPyAgT3Ig
aXMKPiB0aGVyZSBhbiBhbHRlcm5hdGl2ZT8KCkl0J3MgZW5vdWdoIHdoZW4gd2Uga2VlcCBmYXN0
Y2FsbC9GQVNUQ0FMTCBpbiB0aGUgZmV3IGNhc2VzIHdoZXJlIFVNTCAKY2FsbHMgYXNzZW1ibGVy
IGNvZGUgd2l0aCB0aGlzIGNhbGxpbmcgY29udmVudGlvbi4gWzFdCgo+IE1pa2xvcwoKY3UKQWRy
aWFuCgpbMV0gaHR0cDovL2xrbWwub3JnL2xrbWwvMjAwNy8xMi80LzQyNQoKLS0gCgogICAgICAg
IklzIHRoZXJlIG5vdCBwcm9taXNlIG9mIHJhaW4/IiBMaW5nIFRhbiBhc2tlZCBzdWRkZW5seSBv
dXQKICAgICAgICBvZiB0aGUgZGFya25lc3MuIFRoZXJlIGhhZCBiZWVuIG5lZWQgb2YgcmFpbiBm
b3IgbWFueSBkYXlzLgogICAgICAgIk9ubHkgYSBwcm9taXNlLCIgTGFvIEVyIHNhaWQuCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFBlYXJsIFMuIEJ1Y2sgLSBEcmFnb24g
U2VlZAoKCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KQ2hlY2sgb3V0IHRoZSBuZXcgU291cmNlRm9yZ2UubmV0
IE1hcmtldHBsYWNlLgpJdCdzIHRoZSBiZXN0IHBsYWNlIHRvIGJ1eSBvciBzZWxsIHNlcnZpY2Vz
IGZvcgpqdXN0IGFib3V0IGFueXRoaW5nIE9wZW4gU291cmNlLgpodHRwOi8vYWQuZG91YmxlY2xp
Y2submV0L2NsazsxNjQyMTYyMzk7MTM1MDMwMzg7dz9odHRwOi8vc2YubmV0L21hcmtldHBsYWNl
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClVzZXItbW9k
ZS1saW51eC1kZXZlbCBtYWlsaW5nIGxpc3QKVXNlci1tb2RlLWxpbnV4LWRldmVsQGxpc3RzLnNv
dXJjZWZvcmdlLm5ldApodHRwczovL2xpc3RzLnNvdXJjZWZvcmdlLm5ldC9saXN0cy9saXN0aW5m
by91c2VyLW1vZGUtbGludXgtZGV2ZWwK
