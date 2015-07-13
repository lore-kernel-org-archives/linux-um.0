Return-Path: <user-mode-linux-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-1.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <richard.weinberger@gmail.com>) id 1ZEeAJ-0003S7-7X
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 13:53:03 +0000
Received: from mail-oi0-f47.google.com ([209.85.218.47])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1ZEeAH-0004qh-DB
	for user-mode-linux-devel@lists.sourceforge.net;
	Mon, 13 Jul 2015 13:53:03 +0000
Received: by oihq81 with SMTP id q81so40620099oih.2
	for <user-mode-linux-devel@lists.sourceforge.net>;
	Mon, 13 Jul 2015 06:52:56 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1436794918.3306.5.camel@m3y3r.de>
References: <1436794918.3306.5.camel@m3y3r.de>
Date: Mon, 13 Jul 2015 15:52:55 +0200
Message-ID: <CAFLxGvwo2hjvrkF_ChR1Ooc6o7OqEGEOKnP=4NAmt8vP07Kd-Q@mail.gmail.com>
From: Richard Weinberger <richard.weinberger@gmail.com>
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
Errors-To: user-mode-linux-devel-bounces@lists.sourceforge.net
Subject: Re: [uml-devel] uml_net zombie processes
To: Thomas Meyer <thomas@m3y3r.de>
Cc: "user-mode-linux-devel@lists.sourceforge.net" <user-mode-linux-devel@lists.sourceforge.net>

T24gTW9uLCBKdWwgMTMsIDIwMTUgYXQgMzo0MSBQTSwgVGhvbWFzIE1leWVyIDx0aG9tYXNAbTN5
M3IuZGU+IHdyb3RlOgo+IEhpLAo+Cj4gVGhlIHVtbF9uZXQgbmV0d29yayBzZXR1cCAiZmFpbHMi
IG9uIG15IGNvbXB1dGVyIHdpdGg6Cj4KPiBbICAgMTUuOTMwMDAwXSBoZWxwZXJfd2FpdCA6IHdh
aXRwaWQgcHJvY2VzcyAxMTY3MyBmYWlsZWQsIGVycm5vID0gMTAKPiBbICAgMTUuOTMwMDAwXSAq
IG1vZHByb2JlIHR1bgo+ICAgICAgICAgICAgICAgICogaWZjb25maWcgdGFwMCAxOTIuMTY4LjEw
LjEgbmV0bWFzayAyNTUuMjU1LjI1NS4yNTUgdXAKPiAgICAgICAgICAgICAgICAqIGJhc2ggLWMg
ZWNobyAxID4gL3Byb2Mvc3lzL25ldC9pcHY0L2lwX2ZvcndhcmQKPiBbICAgMjAuNDgwMDAwXSBo
ZWxwZXJfd2FpdCA6IHdhaXRwaWQgcHJvY2VzcyAxMTc4MCBmYWlsZWQsIGVycm5vID0gMTAKPiBb
ICAgMjAuNDgwMDAwXSAqIHJvdXRlIGFkZCAtaG9zdCAxOTIuMTY4LjEwLjIgZGV2IHRhcDAKPiAg
ICAgICAgICAgICAgICAqIGJhc2ggLWMgZWNobyAxID4KPiAvcHJvYy9zeXMvbmV0L2lwdjQvY29u
Zi90YXAwL3Byb3h5X2FycAo+Cj4gYmVjYXVzZSBJIHJ1biB1bWwgbGludXggYXMgYSBub3JtYWwg
dXNlciBhbmQgSSBndWVzcyB0aGVzZSBjb21tYW5kcwo+IGZhaWwsIGJlY2F1c2Ugb2YgaW5zdWZm
aWNpZW50IHJpZ2h0czoKPiBiYXNoIC1jIGVjaG8gMSA+IC9wcm9jL3N5cy9uZXQvaXB2NC9pcF9m
b3J3YXJkCj4gYmFzaCAtYyBlY2hvIDEgPiAvcHJvYy9zeXMvbmV0L2lwdjQvY29uZi90YXAwL3By
b3h5X2FycAo+Cj4gQnV0IHRoaXMgZmFpbHVyZSBpcyBva2F5IGZvciBtZSwgYXMgZmlyZXdhbGxk
LCBzZXRzIGFib3ZlIG9wdGlvbnMKPiBjb3JyZWN0bHkgb24gbXkgaG9zdCBjb21wdXRlci4KPgo+
IFRoZSBwcm9ibGVtIEkgc2VlIGlzIHRoYXQgVU1MIGxpc3QgdHdvIHpvbWJpZSBwcm9jZXNzZXM6
Cj4gICAxMTc4MCByb290ICAgICAgIDIwICAgMCAgICAgMCAgICAgMCAgICAgMCBaICAwLjAgIDAu
MCAgMDowMC4wMCAxNTozNCDilIIgIOKUgiAgICAg4pSc4pSAIHVtbF9uZXQKPiAgIDExNjczIHJv
b3QgICAgICAgMjAgICAwICAgICAwICAgICAwICAgICAwIFogIDAuMCAgMC4wICAwOjAwLjAwIDE1
OjM0IOKUgiAg4pSCICAgICDilJzilIAgdW1sX25ldAo+Cj4gVU1MIHNlZW1zIHRvIG5ldmVyIHJl
YXAgdGhvc2UgdHdvIHByb2Nlc3NlcywgbGlrZWx5IGJlY2F1c2Ugb2YgZXJybm89MTAgZXhpdCBj
b2RlLgo+Cj4gYW55IGlkZWEgaG93IHRvIGZpeCB0aGlzPwoKSG1tLCBpdCB0cmllcyB0byByZWFw
IHRoZW0gdXNpbmcgd2FpdHBpZCgpLgpCdXQgaXQgc2VlbXMgdG8gZmFpbCB3aXRoIEVDSElMRC4K
CkNhbiB5b3UgYWRkIGEgZmV3IHByaW50cyB0byBjb21wYXJlIHRoZSBQSURzPwoKLS0gClRoYW5r
cywKLy9yaWNoYXJkCgotLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KRG9uJ3QgTGltaXQgWW91ciBCdXNp
bmVzcy4gUmVhY2ggZm9yIHRoZSBDbG91ZC4KR2lnZU5FVCdzIENsb3VkIFNvbHV0aW9ucyBwcm92
aWRlIHlvdSB3aXRoIHRoZSB0b29scyBhbmQgc3VwcG9ydCB0aGF0CnlvdSBuZWVkIHRvIG9mZmxv
YWQgeW91ciBJVCBuZWVkcyBhbmQgZm9jdXMgb24gZ3Jvd2luZyB5b3VyIGJ1c2luZXNzLgpDb25m
aWd1cmVkIEZvciBBbGwgQnVzaW5lc3Nlcy4gU3RhcnQgWW91ciBDbG91ZCBUb2RheS4KaHR0cHM6
Ly93d3cuZ2lnZW5ldGNsb3VkLmNvbS8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVXNlci1tb2RlLWxpbnV4LWRldmVsIG1haWxpbmcgbGlzdApVc2VyLW1v
ZGUtbGludXgtZGV2ZWxAbGlzdHMuc291cmNlZm9yZ2UubmV0Cmh0dHBzOi8vbGlzdHMuc291cmNl
Zm9yZ2UubmV0L2xpc3RzL2xpc3RpbmZvL3VzZXItbW9kZS1saW51eC1kZXZlbAo=

